part of tangram_flutter_base;

/// A container object for configuration options when building a widget.
///
/// This is intended for use as a parameter in platform interface methods, to
/// allow adding new configuration options to existing methods.
@immutable
class TangramWidgetConfiguration {
  /// Creates a new configuration with all the given settings.
  const TangramWidgetConfiguration({
    required this.textDirection,
    this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
  });

  /// The text direction for the widget.
  final TextDirection textDirection;

  /// Gesture recognizers to add to the widget.
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
}
