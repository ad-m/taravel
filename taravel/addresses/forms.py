# -*- coding: utf-8 -*-
from django import forms
from .models import Address
from braces.forms import UserKwargModelFormMixin
from atom.ext.crispy_forms.forms import SingleButtonMixin


STATIC_FIELD = ['name', 'street', 'street_number', 'postcode', 'city', 'taxpayer_id']


#Source: https://github.com/KlubJagiellonski/pola-backend/blob/75d4d17a24902e6cdf67fe48e6df80dc63160fee/pola/forms.py#L61-L76
class ReadOnlyFieldsMixin(object):
    readonly_fields = ()

    def __init__(self, *args, **kwargs):
        super(ReadOnlyFieldsMixin, self).__init__(*args, **kwargs)
        for field_name in self.readonly_fields:
            field = self.fields[field_name]
            field.widget.attrs['disabled'] = 'true'
            field.required = False

    def clean(self):
        cleaned_data = super(ReadOnlyFieldsMixin, self).clean()
        for field in self.readonly_fields:
            cleaned_data[field] = getattr(self.instance, field)
        return cleaned_data


class AddressForm(ReadOnlyFieldsMixin, SingleButtonMixin, UserKwargModelFormMixin, forms.ModelForm):
    readonly_fields = ()

    def __init__(self, *args, **kwargs):
        if kwargs.get('instance', None) and kwargs.get('instance', None).used:
            self.readonly_fields = STATIC_FIELD
        super(AddressForm, self).__init__(*args, **kwargs)
        if not self.user.has_perm('addresses.add_addrress'):  # can't add
            del self.fields['user']
            self.instance.user = self.user
        else:
            self.fields['user'].initial = self.user
        if not self.instance:
            del self.fields['active']

    class Meta:
        model = Address
        fields = ['user'] + STATIC_FIELD + ['active', ]
