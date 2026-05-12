# Submission: Foundations of Physics (Springer Nature)

This branch contains the **Foundations of Physics**-formatted version of the manuscript.

- **Journal**: [Foundations of Physics](https://www.springer.com/journal/10701) (Springer Nature)
- **Class**: `sn-jnl.cls` (committed in repo root)
- **Bibliography**: `sn-mathphys.bst` (math/physics author-year style; committed in repo root)
- **Backup bibliography**: `sn-basic.bst` (committed if you want to switch styles)

## Differences from `main` branch

The canonical pre-print version lives on `main` and uses the standard `article` class with `natbib + apalike`. This branch ports the LaTeX to the Springer Nature template:

| Element | `main` | `submission-foundations` |
|---|---|---|
| Document class | `article` (12pt, a4paper) | `sn-jnl` (`pdflatex,sn-mathphys`) |
| Author block syntax | `\author{Joshua Adams\\\\Independent Researcher\\\\contact@...}` | Springer's structured `\fnm{Joshua} \sur{Adams}` + `\affil*[1]{\orgname{Independent Researcher}}` |
| Abstract | `\begin{abstract} ... \end{abstract}` environment | `\abstract{...}` command |
| Keywords | not present | `\keywords{...}` (Springer expects this) |
| Bibliography style | `apalike` | `sn-mathphys` (Springer house style for math/physics) |
| Section files | `\input` works | `\input` works in our build but Springer **prefers single-file submission** — see "Flatten before submission" below |

## Section files unchanged

The 10 section files in `sections/` are imported via `\input{}` exactly as on `main`. Citations using `\citep{}` and `\citet{}` work because `sn-mathphys.bst` supports the natbib author-year pattern.

## Flatten before submission

Springer Nature's submission guidelines say "do not use `\input{...}` to include other tex files; submit your LaTeX manuscript as one .tex document."

For day-to-day editing in Overleaf, keep `\input{}` for sanity. **Before submission**, generate a flattened single-file version using the included `make-submission.sh` script:

```sh
./make-submission.sh
# produces main-submission.tex with all sections inlined
```

Submit `main-submission.tex` (renamed to whatever you prefer) along with `references.bib`, `figures/`, `sn-jnl.cls`, and `sn-mathphys.bst`.

## Springer-specific things to verify before submitting

- [ ] Recompile in Overleaf to verify clean build (sn-jnl can be picky about package conflicts)
- [ ] Abstract length: Foundations of Physics typically expects ≤ 250 words (we're at ~310; consider trimming or check current journal limit)
- [ ] Keyword count: Springer prefers 4–8; we have 12 — trim to the 6–8 most relevant
- [ ] Section numbering: ensure no double-numbering issues (Springer auto-numbers)
- [ ] Bibliography: verify `sn-mathphys.bst` formatting is acceptable (some entry types may need tweaks)
- [ ] Figures: if any figures are added later, place inline and reference with `\ref{fig:...}` (Springer is strict about this)

## Submission checklist

- [ ] Recompile current branch in Overleaf — clean build
- [ ] Run `make-submission.sh` to flatten
- [ ] Generate fresh PDF from flattened source
- [ ] Submit via Springer's [Editorial Manager](https://www.editorialmanager.com/foop/) for *Foundations of Physics*
- [ ] Cover letter mentions the Zenodo pre-print: `https://doi.org/10.5281/zenodo.20130289`
- [ ] Suggest reviewers (Springer's submission system asks for 3–5)
- [ ] Disclose pre-print status: "This manuscript has been deposited as a pre-print at Zenodo (DOI: 10.5281/zenodo.20130289). The companion physics paper is at DOI: 10.5281/zenodo.20130304."

## After submission

If accepted: update on `main` if any substantive edits are required, re-port to this branch, tag a new release.

If rejected: review feedback, decide whether to revise on `main` and re-submit elsewhere (e.g., create `submission-synthese` from `main`).
