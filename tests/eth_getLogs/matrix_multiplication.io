
Matrix := Object clone do(
    dim := method(self size .. self at(0) size)
    
    mul := method(other,
        if(self dim != other dim,
            Exception raise("Matrix dimensions do not match for multiplication")
        )
        
        result := List clone
        self foreach(i, row,
            newRow := List clone
            other at(0) size repeat(j,
                sum := 0
                row foreach(k, value,
                    sum = sum + (value * other at(k) at(j))
                )
                newRow append(sum)
            )
            result append(newRow)
        )
        Matrix clone setProto(result)
    )
    
    print := method(
        self foreach(row,
            row foreach(value,
                value asString print
                " " print
            )
            "" println
        )
    )
)

// Example usage
a := Matrix clone setProto(list(list(1,2), list(3,4)))
b := Matrix clone setProto(list(list(5,6), list(7,8)))

"Matrix A:" println
a print

"Matrix B:" println
b print

"Result of A * B:" println
c := a mul(b)
c print