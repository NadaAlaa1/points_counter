import 'package:flutter/material.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart'; // Import the AutoSizeTextField package

void main() {
  runApp(const PointsCounter());
}

class PointsCounter extends StatefulWidget {
  const PointsCounter({super.key});

  @override
  State<PointsCounter> createState() => _PointsCounterState();
}

class _PointsCounterState extends State<PointsCounter> {
  int teamAPoints = 0, teamBPoints = 0;

  TextEditingController teamAController = TextEditingController();
  TextEditingController teamBController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values for both teams' points to 0
    teamAController.text = '0';
    teamBController.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive text and button sizes
    final double textSize = screenWidth * 0.08;
    final double buttonFontSize = screenWidth * 0.045;
    final double buttonWidth = screenWidth * 0.4;
    final double buttonHeight = screenHeight * 0.07;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            'Points Counter',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                // Wrap the first column with Expanded
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Team A',
                        style: TextStyle(fontSize: textSize),
                      ),
                      // Using AutoSizeTextField for teamAPoints
                      AutoSizeTextField(
                        controller: teamAController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 150),
                        maxLines: 1,
                        minFontSize: 50, // Adjust this value as per your preference
                        onChanged: (value) {
                          setState(() {
                            // Parse the value and update the points
                            teamAPoints = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      _buildPointButton(
                        "Add 1 Point",
                        1,
                        buttonFontSize,
                        buttonWidth,
                        buttonHeight,
                        team: 'A',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildPointButton(
                        "Add 2 Points",
                        2,
                        buttonFontSize,
                        buttonWidth,
                        buttonHeight,
                        team: 'A',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildPointButton(
                        "Add 3 Points",
                        3,
                        buttonFontSize,
                        buttonWidth,
                        buttonHeight,
                        team: 'A',
                      ),
                    ],
                  ),
                ),
                // Add a divider with flexible height
                Container(
                  height: screenHeight * 0.4,
                  width: 1,
                  color: Colors.grey,
                ),
                // Wrap the second column with Expanded
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Team B',
                        style: TextStyle(fontSize: textSize),
                      ),
                      // Using AutoSizeTextField for teamBPoints
                      AutoSizeTextField(
                        controller: teamBController,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 150),
                        maxLines: 1,
                        minFontSize: 50, // Adjust this value as per your preference
                        onChanged: (value) {
                          setState(() {
                            // Parse the value and update the points
                            teamBPoints = int.tryParse(value) ?? 0;
                          });
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                      _buildPointButton(
                        "Add 1 Point",
                        1,
                        buttonFontSize,
                        buttonWidth,
                        buttonHeight,
                        team: 'B',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildPointButton(
                        "Add 2 Points",
                        2,
                        buttonFontSize,
                        buttonWidth,
                        buttonHeight,
                        team: 'B',
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildPointButton(
                        "Add 3 Points",
                        3,
                        buttonFontSize,
                        buttonWidth,
                        buttonHeight,
                        team: 'B',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.1),
            ElevatedButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsets.all(screenWidth * 0.02)),
                backgroundColor: const WidgetStatePropertyAll(Colors.orange),
                minimumSize: WidgetStatePropertyAll(Size(buttonWidth, buttonHeight)),
              ),
              onPressed: () {
                setState(() {
                  teamAPoints = 0;
                  teamBPoints = 0;
                  teamAController.text = '0';
                  teamBController.text = '0';
                });
              },
              child: Text('Reset',
                  style: TextStyle(fontSize: buttonFontSize, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method for creating buttons
  ElevatedButton _buildPointButton(
      String text, int points, double fontSize, double width, double height,
      {required String team}) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
        backgroundColor: const WidgetStatePropertyAll(Colors.orange),
        minimumSize: WidgetStatePropertyAll(Size(width, height)),
      ),
      onPressed: () {
        setState(() {
          if (team == 'A') {
            teamAPoints += points;
            teamAController.text = '$teamAPoints';
          } else {
            teamBPoints += points;
            teamBController.text = '$teamBPoints';
          }
        });
      },
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: Colors.black),
      ),
    );
  }
}
