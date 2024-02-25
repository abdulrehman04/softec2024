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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            onPressed: () {
              AppRouter.push(context, const ChatScreen());
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
          : ListView.builder(
              itemCount: controller.posts.length,
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
    );
  }
}
