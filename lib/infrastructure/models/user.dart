import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class User extends Equatable {
  const User(
    this.id,
    this.name,
    this.username,
    this.email,
    this.address,
    this.phone,
    this.website,
    this.company,
  );

  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final Address? address;
  final String? phone;
  final String? website;
  final Company? company;

  factory User.fromJson(Map<String, dynamic> json) => User(
        json["id"],
        json["name"],
        json["username"],
        json["email"],
        Address.fromJson(json["address"]),
        json["phone"],
        json["website"],
        Company.fromJson(json["company"]),
      );

  @override
  List<Object?> get props =>
      [id, username, name, email, address, phone, website, address];
}

class UserAdapter extends TypeAdapter<User> {
  @override
  User read(BinaryReader reader) {
    // var numOfFields = reader.readByte();
    // var fields = <int, dynamic>{
    //   for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    // };
    return User(
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
      reader.read(),
    );
  }

  @override
  final typeId = 0;

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..write(obj.id)
      ..write(obj.name)
      ..write(obj.username)
      ..write(obj.email)
      ..write(obj.address)
      ..write(obj.phone)
      ..write(obj.website)
      ..write(obj.company);
  }
}

@HiveType(typeId: 1)
class Address {
  Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  String? street;
  String? suite;
  String? city;
  String? zipcode;
  Geo? geo;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: Geo.fromJson(json["geo"]),
      );
}

class AddressAdapter extends TypeAdapter<Address> {
  @override
  Address read(BinaryReader reader) {
    return Address(
      street: reader.read(),
      suite: reader.read(),
      city: reader.read(),
      zipcode: reader.read(),
      geo: reader.read(),
    );
  }

  @override
  final typeId = 1;

  @override
  void write(BinaryWriter writer, Address obj) {
    writer
      ..write(obj.street)
      ..write(obj.suite)
      ..write(obj.city)
      ..write(obj.zipcode)
      ..write(obj.geo);
  }
}

@HiveType(typeId: 2)
class Geo {
  Geo({
    this.lat,
    this.lng,
  });

  String? lat;
  String? lng;

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        lat: json["lat"],
        lng: json["lng"],
      );
}

class GeoAdapter extends TypeAdapter<Geo> {
  @override
  Geo read(BinaryReader reader) {
    return Geo(
      lat: reader.read(),
      lng: reader.read(),
    );
  }

  @override
  final typeId = 2;

  @override
  void write(BinaryWriter writer, Geo obj) {
    writer
      ..write(obj.lat)
      ..write(obj.lng);
  }
}

@HiveType(typeId: 3)
class Company {
  Company({
    this.name,
    this.catchPhrase,
    this.bs,
  });

  String? name;
  String? catchPhrase;
  String? bs;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );
}

class CompanyAdapter extends TypeAdapter<Company> {
  @override
  Company read(BinaryReader reader) {
    return Company(
      name: reader.read(),
      catchPhrase: reader.read(),
      bs: reader.read(),
    );
  }

  @override
  final typeId = 3;

  @override
  void write(BinaryWriter writer, Company obj) {
    writer
      ..write(obj.name)
      ..write(obj.catchPhrase)
      ..write(obj.bs);
  }
}
