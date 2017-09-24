include("printfs.jl")
include("engine.jl")

function evaluate(player::Int8, board::Array{Tuple{Int8,Int8},1})::Int8
    # this heuristic really sucks
    pl = length(legal_moves(player, board))
    opp = length(legal_moves(one(Int8) - player, board))
    return Int8(pl - opp)
end

function best_move(player::Int8, moves::Array{Any,1}, board::Array{Tuple{Int8,Int8},1}, depth::Int8)::Tuple{String,Int8}
    wins(one(Int8)-player,board) && return "", -100
    depth == 0 && return "", evaluate(player, board)
    length(moves) == 0 && return "", -100
    best_so_far = ("", -1000)
    for move in moves
        execute!(move[2],move[3],board)
        newMoves = legal_moves(one(Int8) - player, board)
        cont, val = best_move(player, newMoves, board, depth-one(Int8))
        execute!(move[2],move[3],board)
        val = -val
        if best_so_far[2] < val
            best_so_far = (move[1] * " " * cont, val)
        end
    end
    return best_so_far
end

function execute!(index::Int8, newIndex::Int8, board::Array{Tuple{Int8,Int8},1})
    # it is both do and undo function
    board[index], board[newIndex] = board[newIndex], board[index]
end

function wins(player::Int8, board::Array{Tuple{Int8,Int8},1})::Bool
    return board[13] == (player, 3) ? true :
                                      false
end

function turn(player::Int8, board::Array{Tuple{Int8,Int8},1})::Int8
    print_board(player, board)
    moves = legal_moves(player, board)
    println(best_move(player, moves, board, Int8(4)))
    print_moves(player, moves)
    move = get_move(moves)
    println("\33[2J")
    execute!(move[2], move[3], board)
    return wins(player, board) ? player :
                                 turn(one(Int8) - player, board)
end

function main()
    # must find better way to clean the console
    println("\33[2J")
    # must change data structure for board in future
    board::Array{Tuple{Int8,Int8},1} =
            [(1,5),(1,4),(1,3),(1,2),(1,1),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (2,0),(2,0),(2,0),(2,0),(2,0),
            (0,1),(0,2),(0,3),(0,4),(0,5)]
    winner = turn(zero(Int8), board)
    println("The $(winner == 0 ? "red" : "black") player wins!")
    print_board(zero(Int8), board)
end

main()
