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
