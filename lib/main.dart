import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData(), home: PizzaOrderPage());
  }
}

const _pizzaCardSize = 48.0;

class PizzaOrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PizzaOrderPage();
}

class _PizzaOrderPage extends State<PizzaOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New order Pizza",
          style: TextStyle(color: Colors.brown, fontSize: 28),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.add_shopping_cart_outlined),
            color: Colors.brown,
            onPressed: () {},
          )
        ],
      ),
      body: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: const Stack(
          children: [
            Positioned.fill(
              bottom: 50,
              left: 10,
              right: 10,
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: _PizzaDitels(),
                  ),
                  Expanded(
                    flex: 2,
                    child: _pizzaIngredinets(),
                  ),
                ],
              ),
            ),
            const Positioned(
              bottom: 25,
              height: _pizzaCardSize,
              width: _pizzaCardSize,
              left:
                  58, //MediaQuery.of(context).size.width / 2 -_pizzaCardSize/2,
              child: _PizzaCardButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _pizzaIngredinets extends StatelessWidget {
  const _pizzaIngredinets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ingredinents.length,
        itemBuilder: (context, i) {
          final ingredinet = ingredinents[i];
          return _PizzaingredinetsItem(ingredinet: ingredinet);
        },
      ),
    );
  }
}

class _PizzaingredinetsItem extends StatelessWidget {
  const _PizzaingredinetsItem({super.key, required this.ingredinet});
  final Ingredinet ingredinet;
  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 45,
        width: 45,
        decoration: const BoxDecoration(
          color: Color(0xFFF5EED3),
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          ingredinet.image,
          fit: BoxFit.contain,
        ),
      ),
    );
    return Center(
      child: Draggable(
          feedback: DecoratedBox(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10.0,
                  color: Colors.black26,
                  offset: Offset(0.0, 0.5),
                  spreadRadius: 5.0,
                ),
              ],
            ),
            child: child,
          ),
          child: child),
    );
  }
}

class Ingredinet {
  Ingredinet(this.image, this.position);
  final String image;
  List<Offset> position;
  bool compare(Ingredinet ingredinet) => ingredinet.image == image;
}

final ingredinents = <Ingredinet>[
  Ingredinet('pizza_order/chili.png', const <Offset>[
    Offset(0.2, 0.2),
    Offset(0.6, 0.2),
    Offset(0.4, 0.25),
    Offset(0.5, 0.3),
    Offset(0.4, 0.65),
  ]),
  Ingredinet('pizza_order/garlic.png', const <Offset>[
    Offset(0.2, 0.35),
    Offset(0.65, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.3, 0.5),
  ]),
  Ingredinet('pizza_order/olive.png', const <Offset>[
    Offset(0.25, 0.5),
    Offset(0.65, 0.6),
    Offset(0.2, 0.3),
    Offset(0.4, 0.2),
    Offset(0.2, 0.6),
  ]),
  Ingredinet('pizza_order/onion.png', const <Offset>[
    Offset(0.2, 0.65),
    Offset(0.65, 0.3),
    Offset(0.25, 0.25),
    Offset(0.45, 0.35),
    Offset(0.4, 0.65),
  ]),
  Ingredinet('pizza_order/pea.png', const <Offset>[
    Offset(0.2, 0.35),
    Offset(0.65, 0.35),
    Offset(0.3, 0.23),
    Offset(0.5, 0.2),
    Offset(0.3, 0.5),
  ]),
  Ingredinet('pizza_order/pickle.png', const <Offset>[
    Offset(0.2, 0.65),
    Offset(0.65, 0.3),
    Offset(0.25, 0.25),
    Offset(0.45, 0.35),
    Offset(0.4, 0.65),
  ]),
  Ingredinet('pizza_order/potato.png', const <Offset>[
    Offset(0.2, 0.2),
    Offset(0.6, 0.2),
    Offset(0.4, 0.25),
    Offset(0.5, 0.3),
    Offset(0.4, 0.65),
  ]),
];

class _PizzaCardButton extends StatelessWidget {
  const _PizzaCardButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange.withOpacity(0.5),
            Colors.orange,
          ],
        ),
      ),
      child: Icon(
        Icons.shopping_cart_outlined,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

class _PizzaDitels extends StatefulWidget {
  const _PizzaDitels({super.key});

  @override
  State<_PizzaDitels> createState() => _PizzaDitelsState();
}

class _PizzaDitelsState extends State<_PizzaDitels>
    with SingleTickerProviderStateMixin {
  final _listIngredients = <Ingredinet>[];
  int _total = 15;
  late AnimationController _animationController;
  List<Animation> _animationList = <Animation>[];
  late BoxConstraints _pizzaConstraints;
  Widget _bulidIngredinetWiget() {
    List<Widget> elements = [];
    if (_animationList.isNotEmpty) {
      for (var i = 0; i < _listIngredients.length; i++) {
        Ingredinet ingredinet = _listIngredients[i];
        for (var j = 0; j < ingredinet.position.length; j++) {
          final animation = _animationList[j];
          final position = ingredinet.position[j];
          final positionX = position.dx;
          final positionY = position.dy;
          double fromX = 0.0, fromY = 0.0;
          if (j < 1) {
            fromX = -_pizzaConstraints.maxWidth * (1 - animation.value);
          } else if (j < 2) {
            fromX = _pizzaConstraints.maxWidth * (1 - animation.value);
          } else if (j < 4) {
            fromX = -_pizzaConstraints.maxHeight * (1 - animation.value);
          } else {
            fromY = _pizzaConstraints.maxHeight * (1 - animation.value);
          }

          elements.add(Transform(
              transform: Matrix4.identity()
                ..translate(
                  fromX + _pizzaConstraints.maxHeight * positionX,
                  fromY + _pizzaConstraints.maxHeight * positionY,
                ),
              child: Image.asset(
                ingredinet.image,
                height: 40,
              ),),);
        }
          return Stack(
            children: elements,
          );
      }
    }
    return SizedBox.fromSize();
  }

  void _buildIngredinetAnimation() {
    _animationList.clear();
    _animationList.add(
      CurvedAnimation(
        curve: const Interval(0.0, 0.8, curve: Curves.decelerate),
        parent: _animationController,
      ),
    );
    _animationList.add(
      CurvedAnimation(
        curve: const Interval(0.2, 0.8, curve: Curves.decelerate),
        parent: _animationController,
      ),
    );
    _animationList.add(
      CurvedAnimation(
        curve: const Interval(0.4, 1.0, curve: Curves.decelerate),
        parent: _animationController,
      ),
    );
    _animationList.add(
      CurvedAnimation(
        curve: const Interval(0.1, 0.7, curve: Curves.decelerate),
        parent: _animationController,
      ),
    );
    _animationList.add(
      CurvedAnimation(
        curve: const Interval(0.3, 1.0, curve: Curves.decelerate),
        parent: _animationController,
      ),
    );
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final _notifierFocused = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: DragTarget<Ingredinet>(
                onAccept: (ingredinet) {
                  print('onAccept');
                  _notifierFocused.value = false;
                  setState(() {
                    _total++;
                    _listIngredients.add(ingredinet);
                  });
                  _buildIngredinetAnimation();
                  _animationController.forward(from: 0.0);
                },
                onWillAccept: (ingredinet) {
                  print('onWillaccept');
                  print(ingredinet);
                  _notifierFocused.value = true;
                  for (Ingredinet i in _listIngredients) {
                    if (i.compare(ingredinet!)) {
                      return true;
                    }
                  }

                  print(_total);
                  return false;
                },
                onLeave: (ingerdinet) {
                  print('onLeave');
                  _total++;
                  _notifierFocused.value = false;
                },
                builder: (context, list, rejects) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      _pizzaConstraints = constraints;
                      print(constraints);
                      return Center(
                        child: ValueListenableBuilder<bool>(
                            valueListenable: _notifierFocused,
                            builder: (context, focused, _) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                height: focused
                                    ? constraints.maxHeight
                                    : constraints.maxHeight - 10,
                                child: Stack(
                                  children: [
                                    Image.asset('pizza_order/dish.png'),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                          'pizza_order/pizza-1.png'),
                                    )
                                  ],
                                ),
                              );
                            }),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AnimatedSwitcher(
              duration: const Duration(microseconds: 800),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: animation.drive(
                      Tween<Offset>(
                        begin: Offset(0.0, 0.1),
                        end: Offset(0.0, animation.value - 0.1),
                      ),
                    ),
                    child: child,
                  ),
                );
              },
              child: Text(
                "\$$_total",
                key: UniqueKey(),
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown),
              ),
            ),
          ],
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return _bulidIngredinetWiget();
          },
        ),
      ],
    );
  }
}
