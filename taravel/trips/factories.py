import factory
import factory.fuzzy
from . import models

from taravel.users.factories import UserFactory


class TripFactory(factory.django.DjangoModelFactory):
    name = factory.Sequence(lambda n: 'trip-%04d' % n)
    created_by = factory.SubFactory(UserFactory)
    description = factory.fuzzy.FuzzyText()
    base_price = factory.fuzzy.FuzzyInteger(low=100, high=200)
    space = factory.fuzzy.FuzzyInteger(low=3, high=10)
    main_image = factory.django.ImageField()

    class Meta:
        model = models.Trip


class ImageFactory(factory.django.DjangoModelFactory):
    trip = factory.SubFactory(TripFactory)
    file = factory.django.ImageField()

    class Meta:
        model = models.Image
