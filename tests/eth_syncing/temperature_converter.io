
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
// 25 Celsius toFahrenheit println // 77
// 100 Celsius toKelvin println    // 373.15
// 32 Fahrenheit toCelsius println // 0
// 0 Kelvin toCelsius println      // -273.15
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5 / 9)
Fahrenheit toKelvin := method((self - 32) * 5 / 9 + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method((self - 273.15) * 9 / 5 + 32)

// Example usage (commented out in actual utility)
// 25 Celsius toFahrenheit println  // Outputs 77
// 100 Fahrenheit toCelsius println // Outputs 37.77777777777778
// 300 Kelvin toFahrenheit println  // Outputs 80.33
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
c := 100
writeln(c, " Celsius = ", c toFahrenheit, " Fahrenheit")
writeln(c, " Celsius = ", c toKelvin, " Kelvin")

f := 212
writeln(f, " Fahrenheit = ", f toCelsius, " Celsius")
writeln(f, " Fahrenheit = ", f toKelvin, " Kelvin")

k := 373.15
writeln(k, " Kelvin = ", k toCelsius, " Celsius")
writeln(k, " Kelvin = ", k toFahrenheit, " Fahrenheit")
*/
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
"25°C in Fahrenheit: " print; 25 Celsius toFahrenheit println
"98.6°F in Celsius: " print; 98.6 Fahrenheit toCelsius println
"300K in Celsius: " print; 300 Kelvin toCelsius println
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

FahrenheitToCelsius := method(fahrenheit,
    (fahrenheit - 32) * 5/9
)

// Example usage
"25°C in Fahrenheit: " print
CelsiusToFahrenheit(25) println

"77°F in Celsius: " print
FahrenheitToCelsius(77) println