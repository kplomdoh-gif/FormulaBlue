# FormulaFlow

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

Practice progress and saved formulas currently live only in memory and reset
when the app restarts. The app does not yet include accounts or cloud storage.
