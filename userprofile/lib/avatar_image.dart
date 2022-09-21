part of userprofile;

class AvatarImage extends ConsumerWidget {
  const AvatarImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      tooltip: 'Edit Profile',
      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Edit Profile'),
        ),
      ),
      icon: Padding(
        padding: const EdgeInsets.only(right: 4),
        child: Center(
          child: FirebaseAuth.instance.currentUser?.photoURL == null
              ? const Icon(Icons.person)
              : CircleAvatar(
                  radius: 14,
                  backgroundImage: Image.network(
                          FirebaseAuth.instance.currentUser!.photoURL!)
                      .image),
        ),
      ),
    );
  }
}
