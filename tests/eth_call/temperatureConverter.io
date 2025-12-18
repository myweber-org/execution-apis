
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convertCelsius := method(value,
    Map clone atPut("celsius", value) \
        atPut("fahrenheit", Celsius clone toFahrenheit(value)) \
        atPut("kelvin", Celsius clone toKelvin(value))
)

// Example usage
converter := TemperatureConverter clone
result := converter convertCelsius(25)
result keys foreach(key, writeln(key, ": ", result at(key)))