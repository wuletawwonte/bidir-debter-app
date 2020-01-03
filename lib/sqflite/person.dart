
class Person  {
  int id;
  String firstName;
  String lastName;

  Person(this.id, this.firstName, this.lastName);
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'id': id,
      'first_name': firstName,
      'last_name': lastName
    };

    return map;
  }

  Person.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    firstName = map['first_name'];
    lastName = map['last_name'];
  }

}