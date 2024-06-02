import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyListWidgets extends StatelessWidget {
  const EmptyListWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lotties/empty_list.json',
            width: 300,
            height: 300,
            fit: BoxFit.scaleDown,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Your Todo List is Empty',
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
