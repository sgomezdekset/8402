randomInt = (x) ->
  Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

randomValue = ->
  values = [2,2,2,4]
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

  if board[row][column] == 0
    board[row][column] = value
  else
    generateTile(board)

  console.log "generate tile"

showBoard = ->
  console.log "showBoard"
  
printArray = (array) ->
  console.log "-- Start --" 
  for row in array
    console.log row
  console.log "-- End --"

$ ->
  newBoard = buildBoard()
  generateTile(newBoard)
  generateTile(newBoard)
  printArray(newBoard)
  showBoard(newBoard)
