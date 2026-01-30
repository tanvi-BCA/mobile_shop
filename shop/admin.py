from django.contrib import admin
from .models import Product, ProductCategory, ProductBrand, Cart, Wishlist, Order, OrderItem
from django.contrib.auth import get_user_model
from django.contrib.admin import AdminSite
from django.contrib.auth.admin import UserAdmin as DefaultUserAdmin
from .models import UserProfile
from .models import HotDeal
from .models import NewsletterSubscriber  
from django.core.mail import send_mail
from django.conf import settings

User = get_user_model()


admin.site.site_header = "Mobile Shop Admin"
admin.site.site_title = "Mobile Shop Admin Portal"
admin.site.index_title = "Dashboard"

# ----------------------
# User admin (unregister & register custom)
# ----------------------
admin.site.unregister(User)

@admin.register(User)
class CustomUserAdmin(DefaultUserAdmin):
    list_display = ('username', 'email', 'first_name', 'last_name', 'is_staff')

# ----------------------
# Custom AdminSite (optional, global CSS)
# ----------------------
class MyAdminSite(AdminSite):
    site_header = "Mobile Shop Admin"
    site_title = "Mobile Shop"
    index_title = "Dashboard"


admin_site = MyAdminSite(name='myadmin')

# ----------------------
# ModelAdmin definitions
# ----------------------
class ProductAdmin(admin.ModelAdmin):
    list_display = ('product_name', 'category', 'brand', 'price', 'stock')
   

class ProductCategoryAdmin(admin.ModelAdmin):
    list_display = ('category_name',)
    

class ProductBrandAdmin(admin.ModelAdmin):
    list_display = ('brand_name',)
    
class CartAdmin(admin.ModelAdmin):
    list_display = ('user', 'product', 'quantity')

class WishlistAdmin(admin.ModelAdmin):
    list_display = ('user', 'product')

class OrderAdmin(admin.ModelAdmin):
    list_display = ('user', 'first_name', 'last_name', 'email', 'created_at')

class OrderItemAdmin(admin.ModelAdmin):
    list_display = ('order', 'product', 'quantity', 'price')

@admin.register(HotDeal)
class HotDealAdmin(admin.ModelAdmin):
    filter_horizontal = ('products',)

@admin.register(NewsletterSubscriber)
class NewsletterSubscriberAdmin(admin.ModelAdmin):
    actions = ['test_action']

    def test_action(self, request, queryset):
        self.message_user(request, "TEST ACTION WORKING")

    test_action.short_description = "TEST ACTION"
    
# ----------------------
# Register all other models (once each!)
# ----------------------
admin.site.register(Product, ProductAdmin)
admin.site.register(ProductCategory, ProductCategoryAdmin)
admin.site.register(ProductBrand, ProductBrandAdmin)
admin.site.register(Cart, CartAdmin)
admin.site.register(Wishlist, WishlistAdmin)
admin.site.register(Order, OrderAdmin)
admin.site.register(OrderItem, OrderItemAdmin)
admin.site.register(UserProfile)
