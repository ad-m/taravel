# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-28 23:02
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('guests', '0005_remove_guest_child'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='guest',
            name='value',
        ),
    ]