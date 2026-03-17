import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/storage_item.dart';
import '../providers/storage_provider.dart';
import 'edit_screen.dart';


class DetailsScreen extends StatelessWidget {
  final StorageItem item;
  const DetailsScreen(this.item, {super.key});


  @override
  Widget build(BuildContext context) {
    final provider = context.read<StorageProvider>();


    return Scaffold(
      appBar: AppBar(title: Text(item.name)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Hero(
            tag: 'item_${item.id}',
            child: Material(
              color: Colors.transparent,
              child: Card(
                elevation: 8,
                color: Theme.of(context).colorScheme.secondaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: Text(
                          item.name.isNotEmpty
                              ? item.name[0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            fontSize: 40,
                            color:
                                Theme.of(context).colorScheme.onSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(item.name,
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.place, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text(item.location)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.notes, size: 18),
                          const SizedBox(width: 8),
                          Expanded(child: Text(item.note)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.edit),
                            label: const Text('Modifier'),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EditScreen(item: item)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          OutlinedButton.icon(
                            icon: const Icon(Icons.delete),
                            label: const Text('Supprimer'),
                            onPressed: () {
                              provider.delete(item);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}