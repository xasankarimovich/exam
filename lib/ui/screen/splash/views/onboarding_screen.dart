import 'dart:async';
import 'package:exam_6_oy/ui/screen/auth/login.dart';
import 'package:flutter/material.dart';
import '../../../../data/constants/app_constants.dart';
import '../models/onboarding_data.dart';
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController fadeController;
  late Animation<double> fadeAnimation;
  final streamPageController = StreamController<int>.broadcast();
  final List<OnboardingData> pages = [
    OnboardingData(
      title: 'Share Your\nRecipes',
      description:
      'Eiusmod proident ex occaecat fugiat esse pariatur laboris eiusmod labore qui elit aliqua.',
      image: Images.splash1,
    ),
    OnboardingData(
      title: 'Learn to\nCook',
      description:
      'Eiusmod proident ex occaecat fugiat esse pariatur laboris eiusmod labore qui elit aliqua.',
      image: Images.splash2,
    ),
    OnboardingData(
      title: 'Become a\nMaster Chef',
      description:
      'Eiusmod proident ex occaecat fugiat esse pariatur laboris eiusmod labore qui elit aliqua.',
      image: Images.splash3,
    ),
  ];
  Offset scrollOffset = const Offset(0, 0);
  int currentPage = 0;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();

    streamPageController.sink.add(0);
    fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    fadeAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: fadeController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> onHorizontalDragEnd(DragEndDetails details) async {
    if (details.primaryVelocity! > 0) {
      // previous page
      if (currentPage != 0) {
        await changePage(currentPage - 1);
      }
    } else if (details.primaryVelocity! < 0) {
      // next page
      if (currentPage != pages.length - 1) {
        await changePage(currentPage + 1);
      } else if (currentPage == pages.length - 1) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child:  LoginScreen(),
              );
            },
          ),
        );
      }
    }
  }

  Future<void> changePage(int newPage) async {
    await fadeController.forward();
    currentPage = newPage;
    streamPageController.add(currentPage);
    await fadeController.reverse();
  }

  @override
  void dispose() {
    streamPageController.close();
    fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: onHorizontalDragEnd,
        child: Container(
          width: double.infinity,
          color: Colors.black,
          child: Stack(
            children: [
              StreamBuilder<int>(
                stream: streamPageController.stream,
                builder: (context, pageSnapshot) {
                  return FadeTransition(
                    opacity: fadeAnimation,
                    child: OnboardingPage(
                      data: pages[pageSnapshot.data ?? 0],
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 100,
                  height: 7,
                  margin: const EdgeInsets.only(bottom: 50),
                  decoration: BoxDecoration(
                    // color: AppColors.primary.withOpacity(0.32),
                    borderRadius: BorderRadius.circular(3.5),
                  ),
                  alignment: Alignment.centerLeft,
                  child: StreamBuilder(
                    stream: streamPageController.stream,
                    builder: (context, snapshot) {
                      final width = (snapshot.data ?? 0) + 1;
                      return AnimatedFractionallySizedBox(
                        duration: const Duration(milliseconds: 300),
                        widthFactor: width / pages.length,
                        child: Container(
                          decoration: BoxDecoration(
                            // color: AppColors.primary,
                            borderRadius: BorderRadius.circular(3.5),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  const OnboardingPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(data.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.7),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: TextStyles.medium.copyWith(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data.description,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}