from atom.ext.crispy_forms.forms import BaseTableFormSet
from atom.views import DeleteMessageMixin
from braces.views import FormValidMessageMixin, SelectRelatedMixin, UserFormKwargsMixin
from django.contrib.auth.mixins import PermissionRequiredMixin
from django.core.urlresolvers import reverse_lazy
from django.utils.translation import ugettext_lazy as _
from django.views.generic import CreateView, DeleteView, DetailView, UpdateView
from django_filters.views import FilterView
from extra_views import CreateWithInlinesView, InlineFormSet, NamedFormsetsMixin, UpdateWithInlinesView

from .filters import TripFilter
from .forms import TripForm
from .models import Trip, Image


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


class ImageInline(InlineFormSet):  # TODO: Calculate value
    model = Image
    formset_class = BaseTableFormSet


class TripCreateView(NamedFormsetsMixin, UserFormKwargsMixin, CreateWithInlinesView):
    model = Trip
    form_class = TripForm
    inlines = [ImageInline]
    inlines_names = ['images']

    def get_success_url(self):
        return self.object.get_absolute_url()


class TripUpdateView(NamedFormsetsMixin, FormValidMessageMixin, UpdateWithInlinesView):
    model = Trip
    form_class = TripForm
    permission_required = 'orders.change_order'
    inlines = [ImageInline]
    inlines_names = ['images']

    def get_form_valid_message(self):
        return _("{0} updated!").format(self.object)


class TripDeleteView(PermissionRequiredMixin, DeleteMessageMixin, DeleteView):
    model = Trip
    success_url = reverse_lazy('trips:list')
    permission_required = 'trips.delete_trip'

    def get_success_message(self):
        return _("{0} deleted!").format(self.object)
