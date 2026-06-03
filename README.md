# 📝 TODO List App (Flutter)

A simple and interactive TODO List application developed during Week 2 of my internship. This project demonstrates basic CRUD operations, dynamic UI updates, and state management in Flutter.

---

## 🎯 Project Overview

This application allows users to add, manage, and complete daily tasks. Users can input tasks through a TextField, view them in a list, mark them as completed, and delete them when no longer needed.

The app also properly handles empty states when no tasks are available.

---

## 🚀 Features

* Add new tasks using TextField
* Display tasks in a dynamic list
* Mark tasks as completed
* Strike-through effect for completed tasks
* Delete tasks from the list
* Empty state message when no tasks exist
* Clean and minimal UI design

---

## 📸 Screenshots

### 🏠 Empty Home Page

<img src="screenshots/No Tasks Screen.jpeg" width="250"/>

> Shows "No tasks to display" when the task list is empty.

---

### 📝 Tasks Added (Unchecked)

<img src="screenshots/Tasks Added HomePage.jpeg" width="250"/>

> Displays tasks added by the user without completion status.

---

### ✅ Tasks Completed

<img src="screenshots/Tasks Checked HomePage.jpeg" width="250"/>

> Shows completed tasks with strike-through text decoration.

---

## 🛠️ Tech Stack

* Flutter
* Dart
* Material Design

---

## ⚙️ Functional Flow

1. User opens the app
2. If no tasks exist → empty state message is shown
3. User enters task in TextField
4. Task is added to list dynamically
5. User can mark task as completed
6. Completed tasks show strike-through effect
7. User can delete tasks from list

---

## 🧠 Key Concepts Used

* Stateful Widgets
* setState() for UI updates
* Dynamic List handling
* TextField input handling
* Conditional UI rendering
* Basic CRUD operations
* Flutter ListView

---

## 📂 Project Structure

```text id="struct002"
lib/
├── main.dart
├── screens/
│   └── home_page.dart
└── utils/
    └── app_colors.dart
```

---

## 📱 How to Run

Clone the repository:

```bash id="run001"
git clone https://github.com/umarjawad123/flutter-todo-list-app.git
```

Navigate to project folder:

```bash id="run002"
cd flutter-todo-list-app
```

Install dependencies:

```bash id="run003"
flutter pub get
```

Run the app:

```bash id="run004"
flutter run
```

---

## 🎯 Future Improvements

* Add local storage (SharedPreferences or SQLite)
* Add task categories
* Add due dates and reminders
* Add task priority levels
* Improve UI with animations
* Dark mode support

---

## 👨‍💻 Author

**Umar Jawad**
Flutter Developer | BSCS Student
