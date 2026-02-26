Matrix := Object clone do(
    multiply := method(other,
        if(self size == 0 or other size == 0, return list())
        if(self at(0) size != other size, Exception raise("Incompatible dimensions"))
        
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
        result
    )
    
    transpose := method(
        if(self size == 0, return list())
        result := List clone
        self at(0) size repeat(i,
            newRow := List clone
            self foreach(j, row,
                newRow append(row at(i))
            )
            result append(newRow)
        )
        result
    )
    
    prettyPrint := method(
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

"Matrix A:" println
Matrix clone setProto(a) prettyPrint

"Matrix B:" println
Matrix clone setProto(b) prettyPrint

"Transpose of A:" println
Matrix clone setProto(a) transpose prettyPrint

"A * B:" println
product := Matrix clone setProto(a) multiply(b)
Matrix clone setProto(product) prettyPrint