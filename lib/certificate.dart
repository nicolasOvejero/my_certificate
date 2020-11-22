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

  Address(this.city, this.street, this.zipCode);

  Address.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        street = json['street'],
        zipCode = json['zipCode'];

  Map<String, dynamic> toJson() =>
      {'city': city, 'street': street, 'zipCode': zipCode};
}

class Certificate {
  String firstname;
  String lastname;
  DateTime birthdate;
  String birthplace;
  Address address;
  MovementType type;
  DateTime creationDateTime;

  Certificate();

  Certificate.fromJson(Map<String, dynamic> json)
      : firstname = json['firstname'],
        lastname = json['lastname'],
        birthdate = DateTime.parse(json['birthdate']),
        birthplace = json['birthplace'],
        address = Address.fromJson(json['address']),
        type = MovementType.values.singleWhere(
            (enumItem) => enumItem.toString() == json['type'],
            orElse: () => null),
        creationDateTime = DateTime.parse(json['creationDateTime']);

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'birthdate': birthdate.toString(),
        'birthplace': birthplace,
        'address': address.toJson(),
        'type': type.toString(),
        'creationDateTime': creationDateTime.toString(),
      };
}
