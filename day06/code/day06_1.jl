function empty_filter!(input)
    for line in input
        filter!(!isempty, line)
    end
end

function operation(column)
    len = length(column)
    numbers = parse.(Int, column[1:len-1])
    op = column[len]
    if op == "+"
        return sum(numbers)
    else
        return reduce(*, numbers)
    end
end

function main()
    path = @__DIR__
    input_path = abspath(path, "..","input","input.txt")
    input = split.(readlines(input_path), " ")
    empty_filter!(input)
    count = 0
    for i in 1:length(input[1])
        res = operation(getindex.(input, i))
        count += res
    end
    return count
end




main()