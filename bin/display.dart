import 'dart:io';
import 'taskManager.dart';

class Display {
  final TaskManager manager = TaskManager();

  Future<void> start() async {
    await manager.loadFromFile();

    while (true) {
      print("\n=== Things To Do ===");
      print(manager.show());
      String? input = stdin.readLineSync();

      if (input == "+") {
        print("Enter new task description:");
        String? desc = stdin.readLineSync();
        if (desc != null && desc.trim().isNotEmpty) {
          await manager.addToFile(desc);
          await manager.loadFromFile();
        }
      } else if (int.tryParse(input ?? "") != null){
        int numChoice = int.parse(input!);
        int totalTasks = await manager.numOfTasks();
        if(numChoice > totalTasks){
          print("Invalid task number");
        } else{
          await manager.singleLoadFromFile(numChoice);
          await _singleTaskMenu(numChoice);
        }
      } else {
        print("Invalid input, try again!");
      }
    }
  }

  Future<void> _singleTaskMenu(int num) async {
    print("\n1. Edit");
    print("2. Delete");
    print("3. Go Back");

    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        print("Enter new description:");
        String? desc = stdin.readLineSync();
        if (desc != null) {
          await manager.editTask(num, desc);
        }
        break;
      case "2":
        await manager.removeTask(num);
        break;
      case "3":
        return;
      default:
        print("Invalid choice.");
    }
  }
}

void main() {
  Display().start();
}
