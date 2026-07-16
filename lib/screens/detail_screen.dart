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
      appBar: AppBar(
        title: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
        actions: [
          IconButton(
            tooltip: 'Modifier',
            icon: const Icon(Icons.edit_outlined),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => EditScreen(item: item))),
          ),
          IconButton(
            tooltip: 'Supprimer',
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              provider.delete(item);
              if (context.mounted) Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth > 360
                ? 360.0
                : constraints.maxWidth - 32;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withOpacity(0.96),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        width: 0.6,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          child: Text(
                            item.name.isNotEmpty
                                ? item.name[0].toUpperCase()
                                : '?',
                            style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          item.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 14),
                        _InfoRow(
                          icon: Icons.place_outlined,
                          label: 'Emplacement',
                          value: item.location,
                        ),
                        const SizedBox(height: 8),
                        _InfoRow(
                          icon: Icons.notes_outlined,
                          label: 'Note',
                          value: item.note,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            FilledButton.icon(
                              icon: const Icon(Icons.edit_outlined),
                              label: const Text('Modifier'),
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => EditScreen(item: item),
                                ),
                              ),
                            ),
                            OutlinedButton.icon(
                              icon: const Icon(Icons.delete_outline),
                              label: const Text('Supprimer'),
                              onPressed: () {
                                provider.delete(item);
                                if (context.mounted) Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = value.isEmpty ? 'Non renseigné' : value;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              const SizedBox(height: 2),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
                overflow: TextOverflow.visible,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
