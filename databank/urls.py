from django.urls import path, re_path
from . import views

#The urls of the databank application.
urlpatterns = [
    path('', views.index, name='index'),
    path('dowload/', views.download, name='download'),
    path('getdata/', views.getdata, name='getdata'),
    # path('output/', views.printdata, name='printdata'),
    # path('query/', views.QueryList.as_view(), name='query'),
]
