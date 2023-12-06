enum FirestorePaths {
  blogs('blogs/'),
  clientFeedbacks('client_feedbacks/'),
  events('events/'),
  offers('offers/'),
  projects('projects/', storagePath: ''),
  purchasableServices('purchasable_services/'),
  services('services/'),
  staff('staff/'),
  technologies('technologies/');

  final String path;
  final String? storagePath;

  const FirestorePaths(this.path, {this.storagePath});
}
