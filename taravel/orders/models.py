from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.core.urlresolvers import reverse
from django.conf import settings
from django.utils.encoding import python_2_unicode_compatible

from taravel.trips.models import Trip
from taravel.addresses.models import Address


class OrderQuerySet(models.QuerySet):
    def with_total_value(self):
        return self.annotate(value=models.Sum('guest__value'))


@python_2_unicode_compatible
class Order(models.Model):
    user = models.ForeignKey(to=settings.AUTH_USER_MODEL, verbose_name=_("User"))
    trip = models.ForeignKey(to=Trip, verbose_name=_("Trip"))
    address = models.ForeignKey(to=Address, verbose_name=_("Billing address"))
    created = models.DateTimeField(verbose_name=_("Creation date"), auto_now_add=True)
    paid = models.DateField(verbose_name=_("Date of payment"), blank=True, null=True)
    note = models.TextField(blank=True)
    objects = OrderQuerySet.as_manager()

    def is_paid(self):
        return bool(self.paid)

    class Meta:
        verbose_name = _("Order")
        verbose_name_plural = _("Orders")
        permissions = (("mark_paid_order", "Can mark paid order"),
                       ("view_order", "Can view order"),
                       )

    def __str__(self):
        return _("Order #%d") % (self.pk, )

    def get_absolute_url(self):
        return reverse('orders:details', kwargs={'pk': self.pk})
