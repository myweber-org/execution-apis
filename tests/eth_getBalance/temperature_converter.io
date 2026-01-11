
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "C2F", return CelsiusToFahrenheit(value))
        if(unit == "C2K", return CelsiusToKelvin(value))
        Exception raise("Unsupported conversion unit: " .. unit)
    )
    
    runDemo := method(
        "Temperature Conversion Demo" println
        "25°C to Fahrenheit: " print
        convert(25, "C2F") println
        "0°C to Kelvin: " print
        convert(0, "C2K") println
    )
)

if(isLaunchScript,
    TemperatureConverter runDemo
)