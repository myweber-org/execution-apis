
Matrix := Object clone do(
    dim := method(self size .. self at(0) size)
    
    * := method(other,
        if(self at(0) size != other size,
            Exception raise("Matrix dimension mismatch: cannot multiply #{self dim} by #{other dim}" interpolate)
        )
        
        result := List clone
        self foreach(i, row,
            newRow := List clone
            other at(0) foreach(j, col,
                sum := 0
                row foreach(k, value,
                    sum = sum + (value * other at(k) at(j))
                )
                newRow append(sum)
            )
            result append(newRow)
        )
        Matrix clone setProto(result)
    )
)

// Example usage
a := Matrix clone setProto(list(list(1,2,3), list(4,5,6)))
b := Matrix clone setProto(list(list(7,8), list(9,10), list(11,12)))

product := a * b
product println

// This will throw an error
c := Matrix clone setProto(list(list(1,2), list(3,4)))
try(a * c) catch(Exception, writeln("Caught: ", error))