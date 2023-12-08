enum FirebasePaths {
  blogs('blogs/', ''),
  clientFeedbacks('client_feedbacks/', ''),
  events('events/', ''),
  offers('offers/'),
  projects('projects/', ''),
  purchasableServices('purchasable_services/', ''),
  services('services/'),
  staff('staff/'),
  technologies('technologies/', ''),
  videos('videos/', ''),
  storageBucket('', 'gs://zognest-website.appspot.com/');

  final String firestorePath;
  final String? storagePath;

  const FirebasePaths(this.firestorePath, [this.storagePath]);
}
