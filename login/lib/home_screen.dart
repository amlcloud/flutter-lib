part of login;

enum Option { login, signUp }

final authOptionProvider =
    StateNotifierProvider((_) => AuthStateNotifier(true));

final currentState = Provider((ref) => ref.watch(authOptionProvider));

class HomePage extends ConsumerWidget {
  const HomePage({
    super.key,
    required this.screenTitle,
    required this.loginOptions,
    required this.mainTitle,
  });

  final Option selectedOption = Option.login;

  final String screenTitle;
  final Map<String, bool> loginOptions;
  final String mainTitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authOption = ref.watch(authOptionProvider.notifier);

    var currentUserSelection = ref.watch(currentState);

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
                child: getUserSelection(currentUserSelection as bool) ==
                        Option.login
                    ? LoginScreen(
                        loginOptions: loginOptions,
                        screenTitle: screenTitle,
                        onSignUpSelected: () {
                          authOption.value = false;
                        },
                      )
                    : SignupScreen(
                        onLogInSelected: () {
                          authOption.value = true;
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
            decoration: const BoxDecoration(color: Colors.blueGrey),
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
