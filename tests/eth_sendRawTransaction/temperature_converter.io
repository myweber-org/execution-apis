
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
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method((self - 32) * 5 / 9 + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method((self - 273.15) * 9 / 5 + 32)

// Example usage
"25°C in Fahrenheit: " print; (25 Celsius toFahrenheit) println
"77°F in Celsius: " print; (77 Fahrenheit toCelsius) println
"300K in Celsius: " print; (300 Kelvin toCelsius) println