from django.db import models


class TempModel(models.Model):
    temp = models.FloatField()
    datetime_stamp = models.DateTimeField()
    room = models.ForeignKey(
        'RoomModel',
        null=True,
        blank=True,
        on_delete=models.CASCADE
    )


class RoomModel(models.Model):
    temps = models.ForeignKey(
        'TempModel',
        null=True,
        blank=True,
        on_delete=models.CASCADE
    )
    name = models.CharField(max_length=100, null=True, blank=True)
    department = models.CharField(max_length=100, null=True, blank=True)

