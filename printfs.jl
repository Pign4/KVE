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

function print_board(board::Array{Tuple{Int8,Int8},1})
    paint(" "^21)
    println()
    for y in 1:5:21
        paint(" ")
        for x in y:y+4
            paint(board[x])
            paint(" ")
        end
        println()
        paint(" "^21)
        println()
    end
end

function print_moves(player::Int8, moves::Array{Any,1})
    printed::Array{Int8,1} = []
    color = player2color(player)
    for (n, move) in zip(UnitRange{Int8}(1:length(moves)), moves)
        if !(move[1] in printed)
            print("\n"*int2str(move[1])*": ")
            push!(printed, move[1])
        else
            print(", ")
        end
        print_with_color(Crayon(background = color), string(n))
        print(" "*move[2])
    end
    println()
end
