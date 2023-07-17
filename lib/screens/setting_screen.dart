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
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: TextFormField(
                  controller: _controllerTimeInitialized,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Time Loop', // Đặt văn bản cho nhãn
                    labelStyle:
                        TextStyle(color: Colors.white), // Đặt màu chữ cho nhãn
                    hintStyle: TextStyle(
                        color: Colors.grey), // Đặt màu chữ cho văn bản gợi ý
                    prefixIcon: Icon(Icons.person,
                        color: Colors
                            .white), // Đặt biểu tượng tiền tố và màu của nó
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .blue), // Đặt màu viền khi trường được kích hoạt
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors
                              .blue), // Đặt màu viền khi trường được tập trung
                    ),
                  ),
                  onChanged: (value) {
                    timerModel.changeTime(
                        time: value.isEmpty ? 0 : int.parse(value),
                        type: 'initialized');
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
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Time Break',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  onChanged: (value) {
                    timerModel.changeTime(
                        time: value.isEmpty ? 0 : int.parse(value),
                        type: 'break');
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
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Time Extension',
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  onChanged: (value) {
                    timerModel.changeTime(
                        time: value.isEmpty ? 0 : int.parse(value),
                        type: 'extension');
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
    );
  }
}
