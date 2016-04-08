# -*- coding: utf-8 -*-
from __future__ import unicode_literals, absolute_import

from django.contrib.auth.models import AbstractUser
from django.core.urlresolvers import reverse
from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _


@python_2_unicode_compatible
class User(AbstractUser):

    # First Name and Last Name do not cover name patterns
    # around the globe.
    name = models.CharField(verbose_name=_("Name of User"),
                            blank=True,
                            max_length=255)
    discount = models.IntegerField(verbose_name=_("Discount"), default=0)

    def __str__(self):
        return self.username

    def get_absolute_url(self):
        return reverse('users:detail', kwargs={'username': self.username})


@python_2_unicode_compatible
class Address(models.Model):
    name = models.CharField(verbose_name=_("Name"), max_length=100)
    street = models.CharField(verbose_name=_("Street"), max_length=50)
    street_number = models.CharField(verbose_name=_("Street number"), max_length=10)
    postcode = models.CharField(verbose_name=_("Postcode"), max_length=6)
    city = models.CharField(verbose_name=_("City"), max_length=50)
    taxpayer_id = models.IntegerField(verbose_name=_("Taxpayer ID"),
                                      help_text=_("Awarded by the government"))

    class Meta:
        verbose_name = _("Address")
        verbose_name_plural = _("Addresses")

    def __str__(self):
        return _("{name} (Street {street} {stret_number}," +
                 " {postcode} {city})").format(**self.__dict__())
