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
