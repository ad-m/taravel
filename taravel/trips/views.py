from atom.views import DeleteMessageMixin
from braces.views import FormValidMessageMixin, SelectRelatedMixin, UserFormKwargsMixin
from django.contrib.auth.mixins import PermissionRequiredMixin
from django.core.urlresolvers import reverse_lazy
from django.utils.translation import ugettext_lazy as _
from django.views.generic import CreateView, DeleteView, DetailView, UpdateView
from django_filters.views import FilterView

from .filters import TripFilter
from .forms import TripForm
from .models import Trip


class TripListView(FilterView):
    filterset_class = TripFilter
    model = Trip
    paginate_by = 25

    def get_queryset(self, *args, **kwargs):
        qs = super(TripListView, self).get_queryset(*args, **kwargs)
        return qs


class TripDetailView(SelectRelatedMixin, DetailView):
    model = Trip
    select_related = ['location', 'location__country']

    def dispatch(self, request, *args, **kwargs):
        if request.user.is_staff:
            self.select_related.append('created_by')
        return super(TripDetailView, self).dispatch(request, *args, **kwargs)


class TripCreateView(PermissionRequiredMixin, UserFormKwargsMixin, CreateView):
    model = Trip
    form_class = TripForm
    permission_required = 'trips.add_trip'

    def get_form_valid_message(self):
        return _("{0} created!").format(self.object)


class TripUpdateView(PermissionRequiredMixin, FormValidMessageMixin, UpdateView):
    model = Trip
    form_class = TripForm
    permission_required = 'trips.change_trip'

    def get_form_valid_message(self):
        return _("{0} updated!").format(self.object)


class TripDeleteView(PermissionRequiredMixin, DeleteMessageMixin, DeleteView):
    model = Trip
    success_url = reverse_lazy('trips:list')
    permission_required = 'trips.delete_trip'

    def get_success_message(self):
        return _("{0} deleted!").format(self.object)
