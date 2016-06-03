# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.LocationMapView.as_view()),
    url(r'^~create$', views.LocationCreateView.as_view(),
        name="create"),
    url(r'^location-(?P<pk>\w+)/~update$', views.LocationUpdateView.as_view(),
        name="update"),
    url(r'^location-(?P<pk>\w+)/~delete$', views.LocationDeleteView.as_view(),
        name="delete"),
    url(r'^~create-country$', views.CountryCreateView.as_view(),
        name="create_country"),
    url(r'^country-(?P<pk>\w+)/~update$', views.CountryUpdateView.as_view(),
        name="update"),
    url(r'^country-(?P<pk>\w+)/~delete$', views.CountryDeleteView.as_view(),
        name="delete"),
    url(r'^location/(?P<z>\d+)/(?P<x>\d+)/(?P<y>\d+).geojson$',
        views.LocationTiledGeoJSONLayerView.as_view(),
        name="data"),
    url(r'^location.geojson$', views.LocationMapLayer.as_view(), name='data'),
]
