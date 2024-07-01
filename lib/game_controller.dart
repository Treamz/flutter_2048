import 'dart:math';
import 'package:collection/collection.dart';

class GameController {
  late List<List<int>> board;

  GameController() {
    board = List.generate(4, (_) => List.generate(4, (_) => 0));
    addNewTile();
  }

  void addNewTile() {
    List<int> emptyTiles = [];

    for (int i = 0; i < 16; i++) {
      if (board[i ~/ 4][i % 4] == 0) {
        emptyTiles.add(i);
      }
    }

    // Add new random tyle
    if (emptyTiles.isNotEmpty) {
      int idx = Random().nextInt(emptyTiles.length);
      board[idx ~/ 4][idx % 4] = 2;
    }
  }

  bool moveLeft() {
    bool moved = false;

    for (int i = 0; i < 4; i++) {
      List<int> newRow = _mergeRow(row: board[i]);
      if (const ListEquality().equals(newRow, board[i]) == false) {
        moved = true;
        board[i] = newRow;
      }
    }
    if(moved) addNewTile();
    return moved;
  }

  bool moveRight() {
    bool moved = false;

    for (int i = 0; i < 4; i++) {
      List<int> newRow = _mergeRow(row: board[i].reversed.toList()).reversed.toList();
      if (const ListEquality().equals(newRow, board[i]) == false) {
        moved = true;
        board[i] = newRow;
      }
    }
    if(moved) addNewTile();
    return moved;
  }

  bool moveUp() {
    bool moved = false;
    board = _transpose(board);
    for (int i = 0; i < 4; i++) {
      List<int> newRow = _mergeRow(row: board[i]);
      if (const ListEquality().equals(newRow, board[i]) == false) {
        moved = true;
        board[i] = newRow;
      }
    }
    board = _transpose(board);
    if (moved) addNewTile();
    return moved;
  }

  List<List<int>> _transpose(List<List<int>> matrix) {
    List<List<int>> transposed = List.generate(4, (_) => List.generate(4, (_) => 0));
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        transposed[i][j] = matrix[j][i];
      }
    }
    return transposed;
  }

  bool moveDown() {
    bool moved = false;
    board = _transpose(board);
    for (int i = 0; i < 4; i++) {
      List<int> newRow = _mergeRow(row: board[i].reversed.toList()).reversed.toList();
      if (const ListEquality().equals(newRow, board[i]) == false) {
        moved = true;
        board[i] = newRow;
      }
    }
    board = _transpose(board);
    if (moved) addNewTile();
    return moved;
  }


  List<int> _mergeRow({required List<int> row}) {
    List<int> newRow = row.where((num) => num != 0).toList();

    for (int i = 0; i < newRow.length - 1; i++) {
      if (newRow[i] == newRow[i + 1]) {
        newRow[i] *= 2;
        newRow.removeAt(i + 1);
        newRow.add(0);
      }
    }

    while (newRow.length < 4) {
      newRow.add(0);
    }
    return newRow;
  }
}
