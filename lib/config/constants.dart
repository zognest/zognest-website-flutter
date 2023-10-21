import 'package:zognest_website/features/home/pages/components/marquee_text.dart';
import 'package:zognest_website/features/home/pages/components/zognest_video.dart';
import 'package:zognest_website/features/home/pages/home_page.dart';
import 'package:zognest_website/resources/spacing.dart';

class Constants {
  /// The total height of the app bar
  static const appBarHeight = Spacing.xl72;

  /// Horizontal padding of any main component or the children inside it
  static const pageHorizontalPadding = Spacing.l48 * 2;

  /// Vertical padding of any main component or the children inside it
  static const componentVerticalPadding = Spacing.l40 * 2;

  /// The spacing between each [Foreground] component
  static const sectionSpacing = 150.0;

  /// The height of [MarqueeText] component
  static const marqueeHeight = 150.0;

  /// Aspect Ratio of [ZognestVideo]
  static const videoAspectRatio = 16 / 9;

  // region Zognest Offers
  static const zognestOffersItemWidth = 440.0;
  static const zognestOffersListHeight = 340.0;

  // endregion

  // region Section Heights
  static const zognestDescriptionSectionHeight = 700.0;
  static const optimismSectionHeight = 900.0;
  static const countItemHeight = Spacing.xl60 * 2;
  static const servicesCardWidth = 362.0;
  static const servicesCardHeight = 542.0;
  static const mocksSectionHeight = 1000.0;
  static const clientsSectionHeight = 480.0;
  static const contactUsSectionHeight = 850.0;
  static const backgroundDecorationSpacing = 1000.0;
  static const beyondSpaceAppDuration = 5;
  static const circleButtonRadius = Spacing.s4;
  static const clientsMarqueeHeight = Spacing.xl72;

  // endregion

  // region Durations
  static const appMockAnimationDuration = 2000;
  static const scrollToDuration = 1000;
  static const marqueeScrollDuration = 3000;
// endregion
}
