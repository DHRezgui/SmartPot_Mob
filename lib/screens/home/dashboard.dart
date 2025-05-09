import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smartpot/widgets/custom_bottom_navbar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool loading = true;
  Map<String, dynamic> _sensorData = {};
  List<FlSpot> humidityData = [];
  List<FlSpot> temperatureData = [];
  List<FlSpot> soilMoistureData = [];
  List<FlSpot> waterLevelData = [];

  int _xAxisIndex = 0; // Variable pour suivre l'index de l'axe X

  @override
  void initState() {
    super.initState();
    _setupFirestoreListener();
  }

  void _setupFirestoreListener() {
    print("Listening to Firestore...");

    // On s'assure que les données sont triées par timestamp (ou autre champ pertinent)
    FirebaseFirestore.instance
        .collection('sensor_readings')
        .orderBy(
          'timestamp',
          descending: true,
        ) // Trier par timestamp décroissant
        .limit(1)
        .snapshots()
        .listen(
          (QuerySnapshot snapshot) {
            if (snapshot.docs.isNotEmpty) {
              final data = snapshot.docs.first.data() as Map<String, dynamic>;

              setState(() {
                _sensorData = {
                  'humidity': data['humidity'],
                  'soilMoisture': data['soilMoisture'],
                  'tempC': data['tempC'],
                  'timestamp': data['timestamp'],
                  'waterLevel': data['waterLevel'],
                };

                // Ajouter un nouveau point pour chaque mesure avec un X unique
                humidityData.add(
                  FlSpot(
                    _xAxisIndex.toDouble(),
                    data['humidity']?.toDouble() ?? 0.0,
                  ),
                );
                temperatureData.add(
                  FlSpot(
                    _xAxisIndex.toDouble(),
                    data['tempC']?.toDouble() ?? 0.0,
                  ),
                );
                soilMoistureData.add(
                  FlSpot(
                    _xAxisIndex.toDouble(),
                    data['soilMoisture']?.toDouble() ?? 0.0,
                  ),
                );
                waterLevelData.add(
                  FlSpot(
                    _xAxisIndex.toDouble(),
                    data['waterLevel']?.toDouble() ?? 0.0,
                  ),
                );

                // Incrémenter l'index pour la prochaine donnée
                _xAxisIndex++;

                loading = false;
              });
            }
          },
          onError: (error) {
            print("Firestore error: $error");
            setState(() {
              loading = false;
            });
          },
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
        LineChartBarData(
          spots: waterLevelData,
          isCurved: true,
          color: Colors.blue.shade200,
          barWidth: 3,
          dotData: FlDotData(show: false),
        ),
      ],
      minY: 0, // Ajustez en fonction de vos données
      maxY: 100, // Ajustez en fonction de vos données
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

  @override
  Widget build(BuildContext context) {
    const green700 = Color(0xFF047857);
    const white = Colors.white;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            'assets/images/logoApp1.png',
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            semanticLabel: 'App logo',
          ),
        ),
      ),
      body:
          loading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'CAPTEURS EN TEMPS RÉEL',
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
                              title: 'Humidité',
                              value: _sensorData['humidity'],
                              unit: '%',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSensorCard(
                              icon: Icons.thermostat,
                              color: Colors.orange,
                              title: 'Température',
                              value: _sensorData['tempC'],
                              unit: '°C',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _buildSensorCard(
                              icon: Icons.grass,
                              color: Colors.green,
                              title: 'Humidité du sol',
                              value: _sensorData['soilMoisture'],
                              unit: '%',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildSensorCard(
                              icon: Icons.water_drop,
                              color: Colors.blue.shade200,
                              title: 'Niveau d\'eau',
                              value: _sensorData['waterLevel'],
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
                      SizedBox(
                        height: 250,
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            loading = true;
                            humidityData = [];
                            temperatureData = [];
                            soilMoistureData = [];
                            waterLevelData = [];
                          });
                          _setupFirestoreListener();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Actualiser les données'),
                      ),
                    ],
                  ),
                ),
              ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        selectedColor: green700,
        unselectedColor: Colors.grey.shade500,
        selectedFontSize: 12,
        unselectedFontSize: 10,
      ),
    );
  }
}
