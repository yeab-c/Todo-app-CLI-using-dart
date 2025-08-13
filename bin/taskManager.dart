import 'task.dart';

class TaskManager{
  List<Task> tasks = [];

  void addTask(String description){
    var des = Task(description);
    tasks.add(des);
  }
  String show() {
    String result = "";
    for (int i = 0; i < tasks.length; i++) {
      result += "${i + 1}. ${tasks[i].toString()}\n";
    }
    return result;
  }

  void edit(int index, String description){
    index = index - 1;
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
}

void main(){
  var manager = TaskManager();
  manager.addTask("Go shopping");
  manager.addTask("description");
  print(manager.show());
  manager.edit(2, "Go do something");
  print(manager.show());
  manager.delete(1);
  print(manager.show());
}