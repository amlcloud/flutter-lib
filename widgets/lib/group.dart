part of widgets;

class Group extends StatelessWidget {
  final Widget child;

  const Group({super.key, required this.child});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Colors.grey,
              )),
          child: Padding(padding: const EdgeInsets.all(8), child: child)));
}
