import 'package:zognest_website/shared/models/technology.dart';

class Service {
  final String highlight;
  final String title;
  final String description;
  final List<Technology> technologies;

  Service({
    required this.highlight,
    required this.title,
    required this.description,
    required this.technologies,
  });
}
