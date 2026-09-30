class Note {
  final String title;
  final String content;

  Note({required this.title, required this.content});

  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
      };

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}
