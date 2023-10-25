import 'package:zognest_website/features/home/pages/components/counters.dart';
import 'package:zognest_website/features/home/pages/components/marquee_text.dart';
import 'package:zognest_website/features/home/pages/components/zognest_blogs.dart';
import 'package:zognest_website/features/home/pages/components/zognest_clients.dart';
import 'package:zognest_website/features/home/pages/components/zognest_mocks.dart';
import 'package:zognest_website/features/home/pages/components/zognest_offers.dart';
import 'package:zognest_website/features/home/pages/components/zognest_services.dart';
import 'package:zognest_website/features/home/pages/components/zognest_video.dart';
import 'package:zognest_website/features/home/pages/home_page.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';

class Constants {
  /// Horizontal padding of any main component or the children inside it
  static const pageHorizontalPadding = Spacing.l48 * 2;

  /// Vertical padding of any main component or the children inside it
  static const componentVerticalPadding = Spacing.l40 * 2;

  /// The total height of the [PrimaryAppBar]
  static const appBarHeight = Spacing.xl72;

  /// The spacing between each [Foreground] component
  static const sectionSpacing = 150.0;

  /// The height of [MarqueeText] component
  static const marqueeHeight = 150.0;

  /// Radius of [CircleButton] used to scroll to end/start
  static const circleButtonRadius = Spacing.s4;

  /// region [ZognestVideo]
  static const videoAspectRatio = 16 / 9;
  // endregion

  /// region [ZognestOffers]
  static const zognestOffersItemWidth = 440.0;
  static const zognestOffersListHeight = 340.0;
  // endregion

  /// region [Counters]
  static const countersAnimationDuration = 3000;
  static const countItemHeight = Spacing.xl60 * 2;
  // endregion

  /// region [ZognestServices]
  static const servicesCardWidth = 360.0;
  static const servicesCardHeight = 540.0;
  // endregion

  /// region [ZognestMocks]
  static const appMockAnimationDuration = 2000;
  static const mocksSectionHeight = 1000.0;
  // endregion

  /// region [ZognestClients]
  static const clientsItemWidth = 440.0;
  static const clientsSectionHeight = 480.0;

  // endregion

  /// region [ZognestBlogs]
  static const blogsItemWidth = 440.0;
  static const blogsSectionHeight = 480.0;

  // endregion

  /// region [ZognestProjects]
  static const projectBaseWidth = 360.0;
  static const projectExtendedWidth = 960.0;
  static const projectHeight = 540.0;

  // endregion

  /// region [ServicesBrowser]
  static const servicesBrowserItemHeight = 325.0;
  static const servicesBrowserItemWidth = 550.0;

  // endRegion

  // region Section Heights
  static const zognestDescriptionSectionHeight = 700.0;
  static const zognestFooterSectionHeight = 800.0;
  static const optimismSectionHeight = 800.0;
  static const contactUsSectionHeight = 850.0;
  static const backgroundDecorationSpacing = 1000.0;
  static const beyondSpaceAppDuration = 5;
  static const clientsMarqueeHeight = Spacing.xl72;

  // endregion

  // region Durations
  static const scrollToDuration = 1000;
  static const marqueeScrollDuration = 3000;
// endregion
}
