import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/strings.dart';

import '../../../shared/widgets/network_fading_image.dart';

class GalleryDialog extends StatelessWidget {
  GalleryDialog({super.key, required this.event});

  final Event event;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(36),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: Responsive.isDesktop(context)
                  ? double.infinity
                  : MediaQuery.sizeOf(context).height * 0.70,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: double.infinity,
                      viewportFraction: 1,
                      autoPlay: true,
                    ),
                    items: event.images.map(
                      (image) {
                        return NetworkFadingImage(
                          path: image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ).toList()),
              ),
            ),
            Positioned(
              bottom: 104,
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (Responsive.isDesktop(context))
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('MMMM').format(event.date).toUpperCase(),
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
                      ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _controller.previousPage(),
                          child: Image.asset(Assets.shortArrowLeft),
                        ),
                        const SizedBox(width: 4),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Strings.scroll.toUpperCase(),
                              style: theme.textTheme.displaySmall?.copyWith(
                                fontSize: Responsive.isDesktop(context) ? 48 : 32,
                              ),
                            ),
                            Text(
                              '${event.images.length} Images'.toUpperCase(),
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.primaryColor,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () => _controller.nextPage(),
                          child: Image.asset(Assets.arrowRight),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
