# Motion

Material 3 Expressive treats motion as a first-class design element — not decoration. Motion explains spatial relationships, confirms interactions, and communicates hierarchy through physically plausible spring physics rather than fixed-duration cubic bezier curves.

Official reference: [Material motion](https://m3.material.io/styles/motion/overview/how-it-works), [Easing and duration](https://m3.material.io/styles/motion/easing-and-duration/applying-easing-and-duration), [Transition patterns](https://m3.material.io/styles/motion/transitions/transition-patterns)

---

## Two motion schemes

M3E specifies two distinct spring physics schemes. Choosing the wrong one produces an incorrect interaction feel.

| Scheme | When to use | Spring character | Dart accessor |
|---|---|---|---|
| **Spatial spring** | Positional movement, size change, shape morph, element entering/leaving screen | Slight overshoot (bouncy) | `m3e.motion.createSpatialSpring()` |
| **Effect spring** | Color change, opacity/fade, elevation change, icon swap | Critically damped (smooth, no overshoot) | `m3e.motion.createEffectSpring()` |

**Evidence:** Material guidance (two-scheme distinction) + Custom (spring parameter values: mass, stiffness, damping are not published by Google; labeled custom).

---

## Duration tokens

**Evidence:** Custom Implementation Choice — Material guidance describes duration principles but does not mandate specific millisecond values for every component state. Use these as a starting point and adjust against the source page for any specific component.

| Token | Value | Use for |
|---|---|---|
| `durationFast` | 150ms | Focus indicators, supported pointer-hover highlights, and micro-interactions |
| `durationMedium` | 300ms | Selected/unselected state changes, expand/collapse, navigation |
| `durationSlow` | 500ms | Full-screen transitions, large container transforms |

---

## Curve tokens

| Token | Flutter curve | Use for |
|---|---|---|
| `curveSpatialOvershoot` | `Curves.easeOutBack` | Positional springs where slight overshoot is expressive |
| `curveContainerMorph` | `Curves.fastOutSlowIn` | Container size and shape morphing |
| `curveEffectFade` | `Curves.easeOutCubic` | Fades, opacity, color, elevation |

---

## Implementation patterns

### Pattern 1: Simple state transition (`AnimatedContainer`)

The simplest way to animate a state change. Use when the animated property is a direct style — color, size, border radius.

```dart
AnimatedContainer(
  duration: context.m3e.motion.durationMedium,
  curve: context.m3e.motion.curveEffectFade,
  padding: isSelected
    ? context.m3e.spacing.symmetricH16V12
    : context.m3e.spacing.symmetricH16V8,
  decoration: BoxDecoration(
    color: isSelected
      ? theme.colorScheme.secondaryContainer
      : theme.colorScheme.surfaceContainerLow,
    borderRadius: context.m3e.shapes.borderFull,
  ),
  child: Text(label, style: theme.textTheme.labelLarge),
)
```

### Pattern 2: Spring-driven positional animation

Use when an element moves to a new position or grows/shrinks in response to user input.

```dart
class _SpringCard extends StatefulWidget {
  const _SpringCard();
  @override
  State<_SpringCard> createState() => _SpringCardState();
}

class _SpringCardState extends State<_SpringCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  void _expand() {
    final sim = context.m3e.motion.createSpatialSpring(start: 0.0, end: 1.0);
    _controller.animateWith(sim);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => SizeTransition(
        sizeFactor: _controller,
        child: child,
      ),
      child: const _ExpandedContent(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

### Pattern 3: `AnimatedSwitcher` for element swaps

Use when one widget replaces another (icon change, content update).

```dart
AnimatedSwitcher(
  duration: context.m3e.motion.durationFast,
  transitionBuilder: (child, animation) => FadeTransition(
    opacity: animation,
    child: child,
  ),
  child: Icon(
    isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
    key: ValueKey(isLiked),
    color: isLiked
      ? theme.colorScheme.primary
      : theme.colorScheme.onSurfaceVariant,
  ),
)
```

### Pattern 4: Page/route transitions

```dart
// Inside your GoRouter or Navigator route configuration:
CustomTransitionPage(
  child: const NextScreen(),
  transitionsBuilder: (context, animation, secondary, child) {
    final m3e = context.m3e;
    final reduceMotion = MediaQuery.of(context).disableAnimations;
    if (reduceMotion) return child;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: m3e.motion.curveContainerMorph,
      )),
      child: child,
    );
  },
)
```

---

## Reduced motion — mandatory requirement

**Every animated widget must check `MediaQuery.of(context).disableAnimations`.** This covers both the Android "Remove animations" developer option and the iOS "Reduce Motion" accessibility setting.

```dart
Widget buildAnimatedToggle(BuildContext context, bool isActive) {
  final m3e = context.m3e;
  final theme = Theme.of(context);
  final reduceMotion = MediaQuery.of(context).disableAnimations;

  return AnimatedContainer(
    // Duration collapses to zero when reduce-motion is active
    duration: reduceMotion ? Duration.zero : m3e.motion.durationMedium,
    curve: m3e.motion.curveEffectFade,
    color: isActive
      ? theme.colorScheme.primaryContainer
      : theme.colorScheme.surfaceContainerLow,
    child: child,
  );
}
```

---

## Anti-patterns

- **Do not** animate every widget on first build (entrance animations on all items are visually overwhelming).
- **Do not** use `duration: const Duration(milliseconds: 220)` — use `m3e.motion.durationFast` instead.
- **Do not** leave animations running after a widget disposes (always call `controller.dispose()`).
- **Do not** assume a specific curve or duration matches M3E unless the official component page states it — label custom choices explicitly.
- **Do not** use motion to hide loading states (prefer skeleton screens or progress indicators for meaningful feedback).

---

## Verification checklist

- [ ] Every animation uses `m3e.motion` duration and curve tokens — no raw milliseconds or `Curves.*` literals.
- [ ] Spatial spring used for positional/size changes; effect spring used for color/opacity changes.
- [ ] `MediaQuery.of(context).disableAnimations` checked — `Duration.zero` fallback applied.
- [ ] `AnimationController.dispose()` called in every `State.dispose()`.
- [ ] Rapid repeated input (e.g. tapping quickly) does not leave the UI in an intermediate state.
- [ ] Route transitions are interruptible (back-swipe mid-transition works correctly).
