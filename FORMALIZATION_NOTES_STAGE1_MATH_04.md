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
