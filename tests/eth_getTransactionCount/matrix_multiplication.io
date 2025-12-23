
Matrix := Object clone do(
    dim := method(self size .. self at(0) size)
    
    mul := method(other,
        if(self at(0) size != other size,
            Exception raise("Matrix dimension mismatch: " .. 
                self at(0) size .. " != " .. other size)
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
                value asString alignRight(6) print
            )
            "" println
        )
    )
)

// Example usage
a := list(
    list(1, 2, 3),
    list(4, 5, 6)
)

b := list(
    list(7, 8),
    list(9, 10),
    list(11, 12)
)

result := Matrix clone setProto(a) mul(b)
"Matrix multiplication result:" println
result print