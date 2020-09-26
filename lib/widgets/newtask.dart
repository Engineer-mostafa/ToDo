import 'package:flutter/material.dart';

class NewTask extends StatefulWidget {
  final Function addTask;
  final int id;

  NewTask(this.addTask, this.id);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final _taskNameController = TextEditingController();

  final _fromController = TextEditingController();

  final _toController = TextEditingController();

  void submitData() {
    final enteredName = _taskNameController.text;
    final enteredFrom = double.parse(_fromController.text);
    final enteredTo = double.parse(_toController.text);

    if (enteredName.isEmpty ||
        enteredFrom <= 0 ||
        enteredTo <= 0 ||
        enteredFrom > 12 ||
        enteredTo > 12) {
      return;
    }

    widget.addTask(widget.id, enteredName, enteredFrom, enteredTo);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 500,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Task Name'),
                controller: _taskNameController,
                onSubmitted: (_) => submitData(),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 35, 10),
                      child: new TextField(
                        decoration: InputDecoration(labelText: 'From'),
                        controller: _fromController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => submitData(),
                      ),
                    ),
                  ),
                  new Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
                      child: new TextField(
                        decoration: InputDecoration(labelText: 'To'),
                        keyboardType: TextInputType.number,
                        controller: _toController,
                        onSubmitted: (_) => submitData(),
                      ),
                    ),
                  ),
                ],
              ),
              RaisedButton(
                child: Text(
                  'Add Task',
                  style: TextStyle(color: Theme.of(context).buttonColor),
                ),
                color: Theme.of(context).primaryColor,
                onPressed: submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
