part of 'posts.dart';

// ignore: unused_element
class PostState extends ChangeNotifier {
  // bool hasPosts = false;
  List<Post> posts = [];

  static PostState s(BuildContext context, [listen = false]) =>
      Provider.of<PostState>(context, listen: listen);

  File? pickedImage;
  bool isLoading = false;

  pickImage(context) async {
    try {
      pickedImage = await ImagePickerService.instance.pickSingleImage();
      notifyListeners();
    } catch (e) {
      SnackBars.failure(context, 'Failed to pick image');
    }
  }

  fetchAllPosts() async {
    // isLoading = true;
    // notifyListeners();
    PostsRepo repo = PostsRepo();
    posts = await repo.fetchAllPosts();
    notifyListeners();
    // isLoading = false;
    // notifyListeners();
  }

  Future<bool> createPost(context, String caption, File file) async {
    isLoading = true;
    notifyListeners();
    AuthData? userData =
        Provider.of<AuthService>(context, listen: false).authData;
    if (userData == null) {
      isLoading = false;
      return Future(() => false);
    }
    bool result = await PostsRepo().createPost(
      caption: caption,
      file: file,
      uid: userData.uid,
      name: userData.fullname,
      profileImage:
          'https://images.mubicdn.net/images/cast_member/25100/cache-2388-1688754259/image-w856.jpg?size=800x',
      // profileImage: userData. profileImage,
    );
    isLoading = false;
    notifyListeners();
    return result;
  }
}
