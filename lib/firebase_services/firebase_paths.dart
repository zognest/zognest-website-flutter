enum FirebasePaths {
  /// Storage Instructions: Upload directly
  blogs('blogs/', ''),

  /// Storage Instructions: client_name/
  clientFeedbacks('client_feedbacks/', ''),

  /// Storage Instructions: event_name/
  events('events/', ''),
  offers('offers/'),

  /// Storage Instructions: project_name/
  projects('projects/', ''),

  /// Storage Instructions: Upload directly
  purchasableServices('purchasable_services/', ''),
  services('services/'),
  staff('staff/'),
  technologies('technologies/', ''),
  storageBucket('', 'gs://zognest-website.appspot.com/');

  final String firestorePath;
  final String? storagePath;

  const FirebasePaths(this.firestorePath, [this.storagePath]);
}
