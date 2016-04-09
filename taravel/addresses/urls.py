# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^(?P<username>[\w.@+-]+)$', views.AddressListView.as_view(),
        name="list"),
    url(r'^~create$', views.AddressCreateView.as_view(),
        name="create"),
    url(r'^(?P<username>[\w.@+-]+)/address-(?P<pk>\d+)$', views.AddressDetailView.as_view(),
        name="details"),
    url(r'^(?P<username>[\w.@+-]+)/address-(?P<pk>\d+)/~update$', views.AddressUpdateView.as_view(),
        name="update"),
    url(r'^(?P<username>[\w.@+-]+)/address-(?P<pk>\d+)/~delete$', views.AddressDeleteView.as_view(),
        name="delete"),
]
