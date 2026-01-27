from .models import ProductCategory

def categories_processor(request):
    return {
        'categories': ProductCategory.objects.all()
    }
