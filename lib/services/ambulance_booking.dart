// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AmbulanceBooking {
  final String name;
  final String phone;
  final GeoPoint user_location;
  final String status;
  final Timestamp timestamp;
  AmbulanceBooking({
    required this.name,
    required this.phone,
    required this.user_location,
    required this.status,
    required this.timestamp,
  });

  AmbulanceBooking copyWith({
    String? name,
    String? phone,
    GeoPoint? user_location,
    String? status,
    Timestamp? timestamp,
  }) {
    return AmbulanceBooking(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      user_location: user_location ?? this.user_location,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'user_location': user_location,
      'status': status,
      'timestamp': timestamp,
    };
  }

  factory AmbulanceBooking.fromMap(Map<String, dynamic> map) {
    return AmbulanceBooking(
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      user_location: map['user_location'] != null
          ? GeoPoint(map['user_location']['latitude'],
              map['user_location']['longitude'])
          : const GeoPoint(0, 0),
      status: map['status'] as String,
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AmbulanceBooking.fromJson(String source) =>
      AmbulanceBooking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AmbulanceBooking(name: $name, phone: $phone, user_location: $user_location, status: $status, timestamp: $timestamp)';
  }

  @override
  bool operator ==(covariant AmbulanceBooking other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phone == phone &&
        other.user_location == user_location &&
        other.status == status &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        user_location.hashCode ^
        status.hashCode ^
        timestamp.hashCode;
  }

  Future<void> bookAmbulance() async {
    await FirebaseFirestore.instance.collection('bookings').add({
      'name': name,
      'phone': phone,
      'pickup_location': user_location,
      'status': status,
      'timestamp': timestamp,
    });
  }
}
