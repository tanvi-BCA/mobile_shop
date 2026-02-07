import razorpay
from django.db import models
from django.conf import settings
from django.contrib.auth.models import User
from django.shortcuts import render
from django.utils.text import slugify


# ------------------
# ROLE
# ------------------
class Role(models.Model):
    role_name = models.CharField(max_length=50)
    description = models.TextField(null=True, blank=True)
    can_manage_orders = models.BooleanField(default=False)
    can_manage_products = models.BooleanField(default=False)

    def __str__(self):
        return self.role_name


# ------------------
# PRODUCT CATEGORY
# ------------------
class ProductCategory(models.Model):
    category_name = models.CharField(max_length=100)
    slug = models.SlugField(unique=True, blank=True)
    description = models.TextField(blank=True)

    def save(self, *args, **kwargs):
        if not self.slug:
            self.slug = slugify(self.category_name)
        super().save(*args, **kwargs)

    def __str__(self):
        return self.category_name

# ------------------
# PRODUCT BRAND
# ------------------
class ProductBrand(models.Model):
    brand_name = models.CharField(max_length=100)
    slug = models.SlugField(unique=True, blank=True)

    def __str__(self):
        return self.brand_name


# ------------------
# PRODUCT
# ------------------
class Product(models.Model):
    product_name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)

    mrp = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        blank=True,
        null=True
    )

    price = models.DecimalField(max_digits=10, decimal_places=2)
    stock = models.IntegerField()

    is_hot_deal = models.BooleanField(default=False)

    category = models.ForeignKey(
        ProductCategory,
        on_delete=models.SET_NULL,
        null=True,
        blank=True
    )

    brand = models.ForeignKey(
        ProductBrand,
        on_delete=models.SET_NULL,
        null=True,
        blank=True
    )

    image = models.ImageField(upload_to='products/', blank=True, null=True)

    # % OFF calculate
    def discount_percent(self):
        if self.mrp and self.mrp > self.price:
            return int(((self.mrp - self.price) / self.mrp) * 100)
        return 0

    # discounted price
    def discounted_price(self):
        if self.mrp and self.discount_percent() > 0:
            return self.mrp - (self.mrp * self.discount_percent() / 100)
        return self.price

    def __str__(self):
        return self.product_name

class NewsletterSubscriber(models.Model):
    email = models.EmailField(unique=True)
    subscribed_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.email
    


# ------------------
# CART
# ------------------
class Cart(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField(default=1)
    added_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.user} - {self.product.product_name}"


# ------------------
# WISHLIST
# ------------------
class Wishlist(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)


# ------------------
# ORDER
# ------------------
class Order(models.Model):

    STATUS_CHOICES = [
        ('pending', 'Pending'),
        ('confirmed', 'Confirmed'),
        ('shipped', 'Shipped'),
        ('delivered', 'Delivered'),
        ('cancelled', 'Cancelled'),
        ('returned', 'Returned'),
    ]

    PAYMENT_STATUS = [
        ('pending', 'Pending'),
        ('paid', 'Paid'),
        ('failed', 'Failed'),
        ('refunded', 'Refunded'),
    ]

    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    is_paid = models.BooleanField(default=False)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    email = models.EmailField()
    phone = models.CharField(max_length=20)

    address = models.TextField()
    city = models.CharField(max_length=50)
    country = models.CharField(max_length=50)
    zip_code = models.CharField(max_length=20)

    total_amount = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        default=0   # ⭐ VERY IMPORTANT
    )

    payment_method = models.CharField(max_length=50)
    payment_status = models.CharField(
        max_length=20,
        choices=PAYMENT_STATUS,
        default='pending'
    )

    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='pending'
    )

    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Order #{self.id} - {self.user}"


class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='items')
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()
    price = models.DecimalField(max_digits=10, decimal_places=2)


class OrderReturn(models.Model):
    order = models.OneToOneField(Order, on_delete=models.CASCADE)
    reason = models.TextField()
    requested_at = models.DateTimeField(auto_now_add=True)
    approved = models.BooleanField(default=False)

    def __str__(self):
        return f"Return Order #{self.order.id}"

class OrderStatusHistory(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    status = models.CharField(max_length=20)
    changed_at = models.DateTimeField(auto_now_add=True)


class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone = models.CharField(max_length=15)
    address = models.TextField(blank=True)
    city = models.CharField(max_length=50)
    state = models.CharField(max_length=50)
    pincode = models.CharField(max_length=10)
    profile_image = models.ImageField(
    upload_to='profile/',
    blank=True,
    null=True
)


    def __str__(self):
        return self.user.username
    
class HotDeal(models.Model):
    title = models.CharField(max_length=100)
    subtitle = models.CharField(max_length=200)
    end_time = models.DateTimeField()
    products = models.ManyToManyField(Product, blank=True)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return self.title
    
class Payment(models.Model):
    order = models.OneToOneField(Order, on_delete=models.CASCADE)
    razorpay_order_id = models.CharField(max_length=100, blank=True, null=True)
    razorpay_payment_id = models.CharField(max_length=100, blank=True, null=True)
    razorpay_signature = models.CharField(max_length=255, blank=True, null=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(
        max_length=20,
        choices=[
            ('created', 'Created'),
            ('paid', 'Paid'),
            ('failed', 'Failed'),
            ('refunded', 'Refunded'),
        ],
        default='created'
    )
    paid_at = models.DateTimeField(blank=True, null=True)

    def __str__(self):
        return f"Payment for Order #{self.order.id}"

class ProductReview(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE, related_name='reviews')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    rating = models.PositiveIntegerField(default=5)
    comment = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('product', 'user')

    def __str__(self):
        return f"{self.product.product_name} - {self.rating}⭐"

class Notification(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    message = models.CharField(max_length=255)
    is_read = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.message

class Address(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='addresses')
    full_name = models.CharField(max_length=100)
    phone = models.CharField(max_length=15)
    address = models.TextField()
    city = models.CharField(max_length=50)
    state = models.CharField(max_length=50)
    country = models.CharField(max_length=50)
    pincode = models.CharField(max_length=10)
    is_default = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.user.username} - {self.city}"

class Refund(models.Model):
    order = models.OneToOneField(Order, on_delete=models.CASCADE)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    reason = models.TextField()
    status = models.CharField(
        max_length=20,
        choices=[
            ('initiated', 'Initiated'),
            ('completed', 'Completed'),
        ],
        default='initiated'
    )
    refunded_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"Refund Order #{self.order.id}"

class Shipment(models.Model):
    order = models.OneToOneField(Order, on_delete=models.CASCADE)
    courier_name = models.CharField(max_length=100)
    tracking_number = models.CharField(max_length=100, blank=True, null=True)
    status = models.CharField(
        max_length=20,
        choices=[
            ('pending', 'Pending'),
            ('shipped', 'Shipped'),
            ('delivered', 'Delivered'),
        ],
        default='pending'
    )
    shipped_at = models.DateTimeField(null=True, blank=True)
    delivered_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"Shipment Order #{self.order.id}"
