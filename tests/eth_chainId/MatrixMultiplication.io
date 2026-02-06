List2D := Object clone
List2D dim := method(x, y,
    self rows := List clone
    x repeat(
        row := List clone
        y repeat(row append(nil))
        rows append(row)
    )
    self
)
List2D set := method(x, y, value, rows at(x) atPut(y, value))
List2D get := method(x, y, rows at(x) at(y))
List2D rowsCount := method(rows size)
List2D colsCount := method(if(rows size > 0, rows at(0) size, 0))
List2D print := method(
    rows foreach(i, row,
        row foreach(j, cell,
            if(cell == nil, write("nil "), write(cell, " "))
        )
        writeln
    )
)
List2D multiply := method(other,
    if(self colsCount != other rowsCount,
        Exception raise("Matrix dimensions incompatible for multiplication")
    )
    result := List2D clone dim(self rowsCount, other colsCount)
    for(i, 0, self rowsCount - 1,
        for(j, 0, other colsCount - 1,
            sum := 0
            for(k, 0, self colsCount - 1,
                sum = sum + (self get(i, k) * other get(k, j))
            )
            result set(i, j, sum)
        )
    )
    result
)