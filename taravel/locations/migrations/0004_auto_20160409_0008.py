# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-09 00:08
from __future__ import unicode_literals

import django.contrib.gis.db.models.fields
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('locations', '0003_location_country'),
    ]

    operations = [
        migrations.AlterField(
            model_name='location',
            name='position',
            field=django.contrib.gis.db.models.fields.PointField(null=True, srid=4326, verbose_name='Position'),
        ),
    ]
