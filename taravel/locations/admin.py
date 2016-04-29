from django.contrib import admin
from leaflet.admin import LeafletGeoAdmin

from .models import Country, Location


class LocationInline(admin.TabularInline):
    '''
    Stacked Inline View for Location
    '''
    model = Location


class CountryAdmin(admin.ModelAdmin):
    '''
        Admin View for Country
    '''
    list_display = ('name', 'continent')
    list_filter = ('continent',)
    inlines = [
        LocationInline,
    ]
admin.site.register(Country, CountryAdmin)


class LocationAdmin(LeafletGeoAdmin):
    list_display = ('name', 'country', 'position')
    list_filter = ('country', 'country__continent')
    search_fields = ('name',)
admin.site.register(Location, LocationAdmin)
