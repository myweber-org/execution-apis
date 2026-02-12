
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

Matrix set := method(i, j, value,
    data at(i-1) atPut(j-1, value)
    self
)

Matrix get := method(i, j,
    data at(i-1) at(j-1)
)

Matrix print := method(
    data foreach(row,
        row foreach(element, element print; " " print)
        "\n" print
    )
)

Matrix multiply := method(other,
    result := Matrix clone dim(x, other y)
    for(i, 1, x,
        for(j, 1, other y,
            sum := 0
            for(k, 1, y,
                sum = sum + get(i, k) * other get(k, j)
            )
            result set(i, j, sum)
        )
    )
    result
)

Matrix identity := method(n,
    m := Matrix clone dim(n, n)
    for(i, 1, n, m set(i, i, 1))
    m
)

Matrix transpose := method(
    result := Matrix clone dim(y, x)
    for(i, 1, x,
        for(j, 1, y,
            result set(j, i, get(i, j))
        )
    )
    result
)