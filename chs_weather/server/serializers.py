
from django.contrib.auth.models import User
from rest_framework import serializers

from .models import *


class TempSerializer(serializers.ModelSerializer):
    temp = serializers.FloatField(source='temp')
    room_name = serializers.CharField(source='room.name')
    datetime_stamp = serializers.DateTimeField(source='datetime_stamp')

    class Meta:
        model = TempModel
        fields = (
            'pk',
            'temp',
            'room',
            'datetime_stamp',
        )
        read_only_fields = (
            'pk',
        )


class RoomSerializer(serializers.ModelSerializer):
    temps = TempSerializer(many=True)
    name = serializers.CharField()
    department = serializers.CharField()

    class Meta:
        model = TempModel
        fields = (
            'pk',
            'temps',
            'name',
            'department'
        )
        read_only_fields = (
            'pk',
        )
