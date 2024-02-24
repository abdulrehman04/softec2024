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
  }

  @override
  Widget build(BuildContext context) {
    PostState controller = Provider.of<PostState>(context, listen: true);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppRouter.push(context, CreatePost());
        },
        child: Icon(
          Icons.chat,
          size: 30,
          color: AppTheme.c.primary,
        ),
      ),
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
