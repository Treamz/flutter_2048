import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2048/game_controller.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameController gameController;

  @override
  void initState() {
    super.initState();
    gameController = GameController();
  }

  void onVerticalDrag(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dy < 0) {
      setState(() {
        gameController.moveUp();
      });
    } else if (details.velocity.pixelsPerSecond.dy > 0) {
      setState(() {
        gameController.moveDown();
      });
    }
  }

  void onHorizontalDrag(DragEndDetails details) {
    if (details.velocity.pixelsPerSecond.dx < 0) {
      setState(() {
        gameController.moveLeft();
      });
    } else if (details.velocity.pixelsPerSecond.dx > 0) {
      setState(() {
        gameController.moveRight();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onVerticalDragEnd: onVerticalDrag,
          onHorizontalDragEnd: onHorizontalDrag,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: gameController.board.map((row) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: row.map((tile) {
                  return _ItemWidget(
                    title: tile,
                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final int title;

  _ItemWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      height: 48,
      width: 48,
      color: title == 0 ? Colors.grey : Colors.green,
      child: Center(
        child: title == 0 ? null : Text(title.toString()),
      ),
    );
  }
}
