
Matrix := Object clone do(
    dim := method(self data size, self data first size)
    
    init := method(data,
        self data := data
        self
    )
    
    print := method(
        self data foreach(row,
            row foreach(e, e asString alignLeft(4) print)
            "\n" print
        )
        self
    )
    
    multiply := method(other,
        if(self dim second != other dim first,
            Exception raise("Matrix dimension mismatch: " .. 
                self dim second asString .. " != " .. other dim first asString)
        )
        
        result := List clone
        self data foreach(i, row,
            newRow := List clone
            other dim second repeat(j,
                sum := 0
                row foreach(k, value,
                    sum = sum + value * other data at(k) at(j)
                )
                newRow append(sum)
            )
            result append(newRow)
        )
        Matrix clone init(result)
    )
)

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

"\nMatrix B:" println
b print

"\nResult of A * B:" println
c := a multiply(b)
c print

"\nTesting error handling:" println
d := Matrix clone init(list(list(1, 2)))
try(
    c multiply(d)
) catch(Exception,
    "Caught expected error: " .. Exception description println
)