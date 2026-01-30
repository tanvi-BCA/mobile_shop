import razorpay
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.core.mail import send_mail
from django.conf import settings
from django.http import HttpResponse
from .models import UserProfile
from .forms import UserProfileForm
from django.template.loader import render_to_string
from django.template.loader import get_template
from xhtml2pdf import pisa
from django.utils import timezone
from .models import HotDeal
from .models import NewsletterSubscriber

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


def hot_deal_products(request, deal_id):
    deal = get_object_or_404(
        HotDeal,
        id=deal_id,
        is_active=True,
        end_time__gt=timezone.now()
    )
    products = deal.products.all()

    return render(request, 'hot_deal_products.html', {
        'deal': deal,
        'products': products
    })

def product_detail(request, id):
    product = get_object_or_404(Product, id=id)
    return render(request, 'product_detail.html', {
        'product': product
    })

def register_view(request):
    if request.method == "POST":
        form = RegisterForm(request.POST)

        if form.is_valid():
            user = form.save()

            send_mail(
                "Welcome to Mobile Shop",
                "Registration successful. Please login.",
                settings.DEFAULT_FROM_EMAIL,
                [user.email],
                fail_silently=False
            )

            messages.success(request, "Registration successful. Please login.")
            return redirect('login')

    else:
        form = RegisterForm()

    return render(request, 'register.html', {'form': form})


# ---------- HOME / DASHBOARD ----------

def index(request):
    categories = ProductCategory.objects.all()
    products = Product.objects.all()

    deal = HotDeal.objects.filter(
        is_active=True,
        end_time__gt=timezone.now()
    ).first()

    return render(request, 'index.html', {
        'categories': categories,
        'products': products,
        'deal': deal,   # 🔥 THIS IS THE KEY
    })


def category_products(request, id):
    category = get_object_or_404(ProductCategory, id=id)
    products = Product.objects.filter(category=category)
    categories = ProductCategory.objects.all()

    return render(request, 'index.html', {
        'categories': categories,
        'products': products,
        'selected_category': category
    })


def store(request):
    products = Product.objects.all()
    categories = ProductCategory.objects.all()

    category_id = request.GET.get('category')
    search_query = request.GET.get('q')

    if category_id:
        products = products.filter(category_id=category_id)

    if search_query:
        products = products.filter(product_name__icontains=search_query)

    context = {
        'products': products,
        'categories': categories,
    }
    return render(request, 'store.html', context)



def newsletter_subscribe(request):
    if request.method == "POST":
        email = request.POST.get("email")

        if not email:
            messages.error(request, "Email is required")
            return redirect(request.META.get('HTTP_REFERER'))

        obj, created = NewsletterSubscriber.objects.get_or_create(email=email)

        if created:
            messages.success(request, "Subscribed successfully 🎉")
        else:
            messages.warning(request, "Email already subscribed")

        return redirect(request.META.get('HTTP_REFERER'))


def home(request):
    deal = HotDeal.objects.filter(
        is_active=True,
        end_time__gt=timezone.now()
    ).first()

    return render(request, 'index.html', {
        'deal': deal
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
@login_required
def my_profile(request):
    profile, created = UserProfile.objects.get_or_create(user=request.user)

    return render(request, 'my_profile.html', {'profile': profile})



def edit_profile(request):
    profile = UserProfile.objects.get(user=request.user)

    if request.method == 'POST':
        form = UserProfileForm(request.POST, request.FILES, instance=profile)
        if form.is_valid():
            form.save()
            return redirect('my_profile')
    else:
        form = UserProfileForm(instance=profile)

    return render(request, 'edit_profile.html', {'form': form})


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

    items = order.items.all()

    grand_total = 0
    for item in items:
        grand_total += item.quantity * item.price

    return render(request, 'invoice_a4.html', {
        'order': order,
        'items': items,
        'grand_total': grand_total
    })


@login_required
def download_invoice_pdf(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)
    items = order.items.all()

    template = get_template('invoice_pdf.html')
    html = template.render({
        'order': order,
        'items': items
    })

    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="invoice_{order.id}.pdf"'

    pisa.CreatePDF(html, dest=response)
    return response

# ---------- PRODUCT LIST ----------

def product_list(request):
    return HttpResponse("Product list working")


# ---------- CHECKOUT ----------
@login_required
def checkout(request):
    cart_items = Cart.objects.filter(user=request.user)
    if not cart_items.exists():
        return redirect('cart')

    total = sum(item.product.price * item.quantity for item in cart_items)

    if request.method == 'POST':
        order = Order.objects.create(
            user=request.user,
            first_name=request.POST['first_name'],
            last_name=request.POST['last_name'],
            email=request.POST['email'],
            address=request.POST['address'],
            city=request.POST['city'],
            country=request.POST['country'],
            zip_code=request.POST['zip_code'],
            phone=request.POST['phone'],
            payment_method=request.POST['payment_method'],
            total_amount=total
        )

        for item in cart_items:
            OrderItem.objects.create(
                order=order,
                product=item.product,
                quantity=item.quantity,
                price=item.product.price
            )

        cart_items.delete()
        return redirect('order_success')

    return render(request, 'checkout.html', {
        'cart_items': cart_items,
        'total': total
    })

@login_required
def my_orders(request):
    orders = Order.objects.filter(user=request.user).order_by('-created_at')
    return render(request, 'my_orders.html', {'orders': orders})

@login_required
def return_order(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)

    if order.status == 'delivered':
        order.status = 'returned'
        order.save()

    return redirect('my_orders')


@login_required
def cart(request):
    cart_items = Cart.objects.filter(user=request.user)

    subtotal = 0
    discount_total = 0

    for item in cart_items:
        product = item.product

        original_price = product.mrp if product.mrp else product.price

        if product.discount_percent() > 0:
            discounted_price = product.discounted_price()
            discount_total += (original_price - discounted_price) * item.quantity
            price = discounted_price
        else:
            price = original_price

        item.unit_price = price
        item.total_price = price * item.quantity
        subtotal += item.total_price

    total = subtotal

    context = {
        'cart_items': cart_items,
        'subtotal': subtotal,
        'discount_total': discount_total,
        'total': total
    }
    return render(request, 'cart.html', context)

@login_required
def add_to_cart(request, id):
    product = get_object_or_404(Product, id=id)

    # check already cart ma che ke nahi
    cart_item, created = Cart.objects.get_or_create(
        user=request.user,
        product=product
    )

    if not created:
        cart_item.quantity += 1
    else:
        cart_item.quantity = 1

    cart_item.save()
    return redirect('cart')


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

        cart_items = Cart.objects.filter(user=request.user)
        if not cart_items.exists():
            messages.error(request, "Cart is empty")
            return redirect('checkout')

        payment_method = request.POST.get('payment_method')

        order = Order.objects.create(
            user=request.user,
            first_name=request.POST.get('first_name'),
            last_name=request.POST.get('last_name'),
            email=request.POST.get('email'),
            address=request.POST.get('address'),
            city=request.POST.get('city'),
            country=request.POST.get('country'),
            zip_code=request.POST.get('zip_code'),
            phone=request.POST.get('phone'),
            payment_method=payment_method,
            is_paid=False
        )

        total = 0
        for item in cart_items:
            OrderItem.objects.create(
                order=order,
                product=item.product,
                quantity=item.quantity,
                price=item.product.price
            )
            total += item.product.price * item.quantity

        # ✅ COD FLOW
        if payment_method == "cod":
            cart_items.delete()
            order.is_paid = False
            order.save()
            return redirect('order_success', order_id=order.id)

        # ✅ UPI FLOW (Razorpay)
        if payment_method == "upi":
            client = razorpay.Client(
                auth=(settings.RAZORPAY_KEY_ID, settings.RAZORPAY_KEY_SECRET)
            )

            razorpay_order = client.order.create({
                "amount": int(total * 100),  # paise
                "currency": "INR",
                "payment_capture": 1
            })

            order.razorpay_order_id = razorpay_order['id']
            order.total_amount = total
            order.save()

            return redirect('razorpay_payment', order_id=order.id)

    return redirect('checkout')

def payment_failed(request):
    return render(request, 'payment_failed.html')

def order_success(request, order_id):
    order = get_object_or_404(Order, id=order_id)
    return render(request, 'order_success.html', {'order': order})

def about(request):
    return render(request, 'about.html')
