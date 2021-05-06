// To parse this JSON data, do
//
//     final dbContact = dbContactFromJson(jsonString);

import 'dart:convert';

DbContact dbContactFromJson(String str) => DbContact.fromJson(json.decode(str));

String dbContactToJson(DbContact data) => json.encode(data.toJson());

class DbContact {
  DbContact({
    this.id,
    this.name,
    this.phones,
  });

  int id;
  String name;
  String phones;

  DbContact copyWith({
    int id,
    String name,
    String phones,
  }) =>
      DbContact(
        id: id ?? this.id,
        name: name ?? this.name,
        phones: phones ?? this.phones,
      );

  factory DbContact.fromJson(Map<String, dynamic> json) => DbContact(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        phones: json["phones"] == null ? null : json["phones"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "phones": phones == null ? null : phones,
      };
}
