# Network Observations

**Tool:** Wireshark
**Interface:** Host-Only network adapter with no internet routing

---

## Observation 1 - Kill Switch HTTP Request

Captured immediately upon execution:

GET / HTTP/1.1
Host: www.iuqerfsodp9ifjaposdfjhgosurijfaejfsdfhgosurijfaejfsdfhgosurijf.com
Connection: Keep-Alive

Redirected to 127.0.0.1 by the hosts file. Connection refused. Kill switch failed. Payload continued.

---

## Observation 2 - SMB Worm Scanning

High-volume TCP SYN packets to port 445 observed from the mssecsvc.exe service component.

Local subnet scan targeting sequential IPs across 192.168.56.0/24
Random IP scan targeting randomly generated external addresses
Rate approximately 50 to 100 SYN packets per second
No successful exploitation occurred in the isolated environment

This confirms the EternalBlue worm component actively scanning for unpatched Windows machines.

---

## Observation 3 - Tor C2 Connection Attempts

taskhsvc.exe attempted outbound connections to Tor relay IP addresses on ports 9001 and 9003.
All connection attempts timed out due to the host-only network restriction.
In a real infection this Tor tunnel would establish C2 communications.

---

## Network Summary

| Traffic Type | Port | Outcome in Lab |
|---|---|---|
| Kill switch HTTP GET | 80 | Connection refused by hosts file redirect |
| SMB worm scan local subnet | 445 | No response no live targets |
| SMB worm scan random IPs | 445 | No response no internet access |
| Tor C2 bootstrap | 9001 and 9003 | Connection timeout |
