
Matrix := Object clone
Matrix dim := method(x, y,
    self data := List clone
    for(i, 1, y,
        row := List clone
        for(j, 1, x, row append(0))
        data append(row)
    )
    self
)

Matrix set := method(x, y, value,
    data at(y-1) atPut(x-1, value)
    self
)

Matrix get := method(x, y,
    data at(y-1) at(x-1)
)

Matrix rows := method(data size)
Matrix cols := method(if(data size > 0, data at(0) size, 0))

Matrix print := method(
    data foreach(i, row,
        row foreach(j, elem,
            elem asString alignLeft(4) print
        )
        "" println
    )
    self
)

Matrix multiply := method(other,
    if(self cols != other rows, Exception raise("Incompatible dimensions"))
    result := Matrix clone dim(other cols, self rows)
    for(i, 1, self rows,
        for(j, 1, other cols,
            sum := 0
            for(k, 1, self cols,
                sum = sum + (self get(k, i) * other get(j, k))
            )
            result set(j, i, sum)
        )
    )
    result
)

a := Matrix clone dim(2, 3)
a set(1,1,1) set(2,1,2)
a set(1,2,3) set(2,2,4)
a set(1,3,5) set(2,3,6)

b := Matrix clone dim(3, 2)
b set(1,1,7) set(2,1,8) set(3,1,9)
b set(1,2,10) set(2,2,11) set(3,2,12)

"Matrix A:" println
a print
"Matrix B:" println
b print
"Result of A * B:" println
c := a multiply(b)
c print