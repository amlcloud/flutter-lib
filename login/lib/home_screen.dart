part of login;

Color transparent = const Color.fromARGB(255, 255, 255, 255);

enum Option { login, signUp }

final isLoginProvider = StateNotifierProvider((_) => BooleanNotifier(false));

final loginState = Provider((ref) => ref.watch(isLoginProvider));

class HomePage extends ConsumerWidget {
  const HomePage(this.loginOptions, {super.key, required this.screenTitle});

  final Option selectedOption = Option.login;

  final String screenTitle;
  final Map<String, bool> loginOptions;

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

    return  Row(
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
      ),
  
  }
}
