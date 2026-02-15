
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

main := method(
    "Enter Celsius temperature: " print
    input := File standardInput readLine asNumber
    fahrenheit := CelsiusToFahrenheit(input)
    ("Temperature in Fahrenheit: " .. fahrenheit) println
)

main()
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
// 25 Celsius toFahrenheit println
// 98.6 Fahrenheit toCelsius println
// 300 Kelvin toFahrenheit println
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
sampleTemperatures := list(-40, 0, 25, 100)
converted := convertTemperatures(sampleTemperatures)

converted foreach(tempMap,
    writeln(tempMap at("celsius"), "°C = ", 
            tempMap at("fahrenheit"), "°F = ",
            tempMap at("kelvin"), "K")
)