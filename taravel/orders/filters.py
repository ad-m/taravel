# -*- coding: utf-8 -*-
from atom.ext.django_filters.filters import CrispyFilterMixin
from django.utils.translation import ugettext_lazy as _
from django_filters import FilterSet

from .models import Order


class OrderFilter(CrispyFilterMixin, FilterSet):
    form_class = None

    def __init__(self, *args, **kwargs):
        super(OrderFilter, self).__init__(*args, **kwargs)

    class Meta:
        model = Order
        fields = ['user']
