
Matrix := Object clone do(
    multiply := method(other,
        if(self dim != 2 or other dim != 2,
            Exception raise("Both arguments must be 2D lists")
        )
        if(self at(0) size != other size,
            Exception raise("Matrix dimension mismatch: self columns != other rows")
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
    
    dim := method(
        depth := 0
        current := self
        while(current isKindOf(List),
            depth = depth + 1
            if(current size > 0, current = current at(0), break)
        )
        depth
    )
)

// Example usage
a := list(list(1,2,3), list(4,5,6))
b := list(list(7,8), list(9,10), list(11,12))

result := Matrix multiply(a, b)
result println