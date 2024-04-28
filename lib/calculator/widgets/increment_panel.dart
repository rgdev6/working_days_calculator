import "package:flutter/material.dart";

class IncrementPanel extends StatefulWidget {
  IncrementPanel(
      {Key? key,
      required this.counter,
      required,
      required this.onIncrement,
      required this.onDecrement})
      : super(key: key);
  final Function onIncrement;
  final Function onDecrement;
  int counter;

  @override
  _IncrementPanelState createState() => _IncrementPanelState();
}

class _IncrementPanelState extends State<IncrementPanel> {
  double _containerSize = 120.0; // Initial container size

  void _handleIncrement(bool isIncrement) {
    setState(() {
      if (isIncrement) {
        widget.onIncrement();
      } else {
        widget.onDecrement();
      }
      _containerSize =
          150.0; // Increase the container size during the transition
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _containerSize =
            120.0; // Return the container size to its original value
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        IconButton.filledTonal(
          onPressed: () => _handleIncrement(false),
          icon: const Icon(Icons.remove),
        ),
        SizedBox(
          width: 150,
          height: 150,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(8.0),
              ),
              margin: const EdgeInsets.all(8),
              width: _containerSize, // Animated width
              height: _containerSize, // Animated height
              child: Center(
                child: Text(
                  "${widget.counter}",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 48),
                ),
              ),
            ),
          ),
        ),
        IconButton.filledTonal(
          onPressed: () => _handleIncrement(true),
          icon: const Icon(Icons.add),
        ),
        const Spacer()
      ],
    );
  }
}
