
CelsiusToFahrenheit := method(celsius, celsius * 9 / 5 + 32)
CelsiusToKelvin := method(celsius, celsius + 273.15)

TemperatureConverter := Object clone do(
    convert := method(value, unit,
        if(unit == "CtoF", return CelsiusToFahrenheit(value))
        if(unit == "CtoK", return CelsiusToKelvin(value))
        Exception raise("Unsupported conversion unit: " .. unit)
    )
    
    displayConversions := method(celsiusValue,
        fahrenheit := CelsiusToFahrenheit(celsiusValue)
        kelvin := CelsiusToKelvin(celsiusValue)
        
        "Celsius: " .. celsiusValue .. " -> Fahrenheit: " .. fahrenheit .. ", Kelvin: " .. kelvin println
    )
)

// Example usage
converter := TemperatureConverter clone
converter displayConversions(25)
converter displayConversions(0)
converter displayConversions(100)
CelsiusToFahrenheit := method(celsius,
    (celsius * 9/5) + 32
)

main := method(
    "Enter Celsius temperature: " print
    input := File standardInput readLine asNumber
    fahrenheit := CelsiusToFahrenheit(input)
    ("Temperature in Fahrenheit: " .. fahrenheit) println
)

main()
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

// Example usage
/*
celsiusValue := 25
fahrenheitValue := celsiusValue asNumber Celsius toFahrenheit
kelvinValue := celsiusValue asNumber Celsius toKelvin

("Celsius: " .. celsiusValue) println
("Fahrenheit: " .. fahrenheitValue) println
("Kelvin: " .. kelvinValue) println
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
/*
c := 100
c asCelsius toFahrenheit println  // 212
c asCelsius toKelvin println      // 373.15

f := 212
f asFahrenheit toCelsius println  // 100
f asFahrenheit toKelvin println   // 373.15

k := 373.15
k asKelvin toCelsius println      // 100
k asKelvin toFahrenheit println   // 212
*/

Number asCelsius := method(Celsius clone setSlot("value", self))
Number asFahrenheit := method(Fahrenheit clone setSlot("value", self))
Number asKelvin := method(Kelvin clone setSlot("value", self))

// Helper method for pretty printing
Object printTemperature := method(
    "Temperature: " print
    self value print
    " " print
    self type print
    "\n" print
)