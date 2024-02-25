part of '../posts.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    final notiProvider = Provider.of<NotiService>(context, listen: false);
    notiProvider.pullNotis();
    final eventP = Provider.of<EventService>(context, listen: false);
    eventP.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    PostState controller = Provider.of<PostState>(context, listen: true);
    final authP = Provider.of<AuthService>(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Feed'),
          actions: [
            IconButton(
              onPressed: () {
                AppRouter.push(
                  context,
                  MealPlanView(
                    plan: obese,
                    bmi: 45.2,
                  ),
                );
                // AppRouter.push(context, const ChatScreen());
              },
              icon: const Icon(Icons.telegram),
            )
          ],
        ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          // key: _key,
          overlayStyle: ExpandableFabOverlayStyle(
            blur: 5,
          ),
          children: [
            FloatingActionButton.small(
              heroTag: null,
              tooltip: 'Create post',
              child: const Icon(Icons.edit_document),
              onPressed: () {
                AppRouter.push(context, CreatePost());
              },
            ),
            FloatingActionButton.small(
              heroTag: null,
              tooltip: 'Add Event',
              child: const Icon(Icons.event),
              onPressed: () {
                AppRouter.push(context, const EventScreen());
              },
            ),
            FloatingActionButton.small(
              heroTag: null,
              tooltip: 'Pose analysis',
              child: const Icon(Icons.medical_services),
              onPressed: () {
                AppRouter.push(context, const PoseAnalysisScreen());
              },
            ),
            FloatingActionButton.small(
              heroTag: null,
              tooltip: 'Live streaming',
              child: const Icon(Icons.video_call),
              onPressed: () {
                final allUsers = authP.allUsers;
                for (final user in allUsers) {
                  if (authP.authData!.followers.contains(user.uid)) {
                    NotificationBase().sendPushMessage(
                      user.uid,
                      user.deviceToken ?? '',
                      '${authP.authData!.fullname} is going live!',
                      "Guess who?",
                    );
                  }
                }
                AppRouter.push(
                  context,
                  LiveStreaming(
                    selectedProduct: ProductName.broadcastStreaming,
                    isBroadcaster:
                        Provider.of<AuthService>(context, listen: false)
                                .authData
                                ?.isProfessional ??
                            false,
                  ),
                );
              },
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     AppRouter.push(context, CreatePost());
        //   },
        //   child: Icon(
        //     Icons.chat,
        //     size: 30,
        //     color: AppTheme.c.primary,
        //   ),
        // ),
        bottomNavigationBar: const BottomBar(),
        body: controller.posts.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const _Banner(),
                    ListView.builder(
                      itemCount: controller.posts.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        Post item = controller.posts[index];
                        return PostItem(
                          name: item.name,
                          post: item.imageLink,
                          title: item.caption,
                          image: item.image,
                        );
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

MealPlan underweight = MealPlan(
  breakfast: [
    'Whole grain toast with avocado slices and a poached egg',
    'Greek yogurt with mixed berries and a drizzle of honey',
  ],
  lunch: [
    'Quinoa salad with mixed vegetables (such as bell peppers, cucumbers, and cherry tomatoes) and grilled chicken or tofu',
    'A piece of fruit (apple, pear, or banana)',
  ],
  dinner: [
    'Grilled salmon with roasted sweet potatoes and steamed broccoli',
    'Mixed green salad with olive oil and vinegar dressing',
  ],
  snacks: [
    'Almonds or mixed nuts',
    'Carrot sticks with hummus',
  ],
);

MealPlan normal = MealPlan(
  breakfast: [
    'Oatmeal topped with sliced banana, almonds, and a drizzle of maple syrup',
    'Scrambled eggs with spinach and whole grain toast',
  ],
  lunch: [
    'Whole wheat wrap with grilled chicken or turkey, lettuce, tomato, and avocado',
    'Greek salad with feta cheese, olives, and a vinaigrette dressing',
  ],
  dinner: [
    'Stir-fried tofu or lean beef with mixed vegetables (broccoli, bell peppers, snap peas) served over brown rice',
    'Steamed green beans with garlic and lemon zest',
  ],
  snacks: [
    'Greek yogurt with granola',
    'Apple slices with almond butter',
  ],
);

MealPlan overweight = MealPlan(
  breakfast: [
    'Smoothie made with spinach, banana, frozen berries, Greek yogurt, and almond milk',
    'Whole grain toast with peanut butter and sliced strawberries',
  ],
  lunch: [
    'Grilled vegetable and chickpea salad with quinoa',
    'Whole grain pita with hummus and sliced cucumbers',
  ],
  dinner: [
    'Baked chicken breast with roasted potatoes and asparagus',
    'Mixed green salad with balsamic vinaigrette',
  ],
  snacks: [
    'Air-popped popcorn',
    'Cottage cheese with pineapple chunks',
  ],
);

MealPlan obese = MealPlan(
  breakfast: [
    'Veggie omelet with mushrooms, onions, bell peppers, and a sprinkle of cheese',
    'Whole grain English muffin with avocado spread',
  ],
  lunch: [
    'Turkey and avocado wrap with whole wheat tortilla',
    'Mixed bean salad with bell peppers, corn, and a lime vinaigrette',
  ],
  dinner: [
    'Grilled fish with quinoa pilaf and steamed broccoli',
    'Spinach salad with walnuts, cranberries, and a light vinaigrette dressing',
  ],
  snacks: [
    'Celery sticks with peanut butter',
    'Low-fat Greek yogurt with sliced peaches',
  ],
);
