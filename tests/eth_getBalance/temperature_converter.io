
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
/*
celsiusValue := 100
fahrenheitValue := celsiusValue toFahrenheit
kelvinValue := celsiusValue toKelvin

("Celsius: " .. celsiusValue) println
("Fahrenheit: " .. fahrenheitValue) println
("Kelvin: " .. kelvinValue) println
*/
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

convertTemperatures := method(celsiusList,
    celsiusList map(celsius,
        Map clone atPut("celsius", celsius) \
               atPut("fahrenheit", CelsiusToFahrenheit(celsius)) \
               atPut("kelvin", CelsiusToKelvin(celsius))
    )
)

// Example usage (commented out in actual utility)
// temperatures := convertTemperatures(list(0, 20, 100))
// temperatures foreach(temp, 
//     writeln(temp at("celsius"), "°C = ", 
//             temp at("fahrenheit"), "°F = ",
//             temp at("kelvin"), "K")
// )