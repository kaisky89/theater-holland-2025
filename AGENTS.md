# Projekt Übersicht

In diesem Projekt wird ein Drehbuch für eine Serie von Theater Szenen erstellt, die begleitend zu einer Kinderfreizeit aufgeführt werden.

## Zielgruppe

Die Zuschauer sind Kinder im Alter von 8 bis 12 Jahren. Die Theaterstücke sind Teil einer christlichen Kinderfreizeit, die in den Sommerferien stattfindet. Die Kinder sollen durch die Stücke unterhalten und gleichzeitig christliche Werte vermittelt bekommen.

## Inhaltlicher Rahmen

Das Motiv für die Freizeit ist "Die Unglaublichen, Abenteuer im Dschungel". Es ist eine Mischung aus den Motiven "Superhelden" und "Dschungel". Außerdem wird im Verlauf der Freizeit während der Bibelarbeiten vor allem auf das Thema "Jesus ist stärker" eingegangen. Die Themen sind:
- "Jesus ist stärker als der Zufall"
- "Der Start von Jesus"
- "Jesus ist stärker als Krankheit"
- "Jesus ist stärker als die Natur"
- "Jesus ist stärker als die Ansprüche der Welt"
- "Jesus ist stärker als deine Sorgen"
- "Jesus ist stärker als deine Schuld"
- "Jesus ist stärker als der Tod"
- "Jesus ist stärker als dein Alleinsein"

Die Theaterstücke sollen die Kinder unterhalten und gleichzeitig die oben genannten Themen aufgreifen. Die Stücke sind so gestaltet, dass sie in einem Zeitraum von 5 Minuten bis 15 Minuten aufgeführt werden können. Die Kinder sollen aktiv in die Stücke eingebunden werden (siehe *Interaktive Elemente*).

## Gestalterischer Rahmen

Die Theaterstücke sollen eine Geschichte erzählen, die sich über die gesamte Freizeit erstreckt. Die Handlung soll spannend und unterhaltsam sein, aber auch die christlichen Werte und Themen aufgreifen.

- Für den Zeitplan, siehe `Zeitplan.md`
- Für die Bibelarbeiten, siehe `Bibelarbeiten.md`
- Für den aktuellen Entwicklungsstand, siehe `Drehbuch-Entwicklungsplan.md`

## Haupthandlung

### Plot: "Das Tor der wahren Stärke"

**Setup:**
Jugendliche werden ins Spiel gesogen, bekommen Superkräfte. Ein mysteriöser Wächter erklärt: "Um nach Hause zu kommen, müsst ihr das Tor der wahren Stärke finden."

**Struktur:**
- **Dschungel-Reise:** Verschiedene Prüfungen bereiten auf das Tor vor
- **Tor-Finale:** Sie müssen beweisen, was sie auf der Reise gelernt haben. Es stellt sich heraus, dass Samuel der einzige ist, der das Tor öffnen kann.

**Mysteriöse Elemente:**
- Rätsel mit Bibelvers-Bezug an jedem Ort
- Botschaften des Wächters in der Natur

**Finale Erkenntnis:**
Wahre Stärke kommt von Gott und Gemeinschaft, nicht von Superkräften.

**Charakterentwicklung:**
Die Protagonisten bekommen durch das Eingesogen-werden spezielle individuelle Fähigkeiten. Sie lernen aber während der Geschichte, dass sie auch auf die speziellen Fähigkeiten der anderen angewiesen sind, und dass die größte Superkraft das Vertrauen in Gott ist.

## Charaktere

Die wichtigsten Charaktere sind:
- **Maya** - Die Anführerin
- **Karl** - Der Technik-Experte
- **Aria** - Die Pfadfinderin und Heilerin
- **Diego** - Der Beschützer
- **Samuel** - Der mysteriöse Wächter und Mentor

Für eine ausführliche Beschreibung der Charaktere, siehe `Charaktere.md`

## Wichtige Gegenstände

- **Der Kartenwürfel:** Eine Zauberwürfel (RubicsCube), der statt Farben eine Karte auf den Flächen hat, die die Protagonisten durch den Dschungel führt. Er enthält Rätsel und Hinweise, die gelöst werden müssen, um das Tor der wahren Stärke zu finden. Außerdem kann die Gruppe den Würfel nutzen, um Samuel zu rufen, wenn sie in Not sind. Dafür müssen sie den Würfel allerdings in eine Stellung bringen, wo alle Seiten des Würfels wieder durcheinander sind und damit die Karte nicht mehr lesbar ist.

## Interaktive Elemente

Die Theaterstücke sind so gestaltet, dass sie interaktive Elemente enthalten, die das Publikum aktiv einbeziehen. Das passiert meistens, indem der Techniker, der bei der Einsaugung der Kinder dabei war, die Szene per Fernbedinung "pausiert" (alle Protagonisten frieren ein) und dann das Publikum mit einbezieht. Das Publikum kann dann beispielsweise Fragen beantworten, Entscheidungen treffen oder kleine Rätsel lösen.

## Entwicklungsstand

**Aktueller Status:** 🟡 Phase 1 - Story-Mapping (In Vorbereitung)

Der detaillierte Entwicklungsplan mit Checklisten und Zeitplanung befindet sich in `Drehbuch-Entwicklungsplan.md`.

# Projektstruktur

## Format der Drehbücher

Die Theaterstücke werden im **Markdown-Format (`.md`)** geschrieben. Sie liegen im Ordner `Szenen`.

Neben den finalen Szenen werden auch .meta.md Dateien erstellt, die alle groben Planungen, Ideen und Notizen enthalten. Diese Dateien dienen als Arbeitsgrundlage und werden später in die finalen Szenen umgewandelt.

### Struktur einer Szene

Jedes Szene folgt dieser Grundstruktur:

```markdown
# [Tag X]: [Titel der Szene]

## Charaktere

- **CHARAKTERNAME** (Beschreibung/Rolle)
- **KINDER** (Publikum/Mitspieler)

## Handlung

*Regieanweisung für Bühnenbild und Situation*

**CHARAKTERNAME** *(Regieanweisung)*  
Dialog text...

**CHARAKTERNAME** *(zum Publikum)*  
Interaktiver Dialog...

*(Publikum einbeziehen)*  
Frage an das Publikum...  
*(Publikum: „Antwort!")*

---

## Regieanweisungen

- **Bühnenbild:** Beschreibung

- **Soundeffekte:** Liste der Effekte

- **Licht:** Lichteffekte und -wechsel

- **Publikumsinteraktion:** Beschreibung der Interaktionen

- **Requisiten:** Benötigte Gegenstände
```

## Formatierungsregeln

- **Charakternamen** werden fett geschrieben: `**NAME**`
- *Regieanweisungen* werden kursiv und in Klammern geschrieben
- **Zwei Leerzeichen am Ende jeder Dialogzeile** für korrekte Zeilenumbrüche in GitHub
- Szenenüberschriften als Unterüberschriften (`###`) formatieren
- Horizontale Trennlinien (`---`) zwischen Szenen verwenden
- Publikumsinteraktionen werden mit `*(Publikum einbeziehen)*` markiert
- Regieanweisungen am Ende mit **Fettschrift** für Kategorien strukturieren
- Leere Zeilen für bessere Lesbarkeit verwenden
