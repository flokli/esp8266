# esp8266

Various notes about the ESP8266

## Models
 - 0018000902-ai03

## Serial console
Connections needed:
 - VCC to CH_PD to disable power down
 - GND with GPIO-15 (at least on models with this GPIO). This was needed to make the bootloader boot.
 - Now, connect VCC (3.3V!), GND, RX and TX as usual


Use `minicom -b 9600 -D /dev/tty--- -s` to get the serial console. Set Hardware Flow Control to "No".

Attention: always make sure mincom is not running while flashing firmware or uploading files. You can
temporary suspend it by pressing Ctrl-A,J.

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
 - AT+CIFSR (print devices ip)

## NodeMcu
Open-Source Firmware for the ESP8266 with Lua interpreter and lots of useful bindings

### Installation
 - Download the [esp-open-sdk](https://github.com/pfalcon/esp-open-sdk)
 - run `make`
 - as suggested, add the `xtensa-lx106-elf/bin` directory to your path (by exporting it for the current session or in a permament way, like bashrc
 - Download [nodemcu-firmware](https://github.com/nodemcu/nodemcu-firmware)
 - run `make`
 - Download [nodemcu-uploader](https://github.com/kmpm/nodemcu-uploader)

### Flashing the firmware
Flash the firmware via `make flash` (GPIO0 needs to be connected to GND for that)

### Uploading init.lua
Initially, the ESP8266 will simply display the lua prompt at the serial console.
If you want it to execute a given `init.lua` file on bootup,
use `nodemcu-uploader.py upload init.lua` to upload the file.


## Links
 - http://www.esp8266.com/wiki/doku.php?id=getting-started-with-the-esp8266
 - http://wiki.iteadstudio.com/ESP8266_Serial_WIFI_Module
 - https://nurdspace.nl/ESP8266
 - http://www.electrodragon.com/w/Wi07c
 - [https://docs.google.com/file/d/0B_ctPy0pJuW6LVdrSFctX1dmTzA/edit?pli=1](ESP8266 AT instruction set)
