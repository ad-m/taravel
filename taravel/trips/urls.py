# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.TripListView.as_view(),
        name="list"),
    url(r'^~create$', views.TripCreateView.as_view(),
        name="create"),
    url(r'^trip-(?P<slug>[\w-]+)$', views.TripDetailView.as_view(),
        name="details"),
    url(r'^trip-(?P<slug>[\w-]+)/~update$', views.TripUpdateView.as_view(),
        name="update"),
    url(r'^trip-(?P<slug>[\w-]+)/~delete$', views.TripDeleteView.as_view(),
        name="delete"),
]
