
Celsius := Object clone do(
    toFahrenheit := method(self * 9/5 + 32)
    toKelvin := method(self + 273.15)
)

Fahrenheit := Object clone do(
    toCelsius := method((self - 32) * 5/9)
    toKelvin := method((self - 32) * 5/9 + 273.15)
)

Kelvin := Object clone do(
    toCelsius := method(self - 273.15)
    toFahrenheit := method((self - 273.15) * 9/5 + 32)
)

// Example usage (commented out in actual utility)
// 25 Celsius toFahrenheit println  // 77
// 100 Fahrenheit toCelsius println // 37.77777777777778
// 300 Kelvin toCelsius println     // 26.85