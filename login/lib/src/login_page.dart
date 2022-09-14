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

class LoginPage extends ConsumerWidget {
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
  const LoginPage({
    this.screenTitle,
    this.loginOptions,
    this.mainTitle,
    Key key,
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
    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: double.infinity,
                          maxWidth: 340,
                        ),
                        child: Container(
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
                                  )),
                              Gap(25),
                              Visibility(
                                visible: true,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      signInWithGoogle().whenComplete(() {
                                        ref.read(userLoggedIn.notifier).value =
                                            true;
                                      });
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 208, 208, 208),
                                              ),
                                            ),
                                          ),
                                          margin:
                                              const EdgeInsets.only(right: 70),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            child: Image.asset("search.png",
                                                width: 30, height: 30),
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
                              ),
                              Gap(50),
                              Visibility(
                                visible: true,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      ref.read(showLoading.notifier).value =
                                          true;
                                      await FirebaseAuth.instance
                                          .signInAnonymously()
                                          .then((a) => {
                                                ref
                                                    .read(userLoggedIn.notifier)
                                                    .value = true,
                                                ref
                                                    .read(showLoading.notifier)
                                                    .value = false,
                                              });
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                            color: Color.fromARGB(
                                                255, 208, 208, 208),
                                          ))),
                                          margin:
                                              const EdgeInsets.only(right: 75),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 18),
                                            child: Image.asset(
                                                "github-logo.png",
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
                              ),
                              Gap(50),
                              Visibility(
                                visible: true,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 208, 208, 208),
                                              ))),
                                              margin: const EdgeInsets.only(
                                                  right: 70),
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
                              ),
                              Gap(50),
                              Visibility(
                                visible: true,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 208, 208, 208),
                                              ))),
                                              margin: const EdgeInsets.only(
                                                  right: 70),
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
                                ),
                              ),
                              Gap(50),
                              Visibility(
                                visible: true,
                                child: SizedBox(
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
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 208, 208, 208),
                                              ),
                                            ),
                                          ),
                                          margin:
                                              const EdgeInsets.only(right: 70),
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 20),
                                            child: Image.asset("anonymous.png",
                                                width: 30, height: 30),
                                          ),
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
                              ),
                              Gap(50),
                              Container(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account ? ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  InkWell(
                                    onTap: () => {print("Clicked")},
                                    child: const Text(
                                      " Sign up.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.blue),
                                    ),
                                  )
                                ],
                              )),
                              Gap(50),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Text(
                      "AML",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void setAuthOptions(List config) {
    showGitHubAuth = config.contains(loginGitHub);
    showGoogleAuth = config.contains(loginGoogle);
    showEmailAuth = config.contains(loginEmail);
    showSsoAuth = config.contains(loginSSO);
    showAnonymousAuth = config.contains(loginAnonymous);
  }
}
