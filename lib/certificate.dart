enum MovementType {
  work,
  shopping,
  medical,
  family,
  handicap,
  sport,
  administrative,
  general_interest,
  school
}

class Address {
  String city;
  String street;
  String zipCode;
}

class Certificate {
  String firstname;
  String lastname;
  String birthdate;
  String birthplace;
  Address address;
  MovementType type;
}