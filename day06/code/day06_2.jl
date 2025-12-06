
function cephalopod_into_human(input)
    human = []
    sub_human = []
    len = length(input[1])
    for i in 1:len
        concat = reduce(*, getindex.(input, len+1-i))
        if '+' in concat 
            concat = filter(x->'0'<=x<='9', concat)
            push!(sub_human, parse(Int,concat))
            push!(sub_human, '+')
            push!(human, sub_human)
            sub_human = []
        elseif  '*' in concat
            concat = filter(x->'0'<=x<='9', concat)
            push!(sub_human, parse(Int,concat))
            push!(sub_human, '*')
            push!(human, sub_human)
            sub_human = []
        else 
            concat = strip(concat, ' ')
            if !isempty(concat)
                push!(sub_human, parse(Int,concat))
            end
        end
            
    end
    return human
end

function operation(column)
    len = length(column)
    numbers = column[1:len-1]
    op = column[len]
    if op == '+'
        return sum(numbers)
    else
        return reduce(*, numbers)
    end
end

function main()
    path = @__DIR__
    input_path = abspath(path, "..","input","input.txt")
    input = collect.(readlines(input_path))
    human = cephalopod_into_human(input)
    count = 0
    for math in human 
        res = operation(math)
        count += res
    end
    return count
end




main()