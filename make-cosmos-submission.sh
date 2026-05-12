#!/usr/bin/env bash
# Convert main.tex (with \input{sections/*}) plus references.bib into a
# Microsoft Word document suitable for submission to Cosmos and History.
# Citations are converted from natbib's parenthetical \citep{}/\citet{}
# style to Chicago footnote style (matching the journal's house style:
# AGPS / Oxford System with footnotes).
#
# Usage: ./make-cosmos-submission.sh
# Output: pub2-cosmos-and-history.docx
#
# Prerequisites: pandoc (brew install pandoc).

set -euo pipefail

cd "$(dirname "$0")"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "ERROR: pandoc not installed. Install with: brew install pandoc"
  exit 1
fi

# Step 1: Flatten main.tex by inlining \input{sections/*.tex} so pandoc
# sees a single self-contained document.
TMPTEX="$(mktemp -t cosmos-submission-XXXXXX.tex)"
trap 'rm -f "$TMPTEX"' EXIT

while IFS= read -r line; do
  if [[ "$line" =~ ^[[:space:]]*\\input\{sections/([^}]+)\}[[:space:]]*$ ]]; then
    section_name="${BASH_REMATCH[1]}"
    section_path="sections/${section_name}"
    if [[ ! -f "$section_path" && -f "${section_path}.tex" ]]; then
      section_path="${section_path}.tex"
    fi
    if [[ -f "$section_path" ]]; then
      cat "$section_path" >> "$TMPTEX"
      echo "" >> "$TMPTEX"
    else
      echo "WARNING: section file not found for: $line" >&2
      echo "$line" >> "$TMPTEX"
    fi
  else
    echo "$line" >> "$TMPTEX"
  fi
done < main.tex

# Step 2: Convert flattened LaTeX to Word, with footnote citations.
# --citeproc: process \cite commands using references.bib
# --csl=chicago-fullnote-bibliography.csl: footnote-style citations
#   matching Cosmos and History's "AGPS / Oxford" footnote style
#
# Pandoc's built-in CSL is Chicago author-date by default; we need to
# specify a footnote CSL. Try Chicago Manual of Style 17 (full note
# bibliography), which most closely matches the journal's preference.

OUTPUT="pub2-cosmos-and-history.docx"

# Citeproc requires a CSL file. We use chicago-fullnote-bibliography
# as the closest match to Cosmos and History's house style.
# CSL fetched from the official CSL repository if not already local.
CSL_FILE="chicago-fullnote-bibliography.csl"
if [[ ! -f "$CSL_FILE" ]]; then
  echo "Fetching Chicago full-note bibliography CSL..."
  curl -fsSL "https://raw.githubusercontent.com/citation-style-language/styles-distribution/master/chicago-fullnote-bibliography.csl" -o "$CSL_FILE"
fi

pandoc "$TMPTEX" \
  --from=latex \
  --to=docx \
  --bibliography=references.bib \
  --citeproc \
  --csl="$CSL_FILE" \
  --output="$OUTPUT" \
  --metadata title="Three Paths to One Structure: Quantum Mechanics, Process Philosophy, and the Bahá'í Metaphysics of Relational Reality" \
  --metadata author="Joshua Adams" \
  --resource-path=".:sections:figures" \
  2>&1 | head -30

echo ""
echo "Wrote $OUTPUT"
echo ""
WORD_COUNT=$(pandoc "$OUTPUT" --to=plain 2>/dev/null | wc -w | tr -d ' ')
echo "Approximate word count (post-citation expansion): $WORD_COUNT words"
echo ""
echo "Cosmos and History 'typical' range: 4,000-8,000 words"
echo "Note: there is no strict limit, but the paper is significantly over"
echo "typical range. Consider whether trimming is feasible, or query the editor"
echo "before submission about acceptable length."
