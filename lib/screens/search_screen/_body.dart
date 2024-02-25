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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Users near me',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      15.verticalSpace,
                      SizedBox(
                        height: 100.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: (screenState.nearMe).map((e) {
                            return Container(
                              height: 100.h,
                              width: 130.w,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey[900]!,
                                  width: 2,
                                ),
                              ),
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  e.profilePicture == ''
                                      ? Container(
                                          height: 50.h,
                                          width: 50.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.grey[900],
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            size: 27,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 70,
                                          backgroundImage: NetworkImage(
                                            e.profilePicture,
                                          ),
                                        ),
                                  5.verticalSpace,
                                  Text(
                                    e.fullname,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      Space.y2!,
                      25.verticalSpace,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          screenState.allUsers.length ==
                                  screenState.filteredUsers.length
                              ? 'All users'
                              : 'Filtered users',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      15.verticalSpace,
                      Expanded(
                        child: ListView.builder(
                          padding: Space.z,
                          itemCount: screenState.filteredUsers.length,
                          itemBuilder: (context, index) {
                            final chat = screenState.filteredUsers[index];
                            return ListTile(
                              leading: chat.profilePicture == ''
                                  ? Container(
                                      height: 50.h,
                                      width: 50.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[900],
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        size: 27,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 70,
                                      backgroundImage: NetworkImage(
                                        chat.profilePicture,
                                      ),
                                    ),
                              title: Text(chat.fullname),
                              onTap: () {
                                AppRouter.push(
                                  context,
                                  OtherUserProfile(user: chat),
                                );
                              },
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
