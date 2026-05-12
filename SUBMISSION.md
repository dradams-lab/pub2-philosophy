# Submission: Cosmos and History

This branch contains the **Cosmos and History**-formatted version of the manuscript.

- **Journal**: [Cosmos and History: The Journal of Natural and Social Philosophy](https://cosmosandhistory.org)
- **Open Access status**: **Diamond OA** — no Article Processing Charge for authors, free for readers
- **License**: Author retains copyright; first publication rights granted to journal
- **Submission format**: Microsoft Word preferred (other formats acceptable)
- **Citation style**: Footnotes, AGPS / Oxford System (we use Chicago full-note as the closest pandoc-compatible CSL)
- **Typical word count**: 4,000–8,000 words (no strict limit)

## Why this journal

After reviewing Diamond OA options for pub2's content (philosophy of physics + process philosophy + science-religion), Cosmos and History is the strongest fit because:

1. **Truly open access** — no APC, no paywall, free for any reader
2. **Interdisciplinary scope** — explicitly publishes work bridging philosophy, science, history, religion
3. **Welcomes process philosophy** — Whitehead-related work has a publication record there
4. **Simple submission process** — Word document, no LaTeX template required

Alternative Diamond OA targets considered and not selected:
- **Open Theology** (De Gruyter) — has €1200 APC for general issues; not Diamond OA
- **AGATHEOS / European Journal for Philosophy of Religion** — Diamond OA but philosophy-of-physics fit uncertain
- **Ergo** — Diamond OA but mostly analytic philosophy; weak fit for science-religion bridge content

## Differences from `main` branch

The canonical pre-print version on `main` is a 13,200-word LaTeX article with parenthetical natbib citations. This branch produces a Word document with footnote citations.

| Element | `main` | `submission-cosmos-and-history` |
|---|---|---|
| Output format | PDF (from LaTeX) | DOCX (Word) |
| Build path | `pdflatex main.tex` | `./make-cosmos-submission.sh` |
| Citation style | Parenthetical (natbib `\citep{}`) | Footnote (Chicago full-note via pandoc/CSL) |
| Bibliography | `references.bib` rendered by `apalike` | Same `references.bib` consumed by pandoc + CSL |
| Source files | `main.tex` + 10 `sections/*.tex` | Same source — converted at build time |

The source files in `sections/` are unchanged. The conversion happens at submission time via `make-cosmos-submission.sh`.

## Build

```sh
./make-cosmos-submission.sh
# produces pub2-cosmos-and-history.docx
```

The script:
1. Flattens main.tex by inlining all `\input{sections/*.tex}` into a single tempfile
2. Calls pandoc to convert LaTeX → DOCX
3. Uses the Chicago full-note CSL for footnote citations
4. Reads `references.bib` for bibliography
5. Writes the Word document and reports word count

The script auto-downloads `chicago-fullnote-bibliography.csl` on first run.

## Word count caveat (IMPORTANT)

Latest build: **~14,500 words** (Word doc, post-citation expansion).

Cosmos and History's "typical" range is 4,000–8,000 words. The paper is significantly over.

Three options:

1. **Submit as-is and let the editor judge** — they say "no strict limitations." For a substantive interdisciplinary argument, the editor may accept a longer paper.
2. **Trim to 8,000 words** — would require cutting roughly a third of the paper. The defensive scaffolding (objections-and-replies in §2, the methodological clarifications in §1, the §6 functional-role argument) could be trimmed if you accept reduced robustness against reviewer pushback.
3. **Query the editor first** — email the journal editor with the paper's abstract and ask whether 13,200 words is acceptable.

I'd recommend (3) as the safest path before investing in either (1) or (2).

## Caveats and unknowns

- **The Chicago full-note CSL is a close approximation, not an exact match** to the journal's "AGPS / Oxford" house style. The journal accepts that "minimal formatting" is fine since they reformat in production.
- **Equations/math**: pandoc's LaTeX → DOCX conversion handles inline math reasonably; complex display math may render imperfectly. Inspect the docx in Word and fix any math display issues by hand.
- **Tables**: Pandoc handles `tabularx` adequately for simple tables. The chronology table in §1 may need formatting touch-up in Word.
- **Bahá'í typesetting macros (\bahai, \AbdulBaha, \Bahaullah)** render correctly in pandoc output (verified in the build) — `‘Abdu'l-Bahá` and `Bahá'í` come through with proper directional quotes.

## Submission process

1. **Recompile and verify**: open `pub2-cosmos-and-history.docx` in Word (or LibreOffice). Inspect:
   - Footnote citations render correctly
   - Math displays cleanly
   - Tables and figures look right
   - Bibliography appears at the end
2. **Hand-edit if needed**: any pandoc artifacts can be fixed directly in Word
3. **Register on the journal site**: [https://cosmosandhistory.org](https://cosmosandhistory.org)
4. **Submit via their online form**:
   - Title page with author info (Dr. Joshua Adams, Independent Researcher, contact@joshuaadams.dev)
   - Anonymized manuscript (Cosmos and History uses double-blind review — strip author info from the Word doc)
   - Cover letter mentioning the Zenodo pre-print: `https://doi.org/10.5281/zenodo.20130289`
5. **Estimated review timeline**: ~3 months

## Related branches

- `main` — canonical pre-print version (Zenodo)
- `submission-foundations` — Foundations of Physics (Springer) version, kept as backup. Use if Cosmos and History rejects.
- `submission-cosmos-and-history` — this branch
