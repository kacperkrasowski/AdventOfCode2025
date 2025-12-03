path = @__DIR__
input_path = abspath(path, "..","input","input.txt")
input = readlines(input_path)

function check_dividers(len::Int)
    dividers = []
    if len == 1
        return dividers
    end

    for i in 2:floor(Int, len/2)
        if mod(len, i) == 0
            push!(dividers, i)
        end
    end
    push!(dividers, len)
    return dividers
end

function divide(ID::String, divider::Int)
    divided = []
    len = length(ID)
    step = Int(len/divider)
    for i in 0:divider-1
        push!(divided, ID[(i*step+1):((i+1)*step)])
    end
    return divided
end


function check_pattern(ID::String, divider::Int)
    divided = divide(ID, divider)
    if all(divided[1] .== divided)
        return true
    else 
        return false
    end
end

function is_invalid(ID::String)
    len = length(ID)
    dividers = check_dividers(len)
    for divider in dividers
        if check_pattern(ID, divider)
            return true
        end
    end
    return false
end

function data_reader(input)
    ranges = split(input[1], ",")
    pairs = []
    for range in ranges
        elements = split(range,"-")
        push!(pairs, parse.(Int, elements))
    end
    return pairs
end

function main()
    count = 0
    data = data_reader(input)
    for pair in data
        for i in [pair[1]:1:pair[2];]

            if is_invalid(string(i))
                count += i
            end
        end
    end
    return count
end

main()
