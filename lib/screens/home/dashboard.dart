import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smartpot/widgets/custom_bottom_navbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref(
    'sensors_data',
  );
  double? humidity;
  double? temperature;
  double? soilMoisture;
  List<FlSpot> humidityData = [];
  List<FlSpot> temperatureData = [];
  List<FlSpot> soilMoistureData = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _setupRealTimeListener();
  }

  void _setupRealTimeListener() {
    _dbRef
        .orderByKey()
        .limitToLast(10)
        .onValue
        .listen(
          (event) {
            if (event.snapshot.exists) {
              final data = event.snapshot.value as Map<dynamic, dynamic>;
              final entries = data.entries.toList();

              final latestEntry = entries.last.value as Map<dynamic, dynamic>;

              setState(() {
                humidity = latestEntry['humidity']?.toDouble();
                temperature = latestEntry['temperature']?.toDouble();
                soilMoisture = latestEntry['soilMoisture']?.toDouble();

                humidityData = [];
                temperatureData = [];
                soilMoistureData = [];

                for (int i = 0; i < entries.length; i++) {
                  final entry = entries[i].value as Map<dynamic, dynamic>;
                  humidityData.add(
                    FlSpot(i.toDouble(), entry['humidity']?.toDouble() ?? 0.0),
                  );
                  temperatureData.add(
                    FlSpot(
                      i.toDouble(),
                      entry['temperature']?.toDouble() ?? 0.0,
                    ),
                  );
                  soilMoistureData.add(
                    FlSpot(
                      i.toDouble(),
                      entry['soilMoisture']?.toDouble() ?? 0.0,
                    ),
                  );
                }

                loading = false;
              });
            }
          },
          onError: (error) {
            setState(() => loading = false);
            debugPrint('Firebase error: $error');
          },
        );
  }

  Widget _buildSensorCard({
    required IconData icon,
    required Color color,
    required String title,
    required double? value,
    required String unit,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value != null ? '${value.toStringAsFixed(1)}$unit' : '--',
              style: TextStyle(
                color: color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData _buildChartData() {
    return LineChartData(
      gridData: FlGridData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget:
                (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                ),
            interval: 20,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: humidityData,
          isCurved: true,
          color: Colors.blue,
          barWidth: 3,
          dotData: FlDotData(show: false),
        ),
        LineChartBarData(
          spots: temperatureData,
          isCurved: true,
          color: Colors.orange,
          barWidth: 3,
          dotData: FlDotData(show: false),
        ),
        LineChartBarData(
          spots: soilMoistureData,
          isCurved: true,
          color: Colors.green,
          barWidth: 3,
          dotData: FlDotData(show: false),
        ),
      ],
      minY: 0,
      maxY: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord'),
        backgroundColor: Colors.green,
      ),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'CAPTEURS EN TEMPS REEL',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSensorCard(
                            icon: Icons.opacity,
                            color: Colors.blue,
                            title: 'Humidite',
                            value: humidity,
                            unit: '%',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSensorCard(
                            icon: Icons.thermostat,
                            color: Colors.orange,
                            title: 'Temperature',
                            value: temperature,
                            unit: '°C',
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSensorCard(
                            icon: Icons.grass,
                            color: Colors.green,
                            title: 'Humidite du sol',
                            value: soilMoisture,
                            unit: '%',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'HISTORIQUE DES MESURES',
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: LineChart(_buildChartData()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        selectedColor: Colors.green.shade700,
        unselectedColor: Colors.grey.shade500,
        selectedFontSize: 12,
        unselectedFontSize: 10,
      ),
    );
  }
}
