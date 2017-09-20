using Crayons
include("printfs.jl")

function all_moves()

end

function possible_moves(player, board)
    moves = []
    for piece in 1:5
        index = getindex(board, (player, piece))
        push!(moves, all_moves(player, index))
    end
end

function turn(player, board)
    print_board(player, board)
    moves = possible_moves(player, board)
    return 1
    # printBestMove(player, board, depth = 5)
    # printPossibleMoves(moves)
    # move = getMove()
    # executeMove(move, board)
    # if playerWins(player, board)
    #     return player
    # else
    #     turn(1 - player, board)
    # end
end

function main()
    board::Array{Tuple{Int8,Int8},1} =
            [(1,1),(1,2),(1,3),(1,4),(1,5),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (0,1),(0,2),(0,3),(0,4),(0,5)]
    winner = turn(zero(Int8), board)
    println("The $(winner == 0 ? "red" : "black") player wins!")
end

main()
