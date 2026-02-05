
Celsius := Object clone
Celsius toFahrenheit := method((self * 9/5) + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, unit,
    if(unit == "C",
        return list(value, value toFahrenheit, value toKelvin),
        if(unit == "F",
            celsius := (value - 32) * 5/9,
            return list(celsius, value, celsius toKelvin)
        ),
        if(unit == "K",
            celsius := value - 273.15,
            return list(celsius, celsius toFahrenheit, value)
        )
    )
)

// Example usage
converter := TemperatureConverter clone
result := converter convert(25, "C")
"25°C = #{result at(1)}°F = #{result at(2)}K" println
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
celsiusTemp := 25
fahrenheitTemp := CelsiusToFahrenheit(celsiusTemp)
convertedBack := FahrenheitToCelsius(fahrenheitTemp)

("Original Celsius: " .. celsiusTemp) println
("Converted to Fahrenheit: " .. fahrenheitTemp) println
("Converted back to Celsius: " .. convertedBack) println
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
/*
c := 100
c asCelsius toFahrenheit println // 212
c asCelsius toKelvin println    // 373.15

f := 212
f asFahrenheit toCelsius println // 100

k := 373.15
k asKelvin toCelsius println    // 100
*/