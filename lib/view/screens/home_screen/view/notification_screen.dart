// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:work_Force/Constants/colors.dart';
import 'package:work_Force/view/screens/home_screen/model/notification_model.dart';
import 'package:timeago/timeago.dart' as timeago;

final List<NotificationModel> _seedNotifications = [
  NotificationModel(
    id: '1',
    title: 'New Task Assigned',
    subtitle: 'Install electrical panel at ACME Corp.',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    type: NotificationType.task,
  ),
  NotificationModel(
    id: '2',
    title: 'Comment Added',
    subtitle: 'Rajesh: “Need a 20 A breaker instead.”',
    timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 10)),
    type: NotificationType.comment,
  ),
  NotificationModel(
    id: '3',
    title: 'Reminder: Follow‑up Call',
    subtitle: 'Call Mr. Khan (Project X) at 4 PM.',
    timestamp: DateTime.now().subtract(const Duration(hours: 6)),
    type: NotificationType.reminder,
  ),
  NotificationModel(
    id: '4',
    title: 'Task Completed',
    subtitle: '“Annual maintenance – Star Mall” marked as done.',
    timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
    type: NotificationType.task,
    isRead: true,
  ),
  NotificationModel(
    id: '5',
    title: 'System Update',
    subtitle: 'Version 1.3 released – bug fixes & dark‑mode toggle.',
    timestamp: DateTime.now().subtract(const Duration(days: 2)),
    type: NotificationType.system,
    isRead: true,
  ),
];

class NotificationHistoryScreen extends StatefulWidget {
  const NotificationHistoryScreen({super.key});
  @override
  State<NotificationHistoryScreen> createState() =>
      _NotificationHistoryScreenState();
}

class _NotificationHistoryScreenState extends State<NotificationHistoryScreen> {
  late List<NotificationModel> _notifications;
  String _searchQuery = '';
  NotificationType? _activeFilter; // null → "All"

  @override
  void initState() {
    super.initState();
    _notifications = List.of(_seedNotifications);
    _activeFilter = NotificationType.all;
  }

  // Helpers ───────────────────────────────────────────────────────────────────
  List<NotificationModel> get _filteredList {
    return _notifications.where((n) {
      final matchesFilter = _activeFilter == NotificationType.all ||
          _activeFilter == null ||
          n.type == _activeFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          n.title.toLowerCase().contains(_searchQuery) ||
          n.subtitle.toLowerCase().contains(_searchQuery);
      return matchesFilter && matchesSearch;
    }).toList();
  }

  IconData _iconFor(NotificationType type) {
    switch (type) {
      case NotificationType.all:
        return Icons.all_inclusive;
      case NotificationType.task:
        return Icons.event_note_outlined;
      case NotificationType.reminder:
        return Icons.alarm_on_outlined;
      case NotificationType.comment:
        return Icons.chat_bubble_outline;
      case NotificationType.system:
        return Icons.settings_suggest_outlined;
    }
  }

  Color _colorFor(NotificationType type, BuildContext context) {
    switch (type) {
      case NotificationType.all:
        return Colors.grey;
      case NotificationType.task:
        return Colors.blueAccent;
      case NotificationType.reminder:
        return Colors.orangeAccent;
      case NotificationType.comment:
        return Colors.green;
      case NotificationType.system:
        return Theme.of(context).colorScheme.secondary;
    }
  }

  void _markAllRead() {
    setState(() {
      for (final n in _notifications) {
        n.isRead = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredList;

    return Scaffold(
      backgroundColor: kColorwhite,
      appBar: AppBar(
        title: const Text('Notification'),
        titleTextStyle: TextStyle(
            color: kColorblack, fontWeight: FontWeight.bold, fontSize: 18.5.sp),
        backgroundColor: kColorwhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.done_all,
              color: _notifications.any((n) => !n.isRead)
                  ? Colors.black
                  : Colors.green,
            ),
            tooltip: 'Mark all as read',
            onPressed:
                _notifications.any((n) => !n.isRead) ? _markAllRead : null,
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            tooltip: 'Search',
            onPressed: () async {
              final query = await showSearch<String>(
                context: context,
                delegate:
                    _NotificationSearchDelegate(initialQuery: _searchQuery),
              );
              if (query != null) {
                setState(() => _searchQuery = query.toLowerCase());
              }
            },
          ),
          PopupMenuButton<NotificationType?>(
            tooltip: 'Filter',
            itemBuilder: (context) => NotificationType.values.map((t) {
              return PopupMenuItem(
                value: t,
                child: Text(_Cap(t.name).capitalize()),
              );
            }).toList(),
            onSelected: (value) {
              setState(() {
                _activeFilter = value;
              });
            },
            icon: const Icon(
              Icons.filter_list,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: list.isEmpty
          ? const Center(child: Text('No notifications'))
          : ListView.builder(
              padding: EdgeInsets.only(top: 2.h),
              physics: const BouncingScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                final n = list[index];
                return Dismissible(
                  key: ValueKey(n.id),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => setState(
                      () => _notifications.removeWhere((e) => e.id == n.id)),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8, top: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.w),
                          border: Border.all(color: Colors.grey.shade200)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 6.w,
                            backgroundColor:
                                _colorFor(n.type, context).withOpacity(.15),
                            child: Icon(_iconFor(n.type),
                                color: _colorFor(n.type, context)),
                          ),
                          title: Text(
                            n.title,
                            style: TextStyle(
                                fontWeight: n.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold),
                          ),
                          subtitle: Text(n.subtitle),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                timeago.format(n.timestamp),
                                style: TextStyle(
                                    fontSize: 14.sp, color: kColorgrey),
                              ),
                              if (!n.isRead)
                                Container(
                                  margin: EdgeInsets.only(top: 2.w, right: 1.w),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: _colorFor(n.type, context),
                                      shape: BoxShape.circle),
                                ),
                            ],
                          ),
                          onTap: () {
                            setState(() => n.isRead = true);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Tapped → ${n.title}')));
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _NotificationSearchDelegate extends SearchDelegate<String> {
  _NotificationSearchDelegate({String initialQuery = ''})
      : super(searchFieldLabel: 'Search notifications') {
    query = initialQuery;
  }

  @override
  Widget buildSuggestions(BuildContext context) => _buildList();
  @override
  Widget buildResults(BuildContext context) => _buildList();

  Widget _buildList() {
    final items = _seedNotifications.where((n) {
      return n.title.toLowerCase().contains(query.toLowerCase()) ||
          n.subtitle.toLowerCase().contains(query.toLowerCase());
    }).take(_seedNotifications.length);

    return ListView(
      children: items
          .map((n) => ListTile(
                title: Text(n.title),
                subtitle: Text(n.subtitle,
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ))
          .toList(),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) => [
        if (query.isNotEmpty)
          IconButton(
              icon: const Icon(Icons.clear), onPressed: () => query = ''),
      ];

  @override
  Widget buildLeading(BuildContext context) =>
      BackButton(onPressed: () => close(context, query));
}

extension _Cap on String {
  String capitalize() => isEmpty ? this : this[0].toUpperCase() + substring(1);
}
