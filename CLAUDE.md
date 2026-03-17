# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run on device/emulator
flutter run

# Build APK
flutter build apk

# Regenerate Hive adapters after modifying StorageItem
dart run build_runner build --delete-conflicting-outputs

# Lint
flutter analyze

# Tests
flutter test
```

## Architecture

Application Flutter de rangement (inventory tracker) — Material 3, thème amber chaud, light/dark.

**State management** : `provider` — un seul `ChangeNotifier` (`StorageProvider`) injecté à la racine dans `main.dart`.

**Persistance** : `hive_flutter` — une seule box `'storage'` de type `Box<StorageItem>`. Le box est ouvert dans `main()` et passé directement au provider. Toute modification passe par `StorageProvider` (add/update/delete) qui appelle `box.flush()` après chaque écriture.

**Modèle** : `StorageItem` est un `HiveObject` avec les champs `id` (int, timestamp ms), `name`, `location`, `note`. Le fichier `.g.dart` est généré — ne pas modifier manuellement, relancer `build_runner` si le modèle change.

**Navigation** : pas de router nommé, navigation impérative (`Navigator.push`). Flux : `HomeScreen` → `DetailsScreen` ou `EditScreen`. `EditScreen` sert à la fois pour l'ajout (`item == null`) et la modification.

**Hero animation** : tag `'item_${item.id}'` entre `StorageListItem` (grille) et `DetailsScreen`.

**Recherche** : filtre en mémoire dans `StorageProvider.items` (getter) sur `name` et `location`, déclenché par `SearchBar` dans l'AppBar de `HomeScreen`.
