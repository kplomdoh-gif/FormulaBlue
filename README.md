# Formula Flow

An independent Flutter app for exploring school formulas, practicing questions,
and tracking a local practice session. It runs on the web, Android, and Windows.

## Run a preview

From PowerShell:

```powershell
Set-Location 'C:\Users\Hannah KPLOMDO\OneDrive\Apps\FormulaBlue'
..\flutter\bin\flutter.bat run -d chrome
```

In Chrome, changes to the Dart code can be checked with Flutter hot reload.

## Run tests and build

```powershell
..\flutter\bin\flutter.bat test
..\flutter\bin\flutter.bat build web
```

The web build is written to `build\web`. Upload the contents of that folder to a
static web host to share the app by link.

Other supported builds:

```powershell
..\flutter\bin\flutter.bat build apk
..\flutter\bin\flutter.bat build windows
```

Sign-up and sign-in create a temporary local student profile only. They do not
authenticate against a server or store passwords, and the profile and practice
progress reset when the app restarts.

The app includes Mathematics, Physics, Chemistry, Economics, Algebra, and
Geometry formulas, with 50 additional catalog entries for each subject. Select
a formula to see its explanation, tap variable chips for definitions, then try
the guided question. Games include Practice, Formula Match, Variable Match,
and Quick Recall. The Exam screen offers ten untimed subject questions followed
by an answer review. Flashcards use active recall and self-rating. Progress
summarizes formula reviews, games, and points. Settings contains the student
profile and a light/dark blue theme switch.

Further reading requested for this app:

- [Mathematics formulas](https://sengsopheasith.wordpress.com/wp-content/uploads/2013/09/1300_math_formulas.pdf)
- [Physics formula handbook](https://emseo.extramarks.com/wp-content/uploads/2022/06/Physics_Formula_Handbook_Final-2.pdf)
- The IGCSE economics formula sheet was supplied as a local PDF and is not
  included in this repository.
