## @color[#2e75e8](PowerShell IoT)
### Raspberry Pi, Grafana, InfluxDB and more

---

### Agenda

- Introduction.
- PowerShell IoT vs Windows IoT Core.
- The modules
- The Bosch BME280
- Roles.

---

### PowerShell IoT

> A PowerShell module for interacting with hardware sensors and devices using common protocols: GPIO, I2C & SPI.

---

### Windows IoT Core

> Windows 10 IoT Core is a version of Windows 10 that is optimized for smaller devices with or without a display that run on both ARM and x86/x64 devices.

---

### Microsoft.PowerShell.IoT

```powershell
Install-Module Microsoft.PowerShell.IoT
Get-Command -Module Microsoft.PowerShell.IoT
CommandType  Name             Version  Source
-----------  ----             -------  ------
Cmdlet       Get-GpioPin      0.1.1    Microsoft.PowerShell.IoT
Cmdlet       Get-I2CDevice    0.1.1    Microsoft.PowerShell.IoT
Cmdlet       Get-I2CRegister  0.1.1    Microsoft.PowerShell.IoT
Cmdlet       Send-SPIData     0.1.1    Microsoft.PowerShell.IoT
Cmdlet       Set-GpioPin      0.1.1    Microsoft.PowerShell.IoT
Cmdlet       Set-I2CRegister  0.1.1    Microsoft.PowerShell.IoT
```

---

### I2C

> I2C is a multi-device bus used to connect low-speed peripherals to computers and embedded systems.

---

### Bosch BME280

![bme280](https://www.digikey.com/-/media/Images/Product%20Highlights/B/BOSCH/BME280%20Integrated%20Environmental%20Units/bosch-bme280-200.jpg?ts=12c422e4-7dde-47c0-935e-30198d891346&la=en-US)

---

### Questions?

<br>

@fa[twitter](joeypiccola)

@fa[github](joeypiccola)

@fa[wrench](forge.puppet.com/jpi)

@fa[envelope-square](joey@joeypiccola.com)

@fa[bookmark](www.joeypiccola.com)

---