import 'package:flutter/material.dart';

import '../widgets/color_chart.dart';
import '../widgets/size_chart.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
      ),
      body: const Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizeChart(),
                SizedBox(height: 20),
                Text(
                  'Hydration',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(width: 60),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ColorChart(),
                SizedBox(height: 20),
                Text(
                  'Happiness',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
