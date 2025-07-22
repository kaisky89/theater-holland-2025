# Markdown zu Fountain Konverter

Dieses Python-Script konvertiert Ihre Markdown-Theaterskripte ins Fountain-Format, welches ein Standard für Drehbücher ist.

## Installation

Keine zusätzlichen Abhängigkeiten erforderlich. Das Script verwendet nur Python Standard-Bibliotheken.

## Verwendung

### Einzelne Datei konvertieren

```bash
python md_to_fountain.py szene1.md
```

Mit spezifischem Ausgabedateinamen:
```bash
python md_to_fountain.py szene1.md szene1.fountain
```

### Ganzen Ordner konvertieren

```bash
python md_to_fountain.py --dir Szenen
```

Mit spezifischem Ausgabeordner:
```bash
python md_to_fountain.py --dir Szenen fountain_ausgabe
```

## Konvertierungsregeln

Das Script konvertiert Ihre Markdown-Formatierung folgendermaßen:

### Szenenüberschriften
```markdown
# [Tag X]: [Titel der Szene]
```
→ 
```fountain
EXT. THEATER - TAG X

# Titel der Szene
```

### Charaktere
```markdown
## Charaktere
- **CHARAKTERNAME** (Beschreibung/Rolle)
```
→
```fountain
CHARACTERS:
CHARAKTERNAME - Beschreibung/Rolle
```

### Dialoge
```markdown
**CHARAKTERNAME** *(Regieanweisung)*  
Dialog text...
```
→
```fountain
CHARAKTERNAME
(Regieanweisung)
Dialog text...
```

### Regieanweisungen
```markdown
*Regieanweisung für Bühnenbild und Situation*
```
→
```fountain
REGIEANWEISUNG FÜR BÜHNENBILD UND SITUATION
```

### Publikumsinteraktion
```markdown
*(Publikum einbeziehen)*  
Frage an das Publikum...  
*(Publikum: „Antwort!")*
```
→
```fountain
(AUDIENCE PARTICIPATION)
Frage an das Publikum...

AUDIENCE
Antwort!
```

### Produktionsnotizen
```markdown
## Regieanweisungen
- **Bühnenbild:** Beschreibung
- **Soundeffekte:** Liste der Effekte
```
→
```fountain
PRODUCTION NOTES:
BÜHNENBILD: Beschreibung
SOUNDEFFEKTE: Liste der Effekte
```

### Szenenübergänge
```markdown
---
```
→
```fountain
CUT TO:
```

## Besonderheiten

- `.meta.md` Dateien werden beim Ordner-Konvertieren übersprungen
- Das Script behält die deutsche Sprache bei und übersetzt nur die Strukturelemente
- Leere Zeilen werden für bessere Formatierung beibehalten
- Automatisches Hinzufügen von `FADE IN:` am Anfang und `FADE OUT.` am Ende

## Ausgabeformat

Die konvertierten Dateien erhalten die Endung `.fountain` und können mit jedem Fountain-kompatiblen Editor oder Programm geöffnet werden, wie z.B.:
- WriterDuet
- Highland
- Slugline
- Fountain Mode für verschiedene Texteditoren

## Beispiel

**Eingabe (Markdown):**
```markdown
# [Tag 1]: Der magische Wald

## Charaktere
- **ZAUBERER** (Hauptcharakter)
- **KINDER** (Publikum)

## Handlung

*Der Vorhang öffnet sich auf einen dunklen Wald*

**ZAUBERER** *(tritt aus den Schatten)*  
Willkommen, liebe Kinder!

*(Publikum einbeziehen)*  
Könnt ihr mir helfen?  
*(Publikum: „Ja!")*
```

**Ausgabe (Fountain):**
```fountain
EXT. THEATER - TAG 1

# Der magische Wald

CHARACTERS:
ZAUBERER - Hauptcharakter
KINDER - Publikum

FADE IN:

DER VORHANG ÖFFNET SICH AUF EINEN DUNKLEN WALD

ZAUBERER
(tritt aus den Schatten)
Willkommen, liebe Kinder!

(AUDIENCE PARTICIPATION)
Könnt ihr mir helfen?

AUDIENCE
Ja!

FADE OUT.
```
