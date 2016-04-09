# -*- coding: utf-8 -*-
from atom.ext.crispy_forms.forms import SingleButtonMixin
from django import forms
from .models import Trip
from braces.forms import UserKwargModelFormMixin


class TripForm(UserKwargModelFormMixin, SingleButtonMixin, forms.ModelForm):
    def __init__(self, *args, **kwargs):
        super(TripForm, self).__init__(*args, **kwargs)
        if self.user:
            self.instance.created_by = self.user

    class Meta:
        model = Trip
        fields = ['name', 'location', 'base_price', 'space', 'main_image']
