
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:maze_gen/cell.dart';

class Maze extends StatefulWidget {
  const Maze({super.key});

  @override
  State<Maze> createState() => _MazeState();
}

final int mazeSize = 22;
int comienzoEnY = 0;

class _MazeState extends State<Maze> {
  late List<List<bool>> maze;

  void initMaze() {
    maze = List.generate(
      mazeSize,
      (index) => List.generate(mazeSize, (index) => false),
    );
    Random random = Random();
    comienzoEnY = random.nextInt(mazeSize);
    maze[0][comienzoEnY] = true;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    initMaze();

    generateMaze(maze, 0, comienzoEnY);
 

    return Scaffold(
      appBar: AppBar(title: const Text('Maze Generator')),
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 500, width: 500, child: drawMaze(maze)),
            FilledButton(
              onPressed: () {
                setState(() {
                  
                  initMaze();
                });
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
                foregroundColor: WidgetStateProperty.all(Colors.white),
              ),
              child: const Text('Generate new Maze'),
            ),
          ],
        ),
      ),
    );
  }
}

void generateMaze(List<List<bool>> maze, int x, int y) {
  Random random = Random();
  if (allVisited(maze, x, y)) {
    return;
  }

  int direction = random.nextInt(4);
  if (direction == 0) {
    if (isSafe(x - 2, y) && !isVisited(maze, x - 2, y)) {
      maze[x - 1][y] = true;
      maze[x - 2][y] = true;
      generateMaze(maze, x - 2, y);
    }
  } else if (direction == 1) {
    if (isSafe(x + 2, y) && !isVisited(maze, x + 2, y)) {
      maze[x + 1][y] = true;
      maze[x + 2][y] = true;
      generateMaze(maze, x + 2, y);
    }
  } else if (direction == 2) {
    if (isSafe(x, y - 2) && !isVisited(maze, x, y - 2)) {
      maze[x][y - 1] = true;
      maze[x][y - 2] = true;
      generateMaze(maze, x, y - 2);
    }
  } else if (direction == 3) {
    if (isSafe(x, y + 2) && !isVisited(maze, x, y + 2)) {
      maze[x][y + 1] = true;
      maze[x][y + 2] = true;
      generateMaze(maze, x, y + 2);
    }
  }

  generateMaze(maze, x, y);
}

GridView drawMaze(List<List<bool>> maze) {
  return GridView.count(
    crossAxisCount: mazeSize,
    children: List.generate(mazeSize * mazeSize, (index) {
      return Cell(road: maze[index ~/ mazeSize][index % mazeSize]);
    }),
  );
}

bool isSafe(int x, int y) {
  return x >= 0 && x < mazeSize && y >= 0 && y < mazeSize;
}

bool isVisited(List<List<bool>> maze, int x, int y) {
  if (!isSafe(x, y)) return true;
  return maze[x][y];
}

bool allVisited(List<List<bool>> maze, int x, int y) {
  return isVisited(maze, x - 2, y) &&
      isVisited(maze, x + 2, y) &&
      isVisited(maze, x, y - 2) &&
      isVisited(maze, x, y + 2);
}


