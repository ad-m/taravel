# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-09 14:21
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('guests', '0003_auto_20160409_0039'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='guest',
            name='created',
        ),
        migrations.RemoveField(
            model_name='guest',
            name='modified',
        ),
    ]
