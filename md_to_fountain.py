#!/usr/bin/env python3
"""
Markdown to Fountain Converter for Theater Scripts
Converts Markdown theater scripts to Fountain format.
"""

import re
import sys
import os
from pathlib import Path


class MarkdownToFountainConverter:
    def __init__(self):
        self.fountain_content = []

    def convert_file(self, input_file, output_file=None):
        """Convert a single Markdown file to Fountain format."""
        if not os.path.exists(input_file):
            print(f"Error: File '{input_file}' not found.")
            return False

        with open(input_file, 'r', encoding='utf-8') as f:
            content = f.read()

        fountain_text = self.convert_markdown_to_fountain(content)

        if output_file is None:
            output_file = input_file.replace('.md', '.fountain')

        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(fountain_text)

        print(f"Converted '{input_file}' to '{output_file}'")
        return True

    def convert_markdown_to_fountain(self, markdown_text):
        """Convert Markdown theater script to Fountain format."""
        lines = markdown_text.split('\n')
        fountain_lines = []

        in_stage_directions = False
        in_dialogue = False
        current_character = None

        for line in lines:
            line = line.strip()

            # Skip empty lines but preserve them for formatting
            if not line:
                fountain_lines.append('')
                continue

            # Scene headers (# [Tag X]: [Titel])
            scene_match = re.match(r'^#\s*\[([^\]]+)\]:\s*(.+)', line)
            if scene_match:
                day = scene_match.group(1)
                title = scene_match.group(2)
                fountain_lines.append(f"EXT. THEATER - {day.upper()}")
                fountain_lines.append('')
                fountain_lines.append(f"# {title}")
                fountain_lines.append('')
                continue

            # Section headers (## Charaktere, ## Handlung, etc.)
            if line.startswith('## '):
                section_title = line[3:].strip()
                if section_title.lower() == 'charaktere':
                    fountain_lines.append('CHARACTERS:')
                elif section_title.lower() == 'handlung':
                    fountain_lines.append('FADE IN:')
                elif section_title.lower() == 'regieanweisungen':
                    fountain_lines.append('')
                    fountain_lines.append('PRODUCTION NOTES:')
                fountain_lines.append('')
                continue

            # Character list items (- **CHARAKTERNAME** (description))
            char_match = re.match(r'^-\s*\*\*([A-ZÄÖÜ\s]+)\*\*\s*\((.+)\)', line)
            if char_match:
                char_name = char_match.group(1).strip()
                description = char_match.group(2).strip()
                fountain_lines.append(f"{char_name} - {description}")
                continue

            # Stage directions in italics (*text*)
            if line.startswith('*') and line.endswith('*') and not line.startswith('**'):
                stage_direction = line[1:-1].strip()
                fountain_lines.append(stage_direction.upper())
                fountain_lines.append('')
                continue

            # Character dialogue (**CHARAKTERNAME** *(action)*)
            dialogue_match = re.match(r'^\*\*([A-ZÄÖÜ\s]+)\*\*\s*(\*\([^)]+\)\*)?\s*(.*)', line)
            if dialogue_match:
                character = dialogue_match.group(1).strip()
                action = dialogue_match.group(2)
                dialogue = dialogue_match.group(3).strip()

                fountain_lines.append(character.upper())

                if action:
                    # Remove asterisks and parentheses from action
                    clean_action = action.strip('*()').strip()
                    fountain_lines.append(f"({clean_action})")

                if dialogue:
                    fountain_lines.append(dialogue)

                fountain_lines.append('')
                continue

            # Audience interaction markers
            if '*(Publikum einbeziehen)*' in line:
                fountain_lines.append('(AUDIENCE PARTICIPATION)')
                fountain_lines.append('')
                continue

            # Audience responses *(Publikum: "...")*
            audience_match = re.match(r'^\*\(Publikum:\s*[„""]([^"„""]+)[„""]\)\*', line)
            if audience_match:
                response = audience_match.group(1)
                fountain_lines.append('AUDIENCE')
                fountain_lines.append(response)
                fountain_lines.append('')
                continue

            # Production notes section
            prod_note_match = re.match(r'^-\s*\*\*([^*]+)\*\*:\s*(.+)', line)
            if prod_note_match:
                category = prod_note_match.group(1).strip()
                content = prod_note_match.group(2).strip()
                fountain_lines.append(f"{category.upper()}: {content}")
                continue

            # Horizontal rules (scene breaks)
            if line == '---':
                fountain_lines.append('')
                fountain_lines.append('CUT TO:')
                fountain_lines.append('')
                continue

            # Regular dialogue lines (if they don't match other patterns)
            if not line.startswith('#') and not line.startswith('-'):
                # Check if it's a continuation of dialogue
                if line and not line.startswith('*'):
                    fountain_lines.append(line)
                    continue

            # Default: add the line as-is (for any unmatched content)
            fountain_lines.append(line)

        # Add final fade out
        fountain_lines.append('')
        fountain_lines.append('FADE OUT.')

        return '\n'.join(fountain_lines)

    def convert_directory(self, input_dir, output_dir=None):
        """Convert all .md files in a directory."""
        input_path = Path(input_dir)

        if not input_path.exists():
            print(f"Error: Directory '{input_dir}' not found.")
            return False

        if output_dir is None:
            output_dir = input_path / 'fountain_output'

        output_path = Path(output_dir)
        output_path.mkdir(exist_ok=True)

        md_files = list(input_path.glob('*.md'))

        if not md_files:
            print(f"No .md files found in '{input_dir}'")
            return False

        converted_count = 0
        for md_file in md_files:
            # Skip .meta.md files if desired
            if '.meta.md' in md_file.name:
                print(f"Skipping meta file: {md_file.name}")
                continue

            output_file = output_path / md_file.name.replace('.md', '.fountain')

            if self.convert_file(str(md_file), str(output_file)):
                converted_count += 1

        print(f"Converted {converted_count} files to '{output_dir}'")
        return True


def main():
    """Main function to handle command line arguments."""
    if len(sys.argv) < 2:
        print("Usage:")
        print("  python md_to_fountain.py <input_file.md> [output_file.fountain]")
        print("  python md_to_fountain.py --dir <input_directory> [output_directory]")
        print("")
        print("Examples:")
        print("  python md_to_fountain.py scene1.md")
        print("  python md_to_fountain.py scene1.md scene1.fountain")
        print("  python md_to_fountain.py --dir Szenen")
        print("  python md_to_fountain.py --dir Szenen fountain_scripts")
        return

    converter = MarkdownToFountainConverter()

    if sys.argv[1] == '--dir':
        if len(sys.argv) < 3:
            print("Error: Directory path required after --dir")
            return

        input_dir = sys.argv[2]
        output_dir = sys.argv[3] if len(sys.argv) > 3 else None
        converter.convert_directory(input_dir, output_dir)

    else:
        input_file = sys.argv[1]
        output_file = sys.argv[2] if len(sys.argv) > 2 else None
        converter.convert_file(input_file, output_file)


if __name__ == '__main__':
    main()
