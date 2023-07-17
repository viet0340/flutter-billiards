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
      body: OrientationBuilder(
          builder: (context, orientation) => Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: GestureDetector(
                      onTap: () {
                        if (countdownValue == 0 || !isBreak) return;
                        timerModel.startCountdown();
                      },
                      onLongPress: () => timerModel.resetCountdown(),
                      onVerticalDragEnd: (DragEndDetails details) {
                        if (isBreak) {
                          if (details.velocity.pixelsPerSecond.dy < 0) {
                            timerModel.reloopCountdown();
                          } else if (!isExtension && isTimerRunning) {
                            timerModel.extensionCountdown();
                          }
                        }
                      },
                      onHorizontalDragEnd: (DragEndDetails details) {
                        if (!isBreak &&
                            details.velocity.pixelsPerSecond.dx < 0) {
                          timerModel.breakCountdown();
                        }
                        if (isBreak &&
                            details.velocity.pixelsPerSecond.dx > 0) {
                          timerModel.resetCountdown();
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Stack(
                          children: [
                            Center(
                              child: Text(
                                  countdownValue < 10
                                      ? '0$countdownValue'
                                      : countdownValue.toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontFamily: 'RobotoSlab',
                                    color: Colors.white,
                                    fontSize: 280,
                                    height: 1.1,
                                    fontWeight: FontWeight.w900,
                                  )),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 40, left: 10),
                                  child: IconButton(
                                      onPressed: () {
                                        if (isTimerRunning) {
                                          timerModel.startCountdown();
                                        }
                                        Navigator.pushNamed(
                                            context, '/settings');
                                      },
                                      color: Colors.white,
                                      icon: const Icon(Icons.settings))),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                  margin:
                                      const EdgeInsets.only(top: 40, right: 10),
                                  child: OutlinedButton(
                                      onPressed: !isExtension && isTimerRunning
                                          ? timerModel.extensionCountdown
                                          : null,
                                      style: ButtonStyle(
                                        iconColor: MaterialStateProperty
                                            .resolveWith<Color>(
                                          (Set<MaterialState> states) {
                                            if (states.contains(
                                                MaterialState.disabled)) {
                                              return Colors.grey;
                                            }
                                            return Colors.white;
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
                                  margin: const EdgeInsets.only(
                                      bottom: 50, left: 30),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            timerModel.decreasePoint(1);
                                          },
                                          color: Colors.white,
                                          icon: const Icon(Icons
                                              .keyboard_double_arrow_left)),
                                      IconButton(
                                          onPressed: null,
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
                                          icon: const Icon(Icons
                                              .keyboard_double_arrow_right))
                                    ],
                                  )),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 50, right: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            timerModel.decreasePoint(2);
                                          },
                                          color: Colors.white,
                                          icon: const Icon(Icons
                                              .keyboard_double_arrow_left)),
                                      IconButton(
                                          onPressed: null,
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
                                          icon: const Icon(Icons
                                              .keyboard_double_arrow_right))
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                width: 0, color: Colors.transparent)),
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
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.grey;
                                        }
                                        return isTimerRunning
                                            ? Colors.green
                                            : const Color.fromARGB(
                                                255, 182, 124, 0);
                                      },
                                    ),
                                  ),
                                  child: Icon(
                                    isTimerRunning
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                    size: orientation == Orientation.portrait
                                        ? 80
                                        : 40,
                                  ),
                                ),
                                CustomButton(
                                  onPressed: !isBreak
                                      ? null
                                      : timerModel.reloopCountdown,
                                  onLongPress: !isBreak
                                      ? null
                                      : timerModel.resetCountdown,
                                  styleButton: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.grey;
                                        }
                                        return Colors.blue;
                                      },
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.repeat_rounded,
                                    color: Colors.white,
                                    size: orientation == Orientation.portrait
                                        ? 80
                                        : 40,
                                  ),
                                ),
                                CustomButton(
                                  onPressed: isBreak
                                      ? null
                                      : timerModel.breakCountdown,
                                  styleButton: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.grey;
                                        }
                                        return const Color.fromARGB(
                                            255, 72, 51, 94);
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
              )),
    );
  }
}
