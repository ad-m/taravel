from django.contrib import admin
from .models import Guest, Order


class GuestInline(admin.StackedInline):
    '''
        Stacked Inline View for Guest
    '''
    model = Guest


class GuestAdmin(admin.ModelAdmin):
    '''
        Admin View for Guest
    '''
    list_display = ('order', 'first_name', 'second_name')
    search_fields = ('first_name', 'second_name')
admin.site.register(Guest, GuestAdmin)


class OrderAdmin(admin.ModelAdmin):
    '''
        Admin View for Order
    '''
    list_display = ('trip', 'user', 'address', 'unit_price', 'guest_count', 'total_value',
                    'is_paid')
    list_filter = ('unit_price',)
    inlines = [
        GuestInline,
    ]

    def guest_count(self, obj):
        return obj.guest_count

    def total_value(self, obj):
        return obj.total_value

    def get_queryset(self, *args, **kwargs):
        qs = super(OrderAdmin, self).get_queryset(*args, **kwargs)
        return qs.with_guest_count().with_total_value()
admin.site.register(Order, OrderAdmin)


class OrderInline(admin.StackedInline):
        '''
            Stacked Inline View for Order
        '''
        model = Order
