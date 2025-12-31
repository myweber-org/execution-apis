
Matrix := Object clone do(
    dim := method(self data size, self data at(0) size)
    
    init := method(data,
        self data := data
        self
    )
    
    print := method(
        self data foreach(row,
            row foreach(elem,
                (elem asString alignLeft(4)) print
            )
            "" println
        )
    )
    
    multiply := method(other,
        if(self dim second != other dim first,
            Exception raise("Matrix dimension mismatch: " ..
                self dim asString .. " vs " .. other dim asString)
        )
        
        result := List clone
        self data foreach(i, row,
            newRow := List clone
            other data at(0) size repeat(j,
                sum := 0
                row foreach(k, elem,
                    sum = sum + (elem * other data at(k) at(j))
                )
                newRow append(sum)
            )
            result append(newRow)
        )
        Matrix clone init(result)
    )
)

// Example usage
a := Matrix clone init(list(
    list(1, 2, 3),
    list(4, 5, 6)
))

b := Matrix clone init(list(
    list(7, 8),
    list(9, 10),
    list(11, 12)
))

"Matrix A:" println
a print

"Matrix B:" println
b print

"Result of A * B:" println
c := a multiply(b)
c print

// Test error case
d := Matrix clone init(list(list(1, 2)))
e := Matrix clone init(list(list(3, 4, 5)))

"Testing dimension mismatch:" println
try(
    d multiply(e)
) catch(Exception,
    "Caught error: " .. Exception description println
)