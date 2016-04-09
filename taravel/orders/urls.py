# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.OrderListView.as_view(),
        name="list"),
    url(r'^~all$', views.OrderFilterView.as_view(),
        name="full_list"),
    url(r'^~create-(?P<trip_slug>[\w-]+)$', views.OrderCreateView.as_view(),
        name="create"),
    url(r'^order-(?P<pk>\w+)$', views.OrderDetailView.as_view(),
        name="details"),
    url(r'^order-(?P<pk>\w+)/~update$', views.OrderUpdateView.as_view(),
        name="update"),
    url(r'^order-(?P<pk>\d+)/~delete$', views.OrderDeleteView.as_view(),
        name="delete"),
    url(r'^order-(?P<pk>\d+)/~paid$', views.OrderPaidView.as_view(),
        name="paid"),
]
