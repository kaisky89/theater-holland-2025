# Pre-Commit Hook Setup für Automatische Fountain-Konvertierung

Dieses Setup ermöglicht es, dass bei jedem Git-Commit automatisch alle Markdown-Theaterskripte ins Fountain-Format konvertiert werden.

## Schnellstart

1. **Hook installieren:**
   ```bash
   chmod +x setup-pre-commit-hook.sh
   ./setup-pre-commit-hook.sh
   ```

2. **Testen:**
   ```bash
   # Erstellen Sie eine Test-Szene
   echo "# [Tag 1]: Test Szene" > Szenen/test.md
   git add Szenen/test.md
   git commit -m "Test der automatischen Konvertierung"
   ```

## Was passiert automatisch?

Wenn Sie eine `.md`-Datei im `Szenen/` Ordner committen:

1. ✅ Der Pre-Commit Hook wird automatisch ausgeführt
2. ✅ Alle gestaging-ten `.md`-Dateien werden zu `.fountain` konvertiert
3. ✅ Die `.fountain`-Dateien werden in `Szenen/fountain/` gespeichert
4. ✅ Die konvertierten Dateien werden automatisch zum Commit hinzugefügt
5. ✅ Der Commit wird erst ausgeführt, wenn alles erfolgreich konvertiert wurde

## Ordnerstruktur nach Installation

```
Ihr-Projekt/
├── Szenen/
│   ├── szene1.md              # Ihre Markdown-Skripte
│   ├── szene2.md
│   └── fountain/              # Automatisch erstellt
│       ├── szene1.fountain    # Automatisch konvertiert
│       └── szene2.fountain
├── md_to_fountain.py          # Konverter-Script
├── pre-commit-hook.sh         # Hook-Script
└── .git/hooks/
    └── pre-commit             # Installierter Hook
```

## Hook-Verhalten im Detail

### Was wird konvertiert:
- ✅ Alle `.md`-Dateien im `Szenen/` Ordner
- ✅ Nur Dateien, die für den Commit vorgemerkt sind (staged)
- ❌ `.meta.md` Dateien werden übersprungen

### Was passiert bei Fehlern:
- ❌ Commit wird abgebrochen
- 📝 Fehlermeldung wird angezeigt
- 🔧 Sie können die Probleme beheben und erneut committen

### Ausgabebeispiel:
```
🎭 Theater Script Pre-Commit Hook
=================================
📝 Found staged Markdown files:
   - Szenen/szene1.md
   - Szenen/szene2.md
🔄 Converting: Szenen/szene1.md
✅ Successfully converted to: Szenen/fountain/szene1.fountain
🔄 Converting: Szenen/szene2.md
✅ Successfully converted to: Szenen/fountain/szene2.fountain

📊 Conversion Summary:
   - Files converted: 2
   - Conversion errors: 0

🎉 All theater scripts successfully converted to Fountain format!
   The converted .fountain files have been staged for commit.

✅ Pre-commit hook completed successfully.
```

## Nützliche Befehle

### Hook temporär deaktivieren:
```bash
git commit --no-verify -m "Commit ohne Hook"
```

### Hook manuell ausführen:
```bash
./.git/hooks/pre-commit
```

### Hook-Status prüfen:
```bash
ls -la .git/hooks/pre-commit
```

### Hook entfernen:
```bash
rm .git/hooks/pre-commit
```

### Hook neu installieren:
```bash
./setup-pre-commit-hook.sh
```

## Fehlerbehebung

### Problem: "Permission denied"
```bash
chmod +x setup-pre-commit-hook.sh
chmod +x pre-commit-hook.sh
```

### Problem: "Python not found"
Der Hook verwendet `python3`. Stellen Sie sicher, dass Python 3 installiert ist:
```bash
python3 --version
```

### Problem: Hook läuft nicht
Prüfen Sie, ob der Hook korrekt installiert und ausführbar ist:
```bash
ls -la .git/hooks/pre-commit
# Sollte -rwxr-xr-x anzeigen (x = ausführbar)
```

### Problem: Konvertierung schlägt fehl
Prüfen Sie manuell:
```bash
python3 md_to_fountain.py Szenen/ihre-datei.md
```

## Workflow-Integration

### Empfohlener Arbeitsablauf:

1. **Szene bearbeiten:**
   ```bash
   # Bearbeiten Sie Ihre .md Datei
   nano Szenen/szene1.md
   ```

2. **Änderungen stagen:**
   ```bash
   git add Szenen/szene1.md
   ```

3. **Committen:**
   ```bash
   git commit -m "Szene 1 aktualisiert"
   # Hook läuft automatisch und konvertiert zu Fountain
   ```

4. **Prüfen:**
   ```bash
   ls Szenen/fountain/
   # Sollte szene1.fountain enthalten
   ```

### Team-Workflow:

- Jeder Entwickler sollte den Hook installieren
- Die `.fountain`-Dateien werden automatisch mit-committed
- Alle haben immer die aktuellsten Fountain-Versionen
- Keine manuellen Konvertierungen mehr nötig

## Anpassungen

### Hook-Verhalten ändern:

Bearbeiten Sie `pre-commit-hook.sh` für:
- Andere Eingabe-/Ausgabeordner
- Zusätzliche Dateiformate
- Andere Konvertierungsoptionen

### Beispiel-Anpassung:
```bash
# In pre-commit-hook.sh, Zeile ~33:
# Für andere Ordner:
STAGED_MD_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '^MeineSkripte/.*\.md$' || true)

# Für andere Ausgabe:
FOUNTAIN_DIR="$PROJECT_ROOT/Ausgabe/fountain"
```

## Support

Bei Problemen:

1. Prüfen Sie die Ausgabe des Hooks
2. Testen Sie die manuelle Konvertierung
3. Überprüfen Sie Dateiberechtigungen
4. Stellen Sie sicher, dass alle Scripts im Projektroot liegen

Der Hook ist darauf ausgelegt, robust und benutzerfreundlich zu sein. Bei ordnungsgemäßer Installation sollte er nahtlos funktionieren.