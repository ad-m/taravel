from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.core.urlresolvers import reverse
from django.conf import settings
from django.utils.encoding import python_2_unicode_compatible

from taravel.trips.models import Trip


class OrderQuerySet(models.QuerySet):
    pass


@python_2_unicode_compatible
class Order(models.Model):
    user = models.ForeignKey(to=settings.AUTH_USER_MODEL, verbose_name=_("User"))
    trip = models.ForeignKey(to=Trip, verbose_name=_("Trip"))
    created = models.DateTimeField(verbose_name=_("Creation date"), auto_now_add=True)
    paid = models.DateField(verbose_name=_("Date of payment"), blank=True, null=True)
    objects = OrderQuerySet.as_manager()

    class Meta:
        verbose_name = _("Order")
        verbose_name_plural = _("Orders")

    def __str__(self):
        return self.pk

    def get_absolute_url(self):
        return reverse('orders:details', kwargs={'slug': self.slug})
