part of login;

Color transparent = const Color.fromARGB(255, 255, 255, 255);

enum Option { login, signUp }

final isLoginProvider = StateNotifierProvider((_) => AuthStateNotifier(false));

final loginState = Provider((ref) => ref.watch(isLoginProvider));

class HomePage extends ConsumerWidget {
  const HomePage(
      {super.key,
      required this.screenTitle,
      required this.loginOptions,
      required this.mainTitle});

  final Option selectedOption = Option.login;

  final String screenTitle;
  final Map<String, bool> loginOptions;
  final String mainTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(isLoginProvider.notifier);

    var isLogin = ref.watch(loginState);

    Option getUserSelection(bool isLogin) {
      if (isLogin) {
        return Option.login;
      } else {
        return Option.signUp;
      }
    }

    return Row(
      children: [
        Expanded(
          flex: 1,
          child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Container(
                child: getUserSelection(isLogin as bool) == Option.login
                    ? LoginScreen(
                        loginOptions: loginOptions,
                        screenTitle: screenTitle,
                        onSignUpSelected: () {
                          notifier.value = false;
                        },
                      )
                    : SignupScreen(
                        onLogInSelected: () {
                          notifier.value = true;
                        },
                      ),
              )
              //}
              ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.blue.withAlpha(30)),
            child: Text(
              mainTitle,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
