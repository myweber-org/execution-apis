
Matrix := Object clone do(
    init := method(data,
        self data := data
        self rows := data size
        self cols := if(data size > 0, data at(0) size, 0)
    )

    dims := method(list(rows, cols))

    at := method(i, j, data at(i) at(j))

    multiply := method(other,
        if(cols != other rows,
            Exception raise("Matrix dimension mismatch: " .. 
                "(" .. rows .. "," .. cols .. ") * (" .. 
                other rows .. "," .. other cols .. ")")
        )

        result := List clone
        for(i, 0, rows - 1,
            row := List clone
            for(j, 0, other cols - 1,
                sum := 0
                for(k, 0, cols - 1,
                    sum = sum + (at(i, k) * other at(k, j))
                )
                row append(sum)
            )
            result append(row)
        )
        Matrix clone init(result)
    )

    asString := method(
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

result := a multiply(b)
writeln("Result: ", result)