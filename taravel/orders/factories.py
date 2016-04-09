import factory
import factory.fuzzy
from . import models

from taravel.trips.factories import TripFactory
from taravel.users.factories import UserFactory


class OrderFactory(factory.django.DjangoModelFactory):
    user = factory.SubFactory(UserFactory)
    trip = factory.SubFactory(TripFactory)

    class Meta:
        model = models.Order
