
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