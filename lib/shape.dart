class Shape {
  final String name;
  final int x;
  final int y;

  Shape({
    required this.name,
    required this.x,
    required this.y,
  });
}

List<Shape> shapes = [
  Shape(name: 'a', x: 0, y: 50),
  Shape(name: 'b', x: 50, y: 90),
  Shape(name: 'c', x: 0, y: 0),
  Shape(name: 'd', x: 50, y: 20),
  Shape(name: 'Actor', x: 20, y: 40),
];
