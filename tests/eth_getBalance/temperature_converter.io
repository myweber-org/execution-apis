
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method((self - 32) * 5 / 9 + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method((self - 273.15) * 9 / 5 + 32)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, fromUnit, toUnit,
    unitMap := Map clone
    unitMap atPut("C", Celsius)
    unitMap atPut("F", Fahrenheit)
    unitMap atPut("K", Kelvin)
    
    fromObj := unitMap at(fromUnit)
    toObj := unitMap at(toUnit)
    
    if(fromObj and toObj,
        intermediate := doString("fromObj " .. toUnit .. " := method(self))") 
        result := doString("value asNumber " .. fromUnit .. " to" .. toUnit)
        return result
    ,
        return "Invalid units provided. Use C, F, or K."
    )
)

// Example usage
"25°C to Fahrenheit: " print
TemperatureConverter convert(25, "C", "F") println

"98.6°F to Celsius: " print
TemperatureConverter convert(98.6, "F", "C") println

"300K to Celsius: " print
TemperatureConverter convert(300, "K", "C") println