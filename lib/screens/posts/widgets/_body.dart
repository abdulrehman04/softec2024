part of '../posts.dart';

class _Body extends StatelessWidget {
  const _Body();

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
