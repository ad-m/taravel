from __future__ import unicode_literals
from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.core.urlresolvers import reverse
from django.conf import settings
from django.utils.encoding import python_2_unicode_compatible
from ..orders.models import Order


@python_2_unicode_compatible
class PaymentForm(models.Model):
    name = models.CharField(verbose_name=_("Name"), max_length=25)

    def __str__(self):
        return self.name


class PaymentQuerySet(models.QuerySet):
    pass


@python_2_unicode_compatible
class Payment(models.Model):
    order = models.OneToOneField(Order, verbose_name=_("Order"))
    cashier = models.ForeignKey(settings.AUTH_USER_MODEL, blank=True, null=True)
    form = models.ForeignKey(PaymentForm, verbose_name=_("Form of payment"))
    created = models.DateTimeField(verbose_name=_("Creation date"), auto_now_add=True)
    objects = PaymentQuerySet.as_manager()

    class Meta:
        verbose_name = _("Payment")
        verbose_name_plural = _("Payments")
        ordering = ['created', ]

    def __str__(self):
        return _("Payment #%d") % (self.pk or 0, )

    def get_update_url(self):
        return reverse('payments:update', kwargs={'pk': str(self.pk)})

    def get_delete_url(self):
        return reverse('payments:delete', kwargs={'pk': str(self.pk)})
