
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

Matrix set := method(x, y, value,
    data at(x) atPut(y, value)
)

Matrix get := method(x, y,
    data at(x) at(y)
)

Matrix print := method(
    data foreach(i, row,
        row foreach(j, element,
            element print
            " " print
        )
        "" println
    )
)

Matrix multiply := method(other,
    result := Matrix clone dim(x, other y)
    for(i, 0, x - 1,
        for(j, 0, other y - 1,
            sum := 0
            for(k, 0, y - 1,
                sum = sum + (get(i, k) * other get(k, j))
            )
            result set(i, j, sum)
        )
    )
    result
)

a := Matrix clone dim(3, 3)
a set(0, 0, 1) a set(0, 1, 2) a set(0, 2, 3)
a set(1, 0, 4) a set(1, 1, 5) a set(1, 2, 6)
a set(2, 0, 7) a set(2, 1, 8) a set(2, 2, 9)

b := Matrix clone dim(3, 3)
b set(0, 0, 9) b set(0, 1, 8) b set(0, 2, 7)
b set(1, 0, 6) b set(1, 1, 5) b set(1, 2, 4)
b set(2, 0, 3) b set(2, 1, 2) b set(2, 2, 1)

c := a multiply(b)
c print