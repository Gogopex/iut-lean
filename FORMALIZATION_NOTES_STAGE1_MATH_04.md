# Formalization Notes: Stage 1 Math, Part 04

This file continues the stage-1 mathematical implementation notes after
`FORMALIZATION_NOTES_STAGE1_MATH_03.md`.  The root `FORMALIZATION_NOTES.md`
should remain the older infrastructure/base notebook; current Corollary 3.12
math updates continue here.

## 190. The 3.11.5 Audit Exposes Allowed Chart Readings

### Lean Move

We added the chart-discipline accessors:

```text
qToTargetAllowedAtChart
thetaToTargetAllowedAtChart
thetaChartTrivial
```

for `ThreeElevenFiveWeightedThetaAudit` in both route namespaces.

### Mathematical Reason

Once the audit names the package's real-comparison chart, it should also expose
the permitted readings attached to that chart.  The q-side reading is the
order-preserving transport into the target real-line copy, while the Theta-side
reading is allowed together with explicit trivial monodromy.

### Source Check

This addresses the real-line-copy part of the Corollary 3.12 dispute at the
current abstraction level.  It does not assert that the weighted-theta
comparison has been proved, but it records that any use of the 3.11.5 audit is
using the package's named chart discipline rather than an unnamed identification
of real numbers.

### Relevance to the 3.12 Dispute

The formal boundary now exposes the exact chart permissions available when the
hard comparison is supplied.  Later work can require these accessors when
deriving the weighted-to-Theta inequality from Hodge-theater data.

## 191. The 3.11.5 Audit Names The Two Real Endpoints

### Lean Move

We added:

```text
ThreeElevenFiveWeightedThetaEndpointAudit
ThreeElevenFiveWeightedThetaAudit.endpointAudit
ThreeElevenFiveWeightedThetaEndpointAudit.recovers_weightedAverage_le_thetaAverage
```

for both the labelwise and cusp-class routes.

### Mathematical Reason

The remaining hard comparison has two precise real endpoints:

```text
squareWeightedAverage.weightedAverageLogVolume
thetaSourceAverage
```

The endpoint audit names these reals and records that the inequality in the
3.11.5 audit is exactly the inequality between them.  The constructor is marked
`noncomputable` because it materializes the square-weighted average value.

### Source Check

This matches the Scholze-Stix demand that the real quantities being compared be
spelled out, rather than hidden behind notation.  It also keeps Mochizuki's
final comparison slot precise: the source-level proof must target these two
real log-volume endpoints.

### Relevance to the 3.12 Dispute

Future work can replace the current explicit inequality by a proof that
constructs this endpoint audit from source-level Hodge-theater data.  Until
then, Lean records exactly which endpoint inequality remains assumed.

## 192. 3.11.5 Comparison Data Uses The Endpoint Audit

### Lean Move

We added:

```text
ThreeElevenFiveWeightedThetaAudit.comparisonData_uses_endpointAudit
```

for both the labelwise and cusp-class routes.

### Mathematical Reason

The comparison data emitted by a `ThreeElevenFiveWeightedThetaAudit` now has a
named proof that its weighted-to-Theta inequality is exactly the inequality
recovered from the endpoint audit.

### Source Check

This keeps the formal chain honest about the real quantities under comparison.
The source-tagged comparison data cannot be read as introducing a second,
independent proof of the disputed inequality; it is tied back to the endpoint
audit naming the square-weighted average and the Theta-source average.

### Relevance to the 3.12 Dispute

When future source-level work replaces the explicit audit input, the replacement
target is now even more precise: produce endpoint data, recover the endpoint
inequality, and feed that exact proof into the 3.11.5 comparison data.

## 193. 3.11.5 Routes Use The Endpoint Audit

### Lean Move

We added:

```text
weightedThetaComparisonRouteOfThreeElevenFive_uses_endpointAudit
```

for both the labelwise and cusp-class route certificates.

### Mathematical Reason

The full route certificate built from the `3.11.5 => 3.12` audit now exposes
that its hard field

```text
weightedAverage_le_thetaAverage
```

is exactly the inequality recovered from the endpoint audit.

### Source Check

This keeps the source-facing final comparison from being duplicated or obscured
after the route certificate is built.  The route does not introduce a new
comparison; it carries forward the same endpoint audit.

### Relevance to the 3.12 Dispute

Downstream users of the route can recover the precise endpoint proof that drives
the final q/Theta inequality.  This makes the remaining dispute point visible
even at the full-route API boundary.

## 194. Endpoint Audits Carry 3.11.5 Provenance

### Lean Move

We strengthened:

```text
ThreeElevenFiveWeightedThetaEndpointAudit
```

for both the labelwise and cusp-class routes.  The endpoint audit now records:

```text
final_comparison_checkpoint
simultaneous_comparison_checkpoint
real_comparison_chart
```

with accessor theorems:

```text
ThreeElevenFiveWeightedThetaEndpointAudit.finalCheckpoint_eq
ThreeElevenFiveWeightedThetaEndpointAudit.simultaneousCheckpoint_eq
ThreeElevenFiveWeightedThetaEndpointAudit.realComparisonChartMatchesPackage
```

The example file exposes the same fact via endpoint-provenance examples.

### Mathematical Reason

The previous endpoint audit named the two real numbers and their inequality, but
the checkpoint and chart provenance lived one layer above it in the
`ThreeElevenFiveWeightedThetaAudit`.  That was too easy to misuse: a later
consumer could carry the endpoint inequality without also carrying the fact that
it belongs to the final `3.11.5 => 3.12` simultaneous comparison chart.

The endpoint audit is now a self-contained certificate for the disputed real
comparison endpoint.  It still does not derive the hard inequality; it says that
any proof of the hard inequality must be attached to the exact final checkpoint
and real comparison chart used by the package.

### Source Check

Mochizuki's April 2026 formalization report describes the final portion of the
Theorem 3.11 to Corollary 3.12 route as the `3.11.5 => 3.12` comparison of the
q- and Theta-pilot objects in a common container after moving the `hull+det`
work into the `3.11.5` side.  The new fields mirror that organization: the
endpoint comparison is not a free-floating real inequality but part of this
named final simultaneous-comparison stage.

Scholze-Stix's discussion of Corollary 3.12 asks that the relevant copies of the
real line and their identifications be spelled out.  Recording the chart at the
endpoint-audit level is a direct response to that requirement: the real
endpoints and the chart in which they are compared travel together.

### Relevance to the 3.12 Dispute

The current unresolved mathematical load remains exactly the same endpoint
inequality:

```text
squareWeightedAveragedLogVolume.weightedAverageLogVolume <= thetaSourceAverage
```

but the formalization now prevents that inequality from being detached from its
claimed 3.11.5 provenance.  This is useful before moving deeper into the
Hodge-theater side: when we eventually replace the explicit audit assumption by
source-level construction, Lean will require us to produce not merely an
inequality, but an inequality at the named final checkpoint and chart.

## 195. Structured-SHE Transport Supplies The Weighted Endpoint

### Lean Move

We added the transport-to-endpoint bridge:

```text
FLZModCuspLabelCompatibleAveragedInd12Audit.squareWeightedAverage_eq_transportSourceAverage
```

and, for both labelwise and cusp-class routes:

```text
ThreeElevenFiveStructuredSHEWeightedThetaAudit
ThreeElevenFiveStructuredSHEWeightedThetaAudit.transportBridge_eq_structuredSHE
ThreeElevenFiveStructuredSHEWeightedThetaAudit.histories_not_identified
ThreeElevenFiveStructuredSHEWeightedThetaAudit.squareWeightedAverage_eq_transportSource
ThreeElevenFiveStructuredSHEWeightedThetaAudit.weightedAverage_le_thetaAverage
ThreeElevenFiveStructuredSHEWeightedThetaAudit.toThreeElevenFiveWeightedThetaAudit
weightedThetaComparisonRouteOfStructuredSHE
weightedThetaComparisonRouteOfStructuredSHE_source
weightedThetaComparisonRouteOfStructuredSHE_uses_transport
```

The example file now has public structured-SHE examples showing that this route
recovers a final q/Theta signed comparison.

### Mathematical Reason

Before this milestone, the `ThreeElevenFiveWeightedThetaAudit` took the disputed
endpoint inequality directly:

```text
squareWeightedAveragedLogVolume.weightedAverageLogVolume <= thetaSourceAverage
```

The new structured-SHE audit does not take that inequality directly.  Instead it
requires:

```text
IUTStage1StructuredSHESquareWeightTransportAudit
profile = transport.sourceProfile
cuspLogVolume = transport.sourceLogVolume
transport.targetTransportedAverage <= thetaSourceAverage
```

Lean then uses the existing Hodge/SHE square-weight transport theorem

```text
transport.targetTransportedAverage = transport.sourceAverage
```

together with the new equality identifying the formal square-weighted average
with the transport source average.  Thus the endpoint inequality is now derived
from a source-side transport certificate plus one remaining target-side
comparison.  This is a real reduction of the bare audit input: the square-weight
preservation branch must pass through the structured-SHE/Hodge-descent bridge.

### Source Check

Mochizuki's April 2026 formalization report describes the final
`3.11.5 => 3.12` step as the simultaneous comparison of q- and Theta-pilot
objects in a common container, after the `hull+det` work has been moved into
the preceding `3.11.5` side.  The new Lean structure follows that split: the
endpoint route still belongs to the final comparison, but the equality that
makes the square-weighted source average available is now explicitly routed
through structured SHE square-weight transport.

This also tracks IUT III, Corollary 3.12, Step `(xi)`, where the final real
comparison is supposed to come after multiradial construction, indeterminacies,
holomorphic hulls, determinant formation, and simultaneous consideration of the
q- and Theta-side pilot data.

Scholze-Stix's criticism focuses on whether the needed real comparisons survive
consistent identifications of the relevant real-line copies.  The new structure
keeps the Hodge-theater histories nonidentified:

```text
histories_not_identified
```

and it requires explicit source-profile and source-log-volume equalities before
the transported average may be read as the square-weighted average in the final
endpoint.

### Relevance to the 3.12 Dispute

The remaining unresolved input has moved.  We no longer need to assume the
final square-weighted endpoint inequality as an isolated fact in this route; we
can derive it from:

```text
structured-SHE square-weight transport
transport.targetTransportedAverage <= thetaSourceAverage
```

The next mathematical pressure point is therefore sharper: justify the
target-side transported-average comparison from the actual Hodge-theater,
multiradial, IPL, SHE, APT, and hull/determinant data, without collapsing the
distinct histories into a trivial identification.

## 196. Pointwise Target Bounds Supply The Transported Average

### Lean Move

We added the weighted-average upper-bound lemma:

```text
IUTStage1WeightedLabelAveragedProcessionLogVolume.weightedAverage_le_const_of_forall_le
```

and specialized it to the square-weight transport audit:

```text
IUTStage1ZModSquareWeightedFullLabelTransportAudit.targetTransportedWeightedLogVolume
IUTStage1ZModSquareWeightedFullLabelTransportAudit.targetTransportedAverage_le_of_forall_targetFullLabel_le
```

For both labelwise and cusp-class routes we then added:

```text
ThreeElevenFiveStructuredSHEPointwiseTargetThetaAudit
ThreeElevenFiveStructuredSHEPointwiseTargetThetaAudit.toStructuredSHEWeightedThetaAudit
ThreeElevenFiveStructuredSHEPointwiseTargetThetaAudit.weightedAverage_le_thetaAverage
ThreeElevenFiveStructuredSHEPointwiseTargetThetaAudit.toThreeElevenFiveWeightedThetaAudit
weightedThetaComparisonRouteOfPointwiseTarget
```

The example file now verifies that the pointwise-target route also produces the
final q/Theta signed comparison.

### Mathematical Reason

The previous milestone reduced the endpoint problem to:

```text
transport.targetTransportedAverage <= thetaSourceAverage
```

This milestone reduces that average-level input further.  It is enough to
provide pointwise bounds:

```text
transport.targetLogVolume.fullLabelLogVolume
  (fromCoordinate (transport.coordinateEquiv j)) <= thetaSourceAverage
```

for every `j : ZMod l.value`.  Lean proves the average bound from these
pointwise bounds because the square weights are nonnegative and the total weight
is positive.

This is a useful mathematical decomposition: the remaining comparison is now
located at the transported target full-label log-volume branch, not at an
opaque weighted average.

### Source Check

This matches the way Corollary 3.12 uses `j^2`-weighted label data: the final
average should be controlled by estimates on the labeled components together
with the nonnegative square weights.  It also keeps the role of the Hodge/SHE
transport separate: transport supplies the equality between source and target
averages; pointwise target estimates supply the upper bound against the
Theta-source average.

Scholze-Stix's objection remains visible here.  The pointwise estimates are not
allowed to identify the q- and Theta-side real lines silently; they are stated
against the transported target full-label values inside the structured-SHE route.

### Relevance to the 3.12 Dispute

The pressure point is now more local.  To complete this branch, we need a
source-level construction of the pointwise transported target full-label
inequalities from the actual multiradial/Hodge-theater data.  The Lean chain
from such pointwise inequalities to the final Corollary-3.12-shaped q/Theta
comparison is now explicit and verified.

## 197. Constant Target Values Supply Pointwise Target Bounds

### Lean Move

We added, for both the labelwise and cusp-class routes:

```text
ThreeElevenFiveStructuredSHEConstantTargetThetaAudit
ThreeElevenFiveStructuredSHEConstantTargetThetaAudit.toPointwiseTargetThetaAudit
ThreeElevenFiveStructuredSHEConstantTargetThetaAudit.weightedAverage_le_thetaAverage
ThreeElevenFiveStructuredSHEConstantTargetThetaAudit.toThreeElevenFiveWeightedThetaAudit
weightedThetaComparisonRouteOfConstantTarget
weightedThetaComparisonRouteOfConstantTarget_uses_constantTarget
```

The example file now exposes public constant-target examples for both route
shapes.

### Mathematical Reason

The previous milestone accepted pointwise transported target bounds as the
remaining input:

```text
targetLogVolume.fullLabelLogVolume(fromCoordinate (coordinateEquiv j))
  <= thetaSourceAverage
```

This milestone records one concrete sufficient condition for those pointwise
bounds.  If the transported target log-volume object is exactly the Theta-side
cusp log-volume object, and every normalized averaged label value is exactly the
Theta-source average, then each transported target full-label value is bounded
by the Theta-source average by equality.

Lean proves this by rewriting the target log-volume object, then using the
existing full-label/coordinate compatibility theorem:

```text
averageLabel_eq_fullLabelLogVolume_fromCoordinate
```

The result is intentionally only a sufficient route.  It does not assert that
the actual IUT source machinery produces constant normalized target values.

### Source Check

This is not claimed as a direct theorem from Mochizuki's papers.  It is a
sanity route: it checks that the formal pipeline from target-side label control
to the final q/Theta comparison behaves correctly when the target label data is
degenerate in the strongest possible way.

For the Corollary 3.12 dispute this is useful mainly as a guardrail.  If a later
candidate Hodge-theater construction silently collapses the relevant target data
to this constant case, the assumption will be visible as an explicit equality
field rather than hidden inside the weighted-average endpoint.

### Relevance to the 3.12 Dispute

The proof obligation is now stratified into three visible levels:

```text
constant target labels
  -> pointwise transported target bounds
  -> transported weighted-average bound
  -> final 3.11.5-to-3.12 q/Theta comparison
```

The actual dispute still sits upstream: whether Mochizuki's Hodge-theater/SHE
machinery legitimately supplies the needed target-side control without the
Scholze-Stix collapse.  This milestone gives Lean another audited route through
the corridor, while keeping that source-level question explicit.

## 198. Zero/Cusp Target Bounds Supply Pointwise Target Bounds

### Lean Move

At the `IUTStage1ZModCuspLabelLogVolumeCompatibility` level we added:

```text
fullLabelLogVolume_le_of_zero_and_cuspClass_le
fullLabelLogVolume_fromCoordinate_le_of_zero_and_cuspClass_le
```

These lemmas say that an upper bound on the zero log-volume and an upper bound
on every nonzero cusp-class log-volume imply the same upper bound for every
full-label coordinate.

For both the labelwise and cusp-class 3.11.5 routes we then added:

```text
ThreeElevenFiveStructuredSHEZeroCuspTargetThetaAudit
ThreeElevenFiveStructuredSHEZeroCuspTargetThetaAudit.toPointwiseTargetThetaAudit
ThreeElevenFiveStructuredSHEZeroCuspTargetThetaAudit.weightedAverage_le_thetaAverage
ThreeElevenFiveStructuredSHEZeroCuspTargetThetaAudit.toThreeElevenFiveWeightedThetaAudit
weightedThetaComparisonRouteOfZeroCuspTarget
weightedThetaComparisonRouteOfZeroCuspTarget_uses_zeroCuspTarget
```

The example file verifies the corresponding public q/Theta comparison examples.

### Mathematical Reason

The pointwise target route needs:

```text
targetLogVolume.fullLabelLogVolume(fromCoordinate (coordinateEquiv j))
  <= thetaSourceAverage
```

The target log-volume object is not primitive coordinate data.  It is a
zero/nonzero cusp-label object:

```text
zeroLogVolume
cuspClassLogVolume label
```

This milestone makes that decomposition usable on the target-upper side.  To
produce the pointwise target bound, it is enough to prove:

```text
targetLogVolume.zeroLogVolume <= thetaSourceAverage
targetLogVolume.cuspClassLogVolume label <= thetaSourceAverage
```

for every nonzero cusp class.  Lean then performs the zero/nonzero split via
`fromCoordinate` and feeds the result into the existing pointwise-target route.

### Source Check

This follows the same zero/nonzero label split already used on the local
container side of the formalization.  It is also closer to the notation of IUT
III's local cusp-label estimates than the previous monolithic pointwise
coordinate hypothesis, because the nonzero labels are handled through the sign
quotient rather than by pretending the target data is a flat coordinate family.

For the Scholze-Stix issue, the important point is that these are target-side
upper estimates inside the structured-SHE route.  The proof does not identify
the source and target real lines; it only decomposes the target log-volume
object after the structured transport audit has named it.

### Relevance to the 3.12 Dispute

The remaining source-level task is now more faithful to the local geometry:

```text
zero target estimate
nonzero cusp-class target estimates
  -> pointwise transported target bounds
  -> transported weighted-average bound
  -> final 3.11.5-to-3.12 q/Theta comparison
```

This is still not a proof of Corollary 3.12.  It exposes the precise local
upper estimates that would have to come from the Hodge-theater/SHE and
hull/log-volume machinery without collapsing the histories.

## 199. Source Zero/Cusp Bounds Feed The Target Zero/Cusp Route

### Lean Move

For both the labelwise and cusp-class 3.11.5 routes we added:

```text
ThreeElevenFiveStructuredSHESourceZeroCuspTargetThetaAudit
ThreeElevenFiveStructuredSHESourceZeroCuspTargetThetaAudit.toZeroCuspTargetThetaAudit
ThreeElevenFiveStructuredSHESourceZeroCuspTargetThetaAudit.weightedAverage_le_thetaAverage
ThreeElevenFiveStructuredSHESourceZeroCuspTargetThetaAudit.toThreeElevenFiveWeightedThetaAudit
weightedThetaComparisonRouteOfSourceZeroCuspTarget
weightedThetaComparisonRouteOfSourceZeroCuspTarget_uses_sourceZeroCuspTarget
```

The example file now has public source-zero/cusp target examples for both route
shapes.

### Mathematical Reason

The previous milestone required target-side zero/cusp estimates:

```text
targetLogVolume.zeroLogVolume <= thetaSourceAverage
targetLogVolume.cuspClassLogVolume label <= thetaSourceAverage
```

This milestone introduces a source-facing way to produce them.  If the
structured-SHE transport audit identifies its target log-volume object with the
Theta-side cusp log-volume object,

```text
transport.targetLogVolume = theta_source.compatible_average.cuspLogVolume audited
```

then upper estimates on the Theta-side zero/cusp log-volume components rewrite
to the target-side estimates and feed the zero/cusp target route.

### Source Check

This is closer to the final disputed shape than the constant-target sanity
route.  The remaining estimates are now stated on the Theta-side local
zero/nonzero cusp components, while the structured-SHE audit is responsible for
moving those components to the transported target log-volume object.

The move is deliberately conservative: it records the target/source
log-volume equality as an explicit field.  That prevents Lean from silently
identifying the histories or real-line copies, which is exactly the kind of
collapse Scholze-Stix warn about and Mochizuki says the Hodge-theater
apparatus is designed to avoid.

### Relevance to the 3.12 Dispute

The formal corridor now factors this branch as:

```text
Theta-side zero/cusp upper estimates
transport target log-volume equals the Theta-side cusp object
  -> target zero/cusp upper estimates
  -> pointwise transported target bounds
  -> transported weighted-average bound
  -> final 3.11.5-to-3.12 q/Theta comparison
```

The hard mathematical load has moved to proving the Theta-side zero/cusp upper
estimates and the justified structured-SHE target/source log-volume equality
from the actual Hodge-theater construction.

## 200. Constant `ZMod` Packet Data Supplies Source Zero/Cusp Bounds

### Lean Move

In the namespace for

```text
FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit
```

we added:

```text
cuspClassLogVolume_eq_packetNormalized
zeroLogVolume_eq_packetNormalized
cuspClassLogVolume_eq_thetaSourceAverage
zeroLogVolume_eq_thetaSourceAverage
source_cuspClassLogVolume_le_thetaAverage
source_zeroLogVolume_le_thetaAverage
```

The example file now exposes the equality and inequality forms for both the
zero component and the nonzero cusp-class components.

### Mathematical Reason

The source-zero/cusp route from the previous milestone asks for:

```text
source zeroLogVolume <= thetaSourceAverage
source cuspClassLogVolume label <= thetaSourceAverage
```

The constant `ZMod` packet-normalized route already says that every coordinate
of the averaged label family is the packet-normalized capsule value, and that
the Theta-source average is the same packet-normalized value.  Lean now also
pushes this fact through the zero/nonzero cusp-label compatibility object:

```text
zeroLogVolume = packetNormalized = thetaSourceAverage
cuspClassLogVolume label = packetNormalized = thetaSourceAverage
```

The required upper estimates follow by `le_of_eq`.

### Source Check

This is still the degenerate constant-label branch, not a claim that the full
IUT source machinery has proved the nonconstant local estimates.  Its role is
to verify that the formal chain from a packet-normalized label-family equality
through zero/cusp decomposition into the source-zero/cusp target route is
mathematically coherent.

Relative to the Scholze-Stix concern, this remains an explicit equality route:
Lean does not treat source and target histories as interchangeable.  The
constant packet data supplies only the source-side zero/cusp estimates; the
structured-SHE equality needed to read them as target-side estimates is still a
separate field of the later 3.11.5 route.

### Relevance to the 3.12 Dispute

The current branch now has an audited source of the local estimates in the
simplest possible packet-normalized case:

```text
constant ZMod packet-normalized label family
  -> source zero/cusp values equal thetaSourceAverage
  -> source zero/cusp upper estimates
  -> source-zero/cusp target route
```

The remaining nontrivial work is to replace this constant-label source by the
actual Hodge-theater/SHE and hull/log-volume estimates that Mochizuki intends
for Corollary 3.12.

## 201. Constant `ZMod` Packet Data Enters The Source-Zero/Cusp Route

### Lean Move

Still in

```text
FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit
```

we added:

```text
toThetaCuspClassContainerAudit
toSourceZeroCuspTargetThetaAudit
weightedThetaComparisonRouteOfConstantZModSourceZeroCuspTarget
```

The example file now exposes a conversion from the constant packet route to the
cusp-class container, and a public final q/Theta comparison route using
constant packet data plus the explicit structured-SHE transport fields.

### Mathematical Reason

The preceding milestone proved that constant `ZMod` packet-normalized data
supplies the source-side zero/cusp estimates:

```text
source zeroLogVolume <= thetaSourceAverage
source cuspClassLogVolume label <= thetaSourceAverage
```

This milestone feeds those estimates into the audited 3.11.5 corridor.  The
constant packet route first becomes a cusp-class container, because its capsule
estimate bounds the packet-normalized value and the zero/cusp log-volumes are
equal to that value.  Then, given the structured-SHE square-weight transport
audit and the explicit source/target log-volume equalities, Lean constructs:

```text
ThreeElevenFiveStructuredSHESourceZeroCuspTargetThetaAudit
```

and uses the existing source-zero/cusp target route to obtain the final
`qSigned <= thetaSigned` comparison.

### Source Check

This is the first branch where a concrete local data source, not just an
abstract source-zero/cusp audit, reaches the final 3.11.5-shaped q/Theta route.
It is still the constant packet-normalized branch, so it should be read as a
formal sanity corridor rather than as the full Mochizuki construction.

The structured-SHE part remains explicit: the route still asks separately for
the transport audit, the source profile equality, the source log-volume
equality, and the target log-volume equality.  This keeps the Scholze-Stix
identification concern visible instead of hiding it in the constant packet
calculation.

### Relevance to the 3.12 Dispute

The branch now has a complete checked path:

```text
constant ZMod packet-normalized label family
  -> cusp-class container bounds
  -> source zero/cusp upper estimates
  -> explicit structured-SHE transport equalities
  -> source-zero/cusp target route
  -> final 3.11.5-to-3.12 q/Theta comparison
```

The next nontrivial work is to replace the constant packet-normalized source by
the actual nonconstant local Hodge-theater estimates and then examine whether
the required structured-SHE equalities can be justified without collapsing the
histories.

## 202. Factored Structured-SHE Obligations Feed The Constant Branch

### Lean Move

In

```text
FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit
```

we added:

```text
toSourceZeroCuspTargetThetaAuditOfFactoredObligations
weightedThetaComparisonRouteOfConstantZModFactoredSourceZeroCuspTarget
```

The example file now verifies a public route from constant `ZMod` packet data
and factored structured-SHE obligations to the final `qSigned <= thetaSigned`
comparison.

### Mathematical Reason

The previous constant branch accepted a ready-made

```text
IUTStage1StructuredSHESquareWeightTransportAudit
```

This milestone moves one layer closer to the primitive transport data.  The
input is now the factored structured-SHE record:

```text
IUTStage1StructuredSHEFactoredSquareFullLabelObligations
```

which keeps the two relevant preservation requirements separate:

```text
coordinate-square preservation for the j^2 weights
full-label map/value preservation for the log-volume branch
```

Lean then uses the already verified conversions from factored obligations to
the structured-SHE square-weight transport audit, and feeds the result into the
constant packet source-zero/cusp route.

### Source Check

This is important for the Corollary 3.12 dispute because the representative
`j^2` preservation condition is not interchangeable with a weaker balanced
sign-compatible condition.  The factored obligation record is the branch where
that distinction is explicit: coordinate-square preservation and full-label
log-volume preservation are separate fields.

The remaining profile and log-volume matching equalities are still explicit
arguments.  This is intentional.  The formalization does not silently identify
the source profile, source log-volume object, or target log-volume object with
the constant packet route data.

### Relevance to the 3.12 Dispute

The checked branch is now:

```text
constant ZMod packet-normalized label family
  -> source zero/cusp upper estimates
  -> factored structured-SHE square/full-label obligations
  -> structured-SHE transport audit
  -> source-zero/cusp target route
  -> final 3.11.5-to-3.12 q/Theta comparison
```

The next mathematical pressure point is to replace the constant packet data and
explicit matching equalities by source-level constructions from the actual
Hodge-theater/SHE apparatus.

## 203. Factored Constant Branch Matching Is A Single Audit

### Lean Move

In

```text
FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit
```

we added the route-level certificate:

```text
FactoredSourceZeroCuspTargetAudit
```

with accessors:

```text
FactoredSourceZeroCuspTargetAudit.toSourceZeroCuspTargetThetaAudit
FactoredSourceZeroCuspTargetAudit.weightedThetaComparisonRoute
FactoredSourceZeroCuspTargetAudit.qSigned_le_thetaSigned
FactoredSourceZeroCuspTargetAudit.transportBridge_eq_structuredSHE
```

The example file now checks that this single audit proves the final q/Theta
comparison and exposes the structured-SHE bridge equality.

### Mathematical Reason

The previous milestone still passed the three matching equalities as loose
arguments:

```text
profile = obligations.sourceProfile
constantRoute.cuspLogVolume audited = obligations.sourceLogVolume
obligations.targetLogVolume = constantRoute.cuspLogVolume audited
```

These are not incidental implementation details.  They are exactly the
identifications that say the factored structured-SHE obligations are being
applied to the same profile and log-volume objects as the constant packet
route.  This milestone packages them into one certificate, next to the factored
SHE obligations themselves.

### Source Check

This follows the same discipline used throughout the Corollary 3.12 corridor:
identifications of real/log-volume data are not performed silently.  A later
construction may replace this audit by data derived from Hodge-theater/SHE
machinery, but it must still prove the same matching fields.

This directly reflects the Scholze-Stix pressure point.  The branch does not
allow the source and target histories to be identified by notation; the
structured-SHE bridge equality is an accessor theorem of the audit, and the
source/target log-volume matches are named fields.

### Relevance to the 3.12 Dispute

The current constant branch now has a cleaner certificate boundary:

```text
constant packet data
factored SHE square/full-label obligations
profile/source/target log-volume matching fields
  -> final 3.11.5-to-3.12 q/Theta comparison
```

The next step is mathematical rather than organizational: replace one of the
constant-packet or explicit matching fields by a construction from the
nonconstant local Hodge-theater route.

## 204. Ind3 Supplies The Source Zero/Cusp Upper Bounds

### Lean Move

In

```text
FLZModCuspLabelThetaCuspClassContainerAudit
```

we added

```text
ThreeElevenFiveStructuredSHEInd3SourceZeroCuspTargetThetaAudit
```

This audit is a source-zero/cusp route whose upper bounds are no longer supplied
by the constant packet equality branch.  Instead, it names three identifications:

```text
zeroLogVolume = audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume
cuspClassLogVolume label = audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume
thetaSourceAverage = audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume
```

Lean then derives:

```text
source_zeroLogVolume_le_thetaAverage
source_cuspClassLogVolume_le_thetaAverage
weightedAverage_le_thetaAverage
weightedThetaComparisonRouteOfInd3SourceZeroCuspTarget
```

The crucial inequality used in the proof is exactly:

```text
audited.upperSemi_logVolumeUpperBound
```

This is the audited form of the `(Ind3)` upper semi-compatibility inequality.

The example file now verifies two things:

```text
placeAudited_logVolume_fl_zmod_ind3_source_zero_bound_example
placeAudited_logVolume_fl_zmod_ind3_source_cusp_route_example
```

The first checks the local zero bound.  The second checks that the same `(Ind3)`
source route reaches the final q/Theta inequality.

### Mathematical Reason

This is the first replacement of the constant-packet shortcut by a genuine
Theorem 3.11 / Corollary 3.12 mechanism.  IUT III, Remark 3.12.3 explicitly
identifies upper semi-compatibility `(Ind3)` as the source of the inequality in
Corollary 3.12, with a pointer back to Step (x) of the proof.  The Lean object
therefore does not assert a free bound on zero/cusp log-volumes.  It requires
the zero and cusp-class representatives to be identified with the source real
value of the audited upper-semi datum, and it requires the theta source average
to be identified with the target real value of that same datum.

Formally, the proof shape is:

```text
source zero/cusp log-volume
  = upper-semi source log-volume
  <= upper-semi target log-volume
  = theta source average
```

This is intentionally one-sided.  We do not introduce an equality between the
source and target log-volume values; the only order step is the upper-semi
inequality already attached to the audited choice.

### Source Check

Local paper passages checked before this move:

```text
docs/INTER-UNIVERSAL TEICHM ULLER THEORY III: ... .md
```

around the Corollary 3.12 remarks says that the upper semi-compatibility
indeterminacy `(Ind3)` underlies the inequality of Corollary 3.12 and compares
this to an inequality rather than an isomorphism in the p-adic Teichmuller
analogy.

```text
docs/scholze- Why abc is still a conjecture.md
```

around Section 2.2 says that the disputed step requires explicit and consistent
identifications of copies of ordered one-dimensional real vector spaces, and
that the issue is whether the theta-side square factors can be carried through
those identifications without producing monodromy or an empty inequality.

The Lean move responds to both points: `(Ind3)` is used as the actual source of
the inequality, while the real/log-volume identifications remain named fields.
No identification of source and target real-line copies is hidden in notation.

### Relevance to the 3.12 Dispute

The active 3.12 corridor now has two mathematically distinct branches:

```text
constant packet branch:
  packet normalization equalities give source zero/cusp <= theta average

Ind3 branch:
  audited upper semi-compatibility gives source zero/cusp <= theta average
```

The second branch is closer to the paper's stated mechanism.  It isolates the
next hard obligation: construct the three matching identifications between
zero/cusp log-volumes, theta average, and the audited upper-semi source/target
values from Hodge-theater descent and the multiradial algorithm, rather than
supplying them as fields.

## 205. Hodge Descent Derives The Source Side Of The Ind3 Bridge

### Lean Move

We refined the previous `(Ind3)` bridge by adding source-side derivations from
the Hodge-descent packet transport route.

In

```text
FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit
```

we added:

```text
cuspClassLogVolume_eq_packetLocalObjectFinite
zeroLogVolume_eq_packetLocalObjectFinite
targetSigned_le_cuspClassLogVolume
targetSigned_le_zeroLogVolume
toThetaCuspClassContainerAudit
```

In

```text
FLZModCuspLabelThetaHodgeDescentPacketTransportAudit
```

we added:

```text
toThetaCuspClassContainerAudit
cuspClassLogVolume_eq_packetLocalObjectFinite
zeroLogVolume_eq_packetLocalObjectFinite
Ind3SourceTargetAlignment
toInd3SourceZeroCuspTargetThetaAudit
```

The new `Ind3SourceTargetAlignment` no longer asks for separate zero and
cusp-class identifications with the upper-semi source value.  Hodge descent
derives both zero and cusp-class log-volumes as the finite log-volume of the
packet local object.  The remaining alignment data is:

```text
packetLocalObjectFinite = upper-semi source log-volume
thetaSourceAverage = upper-semi target log-volume
```

The example file checks that this Hodge-descent-sourced route still reaches the
final q/Theta inequality:

```text
placeAudited_logVolume_fl_zmod_hodge_ind3_source_route_example
```

### Mathematical Reason

The previous milestone used `(Ind3)` correctly as the only inequality, but it
still accepted the zero/cusp-to-upper-semi-source equalities directly.  This
milestone replaces those direct fields by Hodge-descent packet transport:

```text
zero/cusp local object
  -- Hodge descent / packet transport -->
packet local object
  -- remaining real alignment -->
upper-semi source real value
```

This keeps the proof closer to the fourth-triangle picture: the zero-column/SHE
source data and cusp-class Hodge-Arakelov data are routed through the packet
descent target before entering the upper-semi inequality.

The endpoint proof shape is now:

```text
zero/cusp log-volume
  = finite log-volume of packet local object      (Hodge descent)
  = upper-semi source log-volume                  (alignment)
  <= upper-semi target log-volume                 (Ind3)
  = theta source average                          (alignment)
```

Only the third line is an inequality.  The other lines remain named
identifications.

### Source Check

This move follows the same local source readings as Section 204, but it uses
more of Mochizuki's own formalization-oriented decomposition: the recent
formalization note describes the final `3.11.5 => 3.12` piece as concentrating
on simultaneous q/Theta comparison after earlier APT/IPL/SHE work has supplied
the transport data.  Here, SHE/Hodge descent is not decorative infrastructure:
it is the reason zero/cusp representatives may be routed to the packet object
before applying `(Ind3)`.

Against the Scholze-Stix criticism, this remains conservative.  The code does
not identify real-line copies globally or silently.  The Hodge-descent packet
transport provides local-object equalities; the real-valued alignment with the
upper-semi source/target values is still an explicit `Ind3SourceTargetAlignment`
obligation.

### Relevance to the 3.12 Dispute

The active route has moved from:

```text
assume zero/cusp = upper-semi source
assume theta average = upper-semi target
use Ind3
```

to:

```text
derive zero/cusp = packet local object via Hodge descent
assume packet local object = upper-semi source
assume theta average = upper-semi target
use Ind3
```

The next hard mathematical task is now sharper: derive `Ind3SourceTargetAlignment`
from the actual multiradial algorithm / upper-semi compatibility construction,
or prove that such a derivation requires an additional nontrivial identification
of real-line copies.

## 206. Nonarchimedean Upper-Semi Entry Gives A Local Packet-To-Theta Bound

### Lean Move

Inside

```text
FLZModCuspLabelThetaHodgeDescentPacketTransportAudit
```

we added:

```text
NonarchimedeanInd3EntryAlignment
```

with derived facts:

```text
packetLocalObjectFinite_eq_entrySource
packetLocalObjectFinite_le_thetaAverage
packetLocalObjectFinite_eq_ind3Source
thetaAverage_eq_ind3Target
```

The example file checks:

```text
placeAudited_nonarch_ind3_entry_packet_le_theta_example
```

### Mathematical Reason

This formalizes the nonarchimedean half of upper semi-compatibility more
directly.  A nonarchimedean upper-semi entry has a source finite log-volume, a
target finite log-volume, and an inclusion inequality:

```text
entry.sourceLogVolume.finiteLogVolume <= entry.targetLogVolume.finiteLogVolume
```

The new alignment says:

```text
packet local object finite log-volume = entry source finite log-volume
theta average = entry target finite log-volume
```

Lean then proves:

```text
packet local object finite log-volume <= theta average
```

This is not yet the full Corollary 3.12 route.  It is the local
nonarchimedean `(Ind3)` inequality that the full route must aggregate and align
with the Hodge-descent packet object and the theta source average.

### Source Check

This matches the IUT III description of upper semi-compatibility as a local
one-sided phenomenon.  The formal object is intentionally nonarchimedean: it
uses the inclusion direction already encoded in
`IUTStage1NonarchimedeanInclusionData`.  The archimedean surjection data has a
different local direction and should not be silently merged into this theorem.

### Relevance to the 3.12 Dispute

The current proof corridor separates three questions that are often conflated:

```text
1. Hodge descent gives zero/cusp = packet local object.
2. A nonarchimedean upper-semi entry gives packet local object <= theta average.
3. The global q/Theta comparison requires these local real values to match the
   audited upper-semi source/target values used by the final route.
```

The first two are now Lean-checked in separate mathematical modules.  The third
is precisely where the real-line-identification issue remains concentrated.

## 207. Archimedean Upper-Semi Entries Have The Opposite Local Direction

### Lean Move

Next to the nonarchimedean entry alignment we added:

```text
ArchimedeanInd3EntryAlignment
```

with:

```text
thetaAverage_le_packetLocalObjectFinite
packetLocalObjectFinite_eq_ind3Source
thetaAverage_eq_ind3Target
```

The example file checks:

```text
placeAudited_arch_ind3_entry_theta_le_packet_example
```

### Mathematical Reason

The archimedean upper-semi datum in the current source model is a surjection
datum:

```text
entry.targetLogVolume.finiteLogVolume <= entry.sourceLogVolume.finiteLogVolume
```

Thus, if we align

```text
packet local object = entry source
theta average = entry target
```

Lean derives:

```text
theta average <= packet local object finite log-volume
```

not the nonarchimedean-style inequality

```text
packet local object finite log-volume <= theta average
```

### Source Check

This follows the distinction already encoded in the source-facing Theorem 3.11
model: nonarchimedean upper-semi data is represented by inclusion data, while
archimedean upper-semi data is represented by surjection data.  We should not
erase that distinction when assembling the Corollary 3.12 route.

### Relevance to the 3.12 Dispute

This is a useful failure-prevention checkpoint.  One possible formalization
mistake would be to treat all upper-semi local entries as if they supplied the
same ordered real inequality.  The Lean code now makes that impossible at this
layer: the archimedean theorem exposes the reverse orientation, so any later
global aggregation must explain how the archimedean contribution is used rather
than silently folding it into the nonarchimedean inclusion argument.

## 208. Nonarchimedean Ind3 Entry Feeds The Hodge-Descent 3.12 Route

### Lean Move

We connected the local nonarchimedean upper-semi entry to the Hodge-descent
Corollary 3.12 route.

In

```text
NonarchimedeanInd3EntryAlignment
```

we added:

```text
toHodgeDescentInd3SourceTargetAlignment
```

In

```text
FLZModCuspLabelThetaHodgeDescentPacketTransportAudit
```

we added:

```text
toInd3SourceZeroCuspTargetThetaAuditOfNonarchimedeanEntry
```

The example file now checks:

```text
placeAudited_logVolume_fl_zmod_nonarch_entry_hodge_ind3_route_example
```

which builds the final q/Theta comparison from:

```text
Hodge-descent zero/cusp-to-packet transport
nonarchimedean upper-semi inclusion entry
structured-SHE square/full-label transport audit
```

### Mathematical Reason

The previous local nonarchimedean theorem proved only:

```text
packet local object finite log-volume <= theta average
```

This milestone feeds the same local entry into the full Hodge-descent `(Ind3)`
route.  In other words, the nonarchimedean local inclusion is no longer just an
isolated sanity check; it is now one admissible source of the
`Ind3SourceTargetAlignment` needed by the final route.

The proof corridor is:

```text
zero/cusp log-volume
  = packet local object finite log-volume        (Hodge descent)
  = nonarchimedean upper-semi source value       (local entry alignment)
  <= nonarchimedean upper-semi target value      (local inclusion)
  = theta source average                         (local entry alignment)
  -> weighted average <= theta average
  -> qSigned <= thetaSigned
```

### Source Check

This matches IUT III's emphasis that the inequality in Corollary 3.12 is
underwritten by upper semi-compatibility `(Ind3)` and, at the same time, keeps
the Hodge/SHE transport data visible.  It is also consistent with the
Scholze-Stix pressure point: the real/log-volume alignments are still explicit
fields of the local entry alignment and are not collapsed into definitional
equality.

### Relevance to the 3.12 Dispute

This is the first fully routed nonarchimedean `(Ind3)` path to the final
q/Theta inequality.  It gives us a candidate experimental pass:

```text
remove or vary the local entry alignments
observe exactly which final inequality proofs fail
compare failures with the claimed real-line-identification obstruction
```

The remaining experimental work is to instrument these obligations as explicit
missing-datum reports, so we can run proof variants and measure which
identifications are essential.

## 209. First Local Ind3 Experiment Reports

### Lean Move

We added a small Lean-level experiment layer:

```text
IUTStage1Ind3LocalOrientation
IUTStage1Ind3LocalExperimentReport
```

with two orientations:

```text
packet_le_theta
theta_le_packet
```

The nonarchimedean entry alignment now reports:

```text
orientation = packet_le_theta
canFeedPacketToThetaRoute = true
```

The archimedean entry alignment reports:

```text
orientation = theta_le_packet
canFeedPacketToThetaRoute = false
```

The example file checks:

```text
placeAudited_nonarch_ind3_experiment_can_feed_example
placeAudited_arch_ind3_experiment_cannot_feed_example
placeAudited_ind3_experiment_orientations_differ_example
```

### Mathematical Reason

This is the first experimental surface for the disputed Corollary 3.12 passage.
The current Hodge-descent route needs a local inequality of the form:

```text
packet local object finite log-volume <= theta average
```

The nonarchimedean inclusion entry supplies exactly this orientation.  The
archimedean surjection entry supplies the reverse orientation, so it cannot be
fed into the same packet-to-theta route without an additional argument.

### Source Check

This is aligned with IUT III's description of `(Ind3)` as the source of the
inequality but keeps the local models separated.  It also speaks directly to
the Scholze-Stix concern: once the real-valued copies and local directions are
spelled out, Lean distinguishes the usable packet-to-theta route from the
reverse-direction route.

### Experiment Status

We now have two first-pass Lean experiments:

```text
nonarchimedean entry + Hodge descent:
  can feed the q/Theta route

archimedean entry alone:
  cannot feed the current packet-to-theta route
```

The next useful experiment is a missing-alignment pass: remove the
source/target real-line alignment fields while keeping Hodge descent and local
entry data, and report exactly which final q/Theta proof obligation remains
unfilled.

## 210. Missing Real-Alignment Experiment

### Lean Move

We added:

```text
IUTStage1Ind3AlignmentMissingDatum
IUTStage1Ind3AlignmentExperimentReport
```

with missing data:

```text
packetLocalObjectFinite_eq_ind3Source
thetaAverage_eq_ind3Target
```

There are now two experiment reports:

```text
IUTStage1Ind3AlignmentExperimentReport.missingRealAlignment
NonarchimedeanInd3EntryAlignment.alignmentExperimentReport
```

The example file checks:

```text
placeAudited_nonarch_ind3_alignment_experiment_can_build_example
placeAudited_ind3_missing_alignment_experiment_blocks_example
placeAudited_ind3_missing_alignment_packet_source_gap_example
placeAudited_ind3_missing_alignment_theta_target_gap_example
```

### Mathematical Reason

The orientation experiment says whether a local `(Ind3)` entry has the right
inequality direction.  This new experiment asks a different question: even with
the right direction, do we have the real/log-volume identifications that allow
the local entry to be used as the audited upper-semi source/target pair?

Without these fields, Hodge descent still proves:

```text
zero/cusp log-volume = packet local object finite log-volume
```

and a nonarchimedean local entry may still prove:

```text
entry source <= entry target
```

but Lean refuses to jump from these to the final route unless it is also told:

```text
packet local object finite log-volume = audited Ind3 source
theta average = audited Ind3 target
```

### Source Check

This is the formal counterpart of the real-line-identification issue in the
Scholze-Stix critique.  The experiment does not claim that the alignments are
impossible; it records that they are separate mathematical input and cannot be
silently inferred from Hodge descent plus local orientation alone.

### Experiment Status

We now have three first-pass experiment outcomes:

```text
nonarchimedean local orientation:
  can feed packet <= theta

archimedean local orientation:
  reverse orientation, cannot feed the current route

missing real alignment:
  blocks construction of Ind3SourceTargetAlignment
```

This gives us a concrete starting dashboard for the disputed 3.12 passage.

## 211. Dedicated Experiment Module

### Lean Move

We added:

```text
Iut/Stage1/IUTStage1Experiments.lean
```

and imported it from:

```text
Iut/Basic.lean
```

The module exposes the first repeatable diagnostic passes:

```text
Experiments.ind3MissingRealAlignmentReport
Experiments.ind3MissingRealAlignment_blocks
Experiments.ind3MissingRealAlignment_packetSourceGap
Experiments.ind3MissingRealAlignment_thetaTargetGap
Experiments.nonarchimedeanInd3LocalReport
Experiments.nonarchimedeanInd3Local_canFeed
Experiments.archimedeanInd3LocalReport
Experiments.archimedeanInd3Local_cannotFeed
Experiments.ind3LocalOrientations_differ
```

### Mathematical Reason

The experiment module is intentionally proof-theoretic rather than numerical.
The disputed 3.12 passage turns on whether certain real/log-volume
identifications can be supplied coherently.  A useful first experiment is
therefore to ask Lean which proof corridor can be assembled from a given set of
formal data.

The first reports say:

```text
missing real alignment:
  cannot build the final Ind3 source/target alignment

nonarchimedean local entry:
  has the packet <= theta orientation needed by the current route

archimedean local entry:
  has theta <= packet orientation and cannot feed the current route directly
```

### Source Check

This experiment layer is based on the same IUT III passage around Remark
3.12.3 and Step (x): `(Ind3)` supplies the inequality, but the local mechanisms
and real-valued identifications must remain explicit.  It also directly mirrors
the Scholze-Stix diagnostic strategy of spelling out the real-line
identifications before concluding a numerical inequality.

### Relevance to the 3.12 Dispute

We now have the first runnable Lean experiment surface for Corollary 3.12.  It
does not settle the dispute, but it gives us a concrete way to run variants:

```text
provide nonarchimedean local alignment -> route can proceed
provide only archimedean local alignment -> orientation blocks this route
remove real alignment -> missing source/target fields are reported
```

The next experiment should connect these reports to the final q/Theta route
summary, so a single Lean object records both the proof result and the exact
remaining missing data.

## 212. First-Pass Ind3 Dashboard

### Lean Move

In

```text
Iut/Stage1/IUTStage1Experiments.lean
```

we added:

```text
Ind3FirstPassDashboard
ind3FirstPassDashboard
```

with checked fields:

```text
missingRealAlignmentBlocks = true
nonarchimedeanEntryCanFeed = true
archimedeanEntryCanFeed = false
localOrientationsSeparated = true
```

### Mathematical Reason

This is a compact Lean object summarizing the current experimental state of the
Corollary 3.12 `(Ind3)` corridor.  It is intentionally modest: it does not
claim that Corollary 3.12 is proved or refuted.  It records the first structural
facts that our formalization can already distinguish.

### Relevance to the 3.12 Dispute

The dashboard makes the first insight explicit:

```text
The nonarchimedean local upper-semi route is compatible with the current
packet-to-theta comparison.

The archimedean local upper-semi route, as currently modeled, has the opposite
orientation and cannot be substituted silently.

The real-line/log-volume source-target alignment remains a separate proof
obligation.
```

This is the first actual experiment output from the Lean model of the disputed
passage.

## 213. Final-Route Ind3 Experiment Reports

### Lean Move

In

```text
Iut/Stage1/IUTStage1Experiments.lean
```

we added:

```text
Ind3FinalRouteExperimentReport
missingAlignmentFinalRouteReport
nonarchimedeanFinalRouteReport
archimedeanFinalRouteReport
nonarchimedeanEntry_finalQTheta
```

The report records three pieces of data:

```text
whether the final q/Theta route is available
which local Ind3 orientation is present, if any
which real-line alignment datum is still missing
```

The nonarchimedean theorem `nonarchimedeanEntry_finalQTheta` is the first
experiment-level theorem that actually reaches the final inequality

```text
package.preLedger.qSigned <= package.preLedger.thetaSigned
```

from a local nonarchimedean `(Ind3)` entry plus the already audited Hodge
descent and theta/cusp-class transport data.

### Mathematical Reason

This separates three situations that must not be conflated in the disputed
3.11-to-3.12 passage:

```text
missing alignment:
  no source/target real-line identifications have been supplied, so the final
  route is unavailable

nonarchimedean entry:
  packet <= theta orientation is present, and the current audited corridor can
  reach q <= theta

archimedean entry:
  theta <= packet orientation is present, so this local datum cannot feed the
  current packet-to-theta route without an additional argument
```

This is deliberately a small experiment, not a global proof of Corollary 3.12.
Its value is that Lean now checks the final route only in the case where the
required orientation and alignment fields are actually present.

### Source Check

IUT III treats `(Ind3)` as the upper-semicompatibility input used in the
Corollary 3.12 inequality corridor.  The Scholze-Stix objection focuses on
whether the relevant ordered one-dimensional real vector spaces have been
identified in a way that preserves the numerical comparison.  The new report is
designed around exactly those two checks: local orientation and real-line
alignment.

### Experiment Result

The first final-route pass currently says:

```text
missing real alignment -> route unavailable
nonarchimedean aligned entry -> route available and proves q <= theta
archimedean aligned entry -> reverse orientation, route unavailable
```

The next mathematical task is to replace the simplified local entry structures
with definitions closer to Mochizuki's actual theta-link/Hodge theater objects,
while preserving this explicit route accounting.

## 214. Transport-Explicit Real-Line Alignment for Ind3

### Lean Move

In

```text
Iut/Stage1/IUTStage1Source.lean
Iut/Stage1/IUTStage1Experiments.lean
```

we added:

```text
Ind3OrderedRealLineAlignment
Ind3OrderedRealLineAlignment.toInd3SourceTargetAlignment
orderedRealLineAlignment_finalQTheta
scaleMismatch_transported_coords_equal
scaleMismatch_transport_scales_differ
scaleMismatch_raw_coords_differ
```

The new alignment object replaces two raw real equalities by explicit
real-line-copy data:

```text
packet line -> common line
Ind3 source line -> common line
theta line -> common line
Ind3 target line -> common line
```

It permits cancellation back to the raw equalities only when the corresponding
transport scales match.

### Mathematical Reason

This is the first formal pass aimed directly at the Scholze-Stix style concern:
an equality after transporting into a common real line does not by itself
justify an equality of the original coordinates unless the transports have
compatible normalization.

Lean now proves the good case:

```text
matched transport scales
+ transported packet/source equality
+ transported theta/target equality
-> raw source/target alignment
-> final q <= theta route
```

and also proves a concrete warning example:

```text
1 * 2 = 2 * 1
but
2 != 1
```

In our formal language, this is a pair of positive real-line transports whose
transported coordinates agree while the raw coordinates differ.  Thus a
transported equality cannot be collapsed into a raw equality when the scales are
not matched.

### Source Check

This matches the role of real-line identifications in the 3.12 dispute.  The
IUT route needs common-container comparisons after Hodge-theater operations,
but the Scholze-Stix criticism warns that scalar changes in the ordered
one-dimensional real vector spaces cannot be ignored.  The new Lean object does
not decide which mathematical identifications Mochizuki's text ultimately
supplies; it states the exact transport-scale datum that our formal route
requires before the final cancellation.

### Experiment Result

The current experiment surface now has two first-pass insights:

```text
Nonarchimedean aligned Ind3 entry:
  can feed the final q/Theta route.

Transported real-line equality with mismatched scales:
  cannot be treated as raw source/target equality.
```

This is a useful diagnostic for the next stage: when we formalize the actual
theta-link and Hodge-theater constructions, we must identify where the paper
supplies the scale-matching datum, or else record that the route is blocked at
exactly this point.

## 215. Label-Dependent j^2 Scales Cannot Be Absorbed By One Transport

### Lean Move

In

```text
Iut/Stage1/IUTStage1Source.lean
Iut/Stage1/IUTStage1Experiments.lean
```

we added:

```text
representativeSquareScale
representativeSquareScale_one
representativeSquareScale_two
representativeSquareScale_one_ne_two
no_single_scale_matches_one_two
no_label_independent_scale_matches_all_representative_squares
Ind3J2ScaleExperimentReport
no_labelIndependent_transport_scale_absorbs_j2
```

The proof uses only the `l >= 5` hypothesis.  In `ZMod l`, the representatives
`1` and `2` are both available, and their representative real square scales are:

```text
1^2 = 1
2^2 = 4
```

Lean therefore proves that no single real transport scale can match the
representative `j^2` scale for every label `j`.

### Mathematical Reason

This is the labelwise version of the transport-scale warning from the previous
milestone.  The previous experiment showed that transported equality with
mismatched positive scales does not imply raw equality.  This experiment shows
that the representative `j^2` scales used in the current square-weight profile
are genuinely label-dependent.  Thus a label-independent real-line
identification cannot simply absorb all `j^2` factors.

The key checked statement is:

```text
for any scale : Real,
  not (for every j : ZMod l, scale = j.val^2)
```

and the contradiction is already visible at `j = 1` and `j = 2`.

### Source Check

Mochizuki's discussion around Corollary 3.12 distinguishes the 0-column and
1-column roles: the 0-column side uses mono-analytic containers and upper
bounds, while the 1-column side has fixed arithmetic holomorphic structure and
precise log-volume equalities.  Remark 3.12.3 identifies `(Ind3)` as the
upper-semicompatibility source of the inequality.

Scholze-Stix's Section 2.2 isolates the same pressure point in different
language: after spelling out the ordered one-dimensional real vector spaces,
introducing `j^2` scalars into the left side of the diagram risks monodromy or
inconsistent identifications.  The Lean result does not decide Mochizuki's
intended Hodge-theater resolution, but it formally confirms the local algebraic
obstruction: `j^2` cannot be hidden inside one label-independent transport
scale.

### Experiment Result

The current diagnostic picture is now sharper:

```text
matched transport scales:
  cancellation to raw real-line alignment is allowed

mismatched transport scales:
  transported equality does not imply raw equality

representative j^2 scales:
  label-dependent; no single scale matches all labels
```

The next step should connect this labelwise obstruction to the existing
square-weight transport audits, so that any proposed 3.12 route must specify
whether it is using representative `j.val^2` weights, balanced sign-compatible
weights, or a genuinely averaged/hull-level object.

## 216. Square-Weight Transport Levels Are Now Separated

### Lean Move

In

```text
Iut/Stage1/IUTStage1Source.lean
Iut/Stage1/IUTStage1Experiments.lean
```

we added audit-level consequences:

```text
IUTStage1ZModSquareWeightedFullLabelTransportAudit.coordinateSquarePreserving
IUTStage1ZModSquareWeightedFullLabelTransportAudit.coordinateEquiv_apply_eq
IUTStage1ZModSquareWeightedFullLabelTransportAudit.coordinateEquiv_eq_refl
IUTStage1ZModSquareWeightedFullLabelTransportAudit.coordinateEquiv_ne_neg
Ind3SquareWeightLevelExperimentReport
representativeSquareWeightAudit_forcesIdentity
representativeSquareWeightAudit_rejectsNegation
balancedNeg_preservesBalancedWeights
balancedNeg_failsRepresentativeSummands
balancedNeg_levelIsNotPointwise
aggregateLevelIsNotPointwise
```

### Mathematical Reason

The previous milestone proved that the representative `j^2` scale is
label-dependent.  This milestone connects that fact to the existing square-weight
transport audits:

```text
representative pointwise square-weight audit
  -> coordinate-square preservation
  -> coordinate equivalence is identity
  -> negation is rejected

balanced sign-compatible audit
  -> negation can preserve balanced weights
  -> representative j.val^2 summands still fail
  -> comparison level is not pointwiseRepresentative

aggregate/hull level
  -> explicitly not the pointwiseRepresentative level
```

This matters because the final 3.12 route must not silently move between these
levels.  A proof that works for balanced sign-compatible weights is not, by
itself, a proof at the representative `j.val^2` pointwise level.

### Source Check

Mochizuki's formalization note separates the final `3.11.5 => 3.12`
comparison from the earlier APT/hull+det work, and says the final stage is the
simultaneous comparison of q- and Theta-pilot data.  IUT III distinguishes the
0-column upper-bound/container behavior from the 1-column fixed-ring/equality
behavior, while `(Ind3)` supplies the upper-semicompatibility inequality.

Scholze-Stix argue that once the ordered real-line copies are spelled out, the
`j^2` scalars cannot be inserted inconsistently without monodromy.  The Lean
separation here formalizes one precise version of that warning: the
representative `j.val^2` audit is rigid enough to force identity, whereas the
balanced sign-compatible negation branch is a different comparison level.

### Experiment Result

The current diagnostic surface now says:

```text
representative pointwise branch:
  rigid; coordinate transport must be identity

balanced sign-compatible branch:
  supports negation, but does not preserve representative j.val^2 summands

aggregate/hull branch:
  distinct from pointwiseRepresentative
```

This gives us a sharper next target: any proposed formal route through
Mochizuki's Hodge-theater/SHE machinery must say exactly which comparison level
is being used when it reaches the final q/Theta inequality.

## 217. Final Weighted-Theta Route Rejects Balanced-Level Drift

### Lean Move

In

```text
Iut/Stage1/IUTStage1Source.lean
Iut/Stage1/IUTStage1Experiments.lean
```

we added:

```text
IUTStage1WeightedThetaComparisonMissingDatum.comparisonLevel_ne_balancedSignCompatible
IUTStage1WeightedThetaComparisonSource.comparisonLevel_ne_balancedSignCompatible
weightedThetaComparisonRouteLevel_ne_balancedSignCompatible
Ind3FinalRouteLevelExperimentReport
finalWeightedThetaRoute_levelIsHull
finalWeightedThetaRoute_rejectsBalanced
finalWeightedThetaRoute_rejectsPointwise
finalWeightedThetaRoute_rejectsAggregate
missingWeightedThetaComparisonDatum_rejectsBalanced
```

This extends the previous pointwise/aggregate separation by making the balanced
sign-compatible level explicitly unavailable as the final weighted-theta route
level.

### Mathematical Reason

The final q/Theta comparison is recorded as a hull/log-volume comparison:

```text
weighted theta route level = hullLogVolume
```

Lean now checks that this level is not:

```text
pointwiseRepresentative
aggregateRepresentative
balancedSignCompatible
```

This is a small but important guardrail.  The balanced sign-compatible branch
can preserve sign-symmetric data, but the previous milestone showed that it does
not preserve representative `j.val^2` summands.  The final route should
therefore not accept balanced-level evidence as if it were the hull/log-volume
comparison needed for Corollary 3.12.

### Source Check

Mochizuki's formalization note describes the final `3.11.5 => 3.12` portion as
the simultaneous q/Theta pilot comparison after earlier APT and hull+det work.
The Lean route now reflects this: it consumes a hull/log-volume comparison
source, not a pointwise representative square transport or a balanced
sign-compatible transport.

Scholze-Stix's critique presses exactly on this kind of level change: if a
scalar or sign-compatible identification is used in one part of the diagram, it
cannot be silently read as a consistent final real-number comparison.  The new
guard forces any future formal route to state the promotion from balanced or
representative data to hull/log-volume data explicitly.

### Experiment Result

The active 3.12 experiment dashboard now separates four levels:

```text
representative pointwise:
  rigid; coordinate equivalence is identity

balanced sign-compatible:
  allows negation but is not representative pointwise

aggregate average:
  not pointwise and not the final hull comparison

final weighted-theta route:
  hull/log-volume level only
```

The next mathematical step should inspect the existing Hodge/SHE endpoint audit
and make the promotion into this hull/log-volume level more source-specific.

## 218. First Corollary 3.12 Dispute Experiment

### Lean Move

In:

```text
Iut/Stage1/IUTStage1Experiments.lean
```

we added:

```text
Corollary312DisputeFirstPassReport
corollary312DisputeFirstPassReport
corollary312_firstPass_finalQTheta_from_orderedRealLineAlignment
corollary312_firstPass_rejects_labelIndependentJ2Collapse
corollary312_firstPass_rejects_balancedAsFinalRouteLevel
```

and evaluated the report with Lean:

```text
orderedRealLineRouteTheoremAvailable := true
mismatchCounterexampleBlocksRawCancellation := true
labelIndependentJ2CollapseRejectedInZModModel := true
balancedLevelRejectedAtFinalRouteTheoremAvailable := true
disputeSettledByCurrentStage := false
```

### Mathematical Reason

This is the first explicit experiment pass aimed at the disputed 3.11 to 3.12
transition.

The positive route theorem says that, once the ordered real-line alignment
required by the `(Ind3)` corridor is supplied, the current formalization reaches
the final q/Theta inequality:

```text
qSigned <= thetaSigned
```

The obstruction theorems say that two simplifications are not accepted by the
formal model:

```text
no label-independent scale absorbs all representative j^2 factors
balanced sign-compatible evidence is not the final hull/log-volume route level
```

Thus the current Lean code does not collapse the passage to a single global
real-line scaling.  It also does not declare the dispute solved: the successful
route is still conditional on the explicit ordered real-line alignment and on
the Hodge/SHE transport audit data.

### Source Check

Mochizuki's reported formalization program isolates the `3.11.5 => 3.12`
transition as the simultaneous q-/Theta-pilot comparison after the preceding
APT and hull+det work.  The new experiment reflects exactly this by making the
final route a hull/log-volume comparison after ordered alignment, not a raw
pointwise identification.

Scholze-Stix's criticism tests whether the relevant one-dimensional real-line
identifications force a collapse once the scalar factors are made consistent.
Our first-pass Lean experiment agrees that consistency matters: a mismatched
transport cannot be cancelled to raw equality, and a single label-independent
scale cannot absorb the representative `j^2` profile.

### Current Reading

The formalization currently supports this narrow conclusion:

```text
Mochizuki-style direction:
  a conditional 3.12 q/Theta route exists when the ordered alignment and
  Hodge/SHE transport audit are explicitly present.

Scholze-Stix-style collapse pressure:
  the naive single-scale collapse is rejected for the representative j^2
  branch, and balanced sign compatibility cannot be reused as the final
  hull/log-volume comparison.

Unresolved:
  we have not yet formalized enough of the genuine IUT Hodge-theater machinery
  to prove that the needed ordered alignment and transport audit are forced by
  Mochizuki's full hypotheses rather than supplied as explicit assumptions.
```

## 219. Nonarchimedean Ind3 Entry Gives Canonical Ordered Alignment

### Lean Move

In:

```text
Iut/Stage1/IUTStage1Source.lean
Iut/Stage1/IUTStage1Experiments.lean
```

we added:

```text
NonarchimedeanInd3EntryAlignment.toCanonicalOrderedRealLineAlignment
NonarchimedeanInd3EntryAlignment.canonicalOrderedRealLineAlignment_toRaw
corollary312_firstPass_finalQTheta_from_nonarchimedeanEntryCanonicalAlignment
```

and extended the first-pass report with:

```text
nonarchimedeanEntryCanonicalAlignmentTheoremAvailable := true
factoredSHEBridgeTheoremAvailable := true
```

### Mathematical Reason

The previous experiment separated two facts:

```text
nonarchimedean Ind3 entry -> raw source/target equality
ordered real-line alignment -> final q/Theta route
```

This left the ordered real-line alignment as an independent assumption in the
positive 3.12 route theorem.  The new Lean construction closes that gap for the
canonical nonarchimedean case.  It places the packet local object, the Ind3
source value, the theta average, and the Ind3 target value in one real-line copy
and uses unit transports on all four sides.

Lean then checks:

```text
nonarchimedean entry alignment
-> canonical ordered-real-line alignment with matched unit scales
-> raw Ind3 source/target alignment
-> final qSigned <= thetaSigned route
```

This is not a proof that arbitrary ordered identifications are harmless.  It is
the controlled case: no hidden scalar is introduced, so the ordered-line
presentation is exactly the same information as the nonarchimedean source/target
equalities.

### Source Check

Scholze-Stix emphasize that ordered one-dimensional real-vector-space
identifications must be made explicit.  This milestone follows that demand in
the nonarchimedean entry case: the real-line copies and positive scales are
part of the formal object, and cancellation is permitted only because the
scales are definitionally equal to `1`.

Mochizuki's 3.11 to 3.12 route needs the nonarchimedean `(Ind3)` upper-semi
input to feed the simultaneous q/Theta comparison.  The new theorem verifies
that this feed can pass through the explicit ordered-real-line bookkeeping in
the canonical unit-scale case.

### Current Reading

The first-pass 3.12 experiment is now slightly stronger:

```text
positive:
  nonarchimedean Ind3 entry data supplies the canonical ordered real-line
  alignment needed by the final route.

negative:
  mismatched scales still cannot be cancelled, and a single global scalar still
  cannot absorb the representative j^2 profile.

still open:
  the general Hodge/SHE transport audit and full Mochizuki theater machinery
  remain assumptions of the current positive route.
```

## 220. Factored SHE Obligations Feed The Hodge-Descent Ind3 Route

### Lean Move

In:

```text
Iut/Stage1/IUTStage1Source.lean
```

we added:

```text
FLZModCuspLabelThetaHodgeDescentPacketTransportAudit.toInd3SourceZeroCuspTargetThetaAuditOfFactoredObligations
FLZModCuspLabelThetaHodgeDescentPacketTransportAudit.toInd3SourceZeroCuspTargetThetaAuditOfFactoredNonarchimedeanEntry
```

### Mathematical Reason

The previous positive route still accepted a completed
`IUTStage1StructuredSHESquareWeightTransportAudit` as a direct input.  That is
too opaque for the Corollary 3.12 dispute, because the papers separate the
square/Gaussian-monoid branch from the log-volume/full-label branch before the
final hull/log-volume comparison.

The new bridge lets the Hodge-descent `(Ind3)` route consume the already
factored preservation object:

```text
coordinate-square preservation
+ full-label map preservation
+ full-label value preservation
-> structured-SHE square-weight transport audit
-> Ind3 source-zero/cusp-target audit
```

For the nonarchimedean case, it combines this factored transport with the
canonical ordered-real-line alignment from the previous milestone.

### Source Check

IUT II identifies the Hodge-Arakelov theta-value input as carrying `j^2`-type
weights.  IUT III Step `(xi)` then requires these transported objects to be
placed into the hull/log-volume comparison after SHE/IPL.  The new Lean move
does not construct the genuine Gaussian monoids or hulls, but it moves the
interface one step closer to the paper: the transport audit is no longer a single
black box at this point; it is obtained from separate square and full-label
preservation branches.

### Current Reading

The open hypothesis has been narrowed:

```text
old:
  assume a completed structured-SHE square-weight transport audit

new:
  assume factored square/full-label preservation data, then derive the completed
  structured-SHE square-weight transport audit
```

The remaining mathematical gap is to construct those factored preservation data
from actual Hodge-theater, theta-value, Gaussian-monoid, and log-shell objects.

## 221. Review Pass And Paper Draft

### Review Scope

We reviewed the local Markdown conversions of:

```text
IUT I
IUT II
IUT III
IUT IV
Mochizuki's 2026 formalization note
Scholze-Stix, Why abc is still a conjecture
```

The audit focused on IUT III, Corollary 3.12, Steps `(x)` and `(xi)`,
Remarks 3.12.2 and 3.12.3, Mochizuki's `3.11.5 => 3.12` fourth-triangle
decomposition, and Scholze-Stix's ordered-real-line objection in Section 2.2.

### Correction Made

The first-pass experiment report originally used field names that could be read
as unconditional mathematical facts.  We renamed them so that they record
theorem availability under explicit hypotheses:

```text
orderedRealLineRouteTheoremAvailable
nonarchimedeanEntryCanonicalAlignmentTheoremAvailable
factoredSHEBridgeTheoremAvailable
mismatchCounterexampleBlocksRawCancellation
labelIndependentJ2CollapseRejectedInZModModel
balancedLevelRejectedAtFinalRouteTheoremAvailable
```

This is a correctness improvement in presentation: the Lean code still records
that the dispute is not settled by the present stage.

### Paper Draft

We added and compiled:

```text
IUT_FORMALIZATION_3_12_DRAFT.tex
IUT_FORMALIZATION_3_12_DRAFT.pdf
```

The draft states the current result as conditional, records the exact missing
mathematics, and includes simple diagrams for the `3.11 -> 3.11.5 -> 3.12`
decomposition and the current Lean route.

## 222. Representative q-to-Theta Pilot Degree Scaling

### Lean Move

In:

```text
Iut/Stage1/IUTStage1Source.lean
Iut/Stage1/IUTStage1Experiments.lean
```

we added:

```text
IUTStage1ZModSquareWeightProfile.RepresentativeThetaPilotDegreeProfile
RepresentativeThetaPilotDegreeProfile.thetaPilotDegree_one
RepresentativeThetaPilotDegreeProfile.thetaPilotDegree_two
RepresentativeThetaPilotDegreeProfile.no_labelIndependent_scale_matches_theta_degrees
no_labelIndependent_thetaPilot_degree_scale
```

and extended:

```text
Ind3J2ScaleExperimentReport.nonzeroQPilotDegreeRejectsLabelIndependentThetaScale
```

### Mathematical Reason

The previous `j^2` obstruction was stated only for a square-scale function:

```text
j |-> j.val^2
```

The new profile attaches this scale to a q-pilot degree:

```text
thetaPilotDegree j = representativeSquareScale j * qPilotDegree
```

Lean proves:

```text
thetaPilotDegree 1 = qPilotDegree
thetaPilotDegree 2 = 4 * qPilotDegree
```

and, if `qPilotDegree != 0`, no single label-independent scale can make all
theta-pilot degrees equal to `scale * qPilotDegree`.

### Source Check

IUT II's Hodge-Arakelov evaluation discussion identifies the concrete theta
values at torsion labels as carrying `q^{j^2}` behavior.  Scholze-Stix isolate
the corresponding `j^2` degree scaling as part of their real-line identification
objection.  This milestone does not yet formalize theta functions or
Hodge-Arakelov evaluation, but it moves the obstruction from an abstract
square-weight profile to an explicit q/theta pilot-degree relation.

### Current Reading

The finite-label model now checks the narrow collapse claim in the form closest
to the critique:

```text
nonzero q-pilot degree
+ theta_j degree = j^2 * q-pilot degree
-> no label-independent scalar accounts for all theta_j degrees
```

This is still representative-label mathematics, not the full `|F_l|` quotient or
the actual IUT theta-value construction.

## 223. Sign-Quotient q-to-Theta Pilot Degree Descent

### Lean Move

In:

```text
Iut/Stage1/IUTStage1Source.lean
Iut/Stage1/IUTStage1Experiments.lean
```

we added:

```text
IUTStage1ZModSquareWeightProfile.BalancedThetaPilotDegreeProfile
BalancedThetaPilotDegreeProfile.thetaPilotDegree_fromCoordinate
BalancedThetaPilotDegreeProfile.thetaPilotDegree_neg_fromCoordinate_eq
not_exists_signQuotient_representativeThetaPilotDegree
no_signQuotient_representativeThetaPilot_degree
balanced_signQuotient_thetaPilot_degree_fromCoordinate
```

and extended the first-pass experiment reports with:

```text
representativeJ2SignQuotientDescentRejected
balancedThetaPilotDegreeDescendsToSignQuotient
representativeJ2SignQuotientDescentRejectedInZModModel
```

### Mathematical Reason

The previous milestone modeled:

```text
thetaPilotDegree j = representativeSquareScale j * qPilotDegree
```

on raw `ZMod l` labels.  The IUT source passages, however, phrase the relevant
theta labels as elements of:

```text
|F_l| = F_l / {±1}.
```

In the current finite model, the raw nonnegative representative square

```text
j |-> j.val^2
```

does not descend to the sign quotient, because `j` and `-j` define the same
sign-quotient label but generally have different nonnegative representatives.
Lean already had the square-weight obstruction:

```text
not_exists_representativeSquareWeightOnSignQuotient
```

The new theorem transfers that obstruction to the q/theta degree relation: if
`qPilotDegree != 0`, then a quotient-level theta-degree function satisfying

```text
theta([j]) = representativeSquareScale j * qPilotDegree
```

would divide by the nonzero q-degree and produce a quotient-level
representative `j.val^2` function, contradicting the existing no-descent
theorem.

### Source Check

IUT II describes the theta-value labels through `|F_l|` and the concrete
`q^{j^2}` behavior.  Scholze-Stix's objection focuses on the resulting `j^2`
degree scalars.  This milestone records a necessary bookkeeping distinction:
raw representative `j.val^2` data is not automatically quotient-level
`|F_l|` data.

The formalization therefore keeps two branches separate:

```text
representative branch:
  j in F_l, theta_j degree = j.val^2 * q-degree
  does not descend to F_l/{±1}

balanced branch:
  [j] in F_l/{±1}, theta_[j] degree = balancedSquareWeight([j]) * q-degree
  descends to the sign quotient
```

### Current Reading

This improves the 3.12 corridor experiment by preventing a silent conflation of
representative labels with sign-quotient labels.  It is not yet Mochizuki's full
theta-value construction: the balanced branch is a sign-compatible control model,
not a proof that the IUT `q^{j^2}` theta values have been reconstructed from
Hodge-Arakelov theory.
