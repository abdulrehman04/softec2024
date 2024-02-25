part of 'search_screen.dart';

class SearchState extends ChangeNotifier {
  static SearchState s(BuildContext context, [listen = false]) =>
      Provider.of<SearchState>(context, listen: listen);

  final formKey = GlobalKey<FormBuilderState>();

  bool hasSearched = false;
  List<AuthData> allUsers = [];
  List<AuthData> filteredUsers = [];
  List<AuthData> nearMe = [];

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

  getUsersNearMe() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    nearMe = allUsers.length > 5 ? allUsers.sublist(0, 5) : allUsers;
    nearMe.sort(
      (a, b) => calculateDistance(
              a.lat, a.long, position.latitude, position.longitude)
          .compareTo(
        calculateDistance(b.lat, b.long, position.latitude, position.longitude),
      ),
    );

    notifyListeners();
  }

  void init(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    allUsers = authService.allUsers;
    filteredUsers = authService.allUsers;
    getUsersNearMe();
  }

  calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    print(12742 * asin(sqrt(a)));
    return 12742 * asin(sqrt(a));
  }
}
