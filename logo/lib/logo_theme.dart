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

    return Container(
      // margin: const EdgeInsets.only(right: 18),
      child: Image.asset('assets/amlcloudlogodark_removebg_crop.png',
          height: 50, width: 50),

      // child: Image.asset('amlcloudlogoremovebgcrop.png'),
      // (ref.watch(isDarkTheme))
      // ? Image.asset('amlcloudlogodark_removebg_crop.png')
      // : Image.asset('amlcloudlogoremovebgcrop.png'),
    );
  }
}
