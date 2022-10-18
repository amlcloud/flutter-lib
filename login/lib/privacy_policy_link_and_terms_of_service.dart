part of login;

class PrivacyPolicyLinkAndTermsOfService extends StatelessWidget {
  final Map<String, String> tcLinks;

  const PrivacyPolicyLinkAndTermsOfService({super.key, required this.tcLinks});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            const TextSpan(
              text: "By creating an account, you agree to the ",
              style: TextStyle(fontSize: 18),
            ),
            TextSpan(
                text: "Terms of Service.",
                recognizer: TapGestureRecognizer()
                  ..onTap = () async {
                    var url = tcLinks[termsOfServiceLink]!;
                    if (!await launchUrl(Uri.parse(url))) {
                      throw 'Could not launch $url';
                    }
                  },
                style: const TextStyle(fontSize: 18, color: Colors.blueGrey)),
            const TextSpan(
              text:
                  "For more information about our privacy practices, see the ",
              style: TextStyle(fontSize: 18),
            ),
            TextSpan(
              text: "Privacy Statement.",
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  var url = tcLinks[privacyPolicyLink]!;
                  if (!await launchUrl(Uri.parse(url))) {
                    throw 'Could not launch $url';
                  }
                },
              style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
