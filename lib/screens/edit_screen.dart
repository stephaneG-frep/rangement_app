// lib/screens/edit_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/storage_item.dart';
import '../providers/storage_provider.dart';

class EditScreen extends StatefulWidget {
  final StorageItem? item;
  const EditScreen({this.item, super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _locationCtrl;
  late final TextEditingController _noteCtrl;

  @override
  void initState() {
    super.initState();

    _nameCtrl = TextEditingController(text: widget.item?.name ?? '');
    _locationCtrl = TextEditingController(text: widget.item?.location ?? '');
    _noteCtrl = TextEditingController(text: widget.item?.note ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _locationCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final provider = context.read<StorageProvider>();

    final name = _nameCtrl.text.trim();
    final location = _locationCtrl.text.trim();
    final note = _noteCtrl.text.trim();

    if (widget.item == null) {
      // ✅ AJOUT
      final newItem = StorageItem(
        id: DateTime.now().millisecondsSinceEpoch,
        name: name,
        location: location,
        note: note,
      );
      await provider.add(newItem);
    } else {
      // ✅ MODIFICATION (pas de add)
      widget.item!
        ..name = name
        ..location = location
        ..note = note;

      await provider.update(widget.item!); // -> item.save()
    }

    provider.clearSearch();
    if (mounted) Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    final isEditing = widget.item != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Modifier' : 'Ajouter'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                    hintText: 'Ex: Clés, Chargeur, Passeport…',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Nom requis';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _locationCtrl,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Emplacement',
                    hintText: 'Ex: Entrée, Tiroir, Garage…',
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Emplacement requis';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _noteCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Note',
                    hintText: 'Détail rapide (optionnel)',
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save),
                    label: const Text('Enregistrer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
