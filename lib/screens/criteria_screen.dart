import 'package:ahp/screens/criteriaTST.dart';
import 'package:flutter/material.dart';

class CriteriaScreen extends StatefulWidget {
  const CriteriaScreen({super.key});

  @override
  _CriteriaScreenState createState() => _CriteriaScreenState();
}

class _CriteriaScreenState extends State<CriteriaScreen> {
  final _criteriaList = <String>[];

  final _criteriaController = TextEditingController();

  @override
  void dispose() {
    _criteriaController.dispose();
    super.dispose();
  }

  void _addCriteria() {
    final iter_criteria = _criteriaController.text;

    if (iter_criteria.isNotEmpty) {
      setState(() {
        _criteriaList.add(iter_criteria);
      });

      _criteriaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Criteria'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TESTING(choices: _criteriaList),
                ),
              );
            },
            icon: const Icon(Icons.arrow_forward),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _criteriaList.length,
        itemBuilder: (context, index) {
          final criteria = _criteriaList[index];

          return ListTile(
            title: Text(criteria),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Criteria'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _criteriaController,
                      decoration: const InputDecoration(
                        labelText: 'Criteria',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addCriteria();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
