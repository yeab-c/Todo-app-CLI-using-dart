import 'dart:io';
import 'task.dart';

class TaskManager{
  List<Task> tasks = [];
  final File file = File("tasks.txt");

  void addTask(String description){
    var des = Task(description);
    addToFile(des.description);
  }

  Future<int> numOfTasks() async{
    await createFileIfNotExists();
    var contents = await file.readAsString();
    if (contents.trim().isNotEmpty){
      tasks = contents.split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => Task(line))
          .toList();
      return tasks.length;
    } else{
      return 0;
    }
  }

  String show() {
    String result = "";
    String msg = "Enter '+' to add a task\n";
    for (int i = 0; i < tasks.length; i++) {
      result += "${i + 1}. ${tasks[i].toString()}\n";
    }
    return result + msg;
  }

  // "num" is the number that is visible before each task.
  String showSingleTask(int num){
    int index = num - 1;
    if (index >= 0 && index < tasks.length){
      return "$num. ${tasks[index].toString()} \n";
    } else{
      return "Invalid input";
    }
  }


  void edit(int num, String description){
    int index = num - 1;
    if (index >= 0 && index < tasks.length){
      tasks[index].description = description;
    }else {
      print("Invalid Input");
    }
  }

  void delete(int index){
    index = index - 1;
    if (index >= 0 && index < tasks.length){
      tasks.removeAt(index);
    } else{
      print("Invalid Input");
    }
  }

  Future<void> createFileIfNotExists() async{
    if (!await file.exists()) {
      await file.create(recursive: true);
      print('File created: ${file.path}');
    }
  }

  Future<void> addToFile(String data) async{
    await createFileIfNotExists();
    await file.writeAsString("$data\n", mode: FileMode.append);
    print("Task added successfully");
  }

  Future<void> loadFromFile() async{
    await createFileIfNotExists();
    var contents = await file.readAsString();
    if (contents.trim().isNotEmpty){
      tasks = contents.split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => Task(line))
          .toList();

    } else{
      print("No tasks available");
    }
  }

  Future<void> singleLoadFromFile(int num) async{
    await createFileIfNotExists();
    var contents = await file.readAsString();
    if (contents.trim().isNotEmpty){
      tasks = contents.split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => Task(line))
          .toList();
      print(showSingleTask(num));
    } else{
      print("No tasks available");
    }
  }

  Future<void> removeTask(int num) async {
    await createFileIfNotExists();
    var contents = await file.readAsString();

    if (contents.trim().isNotEmpty) {
      tasks = contents
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => Task(line))
          .toList();

      int index = num - 1;
      if (index >= 0 && index < tasks.length) {
        tasks.removeAt(index);
      } else {
        print("Invalid task number");
        return;
      }
      await file.writeAsString(tasks.map((t) => t.description).join('\n'));
      print("Task removed successfully");
    } else {
      print("No tasks available");
    }
  }

  Future<void> editTask(int num, String description) async{
    await createFileIfNotExists();
    var contents = await file.readAsString();
    if (contents.trim().isNotEmpty){
      tasks = contents.split('\n')
          .where((line) => line.trim().isNotEmpty)
          .map((line) => Task(line))
          .toList();
      edit(num, description);
      await file.writeAsString("");
      for (final task in tasks){
        await file.writeAsString("$task\n", mode: FileMode.append);
      }
    }else{
      print("No tasks available");
    }
  }
}