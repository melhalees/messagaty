import 'package:meta/meta.dart';

@immutable
class StoryDataModel {
  const StoryDataModel({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;
}