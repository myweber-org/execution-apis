
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
// result println
TemperatureConverter := Object clone do(
    celsiusToFahrenheit := method(celsius,
        (celsius * 9/5) + 32
    )
    
    celsiusToKelvin := method(celsius,
        celsius + 273.15
    )
    
    fahrenheitToCelsius := method(fahrenheit,
        (fahrenheit - 32) * 5/9
    )
    
    fahrenheitToKelvin := method(fahrenheit,
        celsiusToKelvin(fahrenheitToCelsius(fahrenheit))
    )
    
    kelvinToCelsius := method(kelvin,
        kelvin - 273.15
    )
    
    kelvinToFahrenheit := method(kelvin,
        celsiusToFahrenheit(kelvinToCelsius(kelvin))
    )
    
    convert := method(value, fromUnit, toUnit,
        conversionMap := Map clone do(
            atPut("C_F", celsiusToFahrenheit)
            atPut("C_K", celsiusToKelvin)
            atPut("F_C", fahrenheitToCelsius)
            atPut("F_K", fahrenheitToKelvin)
            atPut("K_C", kelvinToCelsius)
            atPut("K_F", kelvinToFahrenheit)
        )
        
        key := fromUnit .. "_" .. toUnit
        conversionMethod := conversionMap at(key)
        
        if(conversionMethod,
            conversionMethod call(value),
            Exception raise("Unsupported conversion from #{fromUnit} to #{toUnit}" interpolate)
        )
    )
)

// Example usage
converter := TemperatureConverter clone
"25°C to Fahrenheit: " print
converter celsiusToFahrenheit(25) println

"100°F to Celsius: " print
converter fahrenheitToCelsius(100) println

"0°C to Kelvin: " print
converter celsiusToKelvin(0) println

"Using convert method - 20°C to Kelvin: " print
converter convert(20, "C", "K") println