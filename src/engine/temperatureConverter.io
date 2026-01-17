
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method(self toCelsius + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method(self toCelsius * 9 / 5 + 32)

// Example usage (commented out for production)
// 25 Celsius toFahrenheit println  // Output: 77
// 100 Fahrenheit toCelsius println // Output: 37.77777777777778
// 300 Kelvin toFahrenheit println  // Output: 80.33
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
converter celsiusToFahrenheit(25) println

"100°F to Celsius: " print
converter fahrenheitToCelsius(100) println

"0°C to Kelvin: " print
converter celsiusToKelvin(0) println

"Using convert method - 300K to F: " print
converter convert(300, "K", "F") println