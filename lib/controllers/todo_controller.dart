import 'package:get/get.dart';
import '../metods/todos_metods.dart';
import '../models/todos_models.dart';

class TodoController extends GetxController {
  final RxList<TodoModel> todos = <TodoModel>[].obs;
  final RxList<TodoModel> filteredTodos = <TodoModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodos();
    ever(searchQuery, (_) => filterTodos());
  }

  Future<void> fetchTodos() async {
    try {
      isLoading.value = true;
      final fetchedTodos = await TodosMetods().fetchTodos();
      todos.value = fetchedTodos;
      filteredTodos.value = fetchedTodos;
    } catch (e) {
      Get.snackbar(
        'Hata',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void addTodo(String title) {
    final newTodo =
        TodoModel(id: DateTime.now().millisecondsSinceEpoch, title: title);
    todos.add(newTodo);
    filteredTodos.add(newTodo);
  }

  void toggleTodoStatus(TodoModel todo) {
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index].completed = !todos[index].completed;
      todos.refresh();
      filterTodos();
    }
  }

  void filterTodos() {
    if (searchQuery.value.isEmpty) {
      filteredTodos.value = List.from(todos);
    } else {
      filteredTodos.value = todos
          .where((todo) => todo.title
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
