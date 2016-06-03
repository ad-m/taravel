from autoslug.fields import AutoSlugField
from django.conf import settings
from django.core.urlresolvers import reverse
from django.db import models
from django.db.models import Prefetch
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _
from django_bleach.models import BleachField
from model_utils.models import TimeStampedModel
from taravel.locations.models import Location
from taravel.orders.models import Order
from versatileimagefield.fields import VersatileImageField
from django.contrib.gis.db.models.query import GeoQuerySet


class TripQuerySet(GeoQuerySet):
    def with_guest_count(self):
        return self.annotate(guest_count=models.Count('order__guest')).all()

    def free(self):
        return self.with_guest_count().filter(space__lt=models.F('guest_count')).all()

    def full(self):
        return self.with_guest_count().qs.filter(space__gt=models.F('guest_count')).all()

    def with_free_count(self):
        expr = models.ExpressionWrapper(expression=models.F('space') - models.F('guest_count'),
                                        output_field=models.IntegerField())
        return self.with_guest_count().annotate(free_count=expr)

    def with_user_orders(self, user):
        qs = (Order.objects.filter(user=user).
              with_total_value().
              with_payment().
              all())
        return self.prefetch_related(Prefetch('order_set',
                                              queryset=qs,
                                              to_attr='user_orders'))

    def with_orders(self):
        qs = (Order.objects.
              with_total_value().
              with_payment().
              select_related('user').
              all())
        return self.prefetch_related(Prefetch('order_set',
                                              queryset=qs,
                                              to_attr='orders'))

    def nearest(self, point):
        return (self.
                distance(point, field_name='location__position').
                order_by('distance'))


@python_2_unicode_compatible
class Trip(TimeStampedModel):
    location = models.ForeignKey(to=Location, verbose_name=_("Location"))
    name = models.CharField(verbose_name=_("Name"), max_length=100)
    slug = AutoSlugField(populate_from='name', verbose_name=_("Slug"), unique=True)
    created_by = models.ForeignKey(to=settings.AUTH_USER_MODEL)
    description = BleachField(verbose_name=_("Description of trip"))
    base_price = models.IntegerField(verbose_name=_("Price"),
                                     help_text=_("Price per each guest"))
    space = models.PositiveIntegerField(verbose_name=_("Space"),
                                        default=10,
                                        help_text=_("The maximum number of guests"))
    main_image = VersatileImageField(_('Image'), upload_to='images/')
    objects = TripQuerySet.as_manager()

    class Meta:
        verbose_name = _("Trip")
        verbose_name_plural = _("Trips")

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('trips:details', kwargs={'slug': self.slug})

    def get_price_display(self):
        return "%.2f PLN" % (self.base_price / 100)


class Image(models.Model):
    trip = models.ForeignKey(to=Trip, help_text=_("Trip"))
    file = VersatileImageField(_('Image'), upload_to='images/')

    def get_absolute_url(self):
        return self.file.url

    class Meta:
        verbose_name = _("Image")
        verbose_name_plural = _("Images")
