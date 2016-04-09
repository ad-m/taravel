# -*- coding: utf-8 -*-
from django import forms
from .models import Order
from braces.forms import UserKwargModelFormMixin
from django.utils import timezone


class OrderForm(UserKwargModelFormMixin, forms.ModelForm):
    def __init__(self, *args, **kwargs):
        trip = kwargs.pop('trip', None)
        super(OrderForm, self).__init__(*args, **kwargs)
        if trip:
            self.instance.trip = trip
        if self.user:
            self.instance.user = self.user

    class Meta:
        model = Order
        fields = ['note', 'address']


class OrderPaidForm(UserKwargModelFormMixin, forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(OrderPaidForm, self).__init__(*args, **kwargs)

    def save(self, commit=True, *args, **kwargs):
        obj = super(OrderPaidForm, self).save(commit, *args, **kwargs)
        obj.paid = timezone.now()
        if commit:
            obj.save()
        return obj

    class Meta:
        model = Order
        fields = []

