# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-09 10:04
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0002_auto_20160408_2342'),
        ('orders', '0002_order_note'),
    ]

    operations = [
        migrations.AddField(
            model_name='order',
            name='address',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.CASCADE, to='users.Address', verbose_name='Billing address'),
            preserve_default=False,
        ),
    ]
