import factory
from . import models


from ..users.factories import UserFactory


class AddressFactory(factory.django.DjangoModelFactory):
    user = factory.SubFactory(UserFactory)
    name = factory.Sequence(lambda n: 'name-%04d' % n)
    street = factory.Sequence(lambda n: 'street-%04d' % n)
    street_number = factory.Sequence(lambda n: '%da' % n)
    postcode = factory.Sequence(lambda n: '00-%03d' % n)
    city = factory.Sequence(lambda n: 'city-%04d' % n)
    taxpayer_id = factory.Sequence(lambda n: n)

    class Meta:
        model = models.Address
