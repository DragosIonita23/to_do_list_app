class Task {

  int id;
  String title;
  String description;
  String category; // 2 categories for importance hierarchy
  bool done;
  // NORMAL and IMPORTANT

  Task(this.id, this.title, this.description, this.category, this.done);

  // TO DO SQLITE: TOMAP and FROMMAP

}