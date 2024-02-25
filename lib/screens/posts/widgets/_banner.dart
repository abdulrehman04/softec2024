part of '../posts.dart';

class _Banner extends StatelessWidget {
  const _Banner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: AppTheme.c.primary,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('My Plans!', style: AppText.h1b),
                  // 5.verticalSpace,
                  Text('Get a meal plan right now!', style: AppText.h3),
                ],
              ),
              IconButton(
                onPressed: () {
                  AppRouter.push(context, const MealScreen());
                },
                icon: const Icon(
                  Icons.navigate_next,
                  size: 34,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
