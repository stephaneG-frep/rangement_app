import 'package:flutter/material.dart';
import '../models/storage_item.dart';
import '../screens/detail_screen.dart';


class StorageListItem extends StatelessWidget {
  final StorageItem item;
  const StorageListItem(this.item, {super.key});


  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Hero(
      tag: 'item_${item.id}',
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DetailsScreen(item)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 100,
                color: colorScheme.primaryContainer,
                child: Center(
                  child: CircleAvatar(
                    radius: 32,
                    backgroundColor: colorScheme.primary,
                    child: Text(
                      item.name.isNotEmpty ? item.name[0].toUpperCase() : '?',
                      style: TextStyle(
                        fontSize: 32,
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.place, size: 14),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(item.location,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}