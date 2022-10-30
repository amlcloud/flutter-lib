part of widgets;

class Assistant extends StatefulWidget {
  const Assistant({super.key});

  @override
  AsstState createState() {
    return AsstState();
  }
}

class AsstState extends State {
  bool isVisible = false;

  void showAsst() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Align(
                alignment: Alignment.bottomRight,
                child: Visibility(
                    visible: isVisible,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: FractionallySizedBox(
                              heightFactor: 0.6,
                              widthFactor: 0.2,
                              child: Column(children: const [
                                Text("This is your website assistant!",
                                    style: TextStyle(fontSize: 20)),
                                Text("Put assistant content stuff here",
                                    style: TextStyle(fontSize: 20))
                              ])),
                        ))))),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    textStyle: const TextStyle(fontSize: 60),
                    //minimumSize: Size.fromHeight(50),
                  ),
                  onPressed: showAsst,
                  child: const Text("?")),
            ))
      ],
    );
  }
}
