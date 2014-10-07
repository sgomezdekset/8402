randomInt = (x) ->
  Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

randomValue = ->
  values = [2000, 2000, 2000,4000]
  values[randomInt(4)]

buildBoard = ->
#  board = []
# for row in [0..3]
#    board[row] = []
#    for column in [0..3]
#      board[row][column] = 0
#  board
  [0..3].map (-> [0..3].map (-> 0))

 #buildboard -> on set up deux facons de faire 4x4 (=16) espace avec 0 comme valeur
     
generateTile = (board) ->
  value = randomValue()
  [row, column] = randomCellIndices()
  console.log "row: #{row} column: #{column}"
  
  if board[row][column] is 0
    board[row][column] = value
  else
    generateTile(board)

  console.log "generate tile"

move = (board, direction) ->
  newBoard = buildBoard()

  for i in [0..3]
    if direction in ['right', 'left']
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      setRow(row, i, newBoard)
    else if direction in ['down', 'up']
      column = getColumn(i, board)
      column = mergeCells(column, direction)
      column = collapseCells(column, direction)
      console.log "column: ", column
      setColumn(column, i, newBoard)

  newBoard

setRow = (row, index, board) ->
  board[index] = row

getRow = (r, board) ->
  [board[r][0], board[r][1], board[r][2], board[r][3]]

getColumn = (c, board) ->
  [board[0][c],board[1][c], board[2][c], board[3][c]]

setColumn = (column, index, board) ->
  for i in [0..3]
    board[i][index] = column[i]


mergeCells = (cells, direction) ->
  
  merge = (cells) ->
    for a in [3...0]
      for b in [a-1..0]
        if cells[a] is 0
          break
        else if cells[a] == cells[b]
          cells[a] *= 2
          cells[b] = 0
          $(".coin_audio").trigger("play")
          break
        else if cells[b] isnt 0 then break
    cells

  if direction in ['right', 'down']
    cells = merge(cells)
  else if direction in ['left','up']
    cells = merge(cells.reverse()).reverse()

    cells

collapseCells = (cells, direction) ->
  cells = cells.filter (x) -> x isnt 0
  if direction in ['right', 'down']
    while cells.length < 4
      cells.unshift 0
  else if direction in ['left','up']
    while cells.length < 4
      cells.push 0
  cells

moveIsValid = (originalBoard, newBoard) ->
  for row in [0..3]
    for col in [0..3]
      if originalBoard[row][col] isnt newBoard[row][col]
        return true
  false

boardIsFull = (board)->
  for row in board
    if 0 in row
      return false
  true

noValidMoves = (board) ->
  for direction in ['right', 'left','up','down']
    newBoard = move(board, direction)
    console.log newBoard
    if moveIsValid(board, newBoard)
      return false
    true

isGameOver = (board) ->
  boardIsFull(board) and noValidMoves(board)
  
showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      for value in [2000, 4000, 8000, 16000, 32000, 64000, 128000, 256000, 512000, 1024000, 2048000]
        $(".r#{row}.c#{col}").removeClass('val-' + value)
      if board[row][col] == 0
        $(".r#{row}.c#{col} > div").html('')
      else
        $(".r#{row}.c#{col}").addClass('val-' + board[row][col])
        $(".r#{row}.c#{col} > div").html('$' + board[row][col])
  console.log "showBoard"

printArray = (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log "-- End --"

bonus = (board) ->
  for row in [0..3]
    for col in [0..3]
      max = Math.max(board[row][col])

$ ->
  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  showBoard(@board)

  $('body').keydown (e) =>
    key = e.which
    keys = [37..40]

    if key in keys
      e.preventDefault()
      direction = switch key
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'
      console.log "direction: #{direction}"

      newBoard = move(@board, direction)
      printArray newBoard

      if moveIsValid(@board, newBoard)
        console.log "nice move!"
        @board = newBoard
        
        bonus(newBoard)

        generateTile(@board)

        showBoard(@board)

        if isGameOver(@board)
          alert "YOU SUCK"

      else
        console.log "work on your moves again"
    else
  


































