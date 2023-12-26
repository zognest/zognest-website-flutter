import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/features/home/models/service.dart';
import 'package:zognest_website/features/our_services/models/purchasable_service.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/features/our_work/models/project.dart';
import 'package:zognest_website/firebase_services/firebase_paths.dart';

class FirestoreServices {
  static final firestore = FirebaseFirestore.instance;

  static Future<List<Blog>> getBlogs() async {
    final blogsJson =
    await firestore.collection(FirebasePaths.blogs.path).get();

      final blogs =
        blogsJson.docs.map((blogDoc) => Blog.fromMap(blogDoc.data())).toList();

    return blogs;
  }

//part 1
  static Future<List<ClientFeedback>> getClientFeedbacks() async {
    final clientFeedbacksJson =
    await firestore.collection(FirebasePaths.clientFeedbacks.path).get();

    final clientFeedbacks = clientFeedbacksJson.docs
        .map((feedbackDoc) => ClientFeedback.fromMap(feedbackDoc.data()))
        .toList();

    return clientFeedbacks;
  }

//part 2
  static Future<List<Event>> getEvents() async {
    final eventsJson =
    await firestore.collection(FirebasePaths.events.path).get();

    final events = eventsJson.docs
        .map((eventDoc) => Event.fromMap(eventDoc.data()))
        .toList();

    return events;
  }

//part 3
  static Future<List<Offer>> getOffers() async {
    final offersJson =
    await firestore.collection(FirebasePaths.offers.path).get();

    final offers = offersJson.docs
        .map((offerDoc) => Offer.fromMap(offerDoc.data()))
        .toList();

    return offers;
  }

  static Future<String> getVideoUrl() async {
    final urlDoc =
    await firestore.collection(FirebasePaths.videos.path).doc('main').get();

    final url = urlDoc.data()?['url'] as String;

    return url;
  }

// point 1
  static Future<List<Project>> getProject() async {
    final projectJson =
    await firestore.collection(FirebasePaths.projects.path).get();

    final project = projectJson.docs
        .map((projectDoc) => Project.fromMap(projectDoc.data()))
        .toList();
    return project;
  }

  //point 2
  static Future<List<PurchasableService>> getPurchasableService() async {
    final purchasableServiceJson = await firestore.collection(
        FirebasePaths.purchasableServices.path).get();

    final purchasableService = purchasableServiceJson.docs.map((
        purchasableServiceDoc) =>
        PurchasableService.fromMap(purchasableServiceDoc.data())).toList();
    return purchasableService;


    }

  //point 3
    static Future<List<Service>>getService()async{

    final serviceJson=await firestore.collection(FirebasePaths.services.path).get();

    final service=serviceJson.docs.map((serviceDoc) =>Service.fromMap(serviceDoc.data())).toList();

    return service;
    }

}
