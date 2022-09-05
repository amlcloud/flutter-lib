part of login;

class LoginOptionComponent extends StatelessWidget {
  const LoginOptionComponent(
      {Key? key,
      required this.buttonText,
      required this.buttonImage,
      required this.onPress})
      : super(key: key);

  final Widget buttonImage;
  final String buttonText;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      alignment: Alignment.center,
      child: Column(children: [
        const SizedBox(height: 50),
        ElevatedButton(
            style: LoginStyle.buttonStyle,
            onPressed: (() => onPress),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(right: 70),
                  child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: buttonImage)),
              Container(
                  width: 180,
                  child: Text(
                    buttonText,
                    style: LoginStyle.buttontextStyle,
                  )),
            ])),
      ]),
    );
  }
}

class LoginStyle {
  static ButtonStyle buttonStyle = ButtonStyle(
      minimumSize: MaterialStateProperty.all(const Size(350, 50)),
      maximumSize: MaterialStateProperty.all(const Size(350, 50)),
      backgroundColor: MaterialStateProperty.all(Colors.white));
  static TextStyle buttontextStyle = const TextStyle(
      fontSize: 18.0, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle titleStyle =
      const TextStyle(fontWeight: FontWeight.bold, fontSize: 24);
  static TextStyle linkStyle =
      const TextStyle(fontSize: 18, color: Colors.blueGrey);
  static BoxDecoration containerStyle = const BoxDecoration(
      border: Border(
          right: BorderSide(
    color: Colors.grey,
  )));
  static BoxDecoration seperatedLine = const BoxDecoration(
      border: Border(
          top: BorderSide(
    color: Color.fromARGB(255, 208, 208, 208),
  )));
}
