import 'package:flutter/material.dart';
import 'package:flutter_billiard/providers/timermodel_provider.dart';
import 'package:flutter_billiard/widgets/button_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final timerModel = Provider.of<TimerModel>(context);
    final countdownValue = timerModel.countdownValue;
    final isTimerRunning = timerModel.isTimerRunning;
    final isExtension = timerModel.isExtension;
    final isBreak = timerModel.isBreak;
    final warningBackground = timerModel.warningBackground;

    return Scaffold(
      backgroundColor: warningBackground ? Colors.red : Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              color: Colors.transparent,
              child: Stack(
                children: [
                  Center(
                    child: FractionallySizedBox(
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: _formatTime(countdownValue),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: const EdgeInsets.only(top: 40, right: 30),
                        child: IconButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, '/settings');
                            },
                            color: Colors.white,
                            icon: const Icon(Icons.settings))),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        margin: const EdgeInsets.only(top: 40, right: 10),
                        child: ElevatedButton(
                            onPressed: !isExtension && isTimerRunning
                                ? timerModel.extensionCountdown
                                : null,
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.disabled)) {
                                    return Colors.grey;
                                  }
                                  return Colors.green;
                                },
                              ),
                            ),
                            child: const Icon(
                              Icons.more_time_rounded,
                              size: 50,
                            ))),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(width: 0, color: Colors.transparent)),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CustomButton(
                          onPressed: (countdownValue == 0 || !isBreak)
                              ? null
                              : timerModel.startCountdown,
                          styleButton: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.grey;
                                }
                                return Colors.green;
                              },
                            ),
                          ),
                          child: Icon(
                            isTimerRunning ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                        CustomButton(
                          onPressed:
                              !isBreak ? null : timerModel.reloopCountdown,
                          onLongPress:
                              !isBreak ? null : timerModel.resetCountdown,
                          styleButton: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.grey;
                                }
                                return Colors.blue;
                              },
                            ),
                          ),
                          child: const Icon(
                            Icons.repeat_rounded,
                            color: Colors.white,
                            size: 80,
                          ),
                        ),
                        CustomButton(
                          onPressed: isBreak ? null : timerModel.breakCountdown,
                          styleButton: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return Colors.grey;
                                }
                                return const Color.fromARGB(255, 72, 51, 94);
                              },
                            ),
                          ),
                          child: const Text(
                            'Break',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text _formatTime(int time) {
    return Text(time < 10 ? '0$time' : time.toString(),
        style: const TextStyle(
            fontFamily: 'RobotoSlab',
            color: Colors.white,
            fontSize: 200,
            fontWeight: FontWeight.w900));
  }
}
