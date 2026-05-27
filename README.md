# IUT Lean Formalization

This repository is an exploratory Lean 4 formalization project for Shinichi
Mochizuki's inter-universal Teichmuller theory (IUT), with special attention to
the disputed implication around [IUT III, Corollary 3.12]. The goal is not to
assume that IUT is correct or incorrect. The goal is to make the relevant
objects, transports, indeterminacies, and real-valued comparisons explicit enough
that Lean can check whether the claimed implication is valid under stated
hypotheses.

The local `docs/` folder contains Markdown conversions of the four IUT papers,
Mochizuki's April 2026 formalization progress report, and the Scholze-Stix
critique. It is intentionally gitignored as a local paper cache. The tracked
research diary is `FORMALIZATION_NOTES.md`.

## Current Understanding

IUT studies number fields equipped with elliptic curves by constructing
Theta-Hodge theaters: "miniature models" of scheme theory in which the additive
and multiplicative aspects of arithmetic geometry are deliberately separated.
The horizontal Theta-links identify Frobenioid-theoretic multiplicative data
across theaters in a way that is not a ring or scheme morphism. The vertical
log-links, Kummer theory, and anabelian reconstruction machinery are then used to
recover enough information about "alien" arithmetic holomorphic structures to
produce log-volume estimates.

The original four papers were published in PRIMS in 2021. EMS lists IUT IV as
published on 5 March 2021 and tags its central vocabulary with terms such as
non-interference, Kummer-detachment, indeterminacy, q-pilot, Theta-pilot,
multiradial container, holomorphic hull, and species/mutation:
https://ems.press/journals/prims/articles/201528

The final arithmetic output is Theorem A of IUT IV: a class of Diophantine
inequalities from which Vojta for hyperbolic curves, abc, and Szpiro are claimed
to follow. The immediate technical bottleneck is earlier: IUT III, Theorem 3.11
is supposed to provide a multiradial representation for Theta-pilot objects, and
Corollary 3.12 is supposed to turn this into the estimate
`-|log(Theta)| >= -|log(q)|`.

## The Main Dispute

Scholze and Stix isolate the critical issue near IUT III, Corollary 3.12. In
their simplification, the categories of prime strips and realified Frobenioids
become canonically comparable enough that the crucial Theorem 3.11 data becomes
trivial rather than false. Their objection is that, once all copies of the real
line are consistently identified, the `j^2` scaling needed on the Theta side
cannot be inserted without monodromy/inconsistency; omitting those scalars leaves
an empty inequality. Their report is here:
https://www.math.uni-bonn.de/people/scholze/WhyABCisStillaConjecture.pdf

Mochizuki's response, as reflected both in IUT III and the April 2026 report, is
that this simplification erases the essential feature of the proof: the use of
Hodge theaters, log-links, Kummer-detachment, multiradial containers, and
indeterminacies to compare data while not identifying the ring/scheme histories
that must remain separated. In his current formalization plan, the first target
is exactly Stage 1: formalize the implication from IUT III, Theorem 3.11 to
Corollary 3.12, then work backward to the proof of Theorem 3.11 and the
supporting anabelian/Frobenioid/theta-function infrastructure.

That makes the Lean task precise: we need a formal object language in which the
labels, forgotten labels, allowed identifications, indeterminacy actions,
holomorphic hulls, log-volume maps, and real-line comparisons are all explicit.
If the hypotheses are too weak, Lean should expose the gap. If Mochizuki's
claimed "common container" logic is sufficient, Lean should expose the exact
extra structure that makes it sufficient.

## Related Formalization Efforts

Mochizuki's April 2026 progress report describes "LeanForm" primarily as a
communication and disambiguation tool, not only as a verifier. His proposed
stages are:

1. IUT III, Theorem 3.11 implies Corollary 3.12.
2. The proof of IUT III, Theorem 3.11 modulo IUT I-II.
3. IUT I-II modulo earlier anabelian geometry, Frobenioid, and theta-function
   results.
4. The earlier 1995-2015 background corpus.
5. The numerical/log-volume aspects of IUT IV and explicit estimates.

The public slides are available here:
https://aitpm.github.io/slides/Mochizuki.pdf

The LANA project was announced by ZEN Mathematics Center on 31 March 2026.
LANA stands for "Lean for ANAbelian geometry". Its stated aims are to formalize
major theorems of anabelian geometry in Lean, build a corresponding library, and
verify IUT through Lean formalization. ZEN reports that the project has been
underway since autumn 2023, with active operation from September 2024, and that
it intends to stay neutral while distinguishing genuine gaps from current
limitations of understanding. Core members named in the announcement are
Fumiharu Kato, Johan Commelin, Kiran Kedlaya, Yuichiro Hoshi, and Adam Topaz:
https://zen.ac.jp/news/zmcpostevent0331e

ZEN also announced an interim LANA progress report for 17 July 2026. As of this
README's creation on 27 May 2026, that report is still in the future.

Other relevant work includes Taylor Dupuy and Anton Hilado's formal unpacking of
initial theta data, last revised 19 June 2025:
https://arxiv.org/abs/2004.13228

Kirti Joshi has an independent Arithmetic Teichmuller Spaces program claiming a
Rosetta-stone route and a proof of Corollary 3.12; this should be tracked as a
related but separate line rather than imported as an assumption:
https://arxiv.org/abs/2401.13508

## Formalization Strategy

The project should proceed from explicit interfaces toward mathematical content.
For this domain, premature deep definitions are risky: if a Lean structure hides
one of the contested identifications, it can accidentally assume the conclusion.

Initial milestones:

1. Build a vocabulary layer for species, mutations, labeled copies, forgetful
   maps, and full poly-isomorphism-like data.
2. Formalize a small "real line copy" discipline: what it means to compare
   q-side and Theta-side log-volumes, which identifications are used, and which
   diagrams commute.
3. Encode the Stage 1 target as an interface: the hypotheses corresponding to
   "Theorem 3.11.5" plus simultaneous holomorphic expressibility and input
   prime-strip link properties should imply the Corollary 3.12 inequality.
4. Build countermodel tests for weakened hypotheses. These are as important as
   proofs, because they tell us which hidden identifications or indeterminacy
   bounds are mathematically doing work.
5. Expand backward into the first three triangles of Mochizuki's April 2026
   decomposition: descent, algorithmic parallel transport, hull+det, and the
   multiradial representation.
6. Only after the Stage 1 interface is stable, start importing serious Mathlib
   geometry and algebra for elliptic curves, valuations, monoids, Galois actions,
   Frobenioid-like categories, and anabelian reconstruction.

## Lean Layout

This is a Lean 4.30.0 project with Mathlib.

Current modules:

* `Iut.Basic`: root import for the project scaffold.
* `Iut.Foundations.Species`: minimal species/mutation and labeled-copy
  bookkeeping.
* `Iut.Foundations.RealLineCopy`: explicit labeled real-line copies and
  positive-scale transports.
* `Iut.Foundations.TransportDiagram`: coherent parallel transport diagrams and
  the scalar insertion obstruction.
* `Iut.Foundations.IndeterminacyRelation`: region-valued comparison interface
  separating exact equality from indeterminacy membership.
* `Iut.Foundations.RegionMeasure`: abstract monotone real-valued measures for
  log-volume-shaped estimates.
* `Iut.Foundations.CommonTargetBound`: measured common-target packages for
  comparison families, modeling the post-hull upper-bound interface.
* `Iut.Foundations.TransportedRegionFamily`: comparison-family presentation with
  explicit choice-dependent transports and target regions.
* `Iut.Foundations.QualitativeData`: structured inert IPL/SHE/APT data records,
  typed identifiers, and relation records for qualitative bookkeeping.
* `Iut.Foundations.AlgorithmicOutput`: opaque IPL/SHE/APT qualitative-property
  interface for transported algorithmic outputs.
* `Iut.Foundations.AlgorithmicBridge`: explicit bridge schemas from certified
  or structured qualitative output to measured common-target-bound data,
  including named hull+det and HDD composite bridge slots.
* `Iut.Stage1.PilotComparison`: first neutral interface for the Corollary 3.12
  target shape.
* `Iut.Stage1.ToyModel`: Lean tests for Mochizuki's real-valued toy model from
  IUT III, Remark 3.12.2.
* `Iut.Stage1.ToyMeasuredComparison`: measured upper-ray version of the toy
  model, keeping containment, calibration, and arithmetic bounds separate.
* `Iut.Stage1.ToyFamilyBounds`: toy indexed families of upper-ray comparisons
  controlled by an explicit common epsilon bound.
* `Iut.Stage1.ToyAPTTransport`: toy APT-style transported output data before
  passage to common targets and measured bounds.
* `Iut.Stage1.ToyQualitativeOutput`: toy algorithmic output with structured
  inert IPL/SHE/APT certificates plus separate common-target bound data.
* `Iut.Stage1.ToyBridge`: toy bridge from qualitative certification to
  common-target bounds via the epsilon-cap construction, with an inert named
  descent, hull+det, and HDD composite.
* `Iut.Stage1.CorollarySchema`: signed-real schema for producing the
  Corollary-3.12-shaped pilot inequality from bridge output.
* `Iut.Stage1.ToyCorollarySchema`: toy specialization deriving the signed
  inequality from membership in a chosen upper-ray output.
* `Iut.Stage1.SourceObligations`: source-obligation ledger for the structured
  Stage 1 final comparison, now requiring a named HDD composite bridge.
* `Iut.Stage1.ToySourceObligations`: toy completion of that ledger using
  upper-ray normalization and epsilon-cap bounds.

Useful commands:

```bash
lake build
lake exe cache get
```

## Apodeixis

The sibling repository `../Apodeixis` is a Rust-based collaboration and
continuous-verification platform for formal mathematics. Its current Lean path
expects repositories to build with commands such as `lake build`, and its longer
term runtime design supports Lean goal-state and tactic operations through a
process-adapter backend. This repository should stay conventional as a Lake
project so it can later be ingested by Apodeixis without custom handling.
