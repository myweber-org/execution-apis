
Matrix := Object clone
Matrix dims := method(list(x, y))
Matrix data := method(list())

Matrix new := method(x, y,
    m := Matrix clone
    m dims = list(x, y)
    m data = list()
    for(i, 0, x-1,
        row := list()
        for(j, 0, y-1, row append(0))
        m data append(row)
    )
    m
)

Matrix set := method(x, y, value,
    self data at(x) atPut(y, value)
    self
)

Matrix get := method(x, y,
    self data at(x) at(y)
)

Matrix multiply := method(other,
    (self dims at(1) != other dims at(0)) ifTrue(
        Exception raise("Matrix dimensions incompatible for multiplication")
    )
    
    result := Matrix new(self dims at(0), other dims at(1))
    
    for(i, 0, self dims at(0)-1,
        for(j, 0, other dims at(1)-1,
            sum := 0
            for(k, 0, self dims at(1)-1,
                sum = sum + (self get(i, k) * other get(k, j))
            )
            result set(i, j, sum)
        )
    )
    
    result
)

Matrix print := method(
    self data foreach(row,
        row foreach(element,
            element asString print
            " " print
        )
        "" println
    )
)

a := Matrix new(2, 3)
a set(0, 0, 1) set(0, 1, 2) set(0, 2, 3)
a set(1, 0, 4) set(1, 1, 5) set(1, 2, 6)

b := Matrix new(3, 2)
b set(0, 0, 7) set(0, 1, 8)
b set(1, 0, 9) set(1, 1, 10)
b set(2, 0, 11) set(2, 1, 12)

result := a multiply(b)
result print