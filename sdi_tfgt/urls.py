"""sdi_tfgt URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from django.conf import settings
from django.conf.urls import include
from django.conf.urls.static import static
from django.contrib import admin
from django.urls import path
#Add URL maps to redirect the base URL to our application
from django.views.generic import RedirectView

#This is the admin site.
urlpatterns = [
    path('admin/', admin.site.urls),
]

#This is the site of the app, and also includes the urls of the databank app.
urlpatterns += [
    path('databank/', include('databank.urls')),
]

#We define the databank/ pattern as the main site.
urlpatterns += [
    path('', RedirectView.as_view(url='/databank/')),
]

#We define the root of the static and media files if DEBUG is true.
urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
#urlpatterns += static('',(r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root': settings.MEDIA_ROOT}))
urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)


#Add Django site authentication urls (for login, logout, password management)
urlpatterns += [
    path('accounts/', include('django.contrib.auth.urls')),
]
