# -*- coding: utf-8 -*-
from atom.ext.django_filters.filters import CrispyFilterMixin
from django_filters import FilterSet

from .models import Address


class AddressFilter(CrispyFilterMixin, FilterSet):
    form_class = None

    def __init__(self, *args, **kwargs):
        super(AddressFilter, self).__init__(*args, **kwargs)

    class Meta:
        model = Address
        fields = ['active']
