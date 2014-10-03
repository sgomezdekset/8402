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

move = (board, direction) ->
  for i in [0..3]
    if direction is 'right'
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      console.log row

getRow = (r, board) ->
  [board[r][0], board[r][1], board[r][2], board[r][3]]


mergeCells = (row, direction) ->
  if direction is 'right'
    for a in [3...0]
      for b in [a-1..0]
        if row[a] is 0
          break
        else if row[a] == row[b]
          row[a] *= 2
          row[b] = 0
          break
        else if row[b] isnt 0 then break
  row


collapseCells = (row, direction) ->
  row = row.filter (x) -> x isnt 0
  if direction is 'right'
    while row.length < 4
      row.unshift 0
  row

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      $(".r#{row}.c#{col} > div").html(board[row][col])
  console.log "showBoard"

printArray = (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log "-- End --"

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

      move(@board, direction)


































