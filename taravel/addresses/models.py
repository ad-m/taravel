# -*- coding: utf-8 -*-
from __future__ import absolute_import, unicode_literals

from cached_property import cached_property
from django.conf import settings
from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _


class AddressQuerySet(models.QuerySet):
    def with_used_count(self, *args, **kwargs):
        return self.annonate(use_count=models.Count('orders'))


@python_2_unicode_compatible
class Address(models.Model):
    user = models.ForeignKey(to=settings.AUTH_USER_MODEL, verbose_name=_("User"))
    name = models.CharField(verbose_name=_("Name"), max_length=100)
    street = models.CharField(verbose_name=_("Street"), max_length=50)
    street_number = models.CharField(verbose_name=_("Street number"), max_length=10)
    postcode = models.CharField(verbose_name=_("Postcode"), max_length=6)
    city = models.CharField(verbose_name=_("City"), max_length=50)
    taxpayer_id = models.IntegerField(verbose_name=_("Taxpayer ID"))
    active = models.BooleanField(default=True, verbose_name=_("Active"))
    objects = AddressQuerySet.as_manager()

    class Meta:
        verbose_name = _("Address")
        verbose_name_plural = _("Addresses")
        permissions = (("view_address", "Can view address"),)

    def __str__(self):
        return ("{name} (Street {street} {street_number}," +
                " {postcode} {city})").format(name=self.name,
                                              street=self.street,
                                              street_number=self.street_number,
                                              postcode=self.postcode,
                                              city=self.city)

    @cached_property
    def used(self):
        return self.order_set.count() > 0
