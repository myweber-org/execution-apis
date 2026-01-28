
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
"25°C is #{CelsiusToFahrenheit(25)}°F" println
"77°F is #{FahrenheitToCelsius(77)}°C" println
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

convertTemperatures := method(celsiusList,
    celsiusList map(celsius,
        Map clone atPut("celsius", celsius) \
               atPut("fahrenheit", CelsiusToFahrenheit(celsius)) \
               atPut("kelvin", CelsiusToKelvin(celsius))
    )
)

// Example usage
sampleTemperatures := list(-40, 0, 20, 37, 100)
results := convertTemperatures(sampleTemperatures)

results foreach(result,
    result at("celsius") print
    "°C = " print
    result at("fahrenheit") print
    "°F = " print
    result at("kelvin") print
    "K" println
)