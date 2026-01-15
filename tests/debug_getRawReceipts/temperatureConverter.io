
Celsius := Object clone
Celsius toFahrenheit := method(self * 9 / 5 + 32)
Celsius toKelvin := method(self + 273.15)

TemperatureConverter := Object clone
TemperatureConverter convert := method(value, unit,
    if(unit == "C",
        list("F" = value toFahrenheit, "K" = value toKelvin),
    if(unit == "F",
        celsius := (value - 32) * 5 / 9,
        list("C" = celsius, "K" = celsius toKelvin)),
    if(unit == "K",
        celsius := value - 273.15,
        list("C" = celsius, "F" = celsius toFahrenheit))
    )
)

// Example usage:
// converter := TemperatureConverter clone
// converter convert(100, "C") println  // Returns: list(F = 212, K = 373.15)
// converter convert(212, "F") println  // Returns: list(C = 100, K = 373.15)