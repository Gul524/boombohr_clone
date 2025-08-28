# Copilot Instructions for demo_app

## Project Overview
- This is a Flutter application with Android, iOS, and Web targets.
- Main app code is in `lib/`, organized by feature modules (e.g., `lib/app/modules/forms`).
- Uses GetX for state management and navigation (`Get.put`, `GetxController`, `Obx`, `GetView`).
- Data models and repositories are in `lib/app/data/models/` and `lib/app/data/repositories/`.

## Architecture & Patterns
- **Feature Modules:** Each feature (e.g., forms) has its own directory with `controllers`, `views`, and related widgets.
- **Reactive State:** Controllers use `.obs` for reactive variables, updated via methods and observed in views with `Obx`.
- **Navigation:** Use `Get.toNamed('/route')` for navigation. Route definitions are likely in `lib/app/routes/`.
- **Widgets:** Shared widgets (e.g., `FormCard`, `BottomNav`, `ChipFilter`) are in `lib/app/widgets/`.
- **Sample Data:** Demo/sample data is often injected via controller methods (see `addSampleForm`).

## Developer Workflows
- **Build:** Use standard Flutter commands: `flutter run`, `flutter build apk`, etc.
- **Test:** If tests exist, run with `flutter test`. No test files detected in the current structure.
- **Debug:** Use Flutter's built-in debugging tools. Hot reload is supported.
- **Dependencies:** Managed via `pubspec.yaml`. Use `flutter pub get` after changes.

## Project-Specific Conventions
- **GetX Controllers:** Always initialize controllers with `Get.put` in views, and access with `controller` in `GetView`.
- **Reactive UI:** Use `Obx` for widgets that depend on controller state.
- **Form Handling:** Forms are represented by `FormModel` objects. Filtering and sample data logic is handled in the controller.
- **Routing:** Navigation is handled via named routes and GetX.

## Integration Points
- **External Packages:**
  - `get`: State management and navigation
  - `uuid`: For generating unique IDs
- **Assets:** Images and icons are in `assets/images/` and `web/icons/`.
- **Platform Code:** Android and iOS folders contain platform-specific files, but main logic is in Dart.

## Key Files & Directories
- `lib/main.dart`: App entry point
- `lib/app/modules/`: Feature modules (e.g., forms)
- `lib/app/widgets/`: Shared widgets
- `lib/app/data/models/`: Data models
- `lib/app/data/repositories/`: Data access
- `pubspec.yaml`: Dependencies and assets

## Example: Forms Feature
- Controller: `lib/app/modules/forms/controllers/forms_controller.dart`
- View: `lib/app/modules/forms/views/forms_view.dart`
- Model: `lib/app/data/models/models.dart`
- Repository: `lib/app/data/repositories/forms_repository.dart`

---
If any conventions or workflows are unclear, please provide feedback so this guide can be improved.
