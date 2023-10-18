class ClientFeedback {
  final String clientImage;
  final String name;
  final String id;
  final List<String> backgroundImages;
  final String description;

  ClientFeedback({
    required this.description,
    required this.clientImage,
    required this.name,
    required this.id,
    required this.backgroundImages,
  });
}
