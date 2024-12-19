class Todo{
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  Todo(this.title, this.description, this.dateTime, [this.isDone = false]);
}
