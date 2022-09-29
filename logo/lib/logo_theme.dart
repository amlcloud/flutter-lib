part of logo;

final isDarkTheme = StateNotifierProvider<ThemeStateNotifier, bool>(
    (ref) => ThemeStateNotifier(false));

class Logo extends ConsumerWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // var isDarkState = ref.watch(themeStateNotifierProvider);

    return Row(children: [
      Container(
        child: (ref.watch(isDarkTheme))
            ? Image.asset('amlcloudlogodark_removebg_crop.png')
            : Image.asset('amlcloudlogoremovebgcrop.png'),
      )
    ]);
  }
}
