from django.urls import path, re_path
from . import views

# The urls of the databank application.
urlpatterns = [
    path('', views.index, name='index'),
    path('get_data/', views.get_data, name='get_data'),
    path('get_zipped/', views.get_zipped, name='get_zipped'),
    # path('download/', views.download, name='download'),
]
