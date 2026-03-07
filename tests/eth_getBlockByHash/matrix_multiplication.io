
Matrix := Object clone
Matrix dim := method(self size)
Matrix print := method(self foreach(i, row, writeln(row join(" "))))

Matrix multiply := method(other,
    if(self dim != other dim,
        Exception raise("Matrix dimensions must match for multiplication")
    )
    result := List clone
    self foreach(i, row,
        newRow := List clone
        other foreach(j, col,
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

// Example usage
a := Matrix clone setProto(list(list(1,2), list(3,4)))
b := Matrix clone setProto(list(list(5,6), list(7,8)))

"Matrix A:" println
a print
"\nMatrix B:" println
b print
"\nResult of A * B:" println
c := a multiply(b)
c print