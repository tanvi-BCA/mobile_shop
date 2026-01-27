import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mobile_shop.settings')
django.setup()

from shop.models import Cart, User  # app name check karo

invalid_carts = Cart.objects.exclude(user__in=User.objects.all())
count = invalid_carts.count()
invalid_carts.delete()

print(f"Deleted {count} invalid cart entries.")
