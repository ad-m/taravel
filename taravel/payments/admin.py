from django.contrib import admin
from .models import Payment, PaymentForm


class PaymentAdmin(admin.ModelAdmin):
    '''
        Admin View for Payment
    '''
    list_display = ('cashier', 'created', 'order')
    list_filter = ('cashier', )

admin.site.register(Payment, PaymentAdmin)


class PaymentFormAdmin(admin.ModelAdmin):
    '''
        Admin View for PaymentForm
    '''
    list_display = ('name', )

admin.site.register(PaymentForm, PaymentFormAdmin)
