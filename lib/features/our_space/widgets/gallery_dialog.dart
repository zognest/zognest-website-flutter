import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';

import '../../../shared/widgets/network_fading_image.dart';

class GalleryDialog extends StatelessWidget {
  GalleryDialog({super.key, required this.event});

  final Event event;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Spacing.xl60,
          horizontal: Spacing.xl60,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: Constants.eventsDialogHeight,
                      viewportFraction: 1,
                      autoPlay: true,
                    ),
                    items:
                         event.images.map(
                            (image) {
                              return NetworkFadingImage(
                                path: image,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              );
                            },
                          ).toList()
                       )),
            SizedBox(
              height: Constants.eventsDialogHeight,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isDesktop(context)
                      ? Constants.webHorizontalPaddingOurSpace
                      : Constants.mobileHorizontalPadding,
                  vertical: Responsive.isDesktop(context)
                      ? Constants.webVerticalPadding
                      : Constants.mobileVerticalPadding,
                ),
                child: Responsive.isDesktop(context)
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              Text(
                                DateFormat('MMMM')
                                    .format(event.date)
                                    .toUpperCase(),
                                style: theme.textTheme.displaySmall,
                              ),
                              Text(
                                '${event.date.year} ${event.title.toUpperCase()}',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: theme.primaryColor,
                                  fontVariations: TextThemes.fontVariation(6),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Material(
                            color: Palette.transparent,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                children: [
                                  InkWell(
                                    overlayColor: MaterialStateProperty.all(
                                        Palette.transparent),
                                    onTap: () => _controller.previousPage(),
                                    child: Image.asset(Assets.shortArrowLeft),
                                  ),
                                  const SizedBox(width: Spacing.s8),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        Strings.scroll.toUpperCase(),
                                        style: theme.textTheme.displaySmall
                                            ?.copyWith(fontSize: 54),
                                      ),
                                      Text(
                                        '${event.images.length} Images'
                                            .toUpperCase(),
                                        style: theme.textTheme.labelMedium
                                            ?.copyWith(
                                          color: theme.primaryColor,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: Spacing.m18),
                                  InkWell(
                                    overlayColor: MaterialStateProperty.all(
                                        Palette.transparent),
                                    onTap: () => _controller.nextPage(),
                                    child: Image.asset(Assets.arrowRight),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                      children:[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Spacer(),
                            Material(
                              color: Palette.transparent,
                              child: Row(
                                children: [
                                  InkWell(
                                    overlayColor: MaterialStateProperty.all(
                                        Palette.transparent),
                                    onTap: () => _controller.previousPage(),
                                    child: Image.asset(Assets.shortArrowLeft),
                                  ),
                                  const SizedBox(width: Spacing.s12),
                                  const SizedBox(width: Spacing.l24),
                                  InkWell(
                                    overlayColor: MaterialStateProperty.all(
                                        Palette.transparent),
                                    onTap: () => _controller.nextPage(),
                                    child: Image.asset(Assets.arrowRight),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                   ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
