from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.core.mail import send_mail
from django.conf import settings
from django.http import HttpResponse

from django.contrib.auth import get_user_model
from .forms import CustomLoginForm, RegisterForm
from .models import (
    Product,
    ProductCategory,
    ProductBrand,
    Cart,
    Wishlist,
    Order,
    OrderItem,
)

User = get_user_model()


def admin_login(request):
    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")

        user = authenticate(request, username=username, password=password)

        if user is not None:
            if user.is_staff and user.is_superuser:
                login(request, user)
                messages.success(request, "Welcome Admin")
                return redirect('/admin/')
            else:
                messages.error(request, "You are not authorized as admin")
        else:
            messages.error(request, "Invalid username or password")

    return render(request, 'admin_login.html')

def admin_logout(request):
    logout(request)
    return redirect('admin_login')


def dashboard(request):
    return render(request, 'dashboard.html')

#---------Email--------------


def register_view(request):
    if request.method == "POST":
        form = RegisterForm(request.POST)

        if form.is_valid():
            user = form.save()   # 👈 USER CREATE

            # 📧 EMAIL SEND — AA J JAGYA
            send_mail(
                "Welcome to Mobile Shop",
                "Registration successful. Please login.",
                settings.DEFAULT_FROM_EMAIL,
                [user.email],     # 👈 USER NO EMAIL
                fail_silently=False
            )

            messages.success(request, "Registration successful. Please login.")
            return redirect('login')

        else:
            messages.error(request, "Username or Email already exists")

    else:
        form = RegisterForm()

    return render(request, 'register.html', {'form': form})

# ---------- HOME / DASHBOARD ----------

def index(request):   # or index / store je function che
    categories = ProductCategory.objects.all()
    products = Product.objects.all()

    return render(request, 'index.html', {
        'categories': categories,
        'products': products
    })


def category_products(request, id):
    category = get_object_or_404(ProductCategory, id=id)
    products = Product.objects.filter(category=category)

    return render(request, 'category_products.html', {
        'category': category,
        'products': products
    })

def store(request):
    categories = ProductCategory.objects.all()
    products = Product.objects.all()

    category_id = request.GET.get('category')

    if category_id:
        products = products.filter(category_id=category_id)

    return render(request, 'store.html', {
        'categories': categories,
        'products': products
    })



def contact(request):
    return render(request, 'contact.html')


# ---------- LOGIN ----------
def user_login(request):
    form = CustomLoginForm(data=request.POST or None)

    if request.method == "POST":
        if form.is_valid():
            user = form.get_user()
            login(request, user)

            # ✅ POPUP MESSAGE
            messages.success(request, "User is successfully logged in")

            return redirect('index')  # or '/admin/'

    return render(request, 'login.html', {'form': form})


# ---------- REGISTER ----------

from django.contrib import messages

def register_view(request):
    if request.method == "POST":
        form = RegisterForm(request.POST)

        if form.is_valid():
            form.save()
            messages.success(request, "Registration successful. Please login.")
            return redirect('login')
        else:
           pass
    else:
        form = RegisterForm()

    return render(request, 'register.html', {'form': form})


# ---------- LOGOUT ----------
@login_required
def logout_view(request):
    logout(request)  
    return redirect('index') 

# ---------- MY PROFILE ----------
@login_required(login_url='login')
def my_profile(request):
    return render(request, 'my_profile.html')

# ---------- MY ADDRESS ----------
@login_required(login_url='login')
def my_address(request):
    return render(request, 'my_address.html')

# ---------- ORDER LIST ----------
@login_required
def order_list(request):
    orders = Order.objects.filter(user=request.user).order_by('-created_at')

    # Calculate total for each order
    for order in orders:
        order.total = sum(item.price * item.quantity for item in order.items.all())

    return render(request, 'order_list.html', {'orders': orders})


# ---------- ORDER STATUS ----------
@login_required
def order_status(request):
    # Fetch all orders of logged-in user
    orders = Order.objects.filter(user=request.user).order_by('-created_at')
    return render(request, 'order_status.html', {'orders': orders})

# ---------- INVOICE A4 ----------

@login_required
def invoice_a4(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)

    return render(request, 'invoice_a4.html', {
        'order': order,
        'items': order.items.all(),   # related_name='items'
    })

# ---------- PRODUCT LIST ----------

def product_list(request):
    return HttpResponse("Product list working")


# ---------- CHECKOUT ----------
@login_required
def checkout(request):
    cart_items = Cart.objects.filter(user=request.user)  # fetch logged-in user's cart
    
    for item in cart_items:
        item.total_price = item.product.price * item.quantity  # add total_price attribute

    total = sum(item.total_price for item in cart_items)

    context = {
        'cart_items': cart_items,
        'total': total,
    }
    return render(request, 'checkout.html', context)



# ---------- CART ----------
@login_required
def cart(request):
    cart_items = Cart.objects.filter(user=request.user)
    
    # Calculate total_price for each item
    for item in cart_items:
        item.total_price = item.product.price * item.quantity

    # Calculate subtotal
    subtotal = sum(item.total_price for item in cart_items)
    total = subtotal  # For now, can add shipping & tax later

    context = {
        'cart_items': cart_items,
        'subtotal': subtotal,
        'total': total
    }
    return render(request, 'cart.html', context)

@login_required
def add_to_cart(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    cart_item, created = Cart.objects.get_or_create(user=request.user, product=product)
    if not created:
        cart_item.quantity += 1
        cart_item.save()
    return redirect('store')

@login_required
def decrease_quantity(request, product_id):
    cart_item = Cart.objects.filter(
        user=request.user,
        product_id=product_id
    ).first()

    if cart_item:
        if cart_item.quantity > 1:
            cart_item.quantity -= 1
            cart_item.save()
        else:
            cart_item.delete()

    return redirect('cart')

@login_required
def remove_from_cart(request, product_id):
    cart_item = Cart.objects.filter(user=request.user, product_id=product_id).first()
    if cart_item:
        cart_item.delete()
    return redirect('cart')

@login_required
def increase_quantity(request, product_id):
    cart_item = Cart.objects.filter(
        user=request.user,
        product_id=product_id
    ).first()

    if not cart_item:
        return redirect('cart')

    # ❌ quantity limit
    if cart_item.quantity >= settings.MAX_CART_QTY_PER_ITEM:
        messages.error(
            request,
            f"Maximum {settings.MAX_CART_QTY_PER_ITEM} quantity allowed per product"
        )
        return redirect('cart')

    # ❌ total amount limit
    current_total = sum(
        item.product.price * item.quantity
        for item in Cart.objects.filter(user=request.user)
    )

    if current_total + cart_item.product.price > settings.MAX_CART_TOTAL_AMOUNT:
        messages.error(
            request,
            "Cart total limit exceeded. Please checkout first."
        )
        return redirect('cart')

    # ✅ allowed
    cart_item.quantity += 1
    cart_item.save()

    return redirect('cart')



# ---------- WISHLIST ----------
@login_required
def wishlist(request):
    wishlist_items = Wishlist.objects.filter(user=request.user)
    return render(request, 'wishlist.html', {'wishlist_items': wishlist_items})

@login_required
def add_to_wishlist(request, product_id):
    product = get_object_or_404(Product, id=product_id)
    Wishlist.objects.get_or_create(user=request.user, product=product)
    return redirect('store')

@login_required
def remove_from_wishlist(request, product_id):
    wishlist_item = Wishlist.objects.filter(user=request.user, product_id=product_id).first()
    if wishlist_item:
        wishlist_item.delete()
    return redirect('wishlist')

@login_required
def move_wishlist_to_cart(request, product_id):
    # Remove from wishlist and add to cart
    wishlist_item = Wishlist.objects.filter(user=request.user, product_id=product_id).first()
    if wishlist_item:
        wishlist_item.delete()
    product = get_object_or_404(Product, id=product_id)
    cart_item, created = Cart.objects.get_or_create(user=request.user, product=product)
    if not created:
        cart_item.quantity += 1
        cart_item.save()
    return redirect('wishlist')




@login_required
def place_order(request):
    if request.method == 'POST':
        # Check if terms accepted
        if not request.POST.get('terms'):
            messages.error(request, "Accept terms to place order")
            return redirect('checkout')

        # Get billing info
        first_name = request.POST.get('first_name')
        last_name = request.POST.get('last_name')
        email = request.POST.get('email')
        address = request.POST.get('address')
        city = request.POST.get('city')
        country = request.POST.get('country')
        zip_code = request.POST.get('zip_code')
        phone = request.POST.get('phone')

        # Get shipping info (if empty, use billing)
        shipping_address = request.POST.get('shipping_address') or address
        shipping_city = request.POST.get('shipping_city') or city
        shipping_country = request.POST.get('shipping_country') or country
        shipping_zip = request.POST.get('shipping_zip') or zip_code
        shipping_phone = request.POST.get('shipping_phone') or phone

        # Payment method
        payment_method = request.POST.get('payment_method')

        # Get cart items
        cart_items = Cart.objects.filter(user=request.user)
        if not cart_items.exists():
            messages.error(request, "Cart is empty")
            return redirect('checkout')

        # Create order
        order = Order.objects.create(
            user=request.user,
            first_name=first_name,
            last_name=last_name,
            email=email,
            address=address,
            city=city,
            country=country,
            zip_code=zip_code,
            phone=phone,
            payment_method=payment_method,
        )

        # Add order items
        for item in cart_items:
            OrderItem.objects.create(
                order=order,
                product=item.product,
                quantity=item.quantity,
                price=item.product.price
            )

        # Clear cart
        cart_items.delete()

        # Redirect to success page with order ID
        return redirect('order_success', order_id=order.id)

    return redirect('invoice_a4', order_id=order.id)




def order_success(request, order_id):
    order = get_object_or_404(Order, id=order_id)
    return render(request, 'order_success.html', {'order': order})

