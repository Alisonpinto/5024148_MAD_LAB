import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const IconsImagesChartsApp());
}

class IconsImagesChartsApp extends StatelessWidget {
  const IconsImagesChartsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Icons, Images, Charts',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icons, Images & Charts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionHeader('1. Icons'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.home, color: Colors.blue, size: 40),
                Icon(Icons.favorite, color: Colors.red, size: 40),
                Icon(Icons.settings, color: Colors.grey, size: 40),
                Icon(Icons.star, color: Colors.amber, size: 40),
              ],
            ),
            const Divider(height: 32),

            _buildSectionHeader('2. Images'),
            Center(
              child: Image.network(
                'https://picsum.photos/400/200',
                height: 200,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const CircularProgressIndicator();
                },
              ),
            ),
            // Example of loading from assets:
            // Center(
            //   child: Image.asset(
            //     'assets/images/sample.jpg',
            //     height: 200,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const Divider(height: 32),

            _buildSectionHeader('3. Bar Chart (fl_chart)'),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
                          String text;
                          switch (value.toInt()) {
                            case 0: text = 'Math'; break;
                            case 1: text = 'Sci'; break;
                            case 2: text = 'Eng'; break;
                            case 3: text = 'CS'; break;
                            default: text = ''; break;
                          }
                          return SideTitleWidget(axisSide: meta.axisSide, space: 4, child: Text(text, style: style));
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 85, color: Colors.blue, width: 20, borderRadius: BorderRadius.circular(4))]),
                    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 70, color: Colors.green, width: 20, borderRadius: BorderRadius.circular(4))]),
                    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 92, color: Colors.orange, width: 20, borderRadius: BorderRadius.circular(4))]),
                    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 98, color: Colors.purple, width: 20, borderRadius: BorderRadius.circular(4))]),
                  ],
                ),
              ),
            ),
            const Divider(height: 32),

            _buildSectionHeader('4. Pie Chart (fl_chart)'),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(value: 40, color: Colors.blue, title: '40%', radius: 50, titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    PieChartSectionData(value: 30, color: Colors.green, title: '30%', radius: 50, titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    PieChartSectionData(value: 20, color: Colors.orange, title: '20%', radius: 50, titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    PieChartSectionData(value: 10, color: Colors.purple, title: '10%', radius: 50, titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
