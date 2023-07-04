import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class StringToTFLiteExample extends StatefulWidget {
  @override
  _StringToTFLiteExampleState createState() => _StringToTFLiteExampleState();
}

class _StringToTFLiteExampleState extends State<StringToTFLiteExample> {
  late Interpreter _interpreter;
  List<String> _labels = ['Negative', 'Positive']; // Example labels

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  void loadModel() async {
    try {
      String modelPath = 'assets/model.tflite';
      _interpreter = await Interpreter.fromAsset(modelPath);
    } on Exception catch (e) {
      print('Failed to load model: $e');
    }
  }

  List<double> preprocessString(String input) {
    // Perform preprocessing on the input string and convert it into numerical data
    // This is just a sample preprocessing function, you should customize it as per your needs
    List<double> numericalData = [];
    for (int i = 0; i < input.length; i++) {
      numericalData.add(input.codeUnitAt(i).toDouble());
    }
    return numericalData;
  }

  String classifyString(String input) {
    if (_interpreter == null) {
      return 'Model not loaded';
    }

    List<double> inputTensor = preprocessString(input);

    // Prepare the input tensor
    var inputBuffer = Float32List.fromList(inputTensor);
    var inputs = [inputBuffer];
    var inputShape = _interpreter.getInputTensor(0).shape;
    _interpreter.resizeInputTensor(0, inputShape);
    _interpreter.allocateTensors();
    _interpreter.run(0, inputBuffer);

    // Run the inference
    _interpreter.invoke();

    // Get the output tensor
    var outputTensor = _interpreter.getOutputTensor(0);
    var outputBuffer = inputBuffer.buffer;

    var outputValues = outputBuffer.asFloat32List();

    // Find the predicted label
    double maxScore = outputValues[0];
    int maxIndex = 0;
    for (int i = 1; i < outputValues.length; i++) {
      if (outputValues[i] > maxScore) {
        maxScore = outputValues[i];
        maxIndex = i;
      }
    }

    return _labels[maxIndex];
  }

  @override
  void dispose() {
    _interpreter?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('String to TFLite Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter a string:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (value) {
                String classification = classifyString(value);
                print('Input: $value, Classification: $classification');
              },
            ),
          ],
        ),
      ),
    );
  }
}
