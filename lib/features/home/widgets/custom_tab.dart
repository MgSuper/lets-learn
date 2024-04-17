import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomTab extends HookWidget {
  final String label;
  final bool isActive;

  const CustomTab({
    Key? key,
    required this.label,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 100),
    );
    // Hook to control color based on isActive
    final backgroundColor = useState<Color>(Colors.grey);
    final textColor = useState<Color>(Colors.white);
    final fontSize = useState<double>(16.0);

    useEffect(() {
      if (isActive) {
        animationController.forward();
        backgroundColor.value = Colors.blue;
        textColor.value = Colors.yellow;
        fontSize.value = 20.0;
      } else {
        animationController.reverse();
        backgroundColor.value = Colors.grey;
        textColor.value = Colors.white;
        fontSize.value = 16.0;
      }
      return null;
    }, [isActive]);

    return Tab(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: backgroundColor.value,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: textColor.value,
              fontSize: fontSize.value,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
