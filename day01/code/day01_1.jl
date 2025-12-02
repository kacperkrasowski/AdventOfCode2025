path = @__DIR__
input_path = abspath(path, "..","input","input.txt")
input = readlines(input_path)

position = 50
N = length(input)
count = 0

for i in 1:N
    dir = input[i][1]
    step = parse(Int, input[i][2:end])
    dir == 'L' ? position = mod(position-step,100) : position = mod(position+step,100)
    position == 0 ? count += 1 : count += 0
end

println(count)