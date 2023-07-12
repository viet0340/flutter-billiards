import 'package:billiards_countdown/providers/timermodel_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerTimeInitialized =
      TextEditingController();
  final TextEditingController _controllerTimeBreak = TextEditingController();
  final TextEditingController _controllerTimeExtension =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    final timerModel = Provider.of<TimerModel>(context, listen: false);
    final timeInitialized = timerModel.timeInitialized;
    final timeBreak = timerModel.timeBreak;
    final timeExtension = timerModel.timeExtension;

    _controllerTimeInitialized.text = timeInitialized.toString();
    _controllerTimeBreak.text = timeBreak.toString();
    _controllerTimeExtension.text = timeExtension.toString();
  }

  @override
  Widget build(BuildContext context) {
    final timerModel = Provider.of<TimerModel>(context, listen: false);
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  controller: _controllerTimeInitialized,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Time Loop',
                    prefixIcon: const Icon(Icons.timer),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    timerModel.changeTime(time: int.parse(value), type: 'initialized');
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter time loop';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  controller: _controllerTimeBreak,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Time Break',
                    prefixIcon: const Icon(Icons.timer),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    timerModel.changeTime(time: int.parse(value), type: 'break');
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter time break';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  controller: _controllerTimeExtension,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Time Extension',
                    prefixIcon: const Icon(Icons.timer),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    timerModel.changeTime(time: int.parse(value), type: 'extension');
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter time extension';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              // style: ButtonStyle(backgroundColor: MaterialStateColor.),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
