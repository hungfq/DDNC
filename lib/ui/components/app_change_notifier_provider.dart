import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppChangeNotifierProvider<T extends ChangeNotifier?>
    extends StatelessWidget {
  const AppChangeNotifierProvider({
    Key? key,
    required this.value,
    required this.builder,
  }) : super(key: key);

  final T value;
  final Widget Function(
    BuildContext context,
    T value,
    Widget? child,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: value,
      child: Consumer<T>(
        builder: builder,
      ),
    );
  }
}
