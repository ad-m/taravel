import factory
from . import models


class CountryFactory(factory.django.DjangoModelFactory):
    name = factory.Sequence(lambda n: 'country-%04d' % n)

    class Meta:
        model = models.Country


class LocationFactory(factory.django.DjangoModelFactory):
    country = factory.SubFactory(CountryFactory)
    name = factory.Sequence(lambda n: 'location-%04d' % n)

    class Meta:
        model = models.Location
