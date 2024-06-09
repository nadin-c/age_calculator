import 'package:flutter/material.dart';

void main() {
  runApp(AgeCalculatorApp());
}

class AgeCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AgeCalculatorHome(),
    );
  }
}

class AgeCalculatorHome extends StatefulWidget {
  @override
  _AgeCalculatorHomeState createState() => _AgeCalculatorHomeState();
}

class _AgeCalculatorHomeState extends State<AgeCalculatorHome> {
  DateTime selectedDate = DateTime.now();
  int ageYears = 0;
  int ageMonths = 0;
  int ageDays = 0;

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _calculateAge();
      });
    }
  }

  void _calculateAge() {
    DateTime today = DateTime.now();
    int years = today.year - selectedDate.year;
    int months = today.month - selectedDate.month;
    int days = today.day - selectedDate.day;

    if (days < 0) {
      months--;
      days += DateTime(today.year, today.month, 0).day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }

    setState(() {
      ageYears = years;
      ageMonths = months;
      ageDays = days;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Calculator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select your birthdate:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  child: Text(
                    '${selectedDate.toLocal()}'.split(' ')[0],
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Your age is:',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text(
                '$ageYears years, $ageMonths months, $ageDays days',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
