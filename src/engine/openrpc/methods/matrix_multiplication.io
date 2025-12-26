Matrix := Object clone
Matrix dim := method(x, y,
    self data := List clone
    for(i, 1, y, self data append(List clone setSize(x, 0)))
    self
)

Matrix set := method(x, y, value,
    self data at(y) atPut(x, value)
    self
)

Matrix get := method(x, y,
    self data at(y) at(x)
)

Matrix rows := method(self data size)
Matrix cols := method(if(self data isEmpty, 0, self data at(0) size))

Matrix print := method(
    self data foreach(row,
        row foreach(elem, elem asString alignLeft(4, " ") print)
        "" println
    )
)

Matrix multiply := method(other,
    if(self cols != other rows, Exception raise("Incompatible dimensions"))
    result := Matrix clone dim(other cols, self rows)
    for(i, 0, self rows - 1,
        for(j, 0, other cols - 1,
            sum := 0
            for(k, 0, self cols - 1,
                sum = sum + (self get(k, i) * other get(j, k))
            )
            result set(j, i, sum)
        )
    )
    result
)

a := Matrix clone dim(2, 3)
a set(0, 0, 1) set(1, 0, 2)
a set(0, 1, 3) set(1, 1, 4)
a set(0, 2, 5) set(1, 2, 6)

b := Matrix clone dim(3, 2)
b set(0, 0, 7) set(1, 0, 8) set(2, 0, 9)
b set(0, 1, 10) set(1, 1, 11) set(2, 1, 12)

c := a multiply(b)
c print
Matrix := Object clone
Matrix dim := method(x, y,
    self data := List clone
    for(i, 1, y, self data append(List clone setSize(x, 0)))
    self
)

Matrix set := method(x, y, value,
    self data at(y) atPut(x, value)
    self
)

Matrix get := method(x, y,
    self data at(y) at(x)
)

Matrix rows := method(self data size)
Matrix cols := method(if(self data isEmpty, 0, self data first size))

Matrix print := method(
    self data foreach(row,
        row foreach(v, v asString alignLeft(4, " ") print)
        "" println
    )
)

Matrix multiply := method(other,
    if(self cols != other rows, Exception raise("Incompatible dimensions"))
    result := Matrix clone dim(other cols, self rows)
    for(i, 0, self rows - 1,
        for(j, 0, other cols - 1,
            sum := 0
            for(k, 0, self cols - 1,
                sum = sum + (self get(k, i) * other get(j, k))
            )
            result set(j, i, sum)
        )
    )
    result
)

a := Matrix clone dim(2, 3)
a set(0, 0, 1) set(1, 0, 2)
a set(0, 1, 3) set(1, 1, 4)
a set(0, 2, 5) set(1, 2, 6)

b := Matrix clone dim(3, 2)
b set(0, 0, 7) set(1, 0, 8) set(2, 0, 9)
b set(0, 1, 10) set(1, 1, 11) set(2, 1, 12)

c := a multiply(b)
c print