from atom.ext.crispy_forms.forms import BaseTableFormSet
from atom.views import DeleteMessageMixin
from braces.views import FormValidMessageMixin, PrefetchRelatedMixin, SelectRelatedMixin, UserFormKwargsMixin
from cached_property import cached_property
from django.contrib.auth.mixins import PermissionRequiredMixin, LoginRequiredMixin
from django.core.urlresolvers import reverse_lazy
from django.shortcuts import get_object_or_404
from django.utils.translation import ugettext_lazy as _
from django.views.generic import DeleteView, DetailView, ListView
from django_filters.views import FilterView
from extra_views import CreateWithInlinesView, InlineFormSet, NamedFormsetsMixin, UpdateWithInlinesView

from ..guests.models import Guest
from ..trips.models import Trip
from .filters import OrderFilter
from .forms import OrderForm
from .models import Order


class OrderListView(ListView):
    model = Order
    paginate_by = 25

    def get_queryset(self, *args, **kwargs):
        qs = super(OrderListView, self).get_queryset(*args, **kwargs)
        qs = qs.filter(user=self.request.user).with_total_value()
        return qs


class OrderFilterView(FilterView):
    model = Order
    filterset_class = OrderFilter
    paginate_by = 25

    def get_queryset(self, *args, **kwargs):
        qs = super(OrderFilterView, self).get_queryset(*args, **kwargs)
        qs = qs.with_total_value()
        return qs


class OrderDetailView(SelectRelatedMixin, PrefetchRelatedMixin, DetailView):
    model = Order
    select_related = ['user', 'trip', 'payment', 'payment__cashier', 'payment__form']
    prefetch_related = ['guest_set', ]

    def get_queryset(self, *args, **kwargs):
        qs = super(OrderDetailView, self).get_queryset(*args, **kwargs)
        qs = qs.with_total_value()
        return qs


class GuestInline(InlineFormSet):
    model = Guest
    formset_class = BaseTableFormSet

    def get_factory_kwargs(self, *args, **kwargs):
        kw = super(GuestInline, self).get_factory_kwargs(*args, **kwargs)
        kw['min_num'] = 1
        kw['validate_min'] = True
        if hasattr(self.view, 'trip'):
            kw['max_num'] = self.view.trip.free_count
            kw['validate_max'] = True
        return kw


class OrderCreateView(NamedFormsetsMixin, LoginRequiredMixin, UserFormKwargsMixin,
                      CreateWithInlinesView):
    model = Order
    form_class = OrderForm
    inlines = [GuestInline]
    inlines_names = ['guest']

    @cached_property
    def trip(self):
        qs = Trip.objects.select_related('location', 'location__country').with_free_count()
        return get_object_or_404(qs,
                                 slug=self.kwargs['trip_slug'])

    def get_form_kwargs(self, *args, **kwargs):
        kw = super(OrderCreateView, self).get_form_kwargs(*args, **kwargs)
        kw['trip'] = self.trip
        return kw

    def get_context_data(self, **kwargs):
        context = super(OrderCreateView, self).get_context_data(**kwargs)
        context['trip'] = self.trip
        return context

    def get_success_url(self):
        return self.object.get_absolute_url()


class OrderUpdateView(NamedFormsetsMixin, SelectRelatedMixin, UserFormKwargsMixin,
                      FormValidMessageMixin, UpdateWithInlinesView):
    model = Order
    form_class = OrderForm
    permission_required = 'orders.change_order'
    select_related = ['trip__location__country', 'user']
    inlines = [GuestInline]
    inlines_names = ['guest']

    def get_form_valid_message(self):
        return _("{0} updated!").format(self.object)


class OrderDeleteView(PermissionRequiredMixin, DeleteMessageMixin, DeleteView):
    model = Order
    success_url = reverse_lazy('trips:list')
    permission_required = 'orders.delete_order'

    def get_success_message(self):
        return _("{0} deleted!").format(self.object)
