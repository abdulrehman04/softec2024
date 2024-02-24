part of 'search_screen.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    super.initState();
    final screenState = SearchState.s(context, false);
    screenState.init(context);
  }

  @override
  Widget build(BuildContext context) {
    final screenState = SearchState.s(context, true);
    return Scaffold(
      bottomNavigationBar: const BottomBar(),
      body: screenState.allUsers.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Search'),
                ),
                body: Padding(
                  padding: Space.all(),
                  child: Column(
                    children: [
                      AppTextField(
                        name: 'search',
                        prefixIcon: const Icon(
                          Iconsax.search_normal_1,
                        ),
                        hint: 'Search...',
                        onChanged: (query) {
                          if (query != null) {
                            screenState.search(query);
                          }
                        },
                      ),
                      Space.y2!,
                      Expanded(
                        child: ListView.builder(
                          padding: Space.z,
                          itemCount: screenState.filteredUsers.length,
                          itemBuilder: (context, index) {
                            final chat = screenState.filteredUsers[index];

                            return ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(chat.fullname),
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
