import factory
import factory.fuzzy
from . import models

from taravel.orders.factories import OrderFactory


class GuestFactory(factory.django.DjangoModelFactory):
    order = factory.SubFactory(OrderFactory)
    first_name = factory.Sequence(lambda n: 'first_name-%04d' % n)
    second_name = factory.Sequence(lambda n: 'first_name-%04d' % n)
    government_id = factory.fuzzy.FuzzyInteger(low=100, high=200)

    class Meta:
        model = models.Guest
