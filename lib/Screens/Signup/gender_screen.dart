import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utils/page_transitions.dart';
import 'height_screen.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({super.key});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String? _selected; // "male" or "female"

  void _select(String value) => setState(() => _selected = value);

  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Color(0xffF2EDE9),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(30),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.black,
                        iconSize: 28,
                        onPressed: () => Navigator.pop(context),
                      ),
                      Gap(50),
                      AnimatedIndicator(
                        activeIndex: 1,
                        count: 10,
                        animationDuration: const Duration(milliseconds: 400),
                        activeColor: const Color(0xff13EC5B),
                        inactiveColor: const Color(0xFFCCCCCC),
                        dotSize: 10.0,
                      ),
                      const Spacer(),
                    ],
                  ),
                  Gap(60),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      style: const TextStyle(

                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selected != null ? Colors.green : Colors.grey,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: _selected == null
                      ? null
                      : () {
                    Navigator.push(
                      context,
                      CustomPageTransitions.slideAndFadeTransition(
                        HeightScreen(gender: _selected),
                      ),
                    );
                  },
                  child: const Text("Next", style: TextStyle(color: Colors.black)),
                ),
                Gap(50)
              ],
            ),
          ),
        ),

    );
  }
}

class _GenderImageCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool selected;

  const _GenderImageCard({
    required this.imagePath,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: selected ? 1.0 : 0.7,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Image
          Image.asset(
            imagePath,
            height: 400,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 12),
          // Label
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
