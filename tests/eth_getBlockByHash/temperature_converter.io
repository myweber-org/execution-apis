
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