import 'package:ahp/model/ahp_model.dart';
import 'package:flutter/material.dart';

class CriteriaComparisonScreen extends StatefulWidget {
  final List<String> criteriaList;

  CriteriaComparisonScreen({required this.criteriaList});

  @override
  _CriteriaComparisonScreenState createState() =>
      _CriteriaComparisonScreenState();
}

class _CriteriaComparisonScreenState extends State<CriteriaComparisonScreen> {
  Map<String, double> choiceValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criteria Comparison'),
      ),
      body: ListView.builder(
        itemCount: widget.criteriaList.length,
        itemBuilder: (context, index) {
          final currentCriteria = widget.criteriaList[index];
          final remainingCriteria = widget.criteriaList.sublist(index + 1);

          return Column(
            children: [
              ...remainingCriteria.map((otherCriteria) {
                final choiceKey = '$currentCriteria-$otherCriteria';
                final reverseChoiceKey = '$otherCriteria-$currentCriteria';

                return Column(
                  children: [
                    RadioListTile<double>(
                      title: Text("$currentCriteria is more important than $otherCriteria"),
                      // subtitle: Text(otherCriteria),
                      value: choiceValues[choiceKey] ?? 1.0,
                      groupValue: choiceValues[reverseChoiceKey],
                      onChanged: (value) {
                        setState(() {
                          choiceValues[choiceKey] = value!;
                          choiceValues[reverseChoiceKey] = 1 / value!;
                        });
                      },
                    ),
                    Slider(
                      value: choiceValues[choiceKey] ?? 1.0,
                      min: 1,
                      max: 10,
                      divisions: 9,
                      onChanged: (value) {
                        setState(() {
                          choiceValues[choiceKey] = value;
                          choiceValues[reverseChoiceKey] = 1 / value;
                        });
                      },
                    ),
                  ],
                );
              }).toList(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call the isCoherent method from the AHPModel class
          // AHPModel.isCoherent(choiceValues);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}