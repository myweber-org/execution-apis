
CelsiusToFahrenheit := method(celsius,
    (celsius * 9 / 5) + 32
)

main := method(
    "Enter temperature in Celsius: " print
    input := File standardInput readLine asNumber
    fahrenheit := CelsiusToFahrenheit(input)
    writeln(input, "°C = ", fahrenheit, "°F")
)

if(isLaunchScript, main)
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
f := c Celsius toFahrenheit
k := c Celsius toKelvin

("Celsius: " .. c .. " -> Fahrenheit: " .. f .. ", Kelvin: " .. k) println
*/