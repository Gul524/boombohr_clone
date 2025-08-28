import 'package:demo_app/app/data/models/models.dart';
import 'package:demo_app/app/modules/pages/section_reorder.dart';
import 'package:flutter/material.dart';

class ReorderPage extends StatefulWidget {
  final TabModel tab;

  const ReorderPage({super.key, required this.tab});

  @override
  State<ReorderPage> createState() => _ReorderPageState();
}

class _ReorderPageState extends State<ReorderPage> {
  late TabModel tabCopy;

  @override
  void initState() {
    super.initState();
    tabCopy = TabModel.fromJson(widget.tab.toJson()); // deep copy
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reorder ${tabCopy.title}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => Navigator.pop(context, tabCopy),
          )
        ],
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;
            final section = tabCopy.sections!.removeAt(oldIndex);
            tabCopy.sections!.insert(newIndex, section);
          });
        },
        children: [
          for (int i = 0; i < (tabCopy.sections?.length ?? 0); i++)
            ListTile(
              key: ValueKey(i),
              title: Text(tabCopy.sections![i].title),
              trailing: const Icon(Icons.drag_handle),
              onTap: () async {
                // navigate into section-level reordering
                // final updated = await Navigator.push(
                // context,
                // MaterialPageRoute(
                // builder: (_) =>
                // SectionReorderPage(section: tabCopy.sections![i]),
                // ),
                // );
                // if (updated != null) {
                //   setState(() => tabCopy.sections![i] = updated);
                // }
              },
            )
        ],
      ),
    );
  }
}
