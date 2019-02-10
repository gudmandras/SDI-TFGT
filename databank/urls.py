from django.urls import path, re_path
from . import views

# The urls of the databank application.
urlpatterns = [
    path('', views.index, name='index'),
    path('getdata/', views.getdata, name='getdata'),
    path('get_layers/', views.get_layers, name='get_layers'),
    path('download/', views.download, name='download'),
]
