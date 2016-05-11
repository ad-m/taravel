from atom.ext.crispy_forms.forms import BaseTableFormSet
from atom.views import DeleteMessageMixin
from braces.views import FormValidMessageMixin, PrefetchRelatedMixin, SelectRelatedMixin, UserFormKwargsMixin
from django.contrib.auth.mixins import PermissionRequiredMixin
from django.core.urlresolvers import reverse_lazy
from django.utils.translation import ugettext_lazy as _
from django.views.generic import DeleteView, DetailView, ListView
from django_filters.views import FilterView
from extra_views import CreateWithInlinesView, InlineFormSet, NamedFormsetsMixin, UpdateWithInlinesView
from cached_property import cached_property

from .filters import TripFilter
from .forms import SearchForm, TripForm
from .models import Image, Trip


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

    def get_queryset(self, *args, **kwargs):
        qs = super(TripDetailView, self).get_queryset(*args, **kwargs)
        if self.request.user.is_authenticated():
            qs = qs.with_user_orders(self.request.user)
        return qs


class ImageInline(InlineFormSet):
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


class SearchView(ListView):
    form_class = SearchForm
    template_name = 'trips/search.html'
    model = Trip
    paginate_by = 10

    @cached_property
    def form(self):
        return self.form_class(self.request.GET or {})

    def get_queryset(self, *args, **kwargs):
        qs = super(SearchView, self).get_queryset(*args, **kwargs)
        if self.form.is_valid():
            self.point = self.form.cleaned_data['point']
            return qs.nearest(self.point)
        return qs.none()

    def get_context_data(self, *args, **kwargs):
        context = super(SearchView, self).get_context_data(*args, **kwargs)
        context['form'] = self.form
        return context
