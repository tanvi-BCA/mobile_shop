from django.urls import path
from . import views
from .views import user_login, admin_login
from django.contrib.auth import views as auth_views

urlpatterns = [
    path('', views.index, name='index'),

    # 🔐 Authentication
    path('login/', user_login, name='login'),
    path('admin-login/', admin_login, name='admin_login'),
    path('logout/', views.logout_view, name='logout'),
    path('hot-deal/<int:deal_id>/', views.hot_deal_products, name='hot_deal_products'),
     path('product/<int:id>/', views.product_detail, name='product_detail'),

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
    path('newsletter/subscribe/', views.newsletter_subscribe, name='newsletter_subscribe'),
    path('about/', views.about, name='about'),
    

    # 🛒 Cart & Checkout
    path('cart/', views.cart, name='cart'),
   path('category/<slug:slug>/', views.category_products, name='category_products'),

    path('checkout/', views.checkout, name='checkout'),
    path('add-to-cart/<int:id>/', views.add_to_cart, name='add_to_cart'),
    path('remove-from-cart/<int:product_id>/', views.remove_from_cart, name='remove_from_cart'),
    path('increase-quantity/<int:product_id>/', views.increase_quantity, name='increase_quantity'),
    path('decrease-quantity/<int:product_id>/', views.decrease_quantity, name='decrease_quantity'),
    path('edit-profile/', views.edit_profile, name='edit_profile'),

    # ❤️ Wishlist
    path('wishlist/', views.wishlist, name='wishlist'),
    path('add-to-wishlist/<int:product_id>/', views.add_to_wishlist, name='add_to_wishlist'),
    path('remove-from-wishlist/<int:product_id>/', views.remove_from_wishlist, name='remove_from_wishlist'),
    path('move-wishlist-to-cart/<int:product_id>/', views.move_wishlist_to_cart, name='move_wishlist_to_cart'),

    # 📦 Orders
    path('order-list/', views.order_list, name='order_list'),
    path('order-status/', views.order_status, name='order_status'),
    path('return-order/<int:order_id>/', views.return_order, name='return_order'),
    path('my-orders/', views.my_orders, name='my_orders'),
    path('orders/', views.orders, name='orders'),
    path('qr/<int:order_id>/', views.qr_payment, name='qr_payment'),
    path('qr/<int:order_id>/pay/', views.payment_success_dummy, name='payment_success_dummy'),
    path('product/<int:product_id>/review/', views.add_review, name='add_review'),
    path('product/<int:id>/', views.product_detail, name='product_detail'),
    path('product/<int:product_id>/review/', views.add_review, name='add_review'),
    path('review/<int:review_id>/delete/', views.delete_review, name='delete_review'),

    path('hot-deal/', views.hot_deal_products, name='hot_deal_products'),

    path('place-order/', views.place_order, name='place_order'),

    path("order-success/<int:order_id>/", views.order_success,name="order_success"),
    path('my_orders/', views.my_orders, name='my_orders'),
    path('return-order/<int:order_id>/', views.return_order, name='return_order'),

    path('product/<int:id>/', views.product_detail, name='product_detail'),

    path('about/', views.about, name='about'),

    path('refund/<int:order_id>/', views.refund_request, name='refund_request'),
    path('product/<int:id>/', views.product_detail, name='product_detail'),
    # 🔔 Notifications
    path('notifications/', views.notifications, name='notifications'),
    path('notification/read/<int:id>/', views.mark_notification_read, name='mark_notification_read'),
    path('notifications/unread/', views.unread_notifications, name='unread_notifications'),

    # 🧾 Invoice
    path('invoice-a4/<int:order_id>/', views.invoice_a4, name='invoice_a4'),

     path('about/', views.about, name='about'),
    path('contact/', views.contact, name='contact'),
    path('privacy-policy/', views.privacy_policy, name='privacy_policy'),
    path('terms-conditions/', views.terms_conditions, name='terms_conditions'),

    path('my-account/', views.my_account, name='my_account'),
    path('add-address/', views.add_address, name='add_address'),



    path('forgot-password/', auth_views.PasswordResetView.as_view(
        template_name='auth/forgot_password.html'
    ), name='password_reset'),

    path('reset-password-sent/', auth_views.PasswordResetDoneView.as_view(
        template_name='auth/password_reset_done.html'
    ), name='password_reset_done'),

     path(
        'reset/<uidb64>/<token>/',
        auth_views.PasswordResetConfirmView.as_view(),
        name='password_reset_confirm'
    ),

    path(
        'reset/complete/',
        auth_views.PasswordResetCompleteView.as_view(),
        name='password_reset_complete'
    ),
]
