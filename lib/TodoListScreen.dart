import 'package:flutter/material.dart';

class TodoListScreen extends StatefulWidget {
  final List<String> todos;

  TodoListScreen(this.todos);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TextEditingController _newTodoController = TextEditingController();
  List<String> deletedTodos = []; // List untuk menyimpan todo yang dihapus

  void _showAddTodoDialog(BuildContext context) {
    _newTodoController.clear();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tambah Todo Baru Kamu Disini'),
              TextField(
                controller: _newTodoController,
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
                      String newTodo = _newTodoController.text;
                      if (newTodo.isNotEmpty) {
                        setState(() {
                          widget.todos.add(newTodo);
                        });
                      }
                      Navigator.pop(context);
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

  void _showEditTodoDialog(BuildContext context, int index) {
    _newTodoController.text = widget.todos[index];
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Apakah Kamu Ingin Edit Todo Ini ? '),
              TextField(
                controller: _newTodoController,
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
                      String editedTodo = _newTodoController.text;
                      if (editedTodo.isNotEmpty) {
                        setState(() {
                          widget.todos[index] = editedTodo;
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: Text('Simpan'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteTodoDialog(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Hapus Todo'),
              Text('Apakah Anda yakin ingin menghapus todo ini?'),
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
                      setState(() {
                        // Pindahkan todo yang akan dihapus ke list sementara
                        deletedTodos.add(widget.todos[index]);
                        widget.todos.removeAt(index);
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Hapus'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // Tambahkan fungsi untuk membatalkan penghapusan todo
  void _cancelDeleteTodo() {
    setState(() {
      // Pindahkan todo dari list sementara ke list utama
      if (deletedTodos.isNotEmpty) {
        widget.todos.add(deletedTodos.removeLast());
      }
    });
  }

  void _toggleTodoStatus(int index) {
    setState(() {
      // If the todo is not marked as completed, add a strikethrough effect
      // If it is already marked as completed, remove the strikethrough effect
      if (!widget.todos[index].startsWith('☑ ')) {
        widget.todos[index] = '☑ ${widget.todos[index]}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Todo'),
      ),
      backgroundColor: Color.fromARGB(255, 130, 153, 189), // Set background color
      body: widget.todos.isEmpty
          ? Center(
              child: Text('List Todo Kamu Kosong'),
            )
          : ListView.builder(
              itemCount: widget.todos.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8.0), // Add margin for spacing
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 137, 211, 213), // Set background color
                    borderRadius: BorderRadius.circular(8.0), // Set border radius
                  ),
                  child: ListTile(
                    title: Text(
                      widget.todos[index],
                      style: TextStyle(
                        // Apply strikethrough effect for completed todos
                        decoration: widget.todos[index].startsWith('✅ ')
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showEditTodoDialog(context, index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteTodoDialog(context, index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.done),
                          onPressed: () {
                            _toggleTodoStatus(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTodoDialog(context);
        },
        child: Icon(Icons.add),
      ),
      // Tambahkan tombol untuk membatalkan penghapusan
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: _cancelDeleteTodo,
          child: Text('Batal Hapus'),
        ),
      ],
    );
  }
}