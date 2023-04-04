import 'package:flutter/material.dart';

class DoneWidget extends StatefulWidget {
  final bool isDone;
  final Widget message;

  const DoneWidget({
    Key? key,
    this.isDone = true,
    required this.message,
  }) : super(key: key);

  @override
  DoneWidgetState createState() => DoneWidgetState();
}

class DoneWidgetState extends State<DoneWidget> {
  double _containerHeight = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.isDone) {
      _containerHeight = 50.0;
    } else {
      _containerHeight = 0.0;
    }
  }

  @override
  void didUpdateWidget(DoneWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isDone != widget.isDone) {
      setState(() {
        if (widget.isDone) {
          _containerHeight = 50.0;
        } else {
          _containerHeight = 0.0;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Your other widgets here
        AnimatedContainer(
          duration: const Duration(milliseconds: 2000),
          height: _containerHeight,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: widget.message,
          ),
        ),
      ],
    );
  }
}
