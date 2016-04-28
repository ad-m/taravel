# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.PaymentListView.as_view(),
        name="list"),
    url(r'^order-(?P<order_pk>\d+)$', views.PaymentCreateView.as_view(),
        name="create"),
    url(r'^payments-(?P<pk>\d+)$', views.PaymentDetailView.as_view(),
        name="details"),
    url(r'^payments-(?P<pk>\d+)/~update$', views.PaymentUpdateView.as_view(),
        name="update"),
    url(r'^payments-(?P<pk>\d+)/~delete$', views.PaymentDeleteView.as_view(),
        name="delete"),
]
