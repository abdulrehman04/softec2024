part of '../meal_screen.dart';

class _Card extends StatelessWidget {
  final String header;
  final String? sub;
  final Color? color;
  const _Card({required this.header, this.sub, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      width: 110.w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: Space.all(),
        child: Column(
          children: [
            Text(
              header,
              style: AppText.h1bm,
            ),
            if (sub != null) Space.y2!,
            if (sub != null)
              Text(
                sub!,
                style: AppText.b1b,
              ),
          ],
        ),
      ),
    );
  }
}
