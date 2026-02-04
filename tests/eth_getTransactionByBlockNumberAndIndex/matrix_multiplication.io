
Matrix := Object clone
Matrix dim := method(x, y,
    self x := x
    self y := y
    self data := List clone
    for(i, 1, x,
        row := List clone
        for(j, 1, y, row append(0))
        data append(row)
    )
)

Matrix set := method(dataList,
    self data = dataList map(row, row clone)
    self x = data size
    self y = data at(0) size
    self
)

Matrix print := method(
    data foreach(row,
        row foreach(element,
            element asString alignRight(4) print
        )
        "" println
    )
)

Matrix multiply := method(other,
    if(self y != other x,
        Exception raise("Matrix dimensions incompatible for multiplication")
    )
    
    result := Matrix clone dim(self x, other y)
    
    for(i, 0, self x - 1,
        for(j, 0, other y - 1,
            sum := 0
            for(k, 0, self y - 1,
                sum = sum + (self data at(i) at(k) * other data at(k) at(j))
            )
            result data at(i) atPut(j, sum)
        )
    )
    
    result
)

// Example usage
a := Matrix clone set(list(list(1,2,3), list(4,5,6)))
b := Matrix clone set(list(list(7,8), list(9,10), list(11,12)))

"Matrix A:" println
a print

"Matrix B:" println
b print

"Result of A * B:" println
c := a multiply(b)
c print