# Math Formalization Notes

Date started: 2026-05-27

This file starts the second phase of the project: the transition from Stage 1
infrastructure into the mathematical content behind Mochizuki's Theorem 3.11 to
Corollary 3.12 passage.

The previous diary, `FORMALIZATION_NOTES.md`, records the infrastructure phase:
real-line copies, toy models, source obligations, endpoint packaging, payload
routes, public audits, and structured endpoint audit summaries. It remains the
record for those milestones. New milestones that implement non-inert IUT
mathematics should be recorded here.

## Review Checkpoint: End of Infrastructure Phase

The current Lean scaffold verifies the route:

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

The main current entry point is:

```lean
package.structuredEndpointAuditSummary inputs hypotheses
```

It proves that the public endpoint, comparison data, payload route, and source
audit are tied to one coherent structured route. This prevents endpoint drift,
but it does not prove Mochizuki's hard mathematical claim.

## First Math Boundary

The next phase begins with the currently inert Theorem 3.11 ingredients:

```lean
IUTStage1Theorem311StructuredInputs.hasStructuredIPL
IUTStage1Theorem311StructuredInputs.hasStructuredSHE
IUTStage1Theorem311StructuredInputs.hasStructuredAPT
IUTStage1Theorem311StructuredInputs.algorithmOutputCertified
IUTStage1Theorem311StructuredInputs.hodgeTheaterSHEAlignment
```

These names currently expose structured bookkeeping data only. They do not yet
imply common-container comparison data, log-volume bounds, real-line-copy
identifications, or the Corollary 3.12 endpoint.

## Source Alignment

IUT III, Remark 3.11.1, identifies the key qualitative ingredients of Theorem
3.11:

* IPL: input prime-strip linkage;
* SHE: simultaneous holomorphic expressibility;
* APT: algorithmic parallel transport;
* HIS: hidden internal structures, where one reasons about qualitative output
  data without carrying all theta-function internals.

Mochizuki's 2026 formalization report isolates the final `3.11.5 -> 3.12`
portion as the simultaneous comparison around `(HDD) o (SHE)`, while the
second/third triangles concern APT plus IPL.

The Scholze-Stix diagnostic constraint remains active: any formal bridge from
structured source data to a real-valued endpoint must expose the real-line-copy
identifications and must not silently erase Hodge-theater/ring-history data.

## Phase 2 Starting Decision

The first non-inert mathematical target should be SHE.

Reason:

* SHE already appears in the current scaffold as the alignment between the
  common-container SHE arrow and the structured certificate.
* It is local enough to strengthen without claiming the full multiradial
  algorithm.
* It is directly relevant to the contested question of simultaneous comparison
  without collapse of histories.

The first planned math milestone should introduce a record tentatively named:

```lean
StructuredSHEContext
```

It should be strong enough to recover the existing inert `SHEDatum`, but weak
enough that it does not by itself imply the Corollary 3.12 endpoint.

## Guardrail

No theorem in this phase may turn IPL, SHE, APT, HIS, or any single qualitative
name into the endpoint unless every required transport, comparison target,
real-line-copy identification, and Hodge-theater history condition appears in
the theorem statement or an explicit dependency.

## Math Milestone 1: Conservative Structured SHE Context

Lean files:

* `Iut/Foundations/QualitativeData.lean`
* `Iut/Stage1/ToyQualitativeOutput.lean`

### Source Check

IUT III, Remark 3.11.1 describes SHE as simultaneous holomorphic
expressibility: the relevant construction and output data should be expressed in
terms that are valid relative to both the domain and codomain arithmetic
holomorphic structures. Mochizuki's 2026 report identifies `(HDD) o (SHE)` as
the final Stage 1 comparison focus. Scholze-Stix's criticism remains the
guardrail: simultaneous expression must not silently become identification of
the two histories or of their real-line copies.

### Purpose

The existing `SHEDatum` only stored a shared context. This milestone introduces
a first stronger SHE object, `QualitativeData.StructuredSHEContext`, without
making SHE prove any comparison endpoint.

The new context records:

* domain and codomain holomorphic structures;
* a common language;
* q-pilot and Theta-pilot holomorphic structures;
* explicit placement of the q-pilot in the codomain theater;
* explicit placement of the Theta-pilot in the domain theater;
* a proposition witnessing simultaneous validity;
* an explicit proof that the domain and codomain Hodge-theater sides are not
  identified.

### Lean Declarations

In `QualitativeData.lean`:

```text
QualitativeData.StructuredSHEContext
QualitativeData.StructuredSHEContext.sharedContext
QualitativeData.StructuredSHEContext.sheDatum
QualitativeData.StructuredSHEContext.hasStructuredSHE
QualitativeData.StructuredSHEContext.qPilotTheater_eq_codomain
QualitativeData.StructuredSHEContext.thetaPilotTheater_eq_domain
QualitativeData.StructuredSHEContext.simultaneousValid
QualitativeData.StructuredSHEContext.domainHistory_ne_codomainHistory
QualitativeData.StructuredSHEContext.sheDatum_sharedContext
```

In `ToyQualitativeOutput.lean`:

```text
thetaToyStructuredSHEContext
thetaToyStructuredSHEContext_sheDatum
thetaToyStructuredSHEContext_hasStructuredSHE
thetaToyStructuredSHEContext_histories_not_identified
```

### What This Tests

The toy example satisfies the stronger SHE context while proving only the
conservative projections:

* it recovers the old inert `SHEDatum`;
* it recovers `HasStructuredSHE`;
* it records that the toy domain and codomain histories are not identified.

It does not prove a common-target bound, payload route, public audit, or
Corollary-3.12-shaped endpoint.

### Design Trap Avoided

The trap would be to let "SHE" become a magic theorem producing the comparison
payload. This milestone does the opposite: it strengthens the data shape while
only projecting back to existing inert evidence. The extra fields make future
bridges state exactly what simultaneous validity and history separation mean.

### Next Step

The next milestone should connect `StructuredSHEContext` to the source-facing
`IUTStage1Theorem311SHEAlignment` field, again as a conservative projection
rather than as an endpoint theorem.

## Math Milestone 2: Source-Facing Structured SHE Alignment

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 1 strengthened SHE at the qualitative-data layer. The next source
boundary is the existing Theorem 3.11 SHE-alignment field, which states that the
common-container SHE arrow datum agrees with the structured certificate's SHE
datum. This corresponds to the role of SHE in the fourth triangle described in
Mochizuki's 2026 report: the SHE arrow supplies the q-pilot-side data used in
the restricted `(HDD) o (SHE)` composite.

The Scholze-Stix guardrail remains: this alignment is not a theorem that
identifies histories or real lines. It is only a named equality between the SHE
datum used by the common container and the SHE datum stored in the structured
certificate.

### Purpose

This milestone adds a source-facing structure:

```text
IUTStage1Theorem311StructuredSHE
```

It contains:

* a `QualitativeData.StructuredSHEContext`;
* an equality from the context's `sheDatum` to the package certificate's SHE
  datum;
* an equality from the common-container SHE arrow datum to the context's
  `sheDatum`.

From these fields we recover the existing `IUTStage1Theorem311SHEAlignment`.
No endpoint, payload route, common-target bound, or Corollary 3.12 statement is
derived.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311StructuredSHE
IUTStage1Theorem311StructuredSHE.hasStructuredSHE
IUTStage1Theorem311StructuredSHE.sheDatumMatchesCertificate
IUTStage1Theorem311StructuredSHE.sheArrowMatchesContext
IUTStage1Theorem311StructuredSHE.hodgeTheaterSHEAlignment
IUTStage1Theorem311StructuredSHE.sheAlignment
IUTStage1Theorem311StructuredSHE.sheAlignment_hodgeTheaterSHEAlignment_eq
IUTStage1Theorem311StructuredSHE.domainHistory_ne_codomainHistory
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_structured_she_input_example
unitThetaToy_source_theorem311_structured_she_input_hasStructuredSHE_example
unitThetaToy_source_theorem311_structured_she_input_alignment_example
unitThetaToy_source_theorem311_structured_she_input_history_example
```

### What This Tests

The toy source package constructs a strengthened source-facing SHE input and
checks that it recovers:

* the old inert `HasStructuredSHE`;
* the existing source-facing SHE alignment equality;
* the explicit non-identification of domain and codomain Hodge-theater sides.

### Design Trap Avoided

The trap would be to strengthen SHE and immediately let it discharge the final
comparison. Instead, this milestone connects stronger SHE data only to the
pre-existing SHE alignment field. This keeps the next bridge honest: any future
payload construction must state additional HDD/common-container and real-chart
requirements explicitly.

### Next Step

The next milestone should expose a structured SHE input through
`IUTStage1Theorem311StructuredInputs`, so the strengthened SHE context can be
carried alongside the existing algorithmic-output and side-condition routes.

## Math Milestone 3: Structured Inputs with Strengthened SHE

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestones 1 and 2 introduced a stronger SHE context and connected it to the
existing source-facing SHE alignment. The next issue is routing: strengthened
SHE should be available alongside `IUTStage1Theorem311StructuredInputs`, but it
should not replace or redefine the older structured-input route.

This follows the same source discipline as IUT III, Remark 3.11.1: SHE is one
ingredient in the Theorem 3.11 package, not a standalone proof of the final
Corollary 3.12 comparison.

### Purpose

This milestone adds:

```text
IUTStage1Theorem311StructuredInputsWithSHE
```

The bundle contains:

* the existing `IUTStage1Theorem311StructuredInputs`;
* a strengthened `IUTStage1Theorem311StructuredSHE`.

It exposes both routes and proves their SHE-alignment components agree by proof
irrelevance. It also exposes the history-separation guard from the strengthened
SHE context.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311StructuredInputsWithSHE
IUTStage1Theorem311StructuredInputsWithSHE.theorem311StructuredInputs
IUTStage1Theorem311StructuredInputsWithSHE.structuredSHE
IUTStage1Theorem311StructuredInputsWithSHE.hasStructuredIPL
IUTStage1Theorem311StructuredInputsWithSHE.hasStructuredSHE
IUTStage1Theorem311StructuredInputsWithSHE.hasStructuredSHE_from_context
IUTStage1Theorem311StructuredInputsWithSHE.hasStructuredAPT
IUTStage1Theorem311StructuredInputsWithSHE.algorithmOutputCertified
IUTStage1Theorem311StructuredInputsWithSHE.hodgeTheaterSHEAlignment
IUTStage1Theorem311StructuredInputsWithSHE.hodgeTheaterSHEAlignment_from_context
IUTStage1Theorem311StructuredInputsWithSHE.sheAlignment_eq_context_sheAlignment
IUTStage1Theorem311StructuredInputsWithSHE.domainHistory_ne_codomainHistory
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_structured_inputs_with_she_example
unitThetaToy_source_theorem311_structured_inputs_with_she_hasSHE_example
unitThetaToy_source_theorem311_structured_inputs_with_she_alignment_eq_example
unitThetaToy_source_theorem311_structured_inputs_with_she_history_example
```

### What This Tests

The toy source package now carries both the older structured-input route and the
strengthened SHE route in one bundle. The examples check:

* the bundle recovers `HasStructuredSHE` from the strengthened context;
* the old and strengthened SHE-alignment components agree;
* the domain/codomain history separation remains visible.

### Design Trap Avoided

The trap would be to mutate `IUTStage1Theorem311StructuredInputs` itself and
silently strengthen every old theorem. Instead, this milestone introduces an
explicit stronger bundle. Downstream code must opt in to the stronger SHE
context, which makes the new assumption visible in theorem statements.

### Next Step

The next milestone should define the first small SHE-to-common-container
compatibility checklist: it should mention the SHE context, the common
container's shared context, and the certificate SHE datum, but still avoid any
real-valued endpoint conclusion.

## Math Milestone 4: SHE/Common-Container Compatibility

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Mochizuki's formalization report describes the final triangle in the
`3.11.5 => 3.12` route as the composite `(HDD) o (SHE)`, with SHE supplying the
input situation in which HDD is applied. IUT III, Remark 3.11.1 describes SHE as
the condition that the output data can be expressed in a form valid relative to
both arithmetic holomorphic structures.

For our purposes, the immediate formal question is not whether this already
proves Corollary 3.12. The immediate question is whether the strengthened SHE
context is the same SHE context used by the existing common-container/HDD-SHE
composite. This is exactly the kind of bookkeeping where Lean is useful: it
forces the shared-context equality to be proved from recorded fields, rather
than silently assumed.

### Purpose

This milestone adds a proof-level compatibility checklist:

```text
IUTStage1Theorem311StructuredSHECommonContainerCompatibility
```

The checklist records four facts:

* the common-container SHE arrow datum is the strengthened SHE datum;
* the strengthened SHE datum is the certificate SHE datum;
* the common-container shared context is the strengthened SHE shared context;
* the domain and codomain histories are still not identified.

The third item is derived, not postulated. It follows from:

```text
CommonContainerData.she_context_matches
IUTStage1Theorem311StructuredSHE.sheArrowMatchesContext
StructuredSHEContext.sheDatum_sharedContext
```

This is intentionally only a compatibility statement. It does not bind a
comparison endpoint, does not assert a target bound, and does not identify the
two arithmetic histories.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311StructuredSHE.commonContainerContextMatches
IUTStage1Theorem311StructuredSHECommonContainerCompatibility
IUTStage1Theorem311StructuredSHECommonContainerCompatibility.ofStructuredSHE
IUTStage1Theorem311StructuredSHECommonContainerCompatibility.sheArrowMatchesContext
IUTStage1Theorem311StructuredSHECommonContainerCompatibility.sheDatumMatchesCertificate
IUTStage1Theorem311StructuredSHECommonContainerCompatibility.commonContainerContextMatches
IUTStage1Theorem311StructuredSHECommonContainerCompatibility.domainHistory_ne_codomainHistory
IUTStage1Theorem311StructuredInputsWithSHE.commonContainerCompatibility
IUTStage1Theorem311StructuredInputsWithSHE.commonContainerContextMatches
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_structured_she_common_container_compatibility_example
unitThetaToy_source_theorem311_structured_she_common_context_example
unitThetaToy_source_theorem311_structured_inputs_with_she_common_context_example
```

### What This Tests

The toy source package now instantiates the compatibility checklist and proves
that its charted common container uses the same shared context as the structured
SHE context. In the toy model this is by definitional equality, but the
source-level theorem is not `rfl`: it composes the equality stored in the
common-container record with the equality stored in the structured SHE input.

### Design Trap Avoided

The tempting but dangerous shortcut would be to treat the common container as
if it already supplied a global endpoint comparison. We did not do that. The
new theorem merely aligns names and contexts. This keeps the Scholze-Stix
diagnostic issue visible: a later theorem must still explain what is being
compared, under which history discipline, and why the formal route is not a
hidden collapse of the two structures.

### Next Step

The next milestone should expose the first audited entry point from this
compatibility checklist into the existing `HDD o SHE` boundedness machinery.
That step should remain proof-level and should explicitly state which
certificate and common-container object are being used before any bound is
transported.
