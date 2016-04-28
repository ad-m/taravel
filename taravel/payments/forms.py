# -*- coding: utf-8 -*-
from django import forms
from .models import Payment
from braces.forms import UserKwargModelFormMixin


class PaymentForm(UserKwargModelFormMixin, forms.ModelForm):
    def __init__(self, *args, **kwargs):
        order = kwargs.pop('order', None)
        super(PaymentForm, self).__init__(*args, **kwargs)
        if order:
            self.instance.order = order
        self.instance.cashier = self.user

    class Meta:
        model = Payment
        fields = ['form', ]
