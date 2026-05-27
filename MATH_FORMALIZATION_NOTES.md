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

## Math Milestone 5: Audited HDD-after-SHE Bound Entry

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The formalization report isolates the fourth triangle as `(HDD) o (SHE)`: HDD is
restricted to the case where its input data is obtained via the SHE arrow. The
previous milestone checked that our strengthened SHE context is the same context
seen by the common container. The present milestone asks the next narrower
question: once that audit is present, what target-volume bound is already
available from the existing `HDD o SHE` machinery?

This is also where the Scholze-Stix caution remains relevant. Producing a
target-volume upper bound is not yet the Corollary 3.12 comparison. The q-side
membership inequality, chart readings, positivity, normalization, and final
signed packaging are still separate pieces of the formal route.

### Purpose

This milestone adds:

```text
IUTStage1Theorem311AuditedHDDSHEBound
```

The record packages:

* the SHE/common-container compatibility checklist from Milestone 4;
* the chosen output target-volume bound obtained from the charted common
  container applied to the pre-ledger certificate;
* the all-targets version of the same common-container bound;
* the history-separation guard from the strengthened SHE context.

The chosen bound has the form:

```text
RegionMeasure.targetVolume package.preLedger.measure
    (package.preLedger.output.comparison
      package.preLedger.chosenOutput.choice)
  <= package.preLedger.thetaSigned
```

It is proved by:

```text
package.preLedger.chartedContainer.choice_targetVolume_le
  package.preLedger.certificate
  package.preLedger.chosenOutput.choice
```

Thus the certificate and common-container object are explicit in the proof term.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311AuditedHDDSHEBound
IUTStage1Theorem311AuditedHDDSHEBound.ofStructuredInputsWithSHE
IUTStage1Theorem311AuditedHDDSHEBound.commonContainerCompatibility
IUTStage1Theorem311AuditedHDDSHEBound.commonContainerContextMatches
IUTStage1Theorem311AuditedHDDSHEBound.chosenTargetVolume_le_theta
IUTStage1Theorem311AuditedHDDSHEBound.allTargetsAtMost_theta
IUTStage1Theorem311AuditedHDDSHEBound.domainHistory_ne_codomainHistory
IUTStage1Theorem311StructuredInputsWithSHE.auditedHDDSHEBound
IUTStage1Theorem311StructuredInputsWithSHE.auditedHDDSHE_chosenTargetVolume_le_theta
IUTStage1Theorem311StructuredInputsWithSHE.auditedHDDSHE_allTargetsAtMost_theta
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_audited_hdd_she_bound_example
unitThetaToy_source_theorem311_audited_hdd_she_choice_bound_example
unitThetaToy_source_theorem311_audited_hdd_she_all_targets_example
```

### What This Tests

The toy model verifies that the audited route can recover:

* the selected target-volume bound for the chosen output;
* the all-targets upper bound for the transported output family.

Both are obtained through the common-container API. The examples do not use
q-side membership and do not conclude the signed q-to-Theta inequality.

### Design Trap Avoided

The dangerous shortcut would be to identify this upper bound with Corollary 3.12
itself. We did not do that. The new record is an entry into the boundedness
machinery, not an endpoint theorem. In particular, it does not mention
`Corollary312Inequality`, `ComparisonPayloadInputs`, or q-positivity.

### Next Step

The next milestone should relate this audited `HDD o SHE` bound to the existing
charted target-volume middle term. That bridge should state only that the
target-volume field used in the final comparison is the same chosen target
volume bounded here; it should still keep q-side membership and final
Corollary 3.12 packaging separate.

## Math Milestone 6: Audited Target-Volume Middle Term

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The proof of Corollary 3.12 ultimately uses a middle real-valued target-volume
term between the q-side quantity and the Theta-side bound. The previous
milestone recovered the upper bound on the chosen target volume from the
audited `HDD o SHE` route. This milestone connects that chosen target volume to
the named charted target-volume field in the pre-ledger.

This remains below the disputed endpoint. It does not assert that the q-side
quantity lies below the target-volume middle term, and it does not package the
signed q-to-Theta inequality.

### Purpose

This milestone adds:

```text
IUTStage1Theorem311AuditedTargetVolumeMiddle
```

The record packages:

* the audited `HDD o SHE` bound from Milestone 5;
* the equality identifying `targetVolume.targetSigned` with the chosen target
  volume;
* the resulting upper bound `targetVolume.targetSigned <= thetaSigned`;
* the history-separation guard.

The key proof is:

```text
rw [package.preLedger.targetSigned_eq_choiceTargetVolume]
exact audited.chosenTargetVolume_le_theta
```

So the middle-term inequality is not independent data. It is derived from the
existing pre-ledger equality and the audited `HDD o SHE` target-volume bound.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311AuditedTargetVolumeMiddle
IUTStage1Theorem311AuditedTargetVolumeMiddle.ofAuditedHDDSHEBound
IUTStage1Theorem311AuditedTargetVolumeMiddle.ofStructuredInputsWithSHE
IUTStage1Theorem311AuditedTargetVolumeMiddle.auditedHDDSHEBound
IUTStage1Theorem311AuditedTargetVolumeMiddle.targetSigned_eq_chosenTargetVolume
IUTStage1Theorem311AuditedTargetVolumeMiddle.chosenTargetVolume_eq_targetSigned
IUTStage1Theorem311AuditedTargetVolumeMiddle.targetSigned_le_theta
IUTStage1Theorem311AuditedTargetVolumeMiddle.domainHistory_ne_codomainHistory
IUTStage1Theorem311StructuredInputsWithSHE.auditedTargetVolumeMiddle
IUTStage1Theorem311StructuredInputsWithSHE.auditedTargetSigned_eq_chosenTargetVolume
IUTStage1Theorem311StructuredInputsWithSHE.auditedTargetSigned_le_theta
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_audited_target_middle_example
unitThetaToy_source_theorem311_audited_target_middle_eq_example
unitThetaToy_source_theorem311_audited_target_middle_le_theta_example
```

### What This Tests

The toy model verifies that the charted middle term is definitionally the target
volume of the chosen output comparison and inherits the audited upper bound.
The proof goes through the same source-facing API as the non-toy scaffold.

### Design Trap Avoided

The trap would be to combine this with q-side membership immediately and present
the result as the Corollary 3.12 inequality. We did not do that. The record only
covers the upper half of the eventual chain:

```text
targetSigned <= thetaSigned
```

The lower half,

```text
qSigned <= targetSigned
```

is still a separate membership/charting obligation.

### Next Step

The next milestone should add an audited lower-middle bridge for
`qSigned <= targetSigned`, explicitly sourced from the charted membership datum.
Only after both middle bridges are present should we consider a separate
packaging theorem that assembles the signed q-to-Theta inequality.

## Math Milestone 7: Audited q-to-Target Membership Bridge

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestone covered the upper half of the eventual real inequality
chain, namely `targetSigned <= thetaSigned`. The lower half,
`qSigned <= targetSigned`, has a different source: it comes from the charted
membership datum for the selected output comparison, not from `HDD o SHE`.

This distinction matters for the Corollary 3.12 dispute. If the lower bound,
upper bound, chart identifications, and final packaging are collapsed into one
opaque theorem, then Lean would no longer help us locate the exact mathematical
move being used. This milestone therefore isolates the lower-middle bridge.

### Purpose

This milestone adds:

```text
IUTStage1Theorem311AuditedMembershipMiddle
```

The record packages:

* the audited target-volume middle term from Milestone 6;
* the q-side chart reading;
* the fact that the selected output comparison holds at the q-point;
* the lower-middle inequality `qSigned <= targetSigned`;
* the history-separation guard.

The lower-middle inequality is sourced from:

```text
package.preLedger.qSigned_le_targetSigned
```

and the chart/membership facts are sourced from:

```text
package.preLedger.qSigned_eq_chartedQ
package.preLedger.chosenComparisonHoldsQ
```

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311AuditedMembershipMiddle
IUTStage1Theorem311AuditedMembershipMiddle.ofTargetVolumeMiddle
IUTStage1Theorem311AuditedMembershipMiddle.ofStructuredInputsWithSHE
IUTStage1Theorem311AuditedMembershipMiddle.targetVolumeMiddle
IUTStage1Theorem311AuditedMembershipMiddle.qCharted
IUTStage1Theorem311AuditedMembershipMiddle.chosenHolds
IUTStage1Theorem311AuditedMembershipMiddle.qSigned_le_targetSigned
IUTStage1Theorem311AuditedMembershipMiddle.domainHistory_ne_codomainHistory
IUTStage1Theorem311StructuredInputsWithSHE.auditedMembershipMiddle
IUTStage1Theorem311StructuredInputsWithSHE.auditedQCharted
IUTStage1Theorem311StructuredInputsWithSHE.auditedChosenHolds
IUTStage1Theorem311StructuredInputsWithSHE.auditedQSigned_le_targetSigned
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_audited_membership_middle_example
unitThetaToy_source_theorem311_audited_membership_q_charted_example
unitThetaToy_source_theorem311_audited_membership_chosen_holds_example
unitThetaToy_source_theorem311_audited_membership_q_le_target_example
```

### What This Tests

The toy model verifies that the lower-middle bridge recovers the q-side chart
identity, the selected-output membership fact, and `qSigned <= targetSigned`.
These are intentionally tested without invoking the final signed inequality.

### Design Trap Avoided

The dangerous shortcut would be to immediately compose:

```text
qSigned <= targetSigned
targetSigned <= thetaSigned
```

and call this Corollary 3.12. We did not do that. The lower and upper bridges
now exist as separate audited objects, which lets us review exactly which source
datum supports each half of the chain.

### Next Step

The next milestone may add a deliberately named chain-composition record that
derives only the raw real inequality `qSigned <= thetaSigned` from the two
middle bridges. It should still avoid `Corollary312Inequality` until
q-positivity and source normalization are explicitly present.

## Math Milestone 8: Audited Raw Inequality Chain

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

IUT III, Corollary 3.12 ultimately concerns a log-volume estimate comparing the
q-pilot side to the Theta-pilot side. The introduction to IUT III describes this
as a computation of an upper bound for the q-pilot log-volume via the
Theta-pilot/hull computation. Mochizuki's later formalization report separates
the final `3.11.5 => 3.12` portion into the simultaneous-comparison step around
`(HDD) o (SHE)`.

Our current code now has two audited middle bridges:

```text
qSigned <= targetSigned
targetSigned <= thetaSigned
```

This milestone composes exactly these two inequalities and nothing more.

### Purpose

This milestone adds:

```text
IUTStage1Theorem311AuditedRawInequality
```

The record packages:

* the audited membership middle from Milestone 7;
* the lower inequality `qSigned <= targetSigned`;
* the upper inequality `targetSigned <= thetaSigned`;
* the composed raw inequality `qSigned <= thetaSigned`;
* the history-separation guard.

The composed inequality is proved by:

```text
le_trans middle.qSigned_le_targetSigned
  middle.targetVolumeMiddle.targetSigned_le_theta
```

Thus the composition point is explicit and reviewable.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311AuditedRawInequality
IUTStage1Theorem311AuditedRawInequality.ofMembershipMiddle
IUTStage1Theorem311AuditedRawInequality.ofStructuredInputsWithSHE
IUTStage1Theorem311AuditedRawInequality.membershipMiddle
IUTStage1Theorem311AuditedRawInequality.qSigned_le_targetSigned
IUTStage1Theorem311AuditedRawInequality.targetSigned_le_theta
IUTStage1Theorem311AuditedRawInequality.qSigned_le_thetaSigned
IUTStage1Theorem311AuditedRawInequality.domainHistory_ne_codomainHistory
IUTStage1Theorem311StructuredInputsWithSHE.auditedRawInequality
IUTStage1Theorem311StructuredInputsWithSHE.auditedRaw_qSigned_le_thetaSigned
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_audited_raw_inequality_example
unitThetaToy_source_theorem311_audited_raw_q_le_theta_example
unitThetaToy_source_theorem311_audited_raw_explicit_q_le_theta_example
```

### What This Tests

The toy model verifies that the raw chain produces:

```text
(Transport.map unitQToTheta (qAssignment h)).coord <= -(2 * h) + epsilonBound
```

through the source-facing audited route. This gives us a concrete sanity check
that the lower and upper middle bridges compose as intended.

### Design Trap Avoided

The trap would be to make this theorem return `Corollary312Inequality`, or to
silently use q-positivity and normalization. We did not do that. This milestone
returns only a plain real inequality:

```text
package.preLedger.qSigned <= package.preLedger.thetaSigned
```

The signed pilot objects, q-positivity, source normalization, and public
comparison packaging remain outside this record.

### Next Step

The next milestone should introduce an audited packaging boundary that states
exactly which extra side conditions are needed to turn the raw real inequality
into the existing signed comparison payload. That step should mention
q-positivity and normalization explicitly and should remain separate from the
SHE/HDD/membership derivation.

## Math Milestone 9: Audited Signed Payload Boundary

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestone produced only the raw real inequality
`qSigned <= thetaSigned`. The existing Stage 1 schema represents the signed
Corollary-3.12-style data by `Corollary312ComparisonData`, which additionally
stores q-positivity. Separately, the source route tracks normalization as a
promotion side condition.

This milestone marks the boundary where those side conditions are attached. It
does not alter the audited SHE/HDD/membership derivation of the raw inequality.

### Purpose

This milestone adds:

```text
IUTStage1Theorem311AuditedSignedPayloadBoundary
```

The boundary packages:

* the audited raw inequality from Milestone 8;
* q-pilot positivity from `IUTStage1SourceSideConditions`;
* source normalization from `IUTStage1SourceSideConditions`;
* the raw inequality again as the field used by the signed comparison payload;
* the history-separation guard.

It also exposes:

```text
comparisonData : Corollary312ComparisonData
```

This construction uses q-positivity and the raw inequality. Normalization is
kept as an explicit boundary proof even though `Corollary312ComparisonData`
does not currently consume it.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311AuditedSignedPayloadBoundary
IUTStage1Theorem311AuditedSignedPayloadBoundary.ofRawInequality
IUTStage1Theorem311AuditedSignedPayloadBoundary.ofStructuredInputsWithSideConditions
IUTStage1Theorem311AuditedSignedPayloadBoundary.rawInequality
IUTStage1Theorem311AuditedSignedPayloadBoundary.qPilotPositive
IUTStage1Theorem311AuditedSignedPayloadBoundary.sourceNormalization
IUTStage1Theorem311AuditedSignedPayloadBoundary.qSigned_le_thetaSigned
IUTStage1Theorem311AuditedSignedPayloadBoundary.comparisonData
IUTStage1Theorem311AuditedSignedPayloadBoundary.comparisonData_qSigned
IUTStage1Theorem311AuditedSignedPayloadBoundary.comparisonData_thetaSigned
IUTStage1Theorem311AuditedSignedPayloadBoundary.comparisonData_qSigned_le_thetaSigned
IUTStage1Theorem311AuditedSignedPayloadBoundary.comparisonData_corollary312
IUTStage1Theorem311AuditedSignedPayloadBoundary.domainHistory_ne_codomainHistory
IUTStage1Theorem311StructuredInputsWithSHE.auditedSignedPayloadBoundary
IUTStage1Theorem311StructuredInputsWithSHE.auditedComparisonData
IUTStage1Theorem311StructuredInputsWithSHE.auditedComparisonData_qSigned_le_thetaSigned
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_audited_signed_payload_boundary_example
unitThetaToy_source_theorem311_audited_comparison_data_example
unitThetaToy_source_theorem311_audited_comparison_data_q_le_theta_example
unitThetaToy_source_theorem311_audited_payload_normalization_example
```

### What This Tests

The toy model verifies that the audited route can construct
`Corollary312ComparisonData` only after explicit side conditions are supplied.
It also checks that the comparison data stores the raw inequality and that
source normalization remains separately visible.

### Design Trap Avoided

The trap would be to let q-positivity or normalization appear as implicit
consequences of SHE, HDD, or membership. We did not do that. They enter only
through `IUTStage1SourceSideConditions`, at the named signed-payload boundary.

### Next Step

The next milestone should compare this audited signed payload with the older
public-audit route already present in `IUTStage1Source.lean`. The goal is not a
new endpoint, but a theorem saying that the newly audited payload agrees with
the existing comparison-data packaging when supplied the same side conditions.

## Math Milestone 10: Audited Payload Route Equality

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The source file already had an older packaging route:

```text
comparisonPayloadInputs
comparisonDataFromPayloadInputs
```

The new audited route starts earlier, at the structured SHE context, and passes
through the explicit SHE/HDD bound, target middle term, membership middle term,
raw inequality, and signed-payload boundary. This milestone checks that the new
audited payload is not a parallel endpoint: when supplied the same side
conditions, it agrees with the older comparison-data packaging.

### Purpose

This milestone adds package-level route comparison declarations:

```text
IUTStage1SourcePackage.auditedComparisonSourceObligations
IUTStage1SourcePackage.auditedComparisonData_eq_payloadInputs
IUTStage1SourcePackage.auditedComparisonData_stage1Comparison_eq_payloadInputs
```

The source obligations used for the old route are built from:

```text
IUTStage1SourceObligations.ofStructuredInputsAndSideConditions
  bundle.inputs sideConditions
```

The equality then states that:

```text
bundle.auditedComparisonData sideConditions
=
package.comparisonDataFromPayloadInputs
  (package.auditedComparisonSourceObligations bundle sideConditions)
```

### What This Tests

The toy model verifies both comparison-data equality and stage-comparison
equality:

```text
unitThetaToy_source_theorem311_audited_comparison_data_eq_payload_inputs_example
unitThetaToy_source_theorem311_audited_stage_comparison_eq_payload_inputs_example
```

This confirms that the audited route integrates with the existing Stage 1
comparison-data API.

### Design Trap Avoided

The trap would be to leave two independent ways to manufacture signed comparison
data. That would make later reviews ambiguous: a theorem could use the older
payload path while appearing to rely on the audited SHE/HDD/membership path. The
route-equality theorem makes the relationship explicit.

### Next Step

The next milestone should decide how much of the public audit route should be
re-exposed through the newly audited path. A conservative step would prove only
that the public audit obtained from the audited comparison data has the same
Corollary 3.12 proof term up to proof irrelevance, while keeping the route
checklist visible.

## Math Milestone 11: Audited Public-Audit Wrapper

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

At this point the formal route contains two layers:

* the audited derivation layer, which starts at structured SHE and passes through
  `HDD o SHE`, the charted target-volume middle term, q-membership, the raw
  inequality, and the signed-payload boundary;
* the older public-audit layer, which packages `Corollary312ComparisonData` for
  the Stage 1 endpoint API.

This milestone exposes the public-audit tuple through the audited derivation
layer without making a new endpoint theorem.

### Purpose

This milestone adds:

```text
IUTStage1SourcePackage.AuditedPublicAudit
```

The wrapper records:

* the signed-payload boundary from Milestone 9;
* the equality with the older payload-input route from Milestone 10;
* the public-audit raw inequality;
* the public-audit Corollary 3.12-shaped proposition;
* the stage-comparison recovery proof;
* equality of the audited and payload-input stage comparisons;
* source normalization;
* history separation.

It also adds projections:

```text
AuditedPublicAudit.qSigned_le_thetaSigned
AuditedPublicAudit.corollary312Endpoint
AuditedPublicAudit.publicAudit
AuditedPublicAudit.comparisonDataEqPayloadInputs
AuditedPublicAudit.sourceNormalization
AuditedPublicAudit.domainHistory_ne_codomainHistory
IUTStage1SourcePackage.auditedPublicAudit
```

### What This Tests

The toy model verifies:

```text
unitThetaToy_source_theorem311_audited_public_audit_example
unitThetaToy_source_theorem311_audited_public_audit_tuple_example
unitThetaToy_source_theorem311_audited_public_audit_route_example
unitThetaToy_source_theorem311_audited_public_audit_history_example
```

These examples check that the wrapper can recover the public-audit tuple, the
route equality, and the history-separation guard.

### Design Trap Avoided

The trap would be to replace the existing public-audit endpoint with a second
endpoint under a more audited-looking name. We did not do that. The new wrapper
is explicitly a consistency layer: it exposes the existing public-audit facts
while keeping the full audited route checklist available for review.

### Next Step

The next milestone should add a compact route summary for the audited
structured-SHE path, similar in spirit to earlier endpoint summaries, so a human
reader can inspect the major checkpoints without expanding every proof field.

## Math Milestone 12: Audited Structured-SHE Route Summary

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The formal path from structured SHE to the public-audit tuple is now deliberately
long. That length is useful for auditability, but a human reader also needs a
compact checkpoint view that lists the major stages of the route without hiding
which route is being used.

This milestone mirrors earlier endpoint-summary patterns in the file while
remaining attached to the newer structured-SHE audit path.

### Purpose

This milestone adds:

```text
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary
```

The summary records:

* structured SHE availability;
* SHE/common-container compatibility;
* the audited `HDD o SHE` bound;
* the target-volume middle term;
* the q-membership middle term;
* the raw real inequality;
* the signed-payload boundary;
* the audited public-audit wrapper;
* equality with the older payload-input route;
* the q-to-Theta inequality in comparison data;
* source normalization;
* history separation.

It also exposes projection theorems for the public audit, signed-payload
boundary, raw inequality, payload-route equality, q-to-Theta inequality,
normalization, and history separation.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary.ofStructuredInputsWithSHE
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary.publicAudit
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary.signedPayloadBoundary
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary.rawInequality
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary.comparisonDataEqPayloadInputs
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary.qSigned_le_thetaSigned
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary.sourceNormalization
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary.domainHistory_ne_codomainHistory
IUTStage1SourcePackage.auditedStructuredSHERouteSummary
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_audited_route_summary_example
unitThetaToy_source_theorem311_audited_route_summary_raw_example
unitThetaToy_source_theorem311_audited_route_summary_public_example
unitThetaToy_source_theorem311_audited_route_summary_q_le_theta_example
```

### What This Tests

The toy examples verify that the compact route summary can be built and that it
recovers the raw inequality, the audited public-audit wrapper, and the
q-to-Theta inequality in the audited comparison data.

### Design Trap Avoided

The trap would be to introduce a summary that obscures the route by replacing
the checkpoint records. We did not do that. The summary contains the checkpoint
records as fields, so it is a review aid rather than a shortcut around the
audit path.

### Next Step

The next milestone should start separating this audited route into a smaller
module if the source file becomes unwieldy, or else add source-facing naming for
which checkpoint corresponds to the debated Theorem 3.11 to Corollary 3.12
transition.

## Math Milestone 13: Named Theorem 3.11 to Corollary 3.12 Checkpoints

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Mochizuki's formalization report names the final reorganized portion as
`3.11.5 => 3.12` and identifies the fourth triangle as the composite
`(HDD) o (SHE)`. The same passage says this triangle concerns simultaneous
comparison inside a common container. IUT III, Remark 3.11.1 also stresses that
SHE and APT are not ordinary set-theoretic transport, and that later comparison
work remains necessary.

This milestone adds source-facing names for the checkpoints we have formalized,
so a reviewer can see which proof object corresponds to which part of that
discussion.

### Purpose

This milestone adds inert checkpoint identifiers:

```text
TransitionCheckpointId
fourthTriangleHDDSHECheckpoint
simultaneousComparisonCheckpoint
theorem3115ToCorollary312Checkpoint
```

It also adds:

```text
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints
```

The checkpoint record ties together:

* the audited structured-SHE route summary;
* the source input label;
* the Corollary 3.12 comparison label;
* the fourth-triangle `HDD o SHE` bound;
* the simultaneous common-container compatibility proof;
* the raw target-volume chain;
* the signed-payload boundary;
* the audited public audit;
* history separation.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
TransitionCheckpointId
fourthTriangleHDDSHECheckpoint
simultaneousComparisonCheckpoint
theorem3115ToCorollary312Checkpoint
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints.ofStructuredInputsWithSHE
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints.routeSummary
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints.theorem311InputLabel
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints.corollary312ComparisonLabel
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints.fourthTriangleHDDSHE
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints.simultaneousCommonContainer
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints.targetVolumeChain
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints.signedPayloadBoundary
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints.publicAudit
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints.domainHistory_ne_codomainHistory
IUTStage1SourcePackage.auditedTheorem311ToCorollary312Checkpoints
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_transition_checkpoints_example
unitThetaToy_source_theorem311_transition_checkpoints_input_label_example
unitThetaToy_source_theorem311_transition_checkpoints_hdd_she_example
unitThetaToy_source_theorem311_transition_checkpoints_common_container_example
unitThetaToy_source_theorem311_transition_checkpoints_history_example
```

### What This Tests

The toy model verifies that the named checkpoint record can be instantiated and
that it exposes the input label, the fourth-triangle `HDD o SHE` checkpoint, the
simultaneous common-container checkpoint, and history separation.

### Design Trap Avoided

The trap would be to name the entire route "Corollary 3.12" and thereby obscure
which part of the proof corresponds to which mathematical claim. The new record
keeps the checkpoints separate. In particular, the `HDD o SHE` bound, the
common-container compatibility, the raw inequality, and the signed-payload
boundary remain distinct fields.

### Next Step

The source file is now large. The next milestone should split the audited
Theorem 3.11 to Corollary 3.12 route into a dedicated module, preserving public
imports and avoiding any change to theorem statements.

## Math Milestone 14: First Initial Theta Data Layer

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`
* `Iut/Basic.lean`

### Source Check

This milestone starts the actual mathematical implementation from IUT I,
Definition 3.1. The source defines initial theta data as

```text
(Fbar/F, X_F, l, C_K, V, Vbad_mod, epsilon)
```

subject to conditions (a)-(f): `F` is a number field containing `sqrt(-1)`,
`Fbar` is an algebraic closure, `X_F` is a once-punctured elliptic curve over
`F`, `l` is a prime at least `5`, `K/F` is the finite Galois extension
determined by the `l`-torsion representation, `V -> Vmod` is a valuation
section, `Vbad_mod` is a nonempty bad nonarchimedean set of odd residue
characteristic prime to `l`, `C_K` is the associated hyperbolic orbicurve, and
`epsilon` is a specified cusp.

### Lean Decisions

The formalization now uses mathlib for the mathematical objects that are
available:

```text
NumberField F
NumberField Fmod
AlgebraicClosure F
FiniteDimensional Fmod F
IsGalois Fmod F
FiniteDimensional F K
IsGalois F K
Nat.Prime l.value
WeierstrassCurve F
WeierstrassCurve.IsElliptic
```

This is a deliberate shift away from pure labels. In particular,
`PuncturedEllipticCurve.ofJ` uses mathlib's `WeierstrassCurve.ofJ`, and Lean
checks the theorem that its `j`-invariant is the chosen input.

The pieces not yet implemented in full IUT form are kept as explicit named
obligations rather than hidden inside an opaque label:

```text
stableReductionOverNonarchimedean
torsion23RationalOverF
lTorsionImageContainsSL2
qParameterOrdersPrimeToL
HyperbolicOrbicurveModel
CuspData
```

This lets the next milestones replace each obligation with real definitions
without changing the outer shape of initial theta data.

### Lean Declarations

```text
PrimeGeFive
SqrtMinusOneData
ThetaFieldTower
ThetaFieldTower.degreePrimeToL
PuncturedEllipticCurve
PuncturedEllipticCurve.jInvariant
PuncturedEllipticCurve.ofJ
PuncturedEllipticCurve.jInvariant_ofJ
ThetaValuationData
ThetaValuationData.bad
ThetaValuationData.goodMod
ThetaValuationData.good
ThetaValuationData.bad_nonempty
ThetaValuationData.badLift_has_multiplicative_reduction
HyperbolicOrbicurveModel
CuspData
InitialThetaData
InitialThetaData.algebraicClosure_isAlgClosure
InitialThetaData.moduli_extension_is_finiteDimensional
InitialThetaData.moduli_extension_is_galois
InitialThetaData.degree_F_over_Fmod_prime_to_l
InitialThetaData.prime_is_prime
InitialThetaData.prime_ge_five
InitialThetaData.badValuations_nonempty
InitialThetaData.badValuation_has_multiplicative_reduction
InitialThetaData.sqrtMinusOne_square
InitialThetaData.fmodFieldOfModuli
InitialThetaData.kIsLTorsionKernelField
InitialThetaData.cusp_arisesFromNonzeroQuotientElement
```

### What This Tests

The example file verifies:

* the prime `5` satisfies the IUT lower-bound wrapper;
* a small two-point model has a bijective valuation section `V -> Vmod`;
* the bad set is nonempty and bad lifts have the recorded multiplicative
  reduction property;
* a full abstract `InitialThetaData` constructor works under the exact field
  typeclass assumptions;
* mathlib's `ofJ` elliptic curve model supplies a checked `j`-invariant theorem.

### Design Trap Avoided

The trap here would be to keep "initial theta data" as a single inert label and
thereby postpone all mathematical pressure. We did not do that. The prime,
number-field, Galois-extension, algebraic-closure, elliptic-curve, and valuation
section components are real Lean data. The still-missing IUT-specific geometry
is isolated as named obligations that must be discharged or refined in later
milestones.

### Next Step

The next milestone should expand one obligation from Definition 3.1 instead of
adding more audit infrastructure. The most natural target is the field condition
`sqrt(-1) in F`, either by constructing concrete examples via a cyclotomic or
Gaussian number field, or by defining the field-of-moduli/extension layer that
will later support `Fmod`, `F`, and `K`.

## Math Milestone 15: Field Tower for Initial Theta Data

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

This milestone tightens the field portion of IUT I, Definition 3.1(b),(c). The
source introduces `Fmod ⊆ F` as the field of moduli of `X_F`, assumes that
`F/Fmod` is Galois of degree prime to `l`, and then defines `K ⊆ Fbar` as the
finite Galois extension of `F` determined by the kernel of the `l`-torsion
outer representation.

The previous Lean layer had `F` and `K`, but not `Fmod`. That was too weak for
the actual definition, since the bad valuation set lives over `Fmod` and the
prime-to-`l` degree condition concerns `F/Fmod`, not `K/F`.

### Lean Decisions

The formalization now has a separate field-tower record:

```text
ThetaFieldTower l Fmod F K
```

It requires the following mathlib typeclass hypotheses:

```text
NumberField Fmod
NumberField F
NumberField K
Algebra Fmod F
Algebra F K
Algebra Fmod K
IsScalarTower Fmod F K
FiniteDimensional Fmod F
IsGalois Fmod F
FiniteDimensional F K
IsGalois F K
```

The condition that `F/Fmod` has degree prime to `l` is recorded as:

```text
Nat.Coprime (Module.finrank Fmod F) l.value
```

This uses mathlib's `Module.finrank` for finite-dimensional field extensions,
which is the right Lean-level replacement for extension degree at this stage.

The facts that `Fmod` is the field of moduli of `X_F` and that `K` is the
kernel field of the `l`-torsion representation remain explicit obligations in
`InitialThetaData`; they depend on elliptic-curve/moduli and Galois
representation definitions that we have not yet formalized.

### Lean Declarations

```text
ThetaFieldTower
ThetaFieldTower.sqrtMinusOne_square
ThetaFieldTower.degreePrimeToL
ThetaFieldTower.f_over_fmod_is_finiteDimensional
ThetaFieldTower.f_over_fmod_is_galois
ThetaFieldTower.k_over_f_is_finiteDimensional
ThetaFieldTower.k_over_f_is_galois
InitialThetaData.moduli_extension_is_finiteDimensional
InitialThetaData.moduli_extension_is_galois
InitialThetaData.degree_F_over_Fmod_prime_to_l
InitialThetaData.fmodFieldOfModuli
InitialThetaData.kIsLTorsionKernelField
```

### What This Tests

The example file now verifies:

* construction of a `ThetaFieldTower` from a square root of `-1` and a
  prime-to-`l` degree proof;
* construction of `InitialThetaData Fmod F K` rather than only
  `InitialThetaData F K`;
* projection of the `F/Fmod` prime-to-`l` condition;
* projection of the field-of-moduli and `l`-torsion-kernel-field obligations.

### Design Trap Avoided

The trap would be to continue treating `Fmod` as implicit prose. That would
make the valuation data look formally well typed while hiding the field over
which `Vbad_mod` is supposed to live. The Lean record now exposes the three
fields and the two extension layers, so future valuation and moduli definitions
must attach to the correct field.

### Next Step

The next math milestone should continue with Definition 3.1 itself. A good
target is to replace the field-of-moduli obligation with a more structured
record relating `X_F`, its quotient `C_F`, and `Fmod`, or to replace the current
valuation index placeholders with mathlib finite places of `Fmod` and `K` if
the available API is strong enough.

## Math Milestone 16: Curve and Moduli Data for Definition 3.1(b)

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(b) starts with a once-punctured elliptic curve `X_F`
over `F`, writes `E_F` for the elliptic curve determined by `X_F`, forms the
hyperbolic orbicurve `C_F` as the quotient of `X_F` by the unique order-two
involution `-1`, and then introduces `Fmod` as the field of moduli of `X_F`.
The same clause assumes stable reduction over nonarchimedean valuations and
rationality over `F` of the `2 * 3` torsion points of `E_F`.

### Lean Decisions

These clauses now live in:

```text
ThetaCurveModuliData Fmod F
```

The record contains:

```text
xF : PuncturedEllipticCurve F
cF : HyperbolicOrbicurveModel F
cF_is_quotient_by_neg_one : Prop
fmod_is_fieldOfModuli : Prop
stableReductionOverNonarchimedean : Prop
torsion23RationalOverF : Prop
```

The quotient, field-of-moduli, stable-reduction, and torsion-rationality
clauses remain explicit propositions with proofs. This is intentional: mathlib
does not yet provide the exact IUT objects for hyperbolic orbicurves and their
stack-theoretic quotients, so the formalization records the source obligations
without pretending they are already derived.

`InitialThetaData` now contains `curveModuli : ThetaCurveModuliData Fmod F`
instead of carrying those obligations as unrelated fields. This makes the
dependency on `X_F` and `Fmod` visible to later definitions.

### Lean Declarations

```text
ThetaCurveModuliData
ThetaCurveModuliData.quotientByNegOne
ThetaCurveModuliData.fmodFieldOfModuli
ThetaCurveModuliData.stableReduction
ThetaCurveModuliData.torsion23Rational
InitialThetaData.quotientByNegOne
InitialThetaData.stableReductionOverNonarchimedean
InitialThetaData.torsion23RationalOverF
```

### What This Tests

The example file now verifies:

* construction of the curve/moduli data from `X_F`, `C_F`, and the four named
  source obligations;
* construction of initial theta data using the curve/moduli bundle;
* projection of the quotient-by-`-1`, field-of-moduli, stable-reduction, and
  `2 * 3` torsion-rationality obligations.

### Design Trap Avoided

The trap would be to let the field-of-moduli condition float as an unstructured
field of the final initial-theta record. The new bundle ties that condition to
the specific `X_F` and `C_F` data it is about. This does not solve the moduli
problem yet, but it prevents the next layers from using a moduli assertion that
is detached from the curve.

### Next Step

The next Definition 3.1 target should be the valuation layer: `Vmod = V(Fmod)`,
`V ⊆ V(K)`, the section `V -> Vmod`, and the distinction between bad valuation
sets and good valuation sets. We should first inspect mathlib's finite-place API
for number fields and decide how much of the current placeholder
`ThetaValuationData` can be replaced by actual place types.

## Math Milestone 17: Finite-Place Valuation Layer

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(b),(e) uses `Vmod = V(Fmod)`, a nonempty set
`Vbad_mod` of nonarchimedean valuations of `Fmod`, and a subset
`V ⊆ V(K)` inducing a bijection `V -> Vmod`, i.e. a section of the natural
surjection from valuations of `K` to valuations of `Fmod`. It then defines
bad and good parts by pulling back the bad and good moduli-level sets.

The source also assumes that the residue characteristics of elements of
`Vbad_mod` are odd and prime to `l`, and that `X_F` has bad/multiplicative
reduction at valuations over `Vbad_mod`.

### Lean/API Check

Mathlib has:

```text
NumberField.FinitePlace K
NumberField.FinitePlace.maximalIdeal
NumberField.FinitePlace.add_le
NonarchimedeanHomClass (NumberField.FinitePlace K) K R
```

The finite-place API represents finite places as absolute values associated to
height-one spectra of `𝓞 K`. It gives a real nonarchimedean finite-place type,
so our old arbitrary valuation index types were too weak.

I did not find a ready-made canonical restriction map
`FinitePlace K -> FinitePlace Fmod` with the exact section data needed by IUT
Definition 3.1(e). Therefore the map and section remain explicit fields.

### Lean Decisions

`ThetaValuationData` now has the shape:

```text
ThetaValuationData l Fmod K
```

and uses actual mathlib finite places:

```text
toModuli : NumberField.FinitePlace K -> NumberField.FinitePlace Fmod
chosenLift : NumberField.FinitePlace Fmod -> NumberField.FinitePlace K
toModuli_chosenLift : forall w, toModuli (chosenLift w) = w
badMod : Set (NumberField.FinitePlace Fmod)
```

The selected set `V ⊆ V(K)` is represented as:

```text
ThetaValuationData.selected = Set.range chosenLift
```

The bad and good selected valuations are:

```text
bad  = {v | v in selected and toModuli v in badMod}
good = {v | v in selected and toModuli v notin badMod}
```

Residue characteristic is still a function
`NumberField.FinitePlace Fmod -> Nat`. We record the source obligations that it
is prime, odd, and coprime to `l` on the bad moduli set. A later milestone can
try to derive this from maximal ideals/residue fields.

### Lean Declarations

```text
ThetaValuationData
ThetaValuationData.selected
ThetaValuationData.goodMod
ThetaValuationData.bad
ThetaValuationData.good
ThetaValuationData.chosenLift_mem_selected
ThetaValuationData.toModuli_chosenLift_eq
ThetaValuationData.chosenLift_mem_bad_iff
ThetaValuationData.bad_nonempty
ThetaValuationData.badLift_has_multiplicative_reduction
InitialThetaData.badValuations_nonempty
InitialThetaData.badValuation_has_multiplicative_reduction
```

### What This Tests

The example file now constructs valuation data abstractly over number fields
using `NumberField.FinitePlace Fmod` and `NumberField.FinitePlace K`. It also
verifies that initial theta data consumes this finite-place valuation bundle,
not arbitrary placeholder types.

### Design Trap Avoided

The trap would be to keep proving facts about a polymorphic `Valuation` type
that had no connection to number fields. This milestone forces the valuation
layer to use finite places of the actual fields in the initial theta-data
tower. The remaining explicit map/section fields are not drift: they correspond
to the source's section `V -> Vmod` and to API that is not yet provided by
mathlib in the exact form needed here.

### Next Step

The next target should refine one of the valuation obligations: either connect
`residueCharacteristic` to the maximal ideal/residue field attached to a
finite place, or add the `CK`/`CF` base-change relation from Definition 3.1(d)
so the local bad-reduction and cusp conditions have the right geometric target.

## Math Milestone 18: Orbicurve Cover Data for Definition 3.1(d)

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(d) says that `C_K` is a hyperbolic orbicurve of type
`(1,l-tors)^±` over `K`, with `K`-core given by the base-change
`C_F x_F K`. It further says that `C_K` determines, up to `K`-isomorphism, a
hyperbolic orbicurve `X_K` of type `(1,l-tors)` and finite etale covering
diagrams, together with corresponding open immersions of profinite groups.

Before this milestone, `C_K` was an independent field of `InitialThetaData`.
That was too weak: the source relates it directly to the earlier `C_F`.

### Lean Decisions

The new bundle is:

```text
ThetaOrbicurveCoverData Fmod F K curveModuli
```

It contains:

```text
cK : HyperbolicOrbicurveModel K
xK : HyperbolicOrbicurveModel K
cK_has_type_l_tors_pm : Prop
cK_core_is_baseChange_cF : Prop
cK_determined_by_cF : Prop
xK_has_type_l_tors : Prop
finiteEtaleCoveringDiagrams : Prop
profiniteGroupOpenImmersions : Prop
```

The parameter `curveModuli : ThetaCurveModuliData Fmod F` is intentional. It
forces the `C_K` data to be attached to the specific `C_F` produced from
`X_F`, instead of merely sharing the same ambient field names.

The individual geometric conditions remain explicit propositions, since we
still do not have formal hyperbolic orbicurve categories, stack-theoretic
quotients, or profinite fundamental group diagrams in place.

### Lean Declarations

```text
ThetaOrbicurveCoverData
ThetaOrbicurveCoverData.cKType
ThetaOrbicurveCoverData.cKCoreBaseChange
ThetaOrbicurveCoverData.cKDeterminedByCF
ThetaOrbicurveCoverData.xKType
ThetaOrbicurveCoverData.finiteEtaleDiagrams
ThetaOrbicurveCoverData.openImmersions
InitialThetaData.cKType
InitialThetaData.cKCoreBaseChange
InitialThetaData.cKDeterminedByCF
InitialThetaData.xKType
InitialThetaData.finiteEtaleCoveringDiagrams
InitialThetaData.profiniteGroupOpenImmersions
```

### What This Tests

The example file now verifies:

* construction of the `C_K`/`X_K` cover bundle over the existing curve/moduli
  data;
* construction of `InitialThetaData` using the cover bundle;
* projection of the type, base-change, determination, finite-etale diagram,
  and open-immersion obligations.

### Design Trap Avoided

The trap would be to treat `C_K` as just another independent label. The new
record forces the formal data to remember that `C_K` is supposed to be built
from `C_F` by base change and then used to recover `X_K` and the covering
diagrams. This gives later local and cusp conditions the correct geometric
target.

### Next Step

The next Definition 3.1 step should refine the local valuation clauses in
(e): base-changing curves to `K_v`, separating `Vnon`, `Varc`, `Vgood`, and
`Vbad`, and recording the bad-local type `(1, Z/lZ)^±` for `C_v`.

## Math Milestone 19: Bad Local Finite-Place Data

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(e) says that for each `v ∈ V(K)` one base-changes the
orbicurves over `F` or `K` to `K_v`. It then records local cartesian diagrams,
outer surjections to decomposition groups, and, at `v ∈ Vbad`, the condition
that `C_v` has type `(1, Z/lZ)^±`. For bad places it also says that extracting
an `l`-th root of the theta function gives local models over `K_v` of types
`(1,(Z/lZ)_Theta)` and `(1,(Z/lZ)_Theta)^±`, with corresponding open subgroup
inclusions.

### Lean/API Check

For finite places, mathlib gives an actual local completion:

```text
v.maximalIdeal.adicCompletion K
```

for `v : NumberField.FinitePlace K`, and Lean can synthesize a field instance
for this completion. This lets the local curve placeholders be typed over the
correct local field rather than over an arbitrary label.

Definition 3.1(e) also distinguishes `Varc`. That requires archimedean places,
and mathlib has `NumberField.InfinitePlace`. This milestone does not yet build
the finite-or-infinite union type for all of `V(K)`; it formalizes the bad
nonarchimedean part, which is the part directly used by `Vbad`.

### Lean Decisions

The new record is:

```text
ThetaBadLocalData l Fmod F K curveModuli coverData valuations
```

It contains local `X` and `C` placeholders over the actual adic completion:

```text
localX :
  (v : NumberField.FinitePlace K) -> v in valuations.selected ->
    HyperbolicOrbicurveModel (v.maximalIdeal.adicCompletion K)

localC :
  (v : NumberField.FinitePlace K) -> v in valuations.selected ->
    HyperbolicOrbicurveModel (v.maximalIdeal.adicCompletion K)
```

It also records the source obligations:

```text
localBaseChangeDiagrams
decompositionGroupOuterSurjection
badLocalType
thetaRootLocalModels
badLocalOpenSubgroups
```

`InitialThetaData` now includes this bad-local bundle, so bad local statements
are no longer detached from the chosen finite-place section.

### Lean Declarations

```text
ThetaBadLocalData
ThetaBadLocalData.baseChangeDiagrams
ThetaBadLocalData.decompositionSurjection
ThetaBadLocalData.badType
ThetaBadLocalData.thetaRootModels
ThetaBadLocalData.openSubgroups
InitialThetaData.localBaseChangeDiagrams
InitialThetaData.decompositionGroupOuterSurjection
InitialThetaData.badLocalType
InitialThetaData.thetaRootLocalModels
InitialThetaData.badLocalOpenSubgroups
```

### What This Tests

The example file now verifies:

* construction of local data over `v.maximalIdeal.adicCompletion K`;
* construction of initial theta data using the bad-local bundle;
* projection of local base-change diagrams, decomposition group surjections,
  bad local type, theta-root local models, and bad local open subgroup
  obligations.

### Design Trap Avoided

The trap would be to state local `K_v` facts without a local field in the type.
The local placeholders now live over mathlib's completion attached to the
finite place `v`. This is still not a full construction of the local
orbicurves, but it prevents a later proof from silently using data over the
wrong field.

### Next Step

The next local milestone should add the archimedean side explicitly by defining
a controlled finite/infinite place wrapper for selected places, using
`NumberField.FinitePlace` and `NumberField.InfinitePlace`, and then recovering
`Vnon`, `Varc`, `Vgood`, and `Vbad` as typed subsets.

## Math Milestone 20: Finite and Infinite Selected Places

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(e) says that `V ⊆ V(K)` induces a natural bijection
`V -> Vmod`, equivalently a section of the natural surjection from places of
`K` to `Vmod`. It then introduces the four derived pieces:

```text
Vnon, Varc, Vgood, Vbad
```

The source also says that the subscript `v` denotes base-change to `K_v`.
This is why the previous milestone used finite-place completions for the local
nonarchimedean side, while this milestone first makes the finite/archimedean
split visible at the level of selected places.

### Lean/API Check

Mathlib supplies separate APIs for the two classes of places:

```text
NumberField.FinitePlace K
NumberField.InfinitePlace K
```

The finite-place API also supplies the local completion used in the previous
milestone:

```text
v.maximalIdeal.adicCompletion K
```

The infinite-place API includes predicates such as `IsReal` and `IsComplex`.
We do not use those predicates yet, but importing the API now means the
archimedean branch is represented by actual mathlib infinite places rather
than by a string or an untyped label.

### Lean Decisions

The formalization now introduces:

```text
ThetaPlace K
```

with constructors:

```text
ThetaPlace.finite   : NumberField.FinitePlace K -> ThetaPlace K
ThetaPlace.infinite : NumberField.InfinitePlace K -> ThetaPlace K
```

`ThetaValuationData` now has both a finite and an infinite chosen section:

```text
chosenLift         : NumberField.FinitePlace Fmod -> NumberField.FinitePlace K
chosenInfiniteLift : NumberField.InfinitePlace Fmod -> NumberField.InfinitePlace K
```

and corresponding maps back down to `Fmod`, with section identities. This
matches the source requirement that the selected set `V` maps bijectively to
the moduli-level places, while keeping finite and infinite places separate
enough that Lean cannot confuse bad finite places with archimedean places.

### Lean Declarations

```text
ThetaPlace
ThetaPlace.IsFinite
ThetaPlace.IsInfinite
ThetaValuationData.selectedInfinite
ThetaValuationData.selectedPlaces
ThetaValuationData.vnon
ThetaValuationData.varc
ThetaValuationData.vbad
ThetaValuationData.vgood
ThetaValuationData.finite_mem_vnon_iff
ThetaValuationData.infinite_mem_varc_iff
ThetaValuationData.finite_mem_vbad_iff
ThetaValuationData.finite_mem_vgood_iff
InitialThetaData.finitePlace_mem_vnon_iff
InitialThetaData.infinitePlace_mem_varc_iff
InitialThetaData.finitePlace_mem_vbad_iff
InitialThetaData.finitePlace_mem_vgood_iff
```

### What This Tests

The example file now checks that:

* valuation data can be constructed with both finite and infinite sections;
* a finite selected place belongs to `Vnon` exactly when it belongs to the
  selected finite section;
* an infinite selected place belongs to `Varc` exactly when it belongs to the
  selected infinite section;
* `Vbad` and `Vgood` are finite-place subsets, as required by the use of
  bad/good nonarchimedean reduction.

### Design Trap Avoided

The trap would be to model all places as a single opaque type and then add
predicates for "finite", "infinite", "bad", and "good" afterward. That would
make it easy to accidentally state a bad-reduction condition at an
archimedean place. The sum type `ThetaPlace` keeps the source notation
`V ⊆ V(K)` available while preserving Lean's separate finite and infinite
place APIs.

### Remaining Gap

This does not yet construct archimedean local analytic objects. It only gives
the formal selected-place split needed before the later prime-strip and
Frobenioid layers can distinguish `Vnon` from `Varc`.

## Math Milestone 21: Local Cusp Data at Bad Places

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(f) says that `epsilon` is a cusp of `C_K` arising from a
nonzero element of the quotient `Q` in the definition of a hyperbolic
orbicurve of type `(1, l-tors)^±`. It then defines, for `v ∈ V`, a local cusp
`epsilon_v` of `C_v` determined by `epsilon`. At `v ∈ Vbad`, it imposes the
stronger condition that `epsilon_v` arises from the canonical generator, up to
sign, of the local quotient `Z` in the type `(1, Z/lZ)^±` model.

### Lean/API Check

There is no mathlib API for Mochizuki's EtTh quotient `Q`, the local quotient
`Z`, or hyperbolic orbicurves of types `(1, l-tors)^±` and `(1, Z/lZ)^±`.
Therefore the correct current move is not to invent these objects. We keep
the quotient-origin and canonical-generator clauses as named propositions,
but attach them to the already typed global and local orbicurve placeholders.

### Lean Decisions

The existing `CuspData` now represents either a global or local cusp of a
specific `HyperbolicOrbicurveModel`. The new record is:

```text
ThetaCuspLocalData
```

It depends on the actual cover data, valuation data, bad-local data, and
global cusp:

```text
coverData
valuations
badLocalData
epsilon
```

It provides:

```text
localCusp :
  (v : NumberField.FinitePlace K) -> v in valuations.selected ->
    CuspData (badLocalData.localC v hv)

badLocalCuspCanonicalGenerator :
  (v : NumberField.FinitePlace K) -> v in valuations.bad -> Prop
```

This means the local cusp `epsilon_v` is attached to the local curve `C_v`
over the actual finite-place completion, and the bad-place canonical-generator
condition can only be stated at a proof of `v ∈ Vbad`.

### Lean Declarations

```text
ThetaCuspLocalData
ThetaCuspLocalData.badLocalCusp
ThetaCuspLocalData.localCuspDeterminedByGlobal
ThetaCuspLocalData.localCuspArisesFromNonzeroQuotientElement
ThetaCuspLocalData.badLocalCuspArisesFromCanonicalGenerator
InitialThetaData.cuspLocalData
InitialThetaData.localCusp
InitialThetaData.badLocalCusp
InitialThetaData.localCuspDeterminedByGlobal
InitialThetaData.localCusp_arisesFromNonzeroQuotientElement
InitialThetaData.badLocalCusp_arisesFromCanonicalGenerator
```

### What This Tests

The example file now checks:

* construction of `ThetaCuspLocalData`;
* projection of the local-cusp-is-determined-by-global-cusp obligation;
* projection that each selected finite local cusp arises from a nonzero
  quotient element;
* projection of the bad-place canonical-generator-up-to-sign condition.

### Design Trap Avoided

The trap would be to keep only a global cusp and later talk about local cusps
informally. The new record forces every local cusp statement to pass through
the selected finite place and the already constructed `C_v`. It also prevents
the bad-place canonical-generator condition from being applied without a proof
that the place is in `Vbad`.

### Remaining Gap

This still treats the EtTh quotient objects as named obligations. A later
milestone should introduce a typed skeleton for the relevant orbicurve type
data and quotient labels so that "nonzero quotient element" and "canonical
generator up to sign" become structured data rather than opaque propositions.

## Math Milestone 22: Orbicurve Type and Quotient Witness Skeleton

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(d) says that `C_K` is a hyperbolic orbicurve of type
`(1,l-tors)^±`, that it determines `X_K` of type `(1,l-tors)`, and that the
associated covering diagrams and open immersions come from this setup. The
same definition, in (e), says that for `v ∈ Vbad`, `C_v` has type
`(1,Z/lZ)^±`, and that extracting an `l`-th root of the theta function gives
local models of types `(1,(Z/lZ)_Theta)` and `(1,(Z/lZ)_Theta)^±`.

Definition 3.1(f) says that the global cusp `epsilon` arises from a nonzero
element of the quotient `Q` in the EtTh type `(1,l-tors)^±`, and that at bad
places `epsilon_v` arises from the canonical generator, up to sign, of the
local quotient `Z` in the type `(1,Z/lZ)^±`.

I also downloaded Mochizuki's official EtTh PDF from the Kyoto page to check
the referenced definitions directly, but local extraction via `pdftotext`
failed because the installed binary is linked against a missing `libzstd`
library. For this milestone, the formal move is therefore based on the
explicit quotations of EtTh Definition 2.1 and Definition 2.5 inside IUT I,
Definition 3.1(d)-(f), not on an independently extracted EtTh passage.

### Lean/API Check

Mathlib does not have hyperbolic orbicurves, EtTh quotient `Q`, local quotient
`Z`, or the specific orbicurve type labels used here. We therefore introduce a
typed skeleton that keeps these labels and witnesses explicit without
asserting a construction that is not yet formalized.

### Lean Decisions

The new type label enumeration is:

```text
OrbicurveTypeKind.oneLTors
OrbicurveTypeKind.oneLTorsPM
OrbicurveTypeKind.oneLTorsTheta
OrbicurveTypeKind.oneLTorsThetaPM
OrbicurveTypeKind.oneZModLPM
OrbicurveTypeKind.oneZModLTheta
OrbicurveTypeKind.oneZModLThetaPM
```

The formal type assertion is:

```text
OrbicurveTypeData l C kind
```

This still contains a named proposition, but it is no longer an untyped field
such as `cK_has_type_l_tors_pm`; the expected EtTh type label is now part of
the Lean type.

The quotient-origin records are:

```text
NonzeroQuotientElement
CanonicalGeneratorUpToSignElement
```

`CuspData` now contains an actual `NonzeroQuotientElement` witness. The local
bad-place cusp data now contains a `CanonicalGeneratorUpToSignElement`
witness instead of a bare proposition.

### Lean Declarations

```text
OrbicurveTypeKind
OrbicurveTypeData
OrbicurveTypeData.holds
NonzeroQuotientElement
CanonicalGeneratorUpToSignElement
CuspData.quotientOrigin
CuspData.arisesFromNonzeroQuotientElement
CuspData.arisesFromNonzeroQuotientElement_holds
ThetaOrbicurveCoverData.cK_type
ThetaOrbicurveCoverData.xK_type
ThetaBadLocalData.badLocalCType
ThetaBadLocalData.thetaRootLocalXType
ThetaBadLocalData.thetaRootLocalCType
ThetaBadLocalData.thetaRootXType
ThetaBadLocalData.thetaRootCType
ThetaCuspLocalData.badLocalCanonicalGenerator
```

### What This Tests

The example file now checks:

* construction and projection of `OrbicurveTypeData`;
* construction and projection of nonzero quotient witnesses;
* construction and projection of canonical-generator-up-to-sign witnesses;
* construction of cover data whose `C_K` and `X_K` type labels are encoded in
  the Lean type;
* construction of bad local data whose bad local `C_v` and theta-root local
  models carry the expected EtTh type labels;
* projection of the global and local cusp quotient conditions.

### Design Trap Avoided

The trap would be to leave source phrases such as `(1,l-tors)^±` and
`(1,Z/lZ)^±` as English embedded in proposition names. The current encoding
still postpones the full EtTh construction, but the source type labels now
constrain the Lean objects. For example, the theorem for `C_K` proves the
type-data field with kind `oneLTorsPM`, while the local bad-place theorem for
`C_v` proves the type-data field with kind `oneZModLPM`.

### Remaining Gap

The skeleton does not yet define hyperbolic orbicurves, quotient `Q`, quotient
`Z`, or the group action/sign orbit behind "up to sign". A later milestone
should refine `NonzeroQuotientElement` and `CanonicalGeneratorUpToSignElement`
into quotient structures with the relevant torsor and sign-action data.

## Math Milestone 23: Pointed Quotients and Sign-Orbit Data

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(f) distinguishes two quotient-origin statements:

```text
epsilon arises from a nonzero element of the quotient Q
epsilon_v at v in Vbad arises from the canonical generator up to sign of Z
```

Later in IUT I, in the discussion of label classes of cusps, the nonzero cusp
condition is again described as arising from a nonzero element of the quotient
`Q`, and the resulting `LabCusp` set is said to carry a natural `F_l`-torsor
structure arising from the `F_l^×`-action on `Q`.

IUT III also warns that canonical generators can be available only up to a
unit indeterminacy. This is not the same statement as Definition 3.1(f), but it
supports a conservative design principle: "canonical generator up to sign"
should not be collapsed to ordinary equality with a chosen generator.

### Lean Decisions

The previous milestone had quotient witnesses, but the local bad-place
condition still stored "canonical generator up to sign" as an opaque
proposition inside the witness. This milestone refines that into explicit
quotient/action data.

The shared quotient skeleton is:

```text
PointedEtaleQuotient
```

with a carrier and a distinguished zero element. The global nonzero quotient
witness now uses:

```text
QuotientUnitActionData
NonzeroQuotientElement
```

`QuotientUnitActionData` records an abstract unit type, an action on the
quotient carrier, and preservation of nonzero elements. This is intentionally
weaker than a full `F_l^×` group action, but it is strong enough to keep the
source distinction between zero and nonzero quotient elements and to reserve
space for the later `F_l`-torsor layer.

The local bad-place sign condition now uses:

```text
QuotientSignAction
QuotientSignAction.InSignOrbit
CanonicalGeneratorUpToSignElement
```

`InSignOrbit x generator` means `x = generator` or `x = -generator` for the
chosen sign action. Thus the Lean code no longer treats "up to sign" as a
name for an arbitrary proposition.

### Lean Declarations

```text
PointedEtaleQuotient
QuotientUnitActionData
QuotientSignAction
QuotientSignAction.InSignOrbit
QuotientSignAction.generator_mem_signOrbit
QuotientSignAction.neg_generator_mem_signOrbit
NonzeroQuotientElement.quotient
NonzeroQuotientElement.unitAction
CanonicalGeneratorUpToSignElement.quotient
CanonicalGeneratorUpToSignElement.signAction
CanonicalGeneratorUpToSignElement.canonicalGenerator
CanonicalGeneratorUpToSignElement.element_in_signOrbit
CanonicalGeneratorUpToSignElement.canonicalGeneratorUpToSign
CanonicalGeneratorUpToSignElement.canonicalGeneratorUpToSign_holds
```

### What This Tests

The example file now checks:

* construction of a pointed quotient;
* construction of unit-action data preserving nonzero quotient elements;
* construction of a nonzero quotient element using that action data;
* construction of a sign action with involution law;
* direct membership of a generator and its negative in the sign orbit;
* construction and projection of a canonical-generator-up-to-sign witness.

### Design Trap Avoided

The trap would be to encode "up to sign" as a bare proposition and later use it
as if it were equality. The new `InSignOrbit` predicate makes the indeterminacy
visible in the type of the local canonical-generator witness.

### Remaining Gap

The unit action is not yet a full formal `F_l^×` action, and the sign action is
not yet proved to arise from the subgroup `{±1} ⊆ F_l^×`. A later milestone
should connect the prime `l`, finite-field units, and the sign subgroup using
mathlib's finite-field/group-action APIs.

## Math Milestone 24: The `ZMod l` Unit-Action Bridge

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(f) uses the quotient `Q` from the EtTh definition of a
hyperbolic orbicurve of type `(1,l-tors)^±`, and the local quotient `Z` from
the type `(1,Z/lZ)^±` model at bad places. Later in IUT I, the label classes
of cusps are said to have a natural `F_l`-torsor structure arising from the
natural action of `F_l^×` on the quotient `Q`.

This milestone addresses that `F_l^×` phrase directly at the Lean level.

### Lean/API Check

Mathlib provides:

```text
ZMod n
(ZMod n)^x
```

where `(ZMod n)^x` is the bundled unit group of the commutative ring
`ZMod n`. We use `ZMod l.value` as the current formal model of `F_l`. The
fact that `l >= 5` gives `1 < l.value`, which supplies the nontriviality
needed to prove that `1 : ZMod l.value` is nonzero.

### Lean Decisions

The new pointed quotient is:

```text
zmodPointedQuotient l
```

with carrier `ZMod l.value` and zero `0`.

The new unit action is:

```text
zmodUnitActionData l
```

whose units are `(ZMod l.value)^x`, acting by multiplication on
`ZMod l.value`. The action preserves nonzero elements by multiplying a
zero equation by the inverse unit.

The sign action is:

```text
zmodSignAction l
```

defined by additive negation on `ZMod l.value`, with involutivity checked by
Lean.

Finally, two concrete quotient witnesses are available:

```text
zmodOneNonzeroQuotientElement l
zmodCanonicalGeneratorUpToSignElement l
```

The first packages `1 : ZMod l.value` as a nonzero quotient element. The
second packages `1 : ZMod l.value` as the canonical generator modulo the
sign orbit.

### Lean Declarations

```text
zmodPointedQuotient
zmodUnitActionData
zmodSignAction
zmodOneNonzeroQuotientElement
zmodCanonicalGeneratorUpToSignElement
```

### What This Tests

The example file now checks:

* `1 : ZMod 5` is nonzero via `PrimeGeFive`;
* multiplication by a unit of `ZMod 5` preserves nonzero elements;
* `-1` lies in the sign orbit of `1`;
* the concrete `ZMod 5` canonical-generator witness proves
  `canonicalGeneratorUpToSign`.

### Design Trap Avoided

The trap would be to keep saying "`F_l^×` action" while the formal code only
uses an arbitrary type of units. This milestone does not yet build all the
torsor theory, but it pins the unit group to the actual mathlib object
`(ZMod l.value)^x`.

### Remaining Gap

The sign action is still a separate `QuotientSignAction`; it is not yet
constructed as the restriction of the `(ZMod l.value)^x` action along the
subgroup `{±1}`. The next refinement should introduce that compatibility
between unit action and sign action.

## Math Milestone 25: Sign as the Minus-One Unit

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(f), describes the bad local `epsilon_v` data as arising
from a canonical generator of the relevant local quotient, with an unavoidable
`±1` indeterminacy. The later discussion of cusp labels says that the label
classes inherit an `F_l`-torsor structure from the natural `F_l^×` action on
the quotient `Q`.

This means the formal sign operation should not remain merely an independent
involution forever. At the first concrete quotient model, it should be tied to
the same unit action that models the `F_l^×` action.

### Lean/API Check

Mathlib's bundled units accept:

```text
(-1 : (ZMod n)^x)
```

and Lean proves by simplification that multiplication by this unit on
`ZMod n` is additive negation:

```text
((-1 : (ZMod n)^x) : ZMod n) * x = -x
```

The concrete compatibility for our quotient model therefore needs no custom
finite-field lemma at this stage.

### Lean Decisions

The new structure is:

```text
QuotientSignUnitCompatibility
```

It packages:

* a distinguished unit `signUnit`;
* a proof that acting by `signUnit` is the same operation as the sign action.

For the current `ZMod l` quotient model, the distinguished unit is:

```text
(-1 : (ZMod l.value)^x)
```

and the proof is:

```text
zmodSignUnitCompatibility l
```

This keeps the current abstraction honest: the sign orbit used for canonical
generators is now visibly compatible with the unit action used for the
`F_l^×`-language.

### Lean Declarations

```text
QuotientSignUnitCompatibility
zmodSignUnitCompatibility
abstractQuotientSignUnitCompatibility
```

### What This Tests

The example file now checks:

* the generic constructor and projection for sign/unit compatibility;
* in `ZMod 5`, acting by the distinguished sign unit is exactly the sign
  operation.

### Design Trap Avoided

The trap would be to let the `±1` language and the `F_l^×` language evolve in
parallel as unrelated APIs. This milestone forces their first intersection:
in the concrete finite-quotient model, `-1` as a unit is the sign operation.

### Remaining Gap

We still have not formalized the subgroup `{±1} ⊆ (ZMod l)^x`, nor the full
torsor structure on nonzero quotient elements. This milestone only proves the
specific compatibility needed before that subgroup/torsor layer can be added
cleanly.

## Math Milestone 26: The `{1,-1}` Unit Subgroup and Sign Orbits

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(f), says that at bad places the cusp `epsilon_v` comes
from the canonical generator, up to sign `±1`, of the local quotient `Z`.

IUT I, Definition 4.1(ii), says that `LabCusp` has a natural `F_l`-torsor
structure arising from the natural action of `F_l^×` on the quotient `Q`.
The later `LabCusp±` discussion states that the corresponding `±`-canonical
element is well-defined up to multiplication by `±1`, and explicitly relates
`LabCusp± \ {zero} / {±1}` to `LabCusp`.

The formal step below keeps these two source phrases connected: "up to sign"
is now the orbit under the concrete two-element unit subgroup, not merely an
uninterpreted involution.

### Lean/API Check

Mathlib's `Subgroup` works directly for the bundled unit group
`(ZMod l.value)^x`. The subgroup closure conditions for `{1,-1}` are discharged
by case analysis and `simp`:

```text
1 * 1 = 1
1 * (-1) = -1
(-1) * 1 = -1
(-1) * (-1) = 1
```

### Lean Decisions

The new subgroup is:

```text
zmodSignUnitSubgroup l : Subgroup (ZMod l.value)^x
```

with membership characterized by:

```text
a in zmodSignUnitSubgroup l <-> a = 1 or a = -1
```

The main bridge theorem is:

```text
zmodSignUnitSubgroup_orbit_iff_signOrbit
```

It proves that the orbit of a generator under the `{1,-1}` unit subgroup is
equivalent to the existing `QuotientSignAction.InSignOrbit` predicate.

### Lean Declarations

```text
zmodSignUnitSubgroup
mem_zmodSignUnitSubgroup_iff
one_mem_zmodSignUnitSubgroup
neg_one_mem_zmodSignUnitSubgroup
zmodSignUnitSubgroup_smul_eq_self_or_neg
zmodSignUnitSubgroup_orbit_iff_signOrbit
```

### What This Tests

The example file now checks:

* `-1` belongs to the sign unit subgroup;
* every subgroup action is either the identity action or the sign action;
* subgroup-orbit membership is equivalent to the sign-orbit predicate.

### Design Trap Avoided

The trap would be to talk about quotienting by `{±1}` while the formal orbit
condition still only mentioned a separately defined sign action. This milestone
forces the quotient-orbit language to pass through the unit action on `ZMod l`.

### Remaining Gap

The subgroup orbit is now formal, but the full `LabCusp±` structure is not.
The next mathematical step should introduce a small typed model of pointed
`F_l`-label data with a zero element, a nonzero/sign quotient, and the projection
from `±`-labels to ordinary cusp labels.

## Math Milestone 27: Nonzero Labels Modulo Sign

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

The relevant source passage is the `LabCusp±` discussion in IUT I, Definition
6.1(iii). It says that `LabCusp±` has a zero element and a `±`-canonical
element well-defined up to multiplication by `±1`, and gives a natural
bijection of the form:

```text
LabCusp± \ {zero} / {±1} -> LabCusp
```

This is the same sign ambiguity that appears earlier in Definition 3.1(f) for
the bad local canonical generator, and it is compatible with the `F_l^×` action
language from Definition 4.1(ii).

### Lean/API Check

Lean's `Setoid` and `Quotient` are the right primitive tools for this stage:
they let us state that two nonzero labels represent the same ordinary label
class exactly when they differ by the sign action. No choice of representative
is required.

### Lean Decisions

The new nonzero carrier is:

```text
PointedEtaleQuotient.NonzeroCarrier Q
```

For any `QuotientSignAction`, we define:

```text
NonzeroSignRel
nonzeroSignSetoid
SignLabelQuotient
toSignLabelQuotient
```

The relation is:

```text
x ~ y  iff  x = y or x = sign(y)
```

Lean proves reflexivity, symmetry, and transitivity using the sign involution.
The quotient projection then proves:

```text
toSignLabelQuotient (negNonzero x) =
toSignLabelQuotient x
```

For the concrete finite model, the canonical class is:

```text
zmodCanonicalSignLabelQuotient l
```

represented by the nonzero label `1 : ZMod l.value`.

### Lean Declarations

```text
PointedEtaleQuotient.NonzeroCarrier
QuotientSignAction.neg_ne_zero
QuotientSignAction.negNonzero
QuotientSignAction.NonzeroSignRel
QuotientSignAction.nonzeroSignSetoid
QuotientSignAction.SignLabelQuotient
QuotientSignAction.toSignLabelQuotient
QuotientSignAction.toSignLabelQuotient_eq_of_rel
QuotientSignAction.toSignLabelQuotient_neg_eq
zmodOneNonzeroLabel
zmodCanonicalSignLabelQuotient
zmodCanonicalSignLabelQuotient_neg_one_eq
```

### What This Tests

The example file now checks:

* the abstract quotient projection identifies a nonzero label with its negative;
* the concrete `ZMod 5` canonical sign-label quotient exists;
* the `ZMod 5` class of `1` is equal to the class of `-1`.

### Design Trap Avoided

The trap would be to model "modulo `±1`" by choosing either `+1` or `-1` as a
canonical representative. The source says the object is well-defined only up to
that ambiguity. The Lean quotient preserves the ambiguity instead of erasing it.

### Remaining Gap

This still does not construct the full `F_l`-torsor or `F_l^×`-action on actual
cusp labels. It gives the quotient-theoretic target needed for that construction:
nonzero `±` labels can now be projected to sign classes without choosing a sign.

## Math Milestone 28: Unit Action Descends to Sign Labels

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 4.1(ii), says that `LabCusp` carries a natural `F_l`-torsor
structure arising from the natural action of `F_l^×` on the quotient `Q`.
The `LabCusp±` passage in Definition 6.1(iii) says that `LabCusp±` admits a
natural action by `F_l^×`, while the comparison to ordinary `LabCusp` passes
through the quotient of nonzero `±`-labels by `{±1}`.

The formal question at this stage is therefore: does the concrete unit action on
`ZMod l` respect the sign relation strongly enough to descend to the sign-label
quotient? Lean now checks that it does.

### Lean/API Check

Lean's `Quotient.map` is the right tool for descending an operation to a
quotient. It requires exactly the well-definedness proof we want:

```text
x ~ y -> a*x ~ a*y
```

For `ZMod l`, this follows by cases on the sign relation and by the ring identity
`a * (-y) = -(a * y)`.

### Lean Decisions

The nonzero unit action is:

```text
zmodUnitSmulNonzeroLabel
```

It sends a nonzero label to another nonzero label using the existing proof that
unit multiplication preserves nonzero elements.

The descended action on sign-label quotients is:

```text
zmodUnitActionOnSignLabelQuotient
```

Its action laws are exposed as named theorems:

```text
zmodUnitActionOnSignLabelQuotient_one
zmodUnitActionOnSignLabelQuotient_mul
```

Finally, since the quotient already identifies `x` with `-x`, Lean proves:

```text
zmodUnitActionOnSignLabelQuotient_neg_one
zmodSignUnitSubgroup_action_trivial_on_signLabelQuotient
```

So the `{1,-1}` subgroup acts trivially after passing to ordinary sign-label
classes.

### Lean Declarations

```text
zmodUnitSmulNonzeroLabel
zmodUnitSmulNonzeroLabel_respects_sign
zmodUnitActionOnSignLabelQuotient
zmodUnitActionOnSignLabelQuotient_apply
zmodUnitActionOnSignLabelQuotient_one
zmodUnitActionOnSignLabelQuotient_mul
zmodUnitActionOnSignLabelQuotient_neg_one
zmodSignUnitSubgroup_action_trivial_on_signLabelQuotient
```

### What This Tests

The example file now checks:

* application of the descended unit action to a representative;
* the identity and multiplication laws for the descended action;
* multiplication by `-1` is trivial on the sign quotient;
* every element of the `{1,-1}` subgroup acts trivially on the sign quotient.

### Design Trap Avoided

The trap would be to assume that an action on representatives automatically
defines an action on quotient labels. It only does so after proving compatibility
with the quotient relation. This milestone makes that compatibility an explicit
Lean theorem.

### Remaining Gap

We now have the `F_l^×`-style action on sign-label quotients, but not the
additive `F_l`-torsor structure of `LabCusp`. The next step should add the
concrete simply transitive translation model on `ZMod l` labels, then relate its
nonzero/sign quotient to the current multiplicative-unit action.

## Math Milestone 29: Additive `F_l` Label Torsor

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 4.1(ii), states that for each `v`, `LabCusp(D_v)` admits a
natural `F_l`-torsor structure. Proposition 4.2 then says that the canonical
element and this `F_l`-torsor structure determine a natural bijection
`LabCusp(D) -> F_l`.

The earlier milestones modeled the multiplicative `F_l^×` action on the
quotient side. This milestone adds the additive torsor side in the simplest
concrete finite model.

### Lean/API Check

The only algebraic fact needed is simple transitivity of translation on
`ZMod l`:

```text
for all x y, there exists a unique t such that t + x = y
```

Lean proves this with the witness `y - x`.

### Lean Decisions

The new lightweight interface is:

```text
AdditiveTorsorData G X
```

It records:

* an additive action `vadd`;
* the zero-translation law;
* the addition/translation law;
* unique existence of a translation carrying any point to any other point.

The concrete label torsor is:

```text
zmodLabelAdditiveTorsorData l
```

with translation:

```text
zmodLabelTranslate l t x = t + x
```

The coordinate relative to the zero/canonical base label is:

```text
zmodLabelCoordinateFromZero l x = x
```

with a specification and uniqueness theorem.

### Lean Declarations

```text
AdditiveTorsorData
zmodLabelAdditiveTorsorData
zmodLabelTranslate
zmodLabelTranslate_eq_add
zmodLabelTranslate_zero
zmodLabelTranslate_add
zmodLabelTranslate_existsUnique
zmodLabelCoordinateFromZero
zmodLabelCoordinateFromZero_spec
zmodLabelCoordinateFromZero_unique
```

### What This Tests

The example file now checks:

* zero translation fixes labels;
* successive translations compose by addition;
* a unique translation carries any label to any other label;
* the coordinate from the zero base label is characterized by its translation
  property.

### Design Trap Avoided

The trap would be to say "`LabCusp` is an `F_l`-torsor" while only formalizing
the multiplicative unit action. This milestone separates the additive torsor
structure from the multiplicative action and verifies the torsor condition
directly in the `ZMod l` model.

### Remaining Gap

The current torsor is a concrete finite-label model, not a reconstruction of
actual cusp labels from orbicurves. The next step should connect the additive
torsor coordinates with the sign-label quotient and the distinguished
canonical-generator class.

## Math Milestone 30: Coordinates to Sign-Label Classes

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Proposition 4.2 says that a canonical element together with the natural
`F_l`-torsor structure determines a natural bijection from label classes to
`F_l`. IUT I, Definition 6.1(iii), says that the `±`-label version is
well-defined up to multiplication by `±1` and compares to ordinary label classes
through the quotient of nonzero `±`-labels by `{±1}`.

This milestone connects these two pieces in the concrete `ZMod l` model: a
nonzero additive coordinate gives a nonzero label by translation from the base
label, and then maps to a sign-label class.

### Lean/API Check

The needed Lean facts are elementary:

```text
t != 0 -> -t != 0
zmodLabelTranslate l t 0 = t
```

The sign quotient then identifies the coordinate `t` with `-t`.

### Lean Decisions

The new coordinate-to-label construction is:

```text
zmodNonzeroLabelFromCoordinate l t ht
```

where `ht : t != 0`. Its value is obtained by translating the base label `0`
by `t`.

The sign-label class of a nonzero coordinate is:

```text
zmodSignLabelFromCoordinate l t ht
```

Lean proves:

```text
zmodSignLabelFromCoordinate l (-t) ... =
zmodSignLabelFromCoordinate l t ht
```

and identifies coordinate `1` with the previously defined canonical sign-label
class.

### Lean Declarations

```text
zmod_neg_ne_zero_of_ne_zero
zmodNonzeroLabelFromCoordinate
zmodNonzeroLabelFromCoordinate_val
zmodSignLabelFromCoordinate
zmodSignLabelFromCoordinate_neg_eq
zmodSignLabelFromCoordinate_one_eq_canonical
```

### What This Tests

The example file now checks:

* translating the base label by a nonzero coordinate yields that coordinate;
* opposite nonzero coordinates have the same sign-label class;
* coordinate `1` recovers the canonical sign-label class.

### Design Trap Avoided

The trap would be to conflate additive torsor coordinates with multiplicative
sign ambiguity. This milestone keeps the operations separate: coordinates are
additive translations, while sign ambiguity is imposed only after passing to the
nonzero sign quotient.

### Remaining Gap

The bridge is still concrete and local to `ZMod l`. The next step should package
the ordinary label coordinate, sign-label class, unit action, and additive
torsor as one local `LabCusp` model so that bad-place cusp data can refer to a
single structured object instead of separate helper declarations.

## Math Milestone 31: Local `LabCusp` Model Package

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 4.1(ii), treats `LabCusp` as a structured label-class object:
it has a canonical element, an `F_l`-torsor structure, and arises from the
quotient `Q`. Definition 3.1(f) and Definition 6.1(iii) add the nonzero quotient
origin and the canonical-generator-up-to-sign condition.

The previous milestones built these ingredients separately. This milestone
packages them so later local cusp data can point to one object instead of a
loose collection of helper declarations.

### Lean/API Check

The package is a dependent record whose later fields refer to earlier fields:
the sign-label quotient depends on the selected sign action, and the canonical
nonzero label depends on the selected pointed quotient. Lean handles this
directly with ordinary structure fields.

### Lean Decisions

The new record is:

```text
LocalLabCuspModel l
```

It contains:

* the pointed label quotient;
* the unit action;
* the sign action and sign/unit compatibility;
* the additive `ZMod l` torsor;
* a canonical coordinate;
* a canonical nonzero label;
* the corresponding sign-label class.

It also provides two conversion functions:

```text
LocalLabCuspModel.canonicalNonzeroQuotientElement
LocalLabCuspModel.canonicalGeneratorUpToSignElement
```

These are exactly the witness types already used by `CuspData` and
`ThetaCuspLocalData`.

The concrete finite model is:

```text
zmodLocalLabCuspModel l
```

with canonical coordinate `1`.

### Lean Declarations

```text
LocalLabCuspModel
LocalLabCuspModel.canonicalNonzeroQuotientElement
LocalLabCuspModel.canonicalNonzeroQuotientElement_ne_zero
LocalLabCuspModel.canonicalGeneratorUpToSignElement
LocalLabCuspModel.canonicalGeneratorUpToSign
LocalLabCuspModel.canonicalLabelTranslate
LocalLabCuspModel.canonicalSignLabelEq
zmodLocalLabCuspModel
```

### What This Tests

The example file now checks:

* the concrete model has canonical coordinate `1`;
* it produces a nonzero quotient element;
* it produces a canonical-generator-up-to-sign witness;
* its canonical sign-label class is the quotient class of its canonical nonzero
  label.

### Design Trap Avoided

The trap would be to keep adding facts about labels without an object that can
be passed into the local cusp layer. The package makes the boundary explicit:
later IUT records can depend on `LocalLabCuspModel` rather than on unrelated
global declarations.

### Remaining Gap

`ThetaCuspLocalData` has not yet been upgraded to store this package at bad
places. The next step should add an optional or direct bad-place local label
model field and prove that the old nonzero/canonical-generator projections are
recovered from it.

## Math Milestone 32: Bad-Place Cusp Data Uses `LabCusp` Models

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(f), imposes the bad-place condition that the local cusp
arises from the canonical generator, up to sign, of the local quotient `Z`.
Definition 4.1(ii) and Definition 6.1(iii) describe the corresponding label
class structure, including the `F_l`-torsor and `±`-label quotient data.

The previous milestone packaged this label structure as `LocalLabCuspModel`.
This milestone connects that package to the already existing local cusp record.

### Lean/API Check

The old `ThetaCuspLocalData` API exposed:

```text
badLocalCanonicalGenerator
localCusp
```

The new fields are added compatibly rather than replacing those fields outright.
Lean then checks equalities saying the old witnesses are recovered from the new
packaged model.

### Lean Decisions

`ThetaCuspLocalData` now stores, at every bad place:

```text
badLocalLabCuspModel :
  (v : NumberField.FinitePlace K) -> v in valuations.bad ->
    LocalLabCuspModel l
```

and two compatibility fields:

```text
badLocalCusp_quotientOrigin_eq_model
badLocalCanonicalGenerator_eq_model
```

The first says that the local cusp's nonzero quotient origin is exactly the one
supplied by the local label model. The second says that the bad local
canonical-generator witness is exactly the one supplied by the same model.

### Lean Declarations

```text
ThetaCuspLocalData.badLocalLabelModel
ThetaCuspLocalData.badLocalCuspQuotientOriginEqModel
ThetaCuspLocalData.badLocalCanonicalGeneratorEqModel
ThetaCuspLocalData.badLocalModelCanonicalGeneratorUpToSign
InitialThetaData.badLocalLabCuspModel
InitialThetaData.badLocalCusp_quotientOrigin_eq_model
InitialThetaData.badLocalCanonicalGenerator_eq_model
```

### What This Tests

The example file now checks:

* construction of `ThetaCuspLocalData` with a bad-place label model;
* projection of a bad-place `LocalLabCuspModel` from full initial theta data;
* equality of the bad local cusp origin with the model's nonzero quotient
  element;
* equality of the bad local canonical-generator witness with the model witness.

### Design Trap Avoided

The trap would be to introduce `LocalLabCuspModel` but leave it detached from
the actual bad-place local cusp data. This milestone makes the attachment part
of the record, so future local-cusp arguments can cite the packaged label model
instead of reassembling quotient, sign, and torsor facts manually.

### Remaining Gap

The field is still a supplied model at each bad place, not a reconstruction
algorithm from the local orbicurve or fundamental group. A later milestone must
replace this supplied model by data derived from the EtTh type conditions.

## Math Milestone 33: Model-Derived Bad Local Cusps

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 4.1(ii), describes the canonical cusp label class as
constructed from the local object, while Definition 3.1(f) says the bad local
cusp arises from the canonical generator up to sign. After Milestone 32, the
bad-place local cusp record stored a `LocalLabCuspModel` plus compatibility
equalities. The next source-facing refinement is to let the model build the
local cusp witness itself.

### Lean/API Check

`CuspData` is a two-field structure: a string label and a nonzero quotient
origin. Lean proves equality of two `CuspData` values from equality of quotient
origins when the label is kept fixed.

### Lean Decisions

The new constructor is:

```text
LocalLabCuspModel.toCuspData
```

It builds a `CuspData C` from a local label model, a target orbicurve placeholder
`C`, and a string label.

The new equality theorem is:

```text
ThetaCuspLocalData.badLocalCuspEqModelCusp
```

It states that the existing bad local cusp is equal to the cusp built from the
bad-place local label model using the existing cusp's label.

The corresponding full initial-theta projection is:

```text
InitialThetaData.badLocalCusp_eq_modelCusp
```

### Lean Declarations

```text
CuspData.eq_of_quotientOrigin_eq
LocalLabCuspModel.toCuspData
LocalLabCuspModel.toCuspData_quotientOrigin
LocalLabCuspModel.toCuspData_arisesFromNonzeroQuotientElement
ThetaCuspLocalData.badLocalCuspEqModelCusp
InitialThetaData.badLocalCusp_eq_modelCusp
```

### What This Tests

The example file now checks:

* a concrete `zmodLocalLabCuspModel` builds a cusp arising from a nonzero
  quotient element;
* the bad local cusp in full initial theta data is exactly the model-built cusp,
  using its existing label.

### Design Trap Avoided

The trap would be to keep the local label model merely adjacent to the cusp
record. This milestone makes the cusp itself reconstructible from the model,
so future formalization can move toward replacing supplied cusp witnesses with
model-derived ones.

### Remaining Gap

The label string is still bookkeeping, not a mathematically reconstructed cusp
label. The next refinement should reduce reliance on string labels by replacing
or supplementing them with structured label-class data.

## Math Milestone 34: Structured Cusp Label Classes

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 4.1(ii), defines `LabCusp(D_v)` as a set of label classes
over the nonzero cusp associated to the quotient `Q`, equipped with the natural
`F_l`-torsor structure and a canonical element determined by `epsilon_v`.
IUT I, Definition 6.1(iii), later passes through `LabCusp^pm`, removes the zero
element, and quotients by `{pm 1}` to obtain the sign-insensitive cusp label
class. This milestone records that label class as explicit typed data rather
than letting the string label carry mathematical content.

### Lean/API Check

The preceding milestone already had a `LocalLabCuspModel` with a canonical
nonzero label and its sign-label quotient. The remaining API issue was that
`CuspData` still exposed a `String` as the only visible label. We keep the
string for human-readable bookkeeping, but attach a structured label-class
record whenever the cusp is meant to come from the local label model.

### Lean Decisions

The new record

```text
CuspLabelClassData
```

packages a local `LabCusp` model, a sign-label class, and the proof that the
class is the model's canonical sign label.

The new record

```text
ModeledCuspData
```

packages the old `CuspData` together with `CuspLabelClassData` and a proof that
the cusp is exactly the one built from the model. Its theorem
`cusp_quotientOrigin_eq_model` is the operational bridge: the visible cusp
origin is the model's canonical nonzero quotient element.

### Lean Declarations

```text
CuspLabelClassData
CuspLabelClassData.labelClass_eq_model_quotient
zmodCanonicalCuspLabelClassData
ModeledCuspData
ModeledCuspData.cusp_arisesFromNonzeroQuotientElement
ModeledCuspData.cusp_quotientOrigin_eq_model
zmodModeledCuspData
```

### What This Tests

The example file now checks:

* the concrete `ZMod l` canonical cusp-label class is the quotient of the
  canonical nonzero label;
* a modeled cusp still satisfies the nonzero-quotient origin property;
* the modeled cusp's stored quotient origin agrees with the local model.

### Design Trap Avoided

The trap would be to let the string `"epsilon"` become a stand-in for
Mochizuki's cusp-label class. The new structure makes the string explicitly
secondary: the mathematical label is the sign-label quotient attached to a
local `LabCusp` model.

### Remaining Gap

`ModeledCuspData` is not yet threaded back into `ThetaCuspLocalData`; it is a
separate refinement layer. The next step should replace or supplement the
bad-local `CuspData` field with this modeled version, so every bad local cusp
points directly to its structured label class.

## Math Milestone 35: Bad Local Cusps as Modeled Cusps

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(f), says that at bad places the local cusp `epsilon_v`
comes from the canonical generator, up to sign, of the local quotient. IUT I,
Definition 4.1(ii), identifies the corresponding `LabCusp` label class as part
of the local cusp-label package. The previous milestone built a general
`ModeledCuspData`; this milestone exposes that structure at every bad place.

### Lean/API Check

`ThetaCuspLocalData` already stores:

```text
badLocalLabCuspModel
badLocalCusp_quotientOrigin_eq_model
```

Those two fields are sufficient to derive a modeled cusp without adding
duplicated constructor fields. Lean can build the modeled cusp from the existing
bad local cusp, its local `LabCusp` model, and the proof that the cusp equals
the model-built cusp.

### Lean Decisions

The new helper

```text
CuspLabelClassData.canonical
```

builds structured label-class data from any local `LabCusp` model.

The new projection

```text
ThetaCuspLocalData.badLocalModeledCusp
```

turns a bad-place local cusp into a `ModeledCuspData`. The full initial-theta
API mirrors this with:

```text
InitialThetaData.badLocalModeledCusp
```

### Lean Declarations

```text
CuspLabelClassData.canonical
ThetaCuspLocalData.badLocalCuspLabelClassData
ThetaCuspLocalData.badLocalModeledCusp
ThetaCuspLocalData.badLocalModeledCusp_cusp
ThetaCuspLocalData.badLocalModeledCusp_labelClass_eq_model_quotient
InitialThetaData.badLocalCuspLabelClassData
InitialThetaData.badLocalModeledCusp
InitialThetaData.badLocalModeledCusp_cusp
InitialThetaData.badLocalModeledCusp_labelClass_eq_model_quotient
```

### What This Tests

The example file now checks:

* every bad local cusp can be viewed as `ModeledCuspData`;
* the modeled cusp's underlying `cusp` is exactly `theta.badLocalCusp`;
* its label class is the quotient of the local model's canonical nonzero label.

### Design Trap Avoided

The trap would be to add a second, independent bad-local modeled-cusp field and
then maintain consistency by hand. Instead, the modeled cusp is derived from the
existing bad local cusp and compatibility proof, so Lean keeps the two views in
lockstep.

### Remaining Gap

The modeled cusp still depends on the supplied `LocalLabCuspModel`. The next
mathematical step is to relate this local label model more tightly to the
orbicurve type witnesses for `(1, Z/lZ)^pm`, rather than treating the model as
free extra data.

## Math Milestone 36: `LabCusp` Models Sourced from Bad Local Type Data

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(e), assumes that at `v in Vbad` the local orbicurve `C_v`
has type `(1,Z/lZ)^pm`, referring to [EtTh], Definition 2.5(i). Definition
3.1(f) then says that `epsilon_v` arises from the canonical generator, up to
sign, of the quotient `Z` appearing in that same type definition. Definition
4.1(ii) later constructs `LabCusp(D_v)` from the local object and its quotient
data.

This is not yet a formalization of the [EtTh] reconstruction algorithm. The
source-aligned refinement is narrower: the local `LabCusp` model is now packaged
with the bad local type witness, and the cusp layer must use that model.

The Scholze-Stix guardrail remains unchanged: this step is local initial-theta
data, not a cross-Hodge-theater comparison and not a Corollary 3.12 endpoint.
It therefore must not identify distinct Hodge-theater histories or claim any
log-volume inequality.

### Lean/API Check

Before this milestone, the bad local type witness lived in `ThetaBadLocalData`,
while the local label model lived independently in `ThetaCuspLocalData`. That
allowed a bad local cusp to cite a model that was not visibly sourced from the
`(1,Z/lZ)^pm` witness.

The new structure

```text
BadLocalOrbicurveTypeData
```

packages:

```text
typeData : OrbicurveTypeData l C OrbicurveTypeKind.oneZModLPM
labCuspModel : LocalLabCuspModel l
labCuspModel_constructedFromType : Prop
```

The final proposition is an explicit placeholder for the future EtTh
reconstruction proof.

### Lean Decisions

`ThetaBadLocalData.badLocalCType` now returns `BadLocalOrbicurveTypeData`.
The old `ThetaCuspLocalData.badLocalLabCuspModel` field was removed. All
bad-local cusp compatibility statements now refer to:

```text
badLocalData.badLocalLabCuspModel v hv
```

This makes the data flow one-way:

```text
bad local type witness -> local LabCusp model -> modeled bad local cusp
```

### Lean Declarations

```text
BadLocalOrbicurveTypeData
BadLocalOrbicurveTypeData.holds
BadLocalOrbicurveTypeData.labCuspModelSource
ThetaBadLocalData.badLocalLabCuspModel
ThetaBadLocalData.badLocalLabCuspModelSource
InitialThetaData.badLocalLabCuspModelSource
```

### What This Tests

The example file now checks:

* the bad local type witness still proves the `(1,Z/lZ)^pm` type condition;
* the bad local `LabCusp` model has a recorded source obligation from that type
  witness;
* the previously exposed modeled bad cusp still builds and has the same
  underlying local cusp.

### Design Trap Avoided

The trap would be to keep adding compatibility equalities between independent
records. This milestone moves the label model to the bad local type package, so
the cusp layer cannot choose a separate model by accident.

### Remaining Gap

`labCuspModel_constructedFromType` is still a named obligation, not a theorem
derived from a formalized EtTh Definition 2.5(i). A later milestone should
expand the type witness so the quotient `Z`, its sign ambiguity, and the
canonical generator are reconstructed rather than supplied.

## Math Milestone 37: Canonical Generators Sourced from Bad Local Type Data

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(f), specifically says that for `v in Vbad`, `epsilon_v`
arises from the canonical generator, up to sign, of the quotient `Z` appearing
in the definition of a hyperbolic orbicurve of type `(1,Z/lZ)^pm`. Therefore the
canonical-generator witness should be attached to the same bad-local type data
that supplies the quotient/label model.

This is still below the level of the debated IUT III Corollary 3.12 transition.
The Scholze-Stix concern about illicitly identifying histories is not touched by
this local packaging step.

### Lean/API Check

Milestone 36 moved the `LabCusp` model into `BadLocalOrbicurveTypeData`.
This milestone moves the canonical-generator-up-to-sign witness there as well:

```text
canonicalGenerator : CanonicalGeneratorUpToSignElement
canonicalGenerator_eq_model :
  canonicalGenerator = labCuspModel.canonicalGeneratorUpToSignElement
```

The cusp-local layer now records only the local cusp and its equality with the
model-sourced nonzero quotient origin. It no longer owns a separate canonical
generator field.

### Lean Decisions

The public initial-theta API still exposes:

```text
InitialThetaData.badLocalCanonicalGenerator
InitialThetaData.badLocalCanonicalGenerator_eq_model
InitialThetaData.badLocalCusp_arisesFromCanonicalGenerator
```

but these are now projections through `theta.badLocalData`, not independent
fields of `theta.cuspLocalData`.

### Lean Declarations

```text
BadLocalOrbicurveTypeData.canonicalGenerator
BadLocalOrbicurveTypeData.canonicalGeneratorEqModel
BadLocalOrbicurveTypeData.canonicalGeneratorUpToSign
ThetaBadLocalData.badLocalCanonicalGenerator
ThetaBadLocalData.badLocalCanonicalGeneratorEqModel
ThetaBadLocalData.badLocalCanonicalGeneratorUpToSign
InitialThetaData.badLocalCanonicalGenerator
```

### What This Tests

The example file now checks:

* the bad-local canonical generator is available from full initial theta data;
* it satisfies `canonicalGeneratorUpToSign`;
* it agrees with the canonical-generator witness of the bad local `LabCusp`
  model.

### Design Trap Avoided

The trap would be to prove that two separately supplied canonical-generator
witnesses happen to agree. The new API has only one source: the bad local type
package.

### Remaining Gap

The bad local type package still supplies the quotient/model/generator data.
The next refinement should split the current opaque `labCuspModel_constructedFromType`
obligation into explicit quotient-`Z`, sign-action, and canonical-generator
components matching [EtTh], Definition 2.5(i).

## Math Milestone 38: Explicit Bad Local Quotient `Z` Package

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(e), says that for `v in Vbad`, `C_v` is of type
`(1,Z/lZ)^pm`, citing [EtTh], Definition 2.5(i). Definition 3.1(f) then says
that `epsilon_v` arises from the canonical generator, up to sign, of the quotient
`Z` appearing in that definition. IUT I, Definition 4.1(ii), later describes
`LabCusp(D_v)` as label classes over nonzero cusps arising from the relevant
quotient data.

I also checked Mochizuki's external paper *The Etale Theta Function and its
Frobenioid-theoretic Manifestations*, since IUT I explicitly cites it as
`[EtTh]` for Definition 2.5(i).

### Lean/API Check

The previous milestone still had one opaque field:

```text
labCuspModel_constructedFromType : Prop
```

This has been replaced by an explicit package:

```text
BadLocalQuotientZData l
```

with fields for:

```text
quotientZ
unitActionZ
signActionZ
signUnitCompatibilityZ
additiveTorsorZ
canonicalCoordinateZ
canonicalNonzeroLabelZ
canonicalSignLabelZ
```

The bad-local `LabCusp` model is now definitionally derived from this package by
`BadLocalQuotientZData.toLocalLabCuspModel`.

### Lean Decisions

`BadLocalOrbicurveTypeData` now stores:

```text
typeData : OrbicurveTypeData l C OrbicurveTypeKind.oneZModLPM
quotientZData : BadLocalQuotientZData l
canonicalGenerator : CanonicalGeneratorUpToSignElement
canonicalGenerator_eq_model :
  canonicalGenerator = quotientZData.canonicalGeneratorUpToSignElement
```

The old source proposition is replaced by the theorem:

```text
BadLocalOrbicurveTypeData.labCuspModelSource :
  labCuspModel = quotientZData.toLocalLabCuspModel
```

This is stronger than the former opaque proposition because Lean can unfold the
bad local `LabCusp` model back to named quotient-`Z` components.

### Lean Declarations

```text
BadLocalQuotientZData
BadLocalQuotientZData.toLocalLabCuspModel
BadLocalQuotientZData.canonicalGeneratorUpToSignElement
BadLocalQuotientZData.canonicalGeneratorUpToSign
zmodBadLocalQuotientZData
BadLocalOrbicurveTypeData.quotientZData
BadLocalOrbicurveTypeData.labCuspModelSource
```

### What This Tests

The example file now checks:

* the concrete `ZMod l` quotient-`Z` package has canonical coordinate `1`;
* the concrete quotient-`Z` package builds the same local `LabCusp` model as
  `zmodLocalLabCuspModel`;
* the quotient-`Z` package provides a canonical-generator-up-to-sign witness;
* the full initial-theta bad local type still exposes a model sourced from its
  quotient-`Z` package.

### Design Trap Avoided

The trap would be to keep a black-box proposition that says the model came from
the bad local type without saying which pieces were extracted. This milestone
names the quotient, sign action, torsor, and canonical label data, so later
formalization has concrete fields to refine.

### Remaining Gap

`BadLocalQuotientZData` is still supplied data. The next refinement should make
the bad local type witness reconstruct the quotient-`Z` package from a more
faithful encoding of [EtTh], Definition 2.5(i), including the theta-root local
models from IUT I, Definition 3.1(e).

## Math Milestone 39: Theta-Root Data Sources the Bad Quotient `Z`

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(e), says that when `v in Vbad`, extracting an `l`-th root
of the theta function gives natural models of types `(1,(Z/lZ)_Theta)` and
`(1,(Z/lZ)_Theta)^pm`, and that these models determine the relevant open
subgroups. Definition 3.1(f) then uses the quotient `Z` from the
`(1,Z/lZ)^pm` type to state the canonical-generator condition. This milestone
records the theta-root local type witnesses and the quotient-`Z` package in one
typed object.

The Corollary 3.12/Scholze-Stix guardrail is still active: this is a local
initial-theta-data refinement. It does not identify Hodge theaters, compare
real-line copies, or prove any log-volume estimate.

### Lean/API Check

The new structure is:

```text
BadLocalThetaRootData l X C
```

It stores:

```text
thetaRootXType : OrbicurveTypeData l X OrbicurveTypeKind.oneZModLTheta
thetaRootCType : OrbicurveTypeData l C OrbicurveTypeKind.oneZModLThetaPM
quotientZData : BadLocalQuotientZData l
quotientZData_constructedFromThetaRoot : Prop
```

`BadLocalOrbicurveTypeData` now stores this `thetaRootData` instead of a bare
`quotientZData`. The old fields

```text
ThetaBadLocalData.thetaRootLocalXType
ThetaBadLocalData.thetaRootLocalCType
ThetaBadLocalData.thetaRootLocalModels
```

are no longer independent record fields; they are derived projections from
`badLocalCType`.

### Lean Decisions

This keeps the data flow aligned with the source:

```text
(1,Z/lZ)^pm bad local type
  -> theta-root local models
  -> quotient Z package
  -> LabCusp model
  -> modeled bad local cusp
```

The proposition `quotientZData_constructedFromThetaRoot` remains a placeholder
for the eventual EtTh reconstruction theorem, but it is now located at the
precise interface where that theorem belongs.

### Lean Declarations

```text
BadLocalThetaRootData
BadLocalThetaRootData.thetaRootXType_holds
BadLocalThetaRootData.thetaRootCType_holds
BadLocalThetaRootData.quotientZDataSource
BadLocalOrbicurveTypeData.thetaRootData
BadLocalOrbicurveTypeData.thetaRootXType_holds
BadLocalOrbicurveTypeData.thetaRootCType_holds
BadLocalOrbicurveTypeData.quotientZDataSource
ThetaBadLocalData.thetaRootLocalXType
ThetaBadLocalData.thetaRootLocalCType
ThetaBadLocalData.thetaRootLocalModels
```

### What This Tests

The example file continues to check that:

* full initial theta data exposes the theta-root `X` and `C` type witnesses;
* the theta-root construction proposition is available through
  `theta.thetaRootLocalModels`;
* the bad-local `LabCusp` model unfolds to the quotient-`Z` package carried by
  the theta-root data.

### Design Trap Avoided

The trap would be to keep the theta-root witnesses, the quotient `Z`, and the
bad-local cusp model as parallel fields. This milestone makes the quotient and
the model downstream of the theta-root package.

### Remaining Gap

`quotientZData_constructedFromThetaRoot` is still an assumed proposition. A later
milestone should replace this with a more concrete reconstruction statement,
probably by expanding `BadLocalQuotientZData` to include the open subgroup data
`Pi_Xbar_v <= Pi_Cbar_v <= Pi_C_v` mentioned in Definition 3.1(e).

## Math Milestone 40: Bad Local Open Subgroup Chain

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(e), says that for `v in Vbad`, extracting an `l`-th root
of the theta function produces local models `Xbar_v`, `Cbar_v` of types
`(1,(Z/lZ)_Theta)` and `(1,(Z/lZ)_Theta)^pm`. The same sentence says that
these models determine open subgroups:

```text
Pi_Xbar_v <= Pi_Cbar_v <= Pi_C_v
```

Remark 3.1.2 then emphasizes the reconstruction role of such open subgroups in
the `Theta`-approach to applying anabelian reconstruction. This milestone makes
the subgroup chain a structured part of the theta-root local data.

This remains local initial-theta data. It does not touch the later Corollary
3.12 comparison, so it must not be read as a Hodge-theater identification or as
a log-volume estimate.

### Lean/API Check

The new structure is:

```text
BadLocalOpenSubgroupData
```

It stores placeholder group carriers for `Pi_Xbar_v`, `Pi_Cbar_v`, and `Pi_C_v`,
maps for the two inclusions, and proof fields for the two open-subgroup
assertions. The carriers remain abstract because the actual tempered/profinite
fundamental groups have not yet been formalized.

`BadLocalThetaRootData` now stores:

```text
openSubgroups : BadLocalOpenSubgroupData
```

The old independent field `ThetaBadLocalData.badLocalOpenSubgroups` has been
removed. The public API still exposes a derived projection with the same name.

### Lean Decisions

The previous setup had a free proposition:

```text
badLocalOpenSubgroups : v in Vbad -> Prop
```

This was too weak: it did not say that there are three groups, nor that the
source shape is a two-step open subgroup chain. The new data records the shape
while leaving the group theory abstract.

### Lean Declarations

```text
BadLocalOpenSubgroupData
BadLocalOpenSubgroupData.piXbar_to_piCv
BadLocalOpenSubgroupData.piXbarOpenInPiCbar
BadLocalOpenSubgroupData.piCbarOpenInPiCv
BadLocalThetaRootData.openSubgroups
BadLocalThetaRootData.piXbarOpenInPiCbar
BadLocalThetaRootData.piCbarOpenInPiCv
BadLocalOrbicurveTypeData.openSubgroups
ThetaBadLocalData.badLocalOpenSubgroups
ThetaBadLocalData.badLocalPiXbarOpenInPiCbar
ThetaBadLocalData.badLocalPiCbarOpenInPiCv
InitialThetaData.badLocalOpenSubgroups
InitialThetaData.badLocalPiXbarOpenInPiCbar
InitialThetaData.badLocalPiCbarOpenInPiCv
```

### What This Tests

The example file now checks:

* full initial theta data exposes a `BadLocalOpenSubgroupData` package at bad
  places;
* the first inclusion is recorded as open;
* the second inclusion is recorded as open.

### Design Trap Avoided

The trap would be to keep saying "there are open subgroups" as a single opaque
proposition. That would not distinguish the `Xbar -> Cbar -> C` chain needed
later for reconstruction. The new structure names the chain directly.

### Remaining Gap

The three group carriers and the two maps are still abstract placeholders. A
later milestone should replace these carriers with actual profinite/tempered
fundamental group objects, or at least a reusable typed interface for such
groups and open embeddings.

## Math Milestone 41: Abstract Open Embeddings for Bad Local Groups

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(e), does not merely assert an untyped existence statement.
At each bad place, the theta-root local models determine a two-step chain of
open subgroups

```text
Pi_Xbar_v <= Pi_Cbar_v <= Pi_C_v
```

Remark 3.1.2 describes this sort of open subgroup as part of the
group-theoretic reconstruction mechanism in the `Theta` approach. IUT II later
uses inclusions between theta-related fundamental-group objects functorially.
So the Lean representation should not treat the arrows as arbitrary functions.

This milestone still remains before the Corollary 3.12 dispute. It is local
bad-place scaffolding for the theta-root situation, not a Hodge-theater
comparison and not a claim about log-volume inequalities.

### Lean/API Check

The new reusable interfaces are:

```text
AbstractFundamentalGroup
OpenEmbeddingData
```

`AbstractFundamentalGroup` stores a carrier, a group instance, and a temporary
`topologyKind` label. `OpenEmbeddingData` stores a monoid homomorphism, an
injectivity proof, and an openness proposition.

`BadLocalOpenSubgroupData` now stores:

```text
piXbar : AbstractFundamentalGroup
piCbar : AbstractFundamentalGroup
piCv : AbstractFundamentalGroup
piXbar_to_piCbar : OpenEmbeddingData piXbar piCbar
piCbar_to_piCv : OpenEmbeddingData piCbar piCv
```

The composite

```text
piXbar_to_piCv
```

is now a monoid homomorphism, and Lean proves its injectivity from the two
open embeddings.

### Lean Decisions

The previous milestone represented the arrows as raw functions plus separate
openness propositions. That captured the shape of the chain but lost the fact
that these are maps of group-like fundamental-group objects. The new interface
keeps the group-homomorphism obligation explicit while postponing the exact
choice of profinite versus tempered topology.

This is intentionally conservative. We do not yet assert that these are actual
mathlib `OpenEmbedding`s or open subgroups in a topological group, because the
project has not yet chosen the final formal model for the relevant fundamental
groups.

### Lean Declarations

```text
AbstractFundamentalGroup
OpenEmbeddingData
OpenEmbeddingData.openImage
OpenEmbeddingData.injective_holds
BadLocalOpenSubgroupData.piXbar_to_piCv
BadLocalOpenSubgroupData.piXbar_to_piCv_injective
BadLocalThetaRootData.piXbarToPiCvInjective
BadLocalOrbicurveTypeData.piXbarToPiCvInjective
ThetaBadLocalData.badLocalPiXbarToPiCvInjective
InitialThetaData.badLocalPiXbarToPiCvInjective
```

### What This Tests

The example file now checks:

* full initial theta data exposes the bad local open-embedding package;
* the first arrow `Pi_Xbar_v -> Pi_Cbar_v` is open;
* the second arrow `Pi_Cbar_v -> Pi_C_v` is open;
* the composite `Pi_Xbar_v -> Pi_C_v` is injective.

### Design Trap Avoided

The trap would be to let the open subgroup chain decay into arbitrary maps.
That would be too weak for later anabelian reconstruction work, where the maps
must preserve group structure and inclusion-like behavior. This milestone makes
the minimal group-theoretic obligations visible to Lean.

### Remaining Gap

`isOpenImage` is still a proposition field, and `topologyKind` is only a label.
Later milestones should replace this placeholder with real topology:
`TopologicalSpace`, continuity, open image, and eventually whichever profinite
or tempered group category best matches the IUT source material.

## Math Milestone 42: Topological Open Embeddings

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Definition 3.1(e), describes the relevant `Pi(-)` objects as profinite
groups and says that, at bad places, the theta-root local models determine open
subgroups

```text
Pi_Xbar_v <= Pi_Cbar_v <= Pi_C_v
```

Remark 3.1.2 says that the subgroup `Pi_XK <= Pi_CK` may be constructed
group-theoretically from the topological group `Pi_CK`, then uses this in the
`Theta` approach to anabelian reconstruction. IUT II, around the review of
mono-theta-theoretic cyclotomic rigidity, also treats the relevant `Pi_X(MTheta)`,
`Pi_Y(MTheta)`, and `Pi_C(MTheta)` as topological groups and open subgroups.

Scholze-Stix's critique focuses on the later Corollary 3.12 comparison of pilot
objects, realified monoids, and Hodge theaters. This milestone is deliberately
earlier: it only records that the local theta-root subgroup chain is a chain of
topological group embeddings. It does not identify Hodge theaters or compare
log-volumes.

### Lean/API Check

The placeholder string field on `AbstractFundamentalGroup` has been replaced by
actual mathlib topology:

```text
topology : TopologicalSpace carrier
isTopologicalGroup : IsTopologicalGroup carrier
topologyKind : FundamentalGroupTopologyKind
```

The topology kind is now a small datatype with cases:

```text
profinite
tempered
abstract
```

This keeps track of the intended source interpretation without pretending that
we already have full profinite or tempered fundamental group categories.

`OpenEmbeddingData` now stores a monoid homomorphism together with

```text
Topology.IsOpenEmbedding hom
```

instead of a custom openness proposition. From this one Lean derives
continuity, injectivity, open image, and an open image subgroup.

### Lean Decisions

The important change is that openness is no longer only a named proposition. It
is connected to mathlib's topological map API. This gives us standard theorems
such as continuity and closure under composition.

The composite

```text
Pi_Xbar_v -> Pi_C_v
```

is now itself represented as an `OpenEmbeddingData`, not merely as a monoid
homomorphism with a derived injectivity proof. This matches the subgroup-chain
reading of Definition 3.1(e): composing two open subgroup inclusions should
again be an open embedding.

### Lean Declarations

```text
FundamentalGroupTopologyKind
AbstractFundamentalGroup.topology
AbstractFundamentalGroup.isTopologicalGroup
OpenEmbeddingData.isOpenEmbedding
OpenEmbeddingData.continuous_hom
OpenEmbeddingData.isOpenMap_holds
OpenEmbeddingData.imageSubgroup
OpenEmbeddingData.imageSubgroup_open
OpenEmbeddingData.comp
BadLocalOpenSubgroupData.piXbar_to_piCv_openEmbedding
BadLocalOpenSubgroupData.piXbar_to_piCv_open
BadLocalOpenSubgroupData.piXbar_to_piCv_isOpenEmbedding
BadLocalThetaRootData.piXbarOpenInPiCv
BadLocalThetaRootData.piXbarToPiCvIsOpenEmbedding
InitialThetaData.badLocalPiXbarOpenInPiCv
InitialThetaData.badLocalPiXbarToPiCvIsOpenEmbedding
```

### What This Tests

The example file now checks:

* the first and second bad-local subgroup arrows are open images;
* the composite `Pi_Xbar_v -> Pi_C_v` has open image;
* the composite is a mathlib `Topology.IsOpenEmbedding`;
* the composite remains injective.

### Design Trap Avoided

The trap would be to keep a parallel homemade topology vocabulary. By using
mathlib's `TopologicalSpace`, `IsTopologicalGroup`, and `Topology.IsOpenEmbedding`
now, later refinements can connect to existing topological-group results instead
of translating from custom propositions.

### Remaining Gap

This still does not construct actual profinite or tempered fundamental groups.
`profinite` and `tempered` are tags for the intended interpretation. A later
milestone should replace the `abstract` objects at concrete source points with
mathlib-compatible profinite groups, and then add the tempered-fundamental-group
interface needed for the bad-place conjugation operations discussed in IUT II.

## Math Milestone 43: Theta-Approach Normal Quotient

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, says that the open subgroup

```text
Pi_XK <= Pi_CK
```

may be constructed group-theoretically from the topological group `Pi_CK`.
The same remark then states that the reconstruction is applied to `Pi_XK`
to recover the function field of `X_K` equipped with its natural

```text
Gal(X_K/C_K) ~= Pi_CK / Pi_XK
```

action. This is stronger than the local open subgroup chain of Definition
3.1(e): it uses a quotient by the subgroup `Pi_XK`.

The source support is intentionally narrow. Definition 3.1(e) states the
bad-local chain

```text
Pi_Xbar_v <= Pi_Cbar_v <= Pi_C_v
```

as open subgroups, but the text checked here does not justify declaring every
arrow in that local chain to be normal. Therefore this milestone adds normal
quotient data for the global `Theta`-approach quotient, not as a blanket change
to `BadLocalOpenSubgroupData`.

Scholze-Stix's criticism concerns the later Corollary 3.12 use of Hodge
theaters and pilot objects. This milestone remains in the earlier reconstruction
setup: it only records the quotient shape needed before later comparisons can
even be stated.

### Lean/API Check

The new reusable structure is:

```text
NormalOpenEmbeddingData
```

It contains an `OpenEmbeddingData` and a proof that its image subgroup is
normal. From this Lean defines:

```text
quotientGroup
quotientMap
quotientMap_surjective
```

The quotient map is currently the canonical map of the underlying quotient
type. The group instance on the quotient is supplied from the normality proof.

The global cover data now stores:

```text
thetaApproachQuotient : ThetaApproachQuotientData
```

This record contains abstract topological groups `Pi_XK`, `Pi_CK`, a normal
open embedding `Pi_XK -> Pi_CK`, the quotient group `Pi_CK / Pi_XK`, and two
source-level propositions: the identification with `Gal(X_K/C_K)` and the
use of this data in the `Theta`-approach reconstruction.

### Lean Decisions

The important design choice is separating two notions:

* `OpenEmbeddingData` for source statements that only assert open subgroup
  inclusions;
* `NormalOpenEmbeddingData` for source statements that form a quotient group.

This avoids silently importing normality into the bad-local chain. The quotient
is attached to `ThetaOrbicurveCoverData`, which is where the global `C_K`/`X_K`
covering data from Definition 3.1(d) already lives.

### Lean Declarations

```text
NormalOpenEmbeddingData
NormalOpenEmbeddingData.quotientGroup
NormalOpenEmbeddingData.quotientGroupGroup
NormalOpenEmbeddingData.quotientMap
NormalOpenEmbeddingData.quotientMap_surjective
ThetaApproachQuotientData
ThetaApproachQuotientData.deckQuotient
ThetaApproachQuotientData.quotientMap
ThetaApproachQuotientData.quotientMap_surjective
ThetaApproachQuotientData.piXKOpenInPiCK
ThetaApproachQuotientData.piXKNormalInPiCK
ThetaApproachQuotientData.galQuotientIdentification
ThetaApproachQuotientData.reconstructionViaThetaApproach
ThetaOrbicurveCoverData.thetaApproachQuotient
InitialThetaData.thetaApproachDeckQuotient
InitialThetaData.thetaApproachPiXKOpenInPiCK
InitialThetaData.thetaApproachPiXKNormalInPiCK
InitialThetaData.thetaApproachQuotientMapSurjective
InitialThetaData.thetaApproachGalQuotientIdentification
InitialThetaData.thetaApproachReconstruction
```

### What This Tests

The example file now checks that full initial theta data exposes:

* the global `Theta`-approach open image `Pi_XK -> Pi_CK`;
* normality of the image subgroup;
* surjectivity of the canonical quotient map;
* the source-level `Gal(X_K/C_K) ~= Pi_CK / Pi_XK` identification proposition;
* the source-level reconstruction proposition.

### Design Trap Avoided

The trap would be to treat every open subgroup as a normal quotient subgroup.
That would make later quotient notation easy, but it would encode more than the
source says for the bad-local chain. This milestone only introduces normality
where the source explicitly uses a quotient.

### Remaining Gap

The `Gal(X_K/C_K)` object and its action are still represented by propositions,
not by an actual group equivalence or group action. A later milestone should
formalize the deck transformation/Galois action once the covering and function
field reconstruction APIs are mature enough.

## Math Milestone 44: Theta-Approach Function-Field Action

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, says that the `Theta`-approach applies the anabelian
reconstruction algorithm to the open subgroup `Pi_XK <= Pi_CK` in order to
reconstruct the function field of `X_K`, equipped with its natural

```text
Gal(X_K/C_K) ~= Pi_CK / Pi_XK
```

action. The previous milestone encoded the normal-open quotient. This milestone
adds the action target: a reconstructed function field carrying an action of
that quotient group.

IUT II's discussion of the global `F_l` symmetries warns that `Pi_CK` and
`Pi_XK` may be subject to conjugacy and poly-action indeterminacies, and that
one must not simply quotient away these symmetries because of label-crushing.
The present Lean move respects that warning: it records a quotient action on
the reconstructed field, but it does not identify labels, Hodge theaters, or
pilot objects.

Scholze-Stix's critique of Corollary 3.12 emphasizes exactly those later
identification issues between abstract and concrete pilot objects. This
milestone is earlier and narrower: it prepares the reconstruction/action
language needed before such later comparisons can be stated.

### Lean/API Check

The new structure

```text
ReconstructedFunctionFieldData
```

stores:

```text
carrier : Type
field : Field carrier
deckAction : MulAction deckGroup carrier
actionByFieldAutomorphisms : Prop
```

The action is a real Lean `MulAction`, so Lean proves the identity and
composition action laws. The stronger assertion that the action is by field
automorphisms is kept as a proposition for now, because we have not yet
formalized the appropriate function-field automorphism object.

The new structure

```text
ThetaApproachFunctionFieldData
```

connects this reconstructed function field to a specific
`ThetaApproachQuotientData`. It records that the field is the reconstructed
function field of `X_K` and that the deck action matches the
`Gal(X_K/C_K) ~= Pi_CK / Pi_XK` quotient action.

### Lean Decisions

The main design choice is to encode the quotient action as an actual group
action immediately, but to postpone the claim that each group element acts as a
field automorphism. This gives Lean useful structure now without fabricating a
function-field automorphism theory prematurely.

This also keeps the Scholze-Stix guardrail visible: the action target is tied
to the `Theta`-approach quotient, but there is no cross-Hodge-theater
identification or collapse of concrete labels.

### Lean Declarations

```text
ReconstructedFunctionFieldData
ReconstructedFunctionFieldData.deckActionByFieldAutomorphisms
ReconstructedFunctionFieldData.one_smul_element
ReconstructedFunctionFieldData.mul_smul_element
ThetaApproachFunctionFieldData
ThetaApproachFunctionFieldData.functionField
ThetaApproachFunctionFieldData.reconstructedFromXK
ThetaApproachFunctionFieldData.deckActionByFieldAutomorphisms
ThetaApproachFunctionFieldData.deckActionMatchesQuotient
ThetaApproachFunctionFieldData.deck_one_smul
ThetaApproachFunctionFieldData.deck_mul_smul
ThetaOrbicurveCoverData.thetaApproachFunctionField
ThetaOrbicurveCoverData.thetaApproachFunctionFieldCarrier
ThetaOrbicurveCoverData.thetaApproachFunctionFieldOfXK
ThetaOrbicurveCoverData.thetaApproachDeckActionByFieldAutomorphisms
ThetaOrbicurveCoverData.thetaApproachDeckActionMatchesQuotient
InitialThetaData.thetaApproachFunctionFieldCarrier
InitialThetaData.thetaApproachFunctionFieldOfXK
InitialThetaData.thetaApproachDeckActionByFieldAutomorphisms
InitialThetaData.thetaApproachDeckActionMatchesQuotient
```

### What This Tests

The example file now checks that full initial theta data exposes:

* the reconstructed function-field-of-`X_K` proposition;
* the proposition that the quotient action is by field automorphisms;
* the proposition that the deck action matches the quotient/Galois action.

The core Lean file also proves the `1 • x = x` and `(g * h) • x = g • h • x`
laws for the action, directly from `MulAction`.

### Design Trap Avoided

The trap would be to represent the phrase "equipped with its natural action" as
only another proposition. We now require an actual group action. The opposite
trap would be to overreach by declaring concrete field automorphisms before the
function-field API exists. That claim remains explicit and auditable.

### Remaining Gap

The function field is still abstract, and the field-automorphism condition is
not yet a bundled map into `Aut` or `AlgEquiv`. A later milestone should replace
`actionByFieldAutomorphisms : Prop` with a concrete homomorphism from the deck
quotient into the automorphism group of the reconstructed function field.

## Math Milestone 45: Algebraic Deck Action

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

The same sentence of IUT I, Remark 3.1.2, is the source for this refinement:
the reconstructed function field of `X_K` is equipped with its natural

```text
Gal(X_K/C_K) ~= Pi_CK / Pi_XK
```

action. Since this is an action on a function field, the action should preserve
the field operations. Mathlib's `MulSemiringAction` is the appropriate available
structure: its documentation explicitly gives a Galois group acting on a field
as a typical use case, and its axioms express preservation of `0`, `1`,
addition, and multiplication.

The Scholze-Stix boundary remains unchanged. We have formalized an algebraic
action attached to the early `Theta`-approach quotient. We have not identified
Hodge theaters, pilot objects, or copies of realified monoids.

### Lean/API Check

`ReconstructedFunctionFieldData` now stores:

```text
deckAction : MulSemiringAction deckGroup carrier
```

instead of:

```text
deckAction : MulAction deckGroup carrier
actionByFieldAutomorphisms : Prop
```

This is a real strengthening. Lean now knows that the deck action preserves
the semiring structure of the field carrier. The structure exposes the
associated ring endomorphism:

```text
deckRingHom : deckGroup -> carrier ->+* carrier
```

and proves preservation of `0`, `1`, addition, and multiplication.

### Lean Decisions

We used `MulSemiringAction` rather than immediately constructing an explicit
map into a group of field automorphisms. This matches what mathlib already
supports cleanly while still making the action algebraic. Since the acting
object is a group, the action maps are invertible at the action level; later we
can bundle these maps as `RingEquiv`/`AlgEquiv` once the function-field API is
less abstract.

### Lean Declarations

```text
ReconstructedFunctionFieldData.deckRingHom
ReconstructedFunctionFieldData.smul_zero_element
ReconstructedFunctionFieldData.smul_one_element
ReconstructedFunctionFieldData.smul_add_element
ReconstructedFunctionFieldData.smul_mul_element
ThetaApproachFunctionFieldData.deckRingHom
ThetaApproachFunctionFieldData.deck_smul_zero
ThetaApproachFunctionFieldData.deck_smul_one
ThetaApproachFunctionFieldData.deck_smul_add
ThetaApproachFunctionFieldData.deck_smul_mul
```

The previous proposition `actionByFieldAutomorphisms` has been removed from the
current API.

### What This Tests

The example file now checks:

* the deck action identity law;
* the deck action multiplication law;
* preservation of `1`;
* preservation of addition;
* preservation of multiplication;
* the remaining source-level statement that this algebraic action matches the
  intended quotient/Galois action.

### Design Trap Avoided

The trap would be to leave "acts by automorphisms" as an inert proposition
after mathlib already provides a usable algebraic action class. The opposite
trap would be to overfit the current abstraction to a specific concrete
function-field automorphism group before the reconstructed function field has
been built. `MulSemiringAction` is the right intermediate layer.

### Remaining Gap

The reconstructed function field is still abstract. Later milestones should
replace the abstract carrier with a real function-field object and then bundle
the deck action as a homomorphism into the relevant automorphism group.

## Math Milestone 46: Quotient Hom and Induced `Pi_CK` Action

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, identifies the deck/Galois group acting on the
reconstructed function field with the quotient

```text
Gal(X_K/C_K) ~= Pi_CK / Pi_XK
```

Once the quotient action has been made algebraic, the canonical map

```text
Pi_CK -> Pi_CK / Pi_XK
```

should itself be a group homomorphism, not just a function. Pulling the
quotient action back along this homomorphism gives the corresponding
`Pi_CK`-action that factors through the quotient.

This still does not enter the Corollary 3.12/Hodge-theater comparison. It is
part of the reconstruction substrate needed before the later pilot-object and
realified-monoid comparisons can be stated.

### Lean/API Check

`NormalOpenEmbeddingData` now exposes:

```text
quotientHom : target.carrier ->* quotientGroup
quotientHom_surjective
quotientHom_apply
```

`ThetaApproachQuotientData` exposes the corresponding global version:

```text
quotientHom : Pi_CK ->* Pi_CK / Pi_XK
quotientHom_surjective
quotientHom_apply
```

`ThetaApproachFunctionFieldData` now defines an induced algebraic action of
`Pi_CK` on the reconstructed function field by composing the deck action with
the quotient hom:

```text
piCKAction : MulSemiringAction Pi_CK functionField
```

and proves that this action is the pullback of the deck action.

### Lean Decisions

The quotient map is now represented twice:

* `quotientMap`, a plain function kept for compatibility with the earlier API;
* `quotientHom`, the mathematically stronger group homomorphism used by new
  code.

We did not yet keep a kernel theorem in the public API. Lean can construct the
homomorphism and prove surjectivity cleanly, but the dependent universe setup
around the abstract quotient currently makes the kernel theorem noisy. Since
the source need for this milestone is the induced action through the quotient,
the kernel theorem is deferred rather than forced into an unstable shape.

### Lean Declarations

```text
NormalOpenEmbeddingData.quotientHom
NormalOpenEmbeddingData.quotientHom_surjective
NormalOpenEmbeddingData.quotientHom_apply
ThetaApproachQuotientData.quotientHom
ThetaApproachQuotientData.quotientHom_surjective
ThetaApproachQuotientData.quotientHom_apply
ThetaApproachFunctionFieldData.piCKAction
ThetaApproachFunctionFieldData.piCKRingHom
ThetaApproachFunctionFieldData.piCK_smul_eq_deck_smul
ThetaApproachFunctionFieldData.piCK_smul_one
ThetaApproachFunctionFieldData.piCK_smul_add
ThetaApproachFunctionFieldData.piCK_smul_mul
ThetaOrbicurveCoverData.thetaApproachQuotientHomSurjective
InitialThetaData.thetaApproachQuotientHomSurjective
```

### What This Tests

The example file now checks:

* surjectivity of the canonical quotient hom;
* that the induced `Pi_CK` action agrees with the quotient/deck action;
* that the induced `Pi_CK` action preserves multiplication on the reconstructed
  function field.

### Design Trap Avoided

The trap would be to let the deck action float independently of `Pi_CK`. This
milestone records that the `Pi_CK` action factors through the quotient hom, so
the Lean object follows the source phrase `Pi_CK / Pi_XK` rather than merely
naming a quotient in prose.

### Remaining Gap

The kernel of the quotient hom should eventually be exposed as exactly the
image subgroup of `Pi_XK`. That is mathematically standard for quotient groups,
but it should be added when the dependent quotient interface is stable enough
to keep the theorem readable.

## Math Milestone 47: Triviality on the Quotient Kernel

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, uses the quotient

```text
Pi_CK / Pi_XK
```

as the group acting on the reconstructed function field of `X_K`. In ordinary
quotient-group language, the subgroup `Pi_XK` maps to the identity element of
this quotient. Therefore the action of `Pi_CK` on the reconstructed function
field, when pulled back along `Pi_CK -> Pi_CK / Pi_XK`, is trivial on the image
of `Pi_XK`.

This is still part of the early `Theta`-approach reconstruction layer. It does
not compare Hodge theaters or pilot objects and does not touch the
Scholze-Stix criticism of the later Corollary 3.12 argument.

### Lean/API Check

The new quotient theorem is:

```text
ThetaApproachQuotientData.quotientHom_piXK_eq_one
```

It proves that any element coming from `Pi_XK` maps to `1` under the canonical
quotient hom.

The corresponding action theorem is:

```text
ThetaApproachFunctionFieldData.piXK_smul_trivial
```

It proves that the induced `Pi_CK` action on the reconstructed function field
is trivial on the image of `Pi_XK`.

### Lean Decisions

This milestone avoids exposing a full kernel-equality theorem for the dependent
quotient hom, but still proves the concrete direction needed for the action:
elements from the embedded subgroup are killed by the quotient map. The proof
uses mathlib's `QuotientGroup.eq_one_iff`.

This keeps the API readable and source-directed while still adding a genuine
group-theoretic fact.

### Lean Declarations

```text
ThetaApproachQuotientData.quotientHom_piXK_eq_one
ThetaApproachFunctionFieldData.piXK_smul_trivial
ThetaOrbicurveCoverData.thetaApproachQuotientHomPiXK_eq_one
ThetaOrbicurveCoverData.thetaApproachPiXK_smul_trivial
InitialThetaData.thetaApproachQuotientHomPiXK_eq_one
InitialThetaData.thetaApproachPiXK_smul_trivial
```

### What This Tests

The example file now checks:

* every `Pi_XK` element maps to `1` in `Pi_CK / Pi_XK`;
* the induced `Pi_CK` action is trivial on the image of `Pi_XK`.

### Design Trap Avoided

The trap would be to have a quotient notation but no formal evidence that the
subgroup is actually killed by the quotient map. This milestone makes that
basic quotient semantics explicit in Lean.

### Remaining Gap

The full kernel theorem

```text
ker (Pi_CK -> Pi_CK / Pi_XK) = image(Pi_XK)
```

should still be added later. The present theorem gives the source-to-kernel
direction needed for the action layer.

## Math Milestone 48: Kernel of the Theta Quotient Hom

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, identifies the acting deck group with

```text
Pi_CK / Pi_XK
```

For this quotient notation to mean what it says, the kernel of the canonical
map from `Pi_CK` to the quotient must be the image of `Pi_XK`. This milestone
formalizes that kernel statement for the concrete `Theta`-approach quotient.

This remains a reconstruction-layer fact. It does not assert anything about
Hodge-theater comparisons or the later Corollary 3.12 inequality.

### Lean/API Check

The new theorem is:

```text
ThetaApproachQuotientData.quotientHom_ker
```

with statement:

```text
ker (Pi_CK -> Pi_CK / Pi_XK) = image(Pi_XK)
```

The proof uses mathlib's quotient-group theorem:

```text
QuotientGroup.eq_one_iff
```

after unfolding the concrete quotient hom to `QuotientGroup.mk'`.

### Lean Decisions

We kept this theorem at the `ThetaApproachQuotientData` level rather than
placing it in the fully generic `NormalOpenEmbeddingData` namespace. The
generic version ran into dependent-universe noise earlier; the concrete
Theta-approach statement is the one needed by the IUT source and remains
readable.

### Lean Declarations

```text
ThetaApproachQuotientData.quotientHom_ker
ThetaOrbicurveCoverData.thetaApproachQuotientHomKer
InitialThetaData.thetaApproachQuotientHomKer
```

### What This Tests

The example file now checks the full kernel identity for the canonical
Theta-approach quotient hom.

### Design Trap Avoided

The trap would be to rely only on the one-way fact that elements from `Pi_XK`
map to `1`. This milestone adds the converse as well, so the quotient really
has the intended kernel.

### Remaining Gap

The quotient is still abstractly attached to reconstructed function-field data.
Later milestones should connect this to a more concrete covering/deck
transformation formalization and eventually to the Frobenioid/prime-strip data
used later in IUT.

## Math Milestone 49: Explicit Galois Quotient Interface

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, says that the `Theta`-approach reconstructs the function
field of `X_K` together with its natural

```text
Gal(X_K/C_K) ~= Pi_CK / Pi_XK
```

action. Milestones 43-48 formalized the quotient side. This milestone adds an
explicit Lean interface for a proposed Galois/deck group and a multiplicative
equivalence from that group to the quotient.

This remains an IUT I reconstruction-layer statement. It does not identify
pilot objects across Hodge theaters and does not assert any Corollary 3.12
log-volume comparison.

### Lean/API Check

The new record is:

```text
ThetaApproachGaloisQuotientData
```

It stores:

```text
galXKCK : Type
galXKCKGroup : Group galXKCK
galXKCKEquivDeckQuotient :
  galXKCK ~= ThetaApproachQuotientData.deckQuotient thetaApproach
```

The record yields:

```text
toDeckHom
fromDeckHom
piCKToGalHom
piCKToGalHom_surjective
piCKToGalHom_ker
piXK_toGal_eq_one
galFunctionFieldAction
gal_smul_eq_deck_smul
piCK_smul_eq_gal_smul
```

The cover and initial-theta layers expose:

```text
ThetaOrbicurveCoverData.thetaApproachGalPiCKHom
ThetaOrbicurveCoverData.thetaApproachGalPiCKHomSurjective
ThetaOrbicurveCoverData.thetaApproachGalPiCKHomKer
ThetaOrbicurveCoverData.thetaApproachPiXK_toGal_eq_one
InitialThetaData.thetaApproachGalPiCKHom
InitialThetaData.thetaApproachGalPiCKHomSurjective
InitialThetaData.thetaApproachGalPiCKHomKer
InitialThetaData.thetaApproachPiXK_toGal_eq_one
```

### Lean Decisions

We did not replace the earlier proposition
`galXKCK_identifiedWithQuotient`. Instead, we added a separate structured
interface that can be supplied when an actual candidate deck/Galois group is
available. This avoids breaking the existing reconstruction skeleton while
making future uses prove facts through a real group equivalence.

The induced map

```text
Pi_CK -> Gal(X_K/C_K)
```

is defined by composing the quotient hom `Pi_CK -> Pi_CK / Pi_XK` with the
inverse of the Galois/quotient equivalence. Lean proves that this map is
surjective and has kernel exactly the image of `Pi_XK`.

The Galois action on the reconstructed function field is transported from the
quotient/deck action by `MulSemiringAction.compHom`.

### What This Tests

The example file now checks:

* the projected `Pi_CK -> Gal(X_K/C_K)` hom is surjective;
* its kernel is the embedded `Pi_XK`;
* every `Pi_XK` element maps to `1` in the Galois group;
* the Galois action agrees with the existing deck-quotient action;
* the `Pi_CK` action agrees with the action pulled back through the Galois
  quotient map.

### Design Trap Avoided

The trap would be to keep saying "Galois group equals quotient" only as an
opaque proposition. That would not let Lean verify maps, kernels, or transported
actions. The new interface still allows an abstract Galois group, but any use of
it must pass through a concrete `MulEquiv`.

### Remaining Gap

The Galois/deck group is still supplied abstractly. Later milestones should
construct it from finite etale covering data or field automorphism data, then
connect the local/decomposition-group reconstruction data to this global
quotient interface.

## Math Milestone 50: Deck and Galois Actions as Ring Automorphisms

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, says that the `Theta`-approach reconstructs the function
field of `X_K` equipped with its natural

```text
Gal(X_K/C_K) ~= Pi_CK / Pi_XK
```

action. A natural Galois action on a function field should act by field
automorphisms. Milestones 44-49 encoded this as a `MulSemiringAction` and a
quotient/Galois interface. This milestone exposes the corresponding
automorphism homomorphisms using mathlib's `MulSemiringAction.toRingAut`.

This is still the IUT I reconstruction layer. It does not make any
Hodge-theater comparison and does not assert any Corollary 3.12 numerical
inequality.

### Lean/API Check

The reconstructed field package now exposes:

```text
ReconstructedFunctionFieldData.deckRingAutHom
ReconstructedFunctionFieldData.deckRingAut
ReconstructedFunctionFieldData.deckRingAut_apply
```

The theta function-field package now exposes:

```text
ThetaApproachFunctionFieldData.deckRingAutHom
ThetaApproachFunctionFieldData.deckRingAut
ThetaApproachFunctionFieldData.piCKRingAutHom
ThetaApproachFunctionFieldData.piCKRingAut
ThetaApproachFunctionFieldData.deckRingAut_apply
ThetaApproachFunctionFieldData.piCKRingAut_apply
```

The Galois quotient interface now exposes:

```text
ThetaApproachGaloisQuotientData.galRingAutHom
ThetaApproachGaloisQuotientData.galRingAut
ThetaApproachGaloisQuotientData.galRingAut_apply
ThetaApproachGaloisQuotientData.piCKRingAut_eq_galRingAut
```

The cover and initial-theta layers expose corresponding projections:

```text
ThetaOrbicurveCoverData.thetaApproachDeckRingAutHom
ThetaOrbicurveCoverData.thetaApproachPiCKRingAutHom
ThetaOrbicurveCoverData.thetaApproachGalRingAutHom
InitialThetaData.thetaApproachDeckRingAutHom
InitialThetaData.thetaApproachPiCKRingAutHom
InitialThetaData.thetaApproachGalRingAutHom
```

### Lean Decisions

We used mathlib's standard `RingAut` and
`MulSemiringAction.toRingAut`. This avoids introducing a custom "field
automorphism" record and lets Lean inherit the usual group homomorphism API for
automorphisms under composition.

The theorem

```text
ThetaApproachGaloisQuotientData.piCKRingAut_eq_galRingAut
```

states that the automorphism of the reconstructed function field obtained from
`Pi_CK` is exactly the automorphism obtained by first projecting to the Galois
group `Gal(X_K/C_K)`.

### What This Tests

The example file now checks:

* deck quotient elements act through `RingAut`;
* `Pi_CK` elements act through `RingAut`;
* Galois elements act through `RingAut`;
* the `Pi_CK` automorphism equals the Galois automorphism after quotienting.

### Design Trap Avoided

The trap would be to leave the action only as a pointwise semiring action and
then later speak informally about Galois automorphisms. This milestone makes the
automorphism content explicit in Lean.

### Remaining Gap

The reconstructed function field is still abstract. Later milestones should
connect the `RingAut` action to an actual field-extension automorphism group or
finite etale cover/deck transformation construction, rather than supplying the
deck action as an abstract field action.

## Math Milestone 51: Base Function Field Fixed by Deck/Galois Actions

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, says that the `Theta`-approach reconstructs the function
field of `X_K` equipped with its natural

```text
Gal(X_K/C_K) ~= Pi_CK / Pi_XK
```

action. The notation `Gal(X_K/C_K)` is not just an arbitrary automorphism
group: it is the automorphism group over the base object `C_K`. On the function
field side, this means the action should fix the image of the function field of
`C_K` inside the function field of `X_K`.

This milestone does not construct the actual scheme-theoretic cover. It records
the over-base condition needed for such a cover interpretation. It remains below
the Hodge-theater comparison and below the Corollary 3.12 dispute.

### Lean/API Check

`ReconstructedFunctionFieldData` now includes:

```text
baseCarrier : Type
baseField : Field baseCarrier
baseToFunctionField : baseCarrier ->+* carrier
baseToFunctionField_injective : Function.Injective baseToFunctionField
deckActionFixesBase :
  forall g b, g • baseToFunctionField b = baseToFunctionField b
```

The generic reconstructed field package exposes:

```text
baseToFunctionField_injective_holds
deck_smul_base
deckRingAut_fixesBase
```

The theta function-field package exposes:

```text
baseFunctionField
baseToFunctionField
baseToFunctionField_injective
deck_smul_base
deckRingAut_fixesBase
piCK_smul_base
piCKRingAut_fixesBase
```

The Galois quotient interface exposes:

```text
ThetaApproachGaloisQuotientData.gal_smul_base
ThetaApproachGaloisQuotientData.galRingAut_fixesBase
```

The cover and initial-theta layers expose corresponding projections:

```text
thetaApproachBaseFunctionFieldCarrier
thetaApproachBaseToFunctionField
thetaApproachBaseToFunctionFieldInjective
thetaApproachDeck_smul_base
thetaApproachPiCK_smul_base
thetaApproachGal_smul_base
thetaApproachDeckRingAut_fixesBase
thetaApproachPiCKRingAut_fixesBase
thetaApproachGalRingAut_fixesBase
```

### Lean Decisions

We modeled the base `C_K` function field as a field equipped with an injective
ring hom into the reconstructed `X_K` function field, rather than immediately
using a full `Algebra`/scheme morphism formalization. This is a conservative
interface: it captures the fixed-base content of a Galois cover while avoiding a
premature commitment to a particular scheme or finite-etale API.

The `Pi_CK` fixed-base theorem is derived from the quotient action, and the
Galois fixed-base theorem is derived by transporting through the quotient/Galois
equivalence.

### What This Tests

The example file now checks:

* the base-to-function-field map is injective;
* deck quotient elements fix the embedded base field;
* `Pi_CK` elements fix the embedded base field;
* Galois elements fix the embedded base field;
* the corresponding `RingAut` maps also fix the embedded base field.

### Design Trap Avoided

The trap would be to call an action "Galois over `C_K`" while only formalizing
arbitrary automorphisms of the function field of `X_K`. This milestone adds the
explicit invariant subfield interface Lean can check.

### Remaining Gap

The base field and embedding are still supplied as structured data. Later
milestones should construct them from the formalized `C_K`/`X_K` covering and
relate the fixed subfield of the deck action to the embedded base field.

## Math Milestone 52: Fixed Field Equals the Embedded Base Field

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, describes the reconstructed function field of `X_K` with
its natural

```text
Gal(X_K/C_K) ~= Pi_CK / Pi_XK
```

action. In ordinary Galois-cover language, the base `C_K` function field is the
fixed field of the deck/Galois action on the `X_K` function field. Milestone 51
proved one direction: the action fixes the embedded base field. This milestone
adds the converse interface: any element fixed by all deck transformations comes
from the embedded base field.

This remains an IUT I reconstruction-layer statement. It is not a Hodge-theater
comparison and not a Corollary 3.12 log-volume assertion.

### Lean/API Check

`ReconstructedFunctionFieldData` now includes:

```text
fixedElementsFromBase :
  forall x, (forall g, g • x = x) ->
    exists b, baseToFunctionField b = x
```

The generic reconstructed field package exposes:

```text
fixedElementFromBase
deck_fixed_iff_in_base
```

The theta function-field package exposes:

```text
ThetaApproachFunctionFieldData.deck_fixed_iff_in_base
ThetaApproachFunctionFieldData.piCK_fixed_iff_in_base
```

The Galois quotient interface exposes:

```text
ThetaApproachGaloisQuotientData.gal_fixed_iff_in_base
```

The cover and initial-theta layers expose corresponding projections:

```text
thetaApproachDeck_fixed_iff_in_base
thetaApproachPiCK_fixed_iff_in_base
thetaApproachGal_fixed_iff_in_base
```

### Lean Decisions

We keep the fixed-field converse as supplied structure on
`ReconstructedFunctionFieldData`. This is deliberately conservative: Lean does
not yet construct the finite etale cover or prove a theorem of Galois theory
from a concrete extension. But once the statement is supplied, Lean derives the
corresponding `Pi_CK` and Galois versions from already-formalized quotient
surjectivity and the Galois/quotient equivalence.

The `Pi_CK` theorem uses surjectivity of

```text
Pi_CK -> Pi_CK / Pi_XK
```

and the Galois theorem uses surjectivity of

```text
Gal(X_K/C_K) -> Pi_CK / Pi_XK
```

given by the multiplicative equivalence.

### What This Tests

The example file now checks:

* fixed-by-deck elements are exactly elements in the embedded base field;
* fixed-by-`Pi_CK` elements are exactly elements in the embedded base field;
* fixed-by-Galois elements are exactly elements in the embedded base field.

### Design Trap Avoided

The trap would be to stop at "the base field is fixed" and still allow extra
fixed elements. That would be too weak for the phrase `Gal(X_K/C_K)`. This
milestone explicitly rules out extra fixed elements at the interface level.

### Remaining Gap

The fixed-field theorem is still an axiom-like field of the reconstructed data.
Later milestones should derive it from a concrete finite Galois extension or
finite etale cover formalization, then relate that construction to the
fundamental-group quotient.

## Math Milestone 53: Faithful Deck Action and Exact `Pi_CK` Kernel

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, uses the notation

```text
Gal(X_K/C_K) ~= Pi_CK / Pi_XK
```

for the group acting naturally on the reconstructed function field of `X_K`.
For this to behave like a deck/Galois group, the quotient group should act
faithfully as automorphisms. Once that faithfulness is part of the reconstruction
interface, the induced `Pi_CK` action on the reconstructed function field has
kernel exactly the image of `Pi_XK`.

This remains a reconstruction-layer statement in IUT I. It does not compare
Hodge theaters and does not assert a Corollary 3.12 estimate.

### Lean/API Check

`ReconstructedFunctionFieldData` now includes:

```text
deckActionFaithful : FaithfulSMul deckGroup carrier
```

The generic reconstructed field package exposes:

```text
deckRingAutHom_injective
```

The theta function-field package exposes:

```text
ThetaApproachFunctionFieldData.deckRingAutHom_injective
ThetaApproachFunctionFieldData.piCKRingAutHom_ker
```

The Galois quotient interface exposes:

```text
ThetaApproachGaloisQuotientData.galRingAutHom_injective
```

The cover and initial-theta layers expose:

```text
thetaApproachDeckRingAutHomInjective
thetaApproachPiCKRingAutHomKer
thetaApproachGalRingAutHomInjective
```

### Lean Decisions

We model faithfulness with mathlib's standard `FaithfulSMul`, not a custom
predicate. This makes the injectivity proof for the deck action use the same
API as ordinary faithful group actions.

The theorem

```text
ThetaApproachFunctionFieldData.piCKRingAutHom_ker
```

proves:

```text
ker(Pi_CK -> RingAut(functionField X_K)) = image(Pi_XK)
```

It uses:

* faithfulness of the deck quotient action;
* the equality `ker(Pi_CK -> Pi_CK/Pi_XK) = image(Pi_XK)`;
* compatibility of the `Pi_CK` action with the quotient action.

The Galois automorphism action is injective because the Galois group is
multiplicatively equivalent to the deck quotient and the deck action is
faithful.

### What This Tests

The example file now checks:

* injectivity of the deck quotient action into `RingAut`;
* the kernel of the induced `Pi_CK -> RingAut` action is the embedded `Pi_XK`;
* injectivity of the Galois action into `RingAut`.

### Design Trap Avoided

The trap would be to have a quotient group acting on the reconstructed function
field but allow nontrivial deck elements to act trivially. That would weaken the
`Gal(X_K/C_K)` interpretation. This milestone makes faithfulness explicit.

### Remaining Gap

Faithfulness is still supplied as part of the reconstructed data. Later
milestones should derive it from a concrete finite etale cover or Galois
extension formalization.

## Math Milestone 54: Algebra-Automorphism Source for Deck Actions

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, says that the `Theta`-approach reconstructs the function
field of `X_K` equipped with the natural action

```text
Gal(X_K / C_K) ~= Pi_CK / Pi_XK.
```

IUT III, around the discussion of the log-wall, also reminds us that Galois
groups may be viewed as automorphism groups of fields/rings, while warning that
this ring-structure interpretation is precisely what cannot be transported
naively across the log-link.

This milestone stays on the reconstruction side, before any log-link or
Hodge-theater transport. It strengthens the local source of the deck action:
when the deck group is identified with an algebra-automorphism group, Lean now
derives the action and faithfulness from that identification.

### Lean/API Check

The new record is:

```text
AlgebraicDeckFunctionFieldData deckGroup B L
```

It contains:

```text
deckEquivAlgAut : deckGroup ~= (L equiv_alg[B] L)
fixedElementsFromBase :
  fixed by all B-algebra automorphisms -> comes from B
```

From this data, Lean constructs:

```text
AlgebraicDeckFunctionFieldData.toReconstructedFunctionFieldData
```

which is a `ReconstructedFunctionFieldData deckGroup`.

The action is transported from mathlib's tautological action of
`L ≃ₐ[B] L` on `L`; the faithfulness proof is derived from mathlib's
`AlgEquiv.apply_faithfulSMul`.

The theta layer now has:

```text
ThetaApproachFunctionFieldData.ofAlgebraicDeckFunctionField
```

which builds a theta function-field package from an algebraic deck model.

### Lean Decisions

We did not replace the existing abstract reconstruction interface. Instead, we
added a stricter constructor into it. This lets later milestones continue to use
abstract reconstruction data where the geometry is not yet formalized, while
allowing concrete Galois/function-field models to avoid arbitrary action fields.

The fixed-field converse remains a field of `AlgebraicDeckFunctionFieldData`.
This is deliberate: proving that the fixed field of the full automorphism group
is exactly the base field requires the relevant finite Galois extension theorem
or a concrete finite etale cover construction. The new milestone removes the
faithfulness assumption, not the full fixed-field theorem.

### What This Tests

The example file checks:

* the constructed base embedding is `algebraMap B L`;
* the induced deck automorphism is exactly the supplied algebra automorphism;
* the deck automorphism homomorphism is injective;
* fixed elements of the constructed action are precisely the supplied base
  elements;
* the trivial extension `B/B` gives a concrete algebraic deck model;
* the theta function-field package can be constructed from the algebraic deck
  model and still exposes injectivity.

### Design Trap Avoided

The trap would be to keep accepting an arbitrary group action as if it were a
Galois action. This milestone creates a path where the action is forced to come
from algebra automorphisms. At the same time, it does not use this
ring-automorphism model across the log-wall or claim any Corollary 3.12
transport.

### Remaining Gap

The deck group is still supplied together with an equivalence to
`L ≃ₐ[B] L`. Later milestones should derive this equivalence from a concrete
finite etale or finite Galois cover associated to `X_K -> C_K`.

## Math Milestone 55: Finite Galois Fixed-Field Constructor

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, treats the reconstructed function field of `X_K` together
with the natural action

```text
Gal(X_K / C_K) ~= Pi_CK / Pi_XK.
```

IUT I, Remark 3.1.5, also uses the surrounding finite Galois context for the
initial-theta-data field tower, including the fact that `K` is Galois over
`Fmod` in the relevant setting. This supports using standard finite-Galois
fixed-field mathematics in the reconstruction layer, before any Hodge-theater or
log-link transport.

Mathlib supplies the theorem

```text
IsGalois.mem_range_algebraMap_iff_fixed
```

which states that, for a finite Galois extension `L/B`, the elements fixed by
all `B`-algebra automorphisms of `L` are exactly the elements in the range of
`algebraMap B L`.

### Lean/API Check

The algebraic deck model now has:

```text
AlgebraicDeckFunctionFieldData.ofFiniteGaloisAlgAutEquiv
```

This takes:

```text
deckEquivAlgAut : deckGroup ~= (L equiv_alg[B] L)
FiniteDimensional B L
IsGalois B L
```

and constructs an `AlgebraicDeckFunctionFieldData deckGroup B L`.

It also exposes the canonical case:

```text
AlgebraicDeckFunctionFieldData.finiteGalois B L
```

where the deck group is exactly `L ≃ₐ[B] L`.

The derived theorem is:

```text
AlgebraicDeckFunctionFieldData.finiteGalois_fixed_iff_in_base
```

with statement:

```text
(forall sigma : L equiv_alg[B] L, sigma x = x)
  <-> exists b : B, algebraMap B L b = x
```

### Lean Decisions

This milestone removes the fixed-field converse as an independent assumption in
the finite-Galois case. The theorem is not reproved from scratch; it delegates to
mathlib's Galois correspondence API.

We still keep the more general `AlgebraicDeckFunctionFieldData` constructor,
because later IUT objects may pass through reconstruction interfaces before a
concrete finite Galois extension has been attached.

### What This Tests

The example file checks:

* finite Galois `K/F` gives an algebraic deck model with deck group
  `K ≃ₐ[F] K`;
* fixed-by-all-automorphisms is equivalent to being in the image of
  `algebraMap F K`;
* the reconstructed deck automorphism homomorphism is injective;
* the reconstructed fixed-field statement follows from the finite-Galois
  constructor.

### Design Trap Avoided

The trap would be to keep treating the fixed-field converse as a black-box
axiom even in the ordinary finite Galois situation where mathlib can prove it.
This milestone uses Lean's existing Galois theory to discharge that part.

We still do not claim that the geometric cover `X_K -> C_K` has been
constructed as a finite etale cover. The equivalence between the IUT quotient
`Pi_CK/Pi_XK` and the algebra-automorphism group remains supplied.

### Remaining Gap

The next gap is to connect the quotient

```text
Pi_CK / Pi_XK
```

to the finite Galois automorphism group of an actual function-field extension,
rather than supplying `deckEquivAlgAut` directly.

## Math Milestone 56: Theta Quotient Acting on a Finite Galois Function Field

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, says that the `Theta`-approach reconstructs the function
field of `X_K` with the natural action

```text
Gal(X_K / C_K) ~= Pi_CK / Pi_XK.
```

Milestones 54 and 55 separately formalized:

* an algebra-automorphism source for deck actions;
* the finite-Galois fixed-field theorem.

This milestone combines those two pieces at the theta quotient boundary: if the
theta deck quotient `Pi_CK/Pi_XK` is identified with the algebra automorphism
group of a finite Galois extension `L/B`, then the theta function-field package
is built from that finite Galois extension.

This remains strictly on the reconstruction side. It does not transport ring
structures across the log-link and does not assert the Corollary 3.12
inequality.

### Lean/API Check

The theta function-field namespace now has:

```text
ThetaApproachFunctionFieldData.ofFiniteGaloisAlgAutEquiv
```

It takes:

```text
FiniteDimensional B L
IsGalois B L
quotientEquivAlgAut :
  ThetaApproachQuotientData.deckQuotient thetaApproach ~= (L equiv_alg[B] L)
```

and produces:

```text
ThetaApproachFunctionFieldData thetaApproach
```

The supporting theorems are:

```text
ThetaApproachFunctionFieldData.ofFiniteGaloisAlgAutEquiv_deckRingAut_apply
ThetaApproachFunctionFieldData.ofFiniteGaloisAlgAutEquiv_fixed_iff_in_base
```

The first says that the deck action is exactly the transported algebra
automorphism. The second says that the elements fixed by the theta deck quotient
are exactly the base-field elements of the finite Galois extension.

### Lean Decisions

The quotient-to-automorphism equivalence is still an input:

```text
Pi_CK/Pi_XK ~= L equiv_alg[B] L
```

But once this equivalence is supplied, Lean no longer needs arbitrary action,
faithfulness, or fixed-field assumptions for the theta function-field package.
Those are derived from mathlib's algebra automorphism action and finite Galois
fixed-field theorem.

### What This Tests

The example file checks:

* a theta function-field package can be built from a finite Galois extension and
  a quotient-to-automorphism equivalence;
* the resulting deck automorphism is the transported algebra automorphism;
* the fixed-by-deck statement is the finite-Galois base-field statement;
* the induced `Pi_CK -> RingAut` kernel is still exactly the image of `Pi_XK`.

### Design Trap Avoided

The trap would be to let the theta quotient act on a field without tying that
action to a finite Galois extension. This milestone forces the action to pass
through `L ≃ₐ[B] L` in the finite-Galois case.

The remaining trap is also explicit: the equivalence between the group-theoretic
quotient and the finite-Galois automorphism group is not yet derived from a
finite etale cover of orbicurves.

### Remaining Gap

The next step is to introduce a typed finite-etale/Galois-cover interface for
`X_K -> C_K` whose output supplies the quotient-to-automorphism equivalence,
instead of taking that equivalence as a naked field.

## Math Milestone 57: Typed Finite Galois Cover Package for the Theta Quotient

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, says that one applies the reconstruction algorithm to the
open subgroup

```text
Pi_XK <= Pi_CK
```

to reconstruct the function field of `X_K` with its natural action

```text
Gal(X_K / C_K) ~= Pi_CK / Pi_XK.
```

Later in IUT I, the discussion of automorphism groups around `X_K` describes
such groups as reconstructible from the relevant categorical/orbicurve data.
At our present level, we still do not have that geometric finite-etale cover
formalized. The correct next step is therefore to stop passing the quotient
identification as an isolated equivalence and package it as part of a typed
finite Galois function-field cover interface.

### Lean/API Check

The new record is:

```text
ThetaFiniteGaloisFunctionFieldCoverData thetaApproach B L
```

under hypotheses:

```text
Field B, Field L, Algebra B L
FiniteDimensional B L
IsGalois B L
```

It contains:

```text
quotientEquivAlgAut :
  ThetaApproachQuotientData.deckQuotient thetaApproach ~= (L equiv_alg[B] L)
finiteEtaleGaloisCover : Prop
reconstructedFunctionFieldOfXK : Prop
deckActionMatchesGalQuotient : Prop
```

and proof fields for the three propositions.

The namespace exposes:

```text
toAlgebraicDeckFunctionFieldData
toThetaApproachFunctionFieldData
deckRingAut_apply
fixed_iff_in_base
piCKRingAutHom_ker
```

### Lean Decisions

This is a packaging milestone, but it is mathematically protective: the
quotient-to-automorphism equivalence is no longer a loose argument to a
constructor. It is now part of a named finite Galois cover object that also
records the finite-etale/Galois-cover claim and the reconstruction claim.

We still keep `finiteEtaleGaloisCover` as a proposition field. This avoids
pretending that mathlib currently has the IUT-specific finite etale orbicurve
cover construction that would produce the function-field extension and quotient
identification.

### What This Tests

The example file checks:

* construction of an abstract typed finite Galois theta function-field cover;
* extraction of the theta function-field package from that cover;
* access to the finite-etale/Galois-cover proof field;
* the transported deck action formula;
* the finite-Galois fixed-field theorem at the cover level;
* the exact `Pi_CK -> RingAut` kernel remains `image(Pi_XK)`.

### Design Trap Avoided

The trap would be to treat

```text
Pi_CK/Pi_XK ~= L equiv_alg[B] L
```

as a free-floating identification that can be inserted anywhere. The new record
forces it to live inside a finite Galois cover package and keeps the unproved
geometric cover claim visible.

### Remaining Gap

The next milestone should start replacing `finiteEtaleGaloisCover : Prop` with
typed finite-cover data: source/target orbicurves, a cover map, a deck group, and
a theorem that the associated quotient gives the automorphism group of the
function-field extension.

## Math Milestone 58: Typed Finite Etale Cover Certificate

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

This milestone refines the interface introduced in Milestone 57. IUT I, Remark
3.1.2, treats `Pi_XK <= Pi_CK` as the subgroup used to reconstruct the function
field of `X_K` together with the action

```text
Gal(X_K / C_K) ~= Pi_CK / Pi_XK.
```

The later IUT I discussion of automorphism groups of `X_K` describes such
groups as reconstructible from the relevant orbicurve/categorical data. We still
do not construct that geometry, but the formal interface now names the geometric
slots rather than hiding them in one proposition.

### Lean/API Check

The new certificate is:

```text
ThetaFiniteEtaleGaloisCoverCertificate thetaApproach B L
```

It records:

```text
baseField
sourceOrbicurve
targetOrbicurve
coverMapLabel
finiteEtaleCover
galoisCover
functionFieldExtensionOfCover
quotientEquivAlgAut
```

The existing package

```text
ThetaFiniteGaloisFunctionFieldCoverData thetaApproach B L
```

now contains:

```text
coverCertificate :
  ThetaFiniteEtaleGaloisCoverCertificate thetaApproach B L
```

instead of a single `finiteEtaleGaloisCover : Prop` plus a loose quotient
equivalence. The previous `finiteEtaleGaloisCover` is now derived as
`finiteEtaleCover and galoisCover`.

### Lean Decisions

The certificate still uses proposition fields for the actual finite-etale and
Galois-cover assertions. This is deliberate: the goal is to make the missing
geometry visible without pretending to have already formalized finite etale
orbicurve morphisms.

The quotient-to-automorphism equivalence is now attached to a cover certificate
with source and target orbicurves. This moves one step closer to deriving it
from geometry later.

### What This Tests

The example file checks:

* construction of an abstract finite etale Galois cover certificate;
* extraction of finite-etale and Galois proof fields as a conjunction;
* extraction of the function-field-extension proof field;
* construction of the theta finite Galois function-field package from the
  certificate;
* all previous derived consequences: theta package extraction, transported deck
  action, fixed-field theorem, and exact `Pi_CK` kernel.

### Design Trap Avoided

The trap would be to keep a single opaque `finiteEtaleGaloisCover` proposition.
That hides whether the source/target orbicurves, cover map, Galois condition,
function-field extension, and quotient identification are coherently attached to
the same object. The certificate now keeps these pieces together.

### Remaining Gap

The next step is to replace `coverMapLabel : String` and the proposition fields
with actual morphism data for finite etale covers of hyperbolic orbicurves, then
prove that the cover induces the recorded function-field extension and deck
automorphism group.

## Math Milestone 59: Typed Orbicurve Cover Morphism

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, frames the theta reconstruction around the inclusion
`Pi_XK <= Pi_CK` and the corresponding cover relation between `X_K` and `C_K`.
The formal model should therefore remember not only labels for `X_K` and `C_K`,
but also the morphism connecting the source and target orbicurves.

This milestone is still below the actual construction of finite etale morphisms
in algebraic geometry. It replaces an untyped string slot with a typed morphism
placeholder whose source and target are fixed by Lean.

### Lean/API Check

The new morphism record is:

```text
HyperbolicOrbicurveMorphismData source target
```

It contains:

```text
label : String
morphismExists : Prop
morphismExists_holds : morphismExists
```

The finite etale Galois cover certificate now stores:

```text
coverMorphism :
  HyperbolicOrbicurveMorphismData sourceOrbicurve targetOrbicurve
```

instead of:

```text
coverMapLabel : String
```

The certificate namespace exposes:

```text
coverMorphismExists
```

### Lean Decisions

This is another small replacement of a loose placeholder by typed data. The
morphism is still not a mathlib algebraic-geometry morphism; it is a typed
placeholder because our current `HyperbolicOrbicurveModel` is itself a typed
placeholder. But Lean now enforces that the cover morphism has the same source
and target orbicurves as the cover certificate.

### What This Tests

The example file checks:

* construction of a typed orbicurve morphism placeholder;
* extraction of its existence proof;
* construction of a finite etale Galois cover certificate using the morphism;
* extraction of the cover morphism existence proof from the certificate;
* all downstream theta function-field consequences still compile.

### Design Trap Avoided

The trap would be to let `coverMapLabel : String` stand in for geometry. A label
cannot enforce source and target. The typed morphism placeholder is still
abstract, but it pins the morphism to the intended orbicurves.

### Remaining Gap

The next step is to replace `morphismExists`, `finiteEtaleCover`, and
`galoisCover` with typed morphism properties, then eventually connect those
properties to mathlib's finite etale morphism APIs when the orbicurve model is
made concrete.

## Math Milestone 60: Finite-Etale/Galois Properties Indexed by the Cover Morphism

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, uses the open subgroup `Pi_XK <= Pi_CK` to reconstruct
the function field of `X_K` with its natural
`Gal(X_K/C_K) = Pi_CK/Pi_XK` action. The finite-etale/Galois language belongs
to this specific cover relation. Earlier in IUT I, Mochizuki also states that
finite-etale coverings of hyperbolic orbicurves and the corresponding open
immersions of profinite groups are part of the basic setup.

Scholze-Stix's exposition deliberately omits many such covers in its simplified
discussion of initial theta data. That is useful as a warning: our formal model
must keep clear which assertions are attached to the cover itself, so that later
simplifications cannot silently identify unrelated data.

### Lean/API Check

The new record is:

```text
FiniteEtaleGaloisOrbicurveMorphismData morphism
```

It contains:

```text
finiteEtale : Prop
finiteEtale_holds : finiteEtale
galois : Prop
galois_holds : galois
```

and exposes:

```text
finiteEtale_proof
galois_proof
finiteEtaleAndGalois
```

The cover certificate now stores:

```text
coverProperties :
  FiniteEtaleGaloisOrbicurveMorphismData coverMorphism
```

instead of storing independent `finiteEtaleCover` and `galoisCover` fields.
The old public accessors remain as derived certificate definitions:

```text
ThetaFiniteEtaleGaloisCoverCertificate.finiteEtaleCover
ThetaFiniteEtaleGaloisCoverCertificate.galoisCover
```

### Lean Decisions

This is still an abstract interface, not a completed scheme-theoretic finite
etale morphism. The improvement is dependency: Lean now knows that the
finite-etale and Galois assertions are about the same typed morphism that
connects the source and target orbicurves in the certificate.

The downstream `ThetaFiniteGaloisFunctionFieldCoverData` API remains stable
because `finiteEtaleCover` and `galoisCover` are recovered from the indexed
property package.

### What This Tests

The example file checks:

* construction of finite-etale/Galois properties for a fixed orbicurve morphism;
* extraction of the conjunction of those properties;
* construction of the theta finite-etale Galois cover certificate from the
  indexed property package;
* all downstream finite-Galois function-field cover consequences still compile.

### Design Trap Avoided

The trap would be to allow one typed cover morphism but prove finite-etale and
Galois facts about unrelated unnamed geometry. The new indexed property record
prevents that: the assertions are parameterized by the morphism.

### Remaining Gap

`finiteEtale` and `galois` are still propositions supplied by the user of the
interface. The next mathematical step is to bind the function-field extension
claim to the same morphism and the same `B -> L` field extension, then later
replace these propositions with mathlib-backed finite-etale and Galois-cover
notions once the orbicurve category is made concrete.

## Math Milestone 61: Function-Field Extension Indexed by the Cover Morphism

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, says that in the theta approach one applies the
reconstruction algorithm to `Pi_XK <= Pi_CK` to reconstruct the function field
of `X_K`, equipped with its natural `Gal(X_K/C_K) = Pi_CK/Pi_XK` action. This
means the function-field extension should be attached to the same cover/open
subgroup data as the finite-etale/Galois cover claim.

Definition 3.1(d) also frames the setup in terms of finite-etale coverings of
hyperbolic orbicurves and the corresponding open immersions of profinite groups.
Scholze-Stix's simplification notes that many IUT covers are omitted from their
discussion. For our formalization, this reinforces the need to keep the cover,
function field, and Galois action dependencies explicit.

### Lean/API Check

The new record is:

```text
FunctionFieldExtensionOfOrbicurveCoverData morphism B L
```

with typeclass assumptions:

```text
[Field B] [Field L] [Algebra B L]
[FiniteDimensional B L] [IsGalois B L]
```

It contains:

```text
extensionOfCover : Prop
extensionOfCover_holds : extensionOfCover
```

and exposes:

```text
extensionOfCover_proof
```

The cover certificate now stores:

```text
functionFieldExtension :
  FunctionFieldExtensionOfOrbicurveCoverData coverMorphism B L
```

instead of storing independent fields:

```text
functionFieldExtensionOfCover : Prop
functionFieldExtensionOfCover_holds : functionFieldExtensionOfCover
```

The public accessor remains as a derived certificate definition:

```text
ThetaFiniteEtaleGaloisCoverCertificate.functionFieldExtensionOfCover
```

### Lean Decisions

This is still not a construction of function fields of orbicurves. It is an
indexed certificate: the claim that `B -> L` is the function-field extension of
the cover is now parameterized by the cover morphism and by the same finite
Galois field extension used by the algebraic deck-action package.

This keeps the current API usable while eliminating another free-floating
geometric proposition from the certificate.

### What This Tests

The example file checks:

* construction of a function-field extension certificate for a fixed cover
  morphism and a fixed finite Galois extension `B -> L`;
* extraction of the extension proof from that certificate;
* construction of the theta cover certificate using the indexed
  function-field extension certificate;
* all downstream finite-Galois function-field cover consequences still compile.

### Design Trap Avoided

The trap would be to let the geometric cover and the algebraic extension remain
parallel, unlinked assumptions. The new record forces the proposition
`extensionOfCover` to mention exactly which cover morphism and which field
extension it concerns.

### Remaining Gap

The record still accepts `extensionOfCover` as a supplied proposition. The next
step is to bind the deck quotient/automorphism equivalence to the same
function-field extension certificate, so the quotient action can no longer be
attached to an unrelated `B -> L` model.

## Math Milestone 62: Deck Quotient Action Indexed by the Function-Field Extension

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, states that the theta approach reconstructs the function
field of `X_K` from `Pi_XK <= Pi_CK` together with its natural
`Gal(X_K/C_K) = Pi_CK/Pi_XK` action. The action is therefore not independent of
the reconstructed function field: it belongs to the same cover/function-field
package.

The source also uses quotient descriptions such as `Gal(X/C) = Pi_C/Pi_X` in
the reconstruction discussion around Corollary 1.2. Scholze-Stix emphasize that
Mochizuki's anabelian equivalence lets one pass between finite-etale geometry
and fundamental-group data. Our formalization should keep the quotient action
visibly tied to the reconstructed field instead of treating it as an arbitrary
automorphism equivalence.

### Lean/API Check

The new record is:

```text
DeckQuotientFunctionFieldActionData thetaApproach functionFieldExtension
```

where:

```text
functionFieldExtension :
  FunctionFieldExtensionOfOrbicurveCoverData morphism B L
```

It contains:

```text
quotientEquivAlgAut :
  ThetaApproachQuotientData.deckQuotient thetaApproach ≃* (L ≃ₐ[B] L)
```

and exposes:

```text
toAlgAutEquiv
```

The cover certificate now stores:

```text
quotientAction :
  DeckQuotientFunctionFieldActionData thetaApproach functionFieldExtension
```

instead of storing the bare quotient-to-automorphism equivalence directly.
The old public accessor remains as a derived definition:

```text
ThetaFiniteEtaleGaloisCoverCertificate.quotientEquivAlgAut
```

### Lean Decisions

The quotient-to-automorphism equivalence is still supplied as data. What changed
is the dependency: it is now indexed by the function-field extension certificate
that already names the cover morphism and the finite Galois extension `B -> L`.

This lets existing downstream constructors continue to use the old accessor,
while the certificate itself now records that the quotient action is the action
on the specified function-field extension.

### What This Tests

The example file checks:

* construction of a quotient action certificate for a fixed indexed
  function-field extension;
* recovery of the underlying algebra automorphism equivalence;
* construction of the theta finite-etale Galois cover certificate from the
  indexed quotient action;
* all downstream finite-Galois function-field cover consequences still compile.

### Design Trap Avoided

The trap would be to attach an arbitrary equivalence
`deckQuotient thetaApproach ≃* (L ≃ₐ[B] L)` to a cover certificate without
forcing it to act on the specific function-field extension produced by that
cover. The new action certificate removes that extra degree of freedom.

### Remaining Gap

The equivalence is still an input, not derived from the finite-etale Galois
cover. A later milestone should express the compatibility between this quotient
action and the already formalized `Pi_CK` action through the quotient hom, then
work toward deriving the equivalence from concrete cover/deck transformation
data.

## Math Milestone 63: Reconstruction Compatibility Indexed by the Quotient Action

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, presents the theta approach as reconstructing the function
field of `X_K` from `Pi_XK <= Pi_CK`, equipped with the natural
`Gal(X_K/C_K) = Pi_CK/Pi_XK` action. Thus the two claims

```text
the reconstructed field is the function field of X_K
the deck action is the natural Gal(X_K/C_K) action
```

belong to the same quotient-action package. Definition 3.1(d) also keeps the
finite-etale covering diagrams and open immersions of profinite groups together.

Scholze-Stix stress that Mochizuki's anabelian theorem identifies the relevant
finite-etale geometry with fundamental-group data in the essential situation.
For us this is a guardrail: the formal model should not let reconstruction and
quotient-action claims float independently of the chosen quotient action.

### Lean/API Check

The new record is:

```text
ThetaFunctionFieldActionCompatibilityData quotientAction
```

where:

```text
quotientAction :
  DeckQuotientFunctionFieldActionData thetaApproach functionFieldExtension
```

It contains:

```text
reconstructedFunctionFieldOfXK : Prop
reconstructedFunctionFieldOfXK_holds : reconstructedFunctionFieldOfXK
deckActionMatchesGalQuotient : Prop
deckActionMatchesGalQuotient_holds : deckActionMatchesGalQuotient
```

and exposes:

```text
reconstructedFromXK
deckActionMatchesQuotient
```

The finite-Galois cover package now stores:

```text
actionCompatibility :
  ThetaFunctionFieldActionCompatibilityData coverCertificate.quotientAction
```

instead of storing `reconstructedFunctionFieldOfXK` and
`deckActionMatchesGalQuotient` as independent fields.

### Lean Decisions

This is another dependency-tightening move. The two assertions remain abstract
propositions, but they are now indexed by the exact quotient action certificate
that is already indexed by the function-field extension and cover morphism.

The previous public names remain available as derived definitions/proofs on
`ThetaFiniteGaloisFunctionFieldCoverData`, so downstream function-field
constructions and fixed-field theorems continue to compile unchanged.

### What This Tests

The example file checks:

* construction of compatibility data for a fixed quotient action;
* extraction of both reconstruction and deck-action claims;
* construction of the finite-Galois cover package from this compatibility data;
* all downstream consequences: theta function-field package extraction,
  deck-ring action, fixed-field theorem, and exact `Pi_CK` kernel.

### Design Trap Avoided

The trap would be to package a quotient action indexed by one function-field
extension, but then separately assert reconstruction/action compatibility for a
different or unnamed object. Indexing the compatibility record by
`quotientAction` prevents this mismatch.

### Remaining Gap

The compatibility claims are still supplied as propositions. The next step is
to expose a named theorem at the finite-Galois cover level showing that the
induced `Pi_CK` action factors through the stored quotient action, then use that
as the formal bridge toward deriving the compatibility from concrete
fundamental-group and cover data.

## Math Milestone 64: Finite-Cover-Level `Pi_CK` Action Factorization

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, says the theta approach reconstructs the function field of
`X_K` with the natural action of
`Gal(X_K/C_K) = Pi_CK/Pi_XK`. This means the `Pi_CK` action on the reconstructed
function field should factor through the quotient map

```text
Pi_CK -> Pi_CK / Pi_XK.
```

The reconstruction discussion around Corollary 1.2 also uses quotient
descriptions such as `Gal(X/C) = Pi_C/Pi_X`. Scholze-Stix's summary stresses
that, in the essential anabelian situation, the fundamental-group and
finite-etale geometric pictures are equivalent. The factorization theorem is a
formal way to keep that quotient dependence visible.

### Lean/API Check

The finite-Galois cover namespace now exposes:

```text
ThetaFiniteGaloisFunctionFieldCoverData.piCKRingAut_apply_eq_deckRingAut
```

which states pointwise that the `Pi_CK` automorphism of the reconstructed
function field is the deck automorphism indexed by
`ThetaApproachQuotientData.quotientHom thetaApproach g`.

It also exposes:

```text
ThetaFiniteGaloisFunctionFieldCoverData.piCKRingAut_apply_eq_quotientAction
```

which rewrites the same action through the stored quotient-action equivalence
to algebra automorphisms, and:

```text
ThetaFiniteGaloisFunctionFieldCoverData.piCKRingAutHom_eq_deckRingAutHom_comp
```

which states the hom-level factorization:

```text
piCKRingAutHom =
  deckRingAutHom.comp (ThetaApproachQuotientData.quotientHom thetaApproach)
```

### Lean Decisions

This milestone does not add new assumptions. It packages an already available
theorem from `ThetaApproachFunctionFieldData` at the finite-Galois cover level,
where the cover certificate, function-field extension, quotient action, and
compatibility data are all present.

The pointwise theorem and hom-level theorem are both useful. The pointwise form
is easier to read in later arithmetic statements, while the hom-level form is
the cleaner categorical/group-action statement.

### What This Tests

The example file checks:

* pointwise `Pi_CK` action equals deck action after applying `quotientHom`;
* pointwise `Pi_CK` action equals the stored quotient-action equivalence;
* the monoid hom from `Pi_CK` to field automorphisms factors as deck action
  composed with `quotientHom`;
* all previous kernel and fixed-field consequences still compile.

### Design Trap Avoided

The trap would be to keep using the exact-kernel theorem without a named
factorization theorem at the cover level. The kernel theorem is stronger in one
direction, but it hides the basic mechanism: `Pi_CK` acts by first passing to
`Pi_CK/Pi_XK`. This milestone makes the mechanism explicit.

### Remaining Gap

The factorization is proved for the current algebraic action model. We still
need to derive the quotient-action equivalence itself from concrete
finite-etale deck transformations of the orbicurve cover.

## Math Milestone 65: Finite-Cover-Level `Pi_XK` Triviality

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, identifies the natural action on the reconstructed
function field as the action of

```text
Gal(X_K/C_K) = Pi_CK/Pi_XK.
```

Thus elements coming from the open subgroup `Pi_XK <= Pi_CK` should act
trivially after passing to the quotient action. Definition 3.1(d) keeps the
open subgroup/finite-etale covering picture in the same setup, and the
Corollary 1.2 reconstruction discussion also uses quotient descriptions such as
`Gal(X/C) = Pi_C/Pi_X`.

### Lean/API Check

The finite-Galois cover namespace now exposes:

```text
ThetaFiniteGaloisFunctionFieldCoverData.piXK_smul_trivial
```

for the raw induced action on the reconstructed function-field type,

```text
ThetaFiniteGaloisFunctionFieldCoverData.piXKRingAut_apply
```

for the corresponding ring-automorphism action on the concrete field `L`, and

```text
ThetaFiniteGaloisFunctionFieldCoverData.piXK_to_piCK_mem_piCKRingAutHom_ker
```

for the kernel membership of every embedded `Pi_XK` element.

### Lean Decisions

The smul theorem is stated over

```text
cover.toThetaApproachFunctionFieldData.functionField
```

rather than directly over `L`, because Lean's typeclass search needs the
reconstructed action instance in scope. The ring-automorphism theorem is stated
over `L`, which is the convenient form for later field calculations.

### What This Tests

The example file checks:

* embedded `Pi_XK` elements act trivially by smul;
* embedded `Pi_XK` elements act trivially by the induced ring automorphism;
* embedded `Pi_XK` elements lie in the kernel of the `Pi_CK` automorphism hom;
* the existing exact-kernel theorem still compiles.

### Design Trap Avoided

The trap would be to rely only on the abstract kernel equality and never expose
the elementwise consequence needed in later calculations. This milestone gives
both the elementwise action statement and the kernel-membership statement.

### Remaining Gap

These theorems still use the current algebraic action model. The next deeper
step is to connect the finite-etale cover certificate to a typed deck
transformation group of the cover itself, so the quotient action can eventually
be derived rather than supplied.

## Math Milestone 66: Typed Deck-Transformation Group for the Cover

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, identifies the relevant action as the natural
`Gal(X_K/C_K) = Pi_CK/Pi_XK` action on the reconstructed function field.
Definition 3.1(d) frames the setup in terms of finite-etale coverings of
hyperbolic orbicurves and corresponding open immersions of profinite groups.
Elsewhere in IUT I, Mochizuki uses cover automorphism groups such as
`Aut_K(X_K)` and Galois groups such as `Gal(X/C)` in the analysis of the cover
geometry.

Scholze-Stix emphasize that finite-etale geometry and fundamental-group data
are equivalent in the relevant anabelian setting. For the formalization, this
means the passage from cover geometry to `Pi_CK/Pi_XK` should have an explicit
typed attachment point.

### Lean/API Check

The new cover-indexed deck group record is:

```text
OrbicurveCoverDeckTransformationData coverProperties
```

It contains:

```text
deckGroup : Type
deckGroupGroup : Group deckGroup
deckTransformationsOfCover : Prop
deckTransformationsOfCover_holds : deckTransformationsOfCover
```

The new quotient-comparison record is:

```text
OrbicurveCoverDeckQuotientData thetaApproach deckData
```

It contains an equivalence:

```text
deckData.deckGroup ≃* ThetaApproachQuotientData.deckQuotient thetaApproach
```

and a proposition recording that this deck group is the theta quotient.

The finite-etale Galois cover certificate now stores:

```text
coverDeckTransformations :
  OrbicurveCoverDeckTransformationData coverProperties

coverDeckQuotient :
  OrbicurveCoverDeckQuotientData thetaApproach coverDeckTransformations
```

### Lean Decisions

This milestone does not yet construct deck transformations as automorphisms of
orbicurves over the target. It inserts a typed intermediate object between the
cover certificate and the quotient action on the function field.

The deck group is indexed by the finite-etale/Galois property package of the
same cover morphism. The comparison to the theta quotient is indexed by that
deck group, so later concrete deck-transformation constructions can replace the
abstract proposition without changing the surrounding API.

### What This Tests

The example file checks:

* construction of a deck-transformation group for a fixed finite-etale Galois
  cover property package;
* construction of a comparison between that deck group and the theta quotient;
* construction of the theta finite-etale Galois cover certificate with the deck
  group and quotient comparison;
* extraction of the deck-transformation and quotient-identification proofs.

### Design Trap Avoided

The trap would be to move directly from the cover certificate to an automorphism
equivalence on a field, with no object corresponding to deck transformations of
the cover. The new records keep the geometric deck group visible.

### Remaining Gap

The deck group is still supplied abstractly. The next step is to add a typed
interface for deck transformations as automorphisms of the source orbicurve over
the target morphism, then connect that interface to this deck group.

## Math Milestone 67: Deck Transformations as Over-Target Automorphisms

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I uses finite-etale coverings of hyperbolic orbicurves together with
corresponding fundamental-group/open-immersion data. Remark 3.1.2 identifies the
relevant action as `Gal(X_K/C_K) = Pi_CK/Pi_XK`, while the surrounding cover
automorphism discussions use automorphism groups such as `Aut_K(X_K)` and
Galois groups such as `Gal(X/C)`.

For a geometric cover, a deck transformation is an automorphism of the source
lying over the target cover morphism. Since our orbicurve model is still
abstract, this milestone records that shape explicitly without claiming a
scheme-theoretic construction.

### Lean/API Check

The new source-automorphism placeholder is:

```text
HyperbolicOrbicurveAutomorphismOverData coverMorphism
```

It records:

```text
automorphismExists : Prop
inverseExists : Prop
overTarget : Prop
```

The new deck-realization record is:

```text
OrbicurveCoverDeckAutomorphismRealizationData deckData
```

with:

```text
deckAutomorphism :
  deckData.deckGroup -> HyperbolicOrbicurveAutomorphismOverData morphism
realizesDeckTransformations : Prop
```

The finite-etale Galois cover certificate now stores:

```text
coverDeckAutomorphisms :
  OrbicurveCoverDeckAutomorphismRealizationData coverDeckTransformations
```

and exposes accessors/proofs that a deck-group element gives an existing,
invertible, over-target source automorphism.

### Lean Decisions

This is still a typed abstraction. We do not yet define composition of
orbicurve morphisms or prove that these automorphisms form the deck group.
Instead, we make the intended geometric meaning of the abstract deck group
visible and type-indexed by the cover morphism.

### What This Tests

The example file checks:

* construction of an over-target source automorphism for a cover morphism;
* construction of a realization of the abstract deck group by such
  automorphisms;
* extraction of the over-target proof for a deck element;
* construction of the cover certificate with the deck-realization field;
* certificate-level access to existence and over-target facts.

### Design Trap Avoided

The trap would be to call a group a "deck group" while never connecting its
elements to automorphisms of the source over the target. This milestone makes
that connection explicit, even though the actual composition law remains
abstract.

### Remaining Gap

The next step is to formalize the compatibility between deck-group
multiplication and composition of the over-target automorphism placeholders, or
to introduce a more concrete category of orbicurve morphisms where that
composition can be expressed directly.

## Math Milestone 68: Group-Law Compatibility for Deck Automorphism Realization

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I treats `Gal(X_K/C_K) = Pi_CK/Pi_XK` as a group acting naturally on the
reconstructed function field. The cover automorphism discussions also use
groups such as `Aut_K(X_K)` and `Gal(X/C)`, where the group law is composition
of automorphisms. Thus a realization of a deck group by automorphisms of the
source over the target must eventually respect identity and multiplication.

At our current abstraction level, orbicurve morphism composition is not yet
formalized. This milestone records the group-law obligations without inventing
a fake composition operation.

### Lean/API Check

The new record is:

```text
OrbicurveCoverDeckAutomorphismGroupLawData realization
```

where:

```text
realization :
  OrbicurveCoverDeckAutomorphismRealizationData deckData
```

It contains:

```text
identityCompatible : Prop
identityCompatible_holds : identityCompatible
multiplicationCompatible : Prop
multiplicationCompatible_holds : multiplicationCompatible
```

and exposes:

```text
identityCompatible_proof
multiplicationCompatible_proof
compatible
```

The cover certificate now stores:

```text
coverDeckAutomorphismGroupLaw :
  OrbicurveCoverDeckAutomorphismGroupLawData coverDeckAutomorphisms
```

### Lean Decisions

The compatibility is a separate record indexed by the realization, rather than
extra fields on the deck group. This keeps the distinction clear:

* `OrbicurveCoverDeckTransformationData` names the abstract deck group;
* `OrbicurveCoverDeckAutomorphismRealizationData` assigns over-target
  automorphisms to group elements;
* `OrbicurveCoverDeckAutomorphismGroupLawData` states that the assignment
  respects the group law.

### What This Tests

The example file checks:

* construction of group-law compatibility data for a realization;
* extraction of identity and multiplication compatibility together;
* construction of the cover certificate with the group-law field;
* certificate-level recovery of the compatibility conjunction.

### Design Trap Avoided

The trap would be to regard any function from the abstract deck group to
over-target automorphism placeholders as a group realization. This milestone
separates mere assignment from group-law compatibility.

### Remaining Gap

The identity and multiplication compatibility assertions are still propositions.
To make them mathematical the next step is either to define a concrete
composition interface for `HyperbolicOrbicurveAutomorphismOverData`, or to
replace the placeholder orbicurve model with a category-theoretic model where
automorphism composition is already available.

## Math Milestone 69: Composite Cover-Deck Action on the Reconstructed Field

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

IUT I, Remark 3.1.2, describes the theta approach as reconstructing the
function field of `X_K` together with the natural
`Gal(X_K/C_K) = Pi_CK/Pi_XK` action. The preceding milestones had separated
two parts of this assertion:

* the deck group of the finite etale Galois cover is compared with the theta
  quotient;
* the theta quotient acts on the reconstructed function field by
  `B`-algebra automorphisms.

This milestone composes these two already-visible maps. It does not add a new
axiom or a new identification.

### Lean/API Check

The cover certificate now exposes:

```text
ThetaFiniteEtaleGaloisCoverCertificate.coverDeckEquivAlgAut
```

with type:

```text
certificate.coverDeckGroup ≃* (L ≃ₐ[B] L)
```

It is definitionally the composite:

```text
coverDeckEquivThetaQuotient.trans quotientEquivAlgAut
```

The function-field cover wrapper exposes the same composite as:

```text
ThetaFiniteGaloisFunctionFieldCoverData.coverDeckEquivAlgAut
```

and proves:

```text
coverDeckAlgAut_apply
coverDeckRingAut_apply_eq_coverDeckAlgAut
coverDeck_fixed_iff_in_base
```

The last theorem restates the fixed-field criterion using actual cover-deck
group elements, transported through the explicit equivalence with the theta
quotient.

### Lean Decisions

This was implemented as a derived definition rather than a new field. That is
important: a user cannot supply an arbitrary cover-deck action on the field.
Lean forces the action to pass through the existing quotient comparison and
the existing quotient-to-automorphism equivalence.

The fixed-field theorem over cover-deck elements is also derived from the
theta-quotient fixed-field theorem by surjectivity of the deck quotient
equivalence. This keeps the proof honest about the exact bridge being used.

### What This Tests

The example file checks:

* the composite cover-deck algebra automorphism is the quotient action after
  applying `coverDeckEquivThetaQuotient`;
* the reconstructed deck-ring automorphism attached to the corresponding
  theta quotient agrees with the composite cover-deck automorphism;
* the fixed-field characterization can be phrased over the cover deck group.

### Design Trap Avoided

The trap would be to introduce a second action of the cover deck group on the
reconstructed field and merely assert that it is compatible. This milestone
instead uses composition of already-indexed equivalences, so there is one
visible path from cover geometry to field automorphisms.

### Remaining Gap

This still relies on supplied quotient and action equivalences. The next
mathematical improvement should either reduce opacity in the orbicurve
automorphism layer by adding a real composition interface, or return to the
Stage 1 SHE/HDD common-container layer where the Corollary 3.12 dispute
directly lives.

## Math Milestone 70: Composition Compatibility for Deck Automorphisms

Lean files:

* `Iut/Foundations/InitialThetaData.lean`
* `Iut/Foundations/InitialThetaDataExample.lean`

### Source Check

The deck transformations of a Galois cover are not merely a set of maps. They
form a group under composition of automorphisms of the source over the target.
IUT I uses this kind of group language when it identifies the deck/Galois
quotient with the action on the reconstructed function field.

The previous milestone recorded group-law compatibility only as named
propositions. That was honest but still too opaque. This milestone introduces
an explicit interface for identity, composition, and inverse operations on
over-target orbicurve automorphisms, and then states deck identity and deck
multiplication compatibility as actual equalities against that interface.

### Lean/API Check

The new operation interface is:

```text
HyperbolicOrbicurveAutomorphismCompositionData coverMorphism
```

with fields:

```text
identityAutomorphism
composeAutomorphism
inverseAutomorphism
```

All three operations are indexed by the same cover morphism. The API exposes
that the resulting identity, composite, and inverse automorphisms still lie
over the target.

The equation-level compatibility record is:

```text
OrbicurveCoverDeckAutomorphismCompositionCompatibilityData
  realization composition
```

with the core statements:

```text
realization.deckAutomorphism 1 = composition.identityAutomorphism

realization.deckAutomorphism (g * h) =
  composition.composeAutomorphism
    (realization.deckAutomorphism g)
    (realization.deckAutomorphism h)
```

The cover certificate now stores both the composition interface and this
compatibility witness, and exposes:

```text
coverDeckAutomorphism_identity_eq
coverDeckAutomorphism_mul_eq_comp
```

### Lean Decisions

The interface is still supplied data because we have not yet formalized the
category of hyperbolic orbicurves and morphisms. The important improvement is
that the group-law compatibility is no longer an inert proposition. It now
mentions concrete operations and concrete equalities.

This is a middle layer: later, a true category-theoretic or algebraic-geometric
model should replace the supplied operations with actual identity,
composition, and inverse constructions.

### What This Tests

The example file checks:

* construction of the over-target automorphism composition interface;
* extraction that the identity automorphism is over the target;
* construction of deck-composition compatibility;
* recovery of the multiplication compatibility equality for deck elements;
* certificate-level recovery of the deck identity and deck multiplication
  equalities.

### Design Trap Avoided

The trap would be to leave "respects multiplication" as a phrase-like field
forever. This milestone forces the statement to name the composition operation
and the exact equality it satisfies.

### Remaining Gap

The composition operation itself is not yet derived from a category of
orbicurves. Also, this is still reconstruction-layer mathematics: it does not
settle the Hodge-theater common-container issue in IUT III Corollary 3.12.
The next global step should either continue replacing supplied reconstruction
interfaces with typed constructions, or return to the SHE/HDD comparison layer
with the same explicit-history discipline.

## Math Milestone 71: Pilot Placement in Structured SHE Compatibility

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Theorem 3.11 to Corollary 3.12 is not just an endpoint inequality. The debated
part of the route uses simultaneous holomorphic expressibility to place data
from distinct Hodge-theater histories into a common expression setting. The
formal model therefore must remember not only that a SHE datum exists, but also
which side each pilot datum belongs to and that the simultaneous expression
claim is actually present.

The existing `StructuredSHEContext` already had these fields:

```text
q_pilot_in_codomain
theta_pilot_in_domain
simultaneous_valid
histories_not_identified
```

Before this milestone, the common-container compatibility checklist retained
the history-separation field but did not carry the q-pilot placement,
Theta-pilot placement, or simultaneous-validity witness.

### Lean/API Check

The record:

```text
IUTStage1Theorem311StructuredSHECommonContainerCompatibility
```

now includes:

```text
q_pilot_in_codomain
theta_pilot_in_domain
simultaneous_valid
```

in addition to the existing SHE-arrow equality, certificate equality,
common-container context equality, and history-separation proof.

The constructor:

```text
IUTStage1Theorem311StructuredSHECommonContainerCompatibility.ofStructuredSHE
```

fills these fields directly from the structured SHE context. The namespace now
exposes:

```text
qPilotTheater_eq_codomain
thetaPilotTheater_eq_domain
simultaneousValid
```

### Lean Decisions

This is not a new way to prove Corollary 3.12. It is a stronger audit object
for the SHE/common-container portion of the route. The purpose is to prevent a
future proof from treating SHE as a single inert equality between the common
container arrow and the certificate.

The q-pilot and Theta-pilot placements remain equalities internal to the SHE
context. They are not equalities between the domain and codomain Hodge-theater
histories. The existing `histories_not_identified` guard remains part of the
same compatibility object.

### What This Tests

The source example checks that the toy structured SHE input supplies:

* q-pilot placement in the codomain holomorphic structure;
* Theta-pilot placement in the domain holomorphic structure;
* simultaneous-validity evidence;
* the existing common-container context match.

### Design Trap Avoided

The trap would be to let the common-container route remember only a final
shared context and forget which pilot data were valid on which side. This
milestone keeps the source/codomain placement and simultaneous-validity witness
available at the same point where the common-container comparison is audited.

### Remaining Gap

The predicate `simultaneous_valid` is still an abstract proposition. To get
closer to Mochizuki's actual Stage 1 mathematics, later milestones must refine
what counts as simultaneous expression, and must connect that refinement to
the HDD-after-SHE comparison without hiding real-line-copy or history
identifications.

## Math Milestone 72: Structured Local Validity for SHE

Lean files:

* `Iut/Foundations/QualitativeData.lean`
* `Iut/Stage1/ToyQualitativeOutput.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

SHE is supposed to express simultaneous holomorphic validity across distinct
Hodge-theater contexts, not merely assert a final equality of common-container
labels. The previous formalization had improved placement and history
tracking, but still stored the local validity content as one proposition:

```text
simultaneous_valid : Prop
```

That was too coarse for later auditing of the 3.11 to 3.12 transition. The
formal model now separates local validity claims before recombining them.

### Lean/API Check

The new witness is:

```text
QualitativeData.SimultaneousHolomorphicExpressionData
```

with fields for:

```text
domain_expression_valid
codomain_expression_valid
q_pilot_expression_valid
theta_pilot_expression_valid
simultaneous_valid
```

The `StructuredSHEContext` now stores:

```text
simultaneousExpression : SimultaneousHolomorphicExpressionData
```

instead of a bare `simultaneous_valid` proposition. The old public shape is
preserved by a derived definition:

```text
StructuredSHEContext.simultaneous_valid
```

and the namespace exposes:

```text
domainExpressionValid
codomainExpressionValid
qPilotExpressionValid
thetaPilotExpressionValid
simultaneousValid
allLocalExpressionValid
```

### Lean Decisions

This is still an abstract validity layer: each component is a proposition with
a proof. But it is now structured enough that future work can replace one
component at a time with a real definition, rather than replacing a monolithic
black box.

The downstream Stage 1 API continues to use `context.simultaneous_valid`, so
the higher route remains stable. Internally, that proposition is now derived
from the structured witness.

### What This Tests

The toy qualitative output constructs a `SimultaneousHolomorphicExpressionData`
with trivial local witnesses, and proves an `allLocalExpressionValid` theorem.
The source example still builds through the strengthened common-container
compatibility, confirming that the refactor does not break the audited route.

### Design Trap Avoided

The trap would be to let "SHE is valid" remain indivisible. If the later
dispute turns on which side was expressed where, or which piece of the
holomorphic data was valid in the shared language, a monolithic validity
predicate would hide the issue. This milestone makes those pieces separately
addressable.

### Remaining Gap

The local validity components are still not Mochizuki's actual analytic and
arithmetic definitions. The next refinement should either give one component a
more concrete meaning, or connect the structured validity data more tightly to
the HDD-after-SHE bridge while preserving the explicit real-line and history
guards.

## Math Milestone 73: SHE Validity Carried by the HDD-after-SHE Audit

Lean files:

* `Iut/Foundations/QualitativeData.lean`
* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`
* `Iut/Stage1/ToyQualitativeOutput.lean`

### Source Check

Mochizuki's formalization report isolates the final 3.11-to-3.12 transition
around the fourth-triangle `(HDD) o (SHE)` comparison and the simultaneous
common-container reading. If our formal route has an audited HDD-after-SHE
bound, it should not be possible to inspect that bound while forgetting the
SHE validity data that is supposed to restrict the comparison.

Before this milestone, the audited HDD-after-SHE bound carried common-container
compatibility and history separation, but it did not directly carry the full
structured local SHE-validity witness.

### Lean/API Check

The local SHE-validity conjunction is now named as:

```text
SimultaneousHolomorphicExpressionData.AllLocalValid
```

The audited fourth-triangle object:

```text
IUTStage1Theorem311AuditedHDDSHEBound
```

now stores:

```text
local_expression_valid :
  bundle.structuredSHE.context.simultaneousExpression.AllLocalValid
```

and exposes:

```text
localExpressionValid
qPilotExpressionValid
thetaPilotExpressionValid
simultaneousValid
```

The constructor from structured SHE inputs fills this field from the
`StructuredSHEContext`, not from the bound data.

### Lean Decisions

This does not make SHE imply a numerical bound. The bound still comes from the
charted common-container/common-target machinery. The new field simply ensures
that the audited `(HDD) o (SHE)` checkpoint keeps the SHE-local validity witness
in scope at the same time as the target-volume bound.

This is an anti-drift move in the mathematical layer: it keeps the fourth
triangle from degenerating into a naked common-target bound detached from SHE.

### What This Tests

The source example proves that the toy audited HDD-after-SHE bound exposes
`AllLocalValid` for the structured SHE context. The full route still builds,
including the downstream target-volume, membership, raw inequality, and public
audit layers.

### Design Trap Avoided

The trap would be to say "HDD after SHE" while the Lean object only contains an
HDD/common-target bound. This milestone forces the audited object to carry the
SHE-local expression witness as part of the same proof checkpoint.

### Remaining Gap

The common-target bound itself is still supplied by the bridge layer. Future
work should make the bridge state more explicitly which SHE-validity component
it consumes, or refine one local validity component so it is no longer an
abstract proposition.

## Math Milestone 74: Charted Readings at the Signed Payload Boundary

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The final Corollary 3.12-style payload compares signed q-side and Theta-side
real numbers. For the disputed transition, it is essential that these reals
remain tied to explicit real-line-copy charts. Otherwise a proof could compare
raw real numbers while silently forgetting how the q-side and Theta-side copies
were read in the common target.

The pre-ledger already stored the charted q and Theta readings. This milestone
makes the final signed payload boundary carry them too.

### Lean/API Check

The record:

```text
IUTStage1Theorem311AuditedSignedPayloadBoundary
```

now stores:

```text
theta_chart_trivial
q_charted
theta_charted
```

beside the raw inequality, q-positivity, source normalization, and history
separation fields.

The namespace exposes:

```text
thetaChartTrivial
qCharted
thetaCharted
```

The constructor from a raw inequality and side conditions fills these chart
facts from the same pre-ledger data that supplies the final signed reals.

### Lean Decisions

This milestone does not change the numerical comparison. It changes the audit
surface of the final payload boundary. Any use of the signed payload can now
recover:

* the q-side point read through the q-to-target chart;
* the Theta-side point read through the Theta-to-target chart;
* the triviality of the Theta chart.

This keeps the real-line-copy discipline visible at the last step before the
public Corollary 3.12-shaped comparison data is formed.

### What This Tests

The source example proves that the toy audited signed payload boundary exposes
the q-charted and Theta-charted equations. The larger source example still
builds through the public-audit route.

### Design Trap Avoided

The trap would be to produce `qSigned <= thetaSigned` at the boundary while
forgetting that these signs came from charted q and Theta readings. This
milestone makes that forgetting impossible at the audited boundary type.

### Remaining Gap

The chart data are still abstract transports. Later work should refine the
chart conditions, especially any real-line-copy identifications that are
allowed or forbidden in the common-container comparison.

## Math Milestone 75: Charted Readings in the Public Audit

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The public audit is the most visible checkpoint for the current Stage 1 route.
If it exposes a Corollary 3.12-shaped comparison while hiding the charted q and
Theta readings inside an internal signed-payload boundary, then a later reader
has to chase definitions to verify that the real-line-copy discipline has been
preserved.

This milestone promotes the chart evidence to the public audit itself.

### Lean/API Check

The record:

```text
IUTStage1SourcePackage.AuditedPublicAudit
```

now stores:

```text
theta_chart_trivial
q_charted
theta_charted
```

and exposes:

```text
thetaChartTrivial
qCharted
thetaCharted
```

These fields are copied from the audited signed payload boundary. No new
comparison data or endpoint is introduced.

### Lean Decisions

This is intentionally redundant with the signed-payload boundary. The public
audit is the object a later endpoint audit is likely to quote, so the chart
facts should be recoverable there without unfolding the boundary.

The comparison remains the same:

```text
qSigned <= thetaSigned
```

but the public audit now also remembers how `qSigned` and `thetaSigned` were
read from their charted q-side and Theta-side points.

### What This Tests

The source example proves that the toy public audit exposes the q-charted and
Theta-charted equations. The full build verifies the downstream audit summaries
still compile.

### Design Trap Avoided

The trap would be an externally visible audit that shows only the final
inequality and Corollary-shaped statement. This milestone keeps the real-line
copy bookkeeping visible at that same public layer.

### Remaining Gap

The next refinement should state more explicitly which chart identifications
are allowed at the common-container level and which remain forbidden history
identifications.

## Math Milestone 76: Chart/History Discipline Checkpoint

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The central risk in the Corollary 3.12 dispute is not simply that real numbers
are compared, but that the comparison might silently identify histories or
containers that should remain distinct. The formal route now has public chart
facts and history-separation facts, but they lived as separate projections.

This milestone introduces a checkpoint that deliberately pairs them.

### Lean/API Check

The new record is:

```text
IUTStage1SourcePackage.AuditedChartHistoryDiscipline
```

It contains:

```text
public_audit
theta_chart_trivial
q_charted
theta_charted
common_container_context_matches
histories_not_identified
```

The constructor:

```text
AuditedChartHistoryDiscipline.ofStructuredInputsWithSHE
```

derives the chart facts from the public audit, the common-container context
match from the structured SHE bundle, and the history-separation proof from the
same structured SHE data.

### Lean Decisions

This is intentionally not a new endpoint. It is an audit checkpoint for the
kind of statement a human reader will want to inspect when asking whether the
common target has erased Hodge-theater history.

The record says:

* q is read through the q-to-target chart;
* Theta is read through the Theta-to-target chart;
* the Theta chart is trivial;
* the common-container context matches the structured SHE context;
* the domain and codomain Hodge-theater histories remain non-identified.

### What This Tests

The source example constructs the chart/history discipline checkpoint and
extracts its history-separation theorem. The full source example still builds
through public audit and route summary.

### Design Trap Avoided

The trap would be to check charts in one part of the route and history
separation in another, leaving no single object that states both. This
milestone provides exactly that object.

### Remaining Gap

The chart/history discipline is still an audit record. The next mathematical
step should refine the chart data itself: which transports are allowed, what
triviality means, and why these chart readings do not amount to ring- or
scheme-history identification.

## Math Milestone 77: Allowed Chart Transport Versus Forbidden History Identification

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The Corollary 3.12 dispute forces a distinction between two kinds of
operation:

* reading q-side and Theta-side quantities through an explicitly named
  real-comparison chart;
* identifying the underlying Hodge-theater histories.

The former is part of the formal comparison interface. The latter is precisely
what must remain forbidden unless justified by explicit data. This milestone
names that distinction in Lean.

### Lean/API Check

The new record is:

```text
IUTStage1SourcePackage.AuditedAllowedChartTransport
```

It is derived from:

```text
AuditedChartHistoryDiscipline
```

and stores:

```text
allowed_q_to_target_reading
allowed_theta_to_target_reading
theta_target_transport_trivial
forbidden_history_identification
```

The namespace exposes:

```text
allowedQToTargetReading
allowedThetaToTargetReading
forbiddenHistoryIdentification
```

### Lean Decisions

This is a semantic wrapper, not a new proof route. It does not assert any new
bound or endpoint. It repackages already-audited facts under names that match
the mathematical issue: chart transport is allowed as a reading operation, but
domain/codomain Hodge-theater history identification remains forbidden.

The constructor from structured inputs passes through the existing
chart/history discipline checkpoint, so this object cannot be supplied with an
unrelated chart or unrelated history guard.

### What This Tests

The source example constructs the allowed-chart-transport checkpoint and
extracts the forbidden-history-identification proof. The targeted source
example build passes.

### Design Trap Avoided

The trap would be to use chart transport language and history-identification
language interchangeably. This milestone gives the two roles separate names in
the type API.

### Remaining Gap

The allowed chart readings are still equations involving abstract transports.
Future milestones should refine `Transport` and `RealComparisonChartData` so
that the allowed transformations themselves have more mathematical content.

## Math Milestone 78: Chart-Level Transport Discipline

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestone named allowed chart transport at the source-audit layer.
This milestone moves part of that discipline down to the chart itself. The
reason is that real-line-copy transport should not be justified only after the
public audit has been assembled; the chart data should already say which
transports are being used as readings.

### Lean/API Check

The namespace:

```text
AlgorithmicOutput.RealComparisonChartData
```

now defines:

```text
QToTargetAllowedReading
ThetaToTargetAllowedReading
TransportDiscipline
transportDiscipline
qToTargetAllowedReading
thetaToTargetAllowedReading
```

The q-side allowed reading is modeled as pointwise equality of the named
q-to-target transport with itself. This is deliberately minimal: it states that
we are using the named chart transport as a chart reading, not replacing it by
some hidden map.

The Theta-side allowed reading is the existing explicit trivial-monodromy
condition on the target-side transport.

The source-level record:

```text
AuditedAllowedChartTransport
```

now carries:

```text
chart_transport_discipline :
  package.preLedger.chartedContainer.chart.TransportDiscipline
```

and exposes it via:

```text
chartTransportDiscipline
qToTargetAllowedAtChart
thetaToTargetAllowedAtChart
```

### Lean Decisions

This remains intentionally conservative. The q-side permission is not a claim
that the q-side Hodge-theater history is identified with the target-side
history. It is only a statement that the chart's own q-to-target transport is
the permitted reading map.

The Theta-side permission is stronger because the target-to-target transport
must be trivial. This matches the existing chart API and keeps the triviality
proof explicit.

### What This Tests

The source example now extracts the chart transport discipline from the audited
allowed-chart-transport checkpoint. The source example build verifies the new
chart-level API threads through the Stage 1 route.

### Design Trap Avoided

The trap would be to put all "allowed chart transport" language only in a
late-stage source audit. This milestone anchors the allowed-reading discipline
in the chart object itself, then carries it upward.

### Remaining Gap

The q-side allowed-reading predicate is still minimal. Later milestones should
make it more informative, for example by recording preservation properties
that are appropriate for real-line-copy readings but still do not identify
Hodge-theater histories.

## Math Milestone 79: Order Preservation for q-Side Chart Readings

Lean files:

* `Iut/Foundations/RealLineCopy.lean`
* `Iut/Foundations/AlgorithmicBridge.lean`

### Source Check

A real-line-copy chart transport should preserve the order structure used in
the final inequality. This is much weaker than identifying Hodge-theater
histories, but stronger than treating the q-side chart as a mere named map.

The existing `Transport` model uses positive scaling factors. Positivity is
exactly the property needed to prove order preservation of coordinates.

### Lean/API Check

The new transport theorem is:

```text
Transport.map_coord_le_map_coord
```

It states that if `x.coord <= y.coord`, then the transported coordinates also
satisfy the same order inequality.

The chart-level predicate:

```text
RealComparisonChartData.QToTargetAllowedReading
```

now means this order-preservation property for the chart's q-to-target
transport:

```text
forall x y, x.coord <= y.coord ->
  (Transport.map qToTarget x).coord <= (Transport.map qToTarget y).coord
```

The canonical chart `transportDiscipline` proves this using positivity of the
transport scale.

### Lean Decisions

This is a better local meaning for "allowed q-to-target reading" than a
tautological self-equality. It remains safely below history identification:
only order on real-line coordinates is transported.

The Theta-side discipline remains the explicit trivial-monodromy condition
already present in the chart data.

### What This Tests

The foundational chart bridge builds after the change, so downstream Stage 1
objects can continue to use `chart.TransportDiscipline` with the stronger
q-side interpretation.

### Design Trap Avoided

The trap would be to make allowed q-side chart transport mathematically empty.
This milestone gives it exactly the amount of structure needed for inequalities
while avoiding any claim about ring/scheme-history identification.

### Remaining Gap

The transport model is still only positive scaling between labeled real-line
copies. Later work should decide whether additional chart properties are
needed for the IUT log-volume comparison.

## Math Milestone 80: q-Pilot Sign Tied to the Charted q Reading

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The q-pilot positivity side condition is part of the final signed Corollary
3.12-style payload. It should be visibly about the q-side quantity read through
the real-comparison chart, not merely about an unrelated stored real number.

The pre-ledger already proves that the charted q-side point has coordinate
`qSigned` after applying the q-to-target chart. This milestone packages that
with the q-pilot positivity side condition.

### Lean/API Check

The new audit object is:

```text
IUTStage1SourcePackage.AuditedQPilotChartSign
```

It stores:

```text
allowed_chart_transport
q_charted
q_pilot_positive
charted_q_pilot_positive
```

The final field states positivity directly for the charted q-side reading:

```text
0 < - (Transport.map qToTarget qPoint).coord
```

The proof rewrites the charted q coordinate by the audited q-chart equation and
then applies the q-pilot positivity side condition.

### Lean Decisions

This is a small but important audit refinement. The final sign condition is no
longer only a proposition about `preLedger.qSigned`; it is also available as a
proposition about the charted q-side point.

No new endpoint is introduced. The object is derived from the existing allowed
chart transport and side conditions.

### What This Tests

The source example constructs the q-pilot chart/sign audit and extracts the
charted q-positivity theorem. The source example build passes.

### Design Trap Avoided

The trap would be to prove q-positivity for a raw real while separately proving
that some charted q-point equals that raw real. This milestone forces the two
facts to meet in a single checkpoint.

### Remaining Gap

The q-side point is still part of the toy/pre-ledger chart model. Later work
should connect this point to a more concrete q-pilot log-volume construction.

## Math Milestone 81: Theta Bound Tied to the Charted Theta Reading

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The HDD-after-SHE route bounds the chosen target volume by `thetaSigned`. As
with the q-side sign condition, this bound should remain visibly tied to the
Theta-side charted point. Otherwise `thetaSigned` could be read as a free
standing real number detached from the chart discipline.

### Lean/API Check

The new audit object is:

```text
IUTStage1SourcePackage.AuditedThetaChartBound
```

It stores:

```text
allowed_chart_transport
hdd_she_bound
theta_charted
chosen_target_volume_le_theta
chosen_target_volume_le_charted_theta
```

The last field states the target-volume bound directly against the coordinate
of the charted Theta-side point:

```text
targetVolume <= (Transport.map thetaToTarget thetaPoint).coord
```

The proof rewrites the charted Theta coordinate by the audited Theta-chart
equation and then applies the HDD-after-SHE target bound.

### Lean Decisions

This mirrors the q-side chart/sign audit. The q-side audit ties q-positivity to
the charted q reading; this milestone ties the Theta-side bound to the charted
Theta reading.

The object is derived from the existing allowed chart transport and
HDD-after-SHE bound, so it does not add a new comparison route.

### What This Tests

The source example constructs the Theta chart/bound audit and extracts the
target-volume bound against the charted Theta coordinate. The source example
build passes.

### Design Trap Avoided

The trap would be to bound by a raw `thetaSigned` while separately maintaining
that this number comes from a chart. This milestone packages those facts
together at the Theta-side checkpoint.

### Remaining Gap

The Theta-side charted point is still abstract. Later milestones should connect
it to a more concrete Theta/HDD or log-volume construction.

## Math Milestone 82: Charted q-to-Theta Comparison Boundary

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The final public comparison should ultimately be a comparison of charted
quantities, not merely an inequality between two stored real numbers. The
previous two milestones tied q-positivity to the charted q reading and the
Theta bound to the charted Theta reading. This milestone combines them into a
single charted comparison boundary.

### Lean/API Check

The new audit object is:

```text
IUTStage1SourcePackage.AuditedChartedComparisonBoundary
```

It stores:

```text
q_pilot_chart_sign
theta_chart_bound
raw_inequality
q_signed_le_theta
charted_q_le_charted_theta
```

The final field states:

```text
(Transport.map qToTarget qPoint).coord <=
  (Transport.map thetaToTarget thetaPoint).coord
```

The proof rewrites both charted coordinates to `qSigned` and `thetaSigned`,
then applies the audited raw inequality.

### Lean Decisions

This is still not a new endpoint. It is a stronger audit view of the same
comparison. Its role is to make the charted real-line readings visible at the
exact point where q and Theta are compared.

The object depends on both earlier chart-side audits:

* `AuditedQPilotChartSign`;
* `AuditedThetaChartBound`.

### What This Tests

The source example constructs the charted comparison boundary and extracts the
charted q-to-Theta inequality. The source example build passes.

### Design Trap Avoided

The trap would be to keep the final inequality only as `qSigned <= thetaSigned`
while trusting separate lemmas to remember the charting. This milestone gives
the charted inequality its own audited type.

### Remaining Gap

The charted q and Theta points are still abstract pre-ledger data. Later work
should connect them to concrete q-pilot and Theta/HDD log-volume constructions.

## Math Milestone 83: Charted Comparison Exposed in Route Summaries

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The charted q-to-Theta comparison should not live only as an internal lemma.
The public route objects are the records a human reader will inspect when
checking the Theorem 3.11 to Corollary 3.12 transition. They therefore need to
expose the charted comparison boundary directly.

### Lean/API Check

The compact route record:

```text
IUTStage1SourcePackage.AuditedStructuredSHERouteSummary
```

now stores:

```text
charted_comparison_boundary :
  AuditedChartedComparisonBoundary package bundle sideConditions
```

and exposes:

```text
chartedComparisonBoundary
chartedQ_le_chartedTheta
```

The named transition record:

```text
IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints
```

carries the same charted comparison boundary and exposes the same charted
q-to-Theta inequality.

### Lean Decisions

This milestone does not add a second comparison route. Both summaries fill the
field by calling:

```text
package.auditedChartedComparisonBoundary bundle sideConditions
```

Thus the route summary, named checkpoints, public audit, signed payload
boundary, and raw inequality all still point back to the same structured-SHE
bundle and side conditions.

### What This Tests

The source example extracts the charted boundary and the charted inequality
from both:

```text
unitThetaToy_source_theorem311_audited_route_summary_example
unitThetaToy_source_theorem311_transition_checkpoints_example
```

The focused Stage 1 source example build passes.

### Design Trap Avoided

The trap would be to prove the charted comparison but leave the public
checkpoint surface showing only `qSigned <= thetaSigned`. This milestone makes
the charted inequality part of the visible 3.11-to-3.12 audit surface.

### Remaining Gap

The charted comparison is still derived from abstract pre-ledger chart data.
The next mathematical work should begin replacing those abstract chart inputs
with more specific q-pilot and Theta/HDD constructions, or at least isolate the
next pre-ledger object that must become less abstract.

## Math Milestone 84: Pre-Ledger Charted Comparison Chain

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`

### Source Check

The final charted q-to-Theta comparison comes from a more local chain:

```text
charted q <= chosen target volume <= charted Theta.
```

This is the point where membership of the q-side point in the chosen output,
the target-volume measurement, and the common-container Theta bound meet.
Keeping this chain explicit is closer to the mathematical route than storing
only the final q-to-Theta inequality.

### Lean/API Check

The pre-ledger record now has:

```text
IUTStage1PreLedgerData.ChartedComparisonChain
```

It stores:

```text
q_charted
theta_charted
q_charted_le_target
target_le_theta_charted
charted_q_le_charted_theta
```

The constructor:

```text
IUTStage1PreLedgerData.chartedComparisonChain
```

derives the charted endpoint inequalities by rewriting the existing
`qSigned` and `thetaSigned` endpoint equations.

### Lean Decisions

This milestone does not change the final comparison data. It names the local
pre-ledger chain from which the later audited charted comparison is derived.

The middle term remains:

```text
data.targetVolume.targetSigned
```

so the current abstraction boundary is now explicit: q and Theta are charted
endpoints, while the target-volume middle term is still a measured real value
attached to the chosen output.

### What This Tests

The toy pre-ledger examples construct the chain and separately extract:

```text
charted q <= targetSigned
targetSigned <= charted Theta
charted q <= charted Theta
```

The focused pre-ledger example build passes.

### Design Trap Avoided

The trap would be to present the charted q-to-Theta inequality as if it were a
primitive comparison. The new chain records the intermediate measured target
volume and keeps the membership/measurement step visible.

### Remaining Gap

The target-volume middle term is not yet a charted point or a detailed
log-volume construction. Later work should decide whether this middle term
needs its own charted data structure, or whether the correct next refinement is
to replace the abstract membership-to-volume inequality with a more concrete
upper-ray/log-volume lemma.

## Math Milestone 85: Charted Boundary Cites the Pre-Ledger Chain

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

After adding the pre-ledger charted comparison chain, the higher Stage 1 source
boundary should not rederive the charted q-to-Theta inequality in isolation.
It should point back to the local chain where the chosen output and target
volume middle term appear.

### Lean/API Check

The record:

```text
IUTStage1SourcePackage.AuditedChartedComparisonBoundary
```

now stores:

```text
preledger_charted_chain :
  package.preLedger.ChartedComparisonChain
```

and exposes it as:

```text
preLedgerChartedChain
```

The final charted inequality is now filled from:

```text
package.preLedger.chartedComparisonChain.chartedQ_le_chartedTheta
```

rather than by rewriting the raw signed inequality directly.

### Lean Decisions

The boundary still stores the raw inequality and the q/Theta chart audits. The
new field does not replace those; it records provenance. The final boundary
therefore simultaneously exposes:

```text
raw qSigned <= thetaSigned
charted q <= charted Theta
charted q <= targetSigned <= charted Theta
```

all for the same package and structured-SHE bundle.

### What This Tests

The source example extracts the pre-ledger charted chain from the audited
charted comparison boundary. The focused Stage 1 source example build passes.

### Design Trap Avoided

The trap would be to maintain a charted final inequality whose proof no longer
mentions the selected output or measured target-volume middle term. This
milestone keeps the charted boundary attached to that local chain.

### Remaining Gap

The pre-ledger chain still uses an abstract `q_le_target` membership-to-volume
inequality. The next useful mathematical refinement is to inspect the toy
upper-ray proof and decide which general lemma should eventually replace that
abstract field.

## Math Milestone 86: Membership-to-Volume Control for the q-Side Middle Step

Lean files:

* `Iut/Foundations/RegionMeasure.lean`
* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/ToyMeasuredComparison.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

The previous milestone isolated the local chain:

```text
charted q <= targetSigned <= charted Theta.
```

The left inequality was still stored as an abstract `q_le_target` field. The
toy upper-ray proof shows the intended shape: membership of the q-side point
in the chosen comparison, together with normalization of upper rays, implies
that the transported q-coordinate is bounded by the measured target volume.

### Lean/API Check

The reusable predicate is:

```text
RegionComparison.MembershipControlsTargetVolume
```

It states that for every source point, comparison membership implies:

```text
(Transport.map comparison.transport point).coord <=
  RegionMeasure.targetVolume measure comparison
```

For upper-ray comparisons, the theorem:

```text
RegionComparison.upperRay_membershipControlsTargetVolume_of_normalized
```

proves this from upper-ray normalization.

The toy specialization is named as:

```text
thetaIndeterminacy_membershipControlsTargetVolume
```

The structure:

```text
AlgorithmicOutput.ChartedMembershipData
```

now stores:

```text
q_chart_transport_eq :
  chart.qToTarget = chosenOutput.comparison.transport
volume_control :
  chosenOutput.comparison.MembershipControlsTargetVolume measure
```

and derives:

```text
q_le_target : qSigned <= targetVolume.targetSigned
```

from the chart equation, the transport compatibility, target-volume
calibration, and membership.

### Lean Decisions

Lean exposed an important hidden assumption: membership controls the transport
inside `chosenOutput.comparison`, while the q-side signed value is read through
`chart.qToTarget`. These are not automatically the same map. The new
`q_chart_transport_eq` field makes this compatibility explicit instead of
letting it remain implicit in the old `q_le_target` proof.

This is closer to the mathematical issue than the raw inequality field was:
we now distinguish the chart transport, the comparison transport, and the fact
that they agree at this membership step.

### What This Tests

The toy pre-ledger and toy source-obligation constructors now supply the
upper-ray membership-control theorem and the chart/comparison transport
compatibility. The examples extract both fields, and the focused Stage 1 data
example build passes. The full project build also passes.

### Design Trap Avoided

The trap would be to store `qSigned <= targetSigned` without recording why the
charted q-coordinate is the same coordinate controlled by comparison
membership. This milestone forces that transport compatibility into the
membership data.

### Remaining Gap

The membership-control predicate is still an abstract interface for genuine
IUT data. For the toy model it is proved from upper rays and normalized
measure. Later work must replace the toy upper-ray instance with the relevant
IUT log-volume or region-membership construction.

## Math Milestone 87: Membership-Control Provenance in the Pre-Ledger Chain

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`

### Source Check

After deriving `qSigned <= targetSigned` from membership-control data, the
pre-ledger charted comparison chain should expose that provenance. Otherwise a
reader would still see only the endpoint inequality inside the chain.

### Lean/API Check

The record:

```text
IUTStage1PreLedgerData.ChartedComparisonChain
```

now stores:

```text
q_chart_transport_eq :
  data.chartedContainer.chart.qToTarget =
    data.chosenOutput.comparison.transport
membership_volume_control :
  data.chosenOutput.comparison.MembershipControlsTargetVolume data.measure
```

and exposes:

```text
qChartTransport_eq_comparisonTransport
membershipVolumeControl
```

### Lean Decisions

The pre-ledger chain remains the same numerical chain:

```text
charted q <= targetSigned <= charted Theta.
```

The change is that the left step now carries its proof ingredients as part of
the chain: chart/comparison transport compatibility and membership-to-volume
control.

### What This Tests

The toy pre-ledger examples extract both new provenance fields from the
charted comparison chain. The focused pre-ledger example build and the full
project build both pass.

### Design Trap Avoided

The trap would be to improve `ChartedMembershipData` but then hide those
improvements when assembling the chain used by the audited charted boundary.
This milestone keeps the chain itself auditable.

### Remaining Gap

The right step, `targetSigned <= charted Theta`, still deserves the same kind
of provenance refinement. It currently comes from the common-container bound
and the Theta chart equation; later work should expose those proof ingredients
inside the chain as well.

## Math Milestone 88: Target-to-Theta Provenance in the Pre-Ledger Chain

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`

### Source Check

The right side of the pre-ledger chain is:

```text
targetSigned <= charted Theta.
```

This is not a primitive inequality. It comes from the definition of the
chosen target-volume middle term, the common-container bound, and the Theta
chart equation.

### Lean/API Check

The record:

```text
IUTStage1PreLedgerData.ChartedComparisonChain
```

now stores:

```text
target_signed_eq_choice_volume :
  data.targetVolume.targetSigned =
    RegionMeasure.targetVolume data.measure
      (data.output.comparison data.chosenOutput.choice)
choice_target_volume_le_theta :
  RegionMeasure.targetVolume data.measure
      (data.output.comparison data.chosenOutput.choice) <=
    data.thetaSigned
```

and exposes:

```text
targetSigned_eq_choiceTargetVolume
choiceTargetVolume_le_thetaSigned
```

### Lean Decisions

This mirrors the previous provenance refinement for the q-side left step. The
chain now carries both sides' immediate proof ingredients:

```text
q chart transport = comparison transport
membership controls target volume
targetSigned = chosen target volume
chosen target volume <= thetaSigned
```

Together with the q and Theta chart equations, these fields explain the whole
charted q-to-Theta chain.

### What This Tests

The toy pre-ledger examples extract both target-to-Theta provenance fields.
The focused pre-ledger example build and the full project build both pass.

### Design Trap Avoided

The trap would be to expose provenance for `charted q <= targetSigned` while
leaving `targetSigned <= charted Theta` as a raw inequality. This milestone
keeps the middle-to-Theta step auditable as well.

### Remaining Gap

The common-container bound itself is still abstract at this point in the
pre-ledger. Later work should refine where `choice_target_volume_le_theta`
comes from: the HDD-after-SHE/common-container construction and the structured
SHE context that is supposed to control it.

## Math Milestone 89: Chain Provenance Exposed at the Charted Boundary

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The audited charted comparison boundary is the object later summaries expose
for the 3.11-to-3.12 transition. Since it already carries the pre-ledger
charted comparison chain, it should also expose the main provenance fields
from that chain.

### Lean/API Check

The namespace:

```text
IUTStage1SourcePackage.AuditedChartedComparisonBoundary
```

now exposes:

```text
qChartTransport_eq_comparisonTransport
membershipVolumeControl
targetSigned_eq_choiceTargetVolume
choiceTargetVolume_le_thetaSigned
```

These are projections from the carried pre-ledger chain.

### Lean Decisions

No new proof route is introduced. The boundary still derives its final charted
q-to-Theta inequality from:

```text
package.preLedger.chartedComparisonChain
```

This milestone only makes the chain's proof ingredients inspectable at the
audited boundary layer.

### What This Tests

The toy source examples extract all four provenance facts from the audited
charted comparison boundary. The focused Stage 1 source example build and the
full project build both pass.

### Design Trap Avoided

The trap would be for the audited charted boundary to expose the final
inequality while hiding the transport compatibility, membership-to-volume
control, target-volume definition, and common-container bound that produce it.

### Remaining Gap

The common-container/HDD-after-SHE source of `choiceTargetVolume_le_thetaSigned`
is still only visible one layer lower. A later refinement should expose that
HDD-after-SHE provenance at this same boundary or in a sibling audit object.

## Math Milestone 90: HDD-after-SHE Provenance at the Charted Boundary

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The right side of the charted comparison ultimately depends on the
HDD-after-SHE/common-container bound. The audited charted boundary should
therefore expose not only the pre-ledger target-volume inequality, but also
the audited HDD-after-SHE object that supplies it.

### Lean/API Check

The Theta chart-bound audit now exposes:

```text
hddSHEBound
```

The charted comparison boundary now exposes:

```text
hddSHEBound
hddSHECommonContainerCompatibility
hddSHELocalExpressionValid
hddSHEChosenTargetVolume_le_theta
```

These are projections from the existing audited HDD-after-SHE bound.

### Lean Decisions

This milestone does not claim that SHE alone proves the numerical bound. The
existing audited HDD-after-SHE object still records the explicit target-volume
bound and carries the structured-SHE/common-container compatibility and local
SHE validity data alongside it.

The purpose is to make the provenance visible at the final charted comparison
boundary.

### What This Tests

The toy source examples extract the HDD-after-SHE audit object, local SHE
validity, and chosen target-volume bound from the audited charted comparison
boundary. The focused Stage 1 source example build and the full project build
both pass.

### Design Trap Avoided

The trap would be to expose `targetSigned <= charted Theta` while hiding the
HDD-after-SHE/common-container proof object that supplies the Theta-side
target bound. This milestone keeps the final charted boundary attached to the
fourth-triangle audit.

### Remaining Gap

The HDD-after-SHE bound itself still uses an explicit common-container bridge
as data. Future work should refine that bridge, especially the relation
between structured SHE validity, the common container, and the measured
target-volume estimate.

## Math Milestone 91: SHE/Common-Container Alignment Exposed from HDD-after-SHE

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The HDD-after-SHE bound should not be inspected only as a numerical
target-volume estimate. For the debated transition, the reader must also see
how the SHE arrow, structured SHE datum, common container context, pilot
placements, and history separation sit next to that bound.

### Lean/API Check

The audited HDD-after-SHE bound now exposes:

```text
sheArrowMatchesContext
sheDatumMatchesCertificate
qPilotTheater_eq_codomain
thetaPilotTheater_eq_domain
```

The audited charted comparison boundary now exposes:

```text
hddSHESHEArrowMatchesContext
hddSHESHEDatumMatchesCertificate
hddSHECommonContainerContextMatches
hddSHEQPilotTheater_eq_codomain
hddSHEThetaPilotTheater_eq_domain
```

These are projections from the existing common-container compatibility
checklist.

### Lean Decisions

This does not create a new theorem proving the bound from SHE. It makes the
existing compatibility data inspectable from the final charted boundary. The
numerical bound and the structured SHE/common-container alignment are now
available at the same boundary layer.

### What This Tests

The toy source examples extract the SHE-arrow match, common-container context
match, and q-pilot codomain placement from the audited charted comparison
boundary. The focused Stage 1 source example build and the full project build
both pass.

### Design Trap Avoided

The trap would be to treat the HDD-after-SHE object as just a source of a real
inequality. This milestone keeps the SHE/common-container alignment data
visible where the final charted comparison is audited.

### Remaining Gap

The compatibility checklist is still an audit of supplied data. Later work
should refine the bridge construction itself: descent, hull+det, common target,
and the measured target-volume estimate should become less abstract.

## Math Milestone 92: Combined HDD-after-SHE Certificate and Family Bound

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestone exposed SHE/common-container alignment fields
separately. For auditing the route, it is also useful to have the composed
statement that the SHE arrow datum used by the common container is the same as
the pre-ledger structured certificate's SHE datum.

The final boundary should also expose the family-level bound and history
separation attached to the HDD-after-SHE audit.

### Lean/API Check

The audited HDD-after-SHE bound now exposes:

```text
sheArrowDatumMatchesCertificate
```

The audited charted comparison boundary now exposes:

```text
hddSHESHEArrowDatumMatchesCertificate
hddSHEAllTargetsAtMost_theta
hddSHEDomainHistory_ne_codomainHistory
```

### Lean Decisions

The composed SHE-arrow-to-certificate theorem is just:

```text
sheArrowMatchesContext.trans sheDatumMatchesCertificate
```

This is not a new assumption. It packages an audit fact that human readers
will otherwise have to reconstruct from two adjacent compatibility fields.

The all-targets-at-most and history-separation projections keep the final
charted boundary tied to the family-level target-volume estimate and the
non-identification of domain/codomain histories.

### What This Tests

The toy source examples extract the SHE-arrow-to-certificate equality, the
family-level all-targets-at-most bound, and the Hodge-theater history
separation from the audited charted comparison boundary. The focused Stage 1
source example build and the full project build both pass.

### Design Trap Avoided

The trap would be to check only the chosen target bound and miss that the
HDD-after-SHE construction also claims a family-level bound and history
separation. This milestone exposes those facts at the boundary.

### Remaining Gap

The family-level bound is still supplied by the bridge. The next refinement
should inspect the bridge object itself and decide which part can be replaced
by a less abstract construction first: the common target, the hull+det step,
or the descent/HDD bookkeeping.

## Math Milestone 93: Common-Container Bound Audit Object

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestones exposed the HDD-after-SHE bound from the final
charted boundary, but the common-container bridge application itself was still
only visible through separate projection theorems. This milestone names that
bridge application as an audit object.

### Lean/API Check

The generic bridge layer now defines:

```text
AlgorithmicOutput.CommonContainerData.BoundAudit
```

For a common container and structured certificate, it stores:

```text
she_context_matches
all_targets_at_most
choice_target_volume_le
```

The constructor:

```text
CommonContainerData.boundAudit
```

builds this object from the existing common-container data.

The audited HDD-after-SHE bound now stores:

```text
common_container_bound_audit
```

and the charted comparison boundary exposes it as:

```text
hddSHECommonContainerBoundAudit
```

### Lean Decisions

This remains an audit of supplied bridge data. It does not derive the common
target from SHE or from a hull+det construction. Its purpose is to localize
the exact bridge output that future work must replace with less abstract
mathematics.

### What This Tests

The toy source example extracts the common-container bound audit from the
charted comparison boundary. The focused Stage 1 source example build and the
full project build both pass.

### Design Trap Avoided

The trap would be to talk about the common-container bridge while only exposing
its chosen target-volume inequality. This milestone records the SHE context
match and family-level target-volume bound as part of one named audit object.

### Remaining Gap

The audit object still receives its bound from the generic bridge. The next
step should expose the internal HDD decomposition around this bridge:
SHE arrow, descent, hull+det bridge, and common container.

## Math Milestone 94: HDD-after-SHE Decomposition Audit

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The common-container bound is obtained by applying the `(HDD) o (SHE)` bridge.
The bridge itself decomposes through the named HDD composite and then through
the hull+det bridge. This decomposition should be visible as an audit object,
not only as reducible definitions.

### Lean/API Check

The generic bridge layer now defines:

```text
AlgorithmicOutput.HDDSHECompositeData.DecompositionAudit
```

It stores:

```text
structured_bridge_eq_hull_det
apply_eq_hull_det
choice_target_volume_le
all_targets_at_most
```

The common-container bound audit now carries:

```text
hdd_she_decomposition
```

and the Stage 1 charted boundary exposes it as:

```text
hddSHEDecompositionAudit
```

### Lean Decisions

The decomposition equalities are definitional in the current bridge model.
Naming them is still useful: it records exactly where the generic bridge
passes from `(HDD) o (SHE)` to HDD and then to the hull+det bridge.

This does not formalize the actual hull+det mathematics yet. It isolates the
interface where that future work must replace the current explicit bridge.

### What This Tests

The toy source example extracts the HDD-after-SHE decomposition audit from the
charted comparison boundary. The focused Stage 1 source example build and the
full project build both pass.

### Design Trap Avoided

The trap would be to leave the common-container bound as an opaque application
with no named path through SHE, HDD, and hull+det. This milestone names that
path while keeping the remaining abstraction explicit.

### Remaining Gap

The hull+det bridge itself is still supplied as data. The next refinement
should expose the hull+det bridge audit separately and then decide which
mathematical content belongs there first.

## Math Milestone 95: Hull+Det Bridge Audit Exposed

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The HDD-after-SHE decomposition now reaches the hull+det bridge, but the
hull+det bridge itself was still just the endpoint of a decomposition equality.
This milestone gives the hull+det bridge its own bound audit and threads it
back through HDD and the final charted boundary.

### Lean/API Check

The generic bridge layer now defines:

```text
AlgorithmicOutput.HullDetBridgeData.BoundAudit
AlgorithmicOutput.HDDCompositeData.DecompositionAudit
```

The hull+det bound audit stores:

```text
apply_eq_bridge_apply
choice_target_volume_le
all_targets_at_most
```

The HDD decomposition audit stores:

```text
apply_eq_hull_det
hull_det_bound_audit
choice_target_volume_le
all_targets_at_most
```

The HDD-after-SHE decomposition audit now carries the HDD decomposition, and
the final charted boundary exposes:

```text
hddDecompositionAudit
hullDetBoundAudit
```

### Lean Decisions

This continues to avoid pretending that hull+det has been formalized. The
current hull+det bridge is still supplied data. The gain is that the remaining
abstraction is now named exactly as the hull+det bridge audit, rather than
being hidden inside a common-container bound.

### What This Tests

The toy source examples extract both the HDD decomposition audit and the
hull+det bound audit from the audited charted comparison boundary. The focused
Stage 1 source example build and the full project build both pass.

### Design Trap Avoided

The trap would be to stop at `(HDD) o (SHE)` and leave the hull+det step
implicit. This milestone makes the decomposition through HDD and hull+det part
of the formal audit surface.

### Remaining Gap

The hull+det bridge audit still records supplied target-volume bounds. The
next mathematical target is to identify a first nontrivial construction inside
that bridge: likely a named common target or hull operation before determinant
or log-volume estimates are attempted.

## Math Milestone 96: Common Target Data Inside the Hull+Det Audit

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The hull+det bridge audit should not expose only target-volume inequalities.
The underlying bridge returns a common target bound: a common target region
containing every target region in the family, together with a measured upper
bound on that common target. These are the first concrete common-target facts
inside the bridge.

### Lean/API Check

The audit:

```text
AlgorithmicOutput.HullDetBridgeData.BoundAudit
```

now stores:

```text
common_target_contains_each
common_target_volume_bound
```

and exposes:

```text
commonTargetContainsEach
commonTargetVolumeBound
```

The existing chosen-target and all-targets bounds remain in the audit.

### Lean Decisions

This does not construct the common target from IUT geometry. It exposes the
common target already returned by the supplied bridge:

```text
(data.apply certificate).common
```

The point is to make the shape of the bridge output explicit before replacing
the bridge internals with more mathematical content.

### What This Tests

The toy source examples extract common-target containment and the measured
common-target volume bound from the final charted boundary's hull+det audit.
The focused Stage 1 source example build and the full project build both pass.

### Design Trap Avoided

The trap would be to reduce the hull+det bridge to an inequality-producing
black box. This milestone exposes the common target and its measured bound as
separate auditable facts.

### Remaining Gap

The common target is still supplied by the bridge. Future work should refine
how that common target is produced, likely by threading an explicit hull
operation or common-hull object before determinant/log-volume estimates.

## Math Milestone 97: Pointwise Common-Target Consequences in the Hull+Det Audit

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestone exposed the common target and its measured bound inside
the hull+det audit. The next local consequences are pointwise: each chosen
target region has bounded volume, and membership in a chosen comparison lifts
to membership in the enlarged comparison with the common target.

These facts are the concrete common-target content behind the later numerical
target-volume bound.

### Lean/API Check

The audit:

```text
AlgorithmicOutput.HullDetBridgeData.BoundAudit
```

now stores:

```text
choice_region_at_most
holds_common_target
```

and exposes:

```text
choiceRegionAtMost
holdsCommonTarget
```

The chosen target-volume and all-targets-at-most fields remain available.

### Lean Decisions

The new fields are derived from the `CommonTargetBound` returned by the
hull+det bridge:

```text
(data.apply certificate).choice_region_atMost
(data.apply certificate).holds_common_of_choice
```

This keeps the audit close to the foundation API instead of storing only the
final real inequality.

### What This Tests

The toy source examples extract:

```text
RegionMeasure.HasVolumeAtMost ... chosenTargetRegion thetaSigned
```

and the lifted membership statement for the q-point in the enlarged common
target comparison. The focused Stage 1 source example build and the full
project build both pass.

### Design Trap Avoided

The trap would be to expose the common target but never use it except through
a final target-volume inequality. This milestone makes the containment and
membership behavior inspectable.

### Remaining Gap

The common target is still produced by the supplied bridge. The next step is
to decide whether the bridge should expose a common-hull object, or whether
we should first refine the toy upper-ray common target into a reusable
construction pattern.

## Math Milestone 98: Reusable Upper-Ray Common-Target Construction

Lean files:

* `Iut/Foundations/CommonTargetBound.lean`
* `Iut/Stage1/ToyFamilyBounds.lean`

### Source Check

The toy Theta family used an upper-ray common target: each chosen target is an
upper ray with a choice-dependent bound, and a single cap bounds all choices.
This pattern is not specific to the toy names. It is a reusable common-target
construction for any upper-ray comparison family.

### Lean/API Check

The foundation layer now defines:

```text
RegionComparisonFamily.upperRayFamily
RegionComparisonFamily.upperRayFamily_commonTarget
RegionComparisonFamily.upperRayFamily_commonTargetBound
RegionComparisonFamily.upperRayFamily_allTargetsAtMost
```

The common-target bound theorem assumes:

```text
∀ choice, bound choice <= commonBound
```

and upper-ray normalization of the measure.

The toy Theta family:

```text
thetaIndeterminacyFamily
```

is now defined using `upperRayFamily`, and its common-target bound is derived
from `upperRayFamily_commonTargetBound`.

### Lean Decisions

This is the first step toward replacing toy-specific bridge internals with
small reusable mathematical construction patterns. It is still an upper-ray
model, not IUT's full log-volume geometry, but it removes unnecessary
toy-specific proof code.

### What This Tests

The focused build for `Iut.Stage1.ToyFamilyBounds` and the Stage 1 source
example passes. The downstream toy bridge and source audit route continue to
compile after the refactor. The full project build also passes.

### Design Trap Avoided

The trap would be to keep every common-target construction hard-coded in the
toy layer. This milestone moves the generic upper-ray common-target argument
to the foundation layer, where future non-toy approximations can reuse or
replace it.

### Remaining Gap

The construction is still upper-ray specific. The next deeper refinement is to
introduce a common-hull or hull-operation witness that is general enough to
approximate the hull+det bridge without assuming all targets are upper rays.

## Math Milestone 99: Upper-Ray Common-Hull Bound Route

Lean files:

* `Iut/Foundations/CommonTargetBound.lean`
* `Iut/Foundations/TransportedRegionFamily.lean`
* `Iut/Stage1/ToyFamilyBounds.lean`
* `Iut/Stage1/ToyAPTTransport.lean`

### Source Check

The preceding milestone had a reusable upper-ray common target. The hull+det
discussion, however, should not jump directly from possible target regions to
a final numerical bound. At minimum, the formal route should expose a common
hull or hull-like region before measuring it.

This milestone therefore routes the toy upper-ray construction through:

```text
choice-dependent target regions
-> common target hull
-> measured common-hull bound
-> common target bound
-> all-targets-at-most
```

### Lean/API Check

The foundation layer now defines:

```text
RegionComparisonFamily.upperRayFamily_commonTargetHull
RegionComparisonFamily.upperRayFamily_commonTargetHullBound
```

The transported-family layer now exposes:

```text
TransportedRegionFamily.CommonTargetHull
TransportedRegionFamily.holds_commonHull_of_choice
TransportedRegionFamily.choice_targetVolume_le_of_commonHullBound
TransportedRegionFamily.allTargetsAtMost_of_commonHullBound
```

The toy Theta family now defines:

```text
thetaIndeterminacyCommonTargetHull
thetaIndeterminacyCommonTargetHullBound
```

and the old:

```text
thetaIndeterminacyCommonTargetBound
thetaAPTOutputCommonTargetBound
```

are now obtained by applying `toCommonTargetBound` to the measured
common-hull bound.

### Lean Decisions

The upper-ray common hull is currently the same region as the upper-ray common
target:

```text
Region.upperRay target commonBound
```

This is intentionally conservative. We are not pretending that an IUT
holomorphic hull, determinant line, or log-volume calculation has been
formalized. The useful change is the typed route: later a genuine hull
construction can replace this common-hull witness without changing the
downstream common-target-bound consumers.

### What This Tests

Lean verifies that the common-hull bound can be constructed generically for
upper-ray comparison families and then used by the toy APT output. Focused
builds for `Iut.Stage1.ToyFamilyBounds` and `Iut.Stage1.ToyAPTTransport`
pass.

### Design Trap Avoided

The trap would be to keep saying "hull+det" while the formal proof path
contains only a direct common-target bound. This milestone inserts a visible
common-hull datum into the toy construction, while still marking determinant
and log-volume work as absent.

### Remaining Gap

The common hull is still an upper-ray cap, not Mochizuki's actual
holomorphic-hull/determinant construction. The next mathematical refinement is
to expose a hull-producing bridge interface inside the named hull+det bridge,
so that a bridge may provide a `CommonTargetHullBound` first and only then
derive its `CommonTargetBound`.

## Math Milestone 100: Hull-Producing Hull+Det Bridge Interface

Lean files:

* `Iut/Foundations/AlgorithmicOutput.lean`
* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/ToyBridge.lean`

### Source Check

The previous milestone routed the toy upper-ray estimate through a measured
common hull. The named hull+det bridge still accepted only a final
common-target bridge. This milestone adds a source-facing bridge shape that
produces a measured common hull first.

This matches the direction needed for the IUT III 3.11-to-3.12 analysis:
the debated step should not be represented merely as a terminal inequality.
It should expose the intermediate hull-like object whose measurement leads to
the comparison bound.

### Lean/API Check

`AlgorithmicOutput` now has:

```text
AlgorithmicOutput.CommonTargetHullBound
AlgorithmicOutput.CertifiedCommonTargetHullBound
CertifiedCommonTargetHullBound.toCertifiedCommonTargetBound
```

`AlgorithmicBridge` now has:

```text
AlgorithmicOutput.StructuredCommonTargetHullBridge
StructuredCommonTargetHullBridge.toStructuredCommonTargetBoundBridge
AlgorithmicOutput.HullDetHullBridgeData
HullDetHullBridgeData.HullAudit
```

The new hull audit exposes:

```text
apply_eq_hull_to_common
common_hull_contains_each
common_hull_volume_bound
choice_target_volume_le
holds_common_hull
all_targets_at_most
```

The toy bridge now defines:

```text
thetaToyStructuredCommonTargetHullBridge
thetaToyHullDetHullBridgeData
thetaToyHullDetHullAudit
thetaToyHullDetHull_commonHull_volume_bound
thetaToyHullDetHull_choice_targetVolume_le_bound
thetaToyHullDetHull_allTargetsAtMost
```

### Lean Decisions

The existing `HullDetBridgeData` remains available because downstream code
already consumes common-target bridges. The new `HullDetHullBridgeData` can be
forgotten to the old shape through:

```text
HullDetHullBridgeData.toHullDetBridgeData
```

This avoids breaking the already-audited 3.11-to-3.12 route while giving
future real mathematical work a more precise target.

### What This Tests

Lean verifies that a structured hull bridge can be turned into the old
structured common-target bridge, and that the toy hull+det bridge can expose
common-hull containment, common-hull volume control, chosen-target volume
control, and all-targets-at-most facts. The focused build for
`Iut.Stage1.ToyBridge` passes.

### Design Trap Avoided

The trap would be to make "hull+det" a label on a final bound forever. This
milestone separates the hull-producing interface from the final common-target
consumer, so the next replacement can attack the missing mathematical content
directly.

### Remaining Gap

The new bridge interface still does not construct Mochizuki's holomorphic
hulls, determinant operation, or log-volume estimates. It only establishes the
formal slot and audit shape where such a construction must eventually live.
