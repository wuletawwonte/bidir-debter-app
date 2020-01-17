
class Person  {
  int id;
  String firstName;
  String lastName;
  int profileColor;

  Person(this.id, this.firstName, this.lastName, this.profileColor);
  
  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'person_id': id,
      'first_name': firstName,
      'last_name': lastName,
      'profile_color': profileColor
    };

    return map;
  }

  Person.fromMap(Map<String, dynamic> map) {
    id = map['person_id'];
    firstName = map['first_name'];
    lastName = map['last_name'];
    profileColor = map['profile_color'];
  }

}