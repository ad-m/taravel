from atom.views import DeleteMessageMixin
from braces.views import FormValidMessageMixin
from django.contrib.auth.mixins import PermissionRequiredMixin
from django.core.urlresolvers import reverse_lazy
from django.utils.translation import ugettext_lazy as _
from django.views.generic import CreateView, DeleteView, UpdateView

from .forms import CountryForm, LocationForm
from .models import Country, Location


class LocationCreateView(PermissionRequiredMixin, CreateView):
    model = Location
    form_class = LocationForm
    permission_required = 'locations.add_location'

    def get_form_valid_message(self):
        return _("{0} created!").format(self.object)


class LocationUpdateView(PermissionRequiredMixin, FormValidMessageMixin, UpdateView):
    model = Location
    form_class = LocationForm
    permission_required = 'locations.update_location'

    def get_form_valid_message(self):
        return _("{0} updated!").format(self.object)


class LocationDeleteView(PermissionRequiredMixin, DeleteMessageMixin, DeleteView):
    model = Location
    success_url = reverse_lazy('locations:list')
    permission_required = 'locations.delete_location'

    def get_success_message(self):
        return _("{0} deleted!").format(self.object)


class CountryCreateView(PermissionRequiredMixin, CreateView):
    model = Country
    form_class = CountryForm
    permission_required = 'locations.create_country'

    def get_form_valid_message(self):
        return _("{0} created!").format(self.object)


class CountryUpdateView(PermissionRequiredMixin, FormValidMessageMixin, UpdateView):
    model = Country
    form_class = CountryForm
    permission_required = 'locations.change_country'

    def get_form_valid_message(self):
        return _("{0} updated!").format(self.object)


class CountryDeleteView(PermissionRequiredMixin, DeleteMessageMixin, DeleteView):
    model = Country
    success_url = reverse_lazy('locations:list')
    permission_required = 'locations.delete_country'

    def get_success_message(self):
        return _("{0} deleted!").format(self.object)
