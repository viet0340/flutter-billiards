import 'package:flutter/material.dart';
import 'package:billiards_countdown/providers/timermodel_provider.dart';
import 'package:billiards_countdown/widgets/button_widget.dart';
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
    final pointOne = timerModel.pointOne;
    final pointTwo = timerModel.pointTwo;
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
            child: GestureDetector(
                onTap: () {
                  timerModel.startCountdown();
                },
                onVerticalDragEnd: (DragEndDetails details) {
                  if (isBreak) {
                    if (details.velocity.pixelsPerSecond.dy < 0) {
                      timerModel.reloopCountdown();
                    }
                  }
                },
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (!isExtension &&
                      isTimerRunning &&
                      details.velocity.pixelsPerSecond.dx > 0) {
                    timerModel.extensionCountdown();
                  }
                  if (!isBreak && details.velocity.pixelsPerSecond.dx < 0) {
                    timerModel.breakCountdown();
                  }
                },
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Center(
                        child: FractionallySizedBox(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 50),
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
                            margin: const EdgeInsets.only(top: 40, left: 10),
                            child: IconButton(
                                onPressed: () {
                                  if (isTimerRunning) {
                                    timerModel.startCountdown();
                                  }
                                  Navigator.pushNamed(context, '/settings');
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
                                      if (states
                                          .contains(MaterialState.disabled)) {
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
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            margin: const EdgeInsets.only(bottom: 50, left: 30),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      timerModel.decreasePoint(1);
                                    },
                                    color: Colors.white,
                                    icon: const Icon(
                                        Icons.keyboard_double_arrow_left)),
                                IconButton(
                                    onPressed: () {},
                                    color: Colors.white,
                                    iconSize: 35,
                                    icon: Text(
                                      '$pointOne',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      timerModel.increasePoint(1);
                                    },
                                    color: Colors.white,
                                    icon: const Icon(
                                        Icons.keyboard_double_arrow_right))
                              ],
                            )),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                            margin:
                                const EdgeInsets.only(bottom: 50, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      timerModel.decreasePoint(2);
                                    },
                                    color: Colors.white,
                                    icon: const Icon(
                                        Icons.keyboard_double_arrow_left)),
                                IconButton(
                                    onPressed: () {},
                                    color: Colors.white,
                                    iconSize: 35,
                                    icon: Text(
                                      '$pointTwo',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      timerModel.increasePoint(2);
                                    },
                                    color: Colors.white,
                                    icon: const Icon(
                                        Icons.keyboard_double_arrow_right))
                              ],
                            )),
                      ),
                    ],
                  ),
                )),
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
