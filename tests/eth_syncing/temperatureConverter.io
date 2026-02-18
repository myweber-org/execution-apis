
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, unit,
    if(unit == "C",
        list("F" = value toFahrenheit, "K" = value toKelvin),
    if(unit == "F",
        celsiusValue := (value - 32) * 5 / 9,
        list("C" = celsiusValue, "K" = celsiusValue toKelvin)),
    if(unit == "K",
        celsiusValue := value - 273.15,
        list("C" = celsiusValue, "F" = celsiusValue toFahrenheit))
    )
)

// Example usage
converter := TemperatureConverter clone
result := converter convert(100, "C")
result println

result2 := converter convert(212, "F")
result2 println
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
        if(fromUnit == "C",
            if(toUnit == "F", return fromObj toFahrenheit(value))
            if(toUnit == "K", return fromObj toKelvin(value))
        )
        if(fromUnit == "F",
            if(toUnit == "C", return fromObj toCelsius(value))
            if(toUnit == "K", return fromObj toKelvin(value))
        )
        if(fromUnit == "K",
            if(toUnit == "C", return fromObj toCelsius(value))
            if(toUnit == "F", return fromObj toFahrenheit(value))
        )
        return value
    ,
        Exception raise("Invalid temperature unit")
    )
)