
function find_max_and_delete!(line::Vector{Char})
    val = max(line...)
    first_loc = min(findall(x -> x == val, line)...)
    if first_loc == length(line)
        deleteat!(line, first_loc)
    else
        deleteat!(line, 1:1:first_loc)
    end
    return (val, first_loc)
end

function main()
    path = @__DIR__
    input_path = abspath(path, "..","input","input.txt")
    input = readlines(input_path)
    data = collect.(input)
    count = 0
    for line in data 
        len = length(line)
        (val1,pos1) = find_max_and_delete!(line)
        (val2,pos2) = find_max_and_delete!(line)
        if pos1 == len
            val = val2*val1
        else
            val = val1 * val2
        end
        println(val)
        count += parse(Int, val)
    end
    return count
end

main()

