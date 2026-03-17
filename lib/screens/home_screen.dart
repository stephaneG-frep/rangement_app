import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/storage_provider.dart';
import '../widgets/storage_list_item.dart';
import 'edit_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StorageProvider>();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes objets'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SearchBar(
              hintText: 'Rechercher un objet ou emplacement',
              onChanged: provider.search,
              trailing: [
                IconButton(
                  tooltip: 'Effacer la recherche',
                  icon: const Icon(Icons.clear),
                  onPressed: () => provider.search(''),
                ),
              ],
            ),
          ),
        ),
      ),
      body: provider.items.isEmpty
          ? const Center(child: Text('Aucun objet enregistré'))
          : GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.0,
        ),
        itemCount: provider.items.length,
        itemBuilder: (_, i) => StorageListItem(provider.items[i]),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Ajouter un objet',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const EditScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}