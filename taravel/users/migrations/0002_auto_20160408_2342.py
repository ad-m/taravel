# -*- coding: utf-8 -*-
# Generated by Django 1.9.5 on 2016-04-08 23:42
from __future__ import unicode_literals

import django.core.validators
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('users', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Address',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100, verbose_name='Name')),
                ('street', models.CharField(max_length=50, verbose_name='Street')),
                ('street_number', models.CharField(max_length=10, verbose_name='Street number')),
                ('postcode', models.CharField(max_length=6, verbose_name='Postcode')),
                ('city', models.CharField(max_length=50, verbose_name='City')),
                ('taxpayer_id', models.IntegerField(help_text='Awarded by the government', verbose_name='Taxpayer ID')),
            ],
            options={
                'verbose_name': 'Address',
                'verbose_name_plural': 'Addresses',
            },
        ),
        migrations.AddField(
            model_name='user',
            name='discount',
            field=models.IntegerField(default=0, verbose_name='Discount'),
        ),
        migrations.AlterField(
            model_name='user',
            name='username',
            field=models.CharField(error_messages={'unique': 'A user with that username already exists.'}, help_text='Required. 30 characters or fewer. Letters, digits and @/./+/-/_ only.', max_length=30, unique=True, validators=[django.core.validators.RegexValidator('^[\\w.@+-]+$', 'Enter a valid username. This value may contain only letters, numbers and @/./+/-/_ characters.')], verbose_name='username'),
        ),
    ]
