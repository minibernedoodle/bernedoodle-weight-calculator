// main.dart

import 'package:flutter/material.dart';

void main() {
  runApp(WeightCalculatorApp());
}

class WeightCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mini Bernedoodle Weight Calculator',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: WeightCalculatorScreen(),
    );
  }
}

class WeightCalculatorScreen extends StatefulWidget {
  @override
  _WeightCalculatorScreenState createState() => _WeightCalculatorScreenState();
}

class _WeightCalculatorScreenState extends State<WeightCalculatorScreen> {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _unit = 'lbs';
  String? _result;

  void _calculateWeight() {
    final String ageText = _ageController.text.trim();
    final String weightText = _weightController.text.trim();

    if (ageText.isEmpty || weightText.isEmpty) {
      setState(() {
        _result = '❗ Please fill out all fields!';
      });
      return;
    }

    final double? age = double.tryParse(ageText);
    final double? weight = double.tryParse(weightText);

    if (age == null || weight == null || age <= 0 || weight <= 0) {
      setState(() {
        _result = '❗ Please enter valid numbers!';
      });
      return;
    }

    // Convert weight to lbs if unit is kg
    double convertedWeight = weight;
    if (_unit == 'kg') {
      convertedWeight *= 2.20462;
    }

    // Estimate adult weight
    double estimatedWeight = (convertedWeight / age) * 52;

    // Convert back to kg if needed
    String displayUnit = 'lbs';
    if (_unit == 'kg') {
      estimatedWeight /= 2.20462;
      displayUnit = 'kg';
    }

    setState(() {
      _result =
      "✨ Your Mini Bernedoodle's estimated adult weight is ${estimatedWeight.toStringAsFixed(2)} $displayUnit!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mini Bernedoodle Weight Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '🐾 Enter Age (weeks):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Please enter age',
                ),
              ),
              SizedBox(height: 20),
              Text(
                '🐾 Current Weight:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Please enter current weight',
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: DropdownButtonFormField<String>(
                      value: _unit,
                      items: [
                        DropdownMenuItem(
                          value: 'lbs',
                          child: Text('lbs'),
                        ),
                        DropdownMenuItem(
                          value: 'kg',
                          child: Text('kg'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _unit = value!;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateWeight,
                child: Text('Calculate Weight 🐕'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              SizedBox(height: 10),
              OutlinedButton(
                onPressed: () {
                  // Navigate to external URL
                  final Uri url = Uri.parse(
                      'https://minibernedoodlehub.com/size-calculator/');
                  // Add logic to launch URL if needed
                },
                child: Text('Size Calculator 📏'),
              ),
              if (_result != null) ...[
                SizedBox(height: 20),
                Text(
                  _result!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
