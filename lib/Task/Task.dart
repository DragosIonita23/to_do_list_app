class Task {

  int id;
  String title;
  String description;
  String category; // 2 categories for importance hierarchy
  int done; // 0 for false, 1 for true
  // NORMAL and IMPORTANT

  Task(this.id, this.title, this.description, this.category, this.done);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'done': done,
    };
  }

}