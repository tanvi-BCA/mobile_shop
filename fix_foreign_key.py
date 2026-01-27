# fix_foreign_keys.py
import os
import django

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'mobile_shop.settings')
django.setup()

from shop.models import Cart, Wishlist
from django.contrib.auth import get_user_model

User = get_user_model()
default_user = User.objects.first()

Cart.objects.exclude(user__in=User.objects.all()).update(user=default_user)
Wishlist.objects.exclude(user__in=User.objects.all()).update(user=default_user)

print("Foreign keys fixed!")
