# I2C bus implementation with Real-Time Clock and Digital Temperature Sensor

## Notes

I2C bus is used for interfacing with a Real-Time Clock (RTC) and Digital Temperature Sensor. The PIC 18 microcontroller used merges the two I2C and SPI functions into the same pins. If both SPI and I2C are required, the use of software I2C will be necessary. 'I2C_Soft.c' provides the needed library function for the software I2C implementation. 

A digital thermometer, DS1621, with the I2C bus interface, are used to read the actual temperature. The routine 'char DS1621_Read_Temp()' is written to return the reading of the temperature. A function to initialize the DS1621 is also built, called 'void DS1621_Init()'. Both functions are defined in the 'I2C_Support.c' file. the temperature readings are printed in both degrees Celsius and Fahrenheit on TeraTerm.

A Real-Time-Clock (RTC) device called DS3231, along with the I2C, are used to fetch the time values and display them on the TeraTerm. A routine called 'void DS3231_Read_Time()' is created to fetch all the time values and display them on the TeraTerm. The 'Second' register is used to determine whether it has been updated with a new second to avoid displaying duplicated data. When a new time is displayed, the 'int DS1621_Read_Temperature()' routine is called to get the temperature and show it on the screen.

## Schematics

## License

    Copyright [2023] [Jacky Li]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
