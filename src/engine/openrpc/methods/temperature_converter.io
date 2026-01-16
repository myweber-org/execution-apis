
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
    )
    return nil
)

// Example usage
// result := TemperatureConverter convert(100, "C", "F")
// result println // Should print 212
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "CtoF", return CelsiusToFahrenheit(value))
        if(unit == "CtoK", return CelsiusToKelvin(value))
        Exception raise("Unsupported conversion unit: " .. unit)
    )
    
    displayConversions := method(celsiusValue,
        fahrenheit := CelsiusToFahrenheit(celsiusValue)
        kelvin := CelsiusToKelvin(celsiusValue)
        
        writeln("Celsius: ", celsiusValue, "°C")
        writeln("Fahrenheit: ", fahrenheit, "°F")
        writeln("Kelvin: ", kelvin, "K")
    )
)

// Example usage
if(isLaunchScript,
    converter := TemperatureConverter clone
    converter displayConversions(25)
    
    writeln("Single conversion 100°C to Fahrenheit: ", converter convert(100, "CtoF"))
)