
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convert := method(value, unitFrom, unitTo,
        if(unitFrom == "C" and unitTo == "F", return CelsiusToFahrenheit(value))
        if(unitFrom == "C" and unitTo == "K", return CelsiusToKelvin(value))
        if(unitFrom == "F" and unitTo == "C", return (value - 32) * 5 / 9)
        if(unitFrom == "F" and unitTo == "K", return CelsiusToKelvin((value - 32) * 5 / 9))
        if(unitFrom == "K" and unitTo == "C", return value - 273.15)
        if(unitFrom == "K" and unitTo == "F", return CelsiusToFahrenheit(value - 273.15))
        Exception raise("Unsupported conversion from #{unitFrom} to #{unitTo}" interpolate)
    )
    
    formatResult := method(value, fromUnit, toUnit, result,
        "#{value}°#{fromUnit} = #{result}°#{toUnit}" interpolate
    )
)

// Example usage
converter := TemperatureConverter clone
result := converter convert(100, "C", "F")
converter formatResult(100, "C", "F", result) println

result2 := converter convert(212, "F", "K")
converter formatResult(212, "F", "K", result2) println