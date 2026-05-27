# Formalization Notes

These notes are the project diary and the seed of a later paper. Each Lean
milestone should be documented here in ordinary mathematical language: what was
formalized, why the definitions were chosen, what the Lean theorem actually says,
and what trap the design is meant to avoid.

## Method

We are treating Lean as a verification and disambiguation engine. The main rule
is that a Lean theorem should not contain the desired conclusion as a structure
field unless the theorem is explicitly marked as an interface placeholder. When
we introduce a placeholder, the research task is to replace it later by smaller
data and proofs.

This mirrors the "blueprint" style used in large Lean formalization projects:
human-readable mathematical text is kept synchronized with formal declarations.
Examples worth tracking are the Liquid Tensor Experiment blueprint
<https://leanprover-community.github.io/liquid/>, the Fermat's Last Theorem
blueprint <https://imperialcollegelondon.github.io/FLT/blueprint/>, and recent
work on extracting blueprint data from Lean code in LeanArchitect
<https://arxiv.org/abs/2601.22554>.

## Milestone 1: Labeled Real-Line Copies

Lean file: `Iut/Foundations/RealLineCopy.lean`

### Purpose

The Scholze-Stix objection around IUT III, Corollary 3.12 is partly about
identifying several copies of one-dimensional ordered real vector spaces. Their
claim is that consistent identifications leave no room for the required `j^2`
scalings on the Theta side; inserting those scalars produces monodromy. Mochizuki's
position is that the Hodge-theater/log-link/multiradial apparatus makes some
comparisons legitimate precisely because the ring/scheme histories are not
silently identified.

Before formalizing log-volumes or pilot objects, we need a tiny discipline for
copies of the real line:

* a copy has a label;
* a point has a coordinate only relative to its copy;
* a comparison between copies is an explicit transport;
* a transport carries a positive scale, so it preserves the order orientation;
* a loop transport is trivial exactly when its scale is `1`.

This is intentionally much smaller than the IUT situation. Its job is to prevent
the first possible mistake: silently treating all real-number targets as the same
object.

### Lean Declarations

`RealLineCopy.Copy` is a labeled copy of the real line. Its only field is a
string label. This is not mathematically rich, but the label creates an explicit
place where later q-side, Theta-side, abstract-pilot, concrete-pilot, and
holomorphic-hull targets can differ.

`RealLineCopy.Point line` is a coordinate in a specific copy. The coordinate is a
plain real number, but the type records the copy to which the coordinate belongs.
This means a point of the q-copy is not definitionally a point of the Theta-copy.

`RealLineCopy.PositiveScale` is a real scalar with proof that it is positive. We
use positive scalars because the ordered real lines relevant to log-volume
comparisons should not be allowed to reverse order.

`RealLineCopy.Transport source target` is currently just a positive scaling from
one copy to another. Later this may be generalized to affine or abstract ordered
line isomorphisms if the mathematics requires it. For the first milestone,
positive scaling is exactly the structure needed to model identity comparison
versus scalar insertion.

`Transport.PointwiseEqual f g` means two transports induce the same coordinate
map on every point. The theorem
`Transport.pointwiseEqual_iff_scale_eq` proves that, for this model, pointwise
equality is equivalent to equality of scale factors.

`Transport.TrivialMonodromy f` means a loop transport is pointwise equal to the
identity transport. The theorem
`Transport.trivialMonodromy_iff_scale_eq_one` proves the core fact:

```text
a loop has trivial monodromy iff its scale is 1.
```

`Transport.scalarLoop_nontrivial_of_scale_ne_one` is the first formal expression
of the Scholze-Stix-style warning: if a scalar loop has scale not equal to `1`,
then it is not a trivial identification.

### What This Does Not Prove

This milestone does not prove anything about IUT, Corollary 3.12, q-pilots,
Theta-pilots, Frobenioids, Hodge theaters, or log-volumes.

It only proves a small control theorem for a future model: if we later insert a
`j^2` scaling into a closed comparison diagram, then we must either show that the
resulting loop is not meant to be trivial, or prove that the relevant
indeterminacy/hull operation changes the comparison relation. We cannot call it
an ordinary identity unless the scale is `1`.

### Design Trap Avoided

The dangerous shortcut would be to represent every log-volume target simply as
`Real`. That would erase the distinction between q-side and Theta-side real
coordinates before we have proved that such erasure is legitimate. This file does
the opposite: it makes every erasure or comparison pass through an explicit
transport.

## Milestone 2: Coherent Transport Diagrams

Lean file: `Iut/Foundations/TransportDiagram.lean`

### Source Check

Before implementing this milestone, we rechecked the local primary texts.

Scholze-Stix say that, because the argument compares real numbers and several
ordered one-dimensional real vector spaces arise, it is critical to spell out all
identifications of copies of real numbers. In their diagnosis, adding `j^2`
scalars to the left side of the diagram produces monodromy; with consistent
identifications, those scalars must be omitted.

Mochizuki's IUT III, Remark 3.12.2, gives a toy model with two distinct labeled
copies `qR` and `ThetaR` of the real numbers. He emphasizes that forgetting the
distinct labels makes the assignments incompatible, while the labels and the
abstract symbol make simultaneous logical consideration possible. Later, an
assignment with indeterminacies is supposed to be intrinsically associated to the
q-side assignment even after the copies are identified.

Mochizuki's April 2026 progress report says that the Stage 1 Lean target should
focus on the simultaneous comparison of the q-pilot and Theta-pilot, with SHE
and IPL as part of the `3.11.5 => 3.12` package.

The formal move below captures only the elementary "consistent identification"
side of this discussion. It does not model the claimed indeterminacy/hull escape
route yet.

### Purpose

Milestone 1 handled a single loop. Milestone 2 handles two parallel comparison
paths between the same labeled real-line copies. This is closer to the diagrams
in the Scholze-Stix discussion: one path is a baseline comparison, while another
path is the same comparison with an extra scalar inserted.

The intended control theorem is:

```text
if a transport and its scalar-rescaled version form a coherent parallel diagram,
then the inserted scalar is 1.
```

Equivalently:

```text
if the inserted scalar is not 1, the parallel diagram is not coherent.
```

### Lean Declarations

`Transport.rescale s f` takes a transport `f` and multiplies its scale by the
positive scale `s`.

`Transport.ParallelPair source target` is a pair of parallel transports between
the same labeled copies.

`Transport.ParallelPair.Coherent p` means that the two paths are pointwise equal
as maps on coordinates.

`Transport.ParallelPair.coherent_iff_scale_eq` proves that, in this model,
coherence of parallel paths is equivalent to equality of their scale factors.

`Transport.coherent_rescale_iff_scale_eq_one` proves the central theorem of this
milestone:

```text
Coherent(f, rescale s f) iff s = 1.
```

`Transport.incoherent_rescale_of_scale_ne_one` packages the contrapositive:
nontrivial scalar insertion prevents coherence.

### Design Trap Avoided

The trap would be to define a "commutative diagram" as a proposition field and
then freely use it without understanding what it forces. Here we define
coherence as pointwise equality of transports, then prove Lean's reduction of
that condition to equality of scales. This keeps the mathematical content small
and inspectable.

### Next Step

The next milestone should introduce q-side and Theta-side log-volume assignments
as points in labeled real-line copies. Then we can express Mochizuki's toy model
directly:

```text
star |-> q(-h) in qR
star |-> Theta(-2h) in ThetaR
```

and separately express the indeterminacy version:

```text
star |-> Theta(R_{<= -2h + epsilon}) in ThetaR.
```

That will let us distinguish three things in Lean: labeled simultaneous
assignments, forced unlabeled identification, and comparison through an explicit
transport or indeterminacy relation.

## Milestone 3: The IUT III Toy Model

Lean file: `Iut/Stage1/ToyModel.lean`

### Source Check

This milestone is tied directly to IUT III, Remark 3.12.2, especially the
subparagraphs `(atoy)` through `(ftoy)`. Mochizuki describes two distinct labeled
copies `qR` and `ThetaR`, an abstract symbol `*`, and assignments

```text
lambda_q     : * |-> q(-h)        in qR
lambda_Theta : * |-> Theta(-2h)   in ThetaR.
```

He then says that if the labels `q` and `Theta` are forgotten, the assignments
become incompatible because `-h != -2h` for `h > 0`. He replaces the second
assignment by an indeterminacy version

```text
lambda_Theta^Ind : * |-> Theta(R_{<= -2h + epsilon})
```

and concludes formally that membership of `-h` in this region gives
`-h <= -2h + epsilon`, hence `h <= epsilon`.

This is also responsive to Scholze-Stix, who emphasize that all identifications
between the ordered one-dimensional real vector spaces must be spelled out. The
toy model is where we can spell out the smallest possible version of that issue.

### Lean Declarations

`ToyModel.qLine` and `ToyModel.thetaLine` are the two labeled copies.

`ToyModel.qAssignment h` is the point with coordinate `-h` in `qLine`.

`ToyModel.thetaAssignment h` is the point with coordinate `-2h` in `thetaLine`.

`ToyModel.ForcedUnlabeledEquality h` is the proposition obtained by forgetting
the two labels and asserting equality of the resulting coordinates in one
ambient copy of `Real`.

The theorem

```text
forcedUnlabeledEquality_iff_eq_zero
```

proves that this forced equality is equivalent to `h = 0`. The theorem

```text
forcedUnlabeledEquality_contradicts_positive
```

packages the expected contradiction for `h > 0`.

`ToyModel.thetaIndeterminacyRegion h epsilon x` is the coordinate predicate
`x <= -2h + epsilon`.

`ToyModel.QInThetaIndeterminacyAfterForgetting h epsilon` says that the
q-coordinate `-h` lies in this region after labels are forgotten.

The theorem

```text
qInThetaIndeterminacy_iff_bound
```

proves the exact arithmetic equivalence:

```text
-h in R_{<= -2h + epsilon}  iff  h <= epsilon.
```

### What This Tests

This milestone tests both sides of the toy-model passage.

First, the naive forced identification of the exact assignments is impossible
for positive `h`. This matches Mochizuki's own warning in `(atoy)` and the
Scholze-Stix insistence that identifications of real-line copies must be
tracked.

Second, the indeterminacy-region replacement has the advertised arithmetic
effect: once one has justified membership of `-h` in `R_{<= -2h + epsilon}`,
Lean confirms that the formal bound `h <= epsilon` follows.

### Design Trap Avoided

The trap would be to make the indeterminacy step a field such as
`bound : h <= epsilon`. We do not do that. We define the region membership
predicate and prove that the bound is equivalent to membership. The hard future
mathematics is therefore isolated: one must justify the membership, not the
bound directly.

### Next Step

The next milestone should connect this toy model back to explicit transports:
instead of "forgetting labels" by immediately reading both coordinates in `Real`,
we should express comparison through a named transport from `qLine` to
`thetaLine`. This will let us ask whether a proposed comparison path is exact,
scalar-rescaled, or indeterminacy-valued.

## Milestone 4: Toy Model Through Named Transports

Lean file: `Iut/Stage1/ToyModel.lean`

### Source Check

This milestone continues the same source check as Milestone 3. The relevant
mathematical tension is:

* Mochizuki's toy model begins with distinct labeled copies `qR` and `ThetaR`.
* Forgetting the labels directly makes the exact assignments `-h` and `-2h`
  incompatible when `h > 0`.
* Scholze-Stix stress that every identification between ordered one-dimensional
  real vector spaces must be made explicit.

Milestone 4 implements the explicit-identification version: instead of simply
forgetting labels, we compare the q-assignment to the Theta-assignment through a
named positive-scale transport from `qLine` to `thetaLine`.

### Lean Declarations

`ToyModel.TransportedExactEquality f h` says that applying the named transport
`f : Transport qLine thetaLine` to the q-point `q(-h)` gives the exact Theta
point `Theta(-2h)`.

The theorem

```text
transportedExactEquality_iff_scale_eq_two
```

proves that, for `h != 0`, exact transported equality is equivalent to the
transport scale being `2`.

This is a useful normalization check. In the raw coordinate-forgetting model,
equality of `-h` and `-2h` forced `h = 0`. Once a named transport is allowed,
exact equality can be recovered, but only by making the transport carry the
nontrivial scale `2`.

`ToyModel.unitQToTheta` is the unit-scale transport from the q-line to the
Theta-line. The theorem

```text
unitQToTheta_not_transportedExactEquality
```

shows that this unit comparison cannot send `q(-h)` to `Theta(-2h)` when
`h > 0`.

The more general theorem

```text
transportedUnitEquality_contradicts_positive
```

says the same thing for any transport whose scale is `1`.

`ToyModel.TransportedQInThetaIndeterminacy f h epsilon` is the
transport-sensitive version of the indeterminacy-region membership. It says that
the transported q-coordinate lies in the Theta-side region
`R_{<= -2h + epsilon}`.

The theorem

```text
unitTransportedQInThetaIndeterminacy_iff_bound
```

checks that the unit-transport version recovers the arithmetic equivalence from
Milestone 3: membership is equivalent to `h <= epsilon`.

### What This Tests

The milestone separates three notions that must remain distinct in later work:

1. Raw label-forgetting.
2. Exact comparison through a named transport.
3. Indeterminacy-region comparison through a named transport.

This matters because a proof may legitimately compare two labeled copies only
after specifying the comparison map. The formal result here says that the
comparison map itself carries mathematical content: exact comparison of the toy
assignments forces a nontrivial scale.

### Design Trap Avoided

The trap would be to say "identify qR and ThetaR" without recording whether the
identification has scale `1`, scale `2`, scale `j^2`, or is not an exact
identification at all but an indeterminacy-valued relation. This milestone
forces that choice into Lean data.

### Next Step

The next milestone should stop treating indeterminacy as just a predicate on
coordinates and introduce a small abstract interface for indeterminacy-valued
relations between labeled real-line copies. The immediate goal is to distinguish
"pointwise equality" from "membership in a hull/region after transport" at the
type level.

## Milestone 5: Region-Valued Comparison Interface

Lean files:

* `Iut/Foundations/IndeterminacyRelation.lean`
* `Iut/Stage1/ToyModel.lean`

### Source Check

The source texts repeatedly distinguish exact comparison from comparison up to
regions, hulls, and indeterminacies.

In IUT III, Remark 3.9.5, Mochizuki introduces holomorphic hulls of regions and
explains that passing to hulls is used to handle indeterminacies of possible
regions. In the proof of Corollary 3.12 and Remark 3.12.2, he describes the
Theta-pilot side as being represented only up to suitable indeterminacies. In
the toy model, this appears as replacing the exact assignment
`Theta(-2h)` by the region-valued assignment `Theta(R_{<= -2h + epsilon})`.

Scholze-Stix likewise focus on whether the claimed "blurring" by
indeterminacies is large enough to make the relevant diagrams commute. That
critique only makes sense if exact equality and indeterminacy-valued comparison
are kept separate.

### Purpose

The purpose of this milestone is to move the word "indeterminacy" out of
informal comments and into a small Lean interface. We still do not define IUT
hulls, Frobenioid objects, or log-volume hull-approximants. Instead, we define
the weakest useful target:

```text
a comparison sends a source point, through a named transport,
into a target-side region.
```

Exact equality is represented as the special case where the target region is a
singleton.

### Lean Declarations

`RealLineCopy.Region line` is a predicate on points of a labeled real-line copy.

`Region.singleton x` is the exact one-point region.

`Region.upperRay line bound` is the region of points whose coordinate is at most
`bound`. This is the concrete shape used by the toy model
`R_{<= -2h + epsilon}`.

`RegionComparison source target` packages a named transport from `source` to
`target` and a target-side region.

`RegionComparison.Holds comparison x` says that the transported image of `x`
lies in the target region.

`RegionComparison.exact transport targetPoint` is exact comparison as a
singleton-region comparison.

`RegionComparison.upperRay transport bound` is upper-ray comparison after a
named transport.

The foundational lemmas

```text
RegionComparison.exact_holds_iff
RegionComparison.upperRay_holds_iff
```

unfold the two cases to ordinary coordinate statements. These are intentionally
simple lemmas: they make it clear that the interface is not hiding extra
mathematics.

In the toy model, we added:

```text
exactThetaComparison
thetaIndeterminacyComparison
```

and checked that the new interface recovers the previous toy-model statements.
In particular:

```text
unitThetaIndeterminacyComparison_holds_iff_bound
```

still proves that the unit-transported q-point belongs to the Theta upper-ray
region if and only if `h <= epsilon`.

### What This Tests

This milestone tests that "exact equality" and "membership in a target region"
are different Lean objects. This matters for the central dispute: a future proof
cannot silently replace exact equality by a hull/indeterminacy comparison unless
it explicitly changes the target from a singleton region to a larger region and
then proves membership in that larger region.

### Design Trap Avoided

The trap would be to encode indeterminacy as an unstructured proposition such as
`blurred_commutes : Prop`, then use it as if it were equality. Here the target
side is visibly a `Region`, and equality is only the singleton-region special
case. If a later theorem needs a hull, it must say which region/hull is being
used.

### Next Step

The next milestone should introduce a minimal notion of monotonic enlargement
of regions. This is the first abstraction needed for "passing to a hull":
if a point lies in a region and the region is contained in a larger region, then
the point lies in the larger region. This should remain purely order-theoretic
and should not yet attempt to formalize holomorphic hulls.

## Milestone 6: Region Enlargement and Abstract Hulls

Lean file: `Iut/Foundations/IndeterminacyRelation.lean`

### Source Check

This milestone follows IUT III, Remark 3.9.5, especially the formal properties
listed for the hull map `phi : P -> H`:

```text
(P1) phi(H) = H for hulls H,
(P2) P subset phi(P),
(P3) P1 subset P2 implies phi(P1) subset phi(P2).
```

The immediate formal need for our project is only `(P2)` and `(P3)`: hulls
enlarge regions and are monotone with respect to inclusion. The same remark says
that compatibility with the preorder structure given by inclusion plays an
important role in log-volume estimates. Later parts of Remark 3.9.5 explain that
passing to hulls eliminates or absorbs certain indeterminacies of possible
regions.

The April 2026 formalization report also says that Stage 1 moves the
`hull+det` operation into the intermediate `3.11.5` package. That supports
formalizing the hull-facing interface before we attempt any real Frobenioid or
determinant content.

### Purpose

The goal is to capture the order-theoretic core of "passing to a hull" without
pretending to have formalized holomorphic hulls. We only need enough structure
to say:

```text
if a comparison lands in a region, then it also lands in any larger region;
if a hull operation is extensive, then a comparison lands in the hull
whenever it lands in the original region.
```

This is the next safe abstraction after Milestone 5's region-valued comparisons.

### Lean Declarations

`Region.Subset small large` is pointwise containment of regions.

`Region.ExtEq left right` is extensional equality of regions by pointwise
logical equivalence.

The basic lemmas are:

```text
Region.subset_refl
Region.subset_trans
Region.contains_of_subset
Region.extEq_of_subset_of_subset
```

`Region.singleton_subset_iff` says that a singleton region is contained in a
region iff the singleton's point belongs to that region. The proof is a small
sanity check on our representation of points: since regions are predicates on
points, not just on raw coordinates, Lean must reconstruct equality of points
from equality of their only coordinate.

`Region.upperRay_subset_upperRay` proves that upper rays are monotone in their
bound. The iff version,

```text
Region.upperRay_subset_upperRay_iff
```

shows that this condition is exact.

`HullOperator line` is an abstract hull operation with two fields:

```text
extensive : region subset hull(region)
monotone  : small subset large -> hull(small) subset hull(large)
```

This deliberately omits IUT's actual holomorphic definition. It records only the
part of Remark 3.9.5 that we can use without importing analytic or Frobenioid
machinery.

`RegionComparison.enlargeTarget` replaces the target region of a comparison by
a larger one.

`RegionComparison.holds_of_target_subset` proves that region comparison survives
target enlargement.

`RegionComparison.hullTarget` replaces the target region by its abstract hull.

`RegionComparison.holds_hullTarget` proves that a comparison into a region also
holds after replacing that target by its hull.

### What This Tests

This milestone tests the exact proof obligation created by "passing to a hull":
membership must be transported along an explicit inclusion. We now have a Lean
place to put future claims that a holomorphic hull contains the original possible
image region.

### Design Trap Avoided

The trap would be to introduce a function named `hull` and use it as if it
automatically preserved every comparison. Here a hull operation has to provide
the `extensive` field. If an alleged hull construction does not prove that the
original region is contained in the hull, Lean will not let us transfer
membership.

### Next Step

The next milestone should introduce bounded families of possible regions, still
abstractly. Remark 3.9.5 uses a hull associated to a bounded collection of
possible regions to remove dependence on a particular possible output of the
multiradial algorithm. A first Lean model should represent a family
`beta |-> P_beta` and a common target region that contains every `P_beta`.

## Milestone 7: Families of Possible Regions

Lean file: `Iut/Foundations/IndeterminacyRelation.lean`

### Source Check

This milestone follows the final part of IUT III, Remark 3.9.5, (vi), and
Remark 3.9.5, (vii), (Ob5). Mochizuki says that the discussion applies not only
to one region `P`, but also to bounded families

```text
P_B = { P_beta }_{beta in B}
```

and then describes a hull `phi(P_B)` associated to the family. In (Ob5), he
describes the choice of a specific possible region in the output of the
multiradial algorithm as internal to the algorithm; comparison with an external
object such as the q-pilot side should therefore use an object independent of
that specific choice, namely the hull associated to the collection of possible
regions.

This is also the place where the April 2026 progress report's phrase
"gluings up to indeterminacies" becomes relevant. A family of possible target
regions is the minimal formal container for such an indeterminacy of choices.

### Purpose

The goal is to represent the following pattern:

```text
for every choice beta, there is a possible region P_beta;
a common target region C contains every P_beta;
therefore, membership in any chosen P_beta implies membership in C.
```

This is the order-theoretic core of removing dependence on the particular
possible output chosen by an algorithm.

We still do not formalize boundedness, compactness, relative compactness,
log-volume, or the actual analytic construction of `phi(P_B)`. Those are future
milestones. The current milestone only records the containment structure that
later facts must satisfy.

### Lean Declarations

`RegionFamily line index` is a family of regions indexed by a type of choices.

`RegionFamily.ContainedIn family common` says that every region in the family is
contained in a common region.

`RegionFamily.contains_common_of_contains_choice` proves that if a point belongs
to a chosen possible region, and all possible regions are contained in a common
region, then the point belongs to the common region.

`RegionFamily.CommonHull family` packages a common region together with the
proof that it contains every possible region in the family. This is the abstract
shape of `phi(P_B)` for now.

`RegionFamily.CommonHull.enlarge` says that a larger region than a common hull
is again a common hull. This is a basic closure property needed for later
passes through coarser hulls or quotients.

`RegionComparisonFamily source target index` is a family of region comparisons.
This represents possible comparison outputs, all with the same source and target
copies but with possibly different target regions.

`RegionComparisonFamily.targetRegions` extracts the underlying family of target
regions.

`RegionComparisonFamily.CommonTarget family common` says that `common` contains
all target regions of the comparison family.

Theorems:

```text
holds_commonTarget_of_choice
holds_commonTargetHull_of_choice
```

say that if a chosen comparison holds, then it also holds after replacing that
chosen target region by a common target or common target hull.

### What This Tests

This milestone tests the exact logical step from "one of the possible regions
was chosen" to "we may work in a common region independent of the choice." The
proof is deliberately elementary: it is just membership transfer along inclusion.

That is useful because future IUT-specific work must supply the nontrivial
premise: that the proposed hull or common target really contains every possible
region generated by the multiradial algorithm.

### Design Trap Avoided

The trap would be to model an indeterminate algorithmic output as a single
region too early. That would erase the choice-dependence that Remark 3.9.5,
(Ob5), explicitly says must be handled. We now represent the choice-dependence
as an indexed family and require a proof before replacing it by a common target.

### Next Step

The next milestone should introduce a first log-volume abstraction over regions.
It should not try to define the analytic log-volume. It should only express the
monotonicity shape needed for upper-ray toy regions and later hull estimates:
when `small subset large`, the chosen numerical measure is ordered in the
appropriate direction.

## Milestone 8: Abstract Region Measures

Lean file: `Iut/Foundations/RegionMeasure.lean`

### Source Check

This milestone follows IUT III, Remark 3.9.5, where log-volume estimates are
discussed in the presence of hulls and possible regions. The relevant source
pattern is:

```text
mu_log(phi(P)) >= mu_log(H) >= mu_log(P)
```

for hull-approximants `H` associated to a region `P`, together with the
discussion in (Ob6) that one is ultimately interested in estimating log-volumes
but cannot simply replace the region-level construction by log-volumes too
early.

The proof of Corollary 3.12 also says that log-volumes are invariant under some
indeterminacies and convert the upper semi-compatibility indeterminacy `(Ind3)`
into an inequality from above. That is a later target. For this milestone we
only encode the monotonicity shape of region inclusion.

### Purpose

The goal is to introduce a numerical layer without pretending to define IUT
log-volume. We need a controlled interface that can support statements of the
form:

```text
small subset large  ->  volume(small) <= volume(large)
```

and then derive the consequences for hulls and common targets.

This keeps the formalization honest: if later we introduce an actual IUT
log-volume, it will have to instantiate this interface by proving monotonicity.

### Lean Declarations

`RegionMeasure line` is a real-valued function on regions of a labeled real-line
copy, together with a monotonicity proof.

Core lemmas:

```text
RegionMeasure.le_of_subset
RegionMeasure.le_hull
RegionMeasure.le_common_of_choice
RegionMeasure.le_commonHull_of_choice
```

These say that volumes are monotone under ordinary inclusion, passage to an
abstract hull, and passage from any chosen possible region to a common region or
common hull.

`RegionMeasure.HasVolumeAtMost measure region bound` is the proposition
`volume(region) <= bound`.

The theorem

```text
RegionMeasure.atMost_of_subset_of_atMost
```

says that an upper bound on a larger region gives an upper bound on any
contained smaller region. This is the direction needed when an estimate is
proved for a hull/common target and then applied to a specific possible region.

The theorem

```text
RegionMeasure.choice_atMost_of_common_atMost
```

specializes this to a family of possible regions contained in a common target.

For region comparisons, `RegionMeasure.targetVolume` measures the target region
of a comparison. The lemmas

```text
RegionMeasure.targetVolume_le_enlarge
RegionMeasure.targetVolume_le_hullTarget
RegionMeasure.choice_targetVolume_le_common
RegionMeasure.choice_targetVolume_le_commonHull
```

transfer the same monotonicity facts to comparison targets.

### What This Tests

This milestone tests that the numerical estimate layer depends only on explicit
containment hypotheses. No volume inequality is available merely because a
region is called a hull or an indeterminacy region. Lean requires the inclusion
or hull-extensiveness proof.

### Design Trap Avoided

The trap would be to make "log-volume" a magic function with the inequalities
needed for Corollary 3.12 already built into theorem statements. Here the only
built-in property is monotonicity under inclusion. This is intentionally too
weak to prove IUT-level conclusions by itself.

### Next Step

The next milestone should connect the toy model's upper-ray regions to this
measure abstraction by creating a toy measure or bound functional where the
upper-ray bound itself is the measured value. That will provide a small
end-to-end test: upper-ray enlargement corresponds to numerical inequality, and
the `h <= epsilon` bound can be read as a region membership statement rather
than as an assumed conclusion.

## Milestone 9: Measured Toy Upper Rays

Lean files:

* `Iut/Foundations/RegionMeasure.lean`
* `Iut/Stage1/ToyMeasuredComparison.lean`

### Source Check

This milestone follows the end of Step (xi) in the proof of IUT III, Corollary
3.12. In that passage, after applying the multiradial construction and passing
to the holomorphic hull, Mochizuki writes the comparison in terms of a real
upper-ray region of the form

```text
R_{<= -|log(Theta)|}
```

together with the real number `-|log(q)|`. The same passage emphasizes that the
log-volume is applied only after the region/hull and determinant operations have
made the objects comparable.

This is also aligned with the Scholze-Stix criticism: their discussion of
Corollary 3.12 stresses that one must spell out which copies of the real line are
being identified before deriving a real inequality. Our toy module therefore
keeps the labeled transport, target region, target volume, and final real
arithmetic inequality as separate Lean statements.

Mochizuki's recent formalization progress report describes the current RIMS
focus as the "3.11.5 => 3.12" simultaneous comparison relative to a common ring
structure, after moving the "hull+det" operation into the preceding stage. The
present milestone remains below that level: it only verifies the real upper-ray
and volume-calibration shape that such a later stage would have to feed.

### Purpose

The previous milestone introduced an abstract monotone `RegionMeasure`. This
milestone adds an explicit calibration property:

```text
RegionMeasure.NormalizesUpperRays measure
```

meaning that the measure of `Region.upperRay line bound` is exactly `bound`.
This is intentionally not part of the definition of a measure. It is a hypothesis
that must be supplied when a source-specific log-volume construction has been
proved to have this normalization.

### Lean Declarations

In `RegionMeasure.lean`:

```text
RegionMeasure.NormalizesUpperRays
RegionMeasure.upperRay_volume_eq_of_normalized
RegionMeasure.upperRay_volume_le_iff_of_normalized
RegionMeasure.upperRay_atMost_iff_of_normalized
```

These lemmas say that, under explicit upper-ray normalization, volume comparison
of upper rays is exactly comparison of their displayed bounds.

In `ToyMeasuredComparison.lean`:

```text
thetaIndeterminacy_target_subset_iff_epsilon_le
thetaIndeterminacy_targetVolume_eq_bound
thetaIndeterminacy_targetVolume_le_of_epsilon_le
thetaIndeterminacy_targetVolume_le_iff_epsilon_le
thetaIndeterminacy_holds_iff_coord_le_targetVolume
unitThetaIndeterminacy_coord_le_targetVolume_iff_bound
```

The first theorem says that enlarging the toy target region by increasing
`epsilon` is exactly region inclusion. The next two target-volume theorems say
that monotonicity gives one direction for arbitrary measures, and that the
converse is available only under the explicit upper-ray normalization. The final
two theorems connect target-region membership to the measured target bound and,
for the unit transport, recover the arithmetic statement `h <= epsilon`.

### What This Tests

The important test is the dependency structure:

1. Region inclusion follows from upper-ray arithmetic.
2. Volume inequality follows from region inclusion and measure monotonicity.
3. The reverse reading of volume inequality as an upper-ray bound requires the
   extra normalization hypothesis.
4. The toy `h <= epsilon` statement is recovered from target membership, not
   assumed as an input.

This is the kind of bookkeeping that Lean is useful for in the Corollary 3.12
discussion: if a later proof silently forgets a real-line identification,
normalization, or containment hypothesis, the theorem statement should stop
typechecking.

### Design Trap Avoided

The trap would be to define "log-volume of an upper ray" globally as its bound
and then use that as if it were already Mochizuki's analytic log-volume. Instead
we added only a named calibration hypothesis. The formalization now records
where the calibration is used.

### Next Step

The next milestone should introduce a small abstract interface for the
"hull+det" stage mentioned in Mochizuki's formalization report: an input region
family, a chosen common hull/determinant target, and a proof that applying a
normalized measure to that target yields a usable upper bound for every possible
output. This should still be abstract; no IUT-specific determinant construction
should be asserted before its source hypotheses are identified.

## Milestone 10: Measured Common-Target Bounds

Lean file: `Iut/Foundations/CommonTargetBound.lean`

### Source Check

This milestone follows the same Step (xi) portion of IUT III, Corollary 3.12
used in the previous milestone, but now records the family-level shape. The
source passage says that the multiradial construction, followed by formation of
the holomorphic hull, yields a collection of possible output data, and that only
after forming a suitable determinant and applying normalized log-volume do the
Theta-side region and the q-pilot log-volume become comparable real objects.

The introduction to IUT III describes this as the log-volume of the holomorphic
hull of the union of possible images of the Theta-pilot object, computed in
terms of the q-pilot object. Mochizuki's recent formalization progress report
describes a reorganization in which the "hull+det" operation is moved into an
intermediate "3.11.5" stage, leaving the final "3.11.5 => 3.12" step as a
simultaneous comparison in a common container. Scholze-Stix, in their critique,
stress the same danger from the opposite direction: a real inequality is only
meaningful after the relevant copies of real ordered one-dimensional spaces and
their identifications have been made explicit.

### Purpose

The existing `RegionComparisonFamily.CommonTargetHull` says only that every
possible target region is contained in a common hull. The existing
`RegionMeasure` says only that volume is monotone under containment. This
milestone packages the exact additional data needed to pass from those two
facts to a family-wide upper bound:

```text
common target contains every possible target
volume(common target) <= bound
```

No construction of the common target is included. In IUT terms, the future
formalization of APT/IPL/SHE plus hull+det must produce this package.

### Lean Declarations

`RegionComparisonFamily.AllTargetsAtMost measure family bound` is the direct
conclusion:

```text
forall choice, targetVolume(choice) <= bound
```

`RegionComparisonFamily.CommonTargetBound measure family bound` stores:

```text
common        : Region target
contains_each : family.CommonTarget common
volume_bound  : HasVolumeAtMost measure common bound
```

`RegionComparisonFamily.CommonTargetHullBound measure family bound` is the same
package specialized to an existing `family.CommonTargetHull`.

For both packages, Lean proves:

```text
choice_targetVolume_le
allTargetsAtMost
choice_region_atMost
weakenBound
```

The common-target package also proves `holds_common_of_choice`; the hull package
proves `holds_commonHull_of_choice`. These keep membership transport separate
from the numerical estimate.

### What This Tests

This milestone tests the intended proof dependency:

1. A chosen possible output lies in its target region.
2. The common target/hull contains every possible target region.
3. A measure bound is known for the common target/hull.
4. Therefore every chosen target has volume at most the same bound.

Lean enforces that the fourth item cannot be obtained from the name "hull" or
"determinant" alone. It needs the containment and measured-bound fields.

### Design Trap Avoided

The trap would be to introduce a theorem named after Corollary 3.12 that simply
assumes the final inequality. This module does not mention q-pilots, Theta-
pilots, or ABC. It only records the common-target upper-bound mechanism that a
future IUT-specific construction must instantiate.

### Next Step

The next milestone should instantiate this common-target package for a toy
family of upper-ray comparisons. That will give a concrete Lean test that a
single common upper-ray bound controls all choices in a family, while still
requiring explicit containment proofs for each possible output.

## Milestone 11: Toy Family Bounds

Lean file: `Iut/Stage1/ToyFamilyBounds.lean`

### Source Check

This milestone is a toy instantiation of the family-level pattern in IUT III,
Corollary 3.12, Step (xi). The relevant source language is that Theorem 3.11,
followed by formation of the holomorphic hull, yields a collection of possible
output data; only after determinant formation and normalized log-volume are the
resulting Theta-side region and the q-pilot log-volume comparable as real
objects.

Mochizuki's formalization progress report describes the same region of the
argument as the move from APT/IPL/SHE plus "hull+det" to the final simultaneous
comparison. Scholze-Stix emphasize that the real comparison must not hide
identifications of copies of ordered real vector spaces. Our toy family therefore
uses one fixed labeled target line `thetaLine`, one explicit transport, and an
explicit cap on all possible epsilon values.

### Purpose

The previous milestone introduced the abstract package:

```text
CommonTargetBound = common target + containment + measured upper bound
```

This milestone verifies that the package behaves as intended in the toy
upper-ray setting. A family of possible outputs is represented by a function

```text
epsilon : index -> Real
```

and each choice gives the target region

```text
R_{<= -2h + epsilon choice}
```

A single cap `epsilonBound`, together with the hypothesis

```text
forall choice, epsilon choice <= epsilonBound
```

produces the common target

```text
R_{<= -2h + epsilonBound}
```

### Lean Declarations

`thetaIndeterminacyFamily f h epsilon` is a `RegionComparisonFamily` whose
chosen comparison is `thetaIndeterminacyComparison f h (epsilon choice)`.

`thetaIndeterminacyCommonTarget h epsilonBound` is the common upper ray with
bound `-2h + epsilonBound`.

The theorem

```text
thetaIndeterminacyFamily_commonTarget
```

turns the pointwise epsilon cap into a proof that the family is contained in the
common target.

The definition

```text
thetaIndeterminacyCommonTargetBound
```

builds a `RegionComparisonFamily.CommonTargetBound` under the explicit
upper-ray normalization hypothesis on the measure.

The theorems

```text
thetaIndeterminacyFamily_allTargetsAtMost
thetaIndeterminacyFamily_choice_targetVolume_le_bound
thetaIndeterminacyFamily_choice_holds_common
```

extract the family-wide bound, the chosen target-volume bound, and the chosen
membership transfer into the common target.

Finally,

```text
unitThetaIndeterminacyFamily_choice_holds_iff_bound
unitThetaIndeterminacyFamily_bound_of_choice_holds
```

show that, for the unit transport toy case, membership in a chosen possible
target gives `h <= epsilon choice`, and the common cap gives `h <= epsilonBound`.

### What This Tests

This is the first end-to-end family test:

1. Possible outputs remain indexed by an explicit choice type.
2. A common target is available only from a pointwise cap proof.
3. A measured family bound is available only after adding upper-ray
   normalization.
4. The arithmetic conclusion for the unit toy transport factors through the
   chosen output and then through the common cap.

This matches the project discipline for the Corollary 3.12 debate: the Lean code
must reveal exactly where choices, common containers, and real-valued
comparisons enter.

### Design Trap Avoided

The trap would be to replace the whole family by the largest epsilon value
without proving that such a value bounds every choice. This module takes the cap
as a hypothesis and makes Lean use it exactly where containment is needed.

### Next Step

The next milestone should start separating the roles that are currently bundled
inside "common target": a toy APT-style transport record should specify how a
chosen output is carried through a named transport before it is compared with a
common target. This keeps the future APT/IPL/SHE decomposition visible instead
of compressing it into one containment hypothesis.

## Milestone 12: Toy APT-Style Transported Outputs

Lean files:

* `Iut/Foundations/TransportedRegionFamily.lean`
* `Iut/Stage1/ToyAPTTransport.lean`

### Source Check

This milestone follows IUT III, Remark 3.11.1, especially the discussion of IPL,
SHE, and APT. Mochizuki says that SHE may be regarded as a kind of parallel
transport mechanism for the Theta-pilot object, but immediately warns that APT
is not simply transport of a set-theoretic region by a set-theoretic function.
Rather, it is a construction algorithm that is simultaneously meaningful relative
to the arithmetic holomorphic structures on both sides of the Theta-link.

Step (xi) in the proof of Corollary 3.12 then says that, for the qualitative
logical part of the argument, one may temporarily forget the hidden theta-
function internals and regard Theorem 3.11 as "some" algorithm transforming
input data into output data satisfying IPL and SHE. Mochizuki's recent
formalization report identifies the APT aspect as the central work in the
second/third triangles of the reorganized proof. Scholze-Stix's critique again
pushes in the same formal direction: every real comparison must keep the
identifications and transports explicit.

### Purpose

The previous toy family treated possible outputs only as a
`RegionComparisonFamily`. That is enough for containment and volume bounds, but
it hides the separate transport and target-region fields inside one comparison.

This milestone introduces:

```text
TransportedRegionFamily source target index
```

with fields

```text
transport    : index -> Transport source target
targetRegion : index -> Region target
```

and a forgetful map to `RegionComparisonFamily`. This is still only a toy
bookkeeping layer. It does not claim to formalize Mochizuki's actual APT
algorithm.

### Lean Declarations

In `TransportedRegionFamily.lean`:

```text
TransportedRegionFamily.comparison
TransportedRegionFamily.comparisons
TransportedRegionFamily.Holds
TransportedRegionFamily.CommonTarget
TransportedRegionFamily.CommonTargetBound
TransportedRegionFamily.CommonTargetHullBound
TransportedRegionFamily.holds_common_of_choice
TransportedRegionFamily.choice_targetVolume_le_of_commonBound
TransportedRegionFamily.allTargetsAtMost_of_commonBound
```

These declarations let us retain explicit transport data until the exact point
where we intentionally forget to the older common-target interface.

In `ToyAPTTransport.lean`:

```text
thetaAPTOutput
thetaAPTOutput_comparison
thetaAPTOutput_comparisons
thetaAPTOutput_commonTarget
thetaAPTOutputCommonTargetBound
thetaAPTOutput_choice_targetVolume_le_bound
thetaAPTOutput_holds_common_of_choice
unitThetaAPTOutput_bound_of_choice_holds
```

`thetaAPTOutput` is the toy transported-output object: each choice uses the
named transport `f`, and the chosen target region is the upper ray
`R_{<= -2h + epsilon choice}`. The comparison and common-target theorems prove
that this structured view agrees with the earlier toy family only after applying
the forgetful map.

### What This Tests

The dependency chain is now more explicit:

1. A choice supplies a named transport and a target region.
2. These form a chosen `RegionComparison`.
3. The transported family may be forgotten to a `RegionComparisonFamily`.
4. Common-target containment and measured bounds are applied only after that
   forgetful step.

This catches a subtle bookkeeping error: a later proof should not be able to
use a common-target estimate while suppressing the transport that produced the
chosen output.

### Design Trap Avoided

The trap would be to call an ordinary map of regions "APT". This milestone uses
"APT-style" only for the toy bookkeeping shape and explicitly models no more
than choice-dependent transports and regions. The actual IUT APT construction
remains a future source-specific obligation.

### Next Step

The next milestone should add a small interface for named qualitative properties
of an algorithmic output, such as toy `HasIPL`, `HasSHE`, and `HasAPT` fields,
without making them mathematically powerful. That will let future milestones
state which hypotheses are used when passing from algorithmic output to
common-target bounds.

## Milestone 13: Qualitative Algorithmic Output

Lean files:

* `Iut/Foundations/AlgorithmicOutput.lean`
* `Iut/Stage1/ToyQualitativeOutput.lean`

### Source Check

This milestone follows IUT III, Remark 3.11.1, where Mochizuki names IPL
(`Input prime-strip link`), SHE (`Simultaneous holomorphic expressibility`), and
APT (`Algorithmic parallel transport`) as qualitative properties of the output
of the multiradial construction algorithm. The source says that IPL links the
output data to the input q-pilot prime-strip, SHE says the construction is
simultaneously meaningful relative to the two arithmetic holomorphic
structures, and APT is explicitly not just transport of a set-theoretic region by
a set-theoretic map.

Step (xi) in the proof of Corollary 3.12 then takes a qualitative-logical view
of Theorem 3.11 as an algorithm that transforms input data into output data
satisfying IPL and SHE, while temporarily forgetting hidden theta-function
internals. Mochizuki's recent progress report says the RIMS formalization work
is focused on the APT part of the second/third triangles. Scholze-Stix's critique
again motivates explicit bookkeeping: they object to hidden identifications when
real inequalities are extracted.

### Purpose

The previous milestone made the transported-output family explicit. This
milestone adds a wrapper:

```text
AlgorithmicOutput source target index
```

with fields:

```text
family : TransportedRegionFamily source target index
ipl    : Prop
she    : Prop
apt    : Prop
```

The point is not to make these names prove anything. They are opaque
propositions that future source-specific modules must instantiate.

### Lean Declarations

In `AlgorithmicOutput.lean`:

```text
AlgorithmicOutput.HasIPL
AlgorithmicOutput.HasSHE
AlgorithmicOutput.HasAPT
AlgorithmicOutput.Certified
AlgorithmicOutput.comparison
AlgorithmicOutput.comparisons
AlgorithmicOutput.Holds
AlgorithmicOutput.CommonTargetBound
AlgorithmicOutput.CertifiedCommonTargetBound
```

`Certified` stores evidence for the named qualitative properties. A
`CertifiedCommonTargetBound` stores both this evidence and the separate
common-target bound. Theorems such as

```text
CertifiedCommonTargetBound.choice_targetVolume_le
CertifiedCommonTargetBound.allTargetsAtMost
```

use the common-target bound field, not the names IPL/SHE/APT alone.

In `ToyQualitativeOutput.lean`:

```text
thetaToyAlgorithmOutput
thetaToyAlgorithmOutput_certified
thetaToyCertifiedCommonTargetBound
thetaToyAlgorithmOutput_choice_targetVolume_le_bound
unitThetaToyAlgorithmOutput_bound_of_choice_holds
```

The toy output sets IPL/SHE/APT to `True`, only to test the interface. The
numerical estimate still needs the explicit epsilon cap, upper-ray normalization,
and common-target bound construction.

### What This Tests

The formal dependency is now visible:

1. A transported output family is present.
2. Qualitative properties can be named and certified.
3. Certification alone does not produce containment or a volume estimate.
4. The real bound is obtained only when a `CommonTargetBound` is also supplied.

This matters for the IUT formalization because the contested Corollary 3.12 step
cannot be allowed to turn labels such as IPL, SHE, or APT into the desired real
inequality without intermediate formal data.

### Design Trap Avoided

The trap would be to implement `HasAPT -> CommonTargetBound` as an axiom-like
bridge. This milestone refuses that bridge. It provides only names and explicit
packaging, so future work must prove any bridge from source-specific
constructions.

### Next Step

The next milestone should add a first bridge-shaped theorem schema, still
abstract: if a certified algorithmic output is accompanied by an explicit
common-target-bound constructor, then the chosen target-volume bound follows.
This will make the future "3.11 => 3.11.5" obligation visible as a separate
function/hypothesis rather than as an implicit consequence of APT.

## Milestone 14: Algorithmic Bridge Schema

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/ToyBridge.lean`

### Source Check

This milestone follows Mochizuki's formalization progress report, where the
reorganized proof separates the second/third triangles from the final
`3.11.5 => 3.12` comparison. The report says that the operation
`(HDD) := (hull+det) o (dsc)` is moved into the intermediate stage and that the
central issue in the second/third triangles is APT: how gluings up to
indeterminacies plus hull are expressed.

The same separation appears in IUT III, Corollary 3.12, Step (xi): first one
regards Theorem 3.11 qualitatively as an algorithm producing output satisfying
IPL/SHE/APT; then the construction is enlarged by holomorphic hulls, determinant
formation, and normalized log-volume before comparable real objects appear.
Scholze-Stix's critique again motivates this separation because their objection
concerns precisely the passage from qualitative identifications to a real
inequality.

### Purpose

The previous milestone gave names to IPL, SHE, and APT but did not let them
prove anything. This milestone adds the first bridge-shaped schema:

```text
CommonTargetBoundBridge output measure bound
```

It is a structure with one field:

```text
build : output.Certified -> output.CommonTargetBound measure bound
```

This is the formal slot for a future source-specific proof of the
`3.11 => 3.11.5` obligation. The bridge is explicit data; it is not derived from
`HasAPT`, `HasSHE`, or `HasIPL`.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
AlgorithmicOutput.CommonTargetBoundBridge
AlgorithmicOutput.CommonTargetBoundBridge.apply
AlgorithmicOutput.CommonTargetBoundBridge.choice_targetVolume_le
AlgorithmicOutput.CommonTargetBoundBridge.allTargetsAtMost
AlgorithmicOutput.CommonTargetBoundBridge.preserves_hasIPL
AlgorithmicOutput.CommonTargetBoundBridge.preserves_hasSHE
AlgorithmicOutput.CommonTargetBoundBridge.preserves_hasAPT
```

The first two declarations build a `CertifiedCommonTargetBound` from a
certificate and an explicit bridge. The volume theorems use the common-target
bound produced by `build`.

In `ToyBridge.lean`:

```text
thetaToyCommonTargetBoundBridge
thetaToyCertifiedBridgeBound
thetaToyBridge_choice_targetVolume_le_bound
thetaToyBridge_allTargetsAtMost
thetaToyBridge_hasAPT
```

The toy bridge ignores the trivial certificate and constructs the common-target
bound from the explicit epsilon cap plus upper-ray normalization.

### What This Tests

The proof dependency is now:

1. A qualitative output is certified.
2. A separate bridge constructor is supplied.
3. The bridge produces common-target-bound data.
4. Only then do target-volume bounds follow.

This is the shape we want before any real IUT-specific theorem is attempted.
Lean will not permit us to get from the names IPL/SHE/APT to volume estimates
unless we also provide the bridge.

### Design Trap Avoided

The trap would be to encode APT itself as a theorem that returns the target
bound. This module keeps the bridge as an independent hypothesis, so future
work must explain and prove the bridge rather than hiding it in a name.

### Next Step

The next milestone should introduce an explicit Stage 1 statement that consumes
a certified output, a bridge, and a measured q-pilot value to produce a
Corollary-3.12-shaped real inequality. This should still be a theorem schema:
the nontrivial work remains in the bridge and in the real-line/log-volume
identifications supplied to it.

## Milestone 15: Stage 1 Corollary Schema

Lean files:

* `Iut/Stage1/CorollarySchema.lean`
* `Iut/Stage1/ToyCorollarySchema.lean`

### Source Check

This milestone follows the end of IUT III, Corollary 3.12, Step (xi), where
Mochizuki writes the comparable real objects as

```text
R_{<= -|log(Theta)|};  -|log(q)| in R.
```

The displayed conclusion discussed by Scholze-Stix is the signed real
inequality

```text
-|log(q)| <= -|log(Theta)|.
```

This sign convention is easy to mishandle in a formalization because our
`PilotLogVolume.value` field stores the unsigned magnitude. Scholze-Stix's
warning that all copies and identifications of real ordered one-dimensional
spaces must be explicit applies directly here.

The milestone also follows Mochizuki's progress report: after the bridge-shaped
`3.11 => 3.11.5` obligation, the final `3.11.5 => 3.12` step should be the
simultaneous comparison that turns the bridge output into the displayed real
inequality.

### Purpose

The previous milestone supplied an explicit bridge from certified algorithmic
output to a common-target bound. This milestone adds the signed-real final step:

```text
qSigned <= thetaSigned
```

implies

```text
Corollary312Inequality
  (signedPilotLogVolume theta thetaSigned)
  (signedPilotLogVolume q qSigned)
```

where `signedPilotLogVolume side signedValue` stores the positive magnitude
`-signedValue`.

### Lean Declarations

In `CorollarySchema.lean`:

```text
signedPilotLogVolume
corollary312_of_signed_le
stage1Comparison_of_signed_le
corollary312_from_bridge
stage1Comparison_from_bridge
```

The bridge theorem takes:

```text
bridge       : output.CommonTargetBoundBridge measure thetaSigned
certified    : output.Certified
choice       : index
hq_le_choice : qSigned <= targetVolume(choice)
```

and combines `hq_le_choice` with the bridge-produced target-volume bound to get
the Corollary-3.12-shaped inequality.

In `ToyCorollarySchema.lean`:

```text
unitThetaToy_qSigned_le_choiceTargetVolume
unitThetaToyCorollary312
unitThetaToyStage1Comparison
```

The first theorem extracts the q-side signed value from actual membership in the
chosen toy upper-ray target. The final theorem packages the result as a
`Stage1Comparison` when `0 < h`, so the stored q-pilot magnitude is positive.

### What This Tests

The dependency chain is now complete for the toy model:

1. A chosen output membership gives a q-side signed value below the chosen
   target volume.
2. A certified output plus bridge gives the chosen target volume below the
   Theta-side signed bound.
3. Transitivity gives the signed inequality.
4. Only then is the signed inequality converted into the existing
   `Corollary312Inequality` over unsigned pilot magnitudes.

This keeps the exact place of the sign conversion visible in Lean.

### Design Trap Avoided

The trap would be to state the final comparison directly as an inequality of
unsigned magnitudes and let Lean's arithmetic hide the negations. This milestone
uses signed real inputs and an explicit conversion to `PilotLogVolume`.

### Next Step

The next milestone should start replacing the toy `True` IPL/SHE/APT
certificates with structured but still abstract records: for example, a named
input link datum for IPL and a named common-ring/holomorphic-structure datum for
SHE. These records should remain inert until a separate bridge theorem consumes
them.

## Milestone 16: Structured Qualitative Data

Lean files:

* `Iut/Foundations/QualitativeData.lean`
* `Iut/Stage1/ToyQualitativeOutput.lean`

### Source Check

This milestone follows IUT III, Remark 3.11.1. There, IPL is described as
linking output data to the input q-pilot prime-strip via poly-isomorphisms,
SHE is described as simultaneous validity relative to the domain and codomain
arithmetic holomorphic structures, and APT is described as a construction
algorithm rather than set-theoretic transport of a region. Step (xi) of
Corollary 3.12 then says that, for the qualitative logical part of the argument,
one may regard Theorem 3.11 as an algorithm producing output data satisfying
IPL and SHE.

Scholze-Stix's criticism again supports making the bookkeeping explicit: hidden
identifications of real lines or concrete pilot objects should not be smuggled
through labels such as IPL, SHE, or APT.

### Purpose

Previously the toy qualitative output used `True` for IPL/SHE/APT. That was
useful as a placeholder but too featureless for the next milestones. We now add
structured records that are still mathematically inert:

```text
QualitativeData.IPLDatum
QualitativeData.SHEDatum
QualitativeData.APTDatum
```

These records contain labels and, for APT, an explicitly named output family
equal to the family under discussion. They do not imply common-target
containment, hull formation, determinant formation, or any volume estimate.

### Lean Declarations

In `QualitativeData.lean`:

```text
IPLDatum
HolomorphicStructure
SHEDatum
APTDatum
HasStructuredIPL
HasStructuredSHE
HasStructuredAPT
apt_output_eq_family
```

The `HasStructured...` predicates are `Nonempty` wrappers around the data. This
keeps them as propositions suitable for `AlgorithmicOutput`, while preserving a
structured witness for documentation and later refinement.

In `ToyQualitativeOutput.lean`, the toy output now uses:

```text
QualitativeData.HasStructuredIPL (thetaAPTOutput f h epsilon)
QualitativeData.HasStructuredSHE (thetaAPTOutput f h epsilon)
QualitativeData.HasStructuredAPT (thetaAPTOutput f h epsilon)
```

instead of `True`. The existing bridge and Corollary schema continue to work
unchanged, which confirms that these qualitative witnesses remain separate from
the common-target bound.

### What This Tests

This milestone tests that richer qualitative data can be threaded through the
formalization without accidentally gaining mathematical force. The target-volume
and Corollary-style inequalities still require the bridge and the explicit
common-target-bound construction.

### Design Trap Avoided

The trap would be to give `APTDatum` a theorem that immediately produces a
common target or volume bound. We only record that a named output family is the
family under discussion. Any actual bridge from APT/IPL/SHE data to hull+det
data remains a future theorem.

### Next Step

The next milestone should refine the bridge schema so that its constructor
explicitly consumes the structured qualitative data, rather than the generic
`Certified` wrapper alone. It should still return a common-target-bound only as
an explicitly supplied source-specific construction.

## Milestone 17: Structured Bridge Schema

Lean files:

* `Iut/Foundations/QualitativeData.lean`
* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/ToyQualitativeOutput.lean`
* `Iut/Stage1/ToyBridge.lean`

### Source Check

This milestone again follows IUT III, Remark 3.11.1 and Corollary 3.12, Step
(xi). IPL, SHE, and APT are not just flags: the source describes IPL as
linking data by prime-strip isomorphisms, SHE as simultaneous expressibility
relative to two arithmetic holomorphic structures, and APT as the construction
mechanism by which gluings up to indeterminacies are expressed. Mochizuki's
formalization progress report says this APT/hull part is exactly the
second/third-triangle work before the final `3.11.5 => 3.12` comparison.

Scholze-Stix's critique warns against jumping from qualitative identifications
to real inequalities without spelling out the concrete comparison data. This
milestone moves in that direction by making the bridge consume structured
qualitative witnesses, while still refusing to make those witnesses powerful by
themselves.

### Purpose

The previous bridge consumed `output.Certified`, which only proved the opaque
properties `output.HasIPL`, `output.HasSHE`, and `output.HasAPT`. We now add a
more explicit certificate:

```text
QualitativeData.StructuredCertificate family
```

with actual IPL, SHE, and APT datum fields. The new bridge schema is:

```text
AlgorithmicOutput.StructuredCommonTargetBoundBridge
```

whose builder has type:

```text
StructuredCertificate output.family -> output.CommonTargetBound measure bound
```

This is still an explicit bridge. Lean does not derive the common-target bound
from the structured certificate alone.

### Lean Declarations

In `QualitativeData.lean`:

```text
StructuredCertificate
StructuredCertificate.hasStructuredIPL
StructuredCertificate.hasStructuredSHE
StructuredCertificate.hasStructuredAPT
```

In `AlgorithmicBridge.lean`:

```text
AlgorithmicOutput.StructuredCommonTargetBoundBridge
AlgorithmicOutput.StructuredCommonTargetBoundBridge.apply
AlgorithmicOutput.StructuredCommonTargetBoundBridge.choice_targetVolume_le
AlgorithmicOutput.StructuredCommonTargetBoundBridge.allTargetsAtMost
```

In the toy files:

```text
thetaToyStructuredCertificate
thetaToyStructuredCommonTargetBoundBridge
thetaToyStructuredBridge_choice_targetVolume_le_bound
thetaToyStructuredBridge_allTargetsAtMost
```

The toy structured bridge ignores the certificate contents and uses the same
explicit epsilon-cap construction as before. That is intentional: the point of
this milestone is dependency shape, not a mathematical claim about IUT.

### What This Tests

The bridge can now be stated as a function of structured qualitative data, but
the volume conclusion still depends on an explicitly supplied bridge. This
preserves the intended separation:

1. Structured IPL/SHE/APT data describe the algorithmic output.
2. A bridge theorem consumes that data.
3. Only the bridge theorem produces common-target-bound data.
4. Only common-target-bound data yields target-volume estimates.

### Design Trap Avoided

The trap would be to add a theorem
`StructuredCertificate -> CommonTargetBound`. We do not add such a theorem.
Instead, `StructuredCommonTargetBoundBridge` is the named obligation that future
IUT-specific work must prove.

### Next Step

The next milestone should connect the structured bridge to the signed
Corollary-3.12 schema directly, adding a theorem parallel to
`corollary312_from_bridge` that consumes a `StructuredCommonTargetBoundBridge`
and a `StructuredCertificate`.
