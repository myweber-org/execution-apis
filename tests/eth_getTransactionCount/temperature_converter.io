
Celsius := Object clone do(
    toFahrenheit := method(self * 9 / 5 + 32)
    toKelvin := method(self + 273.15)
)

Fahrenheit := Object clone do(
    toCelsius := method((self - 32) * 5 / 9)
    toKelvin := method(self toCelsius + 273.15)
)

Kelvin := Object clone do(
    toCelsius := method(self - 273.15)
    toFahrenheit := method(self toCelsius * 9 / 5 + 32)
)

// Example usage (commented out in actual utility)
// 25 Celsius toFahrenheit println
// 98.6 Fahrenheit toCelsius println
// 300 Kelvin toFahrenheit println