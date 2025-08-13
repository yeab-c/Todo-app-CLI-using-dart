class Task {
  String description;
  bool isDone;

  Task(this.description, {this.isDone = false});

  String toString(){
    if (isDone){
      return "[x] $description";
    } else{
      return "[ ] $description";
    }
  }
}

