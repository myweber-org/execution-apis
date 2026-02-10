
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
if(isLaunchScript,
    celsiusValue := 100
    fahrenheitValue := celsiusValue asCelsius toFahrenheit
    kelvinValue := celsiusValue asCelsius toKelvin
    
    celsiusValue println
    fahrenheitValue println
    kelvinValue println
)

// Helper methods for number conversion
Number asCelsius := method(Celsius clone setSlot("value", self))
Number asFahrenheit := method(Fahrenheit clone setSlot("value", self))
Number asKelvin := method(Kelvin clone setSlot("value", self))