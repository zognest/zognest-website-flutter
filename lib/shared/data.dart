import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/resources/assets.dart';

import '../features/home/models/service.dart';

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
    Offer(
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
          'Team is not enought to define us, we are family of different species of birds, each one of us have unique capabiliities.',
      technologies: [
        Technology(name: 'photoshop', image: Assets.photoshop),
        Technology(name: 'illustrator', image: Assets.illustrator),
        Technology(name: 'zeplin', image: Assets.zeplin),
        Technology(name: 'figma', image: Assets.figma),
        Technology(name: 'xd', image: Assets.xd),
        Technology(name: 'sketch', image: Assets.sketch),
      ],
    ),
  ];
}
