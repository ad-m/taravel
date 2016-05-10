from django.contrib import admin
from .models import Location, Country


class LocationInline(admin.StackedInline):
    '''
    Stacked Inline View for Location
    '''
    model = Location


class CountryAdmin(admin.ModelAdmin):
    '''
        Admin View for Country
    '''
    list_display = ('name',)
    list_filter = ('continent',)
    inlines = [
        LocationInline,
    ]
admin.site.register(Country, CountryAdmin)


class LocationAdmin(admin.ModelAdmin):
    list_display = ('name', 'country',)
    list_filter = ('country', 'country__continent')
    search_fields = ('name',)
admin.site.register(Location, LocationAdmin)
