
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
        celsius := self fahrenheitToCelsius(fahrenheit)
        self celsiusToKelvin(celsius)
    )
    
    kelvinToCelsius := method(kelvin,
        kelvin - 273.15
    )
    
    kelvinToFahrenheit := method(kelvin,
        celsius := self kelvinToCelsius(kelvin)
        self celsiusToFahrenheit(celsius)
    )
    
    convert := method(value, fromUnit, toUnit,
        conversionMap := Map clone
        conversionMap atPut("C_F", self celsiusToFahrenheit)
        conversionMap atPut("C_K", self celsiusToKelvin)
        conversionMap atPut("F_C", self fahrenheitToCelsius)
        conversionMap atPut("F_K", self fahrenheitToKelvin)
        conversionMap atPut("K_C", self kelvinToCelsius)
        conversionMap atPut("K_F", self kelvinToFahrenheit)
        
        key := fromUnit .. "_" .. toUnit
        conversionMethod := conversionMap at(key)
        
        if(conversionMethod,
            conversionMethod call(value)
        ,
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
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "CtoF", return CelsiusToFahrenheit(value))
        if(unit == "CtoK", return CelsiusToKelvin(value))
        Exception raise("Unsupported conversion: " .. unit)
    )
    
    displayConversions := method(celsiusValue,
        fahrenheit := CelsiusToFahrenheit(celsiusValue)
        kelvin := CelsiusToKelvin(celsiusValue)
        writeln(celsiusValue, "°C = ", fahrenheit, "°F = ", kelvin, "K")
    )
)

// Example usage
converter := TemperatureConverter clone
converter displayConversions(25)
result := converter convert(100, "CtoF")
writeln("100°C in Fahrenheit: ", result)