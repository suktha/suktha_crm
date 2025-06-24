import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';

class CustomDropdownWithSearch<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T) itemToString;
  final void Function(T) onSelected;
   String? labelText;
  final bool searchable;
 final TextEditingController controller;

   CustomDropdownWithSearch({
    super.key,
    required this.items,
    required this.itemToString,
    required this.onSelected,
    required this.labelText,
    this.searchable = true, 
   required this.controller,
  });

  @override
  State<CustomDropdownWithSearch<T>> createState() =>
      _CustomDropdownWithSearchState<T>();
}

class _CustomDropdownWithSearchState<T>
    extends State<CustomDropdownWithSearch<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<T> _filteredItems = [];

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    _removeOverlay();

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height,
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 0),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: _filteredItems.map((item) {
                  return ListTile(
                    title: Text(widget.itemToString(item)),
                    onTap: () {
                      widget.controller.text = widget.itemToString(item);
                      widget.onSelected(item);
                      _removeOverlay();
                      FocusScope.of(context).unfocus();
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _filterAndShow(String value) {
    setState(() {
      if (widget.searchable) {
        _filteredItems = widget.items
            .where((item) => widget
                .itemToString(item)
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList();
      } else {
        _filteredItems = widget.items;
      }
    });

    if (_filteredItems.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          if (!widget.searchable) {
            _filterAndShow('');
          }
        },
        child: TextField(
          controller: widget.controller,
          readOnly: !widget.searchable,
          decoration: InputDecoration(
            labelText: widget.labelText,
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              color: kColorblack,
            ),
            hintText:
                widget.searchable == true ? "Search ${widget.labelText}" : "",
            hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: kColorgrey),
            contentPadding: EdgeInsets.only(left: 2.w),
            labelStyle: TextStyle(
                overflow: TextOverflow.fade,
                fontSize: 15.sp,
                color: const Color.fromARGB(255, 78, 78, 78),
                fontWeight: FontWeight.w700),
            errorBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kColorRed),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kColorgrey),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kColorgrey),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: kColorgrey),
            ),
          ),
          onChanged: (value) {
            if (widget.searchable) {
              _filterAndShow(value);
            }
          },
        ),
      ),
    );
  }
}
