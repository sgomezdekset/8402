// Generated by CoffeeScript 1.8.0
(function() {
  var boardIsFull, buildBoard, collapseCells, generateTile, getRow, isGameOver, mergeCells, move, moveIsValid, noValidMoves, printArray, randomCellIndices, randomInt, randomValue, setRow, showBoard,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  randomInt = function(x) {
    return Math.floor(Math.random() * x);
  };

  randomCellIndices = function() {
    return [randomInt(4), randomInt(4)];
  };

  randomValue = function() {
    var values;
    values = [2, 2, 2, 4];
    return values[randomInt(4)];
  };

  buildBoard = function() {
    return [0, 1, 2, 3].map((function() {
      return [0, 1, 2, 3].map((function() {
        return 0;
      }));
    }));
  };

  generateTile = function(board) {
    var column, row, value, _ref;
    value = randomValue();
    _ref = randomCellIndices(), row = _ref[0], column = _ref[1];
    console.log("row: " + row + " column: " + column);
    if (board[row][column] === 0) {
      board[row][column] = value;
    } else {
      generateTile(board);
    }
    return console.log("generate tile");
  };

  move = function(board, direction) {
    var i, newBoard, row, _i;
    newBoard = buildBoard();
    for (i = _i = 0; _i <= 3; i = ++_i) {
      if (direction === 'right' || direction === 'left') {
        row = getRow(i, board);
        row = mergeCells(row, direction);
        row = collapseCells(row, direction);
        setRow(row, i, newBoard);
      }
    }
    return newBoard;
  };

  setRow = function(row, index, board) {
    return board[index] = row;
  };

  getRow = function(r, board) {
    return [board[r][0], board[r][1], board[r][2], board[r][3]];
  };

  mergeCells = function(row, direction) {
    var merge;
    merge = function(row) {
      var a, b, _i, _j, _ref;
      for (a = _i = 3; _i > 0; a = --_i) {
        for (b = _j = _ref = a - 1; _ref <= 0 ? _j <= 0 : _j >= 0; b = _ref <= 0 ? ++_j : --_j) {
          if (row[a] === 0) {
            break;
          } else if (row[a] === row[b]) {
            row[a] *= 2;
            row[b] = 0;
            break;
          } else if (row[b] !== 0) {
            break;
          }
        }
      }
      return row;
    };
    if (direction === 'right') {
      row = merge(row);
    } else if (direction === 'left') {
      row = merge(row.reverse()).reverse();
    }
    return row;
  };

  collapseCells = function(row, direction) {
    row = row.filter(function(x) {
      return x !== 0;
    });
    if (direction === 'right') {
      while (row.length < 4) {
        row.unshift(0);
      }
    } else if (direction === 'left') {
      while (row.length < 4) {
        row.push(0);
      }
    }
    return row;
  };

  moveIsValid = function(originalBoard, newBoard) {
    var col, row, _i, _j;
    for (row = _i = 0; _i <= 3; row = ++_i) {
      for (col = _j = 0; _j <= 3; col = ++_j) {
        if (originalBoard[row][col] !== newBoard[row][col]) {
          return true;
        }
      }
    }
    return false;
  };

  boardIsFull = function(board) {
    var row, _i, _len;
    for (_i = 0, _len = board.length; _i < _len; _i++) {
      row = board[_i];
      if (__indexOf.call(row, 0) >= 0) {
        return false;
      }
    }
    return true;
  };

  noValidMoves = function(board) {
    var direction, newBoard, _i, _len, _ref;
    _ref = ['right', 'left'];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      direction = _ref[_i];
      newBoard = move(board, direction);
      if (moveIsValid(board, newBoard)) {
        return false;
      }
      true;
    }
  };

  isGameOver = function(board) {
    return boardIsFull(board) && noValidMoves(board);
  };

  showBoard = function(board) {
    var col, row, _i, _j;
    for (row = _i = 0; _i <= 3; row = ++_i) {
      for (col = _j = 0; _j <= 3; col = ++_j) {
        if (board[row][col] === 0) {
          $(".r" + row + ".c" + col + " > div").html('');
        } else {
          $(".r" + row + ".c" + col + " > div").html(board[row][col]);
        }
      }
    }
    return console.log("showBoard");
  };

  printArray = function(array) {
    var row, _i, _len;
    console.log("-- Start --");
    for (_i = 0, _len = array.length; _i < _len; _i++) {
      row = array[_i];
      console.log(row);
    }
    return console.log("-- End --");
  };

  $(function() {
    this.board = buildBoard();
    generateTile(this.board);
    generateTile(this.board);
    showBoard(this.board);
    return $('body').keydown((function(_this) {
      return function(e) {
        var direction, key, keys, newBoard;
        key = e.which;
        keys = [37, 38, 39, 40];
        if (__indexOf.call(keys, key) >= 0) {
          e.preventDefault();
          direction = (function() {
            switch (key) {
              case 37:
                return 'left';
              case 38:
                return 'up';
              case 39:
                return 'right';
              case 40:
                return 'down';
            }
          })();
          console.log("direction: " + direction);
          newBoard = move(_this.board, direction);
          printArray(newBoard);
          if (moveIsValid(_this.board, newBoard)) {
            console.log("nice move!");
            _this.board = newBoard;
            generateTile(_this.board);
            showBoard(_this.board);
            if (isGameOver(_this.board)) {
              return console.log("YOU SUCK");
            }
          } else {
            return console.log("work on your moves again");
          }
        } else {

        }
      };
    })(this));
  });

}).call(this);

//# sourceMappingURL=main.js.map
