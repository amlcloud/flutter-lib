// library userprofile;

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:userprofile/userprofile.dart';
// import 'package:widgets/widgets.dart';
part of userprofile;

class AppBarUserProfile extends ConsumerWidget {
  const AppBarUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'Edit Profile',
      onPressed: () => showEditProfileDialog(context, ref),
      icon: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Center(
          child: FirebaseAuth.instance.currentUser?.photoURL == null
              ? const Icon(Icons.person)
              : CircleAvatar(
                  radius: 14,
                  backgroundImage: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL!)
                      .image),
        ),
      ),
    );
  }
}

void showEditProfileDialog(BuildContext context, WidgetRef ref) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text("Edit my profile"),
            content: SizedBox(
                height: 200.0, // Change as per your requirement
                width: 400.0, // Change as per your requirement
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: ProfilePhotoEditor()),
                      ...ref
                          .watch(docSP(
                              'userInfo/${FirebaseAuth.instance.currentUser?.uid}'))
                          .when(
                              data: (userDoc) => [
                                    Text(userDoc.data()!['email']),
                                    /**To ask */
                                    // FFLTTextEdit(userDoc, 'name', 'user name',
                                    //     'edit user name',
                                    //     key: Key(userDoc.id)),
                                  ],
                              loading: () => [
                                    /**To ask */
                                    //Loader()
                                  ],
                              error: (e, s) => [ErrorWidget(e)])
                    ])),
            actions: <Widget>[
              ElevatedButton(
                  key: const Key('sign_out_btn'),
                  child: const Text("Sign Out"),
                  onPressed: () {
                    //Navigator.of(context).popUntil(ModalRoute.withName('/'));
                    // Navigator.of(context).pushNamed(LoginPage.route);
                    Navigator.of(context).pop();
                    FirebaseAuth.instance.signOut();
                  }),
              ElevatedButton(
                child: const Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]);
      });
}
