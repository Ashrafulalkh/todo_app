import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

class Loader extends StatelessWidget {
  final Duration duration;
  const Loader({
    super.key,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRing(
        color: AppColors.themeColor,
        size: 40,
        duration: duration,
        lineWidth: 4.0,
      ),
    );
  }
}
