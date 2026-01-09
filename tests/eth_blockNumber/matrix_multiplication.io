
Matrix := Object clone
Matrix dim := method(x, y,
    self data := List clone
    for(i, 1, x,
        row := List clone
        for(j, 1, y, row append(0))
        data append(row)
    )
    self
)

Matrix set := method(x, y, value,
    data at(x) atPut(y, value)
    self
)

Matrix get := method(x, y,
    data at(x) at(y)
)

Matrix rows := method(data size)
Matrix cols := method(data at(0) size)

Matrix print := method(
    data foreach(i, row,
        row foreach(j, elem,
            elem asString alignLeft(4) print
        )
        "" println
    )
)

Matrix multiply := method(other,
    if(cols != other rows, return nil)
    result := Matrix clone dim(rows, other cols)
    for(i, 0, rows - 1,
        for(j, 0, other cols - 1,
            sum := 0
            for(k, 0, cols - 1,
                sum = sum + (get(i, k) * other get(k, j))
            )
            result set(i, j, sum)
        )
    )
    result
)

a := Matrix clone dim(2, 3)
a set(0, 0, 1) set(0, 1, 2) set(0, 2, 3)
a set(1, 0, 4) set(1, 1, 5) set(1, 2, 6)

b := Matrix clone dim(3, 2)
b set(0, 0, 7) set(0, 1, 8)
b set(1, 0, 9) set(1, 1, 10)
b set(2, 0, 11) set(2, 1, 12)

c := a multiply(b)
if(c, c print)