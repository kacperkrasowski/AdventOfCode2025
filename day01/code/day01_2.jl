path = @__DIR__
input_path = abspath(path, "..","input","input.txt")
input = readlines(input_path)

position = 50
N = length(input)
count = 0

for i in 1:N
    dir = input[i][1]
    step = parse(Int, input[i][2:end])
    if dir == 'L' 
        if position - step <= 0 && position > 0
            over =  floor(Int, abs((position-step)/100)) + 1
        else
            over =  floor(Int, abs((position-step)/100))
            #println(position, " ", position-step," ",over)
        end
        position = mod(position-step, 100) 
    else
        over = floor(Int, abs((position+step)/100))
        position = mod(position+step, 100) 
    end
    count += over
end

println(count)