import 'package:basketball_points_counter/cubit/counter_cubit.dart';
import 'package:basketball_points_counter/cubit/counter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<CounterCubit, CounterState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const Text('Points Counter'),
          ),
          body: SizedBox(
            height: screenHeight,
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Team A',
                              style: TextStyle(fontSize: 28),
                            ),
                            AutoSizeText(
                              '${BlocProvider.of<CounterCubit>(context).teamAPoints}',
                              style: TextStyle(
                                fontSize: screenWidth * 0.3,
                              ),
                              maxLines: 1,
                              minFontSize: 40,
                            ),
                            _buildPointButtons(context, 'A'),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.symmetric(vertical: 20),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Team B',
                              style: TextStyle(fontSize: 28),
                            ),
                            AutoSizeText(
                              '${BlocProvider.of<CounterCubit>(context).teamBPoints}',
                              style: TextStyle(
                                fontSize: screenWidth * 0.3,
                              ),
                              maxLines: 1,
                              minFontSize: 40,
                            ),
                            _buildPointButtons(context, 'B'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: Size(screenWidth * 0.5, 50),
                      ),
                      onPressed: () {
                        BlocProvider.of<CounterCubit>(context).Reset();
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget _buildPointButtons(BuildContext context, String team) {
    return Column(
      children: [
        _buildButton(context, 'Add 1 Point', () {
          BlocProvider.of<CounterCubit>(context)
              .TeamIncrement(team: team, buttonNumber: 1);
        }),
        _buildButton(context, 'Add 2 Points', () {
          BlocProvider.of<CounterCubit>(context)
              .TeamIncrement(team: team, buttonNumber: 2);
        }),
        _buildButton(context, 'Add 3 Points', () {
          BlocProvider.of<CounterCubit>(context)
              .TeamIncrement(team: team, buttonNumber: 3);
        }),
      ],
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onPressed) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: screenWidth * 0.4,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.all(12),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
