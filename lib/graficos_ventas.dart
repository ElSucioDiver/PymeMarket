import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gráficos de Ventas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gráfico de barras
            Text(
              'Top productos vendidos',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: BarChart(
                BarChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const labels = [
                            'Calcetas',
                            'Camisetas',
                            'Audífonos',
                            'Gorras',
                            'Sudaderas'
                          ];
                          return Text(
                            labels[value.toInt()],
                            style: TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(toY: 30, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(toY: 25, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(toY: 20, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(toY: 15, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 4, barRods: [
                      BarChartRodData(toY: 10, color: Colors.blue)
                    ]),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Gráfico de líneas
            Text(
              'Ventas por mes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const labels = [
                            'Ene',
                            'Feb',
                            'Mar',
                            'Abr',
                            'May',
                            'Jun',
                            'Jul'
                          ];
                          return Text(
                            labels[value.toInt()],
                            style: TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, 20),
                        FlSpot(1, 15),
                        FlSpot(2, 18),
                        FlSpot(3, 12),
                        FlSpot(4, 22),
                        FlSpot(5, 19),
                        FlSpot(6, 21),
                      ],
                      isCurved: true,
                      dotData: FlDotData(show: true),
                      color: Colors.cyan,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Barra de progreso para meta mensual
            Text(
              'Meta mensual',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            MonthlyGoalWidget(
              current: 800000,
              goal: 1100000,
            ),
          ],
        ),
      ),
    );
  }
}

// Barra de progreso personalizada
class MonthlyGoalWidget extends StatelessWidget {
  final double current;
  final double goal;

  MonthlyGoalWidget({required this.current, required this.goal});

  @override
  Widget build(BuildContext context) {
    double progress = (current / goal).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Actual:\n\$${current.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Meta:\n\$${goal.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 20,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
            ),
            child: FractionallySizedBox(
              widthFactor: progress,
              alignment: Alignment.centerLeft,
              child: Container(
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
