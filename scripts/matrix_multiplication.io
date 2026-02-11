
Matrix := Object clone
Matrix dim := method(self size, self at(0) size)
Matrix print := method(self foreach(i, row, row println))

Matrix multiply := method(other,
    if(self at(0) size != other size,
        Exception raise("Matrix dimension mismatch: cannot multiply " .. 
                       self dim asString .. " by " .. other dim asString)
    )
    
    result := List clone
    self foreach(i, row,
        newRow := List clone
        for(col, 0, other at(0) size - 1,
            sum := 0
            for(k, 0, row size - 1,
                sum = sum + row at(k) * other at(k) at(col)
            )
            newRow append(sum)
        )
        result append(newRow)
    )
    result
)

// Example usage
a := list(list(1,2,3), list(4,5,6))
b := list(list(7,8), list(9,10), list(11,12))

result := Matrix multiply(a, b)
"Result:" println
Matrix print(result)
Matrix := Object clone
Matrix dim := method(x, y,
    self data := List clone
    for(i, 1, y,
        row := List clone
        for(j, 1, x, row append(0))
        data append(row)
    )
    self
)

Matrix set := method(x, y, value,
    data at(y-1) atPut(x-1, value)
    self
)

Matrix get := method(x, y,
    data at(y-1) at(x-1)
)

Matrix print := method(
    data foreach(row,
        row foreach(value, write(value, " "))
        writeln
    )
)

Matrix multiply := method(other,
    result := Matrix clone dim(self data first size, other data size)
    for(i, 0, self data size - 1,
        for(j, 0, other data first size - 1,
            sum := 0
            for(k, 0, self data first size - 1,
                sum = sum + (self get(k+1, i+1) * other get(j+1, k+1))
            )
            result set(j+1, i+1, sum)
        )
    )
    result
)

a := Matrix clone dim(3, 2)
a set(1,1,1) set(2,1,2) set(3,1,3)
a set(1,2,4) set(2,2,5) set(3,2,6)

b := Matrix clone dim(2, 3)
b set(1,1,7) set(2,1,8)
b set(1,2,9) set(2,2,10)
b set(1,3,11) set(2,3,12)

writeln("Matrix A:")
a print
writeln("Matrix B:")
b print
writeln("Result A * B:")
c := a multiply(b)
c print