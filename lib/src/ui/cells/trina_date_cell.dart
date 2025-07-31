import 'package:flutter/material.dart';
import 'package:trina_grid/src/ui/widgets/trina_date_picker.dart';
import 'package:trina_grid/src/ui/miscellaneous/trina_popup_cell_state_with_custom_popup.dart';
import 'package:trina_grid/trina_grid.dart';

import 'popup_cell.dart';

class TrinaDateCell extends StatefulWidget implements PopupCell {
  @override
  final TrinaGridStateManager stateManager;

  @override
  final TrinaCell cell;

  @override
  final TrinaColumn column;

  @override
  final TrinaRow row;

  const TrinaDateCell({
    required this.stateManager,
    required this.cell,
    required this.column,
    required this.row,
    super.key,
  });

  @override
  TrinaDateCellState createState() => TrinaDateCellState();
}

class TrinaDateCellState
    extends TrinaPopupCellStateWithCustomPopup<TrinaDateCell> {
  @override
  IconData? get popupMenuIcon => widget.column.type.date.popupIcon;

  @override
  late final Widget popupContent;

  @override
  void initState() {
    popupContent = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 300),
      child: TrinaDatePicker(
        initialDate: DateTime.tryParse(widget.cell.value),
        firstDate: widget.column.type.date.startDate,
        lastDate: widget.column.type.date.endDate,
        onDateChanged: (value) {
          final currentDate =
              widget.column.type.date.dateFormat.tryParse(widget.cell.value);
          handleSelected(widget.column.type.date.dateFormat.format(value));

          final onlyYearWasChanged = (currentDate?.year != value.year) &&
              currentDate?.month == value.month &&
              currentDate?.day == value.day;

          if (onlyYearWasChanged) {
            // we don't want to close the date picker when the user
            // selects a new year
            return;
          }
          closePopup(context);
        },
      ),
    );
    super.initState();
  }
}
