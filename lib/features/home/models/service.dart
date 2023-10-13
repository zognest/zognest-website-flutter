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

class Technology {
  final String name;
  final String image;

  Technology({
    required this.name,
    required this.image,
  });
}
