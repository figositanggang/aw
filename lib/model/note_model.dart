class Note {
  int id;
  String note;

  Note(this.id, this.note);

  Map<String, dynamic> toMap() => {'id': this.id, 'note': this.note};

  String toString() => "id: ${this.id}, name:${this.note}";
}
