import 'package:zognest_website/shared/models/technology.dart';

class Staff {
  final String name;
  final String position;
  final String description;
  final String url;
  final List<Technology> technologies;

  Staff({
    required this.name,
    required this.position,
    required this.description,
    required this.url,
    required this.technologies,
  });
}
