from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.core.mail import send_mail
from .models import Product, ProductReview
from .forms import ProductReviewForm
from django.conf import settings
from django.http import HttpResponse
from .models import UserProfile, Address, Order
from .forms import UserProfileForm
from django.template.loader import render_to_string
from django.template.loader import get_template
from xhtml2pdf import pisa
from django.utils import timezone
from .models import HotDeal
from .models import NewsletterSubscriber
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from .forms import AddressForm
from .models import Address
from .models import Order



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
     Product, ProductReview, Notification,
    Order, Refund, Payment
)

User = get_user_model()

import qrcode
from io import BytesIO
import base64
from django.shortcuts import render, get_object_or_404
from .models import Order

@login_required
def qr_payment(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)

    # ✅ Create QR code data (dummy UPI string for now)
    upi_string = f"upi://pay?pa=merchant@upi&pn=MobileShop&am={order.total_amount}&cu=INR&tid={order.id}"

    # Generate QR code
    qr = qrcode.QRCode(version=1, box_size=10, border=4)
    qr.add_data(upi_string)
    qr.make(fit=True)
    img = qr.make_image(fill_color="black", back_color="white")

    # Convert image to base64 so we can render directly in HTML
    buffer = BytesIO()
    img.save(buffer, format="PNG")
    img_str = base64.b64encode(buffer.getvalue()).decode()

    qr_data_uri = f"data:image/png;base64,{img_str}"

    return render(request, 'shop/qr_payment.html', {
        'order': order,
        'qr_data_uri': qr_data_uri
    })

@login_required
def payment_success_dummy(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)

    # Mark order as paid (dummy)
    order.is_paid = True
    order.payment_status = 'paid'
    order.status = 'confirmed'
    order.save()

    # Optional: notification
    Notification.objects.create(
        user=request.user,
        message=f"Payment successful for Order #{order.id}"
    )

    messages.success(request, "Payment successful ✅")
    return redirect('order_success', order_id=order.id)

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

def product_detail(request, id):  # <-- 'id' must match your urls.py
    product = get_object_or_404(Product, id=id)
    context = {
        'product': product
    }
    return render(request, 'product_detail.html', context)


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


@login_required
def add_address(request):
    if request.method == 'POST':
        form = AddressForm(request.POST)
        if form.is_valid():
            address = form.save(commit=False)
            address.user = request.user
            # If user marked as default, reset others
            if address.is_default:
                Address.objects.filter(user=request.user, is_default=True).update(is_default=False)
            address.save()
            return redirect('my_address')  # back to addresses page
    else:
        form = AddressForm()
    return render(request, 'add_address.html', {'form': form})

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
def category_products(request, slug):
    category = get_object_or_404(ProductCategory, slug=slug)
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

    category_slug = request.GET.get('category')
    search_query = request.GET.get('q')

    if category_slug:
        products = products.filter(category__slug=category_slug)

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

@login_required
def edit_profile(request):
    profile = UserProfile.objects.get(user=request.user)

    if request.method == "POST":
        form = UserProfileForm(request.POST, request.FILES, instance=profile)
        if form.is_valid():
            form.save()
            return redirect('my_profile')
    else:
        form = UserProfileForm(instance=profile)

    return render(request, 'edit_profile.html', {
        'form': form,
        'profile': profile
    })



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
# views.py
def order_status(request):
    orders = Order.objects.filter(user=request.user).prefetch_related('items__product')
    return render(request, 'order_status.html', {'orders': orders})


# ---------- INVOICE A4 ----------

def invoice_a4(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)
    items = order.items.all()  # Make sure you have a related_name="items" in OrderItem model

    # Calculate total for each item
    for item in items:
        item.total_price = item.price * item.quantity


    # Grand total (you can use order.total_amount if already stored)
    grand_total = order.total_amount

    return render(request, 'invoice_a4.html', {
        'order': order,
        'items': items,
        'grand': {'total': grand_total}
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

    total = 0
    for item in cart_items:
        if item.product.is_hot_deal:
            total += item.product.price * item.quantity
        else:
            total += item.product.mrp * item.quantity

    if request.method == 'POST':

        order = Order.objects.create(
            user=request.user,
            first_name=request.POST.get('first_name'),
            last_name=request.POST.get('last_name'),
            email=request.POST.get('email'),
            phone=request.POST.get('phone'),
            address=request.POST.get('address'),
            city=request.POST.get('city'),
            country=request.POST.get('country'),
            zip_code=request.POST.get('zip_code'),

            total_amount=total,
            payment_method='DUMMY',
            payment_status='paid',   # ✅ dummy paid
            is_paid=True
        )

        for item in cart_items:
            price = item.product.price if item.product.is_hot_deal else item.product.mrp

            OrderItem.objects.create(
                order=order,
                product=item.product,
                quantity=item.quantity,
                price=price
            )

        cart_items.delete()

        Notification.objects.create(
            user=request.user,
            message=f"Order #{order.id} placed successfully"
        )

        return redirect('order_success')

    return render(request, 'checkout.html', {
        'cart_items': cart_items,
        'total': total
    })


@login_required
def cart(request):
    cart_items = Cart.objects.filter(user=request.user)

    subtotal = 0
    discount_total = 0
    total = 0

    for item in cart_items:
        product = item.product
        qty = item.quantity

        # Subtotal always MRP
        subtotal += product.mrp * qty

        if product.is_hot_deal:
            # 🔥 hot deal discount
            discount = (product.mrp - product.price) * qty
            discount_total += discount

            item.unit_price = product.price
            item.total_price = product.price * qty
            total += product.price * qty
        else:
            # ❌ no discount
            item.unit_price = product.mrp
            item.total_price = product.mrp * qty
            total += product.mrp * qty

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

    qty = int(request.POST.get('quantity', 1))  # ⬅️ qty read

    cart_item, created = Cart.objects.get_or_create(
        user=request.user,
        product=product
    )

    if created:
        cart_item.quantity = qty
    else:
        cart_item.quantity += qty

    cart_item.save()

    Notification.objects.create(
        user=request.user,
        message=f"{product.product_name} added to cart"
    )

    return redirect('cart')   # ⬅️ store nai, cart



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
    if request.method != 'POST':
        return redirect('checkout')

    cart_items = Cart.objects.filter(user=request.user)
    if not cart_items.exists():
        messages.error(request, "Cart is empty")
        return redirect('checkout')

    payment_method = request.POST.get('payment_method')
    if not payment_method:
        messages.error(request, "Please select a payment method")
        return redirect('checkout')

    # Create the order
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

    # Add items and calculate total
    total = 0
    for item in cart_items:
        OrderItem.objects.create(
            order=order,
            product=item.product,
            quantity=item.quantity,
            price=item.product.price
        )
        total += item.product.price * item.quantity

    order.total_amount = total
    order.save()

    # Create notification
    Notification.objects.create(
        user=request.user,
        message="Your order has been placed successfully"
    )

    # Delete cart items
    cart_items.delete()

    # --- Payment flow ---
    if payment_method == "Cash On Delivery":
        return redirect('order_success', order_id=order.id)

    elif payment_method == "UPI":
        return redirect('qr_payment', order_id=order.id)

    else:
        # future: other payment methods
        return redirect('order_success', order_id=order.id)

@login_required
def order_success(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)

    items = order.items.all()   # ✅ CORRECT
    for item in items:
        item.line_total = item.quantity * item.price

    return render(request, "order_success.html", {
        "order": order,
        "items": items
    })

def orders(request):
    user_orders = Order.objects.filter(user=request.user)  # get orders for logged-in user
    return render(request, 'orders.html', {'orders': user_orders})

def my_orders(request):
    user_orders = Order.objects.filter(user=request.user)  # only current user's orders
    return render(request, 'my_orders.html', {'orders': user_orders})

def qr_payment(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)
    return render(request, 'qr_payment.html', {'order': order})


@login_required
def return_order(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)

    # sirf delivered order return thai
    if order.status != 'delivered':
        return redirect('my_orders')

    if request.method == 'POST':
        OrderReturn.objects.create(
            order=order,
            reason=request.POST.get('reason')
        )

        order.status = 'returned'
        order.save()

        Notification.objects.create(
            user=request.user,
            message=f"Return requested for Order #{order.id}"
        )

        return redirect('my_orders')

    return render(request, 'return_order.html', {
        'order': order
    })


@login_required
def add_review(request, product_id):
    product = get_object_or_404(Product, id=product_id)

    # Check if user already reviewed this product
    existing_review = ProductReview.objects.filter(product=product, user=request.user).first()

    if request.method == "POST":
        form = ProductReviewForm(request.POST, instance=existing_review)
        if form.is_valid():
            review = form.save(commit=False)
            review.user = request.user
            review.product = product
            review.save()
            return redirect('product_detail', id=product.id)

    else:
        form = ProductReviewForm(instance=existing_review)

    return render(request, 'add_review.html', {'form': form, 'product': product})

@login_required
def delete_review(request, review_id):
    review = get_object_or_404(ProductReview, id=review_id, user=request.user)
    product_id = review.product.id
    review.delete()

    messages.success(request, "Review deleted")
    return redirect('product_detail', id=product_id)

@login_required
def notifications(request):
    data = Notification.objects.filter(user=request.user).order_by('-created_at')
    return render(request, 'notifications.html', {'notifications': data})


@login_required
def mark_notification_read(request, id):
    note = get_object_or_404(Notification, id=id, user=request.user)
    note.is_read = True
    note.save()
    return redirect('notifications')

@login_required
def refund_request(request, order_id):
    order = get_object_or_404(Order, id=order_id, user=request.user)

    if request.method == "POST":
        reason = request.POST.get('reason')

        Refund.objects.create(
            order=order,
            amount=order.total_amount,
            reason=reason
        )

        order.status = 'returned'
        order.save()

        Notification.objects.create(
            user=request.user,
            message=f"Refund requested for Order #{order.id}"
        )

        messages.success(request, "Refund request submitted")
        return redirect('my_orders')

@csrf_exempt
def payment_success(request):
    payment_id = request.POST.get('razorpay_payment_id')
    order_id = request.POST.get('order_id')

    payment = Payment.objects.get(order_id=order_id)
    payment.razorpay_payment_id = payment_id
    payment.status = 'paid'
    payment.paid_at = timezone.now()
    payment.save()

    order = payment.order
    order.is_paid = True
    order.payment_status = 'paid'
    order.status = 'confirmed'
    order.save()

    Notification.objects.create(
        user=order.user,
        message=f"Payment successful for Order #{order.id}"
    )

    return redirect('order_success', order_id=order.id)

@csrf_exempt
def payment_failed(request):
    messages.error(request, "Payment failed")
    return redirect('checkout')

@login_required
def update_order_status(request, order_id):
    order = get_object_or_404(Order, id=order_id)

    if request.method == "POST":
        status = request.POST.get('status')
        order.status = status
        order.save()

        Notification.objects.create(
            user=order.user,
            message=f"Order #{order.id} status updated to {status}"
        )

        messages.success(request, "Order status updated")
        return redirect('order_list')
    
@login_required
def unread_notifications(request):
    notes = Notification.objects.filter(
        user=request.user,
        is_read=False
    ).values('id', 'message')

    return JsonResponse(list(notes), safe=False)


@login_required
def my_account(request):
    user = request.user
    profile = UserProfile.objects.filter(user=user).first()  # get phone or extra info
    addresses = Address.objects.filter(user=user)
    orders = Order.objects.filter(user=user).order_by('-created_at')

    return render(request, 'my_account.html', {
        'user': user,
        'profile': profile,
        'addresses': addresses,
        'orders': orders,
    })


def about(request):
    return render(request, 'about.html')

def privacy_policy(request):
    return render(request, 'privacy_policy.html')

def return_order(request):
    return render(request, 'return_order.html')

def terms_conditions(request):
    return render(request, 'terms_conditions.html')