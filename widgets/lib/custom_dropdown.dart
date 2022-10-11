part of widgets;

final categorySelector =
    StateNotifierProvider<GenericStateNotifier<String?>, String?>(
        (ref) => GenericStateNotifier<String?>(null));

class CustomDropdown extends ConsumerWidget {
  const CustomDropdown(this.header, this.itemList, this.selector, {super.key});
  final List<String> itemList;
  final String header;
  final StateNotifierProvider<GenericStateNotifier<String?>, String?> selector;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: DropdownButton<String>(
          value: ref.watch(selector),
          hint: Container(
            margin: const EdgeInsets.only(left: 12),
            child: Text(header),
          ),
          isExpanded: true,
          alignment: Alignment.center,
          icon: const Icon(Icons.arrow_downward),
          underline: Container(),
          onChanged: (String? newValue) {
            ref.read(selector.notifier).value = newValue;
          },
          items: itemList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Container(
                margin: const EdgeInsets.only(left: 12),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ));
}
