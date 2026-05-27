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

## Periodic Review: Structured SHE Layer

Date: 2026-05-27

This checkpoint reviews the recent return to the IUT III Theorem 3.11 to
Corollary 3.12 layer.

### Current Lean Chain

The source route now contains a non-inert SHE stack:

```text
StructuredSHEContext
-> IUTStage1Theorem311StructuredSHE
-> IUTStage1Theorem311StructuredSHECommonContainerCompatibility
-> IUTStage1Theorem311StructuredInputsWithSHE
-> audited HDD-after-SHE / common-container / signed-payload route
```

The SHE context now records:

```text
domainStructure
codomainStructure
commonLanguage
qPilotStructure
thetaPilotStructure
q-pilot in codomain
Theta-pilot in domain
structured local simultaneous-expression validity
domain/codomain histories not identified
```

The compatibility object used at the common-container checkpoint carries the
pilot placements, simultaneous validity, and history separation alongside the
SHE-arrow and common-context equalities.

### Positive Alignment

This is now directly relevant to the 3.11/3.12 dispute. The formalization does
not merely say "SHE holds"; it keeps track of which pilot datum is attached to
which Hodge-theater side, which shared context is being used, and that the two
Hodge-theater histories are not being identified.

This is also consistent with the impartial goal of the project. The current
Lean code does not assert that Mochizuki's comparison is correct, nor that the
Scholze-Stix collapse occurs. It makes the disputed information visible enough
that later formal steps must say exactly what they transport and identify.

### Remaining Gaps

The validity fields remain abstract propositions. In particular:

* `domain_expression_valid` and `codomain_expression_valid` do not yet encode
  concrete arithmetic holomorphic structures.
* `q_pilot_expression_valid` and `theta_pilot_expression_valid` do not yet
  contain actual q-pilot or Theta/HDD data.
* `simultaneous_valid` is structured now, but still not a theorem derived from
  a formalized Hodge-theater construction.
* the HDD-after-SHE bridge still uses measured common-target data supplied at
  the algorithmic bridge layer.

These are the right gaps to have at this stage: they are visible and localized.

### Global 3.12 Check

The current code is closer to the disputed transition than the cover/deck
reconstruction layer, but it still does not prove Corollary 3.12 from the IUT
papers. The next risk is to let the HDD-after-SHE bridge consume the structured
SHE context without checking the real-line-copy chart and the target bound
construction at the same time.

Next useful directions:

* make the HDD-after-SHE bridge explicitly record the SHE validity it consumes;
* refine one local SHE validity component into a more concrete record;
* audit the final signed payload route to ensure q-side and Theta-side real
  readings are always charted before comparison.

The invariant remains unchanged: no theorem may convert SHE/HDD/common
container names into a Corollary 3.12 endpoint unless the relevant histories,
transports, charts, and bounds are explicit in the statement.

## Periodic Review: Chart Transport and History Discipline

Date: 2026-05-27

This checkpoint reviews the recent work on the final real-line-copy comparison
layer.

### Current Lean Chain

The chart side of the Stage 1 route now contains:

```text
RealComparisonChartData
-> RealComparisonChartData.TransportDiscipline
-> AuditedSignedPayloadBoundary chart facts
-> AuditedPublicAudit chart facts
-> AuditedChartHistoryDiscipline
-> AuditedAllowedChartTransport
```

The chart discipline records two permitted readings:

* the q-to-target chart transport preserves coordinate order;
* the Theta-to-target transport is explicitly trivial.

The source audit then pairs those permitted chart readings with the forbidden
domain/codomain Hodge-history identification.

### Positive Alignment

This is directly relevant to the Scholze-Stix/Mochizuki disagreement. The code
now distinguishes:

* transport through a named real-comparison chart;
* equality of charted q/Theta real readings;
* matching of the common container with the structured SHE context;
* non-identification of the two Hodge-theater histories.

The q-side chart permission has gained mathematical content: it follows from
positive scaling and states order preservation. This is exactly the sort of
property needed for inequalities, while remaining far weaker than identifying
underlying ring or scheme histories.

### Remaining Gaps

The chart model is still a positive scaling between labeled real-line copies.
That is useful for guarding comparisons, but it is not yet Mochizuki's full
log-volume apparatus.

The main remaining gaps at this layer are:

* the chart transports are not yet connected to actual log-volume maps;
* the q-side reading is order-preserving, but not yet tied to a concrete
  q-pilot log-volume construction;
* the Theta-side triviality is explicit, but its source in the Hodge-theater
  construction is still abstract;
* the chart/history discipline is an audit object, not a proof of Corollary
  3.12 from the IUT papers.

### Global 3.12 Check

The recent milestones reduce one important collapse risk: final real-number
comparison can no longer be read in isolation from charting and history
separation. However, this does not settle the dispute. It prepares the type
surface for the eventual question: whether the actual IUT Hodge-theater data
can supply these charted comparisons without illegitimate history
identification.

Next useful directions:

* connect q-side chart readings to the q-pilot log-volume side condition;
* refine Theta-side chart triviality into a named construction source;
* make the final public audit expose both allowed chart transport and
  forbidden history identification as a compact checklist.

## Periodic Review: Charted Boundary Provenance

Date: 2026-05-27

This checkpoint reviews the recent work around the final charted comparison
and its pre-ledger source.

### Current Lean Chain

The current chain is:

```text
IUTStage1PreLedgerData.ChartedComparisonChain
-> AuditedChartedComparisonBoundary
-> AuditedStructuredSHERouteSummary
-> AuditedTheorem311ToCorollary312Checkpoints
```

The pre-ledger chain states:

```text
charted q <= targetSigned <= charted Theta
```

The audited charted boundary now stores that pre-ledger chain and uses it as
the source of the final charted q-to-Theta inequality.

### Positive Alignment

This is aligned with the 3.11/3.12 dispute because the final comparison is no
longer just a raw inequality between stored reals. A human reader can now ask
where the charted inequality came from and immediately find the local chain
where the chosen output, membership fact, measured target volume, and
Theta-bound endpoint are connected.

This also limits a possible formalization drift: a later theorem cannot easily
present the charted q-to-Theta inequality while bypassing the target-volume
middle term, because the audited boundary exposes the pre-ledger chain as
provenance.

### Remaining Gaps

The biggest gap is now localized:

* `q_charted_le_target` still comes from an abstract pre-ledger membership
  inequality.
* `target_le_theta_charted` still comes from the common-container bound after
  rewriting the Theta chart equation.
* the target-volume middle term is a measured real value, not yet a charted
  geometric/log-volume object of its own.

These gaps are acceptable only as temporary abstraction boundaries. They are
exactly where the next mathematical work should happen.

### Global 3.12 Check

The recent work is not merely infrastructure. It touches the actual formal
route of the disputed comparison by pinning down the public charted inequality
to its local pre-ledger chain. It still does not decide whether IUT proves ABC
or whether the Scholze-Stix objection is correct.

The next useful direction is to refine the abstract membership-to-volume
inequality. The toy upper-ray model already proves a concrete instance of this
step; the formalization should inspect that proof and extract a reusable
lemma or interface that can later be replaced by genuine IUT log-volume data.

## Periodic Review: q-to-Theta Chain Provenance

Date: 2026-05-27

This checkpoint reviews the recent move from final charted comparison
statements into the proof ingredients of the local chain.

### Current Lean Chain

The current charted comparison route now exposes:

```text
RegionComparison.MembershipControlsTargetVolume
AlgorithmicOutput.ChartedMembershipData
IUTStage1PreLedgerData.ChartedComparisonChain
AuditedChartedComparisonBoundary
```

The pre-ledger chain records:

```text
charted q <= targetSigned <= charted Theta
```

and now carries the immediate provenance for both sides:

```text
q chart transport = chosen comparison transport
chosen comparison membership controls target volume
targetSigned = chosen target volume
chosen target volume <= thetaSigned
Theta chart equation
```

The audited charted boundary exposes this chain, plus the HDD-after-SHE audit
that supplies the Theta-side target-volume bound.

### Positive Alignment

This is directly on the disputed 3.11-to-3.12 route. The Lean code no longer
allows the final charted q-to-Theta inequality to appear as a detached raw real
comparison. The route now shows:

* how q membership controls the measured target-volume middle term;
* why the q chart transport is the same transport used by the chosen
  comparison;
* where the target-volume middle term is defined;
* where the Theta-side bound enters;
* which HDD-after-SHE/structured-SHE audit object carries that bound.

This remains impartial. The code does not assert that Mochizuki's full
construction exists, and it does not encode the Scholze-Stix collapse. It
localizes the exact data that must eventually decide whether the comparison is
legitimate.

### Remaining Gaps

The remaining serious abstractions are now clearer:

* `MembershipControlsTargetVolume` is general and only has a toy upper-ray
  instance so far.
* The HDD-after-SHE target-volume bound is supplied by the common-container
  bridge; that bridge is still explicit data rather than a derived theorem
  from a formal Hodge-theater construction.
* The structured SHE validity fields are present, but they are still
  abstract propositions.
* The real-line chart model remains positive scaling/trivial transport, not
  a full formalization of Mochizuki's log-volume apparatus.

### Global 3.12 Check

The recent work was mathematical implementation, not framework polishing. It
tightened the actual chain that leads from q-side membership to the final
charted q-to-Theta comparison.

The next useful direction is to open the common-container/HDD-after-SHE bridge
and add a more explicit audit object for its construction: SHE arrow, descent,
hull+det bridge, common container context, resulting common target bound, and
all-targets-at-most statement. That will identify the next exact abstraction
standing between the formalized route and a genuine IUT proof of the 3.12
comparison.

## Periodic Review: HDD/SHE Bridge Decomposition

Date: 2026-05-27

This checkpoint reviews the recent work on the common-container and
HDD-after-SHE bridge.

### Current Lean Chain

The final charted comparison boundary now exposes:

```text
CommonContainerData.BoundAudit
HDDSHECompositeData.DecompositionAudit
HDDCompositeData.DecompositionAudit
HullDetBridgeData.BoundAudit
```

The route from the final charted comparison to the bridge is:

```text
AuditedChartedComparisonBoundary
-> AuditedThetaChartBound
-> IUTStage1Theorem311AuditedHDDSHEBound
-> CommonContainerData.BoundAudit
-> HDDSHECompositeData.DecompositionAudit
-> HDDCompositeData.DecompositionAudit
-> HullDetBridgeData.BoundAudit
```

### Positive Alignment

This is still on the actual 3.11-to-3.12 path. The Theta-side bound is no
longer just a number in an audit record; it is traceable through the common
container, the `(HDD) o (SHE)` composite, the HDD decomposition, and the
hull+det bridge.

This is useful for the disputed point because it keeps SHE, common-container
context, history separation, and the target-volume estimates visible at the
same boundary where the charted q-to-Theta inequality is stated.

### Remaining Gaps

The key remaining abstraction is now sharply localized:

* `HullDetBridgeData.BoundAudit` still records a supplied structured bridge.
* The bridge does not yet formalize a concrete common target, hull operation,
  determinant construction, or log-volume estimate.
* The current decomposition equalities are definitional bookkeeping, not the
  full IUT mathematics.

This is acceptable as a staging point because the missing object has a name
and a small API.

### Global 3.12 Check

The formalization has not proven Corollary 3.12 from Mochizuki's papers.
What it has done is make it harder for a formal proof to hide the disputed
comparison behind a single real inequality or a single opaque bridge.

The next useful mathematical step is to refine the hull+det bridge audit. A
reasonable first target is a named common-target/hull datum with a measured
bound, before attempting determinant or log-volume content.

## Periodic Review: Upper-Ray Hull Route

Date: 2026-05-27

This checkpoint reviews the new common-hull route for the toy upper-ray
construction.

### Current Lean Chain

The toy Stage 1 common-target estimate now factors as:

```text
thetaAPTOutputCommonTargetHullBound
-> thetaAPTOutputCommonTargetBound
-> thetaToyStructuredCommonTargetBoundBridge
-> HullDetBridgeData.BoundAudit
-> HDD/SHE/common-container/charted audits
-> final q-to-Theta charted comparison
```

At the comparison-family level, the generic upper-ray route is:

```text
upperRayFamily_commonTargetHull
-> upperRayFamily_commonTargetHullBound
-> CommonTargetHullBound.toCommonTargetBound
```

### Positive Alignment

This remains focused on the 3.11-to-3.12 path. It does not add another
administrative label. It changes the mathematical route that supplies the toy
Theta target bound: the bound is now mediated by an explicit common-hull
witness.

That matters for the dispute because the formal path can no longer silently
identify "common target" with "final inequality"; a common region/hull object
is present before measurement.

### Remaining Gaps

The new common hull is still an upper-ray cap. It is not Mochizuki's
holomorphic hull and it does not encode determinant or log-volume geometry.
The named hull+det bridge still accepts a supplied structured bridge rather
than constructing one from source-side IUT data.

### Global 3.12 Check

The formalization has still not reached the hard Mochizuki mathematics.
However, the remaining abstraction has become more constrained: a serious
replacement for the toy bridge should now supply a measured common-hull bound,
not merely a terminal inequality.

## Periodic Review: Hull+Det Internal Split

Date: 2026-05-27

This checkpoint reviews the split of the hull+det bridge into a hull
constructor and a determinant/log-volume bound constructor.

### Current Lean Chain

The toy bridge now factors as:

```text
thetaToyStructuredCommonHullBridge
-> thetaToyStructuredDeterminantLogVolumeBridge
-> thetaToyStructuredHullDetBridgeData
-> thetaToyStructuredCommonTargetHullBridge
-> thetaToyHullDetHullBridgeData
-> thetaToyHullDetBridgeData
-> HDD/SHE/common-container/charted audits
```

The generic bridge layer now has the same shape:

```text
StructuredCommonHullBridge
StructuredDeterminantLogVolumeBridge
StructuredHullDetBridgeData.StepAudit
```

### Positive Alignment

This is aligned with the local source checks:

* Mochizuki's formalization report separates descent from `hull+det` and
  describes `hull+det` via a determinant operation after a generated
  module/hull construction.
* IUT III describes the Corollary 3.12 quantity as the log-volume of the
  holomorphic hull of the union of possible Theta-pilot images.
* Scholze-Stix's criticism makes real-line identifications and concrete pilot
  comparisons the sensitive point, so the formalization should expose exactly
  which hull is measured and where the measurement bound enters.

### Remaining Gaps

The current hull is still the toy upper-ray common hull. The determinant/log-
volume bridge still uses upper-ray normalization, not the actual determinant
of a module over a generated ring and not IUT's procession-normalized
mono-analytic log-volume.

### Global 3.12 Check

The project remains before a proof of Corollary 3.12. But the abstraction is
now better localized: a genuine proof must fill in an unmeasured holomorphic
hull construction and a determinant/log-volume bound for that exact hull,
while preserving the common-container/charted comparison audits already in
place.

## Periodic Review: Union-Hull Provenance at the Source Boundary

Date: 2026-05-27

This checkpoint reviews the recent milestones that carried the
union-of-possible-images hull route up to the source package.

### Current Lean Chain

The strengthened route now has the following visible path:

```text
RegionComparisonFamily.targetUnion
-> CommonHull.ofUnionSubset
-> CommonTargetHullBound
-> HullDetHullBridgeData.HullAudit
-> StructuredHullDetBridgeData.StepAudit
-> IUTStage1PreLedgerData.HullDetSourceData
-> IUTStage1SourceHullDetData
```

For the toy source package, Lean checks both:

```text
targetUnion <= constructed hull
measure constructed hull <= thetaSigned
```

at the source-facing boundary.

### Positive Alignment

This is aligned with the local source text. IUT III describes the Theta-side
quantity in Corollary 3.12 as the log-volume of the holomorphic hull of the
union of possible images of the Theta-pilot object. Mochizuki's formalization
report separates the final route into SHE, HDD, descent, and hull+det pieces.
The Lean code now mirrors that split more faithfully than the earlier
common-target-only route.

This is also useful relative to the Scholze-Stix critique: the formalization is
not allowed to jump from a chosen comparison to a final real inequality without
exposing the family of possible target images, their union, the hull containing
that union, and the measurement of that hull.

### Remaining Gaps

The current implementation is still a toy upper-ray model:

* `targetUnion` is a union of upper-ray target regions, not a family of genuine
  Theta-pilot images in a multiradial representation.
* The hull is still an upper-ray cap, not the holomorphic hull of IUT III,
  Remark 3.9.5 and Corollary 3.12.
* The determinant/log-volume bound is still supplied by upper-ray
  normalization, not by the determinant/module/log-volume argument described
  in the IUT papers.
* `IUTStage1SourceHullDetData` is optional source evidence, not yet a required
  field of the source obligations used to produce the older public endpoint.

### Global 3.12 Check

The project has not proven Mochizuki's Corollary 3.12. What it now has is a
cleaner audit boundary: a serious non-toy proof must provide source-facing
split hull+det data, including containment of the union of possible Theta
images in the constructed hull and a determinant/log-volume bound for that
same hull.

## Periodic Review: Strengthened Hull+Det Obligations

Date: 2026-05-28

This checkpoint reviews the strengthened source-obligation route.

### Current Lean Chain

The source-facing route now has two obligation levels:

```text
IUTStage1SourceObligations
IUTStage1SourceHullDetObligations
```

The strengthened hull+det obligations contain:

```text
sourceObligations : IUTStage1SourceObligations package
hullDetData       : IUTStage1SourceHullDetData package
```

They project to the old endpoint through:

```text
toSourceObligations
comparisonDataOfHullDetObligations
publicAuditOfHullDetObligations
```

and still expose:

```text
targetUnion <= constructed hull
measure constructed hull <= thetaSigned
```

### Positive Alignment

This moves the code closer to the intended IUT III route. The final comparison
can now be requested through obligations that explicitly include the split
hull+det provenance. This makes the source-facing boundary less permissive for
future non-toy work: a source proof can no longer be considered fully audited
unless it supplies both the old promotion obligations and the hull/determinant
evidence.

### Remaining Gaps

The old `IUTStage1SourceObligations` route remains available and is still used
by many existing endpoint constructors. The strengthened route is parallel,
not mandatory. Also, the toy source still supplies an upper-ray hull and
upper-ray-normalized measure, not the holomorphic hull and determinant/log-
volume calculation from IUT III/IV.

### Global 3.12 Check

The formalization still has not reached the real Mochizuki mathematical
construction. The immediate next target should be an audited endpoint object
that packages both the public Corollary-3.12-shaped comparison and the
source-facing hull provenance, so users cannot inspect one without seeing the
other.

## Periodic Review: Multiradial Images and Indeterminacy Quotient

Date: 2026-05-28

This checkpoint reviews the new possible-image, quotient, and multiradial hull
endpoint layers.

### Current Lean Chain

The source-facing route now exposes:

```text
IUTStage1ThetaPilotPossibleImages
-> IUTStage1IndeterminacyQuotient
-> IUTStage1MultiradialThetaImages
-> ThetaPilotHullEndpoint
-> MultiradialThetaHullEndpoint
```

The endpoint proves:

```text
multiradial image union = possible-image endpoint union
multiradial image union <= constructed hull
measure constructed hull <= thetaSigned
Corollary312Inequality theta q
```

It also keeps the quotient invariant available:

```text
related choices -> same possible-image region
```

### Positive Alignment

This is aligned with the source description of the multiradial representation
as data constructed up to `(Ind1)`, `(Ind2)`, `(Ind3)`, and with the formalized
route through descent and hull+det before the final Corollary 3.12 comparison.

The code now prevents a common drift: treating possible images as anonymous
target regions while speaking in prose about the Theta-pilot. The source label,
possible-image family, quotient relation, hull containment, determinant bound,
and final signed inequality are all connected by Lean terms.

### Risks Found

The named `theorem311Ind1`, `theorem311Ind2`, and `theorem311Ind3` records are
still placeholders. Their boolean fields are not used by downstream proofs, and
they must not be interpreted as a complete formal definition of the three IUT
indeterminacies.

The quotient relation is still supplied abstractly. The toy model uses the
discrete relation, so it tests the interface only. It does not test the real
content of quotienting by nontrivial indeterminacy actions.

### Global 3.12 Check

This remains on track for the 3.11 -> 3.12 dispute because the new interface
forces the exact place where the contested nontrivial content must land:

```text
construct the multiradial Theta images
define the Ind1/2/3-generated quotient relation
prove possible-image invariance under that relation
prove the hull+det bound for the resulting union
```

The next implementation should not add more endpoint packaging. It should move
one level lower by modeling generated indeterminacy steps/actions and deriving
an equivalence relation from them.

## Periodic Review: Theorem 3.11 Choice Model

Date: 2026-05-28

This checkpoint reviews the transition from generic quotient infrastructure to
Theorem 3.11-shaped indeterminacy choices.

### Current Lean Chain

The source-facing indeterminacy route now has:

```text
IUTStage1Theorem311IndeterminacySourceData
IUTStage1Theorem311Choice
ProcessionAutomorphismStep
LocalTensorSymmetryStep
UpperSemiCompatibilityStep
```

The generated relation for `IUTStage1Theorem311Choice` preserves:

```text
column
coric
```

and Lean derives possible-image invariance when the image family depends only
on `coric`.

### Source Alignment

This matches the statement of IUT III Theorem 3.11 at the level of roles:

```text
Ind1: automorphisms of the procession of D-prime-strips
Ind2: local tensor-factor/order-two symmetry indeterminacies
Ind3: upper semi-compatibility as m varies
```

The model correctly treats `Ind3` as allowed to vary the row coordinate `m`,
while preserving the column `n` and coric data.

### Risks Found

The current relation records only which abstract coordinates may change. It
does not yet encode the content of:

```text
processions of D-prime-strips
local tensor packet direct summands
inclusions at nonarchimedean places
surjections at archimedean places
log-link compatibility
```

So this is not yet a formalization of Theorem 3.11 itself. It is a typed target
for the next layer of records.

### Global 3.12 Check

The work is still aligned with the Corollary 3.12 dispute: the route now makes
explicit that the possible images must be invariant under the generated
Theorem 3.11 indeterminacies before the hull endpoint can be used seriously.

The next step should define typed state records for the three abstract
coordinates, especially the upper-semi-compatibility state, because that is
where the source text distinguishes inclusions, surjections, and log-volume
compatibility.

## Periodic Review: Local Log-Volume Path

Date: 2026-05-28

This checkpoint reviews the local log-volume objects added after the typed
upper-semi place split.

### Current Lean Chain

The local upper-semi route now has:

```text
IUTStage1PlaceKind
IUTStage1LocalObjectId
IUTStage1LocalLogVolumeObject
IUTStage1FiniteLocalLogVolumeObject
IUTStage1CapsuleLogVolumeObject
IUTStage1TypedCapsuleFamilyLogVolume
IUTStage1ProcessionNormalizedLogVolume
```

The strongest current equation is:

```text
totalLogVolume = Finset.univ.sum fun i => (capsule i).logVolume
normalizedLogVolume = totalLogVolume / capsuleCount
```

### Source Alignment

This is aligned with IUT III Proposition 3.9 at the interface level. The source
text separates packet-normalized local log-volumes from
procession-normalized log-volumes obtained by averaging over capsules in a
procession. The Lean code now has explicit places, local objects, capsules,
finite sums, and an average.

### Risks Found

The analytic construction is still absent. In particular, the code does not yet
formalize:

```text
M(IQ(-))
compact-open or compact-closure regions
direct summand local fields
mono-analytic log-shells
the actual packet-normalized log-volume maps
```

So the current records are a typed audit interface, not a proof of Proposition
3.9.

### Global 3.12 Check

This remains relevant to the 3.11 -> 3.12 route because Corollary 3.12 depends
on log-volume estimates after passing through the multiradial/upper-semi
indeterminacy layer. The current API makes it harder to hide the log-volume
calculation as a bare real number.

The next mathematical target should connect capsule objects to the local tensor
packet/log-shell state in `IUTStage1Theorem311Choice`, then later replace the
log-volume fields by actual maps on typed local regions.

## Periodic Review: Tensor Packet Capsule Link

Date: 2026-05-28

This checkpoint reviews the first connection between the local tensor-factor
state and typed capsule log-volumes.

### Current Lean Chain

The new chain is:

```text
IUTStage1LocalTensorState
IUTStage1TypedCapsuleFamilyLogVolume
IUTStage1LocalTensorPacketLogVolumeState
IUTStage1TensorPacketTheorem311Choice
```

The important proof obligation is:

```text
tensorState.directSummandCount = capsuleFamily.capsuleCount
```

Together with positivity of the capsule count, this gives positivity of the
local tensor direct summand count.

### Source Alignment

This is still only source-facing structure, but it is aligned with the stated
division of roles in IUT III: Proposition 3.9 supplies packet/procession
log-volume structure, while Theorem 3.11 treats `(Ind2)` as local tensor-factor
symmetry. The Lean code now records an explicit bridge rather than letting
`(Ind2)` remain a label disconnected from log-volume normalization.

### Risks Found

The equality between direct summands and capsule count is currently assumed as
record data. This is appropriate for the current layer, but it is not yet a
constructed theorem from Hodge-theater or Frobenioid definitions.

The forgetful map to `IUTStage1StructuredTheorem311Choice` is one-way. We must
not later use it to pretend that arbitrary structured choices can be lifted
back to packet choices without extra obligations.

### Global 3.12 Check

This helps the Corollary 3.12 investigation because it prevents the local
tensor coordinate and the log-volume/capsule coordinate from drifting apart.
The next step should introduce a packet-aware `(Ind2)` step relation and prove
exactly which packet/log-volume fields it preserves.

## Periodic Review: Packet and Direct Summand `(Ind2)` Path

Date: 2026-05-28

This checkpoint reviews the local tensor-factor refinement added after the
first packet/capsule link.

### Current Lean Chain

The current `(Ind2)` path now has:

```text
IUTStage1TypedCapsuleFamilyLogVolumeAction
IUTStage1TensorDirectSummandObject
IUTStage1TensorDirectSummandFamily
IUTStage1TensorDirectSummandFamilyAction
IUTStage1LocalTensorDirectSummandPacketState
IUTStage1DirectSummandPacketTheorem311Choice
```

The important direction is:

```text
direct summand action -> capsule action -> finite-sum log-volume preservation
```

### Source Alignment

This follows the wording of IUT III, Theorem 3.11 `(Ind2)` more closely than the
earlier packet record. `(Ind2)` concerns actions on direct summands of local
tensor products. The Lean code now has a typed direct-summand family and a
direct-summand action that induces a capsule action.

The source distinction between nonarchimedean `Ism` copies and archimedean
order-two automorphisms is currently recorded only as
`IUTStage1TensorSummandSymmetryKind`. This is intentional: the actual
automorphism groups are not yet constructed.

### Risks Found

The current direct-summand family is indexed by the capsule family's finite
index type. This is clean and avoids casts, but it is a modeling decision. When
we later formalize the actual local tensor product, we must check whether the
source gives a canonical shared index or only a cardinality equality.

The action preserves per-capsule log-volume values by assumption. This is not
yet a theorem from `Ism` or order-two automorphism invariance.

### Global 3.12 Check

This remains on track for the Corollary 3.12 dispute because it avoids treating
local tensor symmetries as harmless labels. Downstream log-volume preservation
now has a visible dependency chain through finite indexed data. The next major
risk is the transition from this abstract action surface to actual
Hodge-theater/local tensor objects.

## Periodic Review: Refined Multiradial Quotient Packages

Date: 2026-05-28

This checkpoint reviews the refined multiradial quotient work built on the
direct-summand packet choice type.

### Current Lean Chain

The current refined chain includes:

```text
IUTStage1RefinedThetaImagesDependOnlyOnCoric
IUTStage1Theorem311RefinedMultiradialSubclaim
IUTStage1RefinedThetaImageGeneratorInvariance
IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim
nonarchimedeanIsmIndeterminacySourceData
archimedeanOrderTwoIndeterminacySourceData
IUTStage1NonarchimedeanIsmThetaImageGeneratorInvariance
IUTStage1ArchimedeanOrderTwoThetaImageGeneratorInvariance
IUTStage1NonarchimedeanIsmMultiradialThetaImages
IUTStage1ArchimedeanOrderTwoMultiradialThetaImages
```

The important proof shape is:

```text
generator-wise invariance
  -> generated quotient invariance
  -> source-level multiradial image package
```

### Source Alignment

This matches the source split in IUT III, Theorem 3.11 better than the earlier
single generic quotient. The nonarchimedean `Ism` and archimedean order-two
paths now have separate generated source data and separate image packages.

The source text also says the construction is functorial with respect to
isomorphisms of processions. In the current Lean API, that functoriality is
still represented as the `(Ind1)` generator invariance field, not as an actual
functor on a category of processions.

### Risks Found

The source-specific packages still work one place kind at a time. IUT III uses
collections of places and distinguishes `Vnon_Q` and `Varc_Q`; the next layer
should aggregate families of local place-kind packages rather than treating one
kind as the whole story.

The `Ism` and order-two automorphism actions are still abstract records with
log-volume preservation obligations. They are not yet constructed from the
local tensor product definitions.

### Global 3.12 Check

The work remains aligned with the Corollary 3.12 dispute because the refined
multiradial image packages require explicit quotient invariance before possible
images are identified. This helps prevent silently collapsing local tensor
representatives or Hodge-theater histories into a single undifferentiated copy.

The next mathematical target should aggregate nonarchimedean and archimedean
local data across place families, while preserving the source-specific quotient
invariance already proved for each kind.
