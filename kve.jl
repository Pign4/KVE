include("printfs.jl")

function turn(player, board)
    printBoard(board)
    moves = possibleMoves()
    printBestMove(player, board, depth = 5)
    printPossibleMoves(moves)
    move = getMove()
    executeMove(move, board)
    if playerWins(player, board)
        return player
    else
        turn(1 - player, board)
    end
end

function main()
    board = [(1,1),(1,2),(1,3),(1,4),(1,5),
            (2,None),(2,None),(2,None),(2,None),(2,None),
            (2,None),(2,None),(2,None),(2,None),(2,None),
            (2,None),(2,None),(2,None),(2,None),(2,None),
            (0,1),(0,2),(0,3),(0,4),(0,5)]
    winner = turn(0, board)
end

main()
