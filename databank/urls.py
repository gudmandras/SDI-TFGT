from django.urls import path, re_path
from . import views

#The urls of the databank application.
urlpatterns = [
    path('', views.index, name='index'),
    path('getdata/', views.getdata, name='getdata'),
    path('position/', views.PositionList.as_view(), name='position'),
    path('download/', views.download, name='download'),
]

