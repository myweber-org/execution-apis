
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
Matrix := Object clone do(
    init := method(data,
        self data := data
        self rows := data size
        self cols := if(data size > 0, data at(0) size, 0)
    )

    dims := method(list(rows, cols))

    multiply := method(other,
        if(cols != other rows, 
            Exception raise("Matrix dimension mismatch: " .. 
                "(" .. rows .. "," .. cols .. ") * " ..
                "(" .. other rows .. "," .. other cols .. ")")
        )

        result := List clone
        for(i, 0, rows - 1,
            row := List clone
            for(j, 0, other cols - 1,
                sum := 0
                for(k, 0, cols - 1,
                    sum = sum + (data at(i) at(k) * other data at(k) at(j))
                )
                row append(sum)
            )
            result append(row)
        )
        Matrix clone init(result)
    )

    toString := method(
        "Matrix(" .. rows .. "x" .. cols .. ")"
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

try(
    c := a multiply(b)
    "Result: " println
    c data foreach(row, row println)
) catch(Exception,
    "Error: " .. error println
)