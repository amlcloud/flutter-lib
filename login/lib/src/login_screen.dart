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

class LoginScreenComponents {
  final String screenTitle;
  final Map<String, bool> loginOptions;
  final String mainTitle;

  LoginScreenComponents(this.loginOptions,
      {required this.screenTitle, required this.mainTitle});
}

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key, required this.loginScreenComponents})
      : super(key: key);
  final LoginScreenComponents loginScreenComponents;

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
    List<String> configFlags = [];
    loginScreenComponents.loginOptions.forEach((key, value) {
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
                  loginScreenComponents.screenTitle,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  style: LoginStyle.titleStyle,
                )),
            Visibility(
                visible: showGoogleAuth,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    ElevatedButton(
                        style: LoginStyle.buttonStyle,
                        onPressed: () {
                          signInWithGoogle().whenComplete(() {
                            //ref.read(isLogedIn.notifier).value = true;
                          });
                        },
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.only(right: 70),
                            decoration: LoginStyle.containerStyle,
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Image.asset("search.png",
                                    width: 30, height: 30)),
                          ),
                          Container(
                              width: 180,
                              child: Text("Log in with Google",
                                  style: LoginStyle.buttontextStyle)),
                        ])),
                  ],
                )),
            Visibility(
                visible: showGitHubAuth,
                child: Column(children: [
                  const SizedBox(height: 50),
                  ElevatedButton(
                      style: LoginStyle.buttonStyle,
                      onPressed: () async {
                        // ref.read(isLoading.notifier).value = true;
                        await FirebaseAuth.instance
                            .signInAnonymously()
                            .then((a) => {
                                  //  ref.read(isLoggedIn.notifier).value = true,
                                  // ref.read(isLoading.notifier).value = false,
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
                        Container(
                            width: 180,
                            child: Text(
                              'Log in with Github',
                              style: LoginStyle.buttontextStyle,
                            ))
                      ]))
                ])),
            Visibility(
                visible: showSsoAuth,
                child: Column(children: [
                  const SizedBox(height: 50),
                  ElevatedButton(
                      style: LoginStyle.buttonStyle,
                      onPressed: () {},
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: LoginStyle.containerStyle,
                            margin: const EdgeInsets.only(right: 70),
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.key,
                                  size: 30,
                                  color: Colors.black,
                                ))),
                        Container(
                            width: 180,
                            child: Text(
                              'Log in with SSO',
                              style: LoginStyle.buttontextStyle,
                            ))
                      ]))
                ])),
            Visibility(
                visible: showEmailAuth,
                child: Column(children: [
                  const SizedBox(height: 50),
                  ElevatedButton(
                      style: LoginStyle.buttonStyle,
                      onPressed: () {},
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Container(
                            height: 50,
                            width: 50,
                            decoration: LoginStyle.containerStyle,
                            margin: const EdgeInsets.only(right: 70),
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: const Icon(
                                  Icons.mail,
                                  size: 30,
                                  color: Colors.black,
                                ))),
                        Container(
                            width: 180,
                            child: Text('Log in with Email',
                                style: LoginStyle.buttontextStyle))
                      ]))
                ])),
            Visibility(
                visible: showAnonymousAuth,
                child: Column(children: [
                  const SizedBox(height: 50),
                  ElevatedButton(
                      style: LoginStyle.buttonStyle,
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
                            decoration: LoginStyle.containerStyle,
                            margin: const EdgeInsets.only(right: 70),
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: Image.asset("anonymous.png",
                                    width: 30, height: 30))),
                        Container(
                            width: 180,
                            child: Text(
                              'Log in Anonymous',
                              style: LoginStyle.buttontextStyle,
                            ))
                      ]))
                ])),
            const SizedBox(height: 50),
            Container(
                width: 350,
                decoration: LoginStyle.seperatedLine,
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
                            child: Text(" Sign up.",
                                textAlign: TextAlign.center,
                                style: LoginStyle.linkStyle))
                      ],
                    ))),
          ],
        ),
      ),
      Container(
        width: 735,
        alignment: Alignment.center,
        child: Text(loginScreenComponents.mainTitle),
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
