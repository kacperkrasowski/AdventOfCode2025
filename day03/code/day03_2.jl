
function find_max_and_delete!(line::Vector{Char},l = 12::Int)
    vals = []
    for i in 1:l
        val = max(line[1:end-(12-i)]...,'0')
        first_loc = min(findall(x -> x == val, line)...)
        deleteat!(line, 1:1:first_loc)
        push!(vals,val)
    end
    return vals 
end

function main()
    path = @__DIR__
    input_path = abspath(path, "..","input","input.txt")
    input = readlines(input_path)
    data = collect.(input)
    count = 0
    for line in data 
        val = find_max_and_delete!(line)
        count += parse(Int, string(val...))
    end
    return count
end

main()

