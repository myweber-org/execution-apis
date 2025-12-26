
Matrix := Object clone do(
    dim := method(self size .. "x" .. self at(0) size)
    
    multiply := method(other,
        if(self at(0) size != other size,
            Exception raise("Matrix dimension mismatch: " .. self dim .. " cannot multiply " .. other dim)
        )
        
        result := List clone
        self foreach(i, row,
            newRow := List clone
            other at(0) foreach(j, col,
                sum := 0
                row foreach(k, value,
                    sum = sum + (value * other at(k) at(j))
                )
                newRow append(sum)
            )
            result append(newRow)
        )
        return result
    )
    
    print := method(
        self foreach(row,
            row foreach(value,
                value asString alignLeft(6, " ") print
            )
            "" println
        )
    )
)

// Create two matrices
matrixA := list(
    list(1, 2, 3),
    list(4, 5, 6)
)

matrixB := list(
    list(7, 8),
    list(9, 10),
    list(11, 12)
)

// Perform multiplication
result := Matrix clone multiply(matrixA, matrixB)
"Result of matrix multiplication:" println
result print

// Test error case
matrixC := list(
    list(1, 2),
    list(3, 4)
)

try(
    errorResult := Matrix clone multiply(matrixA, matrixC)
) catch(e,
    "Error caught: " .. e error println
)
Matrix := Object clone do(
    dim := method(self size .. self at(0) size)
    
    mul := method(other,
        if(self at(0) size != other size,
            Exception raise("Matrix dimension mismatch: " .. 
                self at(0) size asString .. " != " .. other size asString)
        )
        
        result := List clone
        self foreach(i, row,
            newRow := List clone
            other at(0) foreach(j, col,
                sum := 0
                row foreach(k, value,
                    sum = sum + (value * other at(k) at(j))
                )
                newRow append(sum)
            )
            result append(newRow)
        )
        result
    )
    
    print := method(
        self foreach(row,
            row foreach(value,
                (value asString alignLeft(8, " ")) print
            )
            "" println
        )
    )
)

// Example usage
a := list(list(1,2,3), list(4,5,6))
b := list(list(7,8), list(9,10), list(11,12))

matrixA := Matrix clone setProto(a)
matrixB := Matrix clone setProto(b)

"Matrix A:" println
matrixA print

"Matrix B:" println
matrixB print

"Result of A * B:" println
result := matrixA mul(matrixB)
result print