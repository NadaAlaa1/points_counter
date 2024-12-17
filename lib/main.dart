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
    teamAController.text = '0';
    teamBController.text = '0';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

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
        body: Center(
          child: SizedBox(
            height: screenHeight * 0.8, // Constrain the overall height
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildTeamColumn(
                          "Team A",
                          teamAController,
                          textSize,
                          buttonFontSize,
                          buttonWidth,
                          buttonHeight,
                          'A'),
                      Container(
                        width: 1,
                        color: Colors.grey,
                        height: screenHeight * 0.6,
                      ),
                      _buildTeamColumn(
                          "Team B",
                          teamBController,
                          textSize,
                          buttonFontSize,
                          buttonWidth,
                          buttonHeight,
                          'B'),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.all(screenWidth * 0.02)),
                    backgroundColor:
                        const WidgetStatePropertyAll(Colors.orange),
                    minimumSize:
                        WidgetStatePropertyAll(Size(buttonWidth, buttonHeight)),
                  ),
                  onPressed: () {
                    setState(() {
                      teamAPoints = 0;
                      teamBPoints = 0;
                      teamAController.text = '0';
                      teamBController.text = '0';
                    });
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                        fontSize: buttonFontSize, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for creating team columns
  Widget _buildTeamColumn(
      String title,
      TextEditingController controller,
      double textSize,
      double buttonFontSize,
      double buttonWidth,
      double buttonHeight,
      String team) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min, // Shrink to fit content
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: textSize),
          ),
          SizedBox(height: 10),
          AutoSizeTextField(
            controller: controller,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 100),
            maxLines: 1,
            minFontSize: 40,
            onChanged: (value) {
              setState(() {
                if (team == 'A') {
                  teamAPoints = int.tryParse(value) ?? 0;
                } else {
                  teamBPoints = int.tryParse(value) ?? 0;
                }
              });
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
          SizedBox(height: 10),
          _buildPointButton(
              "Add 1 Point", 1, buttonFontSize, buttonWidth, buttonHeight, team),
          SizedBox(height: 10),
          _buildPointButton(
              "Add 2 Points", 2, buttonFontSize, buttonWidth, buttonHeight, team),
          SizedBox(height: 10),
          _buildPointButton(
              "Add 3 Points", 3, buttonFontSize, buttonWidth, buttonHeight, team),
        ],
      ),
    );
  }

  ElevatedButton _buildPointButton(
      String text, int points, double fontSize, double width, double height,
      String team) {
    return ElevatedButton(
      style: ButtonStyle(
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
