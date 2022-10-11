part of logo;

final isDarkTheme = StateNotifierProvider<ThemeStateNotifier, bool>(
    (ref) => ThemeStateNotifier(false));

class Logo extends ConsumerWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: (ref.watch(isDarkTheme))
              ? Image.asset('assets/amlcloudlogodark_removebg_crop.png',
                  package: 'logo', fit: BoxFit.contain)
              : Image.asset('assets/amlcloudlogoremovebgcrop.png',
                  package: 'logo', fit: BoxFit.contain),
        ),
      ],
    );

    // return const Image(
    //     image:
    //         AssetImage('assets/amlcloudlogoremovebgcrop.png', package: 'logo'));

    // margin: const EdgeInsets.only(right: 18),
    // child: Image.asset("amlcloudlogodark_removebg_crop.png", height: 50, width: 50),

    // child: Image.asset('amlcloudlogoremovebgcrop.png'),
    // (ref.watch(isDarkTheme))
    // ? Image.asset('amlcloudlogodark_removebg_crop.png')
    // : Image.asset('amlcloudlogoremovebgcrop.png'),
    // );
  }
}
