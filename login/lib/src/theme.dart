part of login;

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
