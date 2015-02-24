# esp8266

Various notes about the ESP8266

## Models
 - 0018000902-ai03

## Serial console
Connections needed:
 - VCC to CH_PD to disable power down
 - GND with GPIO-15 (at least on models with this GPIO). This was needed to make the bootloader boot.
 - Now, connect VCC (3.3V!), GND, RX and TX as usual


Use `minicom -b 115200 -D /dev/tty--- -s` to get the serial console. Set Hardware Flow Control to "No".

### Bootloader
The bootloader is set to a strange baud rate (74766 8N1 with 13,375µs).
This needs to be done manually by an [external script](https://gist.github.com/sentinelt/3f1a984533556cf890d9) after minicom is already configured and listening.

### Firmware
On the 0018000902-ai03, a baud rate of 9600 8N1 had to be used with firmware version 0.9.2.
After entering a command and the enter key, you need to additionally press Ctrl-J to add a LF character, which will make the ESP8266 execute the command.

### Common Commands
 - AT+GMR: output firmware revision number
 - AT+CWMODE=N (1=Station, 2=AP, 3=both)
 - AT+CWLAP (list available APs)
 - AT+CWJAP=<ssid>,<psk> (join AP. ssid and password can be double-quoted)
 - AT+CWLIF (print devices ip)

### References
 - http://www.esp8266.com/wiki/doku.php?id=getting-started-with-the-esp8266
 - http://wiki.iteadstudio.com/ESP8266_Serial_WIFI_Module
