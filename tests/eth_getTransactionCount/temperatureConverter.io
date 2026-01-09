
Celsius := Object clone
Celsius toFahrenheit := method((self * 9/5) + 32)
Celsius toKelvin := method(self + 273.15)

Fahrenheit := Object clone
Fahrenheit toCelsius := method((self - 32) * 5/9)
Fahrenheit toKelvin := method(self toCelsius + 273.15)

Kelvin := Object clone
Kelvin toCelsius := method(self - 273.15)
Kelvin toFahrenheit := method(self toCelsius * 9/5 + 32)

// Example usage
/*
c := 100
f := c asCelsius toFahrenheit
k := c asCelsius toKelvin
write("100°C = ", f, "°F = ", k, "K\n")
*/

// Unit tests
assert := method(condition, message,
    if(condition not, Exception raise(message))
)

testConversion := method(
    // Celsius conversions
    assert(0 asCelsius toFahrenheit == 32, "0°C to °F failed")
    assert(100 asCelsius toFahrenheit == 212, "100°C to °F failed")
    assert(0 asCelsius toKelvin == 273.15, "0°C to K failed")
    
    // Fahrenheit conversions
    assert(32 asFahrenheit toCelsius == 0, "32°F to °C failed")
    assert(212 asFahrenheit toCelsius == 100, "212°F to °C failed")
    assert(32 asFahrenheit toKelvin == 273.15, "32°F to K failed")
    
    // Kelvin conversions
    assert(273.15 asKelvin toCelsius == 0, "273.15K to °C failed")
    assert(373.15 asKelvin toCelsius == 100, "373.15K to °C failed")
    assert(273.15 asKelvin toFahrenheit == 32, "273.15K to °F failed")
    
    "All tests passed" println
)

// Run tests if executed directly
if(isLaunchScript, testConversion)