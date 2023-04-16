# BLE Plant Measurer

> Work in progress

BLE sleepy device which allows measuring the water level via
the Capacitive Soil Moisture Sensor v2.0 and deliver
the results via BLE.

Source code uses Zephyr OS.

## Build

1. [Install Zephyr SDK](https://docs.zephyrproject.org/latest/develop/getting_started/index.html) on system or make available via `ZEPHYR_BASE=<path>` variable

2. Build cmake project

## Test

Run unit tests on the device:

tbd.

Run unit tests in native posix environment with emulated hardware:

tbd.

## Black Magic

Using the black magic to flash the board.

### Upload latest firmware <sup>[1]</sup>

After successful build upload the .elf file via gdb and connected Black Magic probe
(tested v2.1).

```

```

## WSL2 Development

> Requires wsl2 kernel of atleast `5.10.60.1` (check with `uname -a`)

Forward COM using usbipd-win + usbip.

On windows install [usbipd-win](https://github.com/dorssel/usbipd-win).
On linux install [usbipd](https://github.com/dorssel/usbipd-win/wiki/WSL-support#wsl-setup)

On debian:
```bash
sudo apt-get install usbip hwdata
```

On ubuntu:
```bash
sudo apt install linux-tools-virtual hwdata
sudo update-alternatives --install /usr/local/bin/usbip usbip `ls /usr/lib/linux-tools/*/usbip | tail -n1` 20
```

### Connect Serial Device

On windows find the device by running:

```powershell
usbipd.exe list
```

Connect the target usb device directly:

```powershell
# usbipd.exe wsl attach -b <busid>-<busid> -d <distribution>
usbipd.exe wsl attach -b 3-2 -d Debian -a
```

### Connect serial device

On linux the device should be available on `/dev/ttyACMx` and
can be connected with socat:

```bash
sudo socat - /dev/ttyACM0,raw,nonblock,echo=0,crnl,b115200
```

### Enable non root access to USB devices <sup>[2]</sup>

Download udev rules for usb drivers:

```bash
# download and create udev rules file
curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules | sudo tee /etc/udev/rules.d/99-platformio-udev.rules

# restart udev
sudo service udev restart
```

Add current user to access group for usb devices:

```bash
sudo usermod -a -G dialout $USER
sudo usermod -a -G plugdev $USER
```



references:

- [Flashing the nRF52840 with a blackmagic probe swd jtag programmer][1]
- [Platform IO: enable udev rules][2]

[1]: https://bluetun.serverbox.ch/2020/01/10/flashing-the-nrf52840-with-a-blackmagic-probe-swd-jtag-programmer/
[2]: https://docs.platformio.org/en/latest/core/installation/udev-rules.html#platformio-udev-rules
