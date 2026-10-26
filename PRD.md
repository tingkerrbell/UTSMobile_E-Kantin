# PRODUCT REQUIREMENTS DOCUMENT (PRD)
## KantinKu — Flutter Canteen Menu Management App

**Project Name:** KantinKu  
**Platform:** Android Mobile  
**Framework:** Flutter (Dart)  
**Project Type:** Mobile Programming Midterm Examination  
**Academic Year:** 2026/2027

---

## 1. Project Overview

KantinKu is a simple mobile application for managing a canteen menu list. Users can view available food and beverage items with their prices, open a detail page for a selected menu item, and add new menu items through a form.

The application must be developed using Flutter and must strictly follow the widget hierarchies specified in the original examination diagrams for the Menu List Page and Add Menu Page.

The primary priorities are widget structure compliance, functional correctness, form validation, reusable custom text widgets, and clean code.

## 2. Project Objectives

1. Display a list of canteen menu items and their prices.
2. Provide a detail page for each selected menu item.
3. Allow users to add new menu items through a validated form.
4. Implement a reusable custom text widget using Google Fonts.
5. Implement navigation using GetX according to the examination requirements.
6. Return newly created menu data to the list page and update the UI immediately.

## 3. Technology Stack

- **Flutter and Dart:** Main application framework and programming language.
- **get:** Used only for `GetMaterialApp`, `Get.to()`, and `Get.back()`.
- **google_fonts:** Used to apply Google Fonts in the custom text widget.
- **Flutter Material:** Used for UI components such as Scaffold, AppBar, Card, ListTile, TextFormField, and buttons.
- **State management:** `StatefulWidget`, `setState()`, and Flutter form validation.
- **Data storage:** A regular Dart List stored inside the State of the menu list page.

Do not introduce a database, backend, API, or additional state management package. GetX must not be used for state management, dependency injection, or any purpose beyond the permitted navigation functionality.

## 4. Application Pages

### 4.1. Menu List Page — MenuListPage

**Purpose:** Display all available canteen menu items and serve as the application's main page.

**Functional Requirements:**

- Implement the page using `StatefulWidget`.
- Store menu data in a regular Dart List inside the page's State.
- Provide at least five initial menu items with fictional names and prices.
- Display the menu using `ListView.builder`.
- Each menu item must be displayed inside a `Card` containing a `ListTile`.
- `ListTile.title` must display the menu name.
- `ListTile.subtitle` must display the menu price.
- `ListTile.leading` must contain an Icon.
- `ListTile.trailing` must contain an Icon.
- When a menu item is tapped, navigate to its detail page using `Get.to()`.
- Provide a `FloatingActionButton` containing an Icon to navigate to the Add Menu Page using `Get.to()`.
- When the Add Menu Page returns valid data, add the new item to the existing List using `setState()`.

**Initial Sample Data:**

1. Nasi Goreng — IDR 15,000
2. Ayam Geprek — IDR 18,000
3. Mie Ayam — IDR 12,000
4. Es Teh Manis — IDR 5,000
5. Bakso — IDR 14,000

Store prices as numeric values to simplify validation and currency formatting.

**Mandatory Widget Hierarchy:**

```text
Scaffold
├── AppBar
│   └── Text → CustomText
├── Column
│   ├── Padding
│   │   └── Text → CustomText
│   └── Expanded
│       └── ListView.builder
│           └── Card
│               └── ListTile
│                   ├── leading: Icon
│                   ├── title: CustomText
│                   ├── subtitle: CustomText
│                   └── trailing: Icon
└── FloatingActionButton
    └── Icon
```

Do not add, remove, reorder, or replace any required widget nodes in this hierarchy. Supporting properties may be configured as necessary, provided that the required widget structure remains unchanged.

### 4.2. Menu Detail Page — MenuDetailPage

**Purpose:** Display the details of a menu item selected from the menu list.

**Requirements:**

- Receive the menu name and price through the page constructor.
- Display the selected item's name and price clearly.
- Use `CustomText` for all displayed text.
- Provide a way to navigate back to the menu list.
- The layout is flexible because the examination does not specify a mandatory widget diagram for this page.
- Use `Get.back()` to return to the previous page.
- No separate data storage is required.

### 4.3. Add Menu Page — AddMenuPage

**Purpose:** Allow users to add a new menu item to the canteen menu list.

**Form Fields:**

1. **Menu Name:** A `TextFormField` that must not be empty.
2. **Menu Price:** A `TextFormField` that must not be empty and must accept numeric input only.
3. **Add Menu Button:** An `ElevatedButton` to validate and submit the form.

**Validation Requirements:**

- The menu name cannot be empty.
- The menu price cannot be empty.
- The price field must restrict input to digits using `FilteringTextInputFormatter.digitsOnly`.
- The price field must include a validator.
- The entered price must be convertible to a valid numeric value.
- If validation fails, display an appropriate error message and do not submit the form.
- If validation succeeds, create a new menu data object and return it to the previous page using `Get.back(result: ...)`.

**Mandatory Widget Hierarchy:**

```text
Scaffold
├── AppBar
│   └── Text → CustomText
└── Padding
    └── Form
        └── Column
            ├── TextFormField → Menu Name
            ├── SizedBox
            ├── TextFormField → Menu Price
            ├── SizedBox
            └── ElevatedButton
                └── CustomText
```

The first and second `TextFormField` widgets must each have appropriate input configuration, labels, and validation logic. Use `SizedBox` for spacing between the fields as specified in the diagram.

Do not add, remove, reorder, or replace any required widget nodes in this hierarchy.

**Returning Menu Data:**

Use the following data-return contract as a reference:

```dart
Get.back(
  result: {
    'name': nameController.text.trim(),
    'price': int.parse(priceController.text.trim()),
  },
);
```

Ensure that the controllers are correctly initialized and that form validation succeeds before returning the result.

### 4.4. Data Return and List Update Flow

The Menu List Page must await the result returned from the Add Menu Page.

Example implementation:

```dart
final result = await Get.to(
  () => AddMenuPage(),
);

if (result != null) {
  setState(() {
    menus.add(result);
  });
}
```

Adjust the data types and implementation as needed to maintain type safety and consistency.

After a valid submission, the new menu item must immediately appear in the menu list without restarting the application.

## 5. Reusable Custom Text Widget

Create a reusable custom text widget named `CustomText` that extends `StatelessWidget`.

**Requirements:**

- Accept a text parameter of type `String`.
- Provide at least two configurable style parameters, such as `fontSize`, `fontWeight`, or `color`.
- Use a font from the `google_fonts` package.
- Support reuse across multiple application pages.
- Every `Text` node shown in the mandatory widget diagrams must be implemented using `CustomText`, not Flutter's built-in `Text` widget directly.
- String-valued configuration parameters, such as `labelText`, hint text, and validator messages, are exempt from this requirement.
- AppBar titles, headings, menu names, prices, and button labels must use the custom widget wherever they correspond to a required Text node in the diagrams.

Choose one readable Google Font, such as Poppins or Nunito. Keep font styling consistent while allowing the size, weight, and color to be configured through parameters.

Add a 2–3 line design rationale comment immediately above the `CustomText` class declaration. Explain why the selected font and visual style were chosen.

Example:

```dart
// Google Fonts provides consistent typography throughout the application.
// The selected font improves readability on mobile screens.
// Configurable style parameters make the widget reusable.
```

Adapt the final comment to reflect the actual design implementation.

## 6. UI/UX Design Guidelines

The visual design is flexible as long as the mandatory widget structures remain unchanged.

Create a clean, modern interface suitable for a university canteen application.

**Recommended Visual Direction:**

- **Primary color:** Dark green or emerald.
- **Background:** White or very light gray.
- **Typography:** Poppins or Nunito using Google Fonts.
- **Cards:** Rounded corners with subtle elevation.
- **Buttons:** Consistent primary color.
- **Spacing:** Appropriate padding and `SizedBox` spacing while preserving the required hierarchy.
- **Price display:** Use Indonesian Rupiah formatting, for example, `Rp15.000`.
- **Icons:** Use appropriate icons for menu items and navigation actions.

Visual styling may be improved, but do not introduce additional widget nodes that alter the required widget hierarchy.

## 7. Suggested Project Structure

Organize the application into separate files for readability and maintainability.

```text
lib/
├── main.dart
├── models/
│   └── menu_model.dart
├── pages/
│   ├── menu_list_page.dart
│   ├── menu_detail_page.dart
│   └── add_menu_page.dart
└── widgets/
    └── custom_text.dart
```

A simple menu model may be used to represent menu names and prices. However, the initial menu data must still be stored in a regular List inside the State of the Menu List Page.

## 8. Functional Requirements and Acceptance Criteria

| ID | Requirement | Acceptance Criteria |
|---|---|---|
| FR-01 | Display menu list | At least five initial items are displayed |
| FR-02 | Display menu names and prices | Names appear in titles and prices in subtitles |
| FR-03 | Open menu details | The selected item's correct name and price are displayed |
| FR-04 | Open Add Menu Page | FAB navigates using `Get.to()` |
| FR-05 | Validate menu name | Empty names are rejected |
| FR-06 | Validate menu price | Empty and non-numeric prices are rejected |
| FR-07 | Return new menu data | Valid data is returned using `Get.back(result: ...)` |
| FR-08 | Update the menu list | New items are added using `setState()` |
| FR-09 | Use the custom text widget | All required Text nodes use `CustomText` |
| FR-10 | Preserve widget hierarchy | Both mandatory diagrams are followed exactly |
| FR-11 | Restrict GetX usage | GetX is used only for permitted navigation |
| FR-12 | Run without errors | The application builds and its primary flows work correctly |

## 9. Non-Functional Requirements

- Write clean, readable, and consistent Dart code.
- Follow Dart null safety practices.
- Avoid unnecessary code duplication.
- Use descriptive class and variable names.
- Do not implement databases, APIs, authentication, or backend services.
- Do not add external state management solutions.
- Ensure the UI remains usable on mobile screens.
- Ensure that all required pages can be opened and closed without runtime errors.

## 10. Testing Checklist

Before completing the implementation, verify the following:

- [ ] The application launches successfully.
- [ ] The menu list displays at least five initial items.
- [ ] Menu names and prices appear in the required positions.
- [ ] Tapping a menu opens the correct detail page.
- [ ] Users can return from the detail page.
- [ ] The FAB opens the Add Menu Page.
- [ ] The form rejects an empty menu name.
- [ ] The form rejects an empty menu price.
- [ ] The price field accepts digits only.
- [ ] Invalid input displays appropriate validation messages.
- [ ] Valid data is returned using `Get.back(result: ...)`.
- [ ] New menu items appear immediately in the menu list.
- [ ] Every required Text node uses `CustomText`.
- [ ] The 2–3 line design rationale comment appears above the custom widget class.
- [ ] The Menu List Page and Add Menu Page follow their original widget diagrams.
- [ ] No build errors or runtime errors occur in the primary application flows.

## 11. Development Instructions for Antigravity

Implement the application according to this PRD and use the original examination document as the primary reference for the mandatory widget diagrams.

**Development Workflow:**

1. Inspect the existing Flutter project structure and `pubspec.yaml` before making changes.
2. Implement `CustomText` and configure Google Fonts.
3. Implement the Menu List Page according to the required widget hierarchy.
4. Implement the Add Menu Page according to the required widget hierarchy.
5. Implement the Menu Detail Page and navigation flows.
6. Implement form validation and result handling.
7. Run code formatting, static analysis, and a build to identify errors.
8. Fix all errors without violating the required widget structures.
9. Report the files created or modified, verification results, and any unmet requirements.

**Critical Constraints:**

- Never change the hierarchy, order, or number of required widget nodes in the Menu List Page and Add Menu Page diagrams.
- Do not replace `ListView.builder` with `ListView`, `Column`, or another widget.
- Do not replace the Menu List Page's `StatefulWidget` with `StatelessWidget`.
- Do not directly use Flutter's built-in `Text` widget for required Text nodes.
- Do not use GetX for purposes other than the permitted navigation methods.
- Do not introduce unrelated features that could interfere with examination requirements.
- If a Flutter project already exists, preserve relevant configuration and do not overwrite files unnecessarily.

## 12. Definition of Done

The application is considered complete when:

1. KantinKu runs successfully.
2. All three pages function correctly.
3. Form validation works as required.
4. New menu items are returned to and displayed on the menu list.
5. All required Text nodes use the reusable custom text widget.
6. The widget hierarchies match the original examination diagrams.
7. The project passes the available build and analysis checks, with any environment limitations clearly reported.