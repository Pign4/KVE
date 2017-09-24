using Crayons

function int2str(n::Int8)::String
    return n == 0 ? " " :
           n == 3 ? "K" : string(n)
end

function player2color(player::Int8)::Symbol
    return player == 0 ? :red :
           player == 1 ? :black : :white
end

function paint(space::String)
    print_with_color(Crayon(background = :blue), space)
end

function paint(square::Tuple{Int8,Int8})
    color = player2color(square[1])
    symbol = int2str(square[2])
    print_with_color(Crayon(background = color), " "*symbol*" ")
end

function print_board(player::Int8, board::Array{Tuple{Int8,Int8},1})
    paint(" "^21)
    println()
    for y in 1:5:21
        paint(" ")
        for x in y:y+4
            # if player == 1 the board is printed reversed
            paint(board[26*player + (1-2*player)*x])
            paint(" ")
        end
        println()
        paint(" "^21)
        println()
    end
end

function print_moves(player::Int8, moves::Array{Any,1})
    printed::Array{String,1} = []
    color = player2color(player)
    for (n, move) in enumerate(moves)
        if !(string(move[1][1]) in printed)
            print("\n"*string(move[1][1])*": ")
            push!(printed, string(move[1][1]))
        else
            print(", ")
        end
        print_with_color(Crayon(background = color), string(n))
        print(" "*move[1])
    end
    println()
end

function get_move(moves::Array{Any,1})::Tuple{String,Int8,Int8}
    l = length(moves)
    while true
        print("What's your move? ")
        n = get(tryparse(Int8, readline(STDIN)), Int8(0))
        1 <= n <= l && return moves[n]
        println("The move must be an integer between 1 and $(l)!")
    end
end
