
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

TemperatureConverter := Object clone do(
    convertCelsius := method(celsiusValue,
        result := Map clone
        result atPut("celsius", celsiusValue)
        result atPut("fahrenheit", Celsius clone setSlot("", celsiusValue) toFahrenheit)
        result atPut("kelvin", Celsius clone setSlot("", celsiusValue) toKelvin)
        result
    )
    
    printConversions := method(celsiusValue,
        conversions := self convertCelsius(celsiusValue)
        ("Celsius: " .. conversions at("celsius")) println
        ("Fahrenheit: " .. conversions at("fahrenheit")) println
        ("Kelvin: " .. conversions at("kelvin")) println
    )
)

// Example usage
converter := TemperatureConverter clone
converter printConversions(25)
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method(self toCelsius + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method(self toCelsius * 9 / 5 + 32)

// Example usage (commented out in actual utility)
// 25 Celsius toFahrenheit println  // Output: 77
// 100 Celsius toKelvin println     // Output: 373.15
// 32 Fahrenheit toCelsius println  // Output: 0
// 0 Kelvin toCelsius println       // Output: -273.15