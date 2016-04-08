from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.core.urlresolvers import reverse
from django.conf import settings
from django.utils.encoding import python_2_unicode_compatible
from model_utils.models import TimeStampedModel
from autoslug.fields import AutoSlugField
from django_bleach.models import BleachField
from versatileimagefield.fields import VersatileImageField
from taravel.locations.models import Location


class TripQuerySet(models.QuerySet):
    pass


@python_2_unicode_compatible
class Trip(TimeStampedModel):
    name = models.CharField(verbose_name=_("Name"), max_length=100)
    slug = AutoSlugField(populate_from='name', verbose_name=_("Slug"), unique=True)
    created_by = models.ForeignKey(to=settings.AUTH_USER_MODEL)
    description = BleachField(verbose_name=_("Description of trip"))
    base_price = models.IntegerField(verbose_name=_("Price"))  # Custom model field
    space = models.IntegerField(verbose_name=_("Space"), default=_("The maximum number of guests"))
    locations = models.ManyToManyField(to=Location, verbose_name=_("Locations"))
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
        return "%.2f PLN" % (self.price/100)


class Image(models.Model):
    trip = models.ForeignKey(to=Trip, help_text=_("Trip"))
    file = VersatileImageField(_('Image'), upload_to='images/')

    def get_absolute_url(self):
        return self.file.url

    class Meta:
        verbose_name = _("Image")
        verbose_name_plural = _("Images")
