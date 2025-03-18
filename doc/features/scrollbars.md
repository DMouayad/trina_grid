# Scrollbars

TrinaGrid provides extensive customization options for scrollbars, allowing you to create a better user experience, especially for desktop applications.

## Overview

Scrollbars in TrinaGrid can be customized through the `scrollbar` property in `TrinaGridConfiguration`, which provides a comprehensive set of options to control scrollbar appearance and behavior.

## Basic Usage

By default, TrinaGrid shows scrollbars when needed, but they can be configured to always be visible:

```dart
TrinaGrid(
  columns: columns,
  rows: rows,
  configuration: TrinaGridConfiguration(
    scrollbar: TrinaGridScrollbarConfig(
      isAlwaysShown: true, // Prevents scrollbars from fading out
    ),
  ),
)
```

## Advanced Scrollbar Customization

For more detailed control over the grid's scrollbars, you can use additional properties of `TrinaGridScrollbarConfig`:

```dart
TrinaGrid(
  columns: columns,
  rows: rows,
  configuration: TrinaGridConfiguration(
    scrollbar: TrinaGridScrollbarConfig(
      // Visibility settings
      isAlwaysShown: true,    // Prevents scrollbars from fading out after scrolling stops
      thumbVisible: true,     // Whether the scrollbar thumb is visible at all
      showTrack: true,        // Whether to show the track background
      showHorizontal: true,   // Whether to show the horizontal scrollbar
      showVertical: true,     // Whether to show the vertical scrollbar
      
      // Appearance settings
      thickness: 8.0,                          // Thickness of the scrollbar
      minThumbLength: 40.0,                    // Minimum length of the scrollbar thumb
      thumbColor: Colors.blue.withOpacity(0.6), // Color of the scrollbar thumb
      trackColor: Colors.grey.withOpacity(0.2), // Color of the scrollbar track
    ),
  ),
)
```

## Configuration Options

### TrinaGridScrollbarConfig

The `TrinaGridScrollbarConfig` class provides the following key options for scrollbar customization:

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isAlwaysShown` | `bool` | `false` | If true, scrollbars remain visible all the time. If false, they appear during scrolling and fade out after about 3 seconds of inactivity. |
| `thumbVisible` | `bool` | `true` | Whether the scrollbar thumb is visible at all. If false, scrollbars won't show even during scrolling. |
| `showTrack` | `bool` | `true` | Whether to show the scrollbar track background. |
| `showHorizontal` | `bool` | `true` | Whether to show the horizontal scrollbar. |
| `showVertical` | `bool` | `true` | Whether to show the vertical scrollbar. |
| `thickness` | `double` | `8.0` | Thickness of the scrollbar. |
| `minThumbLength` | `double` | `40.0` | Minimum length of the scrollbar thumb. |
| `thumbColor` | `Color?` | `null` | Color of the scrollbar thumb (defaults to semi-transparent gray if null). |
| `trackColor` | `Color?` | `null` | Color of the scrollbar track (defaults to light gray if null). |

There are additional properties available for advanced customization:

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `onlyDraggingThumb` | `bool` | `true` | If false, scrolling can be done by dragging the track area. |
| `enableScrollAfterDragEnd` | `bool` | `true` | Whether scrolling continues with momentum after releasing the scrollbar. |
| `scrollbarThickness` | `double` | `3.0` | Legacy thickness setting (prefer using `thickness` instead). |
| `scrollbarThicknessWhileDragging` | `double` | `8.0` | Thickness while dragging (only effective in certain scenarios). |
| `hoverWidth` | `double` | `12.0` | Width of the hover area. |
| `mainAxisMargin` | `double?` | `null` | Margin along the main axis. |
| `crossAxisMargin` | `double?` | `null` | Margin along the cross axis. |
| `scrollBarColor` | `Color?` | `null` | Deprecated: Use `thumbColor` instead. |
| `scrollBarTrackColor` | `Color?` | `null` | Deprecated: Use `trackColor` instead. |
| `scrollbarRadius` | `Radius` | `Radius.zero` | Radius of scrollbar corners. |
| `scrollbarRadiusWhileDragging` | `Radius` | `Radius.zero` | Radius of scrollbar corners while dragging. |
| `longPressDuration` | `Duration?` | `null` | Duration for long press detection. |
| `dragDevices` | `Set<PointerDeviceKind>?` | `null` | Set of devices that can drag the scrollbar. |

## Examples

### Always Visible Scrollbars

```dart
TrinaGrid(
  columns: columns,
  rows: rows,
  configuration: TrinaGridConfiguration(
    scrollbar: TrinaGridScrollbarConfig(
      isAlwaysShown: true,
    ),
  ),
)
```

### Custom Scrollbar Colors

```dart
TrinaGrid(
  columns: columns,
  rows: rows,
  configuration: TrinaGridConfiguration(
    scrollbar: TrinaGridScrollbarConfig(
      thumbColor: Colors.blue.withOpacity(0.6),
      trackColor: Colors.grey.withOpacity(0.2),
    ),
  ),
)
```

### Hiding Horizontal Scrollbar

```dart
TrinaGrid(
  columns: columns,
  rows: rows,
  configuration: TrinaGridConfiguration(
    scrollbar: TrinaGridScrollbarConfig(
      showHorizontal: false,
      showVertical: true,
    ),
  ),
)
```

### Completely Hiding Scrollbars

```dart
TrinaGrid(
  columns: columns,
  rows: rows,
  configuration: TrinaGridConfiguration(
    scrollbar: TrinaGridScrollbarConfig(
      thumbVisible: false,
    ),
  ),
)
```

### Thicker Scrollbars for Touch Devices

```dart
TrinaGrid(
  columns: columns,
  rows: rows,
  configuration: TrinaGridConfiguration(
    scrollbar: TrinaGridScrollbarConfig(
      thickness: 12.0,
      minThumbLength: 60.0,
    ),
  ),
)
```

## Best Practices

1. **Desktop Applications**: For desktop applications, consider setting `isAlwaysShown: true` to make scrollbars always visible, improving usability.

2. **Touch Devices**: For touch devices, consider using thicker scrollbars by increasing the `thickness` value.

3. **Consistent Styling**: Match scrollbar colors with your application's theme for a consistent look and feel.

4. **Accessibility**: Ensure scrollbars are visible enough for all users, especially those with visual impairments.

5. **Behavior Clarification**: Remember that:
   - `isAlwaysShown: true` makes scrollbars permanently visible (never fades out)
   - `isAlwaysShown: false` makes scrollbars appear during scrolling and fade out after about 3 seconds
   - `thumbVisible: false` completely hides scrollbars regardless of the `isAlwaysShown` setting

## Limitations

- The scrollbar settings only apply to the grid's main scrollbars, not to any scrollable widgets inside cells.
- Some scrollbar properties might not be available on all platforms due to platform-specific implementations.

## Related Features

- [Column Freezing](column-freezing.md) - Learn how to freeze columns in place while scrolling horizontally
- [Frozen Rows](frozen-rows.md) - Learn how to freeze rows in place while scrolling vertically
