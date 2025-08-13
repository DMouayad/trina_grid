import 'package:flutter/material.dart';
import 'package:trina_grid/src/model/trina_select_menu_filter.dart';
import 'package:trina_grid/src/ui/widgets/trina_select_menu.dart';

/// A contract for column types that use a [TrinaSelectMenu] inside the popup.
///
/// This interface should be implemented by column types that want to use
/// [TrinaPopupCellStateWithMenu] for their cell's state.
abstract class TrinaColumnTypeHasMenuPopup {
  /// The icon to display in the popup cell.
  IconData? get popupIcon;

  /// {@macro TrinaSelectMenu.items}
  List<dynamic> get items;

  /// {@macro TrinaSelectMenu.variant}
  TrinaSelectMenuVariant get menuVariant;

  /// {@macro TrinaSelectMenu.itemHeight}
  double get menuItemHeight;

  /// {@macro TrinaSelectMenu.maxHeight}
  double get menuMaxHeight;

  /// {@macro TrinaSelectMenu.width}
  double? get menuWidth;

  /// {@macro TrinaSelectMenu.itemBuilder}
  Widget Function(dynamic item)? get menuItemBuilder;

  /// {@macro TrinaSelectMenu.filters}
  List<TrinaSelectMenuFilter> get menuFilters;

  /// {@macro TrinaSelectMenu.itemToString}
  String Function(dynamic item)? get itemToString;

  /// {@macro TrinaSelectMenu.filtersInitiallyExpanded}
  bool get menuFiltersInitiallyExpanded;

  /// {@macro TrinaSelectMenu.itemToValue}
  dynamic Function(dynamic item)? get itemToValue;

  /// {@macro TrinaSelectMenu.emptyFilterResultBuilder}
  WidgetBuilder? get menuEmptyFilterResultBuilder;

  /// {@macro TrinaSelectMenu.emptySearchResultBuilder}
  WidgetBuilder? get menuEmptySearchResultBuilder;

  /// A callback invoked when a value is selected from the popup menu.
  ///
  /// The callback receives the newly selected value.
  void Function(dynamic item)? get onItemSelected;
}
