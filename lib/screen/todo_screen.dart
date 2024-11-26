import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/item_card.dart';
import '../components/todo_detail.dart';
import '../controllers/todo_controller.dart';
import '../models/todos_models.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView>
    with SingleTickerProviderStateMixin {
  final TodoController _todoController = Get.put(TodoController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Todo Yöneticisi',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: Colors.white,
        tabs: const [
          Tab(icon: Icon(Icons.list), text: 'Aktif Todolar'),
          Tab(icon: Icon(Icons.check_circle), text: 'Tamamlananlar'),
        ],
      ),
      actions: [_buildRefreshAction()],
      flexibleSpace: _buildAppBarGradient(),
    );
  }

  Widget _buildRefreshAction() {
    return Obx(() => _todoController.isLoading.value
        ? const Padding(
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(color: Colors.white),
          )
        : IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _todoController.fetchTodos(),
          ));
  }

  Widget _buildAppBarGradient() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildSearchField(),
        _buildTodoList(),
      ],
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Todo ara...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) => _todoController.updateSearchQuery(value),
      ),
    );
  }

  Widget _buildTodoList() {
    return Expanded(
      child: Obx(() {
        final activeTodos = _todoController.filteredTodos
            .where((todo) => !todo.completed)
            .toList();
        final completedTodos = _todoController.filteredTodos
            .where((todo) => todo.completed)
            .toList();

        return TabBarView(
          controller: _tabController,
          children: [
            _buildTodoSection(activeTodos, false),
            _buildTodoSection(completedTodos, true),
          ],
        );
      }),
    );
  }

  Widget _buildTodoSection(List<TodoModel> todos, bool isCompleted) {
    return todos.isEmpty
        ? Center(
            child: Text(
              isCompleted
                  ? 'Tamamlanmış todo bulunmuyor'
                  : 'Aktif todo bulunmuyor',
            ),
          )
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) => TodoItemCard(
              todo: todos[index],
              onTap: () => _navigateToDetailView(todos[index]),
            ),
          );
  }

  void _navigateToDetailView(TodoModel todo) {
    Get.to(() => TodoDetailView(todo: todo));
  }
}
