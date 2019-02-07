# Generated by Django 2.0.4 on 2018-04-27 23:20

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Position',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('max_x', models.DecimalField(decimal_places=4, default=0, help_text='Max X coordinate', max_digits=6, verbose_name='Max X')),
                ('min_x', models.DecimalField(decimal_places=4, default=0, help_text='Min X coordinate', max_digits=6, verbose_name='Min X')),
                ('max_y', models.DecimalField(decimal_places=4, default=0, help_text='Max Y coordinate', max_digits=6, verbose_name='Max Y')),
                ('min_y', models.DecimalField(decimal_places=4, default=0, help_text='Min Y coordinate', max_digits=6, verbose_name='Min Y')),
            ],
        ),
    ]
