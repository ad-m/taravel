import factory
import factory.fuzzy

from . import models
from ..addresses.factories import AddressFactory
from ..trips.factories import TripFactory
from ..users.factories import UserFactory


class OrderFactory(factory.django.DjangoModelFactory):
    user = factory.SubFactory(UserFactory)
    trip = factory.SubFactory(TripFactory)
    address = factory.SubFactory(AddressFactory)
    unit_price = 250

    class Meta:
        model = models.Order


class GuestFactory(factory.django.DjangoModelFactory):
    order = factory.SubFactory(OrderFactory)
    first_name = factory.Sequence(lambda n: 'first_name-%04d' % n)
    second_name = factory.Sequence(lambda n: 'first_name-%04d' % n)
    document_id = factory.fuzzy.FuzzyInteger(low=100, high=200)

    class Meta:
        model = models.Guest
