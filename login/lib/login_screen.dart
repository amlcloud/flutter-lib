part of login;

const loginGitHub = "loginGitHub";
const loginGoogle = "loginGoogle";
const loginSSO = "loginSSO";
const loginEmail = "loginEmail";
const loginAnonymous = "loginAnonymous";
const signupOption = "signupOption";
const tcUrl = "tcUrl";
const privacyStatementUrl = "privacyStatementUrl";

bool showGoogleAuth = false;
bool showGitHubAuth = false;
bool showSsoAuth = false;
bool showEmailAuth = false;
bool showAnonymousAuth = false;
bool showSignupOption = false;

const borderColor = Color.fromARGB(255, 208, 208, 208);
const borderDecor = BoxDecoration(
  border: Border(
    right: BorderSide(
      color: borderColor,
    ),
  ),
);

final userLoggedIn = StateNotifierProvider<AuthStateNotifier<bool>, bool>(
    (ref) => AuthStateNotifier<bool>(false));

final showLoading = StateNotifierProvider<AuthStateNotifier<bool>, bool>(
    (ref) => AuthStateNotifier<bool>(false));

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
  /// "**signupOption**"" for SignUp option
  ///
  ///Keys for Url:
  ///
  ///"**tcUrl**"" for Terms & Condition
  ///
  ///"**privacyStatementUrl**"" for Privacy Statement
  ///

  const LoginScreen({
    required this.screenTitle,
    required this.loginOptions,
    required this.mainTitle,
    required this.tcLinks,
    Key? key,
  }) : super(key: key);

  final String screenTitle;
  final Map<String, bool> loginOptions;
  final Map<String, String> tcLinks;
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

    //Separating all the "true" values from loginOptions
    loginOptions.forEach((key, value) {
      if (value == true) configFlags.add(key);
    });

    //Setting the flags
    setAuthOptions(configFlags);

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 340,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        screenTitle,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Visibility(
                      visible: showGoogleAuth,
                      child: Column(
                        children: [
                          const Gap(25),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                signInWithGoogle().whenComplete(() {
                                  ref.read(userLoggedIn.notifier).value = true;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: borderDecor,
                                    margin: const EdgeInsets.only(right: 70),
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 20),
                                      child: Image.asset('/assets/search.png',
                                          package: 'login',
                                          width: 30,
                                          height: 30),
                                    ),
                                  ),
                                  const SizedBox(
                                      width: 180,
                                      child: Text(
                                        "Log in with Google",
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: showGitHubAuth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Gap(50),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                ref.read(showLoading.notifier).value = true;
                                await FirebaseAuth.instance
                                    .signInAnonymously()
                                    .then((a) => {
                                          ref
                                              .read(userLoggedIn.notifier)
                                              .value = true,
                                          ref.read(showLoading.notifier).value =
                                              false,
                                        });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: borderDecor,
                                    margin: const EdgeInsets.only(right: 75),
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 18),
                                      child: Image.asset(
                                          'assets/github-logo.png',
                                          package: 'login',
                                          width: 30,
                                          height: 30),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 180,
                                    child: Text(
                                      'Log in with Github',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                        visible: showSsoAuth,
                        child: Column(
                          children: [
                            const Gap(50),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                          height: 50,
                                          width: 50,
                                          decoration: borderDecor,
                                          margin:
                                              const EdgeInsets.only(right: 70),
                                          child: Container(
                                              margin: const EdgeInsets.only(
                                                  right: 20),
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
                                    ]),
                              ),
                            ),
                          ],
                        )),
                    Visibility(
                      visible: showEmailAuth,
                      child: Column(
                        children: [
                          const Gap(50),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        height: 50,
                                        width: 50,
                                        decoration: borderDecor,
                                        margin:
                                            const EdgeInsets.only(right: 70),
                                        child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            child: const Icon(
                                              Icons.mail,
                                              size: 30,
                                              color: Colors.black,
                                            ))),
                                    const SizedBox(
                                      width: 180,
                                      child: Text(
                                        'Log in with Email',
                                      ),
                                    )
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: showAnonymousAuth,
                      child: Column(
                        children: [
                          const Gap(50),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                // ref.read(isLoading.notifier).value = true;
                                await FirebaseAuth.instance
                                    .signInAnonymously()
                                    .then((a) => {
                                          //     ref.read(isLoggedIn.notifier).value = true,
                                          //     ref.read(isLoading.notifier).value = false,
                                        });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: borderDecor,
                                    margin: const EdgeInsets.only(right: 70),
                                    child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 20),
                                        child: const Icon(
                                          Icons.account_circle,
                                          size: 30,
                                          color: Colors.black,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 180,
                                    child: Text(
                                      'Log in Anonymous',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: showSignupOption,
                      child: Column(
                        children: [
                          const Gap(50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Don't have an account ? ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18),
                              ),
                              InkWell(
                                //onTap: () => {print("Clicked")},
                                child: Text(
                                  " Sign up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blueGrey),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(50),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: "By creating an account, you agree to the ",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextSpan(
                              text: "Terms of Service.",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  var url = tcLinks[tcUrl]!;
                                  if (!await launchUrl(Uri.parse(url))) {
                                    throw 'Could not launch $url';
                                  }
                                },
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.blueGrey)),
                          const TextSpan(
                            text:
                                "For more information about our privacy practices, see the ",
                            style: TextStyle(fontSize: 18),
                          ),
                          TextSpan(
                            //onTap: () => {print("Clicked")},
                            text: "Privacy Statement.",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                var url = tcLinks[privacyStatementUrl]!;
                                if (!await launchUrl(Uri.parse(url))) {
                                  throw 'Could not launch $url';
                                }
                              },
                            style: const TextStyle(
                                fontSize: 18, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Colors.blueGrey),
            child: const Text(
              "AML",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void setAuthOptions(List config) {
    showGitHubAuth = config.contains(loginGitHub);
    showGoogleAuth = config.contains(loginGoogle);
    showEmailAuth = config.contains(loginEmail);
    showSsoAuth = config.contains(loginSSO);
    showAnonymousAuth = config.contains(loginAnonymous);
    showSignupOption = config.contains(signupOption);
  }
}
