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
  double lat;
  double long;

  Address(this.city, this.street, this.zipCode, { this.lat, this.long });

  Address.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        street = json['street'],
        zipCode = json['zipCode'],
        lat = json['lat'],
        long = json['long']
  ;

  Map<String, dynamic> toJson() =>
      {'city': city, 'street': street, 'zipCode': zipCode, 'lat': lat, 'long': long};

  bool isEmpty() {
    return this.city == null && this.street == null && this.zipCode == null;
  }

  String encodedAddress() {
    return "${this.street.replaceAll(' ', '+')}+"
        "${this.city.replaceAll(' ', '+')}+"
        "${this.zipCode.replaceAll(' ', '+')}";
  }
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
        creationDateTime = DateTime.tryParse(json['creationDateTime']);

  Map<String, dynamic> toJson() => {
        'firstname': firstname,
        'lastname': lastname,
        'birthdate': birthdate.toString(),
        'birthplace': birthplace,
        'address': address.toJson(),
        'type': type.toString(),
        'creationDateTime': creationDateTime.toString(),
      };

  bool isEmpty() {
    return this.firstname == null && this.lastname == null &&
        this.birthdate == null && this.birthplace == null && this.address.isEmpty();
  }

  bool hasMovementType() {
    return this.type != null;
  }
}
