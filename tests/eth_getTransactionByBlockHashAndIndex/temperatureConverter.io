
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method(self toCelsius + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method(self toCelsius * 9 / 5 + 32)

// Example usage
convertTemperature := method(value, unit,
    if(unit == "C",
        list("F" = value toFahrenheit, "K" = value toKelvin),
    if(unit == "F",
        list("C" = value toCelsius, "K" = value toKelvin),
    if(unit == "K",
        list("C" = value toCelsius, "F" = value toFahrenheit),
        "Invalid unit"
    )))
)

// Test conversions
testConversion := method(
    "25°C conversions:" println
    result := convertTemperature(25, "C")
    result foreach(key, value, ("  " .. key .. " = " .. value) println)
    
    "\n77°F conversions:" println
    result := convertTemperature(77, "F")
    result foreach(key, value, ("  " .. key .. " = " .. value) println)
    
    "\n300K conversions:" println
    result := convertTemperature(300, "K")
    result foreach(key, value, ("  " .. key .. " = " .. value) println)
)

testConversion
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
        self celsiusToKelvin(self fahrenheitToCelsius(fahrenheit))
    )
    
    kelvinToCelsius := method(kelvin,
        kelvin - 273.15
    )
    
    kelvinToFahrenheit := method(kelvin,
        self celsiusToFahrenheit(self kelvinToCelsius(kelvin))
    )
    
    convert := method(value, fromUnit, toUnit,
        conversionMap := Map clone do(
            atPut("C_F", block(celsiusToFahrenheit(value)))
            atPut("C_K", block(celsiusToKelvin(value)))
            atPut("F_C", block(fahrenheitToCelsius(value)))
            atPut("F_K", block(fahrenheitToKelvin(value)))
            atPut("K_C", block(kelvinToCelsius(value)))
            atPut("K_F", block(kelvinToFahrenheit(value)))
        )
        
        key := fromUnit .. "_" .. toUnit
        if(conversionMap hasKey(key),
            conversionMap at(key) call,
            Exception raise("Unsupported conversion from #{fromUnit} to #{toUnit}" interpolate)
        )
    )
)

// Example usage
converter := TemperatureConverter clone
"25°C to Fahrenheit: " print
converter convert(25, "C", "F") println

"100°F to Kelvin: " print
converter convert(100, "F", "K") println

"300K to Celsius: " print
converter convert(300, "K", "C") println