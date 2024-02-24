part of 'search_screen.dart';

class SearchState extends ChangeNotifier {
  static SearchState s(BuildContext context, [listen = false]) =>
      Provider.of<SearchState>(context, listen: listen);

  final formKey = GlobalKey<FormBuilderState>();

  bool hasSearched = false;
  List<AuthData> allUsers = [];
  List<AuthData> filteredUsers = [];

  void search(String value) {
    if (value.isEmpty) {
      hasSearched = false;
      filteredUsers = allUsers;

      notifyListeners();
    }
    if (value.isNotEmpty) {
      var lowerCaseQuery = value.toLowerCase();

      filteredUsers = allUsers.where((user) {
        final hasUserNameFound =
            user.fullname.toLowerCase().contains(lowerCaseQuery);
        return hasUserNameFound;
      }).toList(growable: false)
        ..sort(
          (a, b) => a.fullname.toLowerCase().indexOf(lowerCaseQuery).compareTo(
                b.fullname.toLowerCase().indexOf(lowerCaseQuery),
              ),
        );

      notifyListeners();
    }
  }

  void init(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    allUsers = authService.allUsers;
    filteredUsers = authService.allUsers;
  }
}
