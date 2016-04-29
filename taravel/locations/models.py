from __future__ import unicode_literals

from autoslug.fields import AutoSlugField
from django.core.urlresolvers import reverse
from django.contrib.gis.db import models
from django.utils.encoding import python_2_unicode_compatible
from django.utils.translation import ugettext_lazy as _
from model_utils import Choices


@python_2_unicode_compatible
class Country(models.Model):
    CONTINENT = Choices((0, 'asia', _('Asia')),
                        (1, 'africa', _('Africa')),
                        (2, 'north_america', _('North America')),
                        (3, 'south_america', _('South America')),
                        (4, 'antarctica', _('Antarctica')),
                        (5, 'europe', _('Europe')),
                        (6, 'australia', _('Australia')))
    continent = models.IntegerField(choices=CONTINENT,
                                    default=CONTINENT.europe,
                                    verbose_name=_("Continent"))
    name = models.CharField(_("Name of country"), max_length=255)
    slug = AutoSlugField(populate_from='name', verbose_name=_("Slug"), unique=True)

    class Meta:
        verbose_name = _("Country")
        verbose_name_plural = _("Countries")

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return "%s?location__country=%d" % (reverse('trips:list'), self.pk)


class LocationQuerySet(models.query.GeoQuerySet):
    pass


@python_2_unicode_compatible
class Location(models.Model):
    country = models.ForeignKey(to=Country, verbose_name=_("Country"))
    name = models.CharField(verbose_name=_("Name"), max_length=50)
    slug = AutoSlugField(populate_from='name', verbose_name=_("Slug"), unique=True)
    position = models.PointField(verbose_name=_("Position"), srid=4326, null=True)
    objects = LocationQuerySet.as_manager()

    class Meta:
        verbose_name = _("Location")
        verbose_name_plural = _("Locations")

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return "%s?location=%d" % (reverse('trips:list'), self.pk)

    @property
    def absolute_url(self):
        return self.get_absolute_url()
