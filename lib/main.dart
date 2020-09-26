import 'package:flutter/material.dart';
import './widgets/newtask.dart';
import './widgets/cards_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(59, 66, 84, 1),
        backgroundColor: Color.fromRGBO(59, 66, 84, 1),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Myclass(),
    );
  }
}

class Myclass extends StatefulWidget {
  @override
  _MyclassState createState() => _MyclassState();
}

class _MyclassState extends State<Myclass> {
  int id = 0;

  final List<Cards> _toDoList = [];

  void _addNewTask(int id, String taskName, double from, double to) {
    final newTask = Cards(
      id,
      taskName,
      from,
      to,
    );
    setState(() {
      _toDoList.insert(0, newTask);
    });
  }

  void _deleteTx(int id) {
    setState(() {
      _toDoList.removeWhere((task) => task.id == id);
    });
  }

  void _startAddNewTask(BuildContext ctx, int id) {
    showModalBottomSheet(isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTask(_addNewTask, id),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: Image.asset(
          'assests/images/1.png',
        ),
        title: Text('ToDo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTask(context, id++),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: _toDoList.length == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'no tasks added yet !',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Image.asset('assests/images/2.png')
                ],
              ),
            )
          : Container(
              child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Color.fromRGBO(66, 74, 94, 1),
                      elevation: 10,
                      child: ListTile(
                        leading: Container(
                          child: Column(
                            children: [
                              Text(
                                'Total Time',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                              CircleAvatar(
                                radius: 20,
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Text(
                                    _toDoList[index].timeTo >
                                            _toDoList[index].timeFrom
                                        ? '${_toDoList[index].timeTo - _toDoList[index].timeFrom}'
                                        : '${_toDoList[index].timeTo - _toDoList[index].timeFrom + 12}',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        title: Text(
                          _toDoList[index].taskName,
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                            'From: ${_toDoList[index].timeFrom}\nTo     : ${_toDoList[index].timeTo}',
                            style: TextStyle(color: Colors.amber)),
                        trailing: IconButton(
                          color: Theme.of(context).errorColor,
                          onPressed: () => _deleteTx(_toDoList[index].id),
                          icon: Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                  itemCount: _toDoList.length),
            ),
    );
  }
}
