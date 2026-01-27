from django.urls import path
from . import views
from .views import user_login, admin_login

urlpatterns = [
    path('', views.index, name='index'),

    # 🔐 Authentication
    path('login/', user_login, name='login'),
    path('admin-login/', admin_login, name='admin_login'),
    path('logout/', views.logout_view, name='logout'),

    # 🧭 Pages
    path('dashboard/', views.dashboard, name='dashboard'),
    path('store/', views.store, name='store'),
    path('contact/', views.contact, name='contact'),

    # 👤 User
    path('register/', views.register_view, name='register'),
    path('my-profile/', views.my_profile, name='my_profile'),
    path('edit-profile/', views.edit_profile, name='edit_profile'),
    path('invoice-pdf/<int:order_id>/', views.download_invoice_pdf, name='download_invoice_pdf'),

    path('my-address/', views.my_address, name='my_address'),

    # 🛒 Cart & Checkout
    path('cart/', views.cart, name='cart'),
    path('category/<int:id>/', views.category_products, name='category_products'),
    path('checkout/', views.checkout, name='checkout'),
    path('add-to-cart/<int:product_id>/', views.add_to_cart, name='add_to_cart'),
    path('remove-from-cart/<int:product_id>/', views.remove_from_cart, name='remove_from_cart'),
    path('increase-quantity/<int:product_id>/', views.increase_quantity, name='increase_quantity'),
    path('decrease-quantity/<int:product_id>/', views.decrease_quantity, name='decrease_quantity'),

    # ❤️ Wishlist
    path('wishlist/', views.wishlist, name='wishlist'),
    path('add-to-wishlist/<int:product_id>/', views.add_to_wishlist, name='add_to_wishlist'),
    path('remove-from-wishlist/<int:product_id>/', views.remove_from_wishlist, name='remove_from_wishlist'),
    path('move-wishlist-to-cart/<int:product_id>/', views.move_wishlist_to_cart, name='move_wishlist_to_cart'),

    # 📦 Orders
    path('order-list/', views.order_list, name='order_list'),
    path('order-status/', views.order_status, name='order_status'),
    path('place-order/', views.place_order, name='place_order'),
    path('order-success/<int:order_id>/', views.order_success, name='order_success'),

    # 🧾 Invoice
    path('invoice-a4/<int:order_id>/', views.invoice_a4, name='invoice_a4'),
]
