import 'package:zognest_website/features/home/widgets/marquee_text.dart';
import 'package:zognest_website/features/home/widgets/zognest_clients.dart';
import 'package:zognest_website/features/home/widgets/zognest_services.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';

class Constants {
  /// Horizontal padding of any main component or the children inside it
  static const mobileHorizontalPadding = Spacing.m20;
  static const horizontalPadding = 24.0;
  static const horizontalPaddingViduo = 18.0;

  // region Horizontal Lists
  static const listHeight = 420.0;
  static const listCardWidth = 350.0;
  static const listCardSeparatorWidth = Spacing.m20;
  static const listCardSeparatorWidthMobile = Spacing.s10;

  // endregion

  // region List Buttons
  static const listButtonHorizontalPadding = Spacing.m16;
  static const listButtonVerticalPadding = Spacing.m16;

  // endregion

  /// Vertical padding of any main component or the children inside it
  static const webVerticalPadding = Spacing.l40 * 2;
  static const mobileVerticalPadding = Spacing.m20;

  /// The total height of the [PrimaryAppBar]
  static const appBarHeight = Spacing.xl72;

  /// The spacing between each component
  static const sectionSpacing = 75.0;

  /// The height of [MarqueeText] component
  static const marqueeHeight = 150.0;

  /// Radius of [CircleButton] used to scroll to end/start
  static const circleButtonRadius = Spacing.s4;

  /// region [ZognestVideo]
  static const videoAspectRatio = 16 / 9;
  static const videoAspectRatioMobile = 18/12;

  // endregion

  /// region [ZognestOffers]
  static const zognestOffersItemWidth = 440.0;
  static const zognestOffersListHeight = 340.0;

  // endregion

  /// region [Counters]
  static const countersAnimationDuration = 3000;
  static const countItemHeight = 120.0;

  // endregion

  /// region [ZognestServices]
  static const servicesCardWidth = 360.0;
  static const servicesCardHeight = 540.0;

  // endregion

  /// region [ZognestClients]
  static const clientsItemWidth = 440.0;

  // endregion

  /// region [ZognestBlogs]
  static const blogsItemWidth = 440.0;

  // endregion

  /// region [ZognestProjects]
  static const projectHeight = 540.0;

  // endregion

  /// region [ServicesBrowser]
  static const servicesBrowserItemHeight = 325.0;
  static const mobileServicesBrowserItemHeight = 180.0;
  static const servicesBrowserItemWidth = 550.0;

  // endRegion

  /// region [ZognestEvents]
  static const eventsDesktopTabHeight = 60.0;
  static const eventsMobileTabHeight = 40.0;

  // endRegion

  // region Section Heights
  /// Web list item height
  /// [ImageText]
  static const imageTextHeight = 700.0;
  static const zognestFooterSectionHeight = 800.0;
  static const optimismSectionHeight = 800.0;
  static const contactUsSectionHeight = 890.0;
  static const bgDecorationSpacing = 1000.0;
  static const beyondSpaceAppDuration = 5;
  static const clientsMarqueeHeight = 75.0;
  static const mobileClientsMarqueeHeight = 75.0;

  // endregion

  // region Durations
  static const scrollToDuration = 1000;
// endregion
}
