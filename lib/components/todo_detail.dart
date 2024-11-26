import 'package:flutter/material.dart';
import '../models/todos_models.dart';

class TodoDetailView extends StatelessWidget {
  final TodoModel todo;

  const TodoDetailView({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo Detayı'),
        backgroundColor: todo.completed ? Colors.green : Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTitleText(),
              const SizedBox(height: 20),
              _buildStatusChip(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleText() {
    return Text(
      todo.title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildStatusChip() {
    return Chip(
      label: Text(
        todo.completed ? 'Tamamlandı' : 'Devam Ediyor',
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: todo.completed ? Colors.green : Colors.blue,
    );
  }
}
