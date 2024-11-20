import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<Map<String, String>> faqData = [
    {
      'question': 'How do I navigate within the app?',
      'answer': '''Welcome to our user-friendly app! Navigating is a breeze:
1. Home Screen and Menu:
• Start at the home screen, your hub for essential information. Use the menu icon (usually three lines or a grid) for quick access to features like your profile, settings, and app functionalities.
2. Exploring Features:
• Dive into different sections through the menu. Whether it’s searching for content, swiping between tabs, or using the back button, you can effortlessly explore and find what you need.
3. Customization and Support:
• Personalize your experience in settings or your profile. If you have questions, check the help or support section. And when you’re done, log out securely. Happy navigating!
That’s it! Enjoy your seamless app experience.''',
    },
    {
      'question': 'Can I change my account information?',
      'answer':
          'Yes, you can change your account information by going to the settings page and selecting "Account Information".',
    },
    {
      'question': 'What do I do if I forget my password?',
      'answer':
          'If you forget your password, you can reset it by clicking on "Forgot Password" on the login screen and following the instructions.',
    },
    {
      'question': 'How can I customize my user profile?',
      'answer':
          'You can customize your user profile by going to the settings page and selecting "Profile Customization".',
    },
    {
      'question': 'Are my login credentials stored securely?',
      'answer':
          'Yes, your login credentials are securely stored using industry-standard encryption methods.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "FAQ",
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: NeuroMorphicContainer(
            padding: const EdgeInsets.all(7),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorPalette.primaryColor,
                  width: 2,
                ),
              ),
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  expansionTileTheme: const ExpansionTileThemeData(
                    backgroundColor: Colors.transparent,
                    collapsedBackgroundColor: Colors.transparent,
                    tilePadding: EdgeInsets.symmetric(horizontal: 16.0),
                    childrenPadding: EdgeInsets.all(16.0),
                  ),
                ),
                child: Column(
                  children: faqData.map((faq) {
                    int index = faqData.indexOf(faq);
                    bool isLast = index == faqData.length - 1;

                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: isLast
                              ? BorderSide.none
                              : const BorderSide(
                                  color: ColorPalette.textDark,
                                  width: 1,
                                ),
                        ),
                      ),
                      child: ExpansionTile(
                        dense: true,
                        childrenPadding:
                            const EdgeInsets.fromLTRB(18, 0, 18, 18),
                        title: Text(
                          faq['question']!,
                          style: AppTextThemes.lightTextTheme.headlineLarge,
                        ),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Text(faq['answer']!),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
