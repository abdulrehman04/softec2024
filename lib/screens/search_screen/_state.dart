part of 'search_screen.dart';

class _ScreenState extends ChangeNotifier {
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final formKey = GlobalKey<FormBuilderState>();

  bool hasSearched = false;
  List<ChatMeta> filtered = [];

  void search(String value, List<ChatMeta> data) {
    /// Reset the filters, if the user is searching just to avoid the crash because of
    /// searching across the filtered applied.
    reset();

    if (value.isEmpty) {
      hasSearched = false;
      filtered = [];

      notifyListeners();
    }
    if (value.isNotEmpty) {
      hasSearched = true;
      var lowerCaseQuery = value.toLowerCase();

      filtered = data.where((meta) {
        final hasUserNameFound =
            meta.receiver.fullname.toLowerCase().contains(lowerCaseQuery);
        return hasUserNameFound;
      }).toList(growable: false)
        ..sort(
          (a, b) => a.receiver.fullname
              .toLowerCase()
              .indexOf(lowerCaseQuery)
              .compareTo(
                b.receiver.fullname.toLowerCase().indexOf(lowerCaseQuery),
              ),
        );

      notifyListeners();
    }
  }

  void reset() {
    hasSearched = false;
    filtered = [];

    notifyListeners();
  }
}
