# Markdown zu PDF Konverter

Dieses Projekt verwendet ab sofort eine direkte Konvertierung von Markdown-Theaterskripten ins PDF-Format – ganz ohne Zwischenschritt über Fountain oder screenplain.

## Installation

Für die PDF-Konvertierung wird das Tool [`mdpdf`](https://github.com/BlueHatbRit/mdpdf) benötigt.  
Installiere es global mit:

```bash
npm install -g mdpdf
```

## Verwendung

### Einzelne Datei konvertieren

```bash
mdpdf "Szenen/01 BA 01 - Gott ist staerker als der Zufall.md" -o "Szenen/pdf/01 BA 01 - Gott ist staerker als der Zufall.pdf"
```

### Ganzen Ordner konvertieren (Beispiel mit Bash-Schleife)

```bash
mkdir -p Szenen/pdf
for file in Szenen/*.md; do
  [ "${file##*.}" = "md" ] && [[ "$file" != *.meta.md ]] && \
    mdpdf "$file" -o "Szenen/pdf/$(basename "${file%.md}.pdf")"
done
```

## Automatische Konvertierung beim Commit

Ein Pre-Commit-Hook sorgt dafür, dass alle geänderten Markdown-Dateien im Ordner `Szenen/` (außer `.meta.md`) automatisch ins PDF-Format konvertiert werden.  
Die PDFs landen im Ordner `Szenen/pdf/` und werden direkt mit ins Commit aufgenommen.

**Beispiel für den Ablauf:**
1. Du bearbeitest ein Skript, z.B. `Szenen/03 GoDi 01 - Jesus ist staerker als Krankheit.md`
2. Du fügst es zum Commit hinzu:  
   `git add Szenen/03\ GoDi\ 01\ -\ Jesus\ ist\ staerker\ als\ Krankheit.md`
3. Beim Commit (`git commit ...`) wird automatisch  
   `mdpdf` aufgerufen und erzeugt  
   `Szenen/pdf/03 GoDi 01 - Jesus ist staerker als Krankheit.pdf`
4. Die PDF wird automatisch mit ins Commit aufgenommen.

## Formatierungsregeln

Die Markdown-Dateien folgen weiterhin dem theater-spezifischen Format (siehe `AGENTS.md`).  
**Wichtig:** Die Formatierung in der PDF entspricht dem Standard-Output von mdpdf.  
Für spezielle Layout-Wünsche siehe die [mdpdf Dokumentation](https://github.com/BlueHatbRit/mdpdf#options).

## Besonderheiten

- `.meta.md` Dateien werden übersprungen
- Die PDFs werden immer im Ordner `Szenen/pdf/` abgelegt
- Die Dateinamen bleiben identisch (nur `.pdf` statt `.md`)
- Es gibt keinen Fountain- oder screenplain-Schritt mehr

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

**Ausgabe (PDF):**  
Die PDF enthält den formatierten Markdown-Inhalt, wie von mdpdf erzeugt.

---

## Vorteile

- **Schneller Workflow:** Keine Zwischenschritte, keine Zusatzformate
- **Einfache Installation:** Nur ein Tool (`mdpdf`) notwendig
- **Automatisiert:** PDFs werden immer aktuell gehalten und mitversioniert

---

## Hinweise

- Für individuelle PDF-Layouts kann eine eigene CSS-Datei an mdpdf übergeben werden (siehe mdpdf-Doku).
- Bei Problemen prüfe, ob mdpdf korrekt installiert ist (`mdpdf --version`).

---

**Letzte Änderung:** Umstellung auf direkten Markdown→PDF-Workflow, Stand Juni 2024.