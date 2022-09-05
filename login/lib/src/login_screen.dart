part of login;

class LoginScreenComponents {
  final String screenTitle;
  final List<LoginOption> loginOptions;
  final SignUpOption signUpOption;
  final String mainTitle;

  LoginScreenComponents(
      {required this.screenTitle,
      required this.loginOptions,
      required this.signUpOption,
      required this.mainTitle});
}

class SignUpOption {
  final String text;
  final String signUp;
  final Function onTap;

  SignUpOption({required this.text, required this.signUp, required this.onTap});
}

class LoginOption {
  final String title;
  final Widget icon;
  final Function onPressed;
  LoginOption(
      {required this.title, required this.icon, required this.onPressed});
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.loginScreenComponents})
      : super(key: key);
  final LoginScreenComponents loginScreenComponents;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
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
            Expanded(
              child: ListView.builder(
                  itemCount: loginScreenComponents.loginOptions.length,
                  itemBuilder: (context, item) {
                    return LoginOptionComponent(
                      buttonImage:
                          loginScreenComponents.loginOptions[item].icon,
                      buttonText:
                          loginScreenComponents.loginOptions[item].title,
                      onPress: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              loginScreenComponents.loginOptions[item].title),
                        ));
                      },
                    );
                  }),
            ),
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
                        Text(loginScreenComponents.signUpOption.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18)),
                        InkWell(
                            onTap: (() =>
                                loginScreenComponents.signUpOption.onTap),
                            child: Text(
                                loginScreenComponents.signUpOption.signUp,
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
    ]);
  }
}
