# -*- coding: utf-8 -*-
from atom.ext.crispy_forms.forms import SingleButtonMixin
from django import forms
from .models import Trip
from braces.forms import UserKwargModelFormMixin
from tinymce.widgets import TinyMCE
from leaflet.forms.fields import PointField


class TripForm(UserKwargModelFormMixin, SingleButtonMixin, forms.ModelForm):
    def __init__(self, *args, **kwargs):

        super(TripForm, self).__init__(*args, **kwargs)
        if self.user:
            self.instance.created_by = self.user

    class Meta:
        model = Trip
        fields = ['name', 'location', 'description', 'base_price', 'space', 'main_image']
        widgets = {
                'description': TinyMCE(),
        }


class SearchForm(SingleButtonMixin, forms.Form):
    point = PointField()

    def __init__(self, *args, **kwargs):
        super(SearchForm, self).__init__(*args, **kwargs)
        self.helper.form_method = 'get'
