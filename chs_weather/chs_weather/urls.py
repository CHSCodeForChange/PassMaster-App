"""chs_weather URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.2/topics/http/urls/
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
from django.contrib import admin
from django.urls import path

from rest_framework.authtoken import views as auth_views

from server.api import *


urlpatterns = [
    path('rest/login/', auth_views.obtain_auth_token, name='login'),
    path('rest/temp/<int:temp_id>/', TempView.as_view(), name='temp'),
    path('rest/room/<int:room_id>/', RoomView.as_view(), name='room'),
    path('rest/rooms/', RoomListView.as_view(), name='room-list'),
    path('admin/', admin.site.urls),
]
