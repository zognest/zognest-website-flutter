enum FirebasePaths {
  blogs('blogs/'),
  clientFeedbacks('client_feedbacks/'),
  events('events/'),
  offers('offers/'),
  projects('projects/', ''),
  purchasableServices('purchasable_services/'),
  services('services/'),
  staff('staff/'),
  technologies('technologies/');

  final String firestorePath;
  final String? storagePath;

  const FirebasePaths(this.firestorePath, [this.storagePath]);
}
