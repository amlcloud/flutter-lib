part of userprofile;

const double PHOTO_RADIUS = 50;
//const double PROFILE_PHOTO_WIDTH = 50;
//const PERSON_URL = 'images/company.png';

class ProfilePhotoEditor extends ConsumerWidget {
  ProfilePhotoEditor({super.key});
  // final TextEditingController _name = TextEditingController();
  // final FocusNode _nameFocus = FocusNode();

  final profilePhotoUploadStateProvider =
      StateNotifierProvider((ref) => FileUploadNotifier());

  @override
  Widget build(BuildContext context, WidgetRef ref) => Column(children: [
        Flexible(
            child: GestureDetector(
                //child: Container(),
                child: (ref.watch(profilePhotoUploadStateProvider) == null ||
                        ref.watch(profilePhotoUploadStateProvider) ==
                            TaskState.success)
                    ? buildPhoto(context, ref)
                    : (ref.watch(profilePhotoUploadStateProvider) ==
                            TaskState.running
                        ? const Center(child: CircularProgressIndicator())
                        : Container()),
                onTap: () async {
                  html.InputElement uploadInput =
                      html.FileUploadInputElement() as InputElement;

                  uploadInput.onChange.listen((e) async {
                    // read file content as dataURL
                    final files = uploadInput.files!;
                    if (files.length == 1) {
                      final file = files[0];
                      html.FileReader reader = html.FileReader();

                      reader.onLoadEnd.listen((e) async {
                        // print("wrote bytes");

                        UploadTask _uploadTask;
                        _uploadTask = FirebaseStorage.instance
                            .ref()
                            .child(
                                '$BUCKET_PATH_USR${FirebaseAuth.instance.currentUser!.uid}.jpeg')
                            .putData(
                                reader.result as Uint8List,
                                SettableMetadata(
                                  cacheControl: 'public,max-age=31536000',
                                  contentType: 'image/jpeg',
                                ));

                        _uploadTask.catchError((error) {
                          print('photo storage error');
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error.toString())));
                        });

                        // print('set upload task notifier');
                        ref
                            .read(profilePhotoUploadStateProvider.notifier)
                            .uploadTask = _uploadTask;

                        final TaskSnapshot downloadUrl = (await _uploadTask);

                        final String url =
                            (await downloadUrl.ref.getDownloadURL());

                        await FirebaseStorage.instance
                            .ref()
                            .child(
                                '$BUCKET_PATH_USR${FirebaseAuth.instance.currentUser!.uid}.jpeg')
                            .updateMetadata(SettableMetadata(
                                cacheControl: 'public,max-age=31536000',
                                contentType: 'image/jpeg',
                                customMetadata: {}));
                        // FF.doc(
                        //         'userInfo/${FirebaseAuth.instance.currentUser!.uid}')
                        //     .update({"photoUrl": url});
                      });

                      reader.onError.listen((Object error) {
                        print('photo read error: ${error.toString()}');
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error.toString())));
                      });

                      reader.readAsArrayBuffer(file);
                    }
                  });
                  uploadInput.click();
                }))
      ]);

  Widget buildPhoto(BuildContext context, WidgetRef ref) => Center(
      child: ref
          .watch(docSP('userInfo/${FirebaseAuth.instance.currentUser!.uid}'))
          .when(
              loading: () => Container(),
              error: (e, s) => ErrorWidget(e),
              // data: (userInfo) => CircleAvatar(
              //   radius: 50,
              //   backgroundImage: userInfo.exists &&
              //           !(userInfo.data()?['photoUrl'] ?? '').isEmpty
              //       ? Image.network(userInfo.data()!['photoUrl'],
              //               width: 50, height: 50)
              //           .image
              //       : (FirebaseAuth.instance.currentUser?.photoURL?.isNotEmpty==true
              //          ? Image.network(
              //                   FirebaseAuth.instance.currentUser!.photoURL!)
              //               .image):,

              data: (userInfo) => Center(
                    child: userInfo.exists &&
                            !(userInfo.data()?['photoUrl'] ?? '').isEmpty
                        ? CircleAvatar(
                            backgroundImage: Image.network(
                                    userInfo.data()!['photoUrl'],
                                    width: 50,
                                    height: 50)
                                .image)
                        : FirebaseAuth.instance.currentUser?.photoURL == null
                            ? const Icon(Icons.person)
                            : CircleAvatar(
                                radius: 14,
                                backgroundImage: Image.network(FirebaseAuth
                                        .instance.currentUser!.photoURL!)
                                    .image),
                  )));
  // ref.watch(docStreamProvider('org/$uid')).when(
  //     data: (org) => org.data() == null || org.data()!['logoUrl'] == null
  //         ? Center(
  //             child: ClipOval(
  //                 child: Container(
  //                     height: PHOTO_RADIUS * 2,
  //                     width: PHOTO_RADIUS * 2,
  //                     color: Colors.grey.shade200,
  //                     child: Image.asset(BLANK_PHOTO_URL,
  //                         width: PHOTO_RADIUS * 2,
  //                         height: PHOTO_RADIUS * 2,
  //                         fit: BoxFit.cover))))
  //         : Container(
  //             width: PROFILE_PHOTO_WIDTH,
  //             height: PROFILE_PHOTO_WIDTH,
  //             child: CircleAvatar(
  //                 backgroundImage:
  //                   Image.asset(PERSON_IMG).image
  //                   //NetworkImage(org.data()!['logoUrl']),
  //                 backgroundColor: Colors.transparent,
  //                 radius: PHOTO_RADIUS)),
  //     loading: () => Text('loading...'),
  //     error: (e, s) => ErrorWidget(e));
}
