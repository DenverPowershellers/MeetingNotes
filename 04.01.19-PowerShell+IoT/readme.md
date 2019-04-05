# PowerShell + IoT

To view the GitPitch presentation visit: [GitPitch URL](https://gitpitch.com/DenverPowershellers/MeetingNotes/iot?p=04.01.19-PowerShell%2BIoT#/1).

## Example


### PowerShell
```powershell
# load modules
Import-Module -Name Microsoft.PowerShell.IoT
Import-Module /home/pi/PowerShell-IoT/Examples/Microsoft.PowerShell.IoT.BME280

# get device and data
$device = Get-BME280Device -Id 0x76
$data = Get-BME280Data -Device $device

# format data
$data_to_send = @{
    temperature = [math]::round(($data.Temperature * 1.8 + 32),1)
    pressure = $data.Pressure
    humidity = $data.Humidity
}

# post to influx api
$metrics_host = 'pi3'
$uri = 'http://10.0.50.2:8086/write?db=iot_metrics'

# post temperature
$body = "temperature,host=$metrics_host value=$($data_to_send.temperature)"
Invoke-WebRequest -Method Post -Uri $uri -Body $body

# post pressure
$body = "pressure,host=$metrics_host value=$($data_to_send.pressure)"
Invoke-WebRequest -Method Post -Uri $uri -Body $body

# post humidity
$body = "humidity,host=$metrics_host value=$($data_to_send.humidity)"
Invoke-WebRequest -Method Post -Uri $uri -Body $body
```

Scheduling in cron.
[`sudo crontab -e`]
```
* * * * * /usr/bin/pwsh -File /home/pi/pwsh/Get-BMEData.ps1
```

### Python
Example below used as an input for telegraf

```ini
[[inputs.exec]]
 command = "/home/pi/bme280.py"
 data_format = "json"
 name_suffix = "_pi0a_crawl_space"
```

```python
#!/usr/bin/env python3

import time
import json
import socket
import board
import busio
import adafruit_bmp280
import sys

i2c = busio.I2C(board.SCL, board.SDA)
# pass address 0x76 to override default 0x77
bmp280 = adafruit_bmp280.Adafruit_BMP280_I2C(i2c,address=0x76)

temp = "%0.2f" % ((bmp280.temperature * 1.8) + 32)

data = {"temperature": float(temp)}
json_data = json.dumps(data)
print (json_data)
```