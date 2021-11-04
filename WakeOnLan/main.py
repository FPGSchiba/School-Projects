from wakeonlan import send_magic_packet

send_magic_packet('B4:2E:99:A6:DC:FE', interface="192.168.1.168")

print("Sent")