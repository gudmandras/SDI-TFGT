from django.contrib import admin

# Register your models here.
from .models import footprints

admin.site.register(footprints)

#PositionAdmin class for developer purposes.
# class PositionAdmin(admin.ModelAdmin):
#     list_display = ('id', 'max_x', 'min_x', 'max_y', 'min_y')
#
# admin.site.register(Position, PositionAdmin)