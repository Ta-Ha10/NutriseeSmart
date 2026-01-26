# 📖 Page Transitions - Code Examples & Reference

## Quick Start Examples

### Example 1: Basic Slide & Fade Transition
```dart
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      CustomPageTransitions.slideAndFadeTransition(
        const GenderScreen()
      ),
    );
  },
  child: const Text('Next'),
)
```

### Example 2: Using Named Routes (Automatic Transition)
```dart
ElevatedButton(
  onPressed: () {
    // Automatically applies slideAndFadeTransition via onGenerateRoute
    Navigator.pushNamed(context, '/goal_weight');
  },
  child: const Text('Next'),
)
```

### Example 3: Custom Transition Type
```dart
// Use fade instead of slide & fade
Navigator.push(
  context,
  CustomPageTransitions.fadeTransition(const HeightScreen()),
);

// Or use scale/bounce effect
Navigator.push(
  context,
  CustomPageTransitions.scaleTransition(const ReviewScreen()),
);
```

---

## Indicator Components

### Dot Indicator (Circular Progress)
```dart
AnimatedIndicator(
  activeIndex: 3,      // Current step (0-indexed)
  count: 10,           // Total steps
  animationDuration: const Duration(milliseconds: 400),
  activeColor: const Color(0xff13EC5B),
  inactiveColor: const Color(0xFFCCCCCC),
  dotSize: 10.0,
)
```

**Usage in Screens:**
- Birth Screen (step 0)
- Gender Screen (step 1)
- Height Screen (step 2)
- Current Weight Screen (step 3)
- Goal Weight Screen (step 4)

### Progress Bar (Step Progress)
```dart
AnimatedProgressBar(
  currentStep: 6,      // Number of filled steps
  totalSteps: 9,       // Total step count
  animationDuration: const Duration(milliseconds: 500),
  activeColor: Colors.green,
  inactiveColor: const Color(0xFFE0E0E0),
)
```

**Usage in Screens:**
- Obesity Screen (6/9 steps)
- Activity Screen (7/9 steps)
- Meal Goal Screen (8/9 steps)
- Review Screen (9/9 steps)

---

## All Available Transition Types

### 1. SlideAndFade (RECOMMENDED)
**When to use:** General navigation between screens
```dart
CustomPageTransitions.slideAndFadeTransition(widget)
// Duration: 450ms forward, 300ms backward
// Effect: Slides from right + fades in simultaneously
```

### 2. Slide Only
**When to use:** Simple, professional transitions
```dart
CustomPageTransitions.slideTransition(widget)
// Duration: 400ms forward, 300ms backward
// Effect: Pure slide from right to left
```

### 3. Fade Only
**When to use:** Subtle, elegant screens
```dart
CustomPageTransitions.fadeTransition(widget)
// Duration: 500ms forward, 300ms backward
// Effect: Gradual fade-in of new page
```

### 4. Scale (Elastic)
**When to use:** Important actions, confirmations
```dart
CustomPageTransitions.scaleTransition(widget)
// Duration: 500ms forward, 300ms backward
// Effect: Bouncy scale-up with fade
// Curve: elasticOut (fun, playful)
```

---

## Configuration Examples

### Change Global Transition Timing

**File: lib/main.dart**
```dart
// Make all transitions faster
return CustomPageTransitions.slideAndFadeTransition(page);
// Change Duration here -> const Duration(milliseconds: 300)

// Make all transitions slower
// Change Duration here -> const Duration(milliseconds: 600)
```

### Create Custom Animation Duration

**File: lib/utils/page_transitions.dart**
```dart
// In CustomPageTransitions.slideAndFadeTransition:
static PageRouteBuilder slideAndFadeTransition(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 450), // ← Adjust here
    reverseTransitionDuration: const Duration(milliseconds: 300), // ← Or here
    // ... rest of code
  );
}
```

### Customize Indicator Appearance

```dart
// Make larger, faster dots
AnimatedIndicator(
  activeIndex: 0,
  count: 10,
  dotSize: 15.0,  // Larger dots
  animationDuration: const Duration(milliseconds: 200),  // Faster animation
  activeColor: Colors.blue,  // Different color
)

// Make smaller, slower progress bar
AnimatedProgressBar(
  currentStep: 3,
  totalSteps: 9,
  barHeight: 2.0,  // Thinner bar
  barWidth: 8.0,   // Narrower segments
  spacing: 2.0,    // Less space between
  animationDuration: const Duration(milliseconds: 800),  // Slower animation
)
```

---

## Common Patterns

### Pattern 1: Simple Next Button with Transition
```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    minimumSize: const Size(double.infinity, 50),
  ),
  onPressed: () {
    Navigator.push(
      context,
      CustomPageTransitions.slideAndFadeTransition(
        const NextScreen(),
      ),
    );
  },
  child: const Text('Next'),
)
```

### Pattern 2: Conditional Navigation with Different Transitions
```dart
if (selectedValue == 'premium') {
  Navigator.push(
    context,
    CustomPageTransitions.scaleTransition(const PremiumScreen()),
  );
} else {
  Navigator.push(
    context,
    CustomPageTransitions.slideAndFadeTransition(const BasicScreen()),
  );
}
```

### Pattern 3: Named Route Navigation (Easiest)
```dart
// Define in main.dart (already done)
onGenerateRoute: (settings) {
  final Widget page = _buildPage(settings.name ?? '');
  return CustomPageTransitions.slideAndFadeTransition(page);
}

// Use anywhere in your app
Navigator.pushNamed(context, '/goal_weight');
Navigator.pushNamed(context, '/obesity');
```

### Pattern 4: Back Navigation with Transition
```dart
// Back button with custom style
IconButton(
  icon: const Icon(Icons.arrow_back_ios),
  onPressed: () {
    Navigator.pop(context);  // Automatically uses reverse transition (300ms)
  },
)
```

---

## Animation Easing Curves Used

| Transition Type | Forward Curve | Notes |
|---|---|---|
| SlideAndFade | `Curves.easeInOutCubic` | Natural, professional |
| Slide | `Curves.easeInOutCubic` | Smooth acceleration |
| Fade | `Curves.easeInOutQuad` | Soft fade effect |
| Scale | `Curves.elasticOut` | Bouncy, playful |
| Indicator | `Curves.easeInOutQuad` | Smooth size change |

---

## Performance Considerations

### GPU Acceleration
All animations use GPU-accelerated transitions:
```dart
// Efficient - uses GPU
SlideTransition(position: offsetAnimation, child: child)
FadeTransition(opacity: fadeAnimation, child: child)
ScaleTransition(scale: scaleAnimation, child: child)
```

### Optimal Performance
- Duration: 300-500ms (fast enough to feel smooth, slow enough to be seen)
- No janky 60fps issues on modern devices
- Minimal CPU usage

### For Lower-End Devices
If you notice any lag:
```dart
// Option 1: Reduce transition duration
const Duration(milliseconds: 250)  // Instead of 400-500

// Option 2: Use simpler fade transition
CustomPageTransitions.fadeTransition(widget)

// Option 3: Use only on high-end devices
if (Platform.isAndroid || Platform.isIOS) {
  // Use transitions
}
```

---

## Troubleshooting Guide

### Q: Transitions don't appear smooth on slow device
**A:** Reduce duration or use simpler transition
```dart
// Faster transition
transitionDuration: const Duration(milliseconds: 200)

// Simpler transition
CustomPageTransitions.fadeTransition(widget)
```

### Q: Indicator animation is too fast/slow
**A:** Adjust AnimatedIndicator animationDuration
```dart
AnimatedIndicator(
  animationDuration: const Duration(milliseconds: 200),  // Faster
  // or
  animationDuration: const Duration(milliseconds: 800),  // Slower
)
```

### Q: Want different transition for one specific route
**A:** Use custom PageRouteBuilder directly
```dart
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const MyScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Custom animation logic here
    },
    transitionDuration: const Duration(milliseconds: 600),
  ),
);
```

### Q: Back transition feels weird
**A:** Check reverseTransitionDuration
```dart
// Should be shorter than forward duration
transitionDuration: const Duration(milliseconds: 450),
reverseTransitionDuration: const Duration(milliseconds: 300),  // OK ✓
```

---

## Complete Screen Implementation Example

```dart
// birth_screen.dart (COMPLETE EXAMPLE)
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import '../../utils/page_transitions.dart';
import 'gender_screen.dart';

class BirthScreen extends StatefulWidget {
  const BirthScreen({super.key});

  @override
  State<BirthScreen> createState() => _BirthScreenState();
}

class _BirthScreenState extends State<BirthScreen> {
  int _selectedYear = 1999;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. Animated Indicator showing progress
            AnimatedIndicator(
              activeIndex: 0,
              count: 10,
              animationDuration: const Duration(milliseconds: 400),
              activeColor: const Color(0xff13EC5B),
              inactiveColor: const Color(0xFFCCCCCC),
              dotSize: 10.0,
            ),
            
            const SizedBox(height: 60),
            
            // 2. Content
            const Text(
              "When were you born?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            
            const SizedBox(height: 60),
            
            // 3. Next button with smooth transition
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff13EC5B),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // Smooth transition to next screen
                Navigator.push(
                  context,
                  CustomPageTransitions.slideAndFadeTransition(
                    const GenderScreen(),
                  ),
                );
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Files Modified Summary

| File | Changes |
|------|---------|
| `lib/utils/page_transitions.dart` | **NEW** - Core transition classes |
| `lib/utils/navigation_extension.dart` | **NEW** - Navigation helpers |
| `lib/main.dart` | Added `onGenerateRoute` for auto transitions |
| `birth_screen.dart` | Added AnimatedIndicator + SlideAndFade |
| `gender_screen.dart` | Added AnimatedIndicator + SlideAndFade |
| `height_screen.dart` | Added AnimatedIndicator + SlideAndFade |
| `current_weight_screen.dart` | Added AnimatedIndicator |
| `goal_weight_screen.dart` | Added AnimatedIndicator |
| `obesity_screen.dart` | Added AnimatedProgressBar |
| `activity_screen.dart` | Added AnimatedProgressBar |
| `meal_goal_screen.dart` | Added AnimatedProgressBar |
| `review_screen.dart` | Added AnimatedProgressBar |

---

**Ready to use! Smooth transitions are now active throughout your app.** ✨
