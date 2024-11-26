import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:get/get.dart';
import '../controllers/todo_controller.dart';
import '../models/todos_models.dart';

class TodoItemCard extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onTap;

  const TodoItemCard({super.key, required this.todo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: (context, action) => _buildClosedContent(),
      openBuilder: (context, action) => _buildOpenContent(),
      transitionType: ContainerTransitionType.fadeThrough,
    );
  }

  Widget _buildClosedContent() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: _buildDecoration(),
      child: _buildContent(),
    );
  }

  Widget _buildOpenContent() {
    onTap();
    return Container();
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: todo.completed
            ? [Colors.green.shade100, Colors.green.shade50]
            : [Colors.blue.shade100, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Row(
      children: [
        Expanded(
          child: Text(
            todo.title,
            style: _buildTextStyle(),
          ),
        ),
        Checkbox(
          activeColor: Colors.green,
          value: todo.completed,
          onChanged: (_) => _toggleTodoStatus(),
        ),
      ],
    );
  }

  TextStyle _buildTextStyle() {
    return TextStyle(
      decoration:
          todo.completed ? TextDecoration.lineThrough : TextDecoration.none,
      color: todo.completed ? Colors.green.shade700 : Colors.blue.shade700,
      fontWeight: FontWeight.w600,
    );
  }

  void _toggleTodoStatus() {
    Get.put(TodoController()).toggleTodoStatus(todo);
  }
}
