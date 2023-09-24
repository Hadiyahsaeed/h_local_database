
class Student{
  final int? id;
  final String student;
  // ignore: non_constant_identifier_names
  final String student_description;

  // ignore: non_constant_identifier_names
  const Student({required this.student, required this.student_description, this.id, Student? title, required description});

  factory Student.fromJson(Map<String,dynamic> json) => Student(
    id: json['id'],
    student: json['student'],
    student_description: json['student_description'], description: null
  );

  Map<String,dynamic> toJson() => {
    'id': id,
    'student': student,
    'student_description': student_description,
  };
}