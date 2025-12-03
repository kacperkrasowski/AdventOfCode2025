path = @__DIR__
input_path = abspath(path, "..","input","input.txt")
input = readlines(input_path)
function is_valid(ID::String)
    len = length(ID)
    if isodd(len)
        return true
    else
        half = Int(len/2)
        if SubString(ID,1,half) == SubString(ID,half+1,len)
            return false
        else
            return true
        end
    end
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

            if !is_valid(string(i))
                count += i
            end
        end
    end
    return count
end

main()