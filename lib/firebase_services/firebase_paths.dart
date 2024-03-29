enum FirebasePaths {
  blogs('blogs/'),
  clientFeedbacks('client_feedbacks/'),
  events('events/'),
  offers('offers/'),
  projects('projects/'),
  purchasableServices('purchasable_services/'),
  services('services/'),
  messages('messages/'),
  staff('staff/'),
  technologies('technologies/'),
  staffList('staffList/'),
  videos('videos/'),
  counters('counters/'),
  storageBucket('gs://zognest-website.appspot.com/');

  final String path;

  const FirebasePaths(this.path);
}
