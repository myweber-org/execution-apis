
Matrix := Object clone
Matrix dim := method(x, y,
    self x := x
    self y := y
    self data := List clone
    for(i, 0, x-1,
        row := List clone
        for(j, 0, y-1, row append(0))
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
            element asString alignLeft(8, " ") print
        )
        "" println
    )
)

Matrix multiply := method(other,
    if(self y != other x, Exception raise("Incompatible dimensions"))
    result := Matrix clone dim(self x, other y)
    for(i, 0, self x-1,
        for(j, 0, other y-1,
            sum := 0
            for(k, 0, self y-1,
                sum = sum + (self get(i, k) * other get(k, j))
            )
            result set(i, j, sum)
        )
    )
    result
)

Matrix identity := method(n,
    m := Matrix clone dim(n, n)
    for(i, 0, n-1, m set(i, i, 1))
    m
)

Matrix transpose := method(
    result := Matrix clone dim(self y, self x)
    for(i, 0, self x-1,
        for(j, 0, self y-1,
            result set(j, i, self get(i, j))
        )
    )
    result
)