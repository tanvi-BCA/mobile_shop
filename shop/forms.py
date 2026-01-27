from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
import re


# =======================
# LOGIN FORM
# =======================
class CustomLoginForm(AuthenticationForm):
    username = forms.CharField(
        max_length=150,
        widget=forms.TextInput(attrs={
            'placeholder': 'Enter username'
        })
    )

    password = forms.CharField(
        widget=forms.PasswordInput(attrs={
            'placeholder': 'Enter password'
        })
    )

    def clean_username(self):
        username = self.cleaned_data.get('username')

        if not username:
            raise forms.ValidationError("Username cannot be blank")

        # allow letters, numbers, underscore
        if not re.match(r'^[a-zA-Z0-9_]+$', username):
            raise forms.ValidationError(
                "Username can contain only letters, numbers and underscore"
            )

        if len(username) < 3:
            raise forms.ValidationError(
                "Username must be at least 3 characters long"
            )

        return username

    def clean_password(self):
        password = self.cleaned_data.get('password')

        if not password:
            raise forms.ValidationError("Password cannot be blank")

        if len(password) < 8:
            raise forms.ValidationError("Password must be at least 8 characters")

        if not re.search(r"[A-Z]", password):
            raise forms.ValidationError(
                "Password must contain at least one uppercase letter"
            )

        if not re.search(r"[a-z]", password):
            raise forms.ValidationError(
                "Password must contain at least one lowercase letter"
            )

        if not re.search(r"[0-9]", password):
            raise forms.ValidationError(
                "Password must contain at least one number"
            )

        if not re.search(r"[!@#$%^&*()_+=\-{}[\]:;\"'<>,.?/]", password):
            raise forms.ValidationError(
                "Password must contain at least one special character"
            )

        return password


# =======================
# REGISTER FORM
# =======================
class RegisterForm(UserCreationForm):
    email = forms.EmailField(required=True)

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']

    # ✅ Username validation
    def clean_username(self):
        username = self.cleaned_data.get('username')

        if User.objects.filter(username=username).exists():
            raise forms.ValidationError("Username already exists")

        if not username.isalpha():
            raise forms.ValidationError("Username must contain only alphabets")

        if len(username) < 3:
            raise forms.ValidationError("Username must be at least 3 characters")

        return username

    # ✅ Email validation
    def clean_email(self):
        email = self.cleaned_data.get('email')

        if User.objects.filter(email=email).exists():
            raise forms.ValidationError("Email already registered")

        return email

    # ✅ Strong password validation
    def clean_password1(self):
        password = self.cleaned_data.get('password1')

        if len(password) < 8:
            raise forms.ValidationError("Password must be at least 8 characters")

        if not re.search(r'[A-Z]', password):
            raise forms.ValidationError("Password must contain one uppercase letter")

        if not re.search(r'[a-z]', password):
            raise forms.ValidationError("Password must contain one lowercase letter")

        if not re.search(r'[0-9]', password):
            raise forms.ValidationError("Password must contain one number")

        if not re.search(r'[!@#$%^&*()_+=\-{}[\]:;"\'<>,.?/]', password):
            raise forms.ValidationError("Password must contain one special character")

        return password