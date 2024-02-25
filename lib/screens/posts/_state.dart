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
    String link = await PostsRepo().uploadImage(file);
    bool result = await PostsRepo().createPost(
      context,
      caption: caption,
      fileLink: link,
      uid: userData.uid,
      name: userData.fullname,
      profileImage: userData.profilePicture,
    );

    posts.add(
      Post(
        caption: caption,
        imageLink: link,
        uid: userData.uid,
        name: userData.fullname,
        image: userData.profilePicture,
      ),
    );

    isLoading = false;
    notifyListeners();
    return result;
  }

  void resetSelectedPic() {
    pickedImage = null;
    notifyListeners();
  }
}
