import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'app_bar.dart';

class DragScrollSheetWithFab extends StatefulWidget {
  @override
  _DragScrollSheetWithFabState createState() => _DragScrollSheetWithFabState();
}

class _DragScrollSheetWithFabState extends State<DragScrollSheetWithFab> {
  double _initialSheetChildSize = 0.5;
  double _dragScrollSheetExtent = 0;

  double _widgetHeight = 0;
  double _fabPosition = 0;
  double _fabPositionPadding = 10;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        // render the floating button on widget
        _fabPosition = _initialSheetChildSize * context.size.height;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExampleAppBarLayout(
        title: "Controller",
        showGoBack: true,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Text('Height: ${_widgetHeight.toStringAsFixed(2)}, \nExtent: ${_dragScrollSheetExtent.toStringAsFixed(2)}, \nFabYPosition: ${_fabPosition.toStringAsFixed(2)}'),
            ),
            Positioned(
              bottom: _fabPosition + _fabPositionPadding,
              right: _fabPositionPadding, // Padding to create some space on the right
              child: FloatingActionButton(
                child: Icon(Icons.my_location),
                onPressed: () => print('Add'),
              ),
            ),
            NotificationListener<DraggableScrollableNotification>(
              onNotification: (DraggableScrollableNotification notification) {
                setState(() {
                  _widgetHeight = context.size.height;
                  _dragScrollSheetExtent = notification.extent;

                  // Calculate FAB position based on parent widget height and DraggableScrollable position
                  _fabPosition = _dragScrollSheetExtent * _widgetHeight;
                });
                return;
              },
              child: DraggableScrollableSheet(
                initialChildSize: _initialSheetChildSize,
                maxChildSize: 0.5,
                minChildSize: 0.1,
                builder: (context, scrollController) => ListView.builder(
                  controller: scrollController,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.grey,
                      child: ListTile(
                        title: Text('Item $index'),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
