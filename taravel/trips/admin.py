from django.contrib import admin
from ..orders.admin import OrderInline
from .models import Trip


class TripAdmin(admin.ModelAdmin):
    list_display = ('name', 'location', 'base_price', 'space', 'guest_count', 'free_count')
    list_filter = ('name', 'location')
    inlines = [
        OrderInline,
    ]

    def guest_count(self, obj):
        return obj.guest_count

    def free_count(self, obj):
        return obj.free_count

    def get_queryset(self, *args, **kwargs):
        qs = super(TripAdmin, self).get_queryset(*args, **kwargs)
        return qs.with_guest_count().with_free_count()
admin.site.register(Trip, TripAdmin)
