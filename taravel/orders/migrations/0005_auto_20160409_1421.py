# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-09 14:21
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('orders', '0004_auto_20160409_1145'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='order',
            options={'permissions': (('mark_paid_order', 'Can mark paid order'), ('view_order', 'Can view order')), 'verbose_name': 'Order', 'verbose_name_plural': 'Orders'},
        ),
    ]
