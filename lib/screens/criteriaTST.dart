import 'package:ahp/model/ahp_model.dart';
import 'package:flutter/material.dart';
// import 'package:ahp/ahp_model.dart';

class TESTING extends StatefulWidget {
  final List<String> choices;

  TESTING({required this.choices});

  @override
  _TESTINGState createState() => _TESTINGState();
}

class _TESTINGState extends State<TESTING> {
  Map<String, double> selectedChoices = {};
  Map<String, bool> checkboxValues = {};
  Map<String, double> sliderValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criteria Screen'),
      ),
      body: ListView.builder(
          itemCount: widget.choices.length - 1,
          itemBuilder: (context, index) {
            final choiceA = widget.choices[index];
            final choiceB = widget.choices[index + 1];

            return Column(
              children: [
                for (int i = index + 1; i < widget.choices.length; i++)
                  Column(
                    children: [
                      CheckboxListTile(
                        title: Text(
                            '$choiceA is more importatnt then ${widget.choices[i]}'),
                        value:
                            checkboxValues['$choiceA-${widget.choices[i]}'] ??
                                false,
                        onChanged: (value) {
                          setState(() {
                            checkboxValues['$choiceA-${widget.choices[i]}'] =
                                value ?? false;
                            checkboxValues['${widget.choices[i]}-$choiceA'] =
                                value ?? false;
                            sliderValues['$choiceA-${widget.choices[i]}'] =
                                (value!
                                    ? 1.0
                                    : sliderValues[
                                        '$choiceA-${widget.choices[i]}'])!;
                            // sliderValues['${widget.choices[i]}-$choiceA'] =
                            //     (value! ? 1.0 : null)!;
                          });
                        },
                      ),
                      Slider(
                        value: sliderValues['$choiceA-${widget.choices[i]}'] ??
                            1.0,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        onChanged: (value) {
                          setState(() {
                            sliderValues['$choiceA-${widget.choices[i]}'] =
                                value;
                            sliderValues['${widget.choices[i]}-$choiceA'] =
                                1 / value;
                            checkboxValues['$choiceA-${widget.choices[i]}'] =
                                value != 1.0;
                            checkboxValues['${widget.choices[i]}-$choiceA'] =
                                value != 1.0;
                          });
                        },
                      ),
                      Text(
                        '${sliderValues['$choiceA-${widget.choices[i]}'] ?? 1.0}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final matrix = generateMatrix();
          // final ahpModel = AHPModel();
          final isCoherent = AHPModel.isCoherent(matrix);

          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Coherence Check'),
                content: Text(
                    'The matrix is ${isCoherent ? 'coherent' : 'not coherent'}.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.check),
      ),
    );
  }

  List<List<double>> generateMatrix() {
    final matrix = List.generate(
      widget.choices.length,
      (_) => List<double>.filled(widget.choices.length, 1.0),
    );

    for (var i = 0; i < widget.choices.length; i++) {
      for (var j = i + 1; j < widget.choices.length; j++) {
        final choiceA = widget.choices[i];
        final choiceB = widget.choices[j];

        final checkboxValue = checkboxValues['$choiceA-$choiceB'] ?? false;
        final sliderValue = sliderValues['$choiceA-$choiceB'] ?? 1.0;

        if (checkboxValue) {
          matrix[i][j] = sliderValue;
          matrix[j][i] = 1 / sliderValue;
        } else {
          matrix[j][i] = sliderValue;
          matrix[i][j] = 1 / sliderValue;
        }
      }
    }

    return matrix;
  }
}
