import 'package:meta/meta.dart';

@immutable
class UserDataModel {
  final String id;
  final String name;
  final String image;

  const UserDataModel({
    required this.id,
    required this.name,
    required this.image,
  });
}