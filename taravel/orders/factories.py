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

    class Meta:
        model = models.Order
