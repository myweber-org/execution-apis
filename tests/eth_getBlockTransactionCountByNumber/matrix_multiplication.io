
Matrix := Object clone do(
    dim := method(self size .. self at(0) size)
    
    mul := method(other,
        if(self dim != other dim,
            Exception raise("Matrix dimensions do not match for multiplication")
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
)

// Example usage
a := list(list(1,2), list(3,4))
b := list(list(5,6), list(7,8))

matrixA := Matrix clone setProto(a)
matrixB := Matrix clone setProto(b)

result := try(
    matrixA mul(matrixB)
    writeln("Multiplication successful")
) catch(Exception,
    writeln("Error: ", error)
)