import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/features/our_space/widgets/gallery_dialog.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/shared/widgets/greyscale_filter.dart';

import '../../../shared/widgets/network_fading_image.dart';

class EventCard extends StatefulWidget {
  const EventCard({super.key, required this.event});

  final Event event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  bool over = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GreyscaleFilter(
      isHovered: over,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => GalleryDialog(event: widget.event),
          );
        },
        onHover: (over) => setState(() => this.over = over),
        overlayColor: MaterialStateProperty.all(Palette.transparent),
        child: Column(
          children: [
            Expanded(
              child: NetworkFadingImage(
                path: widget.event.coverImage,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            ColoredBox(
              color: theme.primaryColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacing.m16,
                  vertical: Spacing.l24,
                ),
                child: Row(
                  children: [
                    Text(
                      '${widget.event.images.length}',
                      style: theme.textTheme.headlineMedium
                          ?.copyWith(fontSize: 72),
                    ),
                    const SizedBox(width: Spacing.m20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('MMMM').format(widget.event.date),
                          style: theme.textTheme.headlineMedium
                              ?.copyWith(fontSize: 24),
                        ),
                        Text(
                          widget.event.title,
                          style: theme.textTheme.labelMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${widget.event.date.year}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
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
