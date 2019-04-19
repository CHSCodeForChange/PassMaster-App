from rest_framework import generics, authentication, permissions

from .serializers import *


class TempView(generics.RetrieveUpdateAPIView):
    authentication_classes = (authentication.TokenAuthentication,)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = TempSerializer


class RoomView(generics.RetrieveUpdateAPIView):
    authentication_classes = (authentication.TokenAuthentication,)
    permission_classes = (permissions.IsAuthenticated,)
    serializer_class = RoomSerializer


class RoomListView(generics.ListAPIView):
    authentication_classes = ()
    permission_classes = ()
    queryset = RoomModel.objects.all()
    serializer_class = RoomSerializer
