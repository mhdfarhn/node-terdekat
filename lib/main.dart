import 'dart:math';

import 'package:closest_node/shape.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: App(),
      ),
    );

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Shape? shapeTerdekat;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Node Terdekat'),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight / 2,
          child: Stack(
            children: List.generate(
              shapes.length,
              (index) => Positioned(
                left: shapes[index].x * 3,
                bottom: shapes[index].y * 3,
                child: shapes[index].name != 'Actor'
                    ? Card(
                        color: Colors.grey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(shapes[index].name),
                              Text(
                                  '${shapes[index].x.toString()}, ${shapes[index].y.toString()}'),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                shapeTerdekat = getShapeTerdekat(
                                  shapes: shapes,
                                  mouseX: shapes[index].x,
                                  mouseY: shapes[index].y,
                                );
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(shapes[index].name),
                                  Text(
                                      '${shapes[index].x.toString()}, ${shapes[index].y.toString()}'),
                                ],
                              ),
                            ),
                          ),
                          shapeTerdekat != null
                              ? Text(
                                  'shape terdekat: ${shapeTerdekat!.name} (${shapeTerdekat!.x}, ${shapeTerdekat!.y})',
                                )
                              : Container(),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Shape getShapeTerdekat({
  required List<Shape> shapes,
  required int mouseX,
  required int mouseY,
}) {
  Shape terdekat = shapes.first;

  Map<String, dynamic> temp = {};

  for (Shape shape in shapes) {
    // hitung jarak menggunakan pythagoras
    if (shape.name != 'Actor') {
      int a = mouseX - shape.x;
      int b = mouseY - shape.y;

      double c = sqrt(a * a + b * b);

      if (temp.isEmpty) {
        temp = {
          'shape': shape,
          'jarak': c,
        };
      } else if (temp['jarak'] > c) {
        temp = {
          'shape': shape,
          'jarak': c,
        };
        terdekat = shape;
      }
    }
  }

  return terdekat;
}
