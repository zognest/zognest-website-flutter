import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/features/home/models/counters.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/features/home/models/service.dart';
import 'package:zognest_website/features/our_services/models/purchasable_service.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/features/our_work/models/project.dart';
import 'package:zognest_website/firebase_services/firebase_paths.dart';
import 'package:zognest_website/shared/models/technology.dart';

import '../features/about_us/models/staff.dart';

class FirestoreServices {
  static final firestore = FirebaseFirestore.instance;

  static Future<List<Blog>> getBlogs() async {
    final blogsJson =
        await firestore.collection(FirebasePaths.blogs.path).get();

    final blogs =
        blogsJson.docs.map((blogDoc) => Blog.fromMap(blogDoc.data())).toList();

    return blogs;
  }

  static Future<List<ClientFeedback>> getClientFeedbacks() async {
    final clientFeedbacksJson =
        await firestore.collection(FirebasePaths.clientFeedbacks.path).get();

    final clientFeedbacks = clientFeedbacksJson.docs
        .map((feedbackDoc) => ClientFeedback.fromMap(feedbackDoc.data()))
        .toList();

    return clientFeedbacks;
  }

  static Future<List<Event>> getEvents() async {
    final eventsJson =
        await firestore.collection(FirebasePaths.events.path).get();

    final events = eventsJson.docs
        .map((eventDoc) => Event.fromMap(eventDoc.data()))
        .toList();

    return events;
  }

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

  static Future<List<Project>> getProjects() async {
    final projectsJson =
        await firestore.collection(FirebasePaths.projects.path).get();

    final projects = projectsJson.docs
        .map((projectDoc) => Project.fromMap(projectDoc.data()))
        .toList();
    return projects;
  }

  static Future<List<PurchasableService>> getPurchasableServices() async {
    final purchasableServicesJson = await firestore
        .collection(FirebasePaths.purchasableServices.path)
        .orderBy('orderby', descending: false)
        .get();

    final purchasableServices = purchasableServicesJson.docs
        .map((purchasableServiceDoc) =>
            PurchasableService.fromMap(purchasableServiceDoc.data()))
        .toList();
    return purchasableServices;
  }

  static Future<List<Service>> getServices() async {
    final servicesJson = await firestore
        .collection(FirebasePaths.services.path)
        .orderBy('orderby', descending: false)
        .get();
    final services = await Future.wait(
      servicesJson.docs.map(
        (serviceDoc) async {
          final technologies =
              await getTechnologiesFromRefs(serviceDoc.data()['technologies']);

          Service service = Service.fromMap(serviceDoc.data())
              .copyWith(technologies: technologies);
          return service;
        },
      ),
    );

    return services;
  }

  static Future<List<Staff>> getStaff() async {
    final staffJson =
        await firestore.collection(FirebasePaths.staff.path).get();

    final staff = await Future.wait(
      staffJson.docs.map(
        (staffDoc) async {
          final technologies = await getTechnologiesFromRefs(
            staffDoc.data()['technologies'],
          );
          Staff staff = Staff.fromMap(staffDoc.data())
              .copyWith(technologies: technologies);
          return staff;
        },
      ),
    );

    return staff;
  }
  static Future<List<Counter>> getCounters() async {
    final countersJson =
    await firestore.collection(FirebasePaths.counters.path).get();

    final counters = countersJson.docs
        .map((countersDoc) =>Counter.fromMap(countersDoc.data()))
        .toList();

    return counters;
  }

  static Future<List<Technology>> getTechnologiesFromRefs(
      List<dynamic> refs) async {
    List<Technology> technologies = [];

    for (final DocumentReference technologyRef in refs) {
      final technologyDoc = await technologyRef.get();
      if (technologyDoc.exists) {
        technologies.add(
          Technology.fromMap(technologyDoc.data() as Map<String, dynamic>),
        );
      }
    }

    return technologies;
  }

  static Future<void> sendMessages({
    required String message,
    String? phone,
    String? budget,
    required String name,
    required String email,
    List<String>? services,
    bool call = false,
    required BuildContext context,
  }) async {
    final map = {
      'message': message,
      'phone': phone ?? '-',
      'name': name,
      'email': email,
      'budget': budget ?? '-',
      'call': call,
      'services': services,
      'timestamp': DateTime.now(),
    };
    await FirebaseFirestore.instance
        .collection(FirebasePaths.messages.path)
        .add(map);
    if (context.mounted) {
      MotionToast.success(
        title: const Text("Success!"),
        description: const Text("Message was sent."),
        dismissable: true,
        animationDuration: const Duration(microseconds: 1000),
        animationCurve: Curves.easeIn,
        position: MotionToastPosition.bottom,
        toastDuration: const Duration(seconds: 2),
        animationType: AnimationType.fromBottom,
      ).show(context);
    }
  }
}
