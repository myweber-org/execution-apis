
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
        conversionMap atPut("C_F", block(self celsiusToFahrenheit(value)))
        conversionMap atPut("C_K", block(self celsiusToKelvin(value)))
        conversionMap atPut("F_C", block(self fahrenheitToCelsius(value)))
        conversionMap atPut("F_K", block(self fahrenheitToKelvin(value)))
        conversionMap atPut("K_C", block(self kelvinToCelsius(value)))
        conversionMap atPut("K_F", block(self kelvinToFahrenheit(value)))
        
        key := fromUnit asUppercase .. "_" .. toUnit asUppercase
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

"98.6°F to Celsius: " print
converter convert(98.6, "F", "C") println

"0°C to Kelvin: " print
converter convert(0, "C", "K") println