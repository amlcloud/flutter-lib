part of login;

const loginGitHub = "loginGitHub";
const loginGoogle = "loginGoogle";
const loginSSO = "loginSSO";
const loginEmail = "loginEmail";
const loginAnonymous = "loginAnonymous";

bool showGoogleAuth = false;
bool showGitHubAuth = false;
bool showSsoAuth = false;
bool showEmailAuth = false;
bool showAnonymousAuth = false;

final userLoggedIn = StateNotifierProvider<GenericStateNotifier<bool>, bool>(
    (ref) => GenericStateNotifier<bool>(false));

final showLoading = StateNotifierProvider<GenericStateNotifier<bool>, bool>(
    (ref) => GenericStateNotifier<bool>(false));

class LoginScreen extends ConsumerWidget {
  ///Login Options:
  ///
  /// "**loginGitHub**" for Login via Github
  ///
  /// "**loginGoogle**" for Login via Google
  ///
  /// "**loginSSO**" for Login via SSO
  ///
  /// "**loginEmail**" for Login via Email
  ///
  /// "**loginAnonymous**" for Login as Anonymous user
  ///
  const LoginScreen({
    required this.screenTitle,
    required this.loginOptions,
    required this.mainTitle,
    Key? key,
  }) : super(key: key);

  final String screenTitle;
  final Map<String, bool> loginOptions;
  final String mainTitle;

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(showLoading)) {
      return Center(
        child: Container(
          alignment: const Alignment(0.0, 0.0),
          child: const CircularProgressIndicator(),
        ),
      );
    }
    List<String> configFlags = [];
    loginOptions.forEach((key, value) {
      if (value == true) configFlags.add(key);
    });
    setAuthOptions(configFlags);
    return Scaffold(
        body: Row(children: [
      Container(
        width: 800,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                margin: const EdgeInsets.only(right: 270),
                child: Text(
                  screenTitle,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                )),
            Visibility(
                visible: showGoogleAuth,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () {
                          signInWithGoogle().whenComplete(() {
                            ref.read(userLoggedIn.notifier).value = true;
                          });
                        },
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.only(right: 70),
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Image.asset("search.png",
                                    width: 30, height: 30)),
                          ),
                          const SizedBox(
                              width: 180,
                              child: Text(
                                "Log in with Google",
                              )),
                        ])),
                  ],
                )),
            Visibility(
                visible: showGitHubAuth,
                child: Column(children: [
                  const SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () async {
                        ref.read(showLoading.notifier).value = true;
                        await FirebaseAuth.instance
                            .signInAnonymously()
                            .then((a) => {
                                  ref.read(userLoggedIn.notifier).value = true,
                                  ref.read(showLoading.notifier).value = false,
                                });
                      },
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                              color: Color.fromARGB(255, 208, 208, 208),
                            ))),
                            margin: const EdgeInsets.only(right: 75),
                            child: Container(
                                margin: const EdgeInsets.only(right: 18),
                                child: Image.asset("github-logo.png",
                                    width: 30, height: 30))),
                        const SizedBox(
                            width: 180,
                            child: Text(
                              'Log in with Github',
                            ))
                      ]))
                ])),
            Visibility(
                visible: showSsoAuth,
                child: Column(children: [
                  const SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () {},
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.only(right: 70),
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.key,
                                  size: 30,
                                  color: Colors.black,
                                ))),
                        const SizedBox(
                            width: 180,
                            child: Text(
                              'Log in with SSO',
                            ))
                      ]))
                ])),
            Visibility(
                visible: showEmailAuth,
                child: Column(children: [
                  const SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () {},
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.only(right: 70),
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.mail,
                                  size: 30,
                                  color: Colors.black,
                                ))),
                        const SizedBox(
                            width: 180,
                            child: Text(
                              'Log in with Email',
                            ))
                      ]))
                ])),
            Visibility(
                visible: showAnonymousAuth,
                child: Column(children: [
                  const SizedBox(height: 50),
                  ElevatedButton(
                      onPressed: () async {
                        // ref.read(isLoading.notifier).value = true;
                        await FirebaseAuth.instance
                            .signInAnonymously()
                            .then((a) => {
                                  //     ref.read(isLoggedIn.notifier).value = true,
                                  //     ref.read(isLoading.notifier).value = false,
                                });
                      },
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.only(right: 70),
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Image.asset("anonymous.png",
                                    width: 30, height: 30))),
                        const SizedBox(
                            width: 180,
                            child: Text(
                              'Log in Anonymous',
                            ))
                      ]))
                ])),
            const SizedBox(height: 50),
            SizedBox(
                width: 350,
                child: Container(
                    width: 50,
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account ? ",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18)),
                        InkWell(
                            onTap: () => {Navigator.push},
                            child: const Text(
                              " Sign up.",
                              textAlign: TextAlign.center,
                            ))
                      ],
                    ))),
          ],
        ),
      ),
      Container(
        width: 735,
        alignment: Alignment.center,
        child: Text(mainTitle),
      )
    ]));
  }

  void setAuthOptions(List config) {
    showGitHubAuth = config.contains(loginGitHub);
    showGoogleAuth = config.contains(loginGoogle);
    showEmailAuth = config.contains(loginEmail);
    showSsoAuth = config.contains(loginSSO);
    showAnonymousAuth = config.contains(loginAnonymous);
  }
}
