from __future__ import unicode_literals

from django.core.urlresolvers import reverse
from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _

from taravel.orders.models import Order


class GuestQuerySet(models.QuerySet):
    pass


@python_2_unicode_compatible
class Guest(models.Model):  # TODO: Move to taravel.orders
    order = models.ForeignKey(to=Order, verbose_name=_("Order"))
    first_name = models.CharField(verbose_name=_("First name"), max_length=50)
    second_name = models.CharField(verbose_name=_("Second name"), max_length=50)
    government_id = models.IntegerField(verbose_name=_("Government ID"))
    value = models.IntegerField(verbose_name=_("Value"))  # TODO: Custom model field
    objects = GuestQuerySet.as_manager()

    class Meta:
        verbose_name = _("Guest")
        verbose_name_plural = _("Guests")

    def __str__(self):
        return "{first_name} {second_name}".format(first_name=self.first_name,
                                                   second_name=self.second_name)

    def get_absolute_url(self):
        return reverse('guests:details', kwargs={'pk': self.pk})
