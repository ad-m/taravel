from atom.views import DeleteMessageMixin
from braces.views import FormValidMessageMixin, UserFormKwargsMixin, SelectRelatedMixin
from django.contrib.auth.mixins import AccessMixin, PermissionRequiredMixin
from django.core.urlresolvers import reverse, reverse_lazy
from django.utils.translation import ugettext_lazy as _
from django.views.generic import CreateView, DeleteView, DetailView, UpdateView
from django_filters.views import FilterView

from .filters import AddressFilter
from .forms import AddressForm
from .models import Address


class AddressPermissionMixin(AccessMixin):
    def dispatch(self, request, *args, **kwargs):
        if not (self.kwargs['username'] == self.request.user.username or  # user
                self.request.user.has_perm('addresses.view_address')):
            return self.handle_no_permission()
        return super(AddressPermissionMixin, self).dispatch(request, *args, **kwargs)


class AddressListView(AddressPermissionMixin, FilterView):
    filterset_class = AddressFilter
    model = Address
    paginate_by = 25

    def get_queryset(self, *args, **kwargs):
        qs = super(AddressListView, self).get_queryset(*args, **kwargs)
        qs = qs.filter(user__username=self.kwargs['username'])
        return qs


class AddressDetailView(AddressPermissionMixin, DetailView):
    model = Address


class AddressCreateView(UserFormKwargsMixin,
                        CreateView):
    model = Address
    form_class = AddressForm

    def get_form_valid_message(self):
        return _("{0} created!").format(self.object)

    def get_success_url(self, *args, **kwargs):
        return reverse('addresses:list', kwargs={'username': self.object.user.username})


class AddressUpdateView(AddressPermissionMixin, PermissionRequiredMixin, SelectRelatedMixin,
                        UserFormKwargsMixin, FormValidMessageMixin,
                        UpdateView):
    model = Address
    select_related = ['user']
    form_class = AddressForm
    permission_required = 'addresses.change_address'

    # User can edit own address always
    def has_permission(self, *args, **kwargs):
        if self.get_object().user != self.request.user:
            return super(AddressUpdateView, self).has_permission(*args, **kwargs)
        return True

    def get_form_valid_message(self):
        return _("{0} updated!").format(self.object)

    def get_success_url(self, *args, **kwargs):
        return reverse('addresses:list', kwargs={'username': self.kwargs['username']})


class AddressDeleteView(AddressPermissionMixin, PermissionRequiredMixin, DeleteMessageMixin,
                        DeleteView):
    model = Address
    success_url = reverse_lazy('trips:list')
    permission_required = 'addresses.delete_address'

    def get_success_message(self):
        return _("{0} deleted!").format(self.object)
