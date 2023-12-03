import 'package:zognest_website/features/about_us/models/staff.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/features/our_services/models/purchasable_service.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/features/our_work/models/project.dart';
import 'package:zognest_website/resources/assets.dart';

import '../features/home/models/service.dart';
import 'models/technology.dart';

class Data {
  static const beyondSpaceImages = [
    Assets.cuckoo,
    Assets.drop,
    Assets.myPocket,
    Assets.salt,
    Assets.storeLoop,
  ];

  static const clientsImageAssets = [
    Assets.ajmera,
    Assets.mahalaxmi,
    Assets.tooth,
    Assets.sjrc,
    Assets.texasChiro,
    Assets.vais,
    Assets.ajmera,
    Assets.mahalaxmi,
    Assets.tooth,
    Assets.sjrc,
    Assets.texasChiro,
    Assets.vais,
  ];

  static const ytVideoUrl = 'hRFOa5CtXkY';

  static List<Offer> offers = [
    const Offer(
      highlight: 'Professional',
      title: 'And dedicated team',
      description:
          'Our professionals work with love, and passion for every detail, creating this community of satisfied customers. The combination of a proactive approach and the above technical skills allows us to cooperate/work with leading companies in multiple regions.',
    ),
    const Offer(
      highlight: 'Professional',
      title: 'And dedicated team',
      description:
          'Our professionals work with love, and passion for every detail, creating this community of satisfied customers. The combination of a proactive approach and the above technical skills allows us to cooperate/work with leading companies in multiple regions.',
    ),
    const Offer(
      highlight: 'Professional',
      title: 'And dedicated team',
      description:
          'Our professionals work with love, and passion for every detail, creating this community of satisfied customers. The combination of a proactive approach and the above technical skills allows us to cooperate/work with leading companies in multiple regions.',
    ),
    const Offer(
      highlight: 'Professional',
      title: 'And dedicated team',
      description:
          'Our professionals work with love, and passion for every detail, creating this community of satisfied customers. The combination of a proactive approach and the above technical skills allows us to cooperate/work with leading companies in multiple regions.',
    ),
    const Offer(
      highlight: 'Professional',
      title: 'And dedicated team',
      description:
          'Our professionals work with love, and passion for every detail, creating this community of satisfied customers. The combination of a proactive approach and the above technical skills allows us to cooperate/work with leading companies in multiple regions.',
    ),
    const Offer(
      highlight: 'Professional',
      title: 'And dedicated team',
      description:
          'Our professionals work with love, and passion for every detail, creating this community of satisfied customers. The combination of a proactive approach and the above technical skills allows us to cooperate/work with leading companies in multiple regions.',
    ),
  ];

  static List<Service> services = [
    Service(
      highlight: 'Our',
      title: 'Dedicate Team',
      description:
          'Team is not enough to define us, we are family of different species of birds, each one of us have unique capabilities.',
      technologies: [
        Technology(name: 'Photoshop', image: Assets.photoshop),
        Technology(name: 'Illustrator', image: Assets.illustrator),
        Technology(name: 'Zeplin', image: Assets.zeplin),
        Technology(name: 'Figma', image: Assets.figmaColoured),
        Technology(name: 'XD', image: Assets.xd),
        Technology(name: 'Sketch', image: Assets.sketch),
      ],
    ),
    Service(
      highlight: 'Our',
      title: 'Dedicate Team',
      description:
          'Team is not enough to define us, we are family of different species of birds, each one of us have unique capabilities.',
      technologies: [
        Technology(name: 'Photoshop', image: Assets.photoshop),
        Technology(name: 'Illustrator', image: Assets.illustrator),
        Technology(name: 'Zeplin', image: Assets.zeplin),
        Technology(name: 'Figma', image: Assets.figmaColoured),
        Technology(name: 'XD', image: Assets.xd),
        Technology(name: 'Sketch', image: Assets.sketch),
      ],
    ),
    Service(
      highlight: 'Our',
      title: 'Dedicate Team',
      description:
          'Team is not enough to define us, we are family of different species of birds, each one of us have unique capabilities.',
      technologies: [
        Technology(name: 'Photoshop', image: Assets.photoshop),
        Technology(name: 'Illustrator', image: Assets.illustrator),
        Technology(name: 'Zeplin', image: Assets.zeplin),
        Technology(name: 'Figma', image: Assets.figmaColoured),
        Technology(name: 'XD', image: Assets.xd),
        Technology(name: 'Sketch', image: Assets.sketch),
      ],
    ),
    Service(
      highlight: 'Our',
      title: 'Dedicate Team',
      description:
          'Team is not enough to define us, we are family of different species of birds, each one of us have unique capabilities.',
      technologies: [
        Technology(name: 'Photoshop', image: Assets.photoshop),
        Technology(name: 'Illustrator', image: Assets.illustrator),
        Technology(name: 'Zeplin', image: Assets.zeplin),
        Technology(name: 'Figma', image: Assets.figmaColoured),
        Technology(name: 'XD', image: Assets.xd),
        Technology(name: 'Sketch', image: Assets.sketch),
      ],
    ),
    Service(
      highlight: 'Our',
      title: 'Dedicate Team',
      description:
          'Team is not  to define us, we are family of different species of birds, each one of us have unique capabilities.',
      technologies: [
        Technology(name: 'Photoshop', image: Assets.photoshop),
        Technology(name: 'Illustrator', image: Assets.illustrator),
        Technology(name: 'Zeplin', image: Assets.zeplin),
        Technology(name: 'Figma', image: Assets.figmaColoured),
        Technology(name: 'XD', image: Assets.xd),
        Technology(name: 'Sketch', image: Assets.sketch),
      ],
    ),
  ];

  static List<ClientFeedback> clientFeedbacks = [
    const ClientFeedback(
      description:
      'I am artist of the real world with creative ideas of the ancient arts in benin, Nigeria',
      clientImage: Assets.clientImage,
      name: 'Bright Mba',
      id: '@brightmac',
      backgroundImages: [
        Assets.clientFeedbackBackgroundImage1,
        Assets.clientFeedbackBackgroundImage2,
      ],
    ),
  ];

  static List<Blog> blogs = [
    Blog(
      image: Assets.blog,
      title: '31 of the Best UX Design Blogs to Follow This Year',
      date: DateTime.now(),
    ),
  ];

  static List<PurchasableService> purchasableServices = [
    const PurchasableService(
      title: 'Mobile Development',
      image: Assets.purchasableServicesImage,
      description: 'iOS & Android',
      id: 1,
    ),
    const PurchasableService(
      title: 'Mobile Development',
      image: Assets.purchasableServicesImage,
      description: 'iOS & Android',
      id: 2,
    ),
    const PurchasableService(
      title: 'Mobile Development',
      image: Assets.purchasableServicesImage,
      description: 'iOS & Android',
      id: 3,
    ),
    const PurchasableService(
      title: 'Mobile Development',
      image: Assets.purchasableServicesImage,
      description: 'iOS & Android',
      id: 4,
    ),
    const PurchasableService(
      title: 'Mobile Development',
      image: Assets.purchasableServicesImage,
      description: 'iOS & Android',
      id: 5,
    ),
    const PurchasableService(
      title: 'Mobile Development',
      image: Assets.purchasableServicesImage,
      description: 'iOS & Android',
      id: 6,
    ),
    const PurchasableService(
      title: 'Mobile Development',
      image: Assets.purchasableServicesImage,
      description: 'iOS & Android',
      id: 4,
    ),
    const PurchasableService(
      title: 'Mobile Development',
      image: Assets.purchasableServicesImage,
      description: 'iOS & Android',
      id: 5,
    ),
    const PurchasableService(
      title: 'Mobile Development',
      image: Assets.purchasableServicesImage,
      description: 'iOS & Android',
      id: 6,
    ),
  ];

  static List<Project> projects = [
    const Project(
      title: 'My Pocket',
      brief: 'Card Manager',
      image: Assets.purchasableServicesImage,
      icon: Assets.projectIcon,
      description:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularized in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    ),
  ];

  static List<Event> events = [
    Event(
      title: 'Fun office party',
      date: DateTime(2023, 4, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2023, 7, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2023, 1, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2022, 11, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2023, 4, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2023, 7, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2023, 1, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2022, 11, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2023, 4, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2023, 7, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2023, 1, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
    Event(
      title: 'Fun office party',
      date: DateTime(2022, 11, 20),
      images: List<String>.generate(12, (index) => Assets.eventImage),
      coverImage: Assets.eventCover,
    ),
  ];

  static List<Staff> staff = [
    Staff(
      name: 'Dodo',
      position: 'Co-Founder / CTO',
      description:
          'Imagination creates vision, and vision gives birth to visionaries, so here I am, ready to achieve my goals.',
      url: 'LinkedIn',
      technologies: [
        Technology(name: 'Photoshop', image: Assets.photoshop),
        Technology(name: 'Illustrator', image: Assets.illustrator),
        Technology(name: 'Zeplin', image: Assets.zeplin),
        Technology(name: 'Figma', image: Assets.figmaColoured),
        Technology(name: 'XD', image: Assets.xd),
        Technology(name: 'Sketch', image: Assets.sketch),
      ],
    ),
  ];
}
