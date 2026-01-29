from django.db import models
from django.conf import settings
from django.contrib.auth.models import User


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

    def __str__(self):
        return self.category_name


# ------------------
# PRODUCT BRAND
# ------------------
class ProductBrand(models.Model):
    brand_name = models.CharField(max_length=100)

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
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    email = models.EmailField()
    address = models.TextField()
    city = models.CharField(max_length=50)
    country = models.CharField(max_length=50)
    zip_code = models.CharField(max_length=20)
    phone = models.CharField(max_length=20)
    payment_method = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)


class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE, related_name='items')
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveIntegerField()
    price = models.FloatField()

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone = models.CharField(max_length=15)
    address = models.TextField(blank=True)
    city = models.CharField(max_length=50)
    state = models.CharField(max_length=50)
    pincode = models.CharField(max_length=10)
    profile_image = models.ImageField(upload_to='profiles/', default='default.png')

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