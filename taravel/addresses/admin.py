from django.contrib import admin
from .models import Address


class AddressAdmin(admin.ModelAdmin):
    list_display = ('user', 'name', 'street', 'street_number', 'postcode', 'city')
    list_filter = ('active', )
    search_fields = ('name', 'user__username')
admin.site.register(Address, AddressAdmin)


class AddressInline(admin.StackedInline):
    '''
        Stacked Inline View for Address
    '''
    model = Address
