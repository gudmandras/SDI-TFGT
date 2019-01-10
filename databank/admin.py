from django.contrib import admin

# Register your models here.
from .models import Query, Footprints
"""
username: levente
password: sditfgt
"""


# PositionAdmin class for developer purposes.
class QueryAdmin(admin.ModelAdmin):
    list_display = ('id', 'max_x', 'min_x', 'max_y', 'min_y')


admin.site.register(Query, QueryAdmin)
admin.site.register(Footprints)
