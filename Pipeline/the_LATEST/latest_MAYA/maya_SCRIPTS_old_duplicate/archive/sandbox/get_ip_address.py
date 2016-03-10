import socket
if socket.gethostbyname(socket.gethostname()).startswith('10.7'):
    print True
else:
    print False