from atom.ext.crispy_forms.forms import BaseTableFormSet
from atom.views import ActionMessageMixin, ActionView, DeleteMessageMixin
from braces.views import FormValidMessageMixin, SelectRelatedMixin, UserFormKwargsMixin
from django.contrib.auth.mixins import PermissionRequiredMixin
from django.core.urlresolvers import reverse_lazy
from django.shortcuts import get_object_or_404
from django.utils.translation import ugettext_lazy as _
from django.views.generic import DeleteView, DetailView, ListView, UpdateView
from django_filters.views import FilterView
from extra_views import CreateWithInlinesView, InlineFormSet, NamedFormsetsMixin, UpdateWithInlinesView

from ..guests.models import Guest
from ..trips.models import Trip
from .filters import OrderFilter
from .forms import OrderForm, OrderPaidForm
from .models import Order


class OrderListView(ListView):
    model = Order
    paginate_by = 25

    def get_queryset(self, *args, **kwargs):
        qs = super(OrderListView, self).get_queryset(*args, **kwargs)
        qs = qs.filter(user=self.request.user)
        return qs


class OrderFilterView(FilterView):
    model = Order
    filterset_class = OrderFilter
    paginate_by = 25

    def get_queryset(self, *args, **kwargs):
        qs = super(OrderFilterView, self).get_queryset(*args, **kwargs)
        qs = qs.with_total_value()
        return qs


class OrderDetailView(SelectRelatedMixin, DetailView):
    model = Order
    select_related = ['user', 'trip']


class GuestInline(InlineFormSet):  # TODO: Calculate value
    model = Guest
    formset_class = BaseTableFormSet


class OrderCreateView(NamedFormsetsMixin, UserFormKwargsMixin, CreateWithInlinesView):
    model = Order
    form_class = OrderForm
    inlines = [GuestInline]
    inlines_names = ['guest']

    def get_form_kwargs(self, *args, **kwargs):
        kw = super(OrderCreateView, self).get_form_kwargs(*args, **kwargs)
        kw['trip'] = get_object_or_404(Trip, slug=self.kwargs['trip_slug'])
        return kw

    def get_success_url(self):
        return self.object.get_absolute_url()


class OrderUpdateView(NamedFormsetsMixin, UserFormKwargsMixin, FormValidMessageMixin,
                      UpdateWithInlinesView):
    model = Order
    form_class = OrderForm
    permission_required = 'orders.change_order'
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


class OrderPaidView(PermissionRequiredMixin, UpdateView):
    template_name_suffix = '_paid'
    model = Order
    form_class = OrderPaidForm
    permission_required = 'orders.mark_order_paid'

    def get_success_message(self):
        return _("{0} deleted!").format(self.object)
