from __future__ import unicode_literals

from django.conf import settings
from django.core.urlresolvers import reverse
from django.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext as _f
from django.utils.translation import ugettext_lazy as _
from taravel.addresses.models import Address


class OrderQuerySet(models.QuerySet):
    def with_guest_count(self):
        return self.annotate(guest_count=models.Count('guest'))

    def with_total_value(self):
        return self.annotate(total_value=models.Count('guest') * models.F('unit_price'))

    def with_payment(self):
        return self.select_related('payment')


@python_2_unicode_compatible
class Order(models.Model):
    user = models.ForeignKey(to=settings.AUTH_USER_MODEL, verbose_name=_("User"))
    trip = models.ForeignKey(to='trips.Trip', verbose_name=_("Trip"))
    address = models.ForeignKey(to=Address, verbose_name=_("Billing address"))
    created = models.DateTimeField(verbose_name=_("Creation date"), auto_now_add=True)
    note = models.TextField(blank=True)
    unit_price = models.IntegerField(verbose_name=_("Unit price"),
                                     help_text=_("Participation value of each guest"))
    objects = OrderQuerySet.as_manager()

    def is_paid(self):
        return bool(self.payment)

    class Meta:
        verbose_name = _("Order")
        verbose_name_plural = _("Orders")
        permissions = (("view_order", "Can view order"), )

    def __str__(self):
        if self.pk:
            return _("Order #%d") % (self.pk, )
        return _f("Order")

    def get_absolute_url(self):
        return reverse('orders:details', kwargs={'pk': self.pk})


class GuestQuerySet(models.QuerySet):
    pass


@python_2_unicode_compatible
class Guest(models.Model):
    order = models.ForeignKey(to=Order, verbose_name=_("Order"))
    first_name = models.CharField(verbose_name=_("First name"), max_length=50)
    second_name = models.CharField(verbose_name=_("Second name"), max_length=50)
    document_id = models.CharField(verbose_name=_("Number of governmental document with photo"),
                                   max_length=50)
    objects = GuestQuerySet.as_manager()

    class Meta:
        verbose_name = _("Guest")
        verbose_name_plural = _("Guests")

    def __str__(self):
        return "{first_name} {second_name}".format(first_name=self.first_name,
                                                   second_name=self.second_name)

    def get_absolute_url(self):
        return reverse('guests:details', kwargs={'pk': self.pk})
