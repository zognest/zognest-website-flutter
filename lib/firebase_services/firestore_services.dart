import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/firebase_services/firebase_paths.dart';

class FirestoreServices {
  static final firestore = FirebaseFirestore.instance;

  static Future<List<Blog>> getBlogs() async {
    final blogsJson =
        await firestore.collection(FirestorePaths.blogs.path).get();

    final blogs =
        blogsJson.docs.map((blogDoc) => Blog.fromMap(blogDoc.data())).toList();

    return blogs;
  }

  static Future<List<ClientFeedback>> getClientFeedbacks() async {
    final clientFeedbacksJson =
        await firestore.collection(FirestorePaths.clientFeedbacks.path).get();

    final clientFeedbacks = clientFeedbacksJson.docs
        .map((feedbackDoc) => ClientFeedback.fromMap(feedbackDoc.data()))
        .toList();

    return clientFeedbacks;
  }

  static Future<List<Event>> getEvents() async {
    final eventsJson =
        await firestore.collection(FirestorePaths.events.path).get();

    final events = eventsJson.docs
        .map((eventDoc) => Event.fromMap(eventDoc.data()))
        .toList();

    return events;
  }

  static Future<List<Offer>> getOffers() async {
    final offersJson =
        await firestore.collection(FirestorePaths.offers.path).get();

    final offers = offersJson.docs
        .map((offerDoc) => Offer.fromMap(offerDoc.data()))
        .toList();

    return offers;
  }
}
