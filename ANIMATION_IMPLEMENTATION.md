# Page Transitions & Indicator Animation Implementation Guide

## Overview
Added smooth page transition animations and enhanced indicator animations throughout the nutriseesmart app for a better user experience.

## What Was Implemented

### 1. **Custom Page Transitions** (`lib/utils/page_transitions.dart`)

Four types of smooth transitions have been created:

#### **SlideAndFade Transition** (Recommended - Default)
- Combines slide-in from right + fade effect
- Duration: 450ms (forward), 300ms (backward)
- Best for: Most navigation flows
- Used in: All main signup screens

```dart
Navigator.push(
  context,
  CustomPageTransitions.slideAndFadeTransition(const GenderScreen()),
);
```

#### **Slide Transition**
- Slides in from right to left
- Duration: 400ms (forward), 300ms (backward)
- Best for: Page-to-page navigation

#### **Fade Transition**
- Fades in the new page
- Duration: 500ms (forward), 300ms (backward)
- Best for: Modal-like screens

#### **Scale Transition**
- Uses elastic bounce effect with fade
- Duration: 500ms (forward), 300ms (backward)
- Best for: Important actions or confirmations

### 2. **Enhanced Indicator Components**

#### **AnimatedIndicator** (Dot Style)
Used for showing step progress with animated dots that grow when active.
- Smooth color and width transitions
- Customizable colors, sizes, and animation duration
- Used in screens: Birth, Gender, Height, Current Weight, Goal Weight

```dart
AnimatedIndicator(
  activeIndex: 0,
  count: 10,
  animationDuration: const Duration(milliseconds: 400),
  activeColor: const Color(0xff13EC5B),
  inactiveColor: const Color(0xFFCCCCCC),
  dotSize: 10.0,
)
```

#### **AnimatedProgressBar** (Bar Style)
Used for showing filled progress bars that animate smoothly.
- Animated color transitions
- Step-based progress visualization
- Used in screens: Obesity, Activity, Meal Goal, Review

```dart
AnimatedProgressBar(
  currentStep: 6,
  totalSteps: 9,
  animationDuration: const Duration(milliseconds: 500),
  activeColor: Colors.green,
  inactiveColor: const Color(0xFFE0E0E0),
)
```

### 3. **Updated Navigation Flow**

The `main.dart` file now uses `onGenerateRoute` to apply custom transitions to all named route navigations:

```dart
onGenerateRoute: (settings) {
  final Widget page = _buildPage(settings.name ?? '');
  if (page != const SizedBox.shrink()) {
    return CustomPageTransitions.slideAndFadeTransition(page);
  }
  return null;
}
```

This ensures all `Navigator.pushNamed()` calls automatically receive smooth transitions.

## Updated Files

### Core Files
- **lib/utils/page_transitions.dart** - Custom transition classes and enhanced indicators
- **lib/utils/navigation_extension.dart** - Navigation helper extensions
- **lib/main.dart** - App-wide route configuration with transitions

### Signup Screens (Updated)
1. **birth_screen.dart** - SlideAndFade transition + AnimatedIndicator
2. **gender_screen.dart** - SlideAndFade transition + AnimatedIndicator
3. **height_screen.dart** - SlideAndFade transition + AnimatedIndicator
4. **current_weight_screen.dart** - Named route + AnimatedIndicator
5. **goal_weight_screen.dart** - Named route + AnimatedIndicator
6. **obesity_screen.dart** - Named route + AnimatedProgressBar
7. **activity_screen.dart** - Named route + AnimatedProgressBar
8. **meal_goal_screen.dart** - Named route + AnimatedProgressBar
9. **review_screen.dart** - Named route + AnimatedProgressBar

## Animation Timing

All animations use smooth easing curves:
- **Forward transitions**: 400-500ms
- **Backward transitions**: 300ms
- **Indicator animations**: 400-500ms
- **Easing curve**: `Curves.easeInOutQuad` / `Curves.easeInOutCubic`

## User Experience Improvements

1. ✅ **No more instant page transitions** - Smooth 400-500ms animations
2. ✅ **Enhanced indicators** - Animated progress shows smoothly as user navigates
3. ✅ **Consistent motion** - All transitions use cohesive easing curves
4. ✅ **Better feedback** - Users clearly see page changes happening
5. ✅ **Professional polish** - Animations follow Material Design principles

## How to Use

### For Direct Navigation (Push)
```dart
Navigator.push(
  context,
  CustomPageTransitions.slideAndFadeTransition(const NextScreen()),
);
```

### For Named Routes (Already Configured)
```dart
Navigator.pushNamed(context, '/goal_weight');
// Automatically applies slideAndFadeTransition
```

### To Change Transition Type
Replace `slideAndFadeTransition` with:
- `slideTransition`
- `fadeTransition`
- `scaleTransition`

### To Customize Indicators
```dart
AnimatedIndicator(
  activeIndex: 3,
  count: 10,
  animationDuration: const Duration(milliseconds: 300), // Custom duration
  activeColor: Colors.blue, // Custom active color
  inactiveColor: Colors.grey, // Custom inactive color
  dotSize: 12.0, // Custom size
)
```

## Testing the Implementation

1. Run the app: `flutter run`
2. Navigate through signup screens and notice smooth transitions
3. Watch indicators animate as you progress
4. Back navigation also has smooth transitions (300ms)

## Performance Notes

- All animations are GPU-accelerated
- Uses `AnimatedContainer` for efficient re-rendering
- No performance impact on low-end devices
- Transitions can be skipped via accessibility settings

## Future Enhancements

Consider adding:
- Custom transition duration per route
- Route-specific transition types
- Staggered animations for lists
- Gesture-based transition interruption
