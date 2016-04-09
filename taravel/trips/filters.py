# -*- coding: utf-8 -*-
from atom.ext.django_filters.filters import CrispyFilterMixin
from django.utils.translation import ugettext_lazy as _
from django_filters import FilterSet

from .models import Trip


class TripFilter(CrispyFilterMixin, FilterSet):
    form_class = None

    def __init__(self, *args, **kwargs):
        super(TripFilter, self).__init__(*args, **kwargs)
        self.filters['location__country__continent'].field.choices.insert(0, ('', u'---------'))

    class Meta:
        model = Trip
        order_by = [
            ('base_price', _('Price (ascending)')),
            ('-base_price', _('Price (descending)')),
            ('location', _('Price (ascending)')),
            ('location__country__name', _('Country (ascending)')),
            ('location__country__name', _('Country (descending)')),
        ]
        fields = ['location', 'location__country', 'location__country__continent']
