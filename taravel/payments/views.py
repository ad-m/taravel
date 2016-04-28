from cached_property import cached_property
from atom.views import DeleteMessageMixin
from braces.views import FormValidMessageMixin, SelectRelatedMixin, UserFormKwargsMixin
from django.contrib.auth.mixins import AccessMixin, PermissionRequiredMixin
from django.core.urlresolvers import reverse_lazy
from django.utils.translation import ugettext_lazy as _
from django.views.generic import CreateView, DeleteView, DetailView, ListView, UpdateView
from django.shortcuts import get_object_or_404

from ..orders.models import Order
from .forms import PaymentForm
from .models import Payment


class PaymentPermissionMixin(AccessMixin):
    pass


class PaymentListView(PaymentPermissionMixin, ListView):
    model = Payment
    paginate_by = 25

    def get_queryset(self, *args, **kwargs):
        qs = super(PaymentListView, self).get_queryset(*args, **kwargs)
        return qs


class PaymentDetailView(PaymentPermissionMixin, DetailView):
    model = Payment


class PaymentCreateView(UserFormKwargsMixin,
                        CreateView):
    model = Payment
    form_class = PaymentForm

    @cached_property
    def order(self):
        return get_object_or_404(Order, pk=self.kwargs['order_pk'])

    def get_form_kwargs(self, *args, **kwargs):
        kw = super(PaymentCreateView, self).get_form_kwargs(*args, **kwargs)
        kw['order'] = self.order
        return kw

    def get_context_data(self, **kwargs):
        context = super(PaymentCreateView, self).get_context_data(**kwargs)
        context['order'] = self.order
        return context

    def get_form_valid_message(self):
        return _("{0} created!").format(self.object)

    def get_success_url(self, *args, **kwargs):
        return self.object.order.get_absolute_url()


class PaymentUpdateView(PaymentPermissionMixin, PermissionRequiredMixin, SelectRelatedMixin,
                        UserFormKwargsMixin, FormValidMessageMixin,
                        UpdateView):
    model = Payment
    select_related = ['user']
    form_class = PaymentForm
    permission_required = 'payments.change_payment'

    # User can edit own payment always
    def has_permission(self, *args, **kwargs):
        if self.get_object().user != self.request.user:
            return super(PaymentUpdateView, self).has_permission(*args, **kwargs)
        return True

    def get_form_valid_message(self):
        return _("{0} updated!").format(self.object)

    def get_success_url(self, *args, **kwargs):
        return self.object.order.get_absolute_url()


class PaymentDeleteView(PaymentPermissionMixin, PermissionRequiredMixin, DeleteMessageMixin,
                        DeleteView):
    model = Payment
    success_url = reverse_lazy('trips:list')
    permission_required = 'payments.delete_payment'

    def get_success_message(self):
        return _("{0} deleted!").format(self.object)
