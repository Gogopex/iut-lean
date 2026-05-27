# Stage 1 Review Checkpoint

Date: 2026-05-27

This review marks the transition from endpoint/interface infrastructure toward
the first genuinely mathematical part of the IUT formalization.

Future milestones for the mathematical phase should be recorded in
`MATH_FORMALIZATION_NOTES.md`. The older `FORMALIZATION_NOTES.md` remains the
diary for the infrastructure phase.

## Current Boundary

The Lean development currently verifies a source-to-endpoint audit route for
the local Stage 1 problem:

```text
structured Theorem 3.11 inputs
+ side-condition hypotheses
-> source obligations
-> source audit
-> comparison payload inputs
-> comparison data
-> ComparisonDataEndpoint
-> StructuredEndpointAuditSummary
```

The strongest current source-facing object is:

```lean
package.structuredEndpointAuditSummary inputs hypotheses
```

It packages one coherent source audit witness and exposes:

```lean
summary.endpointPublicAuditEq
summary.payloadDataEqComparisonData
summary.comparisonDataEqPackage
summary.comparisonDataRecovers
```

The last infrastructure milestone proves that this summary is not a second route:
its source audit and payload route summary are tied back to
`structuredHypothesisRouteAudit`.

## What This Proves

The current code proves routing and audit coherence. In particular:

* the public comparison endpoint agrees with the package public audit;
* the comparison endpoint can recover the source audit payload route;
* the structured-hypothesis endpoint specializes the ordinary endpoint route;
* the compact structured endpoint summary uses one source audit witness;
* the compact summary is coherent with the structured route audit.

This is useful because it prevents endpoint drift. A later proof cannot silently
replace the source route while keeping the same public-looking Corollary
3.12-shaped endpoint.

## What This Does Not Prove

The current code does not prove the hard IUT mathematics.

The following fields are still opaque or inert at the mathematical level:

```lean
IUTStage1Theorem311StructuredInputs.hasStructuredIPL
IUTStage1Theorem311StructuredInputs.hasStructuredSHE
IUTStage1Theorem311StructuredInputs.hasStructuredAPT
IUTStage1Theorem311StructuredInputs.algorithmOutputCertified
IUTStage1Theorem311StructuredInputs.hodgeTheaterSHEAlignment
```

The foundational qualitative records currently give names to IPL, SHE, and APT,
but they intentionally do not imply common-container comparison data, real-line
identifications, log-volume bounds, or Corollary 3.12. This was a deliberate
guardrail: an inert name such as `HasStructuredSHE` must not become a hidden
axiom for the disputed endpoint.

## Source Alignment

The local IUT III text, especially Remark 3.11.1, describes Theorem 3.11 as an
algorithm producing output data up to indeterminacies, with central roles for:

* IPL: linking output prime-strip data to the input q-pilot prime strip;
* SHE: simultaneous validity in the domain and codomain arithmetic holomorphic
  structures;
* APT: a construction algorithm rather than simple set-theoretic transport;
* HIS: the option to forget internal theta-function structure and reason about
  qualitative output data.

Mochizuki's 2026 formalization report isolates the final portion of
`3.11 -> 3.12` as `3.11.5 -> 3.12`, focused on simultaneous comparison in a
single common-container setting, and says the second/third triangles concern
APT plus IPL. That matches our current position: the endpoint route is ready,
but the mathematical force of IPL/SHE/APT is not.

Scholze-Stix's critique remains the opposing diagnostic constraint: any move
from structured source data to a real-valued comparison must not hide the
identification of real-line copies or erase the history of the Hodge-theater
objects being compared.

## Transition Point

We are now leaving infrastructure.

The next Lean milestone should not be another endpoint wrapper unless it
supports the mathematical content directly. The next target should define the
first non-inert version of one core Theorem 3.11 ingredient.

The recommended first target is SHE, not APT or full IPL.

Reasons:

* SHE is already present in the route as the equality between the common
  container's SHE arrow datum and the structured certificate's SHE datum.
* Mochizuki's report identifies `(HDD) o (SHE)` as the Stage 1 final comparison
  focus.
* SHE can be strengthened locally without claiming the whole multiradial
  algorithm.
* It directly tests the disputed issue: simultaneous expression without hidden
  collapse of Hodge-theater histories.

## Proposed SHE Target

The first mathematical structure should be a source-facing record, tentatively:

```lean
StructuredSHEContext
```

It should contain, at minimum:

* a domain Hodge-theater/arithmetic-holomorphic context;
* a codomain Hodge-theater/arithmetic-holomorphic context;
* a shared expression or common-language context;
* q-pilot-side datum in the codomain context;
* Theta/HDD-side datum in the domain or HDD context;
* an explicit relation saying the relevant construction is valid relative to
  both contexts;
* an explicit statement of what is not being identified.

It should not directly imply `ComparisonDataEndpoint`.

The first bridge theorem should be modest: from this stronger SHE context,
recover the current inert `HasStructuredSHE` and the existing SHE alignment
field. Only later should we ask whether it contributes to payload construction.

## Review Questions Before Coding

Before implementing `StructuredSHEContext`, decide:

1. What are the Lean types for "arithmetic holomorphic structure" at this layer?
2. Are Hodge-theater histories represented only by labels, or by typed records
   carrying allowed maps?
3. What does "simultaneously valid/executable/well-defined" mean as a Lean
   proposition?
4. Which equality is legitimate at the SHE layer, and which comparisons must
   remain relations or transport data?
5. How do we state "not a ring/scheme-history identification" in a useful Lean
   form?

## Proposed Next Phase

Phase 2 should proceed in small milestones:

1. Add a non-inert `StructuredSHEContext` record.
2. Prove it projects to the existing inert `SHEDatum`.
3. Connect it to the current `hodgeTheaterSHEAlignment` field.
4. Add a toy example that satisfies the stronger SHE context without using it to
   prove any endpoint.
5. Only then attempt a bridge from SHE plus existing HDD/common-container data
   to a named part of the payload route.

The main invariant for Phase 2: no theorem may turn IPL, SHE, APT, or HIS into
the Corollary 3.12 endpoint unless every transport, comparison target, and
real-line-copy identification is visible in its statement.

## Periodic Review: Cover/Deck Reconstruction Layer

Date: 2026-05-27

This checkpoint reviews the recent Lean work around finite etale Galois
orbicurve covers, deck transformations, and the reconstructed function field.
It is math-facing work, not endpoint infrastructure, but it remains below the
IUT III Theorem 3.11 to Corollary 3.12 comparison.

### Current Lean Chain

The current cover certificate records the following dependency chain:

```text
cover morphism
-> finite etale and Galois cover properties
-> deck group of the cover
-> realization by source automorphisms over the target
-> group-law compatibility of this realization
-> comparison with the theta-approach deck quotient
-> function-field extension attached to the cover
-> quotient action on the reconstructed function field
```

The important Lean object is:

```lean
ThetaFiniteEtaleGaloisCoverCertificate
```

It now exposes, among other accessors:

```lean
coverDeckAutomorphism
coverDeckAutomorphism_overTarget
coverDeckAutomorphism_groupLawCompatible
coverDeckEquivThetaQuotient
quotientEquivAlgAut
```

This is aligned with the IUT I reconstruction layer around Definition 3.1(d)
and Remark 3.1.2: finite etale orbicurve covers correspond to subgroup data,
and the theta approach reconstructs the function field of `X_K` from the
subgroup `Pi_XK <= Pi_CK`, equipped with the natural deck/Galois quotient
action.

### Positive Alignment

The formalization no longer treats the cover, its quotient group, and the
field action as independent loose inputs. The deck group is attached to the
finite etale Galois cover; its realization is indexed by that exact cover; the
group-law obligations are indexed by that realization; and the quotient action
is attached to the resulting function-field extension.

This is the right direction for the global project because the Scholze-Stix
diagnostic risk is precisely that identifications become invisible. The Lean
records now force a proposed identification to say which cover, which deck
group, which quotient, and which reconstructed field it belongs to.

### Remaining Gaps

The current layer still contains abstract propositions. In particular:

* `HyperbolicOrbicurveModel` is not yet a concrete orbicurve or a mathlib
  algebraic-geometric object.
* `HyperbolicOrbicurveMorphismData` does not yet carry an actual composition
  law.
* finite etaleness, Galoisness, and realization by automorphisms are named
  propositions rather than derived theorems.
* the deck automorphism group law is visible, but not yet expressed using a
  concrete composition operation on over-target automorphisms.
* the quotient equivalence and reconstructed-field action are supplied data,
  not yet consequences of an EtTh reconstruction theorem.

These are acceptable gaps at this stage only because the records are explicit
about them. They should not be used as hidden shortcuts to produce a
Corollary 3.12-style numerical comparison.

### Global 3.12 Check

This layer is necessary for IUT-style anabelian reconstruction, but it is not
where the 3.11/3.12 disagreement is decided. The disputed step concerns the
later Hodge-theater and common-container comparison: which histories are
forgotten, which structures remain visible, which real-line copies are being
compared, and whether a collapse to a trivial identification has been smuggled
in.

Therefore the next mathematical milestones should either:

* make the cover/deck realization less opaque by adding a concrete
  over-target automorphism composition interface; or
* move back toward the Stage 1 SHE/HDD/common-container structures, with the
  same explicit-history discipline.

In either direction, a theorem must not infer a comparison endpoint from a
mere name such as `Galois`, `SHE`, `APT`, or `reconstructed`. The required
transport and identification data must remain visible in the type.
