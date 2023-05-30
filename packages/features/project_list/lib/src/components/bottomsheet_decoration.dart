import 'package:flutter/material.dart';

class BottomsheetDecoration extends StatelessWidget {
  const BottomsheetDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Row(
          children: [
            const Spacer(),
            Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.grey,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
