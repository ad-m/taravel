from django.test import TestCase
from django.utils.encoding import force_text

from .factories import GuestFactory


class GuestTestCase(TestCase):
    def setUp(self):
        self.object = GuestFactory(first_name="Adam", second_name="Waglowski")

    def test_str(self):
        self.assertEqual("Adam Waglowski", force_text(self.object))
