import 'package:flutter/material.dart';
import 'TodoListScreen.dart';

class AddTodoScreen extends StatelessWidget {
  final List<String> todos = []; // List to store todos

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo APP'),
      ),
      body: Container(
        color: Color.fromARGB(255, 130, 153, 189),
        child: Center(
          child: GestureDetector(
            onTap: () {
              _showAddTodoBottomSheet(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.black,
                ),
                SizedBox(height: 10),
                Text(
                  'Tambah Todo Kamu Disini',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddTodoBottomSheet(BuildContext context) {
    String newTodo = '';

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Apa yang ingin kamu lakukan ?'),
              TextField(
                onChanged: (value) {
                  newTodo = value;
                },
                decoration: InputDecoration(labelText: 'Todo'),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add the new todo to the list
                      todos.add(newTodo);
                      Navigator.pop(context); // Close the bottom sheet
                      _navigateToTodoListScreen(context);
                    },
                    child: Text('Tambah'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToTodoListScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TodoListScreen(todos)),
    );
  }
}