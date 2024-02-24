import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:softec_app/models/auth_data.dart';
import 'package:softec_app/models/ratings.dart';
import 'package:softec_app/services/auth.dart';
import 'package:softec_app/services/image_picker.dart';
import 'package:softec_app/widgets/core/snackbar/custom_snackbar.dart';

class ProfileState extends ChangeNotifier {
  File? pickedImage;
  bool isLoading = false;
  late AuthData userData;

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  init(context, AuthData user) {
    userData = user;
  }

  Future pickImage(context) async {
    try {
      pickedImage = await ImagePickerService.instance.pickSingleImage();
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      SnackBars.failure(context, 'Failed to pick image');
      throw "error";
    }
  }

  updateProfilePicture(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      await pickImage(context);
      final task = await _storage
          .ref()
          .child(DateTime.now().toIso8601String())
          .putFile(pickedImage!);

      String link = await task.ref.getDownloadURL();

      _db.collection('users').doc(userData.uid).update({
        'profilePicture': link,
      });
      if (context.mounted) {
        SnackBars.success(context, 'profile picture updated');
      }
      userData.profilePicture = link;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  void addFollower(context) {
    _db.collection('users').doc(userData.uid).update({
      'followers': FieldValue.arrayUnion(
        [Provider.of<AuthService>(context, listen: false).authData!.uid],
      ),
    });

    userData.followers.add(
      Provider.of<AuthService>(context, listen: false).authData!.uid,
    );
    notifyListeners();
  }

  void removeFollower(context) {
    _db.collection('users').doc(userData.uid).update({
      'followers': FieldValue.arrayRemove(
        [Provider.of<AuthService>(context, listen: false).authData!.uid],
      ),
    });

    userData.followers.remove(
      Provider.of<AuthService>(context, listen: false).authData!.uid,
    );
    notifyListeners();
  }

  void addReview(context, int rating, String review) {
    AuthData currentUser = Provider.of<AuthService>(
      context,
      listen: false,
    ).authData!;

    _db.collection('users').doc(userData.uid).update({
      'reviews': FieldValue.arrayUnion(
        [
          {
            'name': currentUser.fullname,
            'rating': rating,
            'review': review,
          }
        ],
      ),
    });

    userData.ratings!.add(
      Rating(name: currentUser.fullname, rating: rating, review: review),
    );
    notifyListeners();
  }
}
