# -*- coding: utf-8 -*-
from atom.ext.crispy_forms.forms import SingleButtonMixin
from django import forms
from .models import Location, Country


class CountryForm(SingleButtonMixin, forms.ModelForm):
    class Meta:
        model = Country
        fields = ['continent', 'name']


class LocationForm(SingleButtonMixin, forms.ModelForm):
    class Meta:
        model = Location
        fields = ['country', 'name', 'position']
