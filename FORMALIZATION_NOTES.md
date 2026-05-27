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

## Milestone 18: Structured Corollary Schema

Lean files:

* `Iut/Stage1/CorollarySchema.lean`
* `Iut/Stage1/ToyCorollarySchema.lean`

### Source Check

This milestone uses the same source passages as Milestones 15 and 17. IUT III,
Corollary 3.12, Step (xi), presents the final comparison as a signed real
inequality involving `-|log(q)|` and `-|log(Theta)|`. IUT III, Remark 3.11.1,
and Mochizuki's formalization progress report locate the nontrivial earlier
work in the IPL/SHE/APT and hull+det stages. Scholze-Stix's critique stresses
that the passage from those qualitative identifications to a real inequality is
exactly where hidden identifications must be avoided.

### Purpose

Milestone 17 introduced a bridge that consumes a structured IPL/SHE/APT
certificate. This milestone connects that bridge directly to the signed
Corollary-3.12 schema.

The new theorem is parallel to `corollary312_from_bridge`, but takes:

```text
bridge      : output.StructuredCommonTargetBoundBridge measure thetaSigned
certificate : QualitativeData.StructuredCertificate output.family
```

instead of the generic bridge plus `output.Certified`.

### Lean Declarations

In `CorollarySchema.lean`:

```text
corollary312_from_structured_bridge
stage1Comparison_from_structured_bridge
```

In `ToyCorollarySchema.lean`:

```text
unitThetaToyStructuredCorollary312
unitThetaToyStructuredStage1Comparison
```

The proof shape is unchanged:

```text
qSigned <= targetVolume(choice)
targetVolume(choice) <= thetaSigned
-----------------------------------
qSigned <= thetaSigned
```

The only difference is that the second inequality now comes from the structured
bridge applied to a structured qualitative certificate.

### What This Tests

The formal end-to-end path now records the qualitative data at the final schema
boundary:

1. structured IPL/SHE/APT certificate;
2. structured bridge to common-target bound;
3. chosen-output membership gives q-side signed comparison;
4. signed Corollary-3.12 inequality follows.

No theorem turns structured qualitative data alone into the final inequality.

### Design Trap Avoided

The trap would be to keep the structured certificate visible only in intermediate
toy lemmas and then erase it at the Corollary schema. This milestone makes the
structured data part of the final theorem's interface.

### Next Step

The next milestone should add a small "source obligation ledger" in Lean: named
records for which future IUT-specific theorem must provide the structured
bridge, the q-side signed comparison, and the normalization of the measure.

## Milestone 19: Source Obligation Ledger

Lean files:

* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

This milestone follows the same Corollary 3.12 Step (xi) display and the
structured-proof decomposition from Mochizuki's formalization progress report.
The source separates several operations before comparable real objects appear:
the multiradial construction with IPL/SHE/APT properties, hull and determinant
formation, normalized log-volume, and finally the signed real comparison. The
Scholze-Stix critique specifically warns that extracting a real inequality
without spelling out all identifications and comparisons is not acceptable.

### Purpose

The final structured schema now has enough moving parts that we need a ledger
of completed obligations. `SourceObligationLedger` records:

```text
certificate          : structured IPL/SHE/APT data
bridge               : structured bridge to common-target bound
choice               : chosen output
q_le_choice          : qSigned <= targetVolume(choice)
q_positive           : positivity of the stored q magnitude
normalization_proof  : proof of the selected normalization statement
```

The `normalization` field is a parameter of type `Prop`, because the real IUT
normalization statement will not be the toy upper-ray normalization.

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger
SourceObligationLedger.corollary312
SourceObligationLedger.stage1Comparison
SourceObligationLedger.hasNormalization
```

In `ToySourceObligations.lean`:

```text
unitThetaToySourceObligationLedger
unitThetaToyCorollary312_from_sourceObligations
unitThetaToyStage1Comparison_from_sourceObligations
```

The toy ledger uses `RegionMeasure.NormalizesUpperRays measure` as its
normalization obligation.

### What This Tests

The final toy path now names every obligation before producing the Stage 1
comparison. This is useful for future IUT work because a missing bridge,
normalization, or q-side signed comparison will be visible as a missing field
instead of being hidden inside a large theorem.

### Design Trap Avoided

The trap would be to bundle all obligations into one opaque assumption called
"Theorem 3.11". The ledger breaks the final step into fields that can later be
assigned to precise source lemmas.

### Next Step

The next milestone should begin replacing toy labels in `QualitativeData` with
slightly richer abstract identifiers for prime strips, Hodge-theater sides, and
holomorphic structures, still without giving them mathematical consequences.

## Milestone 20: Qualitative Identifiers

Lean files:

* `Iut/Foundations/QualitativeData.lean`
* `Iut/Stage1/ToyQualitativeOutput.lean`

### Source Check

This milestone follows IUT III, Remark 3.11.1, where IPL is described in terms
of input and intermediate `F x mu` prime-strips, SHE is described in terms of
domain and codomain arithmetic holomorphic structures associated to
Theta-Hodge theaters, and APT is described as a construction mechanism rather
than a set-theoretic map. Step (xi) of Corollary 3.12 then uses this qualitative
data while temporarily forgetting hidden theta-function internals.

Scholze-Stix's critique motivates the same bookkeeping discipline: if several
copies of ordered real vector spaces and pilot objects are involved, labels must
not be hidden in prose.

### Purpose

The previous qualitative records still used raw strings for prime-strip and
structure labels. This milestone replaces those raw fields by typed inert
identifiers:

```text
PrimeStripId
HodgeTheaterSide
HodgeTheaterId
CommonLanguageId
TransportMechanismId
```

These identifiers are still just bookkeeping data. They do not produce
isomorphisms, containments, common targets, or volume estimates.

### Lean Declarations

In `QualitativeData.lean`:

```text
PrimeStripId
HodgeTheaterSide
HodgeTheaterId
CommonLanguageId
TransportMechanismId
```

The existing records now use these identifiers:

```text
IPLDatum.inputPrimeStrip
IPLDatum.outputPrimeStrip
IPLDatum.choicePrimeStrip
HolomorphicStructure.theater
HolomorphicStructure.structureLabel
SHEDatum.commonLanguage
APTDatum.mechanism
```

In `ToyQualitativeOutput.lean`, the toy IPL/SHE/APT witnesses now populate the
typed identifiers instead of raw string fields.

### What This Tests

The existing bridge, ledger, and Corollary schema continue to work after making
the qualitative labels more structured. This confirms again that qualitative
bookkeeping remains separate from the proof-producing bridge layer.

### Design Trap Avoided

The trap would be to model a prime-strip identifier as an actual isomorphism or
to make a Hodge-theater identifier carry hidden comparison maps. These are only
typed labels.

### Next Step

The next milestone should add explicit relation records between these
identifiers, such as an inert `PrimeStripLink` and a `SharedHolomorphicContext`,
then thread those through `IPLDatum` and `SHEDatum`.

## Milestone 21: Qualitative Relation Records

Lean files:

* `Iut/Foundations/QualitativeData.lean`
* `Iut/Stage1/ToyQualitativeOutput.lean`

### Source Check

This milestone continues the formalization of IUT III, Remark 3.11.1. The IPL
discussion is not merely about two named prime strips; it refers to links via
full poly-isomorphisms of prime strips. The SHE discussion is not merely about
two Hodge-theater labels; it refers to simultaneous expression relative to both
arithmetic holomorphic structures. We still do not formalize those
isomorphisms or structures, but we now give the relation itself a named
bookkeeping object.

This is also consistent with the Scholze-Stix warning: a proof should not hide
which identifications or shared contexts are being used when a real comparison
is extracted.

### Purpose

Milestone 20 introduced typed identifiers. This milestone adds typed inert
relation records:

```text
PrimeStripLink
SharedHolomorphicContext
```

and threads them through:

```text
IPLDatum.link
SHEDatum.sharedContext
```

These records still do not carry actual isomorphisms, functors, containment
maps, or comparisons.

### Lean Declarations

In `QualitativeData.lean`:

```text
PrimeStripLink
SharedHolomorphicContext
```

`PrimeStripLink` stores source and target prime-strip identifiers plus a label.
`SharedHolomorphicContext` stores domain and codomain holomorphic structures
plus a common-language identifier.

In `ToyQualitativeOutput.lean`, the toy structured certificate now uses:

```text
thetaToyPrimeStripLink
thetaToySharedHolomorphicContext
```

inside the existing IPL and SHE witnesses.

### What This Tests

The complete toy Stage 1 path still builds after adding these relation records.
That confirms the identifiers and relations are still inert bookkeeping:
target-volume estimates and signed inequalities continue to require the bridge,
q-side comparison, and normalization ledger.

### Design Trap Avoided

The trap would be to encode `PrimeStripLink` as an actual isomorphism. That
would overstate the current formalization. We only name the relation that a
future source-specific module must refine.

### Next Step

The next milestone should introduce similarly inert identifiers for the
hull+det stage: a `HullDetOperationId` and a record linking it to the structured
bridge obligation.

## Milestone 22: Hull+Det Bridge Data

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/ToyBridge.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

Mochizuki's April 2026 formalization report decomposes the route toward
Corollary 3.12 into triangles and explicitly describes an arrow

```text
(HDD) := (hull+det) o (dsc)
```

where `hull+det` is obtained by taking a determinant after passing through the
holomorphic-hull form of the multiradial output. The same passage says that
moving `hull+det` into the `3.11.5` side lets the final `3.11.5 => 3.12`
portion focus on the simultaneous comparison.

IUT III, Corollary 3.12, Step `(xi-d)` is the matching source passage. It says
that the multiradial construction, followed by holomorphic hull formation, gives
output data linked to the q-pilot by IPL and expressed in the relevant
holomorphic structure by SHE; then one forms a determinant and applies a
normalized log-volume to obtain comparable real objects.

Scholze-Stix emphasize the opposing diagnostic requirement: when real
comparisons are extracted, all identifications between real-line copies must be
spelled out. Thus this milestone names the hull+det bridge explicitly instead
of letting it disappear inside the final inequality ledger.

### Purpose

The previous bridge record already turned structured qualitative data into a
measured common-target bound. That was too anonymous for the next stage: the
source literature treats the determinant/log-volume passage as a specific proof
step.

This milestone adds a named, inert wrapper:

```text
HullDetOperationId
HullDetBridgeData
```

`HullDetBridgeData` stores both the name of the hull+det operation and the
structured bridge that produces the common-target bound. It does not prove that
the operation is valid, and it does not derive the bridge from the name.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
HullDetOperationId.label
HullDetBridgeData.operation
HullDetBridgeData.bridge
HullDetBridgeData.apply
HullDetBridgeData.choice_targetVolume_le
HullDetBridgeData.allTargetsAtMost
```

In `ToyBridge.lean`:

```text
thetaToyHullDetOperation
thetaToyHullDetBridgeData
thetaToyHullDet_choice_targetVolume_le_bound
thetaToyHullDet_allTargetsAtMost
```

In `SourceObligations.lean`, the ledger field

```text
bridge : output.StructuredCommonTargetBoundBridge measure thetaSigned
```

was replaced by:

```text
hullDetBridge : output.HullDetBridgeData measure thetaSigned
```

The final signed inequality still uses the underlying structured bridge, but it
now reaches that bridge through the named hull+det obligation.

### What This Tests

The toy Stage 1 path still proves the same target-volume bound and signed
Corollary-3.12-shaped inequality after the source ledger is strengthened to
require named hull+det bridge data.

This confirms that the new record is bookkeeping only: it makes a future proof
obligation visible without changing the real-valued arithmetic currently proved
by the toy upper-ray model.

### Design Trap Avoided

The trap would be to model `HullDetOperationId` as if it already performed the
holomorphic hull, determinant, and normalized log-volume construction. That
would silently assume a major part of the contested source proof. We instead
store an inert identifier and continue to require the bridge as explicit data.

### Next Step

The next milestone should split the current hull+det bridge name into the
composition emphasized in Mochizuki's report: introduce a descent-operation
identifier, a hull+det-operation identifier, and an inert `HDD` composite record
that links descent plus hull+det to the structured bridge obligation.

## Milestone 23: HDD Composite Data

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/ToyBridge.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

Mochizuki's April 2026 report distinguishes the second and third triangles in
the Stage 1 decomposition. The second triangle is the descent arrow `(dsc)`,
which concerns regarding the multiradial representation as constructed from
weaker BPS plus etale-Hodge-theater data up to indeterminacies. The third
triangle defines

```text
(HDD) := (hull+det) o (dsc)
```

as the composite of descent with the elementary `hull+det` operation. The
report then identifies the fourth triangle, `(HDD) o (SHE)`, as the final
simultaneous comparison step leading toward Corollary 3.12.

IUT III, Corollary 3.12, Step `(xi-d)` remains the matching technical passage:
the multiradial output is enlarged by holomorphic hulls, converted through
determinants of localized arithmetic vector bundles, and then measured by
normalized log-volume so that q- and Theta-pilot quantities become comparable.

### Purpose

Milestone 22 made hull+det visible in the bridge layer. This milestone prevents
that name from absorbing the descent step. The new declarations make the source
decomposition visible:

```text
DescentOperationId
HDDCompositeData
```

`HDDCompositeData` stores a descent identifier together with a named hull+det
bridge. It still does not assert that descent is valid, that hull+det is valid,
or that their composition has been mathematically constructed.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
DescentOperationId.label
HDDCompositeData.descent
HDDCompositeData.hullDetBridge
HDDCompositeData.structuredBridge
HDDCompositeData.apply
HDDCompositeData.choice_targetVolume_le
HDDCompositeData.allTargetsAtMost
```

In `ToyBridge.lean`:

```text
thetaToyDescentOperation
thetaToyHDDCompositeData
thetaToyHDD_choice_targetVolume_le_bound
thetaToyHDD_allTargetsAtMost
```

In `SourceObligations.lean`, the ledger field

```text
hullDetBridge : output.HullDetBridgeData measure thetaSigned
```

was replaced by:

```text
hdd : output.HDDCompositeData measure thetaSigned
```

The final inequality now accesses the structured bridge through
`ledger.hdd.structuredBridge`.

### What This Tests

The toy source-obligation endpoint still proves the signed Stage 1 inequality
after the final ledger is strengthened from a hull+det bridge to an HDD
composite. This tests that the extra source-level bookkeeping does not change
the current toy arithmetic proof.

### Design Trap Avoided

The trap would be to treat descent as a harmless label already included in
hull+det. In the source decomposition, descent is the place where weaker data
and indeterminacy-controlled construction enter. It needs its own future proof
slot.

### Next Step

The next milestone should expose the fourth triangle by adding an inert
`SHEArrowId` or `SHEBridgeData` and a record for the restricted composite
`HDD o SHE`, then make the source ledger depend on that final composite rather
than directly on HDD.

## Milestone 24: HDD After SHE Composite

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/ToyBridge.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

Mochizuki's April 2026 formalization report describes the fourth triangle as
the composite `(HDD) o (SHE)`. In that triangle, the input data `BPS+etHT` for
`HDD` is obtained by applying the SHE arrow, i.e. simultaneous holomorphic
expressibility, to the q-pilot data constructed from the etale Hodge theater.
The report then says the skeletal Lean work concerns this final triangle: a
simultaneous comparison in a single ring structure/common container between the
Theta-pilot, corresponding to HDD, and the q-pilot, corresponding to SHE.

IUT III, Corollary 3.12, Step `(xi-d)` gives the matching mathematical shape:
the output data after holomorphic hull formation is linked to the q-pilot by
IPL and expressed relative to localized arithmetic vector bundles over rings
arising from the arithmetic holomorphic structure in the `1`-column by SHE.
Only after this expression, determinant formation, and normalized log-volume
application are the q- and Theta-side real objects comparable.

Scholze-Stix again supply the diagnostic constraint for this milestone: because
the final conclusion compares real numbers, all identifications and comparison
contexts must be explicit. The SHE datum used by the final composite therefore
must not drift away from the SHE datum in the structured certificate.

### Purpose

Milestone 23 made HDD visible as descent followed by hull+det. This milestone
adds the fourth-triangle wrapper:

```text
SHEArrowId
SHEArrowData
HDDSHECompositeData
```

`SHEArrowData` stores the inert arrow identifier together with the structured
SHE datum. `HDDSHECompositeData` stores the SHE arrow data and the HDD
composite. The source ledger now depends on this final composite.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
SHEArrowId.label
SHEArrowData.arrow
SHEArrowData.datum
HDDSHECompositeData.sheArrow
HDDSHECompositeData.hdd
HDDSHECompositeData.structuredBridge
HDDSHECompositeData.apply
HDDSHECompositeData.choice_targetVolume_le
HDDSHECompositeData.allTargetsAtMost
```

In `ToyBridge.lean`:

```text
thetaToySHEArrow
thetaToySHEArrowData
thetaToyHDDSHECompositeData
thetaToyHDDSHE_choice_targetVolume_le_bound
thetaToyHDDSHE_allTargetsAtMost
```

In `SourceObligations.lean`, the ledger field

```text
hdd : output.HDDCompositeData measure thetaSigned
```

was replaced by:

```text
hddShe : output.HDDSHECompositeData measure thetaSigned
she_matches_certificate : hddShe.sheArrow.datum = certificate.she
```

The final inequality now accesses the structured bridge through
`ledger.hddShe.structuredBridge`.

### What This Tests

The toy source-obligation endpoint still proves the signed Stage 1 inequality
after the final ledger is strengthened from HDD data to HDD-after-SHE data.
The new `she_matches_certificate` field also tests that the SHE datum used to
restrict HDD is the same SHE datum carried by the structured certificate.

### Design Trap Avoided

The trap would be to add an `(HDD) o (SHE)` label while leaving the actual SHE
datum implicit or inconsistent with the certificate used by the bridge. This
would reintroduce a hidden comparison context at precisely the point where the
source dispute demands explicit bookkeeping.

### Next Step

The next milestone should make the "single ring structure/common container"
language explicit by adding an inert common-container record that ties together
the SHE common holomorphic context, the HDD-after-SHE composite, and the
target-side measure used for the final real comparison.

## Milestone 25: Common Container Data

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/ToyBridge.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

Mochizuki's April 2026 report describes the skeletal Stage 1 Lean work as the
fourth triangle: simultaneous comparison relative to a single ring structure,
or "common container", between the Theta-pilot corresponding to HDD and the
q-pilot corresponding to SHE. Earlier in the same report, the toy description
of IUT emphasizes common multiplicative monoid and abstract group data, but not
common ring structures, as the input for an algorithm that constructs a common
container for distinct arithmetic holomorphic structures.

IUT III also uses this language: in the discussion around Theorem 3.11, a
reconstructed Frobenioid is described as a common container in which distinct
pilot choices and their associated data may be compared. This is consistent
with Step `(xi-d)` of Corollary 3.12, where the q- and Theta-side quantities
become comparable only after the holomorphic-hull, determinant, and normalized
log-volume operations place them in the appropriate shared comparison setting.

Scholze-Stix's criticism again supplies the guardrail: if the formalization says
two real-valued objects are compared in a common setting, then the identity of
that setting must be explicit rather than hidden in prose or in an overloaded
bridge.

### Purpose

Milestone 24 named the restricted composite `(HDD) o (SHE)`. This milestone
adds the common-container layer:

```text
CommonContainerId
CommonContainerData
```

`CommonContainerData` stores an inert container identifier, the shared
holomorphic context supplied by SHE, and the HDD-after-SHE composite. The target
measure appears as a type parameter of the record, so the final real-valued
comparison remains attached to the same target-side measuring apparatus.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
CommonContainerId.label
CommonContainerData.container
CommonContainerData.context
CommonContainerData.hddShe
CommonContainerData.she_context_matches
CommonContainerData.structuredBridge
CommonContainerData.apply
CommonContainerData.choice_targetVolume_le
CommonContainerData.allTargetsAtMost
```

In `ToyBridge.lean`:

```text
thetaToyCommonContainer
thetaToyCommonContainerData
thetaToyCommonContainer_choice_targetVolume_le_bound
thetaToyCommonContainer_allTargetsAtMost
```

In `SourceObligations.lean`, the ledger field

```text
hddShe : output.HDDSHECompositeData measure thetaSigned
```

was replaced by:

```text
commonContainer : output.CommonContainerData measure thetaSigned
```

The ledger still records:

```text
she_matches_certificate :
  commonContainer.hddShe.sheArrow.datum = certificate.she
```

and now also proves:

```text
commonContextMatchesCertificate
```

which states that the common-container context agrees with the SHE shared
context in the structured certificate.

### What This Tests

The toy source-obligation endpoint still proves the signed Stage 1 inequality
after the final ledger is strengthened from HDD-after-SHE data to common
container data. The proof of `commonContextMatchesCertificate` checks that the
container's shared context, the SHE arrow datum, and the certificate's SHE datum
are aligned by explicit Lean equalities.

### Design Trap Avoided

The trap would be to describe a "common container" only in comments while the
actual Lean theorem continues to compare numbers through an anonymous bridge.
This milestone makes the container a formal input to the source ledger without
pretending to have constructed the real IUT common container.

### Next Step

The next milestone should make the real-line comparison discipline sharper by
recording an inert `RealComparisonChart` for the common container, so the final
q- and Theta-side signed reals are explicitly associated with the same target
real-line copy and measure context.

## Milestone 26: Real Comparison Chart

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/ToyBridge.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` says that, after determinant formation
and normalized log-volume are applied, the Theta-side output and q-pilot region
give comparable real objects: an upper ray `R <= -|log(Theta)|` and an element
`-|log(q)|` of `R`.

Mochizuki's April 2026 report describes the same Stage 1 endpoint as a
simultaneous comparison relative to a single ring structure/common container,
and its elementary model says that passing to heights/log-volumes turns the
power map into multiplication on real numbers.

Scholze-Stix emphasize the formal danger: because several ordered
one-dimensional real vector spaces occur, any meaningful inequality requires
consistent identifications of all real-line copies. This milestone adds an
explicit real-comparison chart to record those identifications instead of
letting the final signed inequality use unlabelled `Real` values alone.

### Purpose

Milestone 25 introduced the common container. This milestone adds a real-line
chart for reading q- and Theta-side quantities in the target real-line copy:

```text
RealComparisonChartId
RealComparisonChartData
ChartedCommonContainerData
```

`RealComparisonChartData` records:

```text
qToTarget : Transport source target
thetaToTarget : Transport target target
theta_trivial : Transport.TrivialMonodromy thetaToTarget
```

Thus the q-side real copy must be transported into the target copy explicitly,
and the Theta-side target copy is not silently identified with itself unless the
trivial chart transport is supplied.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
RealComparisonChartId.label
RealComparisonChartData.chart
RealComparisonChartData.qToTarget
RealComparisonChartData.thetaToTarget
RealComparisonChartData.theta_trivial
ChartedCommonContainerData.commonContainer
ChartedCommonContainerData.chart
ChartedCommonContainerData.structuredBridge
ChartedCommonContainerData.apply
ChartedCommonContainerData.choice_targetVolume_le
ChartedCommonContainerData.allTargetsAtMost
ChartedCommonContainerData.thetaTrivial
```

In `ToyBridge.lean`:

```text
thetaToyRealComparisonChart
thetaToyRealComparisonChartData
thetaToyChartedCommonContainerData
thetaToyChartedCommonContainer_choice_targetVolume_le_bound
thetaToyChartedCommonContainer_allTargetsAtMost
thetaToyChartedCommonContainer_theta_trivial
```

In `SourceObligations.lean`, the ledger field

```text
commonContainer : output.CommonContainerData measure thetaSigned
```

was replaced by:

```text
chartedContainer : output.ChartedCommonContainerData measure thetaSigned
```

and the ledger now proves:

```text
thetaChartTrivial
```

which exposes the triviality of the Theta-side chart loop.

### What This Tests

The toy source-obligation endpoint still proves the signed Stage 1 inequality
after the final ledger is strengthened from common-container data to charted
common-container data. The toy chart uses the existing q-to-Theta transport
`f : Transport qLine thetaLine` and the identity transport on `thetaLine`,
whose trivial monodromy is checked in Lean.

### Design Trap Avoided

The trap would be to add common-container bookkeeping while still allowing
q-side and Theta-side real numbers to enter the final inequality without an
explicit chart. This milestone keeps the real-copy identifications visible at
the final source-obligation boundary.

### Next Step

The next milestone should connect `q_le_choice` to the chart more tightly by
introducing a charted q-value record: the q-side point, its transport into the
target real-line copy, and the proof that the transported coordinate is the
`qSigned` value used in the final source ledger.

## Milestone 27: Charted q-Value

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` identifies `-|log(q)|` as the
log-volume of the region arising from the representation of the q-pilot object
at `(1,0)` in the relevant common setting. This is more specific than merely
having an arbitrary real number on the q-side.

Scholze-Stix's warning about ordered one-dimensional real vector spaces applies
directly here: if a real number is used as the q-side term of the final
inequality, the formalization should record which q-side point it came from and
which chart moved it into the target real-line copy.

### Purpose

Milestone 26 recorded the real-comparison chart. This milestone ties the
q-side scalar in the final ledger to that chart:

```text
ChartedQValueData
```

The record stores:

```text
qPoint : Point source
qSigned_eq : (Transport.map chart.qToTarget qPoint).coord = qSigned
```

Thus `qSigned` is no longer just a bare `Real` parameter of the source ledger;
it is explicitly the coordinate obtained by transporting a q-side point through
the ledger's chart.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
ChartedQValueData.qPoint
ChartedQValueData.qSigned_eq
```

In `SourceObligations.lean`, the ledger now has:

```text
qValue : output.ChartedQValueData measure chartedContainer.chart qSigned
```

and proves:

```text
qSigned_eq_chartedQ
```

In `ToySourceObligations.lean`, the toy ledger supplies:

```text
qPoint := qAssignment h
qSigned_eq := rfl
```

because the toy `qSigned` is already
`(Transport.map unitQToTheta (qAssignment h)).coord`.

### What This Tests

The toy source-obligation endpoint still proves the signed Stage 1 inequality
after the final ledger is strengthened with a charted q-value. This confirms
that the q-side real term used by the final inequality is tied to the same
transport chart used by the common container.

### Design Trap Avoided

The trap would be to record a real comparison chart but still allow `qSigned`
to be chosen independently of that chart. This milestone separates two facts:
the chart determines what `qSigned` is, while `q_le_choice` remains the
mathematical inequality comparing that charted value with the chosen target
volume.

### Next Step

The next milestone should add the analogous charted Theta bound record: the
target-side upper-bound coordinate, the proof that it is the `thetaSigned`
bound in the ledger, and the connection to the common-target bound produced by
the charted container.

## Milestone 28: Charted Theta Bound

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` identifies the Theta-side output as the
upper ray `R <= -|log(Theta)|`, where `-|log(Theta)|` is the negative
log-volume of the holomorphic hull under consideration. Earlier explanatory
material in IUT III says the computation of the holomorphic-hull log-volume
amounts to computing an upper bound for the q-side log-volume.

Mochizuki's 2026 report describes the final triangle as a simultaneous
comparison between the Theta-pilot corresponding to HDD and the q-pilot
corresponding to SHE. Scholze-Stix's criticism again makes the formal
requirement sharper: the Theta-side real bound must be tied to the real-line
chart, not left as an unlabelled scalar.

### Purpose

Milestone 27 charted the q-side scalar. This milestone adds the analogous
Theta-side chart record:

```text
ChartedThetaBoundData
```

It stores:

```text
thetaPoint : Point target
thetaSigned_eq :
  (Transport.map chart.thetaToTarget thetaPoint).coord = thetaSigned
```

The source ledger also now stores:

```text
theta_commonBound : output.CommonTargetBound measure thetaSigned
```

This keeps two facts separate: the charted Theta point determines the real
number `thetaSigned`, while the common-target-bound witness says that
`thetaSigned` is the upper bound produced by the charted container.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
ChartedThetaBoundData.thetaPoint
ChartedThetaBoundData.thetaSigned_eq
```

In `SourceObligations.lean`, the ledger now has:

```text
thetaBound :
  output.ChartedThetaBoundData measure chartedContainer.chart thetaSigned
theta_commonBound :
  output.CommonTargetBound measure thetaSigned
```

and provides:

```text
thetaSigned_eq_chartedTheta
thetaCommonBound
```

In `ToySourceObligations.lean`, the toy ledger supplies the target-side point
with coordinate `-(2 * h) + epsilonBound` and obtains `theta_commonBound` by
applying the charted container to the toy structured certificate.

### What This Tests

The toy source-obligation endpoint still proves the signed Stage 1 inequality
after adding a charted Theta-bound point and a separate common-target-bound
witness. Lean checks that the identity Theta chart sends the toy Theta point to
the `thetaSigned` coordinate used in the ledger.

### Design Trap Avoided

The trap would be to treat the upper bound `thetaSigned` as merely the bound
parameter of a bridge. This milestone makes it both a charted target-side real
coordinate and the bound of a common-target-bound witness.

### Next Step

The next milestone should use the new `theta_commonBound` field directly in the
source ledger's derivation of `qSigned <= thetaSigned`, replacing the current
route through `chartedContainer.structuredBridge` where possible.

## Milestone 29: Direct Common-Bound Final Step

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` presents the final real comparison as
membership of the q-side real value in the Theta-side upper ray
`R <= -|log(Theta)|`. In the current Lean interface, this corresponds to a
chosen target volume being bounded by the stored common-target bound
`thetaSigned`.

This also matches the decomposition in Mochizuki's 2026 report: the earlier
HDD/SHE/common-container machinery supplies the comparable Theta-side output,
and the final Stage 1 step consumes that output as an upper bound.

### Purpose

Milestone 28 added:

```text
theta_commonBound : output.CommonTargetBound measure thetaSigned
```

The final source-ledger theorem still re-entered through
`chartedContainer.structuredBridge`. This milestone changes the final derivation
to use the stored common-target-bound witness directly.

### Lean Declarations

In `SourceObligations.lean`:

```text
qSigned_le_thetaSigned
```

is now the central final inequality:

```text
qSigned <= thetaSigned
```

It is proved by composing:

```text
q_le_choice :
  qSigned <= targetVolume(comparison choice)

TransportedRegionFamily.choice_targetVolume_le_of_commonBound
  theta_commonBound choice :
  targetVolume(comparison choice) <= thetaSigned
```

The existing final outputs:

```text
corollary312
stage1Comparison
```

now call `corollary312_of_signed_le` and `stage1Comparison_of_signed_le`
directly on `qSigned_le_thetaSigned`.

### What This Tests

The toy source-obligation endpoint still proves the same signed Stage 1
inequality. The final proof no longer reconstructs the common bound from the
structured bridge; it consumes the common-bound data already recorded in the
ledger.

### Design Trap Avoided

The trap would be to keep the final theorem dependent on a hidden bridge
application after introducing explicit charted Theta-bound and common-bound
fields. This milestone makes the last real inequality depend on the stored
upper-bound witness.

### Next Step

The next milestone should make the chosen target volume itself explicit as
charted data: store the chosen output comparison, its target-volume real, and
the equality connecting that real to the middle term in
`qSigned <= targetVolume <= thetaSigned`.

## Milestone 30: Charted Target Volume

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` describes applying normalized
log-volume to various regions in the common setting: the region coming from the
Theta-side output and the region arising from the q-pilot representation. The
final comparison is not just a two-number comparison; it passes through the
measured output region selected from the collection of possibilities.

The explanatory paragraph around the holomorphic hull says that computing the
log-volume of the hull of possible Theta-pilot images yields an upper bound for
the q-side log-volume. In Lean terms, this is exactly the middle term:

```text
qSigned <= targetVolume(choice) <= thetaSigned
```

Scholze-Stix's real-line-copy warning remains relevant: the middle real must be
identified as the measured target-side value in the same charted comparison
context.

### Purpose

Milestone 29 made the final proof use the stored common bound. This milestone
names the middle target-volume real:

```text
ChartedTargetVolumeData
```

It stores:

```text
targetSigned : Real
targetSigned_eq :
  targetSigned = RegionMeasure.targetVolume measure (output.comparison choice)
```

The record is parameterized by the same real-comparison chart as the q- and
Theta-side values, so the middle real is part of the same charted final
comparison.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
ChartedTargetVolumeData.targetSigned
ChartedTargetVolumeData.targetSigned_eq
```

In `SourceObligations.lean`, the ledger now stores:

```text
targetVolume :
  output.ChartedTargetVolumeData measure chartedContainer.chart choice
q_le_choice :
  qSigned <= targetVolume.targetSigned
```

and proves:

```text
targetSigned_eq_choiceTargetVolume
targetSigned_le_thetaSigned
qSigned_le_thetaSigned
```

The final inequality now factors through the named middle value.

In `ToySourceObligations.lean`, the toy ledger sets `targetSigned` to the
existing target-volume expression for the chosen comparison, with equality by
`rfl`.

### What This Tests

The toy source-obligation endpoint still proves the same signed Stage 1
inequality after the middle real is made explicit. The final proof chain now
has three named pieces: charted q-value, charted chosen target volume, and
charted Theta bound.

### Design Trap Avoided

The trap would be to make q and Theta charted while leaving the measured output
volume as an anonymous expression. This milestone exposes the middle term that
links membership in a chosen output region to the common Theta upper bound.

### Next Step

The next milestone should make the selected comparison itself explicit by
storing a named `ChosenOutputData` record with the choice index, the comparison
object, and the equality to `output.comparison choice`.

## Milestone 31: Chosen Output Data

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` refers to a collection of possible
output data produced by the multiradial construction, followed by holomorphic
hull formation. The final real comparison uses a selected member of this
collection before passing to its measured target volume.

This matches the critique-driven discipline we are enforcing: a formal proof
should not silently pass from a family of possibilities to a chosen measured
region. The selected comparison object should be named before its target volume
is measured.

### Purpose

Milestone 30 named the measured middle real. This milestone names the selected
output comparison itself:

```text
ChosenOutputData
```

It stores:

```text
choice : index
comparison : RegionComparison source target
comparison_eq : comparison = output.comparison choice
```

The source ledger now stores `chosenOutput` instead of a bare `choice`, and the
charted target-volume record depends on `chosenOutput.choice`.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
ChosenOutputData.choice
ChosenOutputData.comparison
ChosenOutputData.comparison_eq
```

In `SourceObligations.lean`, the ledger now has:

```text
chosenOutput : output.ChosenOutputData
targetVolume :
  output.ChartedTargetVolumeData measure chartedContainer.chart chosenOutput.choice
```

and proves:

```text
chosenComparison_eq_outputComparison
targetSigned_eq_chosenComparisonVolume
```

The existing final inequality now factors through:

```text
qSigned
  <= targetVolume.targetSigned
  = targetVolume(output.comparison chosenOutput.choice)
  <= thetaSigned
```

with the chosen comparison itself available as a named object.

### What This Tests

The toy source-obligation endpoint still proves the same signed Stage 1
inequality after replacing the bare choice index with a chosen-output record.
The toy record uses the definitional selected comparison
`(thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice`.

### Design Trap Avoided

The trap would be to name the measured target volume without naming which
possible output comparison was selected from the family. This milestone makes
the passage from possible outputs to a selected comparison explicit.

### Next Step

The next milestone should connect the selected comparison to the q-side point by
storing a charted membership witness: the chosen comparison holds for the
charted q-point, and this membership is the source of `q_le_choice`.

## Milestone 32: Charted Membership Witness

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` describes the q-pilot representation as
a region in the same common setting in which the Theta-side output regions are
measured. The final inequality uses the fact that the q-pilot data is related
to a selected output possibility before taking the measured target-volume
middle term.

Scholze-Stix emphasize that the comparison of concrete q- and Theta-pilot
objects must not hide the identifications of the real-line copies involved. In
our current interface, that means the q-point, the selected comparison, and the
target-volume inequality should be connected in one explicit witness.

### Purpose

Milestone 31 named the selected output comparison. This milestone adds:

```text
ChartedMembershipData
```

It stores:

```text
holds :
  chosenOutput.comparison.Holds qValue.qPoint
q_le_target :
  qSigned <= targetVolume.targetSigned
```

The second field is still explicit because the general abstraction does not
know that all selected regions are normalized upper rays. In the toy model,
this inequality is proved from membership and upper-ray normalization by
`unitThetaToy_qSigned_le_choiceTargetVolume`.

### Lean Declarations

In `AlgorithmicBridge.lean`:

```text
ChartedMembershipData.holds
ChartedMembershipData.q_le_target
```

In `SourceObligations.lean`, the ledger replaces:

```text
q_le_choice : qSigned <= targetVolume.targetSigned
```

with:

```text
membership :
  output.ChartedMembershipData measure chartedContainer.chart
    qValue chosenOutput targetVolume
```

and proves:

```text
chosenComparisonHoldsQ
qSigned_le_targetSigned
qSigned_le_thetaSigned
```

In `ToySourceObligations.lean`, the toy ledger obtains `holds` from the
existing `hholds` assumption and supplies `q_le_target` using the existing toy
membership-to-volume theorem.

### What This Tests

The toy source-obligation endpoint still proves the signed Stage 1 inequality
after the raw q-to-target inequality is moved into a membership witness. This
checks that the final proof chain now records: q-point, chosen comparison
membership, chosen target volume, and Theta upper bound.

### Design Trap Avoided

The trap would be to carry `qSigned <= targetSigned` as an isolated inequality
after formalizing the q-point and chosen output. This milestone keeps the
membership relation visible at the same boundary where the inequality enters.

### Next Step

The next milestone should refine this by adding a toy theorem showing
`membership.q_le_target` is definitionally the same inequality as the old
`unitThetaToy_qSigned_le_choiceTargetVolume`, so that future source modules can
replace it with domain-specific membership-to-volume lemmas.

## Milestone 33: Toy Membership Inequality Projection

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` passes from q-pilot representation data
inside the common comparison setting to real log-volume inequalities. In the toy
model, this is represented by the upper-ray theorem
`unitThetaToy_qSigned_le_choiceTargetVolume`.

This milestone does not add new mathematical content. It records, in Lean, that
the source-obligation ledger's new membership field stores exactly that
membership-to-volume proof in the toy case.

### Purpose

Milestone 32 moved the q-to-target inequality into:

```text
membership.q_le_target
```

This milestone adds a theorem exposing the toy implementation:

```text
unitThetaToy_membership_q_le_target_from_sourceObligations
```

The theorem states that the packaged membership inequality is definitionally the
old theorem:

```text
unitThetaToy_qSigned_le_choiceTargetVolume
```

### Lean Declaration

In `ToySourceObligations.lean`:

```text
unitThetaToy_membership_q_le_target_from_sourceObligations
```

The proof is `rfl`, which is intentionally strong: it confirms that no new
hidden conversion was inserted between the toy membership-to-volume lemma and
the source ledger field.

### What This Tests

The toy endpoint still builds, and the new theorem verifies that the source
ledger is merely packaging the old upper-ray membership-to-volume argument.

### Design Trap Avoided

The trap would be to hide the origin of `membership.q_le_target` after moving
the inequality into a structured witness. This theorem gives future source
modules a concrete pattern: prove a domain-specific membership-to-volume lemma,
then store it directly in the membership witness.

### Next Step

The next milestone should add an analogous projection for the membership
predicate itself, exposing that the ledger's `membership.holds` is exactly the
chosen-output form of the original `hholds` assumption.

## Milestone 34: Toy Membership Predicate Projection

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` uses the relationship between q-pilot
data and the selected output possibility before passing to measured real
volumes. In the toy model, this relationship is the original `hholds`
assumption:

```text
(thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice (qAssignment h)
```

After Milestone 32, the source ledger stores this relation as
`membership.holds` for the selected comparison and charted q-point.

### Purpose

Milestone 33 exposed the packaged inequality proof. This milestone exposes the
packaged membership proof:

```text
unitThetaToy_membership_holds_from_sourceObligations
```

The theorem states that the ledger's `membership.holds` is definitionally the
proof obtained from `hholds` after unfolding:

```text
AlgorithmicOutput.Holds
TransportedRegionFamily.Holds
```

### Lean Declaration

In `ToySourceObligations.lean`:

```text
unitThetaToy_membership_holds_from_sourceObligations
```

The proof is again `rfl`, confirming that the source ledger stores the original
membership assumption in chosen-output form without adding hidden proof
machinery.

### What This Tests

The toy endpoint still builds, and Lean confirms that both parts of the
membership witness are transparent:

```text
membership.holds
membership.q_le_target
```

come directly from the old toy membership assumption and membership-to-volume
theorem.

### Design Trap Avoided

The trap would be to structure the ledger so heavily that the original
membership assumption becomes hard to locate. This milestone keeps the origin
of the membership proof explicit for human readers and future source modules.

### Next Step

The next milestone should add a source-ledger theorem packaging the complete
three-term final chain as named data:

```text
qSigned <= targetVolume.targetSigned <= thetaSigned
```

so the final Corollary-3.12 inequality can be audited through a single
intermediate comparison object.

## Milestone 35: Three-Term Comparison Chain

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` presents the final real comparison in a
common real setting: the q-pilot log-volume value is compared with the
Theta-side upper ray obtained from the holomorphic-hull log-volume. The proof
path in our interface passes through a selected measured output target.

The April 2026 report describes this as the final simultaneous comparison in a
single common container. Scholze-Stix's critique requires that such real-number
comparisons keep the relevant real-line identifications explicit. A named
three-term chain is the current minimal audit object for that final step.

### Purpose

Milestones 30-32 named the chosen output, the selected target volume, and the
membership witness. This milestone packages the final numeric chain:

```text
qSigned <= targetVolume.targetSigned <= thetaSigned
```

as:

```text
ThreeTermComparison
```

### Lean Declarations

In `SourceObligations.lean`:

```text
ThreeTermComparison
ThreeTermComparison.q_le_theta
SourceObligationLedger.threeTermComparison
```

`SourceObligationLedger.qSigned_le_thetaSigned` now derives the final
two-term inequality from:

```text
ledger.threeTermComparison.q_le_theta
```

rather than rebuilding the transitivity proof inline.

### What This Tests

The toy source-obligation endpoint still proves the same signed Stage 1
inequality after the final chain is reified as a named record. The
Corollary-3.12-shaped theorem now consumes a separately auditable chain object.

### Design Trap Avoided

The trap would be to keep compressing the last comparison into a single
`le_trans` expression after making all intermediate data explicit. This
milestone preserves the middle target-volume term as part of the final proof
artifact.

### Next Step

The next milestone should add a toy projection theorem showing that
`threeTermComparison.q_le_target` is the same proof as the ledger's packaged
membership inequality, and `threeTermComparison.target_le_theta` is the common
bound applied to the chosen output.

## Milestone 36: Toy Three-Term Chain Projections

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

Mochizuki's April 2026 formalization report isolates the final part of
`Theorem 3.11 => Corollary 3.12` as the simultaneous comparison of the
`q`- and `Theta`-pilot objects in a common container. IUT III, Corollary 3.12,
Step `(xi-d)` then emphasizes that the comparable objects are obtained only
after forming the correct determinant/log-volume data and landing in a common
real setting:

```text
R_{<= -|log(Theta)|} subset R; -|log(q)| in R
```

Scholze-Stix's critique identifies this as exactly the place where all
identifications of ordered one-dimensional real vector spaces must be spelled
out before concluding a numerical inequality. For our toy endpoint, this means
that a named three-term comparison is not enough: we also want projection
theorems showing where each field of the chain came from.

### Purpose

Milestone 35 introduced:

```text
ThreeTermComparison qSigned targetSigned thetaSigned
```

This milestone proves that, in the toy source ledger, the two fields of the
three-term comparison are not hiding any extra argument:

```text
qSigned <= targetSigned
targetSigned <= thetaSigned
```

The first field is exactly the ledger's membership inequality. The second field
is exactly the common target bound applied to the chosen output, after rewriting
the charted target signed value to the selected output's measured target volume.

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_threeTerm_q_le_target_from_sourceObligations
unitThetaToy_threeTerm_target_le_theta_from_sourceObligations
```

Both proofs are `rfl`. This is intentional: Lean confirms that the toy chain
fields are definitionally the expected proof fields, not merely propositionally
equivalent after proof irrelevance.

### What This Tests

The toy endpoint now exposes the final chain in three audit layers:

```text
membership.holds
membership.q_le_target
threeTermComparison.q_le_target
threeTermComparison.target_le_theta
```

This makes the final `q <= theta` proof traceable through the selected target
volume rather than collapsing immediately to a two-term inequality.

### Design Trap Avoided

The trap would be to introduce a named chain but then make its fields opaque.
That would give us cleaner Lean terms while losing the audit trail that matters
for the Corollary 3.12 dispute. Here the projection lemmas keep the chain
transparent and ready to be replaced later by source-level IUT lemmas.

### Next Step

The next milestone should promote the same field-origin projections from the
toy endpoint to general source-ledger theorems, so every future source module
gets the same audit hooks without having to reprove them.

## Milestone 37: General Three-Term Chain Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The April 2026 formalization report describes the final portion of
`Theorem 3.11 => Corollary 3.12` as the simultaneous comparison of `q`- and
`Theta`-pilot objects in a common container. IUT III, Step `(xi-d)` describes the
same comparison as landing in completely comparable log-volume objects in `R`.
IUT IV repeatedly describes the `Theta` side as a container for possible images
whose upper bound absorbs the indeterminacies.

Scholze-Stix's criticism is again directly relevant: a meaningful real
inequality requires all identifications of the ordered one-dimensional real
spaces to be explicit. The ledger should therefore expose not just the final
inequality, but the exact field origins of the final three-term comparison.

### Purpose

Milestone 36 added toy-only projection lemmas. This milestone promotes the same
audit hooks to the general `SourceObligationLedger`, so they are available to
every later source module:

```text
ledger.threeTermComparison.q_le_target
  = ledger.membership.q_le_target

ledger.threeTermComparison.target_le_theta
  = common target bound applied to ledger.chosenOutput.choice
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.threeTerm_q_le_target_eq_membership
SourceObligationLedger.threeTerm_target_le_theta_eq_commonBound
```

Both proofs are `rfl`. The point is definitional transparency: the chain object
does not contain a hidden comparison theorem. Its left field is the membership
inequality, and its right field is the common-bound theorem transported through
the selected charted target-volume equality.

### What This Tests

The general ledger now has reusable field-origin theorems before any toy data
is supplied. Future source files can cite these theorems to audit the path:

```text
chosen output
charted target volume
membership inequality
common target bound
three-term comparison
final q <= theta inequality
```

### Design Trap Avoided

The trap would be to let each source model invent its own explanation of how
the final chain was assembled. That would make it too easy for two source
modules to satisfy the final API in subtly different ways. These general
projection lemmas keep the source-obligation interface itself responsible for
the audit trail.

### Next Step

The next milestone should connect the final two-term inequality
`qSigned <= thetaSigned` back to the named three-term comparison with a general
projection theorem, then expose the same path for the packaged
`Corollary312Inequality`.

## Milestone 38: Final Inequality Packaging Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` presents the final comparable objects as
a `Theta`-side upper ray in `R` and a `q`-side signed log-volume value in `R`.
The April 2026 formalization report isolates this final stage as the
`3.11.5 => 3.12` comparison of the two pilot objects. Scholze-Stix's critique
warns that the comparison is meaningful only when the real-line identifications
and the resulting numerical inequality are explicitly accounted for.

In the current Stage 1 schema, the final real-number proof has two last
handoffs:

```text
qSigned <= targetSigned <= thetaSigned
  gives qSigned <= thetaSigned

qSigned <= thetaSigned
  gives Corollary312Inequality
```

This milestone names both handoffs.

### Purpose

The source ledger already exposes the two fields of the three-term comparison.
This milestone makes the final packaging path equally explicit:

```text
ledger.qSigned_le_thetaSigned
  = ledger.threeTermComparison.q_le_theta

ledger.corollary312
  = corollary312_of_signed_le ledger.threeTermComparison.q_le_theta
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.qSigned_le_thetaSigned_eq_threeTerm
SourceObligationLedger.corollary312_eq_threeTermComparison
```

Both proofs are `rfl`, so Lean verifies that no extra comparison theorem or
hidden sign manipulation is introduced between the three-term chain and the
packaged Corollary-3.12-shaped inequality.

### What This Tests

The final general audit path is now:

```text
membership.q_le_target
common target bound on chosen output
ThreeTermComparison.q_le_theta
corollary312_of_signed_le
```

This is still a Stage 1 abstraction. It does not prove the disputed IUT source
obligations. It records exactly which obligations must be supplied before the
Corollary-3.12-shaped inequality follows in Lean.

### Design Trap Avoided

The trap would be to leave the last abstraction boundary at
`Corollary312Inequality`, where the reader sees only the final packaged
statement. The new projections force the packaged theorem to point back to the
named three-term chain.

### Next Step

The next milestone should add the analogous projection for
`SourceObligationLedger.stage1Comparison`, showing that the exported
`Stage1Comparison.comparison` field is the same Corollary-3.12 proof produced
from the named three-term chain and that `q_positive` is simply the ledger's
recorded positivity obligation.

## Milestone 39: Stage 1 Comparison Field Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The display in IUT III, Corollary 3.12, Step `(xi-d)` compares signed
log-volume data of the form `-|log(Theta)|` and `-|log(q)|` after the relevant
objects have been made comparable in `R`. Our `CorollarySchema.lean` file
therefore stores signed values explicitly and turns them into positive
`PilotLogVolume.value` fields via `signedPilotLogVolume`.

The April 2026 formalization report separates this endpoint from the earlier
APT/IPL/source-obligation work. Scholze-Stix's critique reinforces why this
endpoint should not hide any real-line identification or sign convention inside
a final record.

### Purpose

`Stage1Comparison` is the exported Stage 1 interface. This milestone exposes
where its proof fields come from when constructed from a source ledger:

```text
ledger.stage1Comparison.q_positive
  = ledger.q_positive

ledger.stage1Comparison.comparison
  = ledger.corollary312

ledger.stage1Comparison.comparison
  = corollary312_of_signed_le ledger.threeTermComparison.q_le_theta
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.stage1Comparison_q_positive_eq_ledger
SourceObligationLedger.stage1Comparison_comparison_eq_corollary312
SourceObligationLedger.stage1Comparison_comparison_eq_threeTermComparison
```

All three proofs are `rfl`. Lean verifies that the exported `Stage1Comparison`
record contains the ledger's positivity proof and the same final comparison
proof already traced through the three-term chain.

### What This Tests

The exported Stage 1 object now has named audit projections for the fields that
matter to the final inequality:

```text
q_positive
comparison
```

This prevents the final API from becoming a place where sign conversion or
proof assembly can disappear from view.

### Design Trap Avoided

The trap would be to treat `Stage1Comparison` as a harmless packaging layer.
Packaging layers are exactly where hidden sign conventions become difficult to
inspect. The new projection lemmas keep the packaging layer transparent.

### Next Step

The next milestone should expose the signed pilot-volume fields of
`stage1Comparison`, namely that the exported `theta` and `q` values are exactly
`signedPilotLogVolume PilotSide.theta thetaSigned` and
`signedPilotLogVolume PilotSide.q qSigned`.

## Milestone 40: Stage 1 Signed Pilot-Volume Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)` writes the final comparison in terms of
signed log-volume expressions such as `-|log(Theta)|` and `-|log(q)|`, while
our `PilotLogVolume` record stores a positive magnitude in its `value` field.
`CorollarySchema.lean` therefore uses `signedPilotLogVolume` to keep the sign
conversion explicit:

```text
signedPilotLogVolume side signedValue has value -signedValue
```

This is a small bookkeeping point, but it is directly connected to the broader
audit requirement emphasized by Scholze-Stix: every real-number identification
and sign convention used in the final inequality should be visible.

### Purpose

Milestone 39 exposed the proof fields of `stage1Comparison`. This milestone
exposes the data fields:

```text
ledger.stage1Comparison.theta
  = signedPilotLogVolume PilotSide.theta thetaSigned

ledger.stage1Comparison.q
  = signedPilotLogVolume PilotSide.q qSigned

ledger.stage1Comparison.theta.value = -thetaSigned
ledger.stage1Comparison.q.value = -qSigned
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.stage1Comparison_theta_eq_signed
SourceObligationLedger.stage1Comparison_q_eq_signed
SourceObligationLedger.stage1Comparison_theta_value_eq_neg
SourceObligationLedger.stage1Comparison_q_value_eq_neg
```

All four proofs are `rfl`, so the exported record's pilot-volume fields are
definitionally the signed values advertised by the Stage 1 schema.

### What This Tests

The final exported object now exposes both sides of the sign convention:

```text
thetaSigned -> theta.value = -thetaSigned
qSigned     -> q.value     = -qSigned
```

This makes the final `Corollary312Inequality` package easier to audit without
unfolding the constructor manually.

### Design Trap Avoided

The trap would be to hide the sign flip inside the final comparison package and
then reason only about positive magnitudes. The source ledger now has explicit
projection lemmas for the signed-to-positive conversion.

### Next Step

The next milestone should expose the remaining side-label fields of
`stage1Comparison`, confirming definitionally that the exported `theta` side is
`PilotSide.theta` and the exported `q` side is `PilotSide.q`.

## Milestone 41: Stage 1 Side-Label Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The final Corollary 3.12 comparison distinguishes the `Theta`-pilot side from
the `q`-pilot side. Mochizuki's April 2026 report describes this as the
simultaneous comparison of the `Theta`-pilot and `q`-pilot objects in a common
container. IUT III, Step `(xi-d)`, likewise presents separate `Theta` and `q`
log-volume expressions after they have been made comparable in `R`.

Since Scholze-Stix's critique stresses that the real-number identifications must
be explicit, the bookkeeping labels on the exported `Stage1Comparison` should
also be explicit: the final record should not leave room for the two pilot sides
to be interchanged silently.

### Purpose

Milestone 40 exposed the signed pilot-volume values. This milestone exposes the
side-label fields:

```text
ledger.stage1Comparison.theta_side = rfl
ledger.stage1Comparison.q_side = rfl

ledger.stage1Comparison.theta.side = PilotSide.theta
ledger.stage1Comparison.q.side = PilotSide.q
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.stage1Comparison_theta_side_eq_ledger
SourceObligationLedger.stage1Comparison_q_side_eq_ledger
SourceObligationLedger.stage1Comparison_theta_side_value
SourceObligationLedger.stage1Comparison_q_side_value
```

All four proofs are `rfl`, so the side labels in the exported Stage 1 object
are definitionally the labels assigned by `stage1Comparison_of_signed_le`.

### What This Tests

The exported endpoint now has explicit projections for:

```text
theta side label
q side label
theta signed value
q signed value
positivity proof
comparison proof
```

This gives a fully named audit trail for the current Stage 1 packaging layer.

### Design Trap Avoided

The trap would be to regard side labels as harmless metadata. In this project,
labels matter because the disputed comparison distinguishes which side carries
the `Theta`-pilot upper ray and which side carries the `q`-pilot value. The
projection lemmas keep that distinction checkable in Lean.

### Next Step

The next milestone should turn this package audit into a compact theorem that
recovers `corollary312_from_stage1_comparison ledger.stage1Comparison` as the
same proof as `ledger.corollary312`, so users of the exported Stage 1 interface
can move back to the ledger proof without unfolding the record manually.

## Milestone 42: Stage 1 Corollary Recovery

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The formalization report separates the final `3.11.5 => 3.12` comparison from
the earlier source obligations, while IUT III, Step `(xi-d)`, presents the final
endpoint as a comparison of the `Theta`-side upper ray and the `q`-side signed
value in a common real setting. Our `Stage1Comparison` record is the exported
interface for precisely that endpoint.

Scholze-Stix's criticism makes it important that passing through an exported
interface does not lose the explicit proof path through the chosen real-line
comparison. A user who has only the `Stage1Comparison` should be able to recover
the same Corollary-3.12-shaped proof as the source ledger produced.

### Purpose

This milestone adds compact recovery theorems:

```text
corollary312_from_stage1_comparison ledger.stage1Comparison
  = ledger.corollary312

corollary312_from_stage1_comparison ledger.stage1Comparison
  = corollary312_of_signed_le ledger.threeTermComparison.q_le_theta
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.stage1Comparison_recovers_corollary312
SourceObligationLedger.stage1Comparison_recovers_threeTermComparison
```

Both proofs are `rfl`. This confirms that the exported Stage 1 interface is a
transparent wrapper around the same comparison proof, not a second route to the
final inequality.

### What This Tests

The current Stage 1 packaging audit now runs in both directions:

```text
ledger -> stage1Comparison fields
stage1Comparison -> ledger.corollary312
stage1Comparison -> threeTermComparison.q_le_theta
```

That gives downstream modules a stable theorem to cite when moving from the
public Stage 1 record back to the internal source-obligation ledger.

### Design Trap Avoided

The trap would be to allow the final exported API to become detached from the
ledger proof path. The recovery theorems make the exported API and the ledger
API definitionally aligned.

### Next Step

The next milestone should step back from final packaging and add source-ledger
projection theorems for the charted `q` and `Theta` numeric values, connecting
`qSigned` and `thetaSigned` back to the transported chart data that supplies the
real-line coordinates.

## Milestone 43: Charted Signed-Coordinate Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

IUT III, Corollary 3.12, Step `(xi-d)`, says that completely comparable objects
are obtained only after the relevant log-volume constructions land in `R`.
Scholze-Stix's critique focuses on exactly this kind of issue: several ordered
one-dimensional real vector spaces occur, and the identifications among them
must be explicit before a numerical inequality is meaningful.

Our `ChartedQValueData` and `ChartedThetaBoundData` records encode this by
requiring explicit transports into the real-comparison chart:

```text
(Transport.map chart.qToTarget qPoint).coord = qSigned
(Transport.map chart.thetaToTarget thetaPoint).coord = thetaSigned
```

### Purpose

The source ledger already exposed these equalities. This milestone adds two
audit improvements:

```text
ledger.qSigned_eq_chartedQ = ledger.qValue.qSigned_eq
ledger.thetaSigned_eq_chartedTheta = ledger.thetaBound.thetaSigned_eq
```

and reverse-orientation forms:

```text
qSigned = transported q coordinate
thetaSigned = transported Theta coordinate
```

The reverse orientation is often easier to read when auditing how the signed
real numbers used in the final inequality arise from chart data.

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.qSigned_eq_chartedQ_eq_field
SourceObligationLedger.qSigned_eq_chartedQCoord
SourceObligationLedger.thetaSigned_eq_chartedTheta_eq_field
SourceObligationLedger.thetaSigned_eq_chartedThetaCoord
```

The field-origin projections are `rfl`; the reverse-orientation projections are
the symmetric forms of the stored chart equalities.

### What This Tests

The ledger now has named audit hooks for the real-coordinate inputs to the
final comparison:

```text
q point transported through qToTarget -> qSigned
Theta point transported through thetaToTarget -> thetaSigned
```

This is the beginning of the source-side real-line audit, as opposed to the
final packaging audit completed in the previous milestones.

### Design Trap Avoided

The trap would be to let `qSigned` and `thetaSigned` appear as free real
parameters detached from their chart origins. These projections keep the signed
numbers tied to the explicit transports recorded in the ledger.

### Next Step

The next milestone should add analogous field-origin projections for the
selected target-volume equality, connecting `targetVolume.targetSigned` to the
measured target volume of the chosen output.

## Milestone 44: Target-Volume Coordinate Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The final Stage 1 comparison uses a middle target-volume term between the
`q`-side signed value and the `Theta`-side bound. IUT III, Step `(xi-d)`, treats
the relevant `q` and `Theta` objects as comparable only after log-volume
interpretation in a common real setting. IUT IV describes the `Theta` side in
terms of containers for possible images and upper bounds. Scholze-Stix's
critique again makes the audit point: the real number being compared must be
explicitly identified.

In the ledger, the middle term is:

```text
ledger.targetVolume.targetSigned
```

and `ChartedTargetVolumeData` ties it to:

```text
RegionMeasure.targetVolume measure (output.comparison choice)
```

### Purpose

This milestone adds source-ledger projections for the target-volume coordinate:

```text
ledger.targetSigned_eq_choiceTargetVolume
  = ledger.targetVolume.targetSigned_eq

RegionMeasure.targetVolume measure (output.comparison choice)
  = ledger.targetVolume.targetSigned

RegionMeasure.targetVolume measure ledger.chosenOutput.comparison
  = ledger.targetVolume.targetSigned
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.targetSigned_eq_choiceTargetVolume_eq_field
SourceObligationLedger.choiceTargetVolume_eq_targetSigned
SourceObligationLedger.chosenComparisonVolume_eq_targetSigned
```

The field-origin projection is `rfl`. The two reverse-orientation forms are the
symmetric target-volume equality, once directly for `output.comparison choice`
and once after rewriting by the chosen comparison equality.

### What This Tests

The three-term comparison's middle term is now tied to the selected output's
measured target volume in both useful orientations:

```text
targetSigned -> measured chosen target volume
measured chosen target volume -> targetSigned
```

This makes the middle term of `qSigned <= targetSigned <= thetaSigned`
auditable without unfolding the ledger constructor.

### Design Trap Avoided

The trap would be to give the three-term comparison a named middle real number
without keeping it visibly connected to the chosen output. These projections
keep the middle term anchored to the selected target volume.

### Next Step

The next milestone should expose field-origin projections for the chosen output
itself, namely that `chosenOutput.comparison` is exactly
`output.comparison chosenOutput.choice`.

## Milestone 45: Chosen-Output Comparison Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

Mochizuki's April 2026 report identifies the input-prime-strip-link aspect as
the relationship between input data and the output of the multiradial algorithm
in the final `3.11.5 => 3.12` comparison. At our current abstraction level, the
selected output is represented by `ChosenOutputData`: a choice index, the
comparison object selected by that index, and the equality identifying it with
the corresponding member of `output.comparison`.

IUT III, Step `(xi-d)`, then uses the resulting output data only after it has
been converted into comparable real log-volume data. Scholze-Stix's critique
requires the path from selected abstract output to real numerical comparison to
remain explicit.

### Purpose

This milestone exposes the chosen-output equality itself:

```text
ledger.chosenComparison_eq_outputComparison
  = ledger.chosenOutput.comparison_eq

output.comparison ledger.chosenOutput.choice
  = ledger.chosenOutput.comparison
```

The second theorem is the reverse orientation, useful when starting from the
algorithmic output family and rewriting toward the named chosen comparison.

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.chosenComparison_eq_outputComparison_eq_field
SourceObligationLedger.outputComparison_eq_chosenComparison
```

The field-origin projection is `rfl`; the reverse-orientation theorem is the
symmetric form of the stored chosen-output equality.

### What This Tests

The selected comparison object is now explicitly connected to the indexed
algorithmic output family in both orientations:

```text
chosenOutput.comparison -> output.comparison choice
output.comparison choice -> chosenOutput.comparison
```

This closes a small gap in the source-side audit chain from algorithmic output
to measured target volume.

### Design Trap Avoided

The trap would be to let the chosen comparison become a standalone object whose
relationship to the algorithmic output family is only visible by unfolding the
ledger. These projections keep the selected output anchored to its index.

### Next Step

The next milestone should expose field-origin projections for the membership
witness in the general source ledger: `chosenComparisonHoldsQ` should be exactly
`membership.holds`, and `qSigned_le_targetSigned` should be exactly
`membership.q_le_target`.

## Milestone 46: Membership Witness Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The April 2026 formalization report identifies the final comparison as involving
both the output of the multiradial algorithm and the input-prime-strip-link
relationship between input data and output data. In the current abstraction, the
q-point's membership in the selected output comparison is represented by
`ChartedMembershipData.holds`.

IUT III, Step `(xi-d)`, then converts the relevant output data into comparable
real log-volume data. The ledger records the current abstraction boundary:
membership of the q-point and the real inequality from `qSigned` to the selected
target volume are stored together, because in a concrete upper-ray model the
inequality follows from membership and normalization.

### Purpose

This milestone exposes the two fields of the membership witness:

```text
ledger.chosenComparisonHoldsQ = ledger.membership.holds
ledger.qSigned_le_targetSigned = ledger.membership.q_le_target
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.chosenComparisonHoldsQ_eq_membership
SourceObligationLedger.qSigned_le_targetSigned_eq_membership
```

Both proofs are `rfl`, so the ledger's public membership and left-inequality
theorems are definitionally the fields stored in `ChartedMembershipData`.

### What This Tests

The left side of the three-term chain is now traceable through:

```text
membership.holds
membership.q_le_target
threeTermComparison.q_le_target
qSigned_le_thetaSigned
```

This keeps the membership-to-left-inequality boundary explicit for later
replacement by genuine source-specific IUT lemmas.

### Design Trap Avoided

The trap would be to let `qSigned <= targetSigned` look like an independent
real inequality unrelated to q-point membership in the selected output
comparison. These projections keep the left inequality attached to the
membership witness.

### Next Step

The next milestone should expose source-ledger projections for the common
Theta-side bound, including that `thetaCommonBound` is exactly
`theta_commonBound` and that the target-to-Theta inequality uses this bound on
the chosen output.

## Milestone 47: Common Theta-Bound Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

IUT IV describes the `Theta` side in terms of containers for possible images and
upper bounds that absorb indeterminacies. IUT III, Step `(xi-d)`, then compares
the `q`-side signed value with the `Theta`-side upper ray in a common real
setting. The right side of our three-term chain abstracts this endpoint:

```text
targetSigned <= thetaSigned
```

Scholze-Stix's critique again motivates making the source of this real
inequality explicit: it should be visible that the bound comes from the common
Theta-side target bound applied to the selected output.

### Purpose

This milestone exposes the right side of the chain:

```text
ledger.targetSigned_le_thetaSigned
  = ledger.threeTermComparison.target_le_theta

ledger.targetSigned_le_thetaSigned
  = common target bound applied to ledger.chosenOutput.choice

ledger.thetaCommonBound
  = ledger.theta_commonBound
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.targetSigned_le_thetaSigned_eq_threeTerm
SourceObligationLedger.targetSigned_le_thetaSigned_eq_commonBound
SourceObligationLedger.thetaCommonBound_eq_field
```

All three proofs are `rfl`, so the right inequality and the public
`thetaCommonBound` accessor are definitionally aligned with the stored
Theta-side common-bound data.

### What This Tests

The right side of the three-term comparison is now traceable through:

```text
theta_commonBound
choice_targetVolume_le_of_commonBound
threeTermComparison.target_le_theta
targetSigned_le_thetaSigned
```

This complements Milestone 46, which audited the left side through the
membership witness.

### Design Trap Avoided

The trap would be to let `targetSigned <= thetaSigned` appear as a free real
inequality rather than the chosen-output instance of a common container bound.
These projections keep the right inequality tied to the common Theta-side
bound.

### Next Step

The next milestone should add a compact source-ledger theorem that names the
complete audited chain from membership and common bound to
`qSigned <= thetaSigned`, collecting the already exposed left and right
projections into one theorem for downstream modules.

## Milestone 48: Complete Audited Chain Projection

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

IUT III, Step `(xi-d)`, presents the final comparison after the relevant objects
have been made comparable in a common real setting. IUT IV describes the
`Theta` side as controlled by containers for possible images and upper bounds.
Scholze-Stix's critique asks that the real-line identifications and resulting
comparison be spelled out explicitly.

At our current abstraction level, the complete real comparison is:

```text
qSigned <= targetSigned <= thetaSigned
```

where the left inequality is the membership inequality and the right inequality
is the chosen-output instance of the common `Theta` bound.

### Purpose

This milestone adds a compact source-ledger theorem:

```text
ledger.qSigned_le_thetaSigned
  =
le_trans ledger.membership.q_le_target
  (common target bound applied to ledger.chosenOutput.choice)
```

This theorem collects the left and right audit projections into one equality
that downstream modules can cite when they need the entire source-to-final-real
chain.

### Lean Declaration

In `SourceObligations.lean`:

```text
SourceObligationLedger.qSigned_le_thetaSigned_eq_membership_commonBound
```

The proof is `rfl`: Lean confirms that the final two-term inequality is
definitionally the transitive composition of the membership inequality and the
common-bound inequality.

### What This Tests

The ledger now exposes the full final real proof path:

```text
membership.q_le_target
choice_targetVolume_le_of_commonBound theta_commonBound chosenOutput.choice
le_trans
qSigned_le_thetaSigned
corollary312
stage1Comparison
```

This gives the current Stage 1 abstraction a compact audit theorem before we
replace toy obligations with genuine IUT source lemmas.

### Design Trap Avoided

The trap would be to have all pieces individually transparent but no single
named theorem that says the final inequality is exactly their composition. This
milestone makes the final chain easy to cite and hard to misread.

### Next Step

The next milestone should add the analogous compact theorem for
`ledger.corollary312`, showing that the packaged Corollary-3.12-shaped
inequality is obtained directly from this complete audited chain.

## Milestone 49: Corollary from Complete Audited Chain

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The April 2026 formalization report isolates the final `3.11.5 => 3.12`
endpoint as the simultaneous comparison of the `q`- and `Theta`-pilot objects
in a common container. IUT III, Step `(xi-d)`, writes the endpoint as a real
comparison between the `Theta`-side upper ray and the `q`-side signed
log-volume value. Scholze-Stix's critique requires the identifications behind
that numerical comparison to remain explicit.

Milestone 48 named the complete real inequality proof. This milestone connects
the packaged `Corollary312Inequality` proof directly to that same audited chain.

### Purpose

This milestone adds:

```text
ledger.corollary312
  =
corollary312_of_signed_le
  (le_trans ledger.membership.q_le_target
    (common target bound applied to ledger.chosenOutput.choice))
```

### Lean Declaration

In `SourceObligations.lean`:

```text
SourceObligationLedger.corollary312_eq_membership_commonBound
```

The proof is `rfl`, so Lean verifies that the packaged Corollary-3.12-shaped
statement is produced directly from the audited membership-plus-common-bound
chain.

### What This Tests

The current endpoint can now be audited at three levels:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison
```

and each level points back to the same source chain:

```text
membership.q_le_target
common Theta-side bound on chosen output
```

### Design Trap Avoided

The trap would be to audit the real inequality but leave the packaged
Corollary-3.12-shaped theorem as a black box. This theorem makes the package
transparent too.

### Next Step

The next milestone should add the analogous compact theorem for
`ledger.stage1Comparison.comparison`, showing that the exported Stage 1 record
also carries the exact same audited chain.

## Milestone 50: Stage 1 Comparison from Complete Audited Chain

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The exported `Stage1Comparison` record is our current interface for the final
`3.11.5 => 3.12` comparison identified in the April 2026 formalization report.
IUT III, Step `(xi-d)`, treats the final endpoint as a comparison of the
`Theta`-side upper ray and the `q`-side signed value in a common real setting.
Scholze-Stix's critique asks that this comparison not hide the real-line
identifications used to obtain it.

Milestone 49 showed that `ledger.corollary312` comes directly from the complete
audited chain. This milestone extends the same audit to the public
`Stage1Comparison.comparison` field.

### Purpose

This milestone adds:

```text
ledger.stage1Comparison.comparison
  =
corollary312_of_signed_le
  (le_trans ledger.membership.q_le_target
    (common target bound applied to ledger.chosenOutput.choice))
```

### Lean Declaration

In `SourceObligations.lean`:

```text
SourceObligationLedger.stage1Comparison_comparison_eq_membership_commonBound
```

The proof is `rfl`, so the exported Stage 1 comparison field is definitionally
the same proof obtained from the membership inequality and the chosen-output
instance of the common `Theta` bound.

### What This Tests

The public Stage 1 record now carries the same audited proof chain as the
internal ledger:

```text
membership.q_le_target
common bound on chosen output
corollary312_of_signed_le
stage1Comparison.comparison
```

This is useful for downstream users who consume only `Stage1Comparison`.

### Design Trap Avoided

The trap would be to finish the audit at the ledger API while leaving the
exported record opaque. This milestone keeps the public endpoint aligned with
the internal source-obligation proof path.

### Next Step

The next milestone should audit the `q_positive` proof in the same compact
style, tying the exported positivity field back to the ledger field and the
signed q-coordinate convention.

## Milestone 51: Q-Positivity Sign Transport

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The Stage 1 schema stores the signed q-value `qSigned` as a positive
`PilotLogVolume.value` by using:

```text
signedPilotLogVolume PilotSide.q qSigned
```

so the record field satisfies:

```text
stage1Comparison.q.value = -qSigned
```

IUT III, Step `(xi-d)`, uses signed log-volume expressions such as
`-|log(q)|`, so this sign convention is part of the final real-number audit.
Scholze-Stix's concern about explicit real-number identifications applies here
as well: the positivity proof should remain connected to the signed coordinate
that produced the stored positive magnitude.

### Purpose

This milestone adds two transport theorems for q-positivity:

```text
0 < ledger.stage1Comparison.q.value
0 < -qSigned
```

The first rewrites the Stage 1 q-value by
`stage1Comparison_q_value_eq_neg` and uses `ledger.q_positive`. The second goes
the other way, recovering `0 < -qSigned` from the exported
`stage1Comparison.q_positive` field.

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.stage1Comparison_q_positive_from_signed
SourceObligationLedger.q_positive_from_stage1Comparison
```

These are small rewrite theorems rather than new assumptions. They make the
existing positivity proof usable on either side of the signed q-value equality.

### What This Tests

The exported positivity field is now tied to:

```text
ledger.q_positive : 0 < -qSigned
ledger.stage1Comparison.q.value = -qSigned
```

so positivity cannot drift away from the signed q-coordinate convention.

### Design Trap Avoided

The trap would be to treat `q_positive` as a standalone condition on the
exported record while forgetting that it originates from the signed q-log-volume
coordinate. These rewrite theorems keep the sign convention visible.

### Next Step

The next milestone should audit the remaining certificate/common-container
alignment fields, starting with the SHE datum equality
`she_matches_certificate`.

## Milestone 52: SHE Certificate Alignment Projections

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

Mochizuki's April 2026 formalization report describes the final comparison as
occurring in a common container for the `Theta`-pilot and `q`-pilot data, with
`q` corresponding to the SHE side. The report also singles out the relationship
between input data and multiradial output data as part of the final Stage 1
interface.

At our abstraction level, the ledger records that the SHE datum inside the
common container is the same SHE datum carried by the structured certificate:

```text
chartedContainer.commonContainer.hddShe.sheArrow.datum = certificate.she
```

### Purpose

This milestone exposes the SHE/certificate alignment field:

```text
ledger.sheMatchesCertificate = ledger.she_matches_certificate

ledger.certificate.she
  = ledger.chartedContainer.commonContainer.hddShe.sheArrow.datum
```

The second theorem is the reverse orientation for rewriting from the certificate
back to the common-container datum.

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.sheMatchesCertificate_eq_field
SourceObligationLedger.certificateShe_eq_commonContainerSheDatum
```

The field-origin theorem is `rfl`; the reverse theorem is the symmetric form of
the stored `she_matches_certificate` proof.

### What This Tests

The common container's SHE side is now visibly tied to the structured
certificate in both directions:

```text
common-container SHE datum -> certificate SHE datum
certificate SHE datum -> common-container SHE datum
```

This begins the audit of the qualitative/certificate layer beneath the numeric
comparison chain.

### Design Trap Avoided

The trap would be to audit only the final real inequalities while allowing the
common container and certificate to drift apart. These projections keep the
source of the SHE data explicit.

### Next Step

The next milestone should expose the common-context equality as a named
composition of the common container's `she_context_matches` field and
`she_matches_certificate`.

## Milestone 53: Common-Context Alignment Projection

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The April 2026 formalization report describes the final comparison as taking
place in a common container for the `Theta`- and `q`-pilot data. It also
identifies the relationship between input data and multiradial output data as
part of the Stage 1 comparison interface. The common container must therefore
remain tied to the SHE datum recorded in the structured certificate.

Our `CommonContainerData` stores:

```text
hddShe.sheArrow.datum.sharedContext = context
```

and the source ledger stores:

```text
hddShe.sheArrow.datum = certificate.she
```

The common-context theorem composes these two facts.

### Purpose

This milestone exposes the proof shape of the context alignment:

```text
ledger.commonContextMatchesCertificate
  =
by
  rw [<- ledger.chartedContainer.commonContainer.she_context_matches]
  rw [ledger.she_matches_certificate]
```

and adds the reverse orientation:

```text
ledger.certificate.she.sharedContext
  = ledger.chartedContainer.commonContainer.context
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.commonContextMatchesCertificate_eq_sheAlignment
SourceObligationLedger.certificateContext_eq_commonContext
```

The first proof is `rfl`, verifying that the public theorem is definitionally
the advertised two-step rewrite. The second proof is the symmetric form of the
public context-alignment theorem.

### What This Tests

The qualitative layer now exposes:

```text
container SHE datum = certificate SHE datum
container context = certificate SHE sharedContext
```

with the second equality explicitly built from the first plus the container's
stored context equality.

### Design Trap Avoided

The trap would be to treat the common container's context as independent of the
certificate's SHE context. This milestone keeps the common-context alignment
auditable before any source-specific IUT construction replaces the current
abstraction.

### Next Step

The next milestone should audit the charted common container accessor
`thetaChartTrivial`, showing it is exactly the chart's recorded trivial
Theta-side transport.

## Milestone 54: Theta Chart Triviality Projection

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

Scholze-Stix's critique emphasizes that several ordered one-dimensional real
vector spaces occur and that the identifications among them must be explicit.
Our `RealComparisonChartData` records the q-side transport into the target
real line and also records the Theta-side transport, even though the Theta side
already lives on the target side:

```text
theta_trivial : Transport.TrivialMonodromy thetaToTarget
```

This mirrors the project policy of making real-line identifications explicit
rather than implicit.

### Purpose

This milestone exposes that the ledger's `thetaChartTrivial` accessor is
exactly the charted container's triviality theorem, and therefore exactly the
chart field:

```text
ledger.thetaChartTrivial = ledger.chartedContainer.thetaTrivial
ledger.thetaChartTrivial = ledger.chartedContainer.chart.theta_trivial
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.thetaChartTrivial_eq_chartedContainer
SourceObligationLedger.thetaChartTrivial_eq_chartField
```

Both proofs are `rfl`.

### What This Tests

The Theta-side chart triviality is now traceable through:

```text
RealComparisonChartData.theta_trivial
ChartedCommonContainerData.thetaTrivial
SourceObligationLedger.thetaChartTrivial
```

This keeps the target-side chart convention explicit.

### Design Trap Avoided

The trap would be to treat the Theta side as automatically identical with the
target real line and only record the q-side transport. The ledger now exposes
the explicit triviality proof, so even the "obvious" real-line identification is
auditable.

### Next Step

The next milestone should audit the common-container bridge/accessor layer:
`theta_commonBound` should be shown to come from applying the charted common
container to the structured certificate in source-specific ledgers, starting
with the toy ledger.

## Milestone 55: Toy Common-Bound Source Projection

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

The April 2026 formalization report describes the final `3.11.5 => 3.12`
comparison as taking place in a common container for the `Theta`- and
`q`-pilot data. IUT IV describes the `Theta` side through containers for
possible images and upper bounds. In the current Lean interface, the source of
such a bound is:

```text
ChartedCommonContainerData.apply certificate
```

The general source ledger stores `theta_commonBound` as an obligation. A
source-specific ledger should show how that obligation is produced.

### Purpose

This milestone adds toy-level projections showing that the toy ledger's
`theta_commonBound` field and public `thetaCommonBound` accessor are exactly
the charted common container applied to the toy structured certificate:

```text
ledger.theta_commonBound
  = ledger.chartedContainer.apply ledger.certificate

ledger.thetaCommonBound
  = ledger.chartedContainer.apply ledger.certificate
```

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_theta_commonBound_from_sourceObligations
unitThetaToy_thetaCommonBound_from_sourceObligations
```

Both proofs are `rfl`. Lean verifies that the toy source ledger discharges the
common `Theta` bound by the named toy charted common container and toy
structured certificate, not by an unrelated proof term.

### What This Tests

The toy right-side chain now has a source audit:

```text
thetaToyStructuredCertificate
thetaToyChartedCommonContainerData
chartedContainer.apply certificate
theta_commonBound
targetSigned <= thetaSigned
```

This is the first source-specific check underneath the general
`theta_commonBound` field.

### Design Trap Avoided

The trap would be to let the toy ledger fill `theta_commonBound` with an opaque
term while the general ledger only records that some common bound exists. This
projection keeps the toy witness visibly tied to the charted common container.

### Next Step

The next milestone should add analogous toy projections for the certificate and
charted common container fields themselves, confirming they are exactly the
named toy constructors.

## Milestone 56: Toy Certificate and Container Source Projections

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

The April 2026 formalization report describes the final comparison as involving
a common container for the `Theta`- and `q`-pilot data and emphasizes the
relationship between input data, multiradial output data, and the final
comparison. In the toy model, those qualitative inputs are represented by named
constructors:

```text
thetaToyStructuredCertificate
thetaToyChartedCommonContainerData
```

Milestone 55 showed that the toy common bound is obtained by applying the
charted common container to the certificate. This milestone records where those
two inputs come from.

### Purpose

This milestone adds toy-level field-origin projections:

```text
ledger.certificate
  = thetaToyStructuredCertificate unitQToTheta h epsilon

ledger.chartedContainer
  = thetaToyChartedCommonContainerData
      measure hnormalized unitQToTheta h hbound
```

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_certificate_from_sourceObligations
unitThetaToy_chartedContainer_from_sourceObligations
```

Both proofs are `rfl`, confirming that the toy source ledger uses the named toy
certificate and named toy charted common container directly.

### What This Tests

The toy common-bound source path now starts from named constructors:

```text
thetaToyStructuredCertificate
thetaToyChartedCommonContainerData
chartedContainer.apply certificate
theta_commonBound
```

This makes the toy source ledger easier to audit before replacing toy data with
genuine IUT constructions.

### Design Trap Avoided

The trap would be to expose the common-bound application while leaving the
certificate and container inputs opaque. These projections make the inputs
themselves transparent.

### Next Step

The next milestone should continue one level down and expose toy projections
for the charted container's `commonContainer` and `chart` subfields.

## Milestone 57: Toy Charted-Container Subfield Projections

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

The final comparison is organized around a common container and explicit
real-line chart. Mochizuki's April 2026 report describes the common container
aspect of the `q`- and `Theta`-pilot comparison, while Scholze-Stix's critique
emphasizes that the real-line identifications must be spelled out. The toy
charted common container has exactly these two pieces:

```text
commonContainer := thetaToyCommonContainerData ...
chart := thetaToyRealComparisonChartData ...
```

### Purpose

This milestone exposes the two subfields of the toy charted common container:

```text
ledger.chartedContainer.commonContainer
  = thetaToyCommonContainerData measure hnormalized unitQToTheta h hbound

ledger.chartedContainer.chart
  = thetaToyRealComparisonChartData measure unitQToTheta h epsilon
```

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_commonContainer_from_sourceObligations
unitThetaToy_realComparisonChart_from_sourceObligations
```

Both proofs are `rfl`.

### What This Tests

The toy source ledger now exposes the origin of:

```text
common container data
real comparison chart data
```

These are the two structural inputs underneath the toy charted common
container.

### Design Trap Avoided

The trap would be to name the charted common container but leave its internal
common-container and chart components opaque. These projections make both
components available to later audit the context, SHE, and real-line transport
subfields separately.

### Next Step

The next milestone should expose the toy real-comparison chart's q-transport
and Theta trivial transport fields, matching the general real-line audit hooks.

## Milestone 58: Toy Real-Comparison Chart Transport Projections

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

Scholze-Stix's critique emphasizes that all ordered real-line identifications
must be explicit before the final numerical comparison is meaningful. Our
general `RealComparisonChartData` records the q-side transport into the target
real line, the Theta-side transport, and a proof that the Theta-side transport
is trivial.

The toy chart instantiates this as:

```text
qToTarget := unitQToTheta
thetaToTarget := Transport.id thetaLine
theta_trivial := by rw [Transport.trivialMonodromy_iff_scale_eq_one]; rfl
```

### Purpose

This milestone exposes those toy chart fields through the source ledger:

```text
ledger.chartedContainer.chart.qToTarget = unitQToTheta
ledger.chartedContainer.chart.thetaToTarget = Transport.id thetaLine
ledger.chartedContainer.chart.theta_trivial = explicit identity proof
```

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_qToTarget_from_sourceObligations
unitThetaToy_thetaToTarget_from_sourceObligations
unitThetaToy_theta_trivial_from_sourceObligations
```

All three proofs are `rfl`.

### What This Tests

The toy real-line chart is now auditable through the ledger:

```text
q transport: unitQToTheta
Theta transport: identity
Theta triviality proof: identity-scale proof
```

This matches the general ledger's chart-triviality audit while also exposing
the concrete toy q-side transport.

### Design Trap Avoided

The trap would be to let the toy model inherit the general chart interface while
hiding the actual transport choices. These projections make the toy
identifications explicit.

### Next Step

The next milestone should expose the toy q-value and Theta-bound fields as
coming from the named toy q assignment and Theta endpoint.

## Milestone 59: Toy Q-Value and Theta-Endpoint Projections

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III's Step `(xi-d)` works with signed q- and Theta-side log-volume objects
after transport into a common ordered real setting. Scholze-Stix's criticism
puts pressure on exactly this point: the real-line identifications and the
origin of the compared numbers must be explicit enough that no hidden
identification can do mathematical work.

Our general source-obligation layer records this with `ChartedQValueData` and
`ChartedThetaBoundData`: each signed comparison datum keeps its source point or
endpoint alongside the signed real number and the proof relating the two.

### Purpose

This milestone exposes the corresponding toy fields through the source ledger:

```text
ledger.qValue.qPoint = qAssignment h
ledger.qValue.qSigned_eq = rfl
ledger.thetaBound.thetaPoint = point thetaLine (-(2 * h) + epsilonBound)
```

The toy q-point is therefore the named q assignment used by the toy bridge, and
the toy Theta endpoint is the upper endpoint determined by the effective
epsilon bound.

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_qPoint_from_sourceObligations
unitThetaToy_qSigned_eq_from_sourceObligations
unitThetaToy_thetaPoint_from_sourceObligations
```

All three proofs are definitional.

### What This Tests

The toy ledger now exposes the source objects underneath the signed numerical
comparison:

```text
q coordinate source: qAssignment h
Theta endpoint source: point thetaLine (-(2 * h) + epsilonBound)
```

This keeps the signed real numbers attached to their named source data before
later milestones audit the selected output and target-volume fields.

### Design Trap Avoided

The trap would be to let signed q- and Theta-side numbers become free real
numbers detached from their source points. That would make the toy comparison
look cleaner while losing the audit trail that matters for the IUT/Scholze-Stix
disagreement.

We do not restate the toy Theta signed-proof field here. Its readable proof
term depends on unfolding the full charted container, and the general projection
`SourceObligationLedger.thetaSigned_eq_chartedTheta_eq_field` already exposes
that field's origin without duplicating a brittle toy-specific proof term.

### Next Step

The next milestone should expose the toy chosen-output and target-volume
fields, showing that the selected output choice/comparison and target signed
value are the named toy choice and measured target volume.

## Milestone 60: Toy Chosen-Output and Target-Volume Projections

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Step `(xi-d)`, describes the multiradial construction algorithm as
yielding a collection of possibilities of output data and then applying
log-volume to regions associated to these possible outputs. This separates two
things that should remain separate in the formalization: the selected possible
output and the real number obtained by measuring its target-side region.

Scholze-Stix's discussion of Corollary 3.12 again stresses that meaningful
comparison requires consistent identifications of the real-line copies. In our
ledger, the selected output is therefore named before its target volume is
measured in the common chart.

### Purpose

This milestone exposes the toy selected-output and target-volume fields:

```text
ledger.chosenOutput.choice = choice
ledger.chosenOutput.comparison =
  (thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice
ledger.chosenOutput.comparison =
  thetaIndeterminacyComparison unitQToTheta h (epsilon choice)
ledger.chosenOutput.comparison_eq = rfl
ledger.targetVolume.targetSigned =
  RegionMeasure.targetVolume measure
    ((thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice)
ledger.targetVolume.targetSigned =
  RegionMeasure.targetVolume measure
    (thetaIndeterminacyComparison unitQToTheta h (epsilon choice))
ledger.targetVolume.targetSigned_eq = rfl
```

The additional `thetaIndeterminacyComparison` projections prevent the toy audit
from stopping at the generic algorithmic-output wrapper.

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_chosenChoice_from_sourceObligations
unitThetaToy_chosenComparison_from_sourceObligations
unitThetaToy_chosenThetaComparison_from_sourceObligations
unitThetaToy_chosenComparison_eq_from_sourceObligations
unitThetaToy_targetSigned_from_sourceObligations
unitThetaToy_targetSigned_thetaComparison_from_sourceObligations
unitThetaToy_targetSigned_eq_from_sourceObligations
```

All proofs are definitional.

### What This Tests

The toy ledger now records that the middle term in the comparison chain is not a
free real number. It is obtained by:

```text
choice
  -> thetaIndeterminacyComparison unitQToTheta h (epsilon choice)
  -> RegionMeasure.targetVolume measure ...
```

This mirrors the general `ChosenOutputData` and `ChartedTargetVolumeData`
boundary in `AlgorithmicBridge.lean`.

### Design Trap Avoided

The trap would be to conflate the selected possible output with the measured
target volume, or to let the measured target volume float without remembering
which possible output it came from. This is exactly the kind of bookkeeping that
must stay explicit when comparing q-side and Theta-side quantities.

### Next Step

The next milestone should expose the toy membership fields in terms of the
selected Theta indeterminacy comparison, not only through the already available
generic output comparison.

## Milestone 61: Toy Membership as Concrete Theta Indeterminacy

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Step `(xi-d)`, passes from possible output data to log-volume
comparison by measuring regions associated to those possible outputs. In the toy
model, the relevant possible output is the Theta indeterminacy upper ray

```text
thetaIndeterminacyComparison unitQToTheta h (epsilon choice)
```

rather than an unnamed target-side region. Scholze-Stix's objection to
Corollary 3.12 focuses on whether the identifications and comparisons of real
copies have been made explicitly enough. For this toy layer, the membership
proof must therefore be visible both as membership in the chosen comparison and
as the underlying coordinate inequality.

### Purpose

This milestone exposes the toy membership field at the concrete comparison
level:

```text
(thetaIndeterminacyComparison unitQToTheta h (epsilon choice)).Holds
  (qAssignment h)
```

and then unfolds that comparison to the coordinate condition:

```text
(Transport.map unitQToTheta (qAssignment h)).coord <=
  -(2 * h) + epsilon choice
```

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_membership_holds_thetaComparison_from_sourceObligations
unitThetaToy_membership_coord_le_choiceBound_from_sourceObligations
```

The first theorem projects the ledger membership proof into the concrete toy
Theta comparison. The second theorem uses that projection to expose the
upper-ray inequality directly.

### What This Tests

The ledger's membership field is now auditable at three levels:

```text
generic algorithmic output
selected thetaIndeterminacyComparison
transported q-coordinate <= selected upper-ray bound
```

This is deliberately redundant. The redundancy makes it harder for later code
to accidentally replace the concrete toy comparison by an unrelated measured
region.

### Design Trap Avoided

The trap would be to treat `membership.holds` as a proof of some abstract
membership proposition without checking which region it references. This
milestone ties it back to the selected Theta indeterminacy upper ray and the
actual transported q-coordinate.

### Next Step

The next milestone should expose the toy q-to-target inequality as both the
stored membership field and the elementary upper-ray/target-volume comparison
used to form the first leg of the three-term chain.

## Milestone 62: Toy Q-to-Target Volume First Leg

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Step `(xi-d)`, obtains comparable real quantities by applying
log-volume to the relevant output regions. In the toy model, this is represented
by the theorem

```text
thetaIndeterminacy_holds_iff_coord_le_targetVolume
```

which says that membership in a Theta indeterminacy upper ray is equivalent to
the transported q-coordinate being bounded by that region's measured target
volume. This is the elementary toy analogue of passing from membership in a
possible output region to the first numerical inequality in the comparison
chain.

### Purpose

This milestone exposes the first leg of the toy three-term chain:

```text
(Transport.map unitQToTheta (qAssignment h)).coord <=
  ledger.targetVolume.targetSigned
```

and the same inequality after unfolding the target volume to the selected Theta
indeterminacy comparison:

```text
(Transport.map unitQToTheta (qAssignment h)).coord <=
  RegionMeasure.targetVolume measure
    (thetaIndeterminacyComparison unitQToTheta h (epsilon choice))
```

It also records the independent route from concrete membership through
`thetaIndeterminacy_holds_iff_coord_le_targetVolume`.

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_qSigned_le_targetSigned_from_sourceObligations
unitThetaToy_qSigned_le_thetaTargetVolume_from_sourceObligations
unitThetaToy_qSigned_le_thetaTargetVolume_from_membership
```

### What This Tests

The toy source ledger's first numerical inequality is now visible in three
compatible forms:

```text
membership.q_le_target
qSigned <= ledger.targetVolume.targetSigned
qSigned <= measured volume of the selected thetaIndeterminacyComparison
```

The last theorem shows that the concrete inequality can also be recovered from
the membership theorem for upper rays, rather than only by projecting the stored
ledger field.

### Design Trap Avoided

The trap would be to use `membership.q_le_target` as a black-box inequality.
Here we keep the proof connected to the selected output region and to the
normalization theorem that turns upper-ray membership into a target-volume
comparison.

### Next Step

The next milestone should expose the second leg of the toy three-term chain:
the target volume of the selected output is bounded by the common Theta bound
coming from the charted common container.

## Milestone 63: Toy Target-to-Theta Second Leg

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Step `(xi-d)`, forms comparable real quantities by applying log-volume
to the possible output data and comparing those values with the common
Theta-side bound. In the toy formalization, the common bound is supplied by the
charted common container:

```text
thetaToyChartedCommonContainerData ...
```

and its choice-volume theorem says that the target volume of every selected
output is bounded by

```text
-(2 * h) + epsilonBound
```

This is the toy version of the second inequality in the three-term chain.

### Purpose

This milestone exposes the second leg of the toy source ledger:

```text
ledger.targetVolume.targetSigned <= -(2 * h) + epsilonBound
```

It also records that the same result is obtained directly from the charted
common container, and then unfolds the selected output to the concrete toy
comparison:

```text
RegionMeasure.targetVolume measure
  (thetaIndeterminacyComparison unitQToTheta h (epsilon choice))
  <= -(2 * h) + epsilonBound
```

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_targetSigned_le_thetaSigned_from_sourceObligations
unitThetaToy_targetSigned_le_thetaSigned_from_chartedContainer
unitThetaToy_choiceTargetVolume_le_thetaBound_from_sourceObligations
unitThetaToy_thetaTargetVolume_le_thetaBound_from_sourceObligations
```

### What This Tests

The toy ledger now exposes the second numerical comparison in three compatible
forms:

```text
targetSigned <= thetaSigned
choice target volume <= thetaSigned
selected thetaIndeterminacyComparison volume <= thetaSigned
```

The charted-container theorem makes the source of the upper bound explicit
instead of treating `target_le_theta` as an isolated arithmetic fact.

### Design Trap Avoided

The trap would be to let the second leg of the inequality appear as a free
assumption. This milestone ties it back to the charted common container and to
the concrete selected output region.

### Next Step

The next milestone should expose the composed toy q-to-Theta inequality as a
named transitive chain through the target-volume middle term.

## Milestone 64: Toy Q-to-Theta Transitive Chain

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

Corollary 3.12 is ultimately a comparison between signed q-side and Theta-side
real quantities. In the source-obligation formalization, we do not make that
comparison primitive. It is produced by composing two audited inequalities:

```text
qSigned <= targetSigned
targetSigned <= thetaSigned
```

This mirrors the role of the measured possible output as the middle term in the
toy version of IUT III, Step `(xi-d)`: first the q-pilot representation is
compared with the selected output region, then that selected output volume is
bounded by the common Theta bound.

### Purpose

This milestone exposes the composed toy inequality

```text
(Transport.map unitQToTheta (qAssignment h)).coord <=
  -(2 * h) + epsilonBound
```

in four compatible ways:

```text
ledger.qSigned_le_thetaSigned
ledger.threeTermComparison.q_le_theta
le_trans qSigned_le_targetSigned targetSigned_le_thetaSigned
le_trans qSigned_le_thetaTargetVolume thetaTargetVolume_le_thetaBound
```

The last form uses the concrete selected `thetaIndeterminacyComparison` volume
as the visible middle term.

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_qSigned_le_thetaSigned_from_sourceObligations
unitThetaToy_qSigned_le_thetaSigned_from_threeTerm
unitThetaToy_qSigned_le_thetaSigned_via_targetSigned
unitThetaToy_qSigned_le_thetaBound_via_thetaTargetVolume
```

### What This Tests

The toy final numerical inequality is no longer visible only as the endpoint of
the source ledger. The formalization now records its internal route:

```text
transported q-coordinate
  <= selected target volume
  <= common Theta endpoint
```

This is the exact place where later non-toy work must avoid collapsing labels or
real-line identifications.

### Design Trap Avoided

The trap would be to introduce the final q-to-Theta inequality as a direct
axiom. This milestone keeps it tied to the selected target-volume middle term
and to the two earlier audited legs.

### Next Step

The next milestone should expose the toy Corollary 3.12 proof itself as the
signed-pilot packaging of this transitive q-to-Theta chain.

## Milestone 65: Toy Corollary Packaging from the Q-to-Theta Chain

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

The signed form of Corollary 3.12 compares tagged q- and Theta-side
log-volume quantities. In our schema, this final step is deliberately separated
from the construction of the numerical inequality:

```text
corollary312_of_signed_le : qSigned <= thetaSigned -> Corollary312Inequality ...
```

This separation matters for the IUT/Scholze-Stix disagreement. The packaging
into signed pilot log-volumes should not hide where the inequality came from;
it should only tag the already-audited q- and Theta-side real numbers.

### Purpose

This milestone exposes the toy Corollary 3.12 proof as packaging of the
q-to-Theta chain:

```text
corollary312_of_signed_le qSigned_le_thetaSigned
```

and repeats the packaging for the three visible forms of the same chain:

```text
threeTermComparison.q_le_theta
le_trans qSigned_le_targetSigned targetSigned_le_thetaSigned
le_trans qSigned_le_thetaTargetVolume thetaTargetVolume_le_thetaBound
```

It also records that the source-ledger corollary field is definitionally the
same packaging of the ledger's q-to-Theta inequality.

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToyCorollary312_from_qThetaChain
unitThetaToyCorollary312_from_threeTermChain
unitThetaToyCorollary312_from_targetSignedChain
unitThetaToyCorollary312_from_thetaTargetVolumeChain
unitThetaToyCorollary312_eq_qThetaChain_from_sourceObligations
```

### What This Tests

The toy final Corollary 3.12 statement is now auditable as:

```text
explicit source obligations
  -> q <= target <= theta
  -> q <= theta
  -> signed-pilot Corollary312Inequality
```

This keeps the sign conversion and pilot-side tagging separate from the
mathematical construction of the real inequality.

### Design Trap Avoided

The trap would be to let `Corollary312Inequality` become a black-box endpoint.
This milestone shows that, in the toy source-obligation path, the corollary
proof is only `corollary312_of_signed_le` applied to the previously audited
chain.

### Next Step

The next milestone should expose the toy `Stage1Comparison` record as the same
signed-pilot packaging plus the q-positivity proof, again keeping the
comparison field tied to the q-to-Theta chain.

## Milestone 66: Toy Stage1Comparison Packaging

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

`Stage1Comparison` is the record form of the Corollary 3.12-shaped output. It
stores the tagged Theta and q pilot log-volumes, side-label proofs, positivity
of the q pilot magnitude, and the Corollary 3.12 comparison field.

This record should not introduce another mathematical comparison. In the toy
source-obligation path, its `comparison` field is the same signed-pilot
Corollary 3.12 packaging from the previous milestone, and its `q_positive` field
is the elementary positivity of the q-side pilot magnitude.

### Purpose

This milestone exposes the toy `Stage1Comparison` fields:

```text
theta = signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound)
q = signedPilotLogVolume PilotSide.q
      (Transport.map unitQToTheta (qAssignment h)).coord
theta.side = PilotSide.theta
q.side = PilotSide.q
0 < q.value
comparison = ledger.corollary312
comparison = corollary312_of_signed_le qSigned_le_thetaSigned
```

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToyStage1Comparison_theta_eq_signed_from_sourceObligations
unitThetaToyStage1Comparison_q_eq_signed_from_sourceObligations
unitThetaToyStage1Comparison_theta_side_from_sourceObligations
unitThetaToyStage1Comparison_q_side_from_sourceObligations
unitThetaToyStage1Comparison_q_positive_from_sourceObligations
unitThetaToyStage1Comparison_comparison_eq_corollary312_from_sourceObligations
unitThetaToyStage1Comparison_comparison_eq_qThetaChain
```

### What This Tests

The final toy `Stage1Comparison` record is now auditable field-by-field:

```text
signed pilot packaging
side labels
q positivity
corollary comparison from the q-to-Theta chain
```

This makes clear that `Stage1Comparison` is a packaging layer over the source
obligations rather than a new proof source.

### Design Trap Avoided

The trap would be to inspect only the final record type and lose the dependency
from its comparison field back to the two-leg q-to-target-to-Theta chain. These
projections keep the dependency visible.

### Next Step

The next milestone should expose the toy final comparison's recovered
Corollary 3.12 statement via `corollary312_from_stage1_comparison`, confirming
that unpacking the final record returns the same corollary proof.

## Milestone 67: Toy Stage1Comparison Corollary Recovery

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

The `Stage1Comparison` record is a packaging of the signed pilot data and the
Corollary 3.12 comparison. The recovery theorem

```text
corollary312_from_stage1_comparison
```

only projects the record's `comparison` field. For the source-obligation path,
we therefore want to verify that unpacking the final toy record recovers exactly
the same corollary proof already produced from the q-to-Theta chain.

### Purpose

This milestone exposes the final unpacking step:

```text
corollary312_from_stage1_comparison
  unitThetaToyStage1Comparison_from_sourceObligations
```

and proves that it is definitionally the same as:

```text
ledger.corollary312
corollary312_of_signed_le qSigned_le_thetaSigned
corollary312_of_signed_le threeTermComparison.q_le_theta
```

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToyStage1Comparison_recovers_corollary312
unitThetaToyStage1Comparison_recovers_qThetaChain
unitThetaToyStage1Comparison_recovers_threeTermChain
```

### What This Tests

The final public theorem can be read in either direction:

```text
source obligations -> Stage1Comparison -> recovered Corollary312Inequality
source obligations -> q-to-Theta chain -> Corollary312Inequality
```

Both paths are definitionally aligned in the toy model.

### Design Trap Avoided

The trap would be to let a final record-unpacking function obscure a different
or stronger proof than the one audited earlier. These projections show that
unpacking the record simply returns the existing comparison field.

### Next Step

The next milestone should start consolidating the toy source-obligation audit
into a named end-to-end theorem that states the complete dependency chain from
certificate, chart, membership, common bound, and signed packaging to the final
Stage 1 comparison.

## Milestone 68: Toy End-to-End Source-Obligation Audit

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

IUT III, Step `(xi-d)`, combines several logically distinct ingredients:
possible output data from the multiradial construction, comparison with the
q-pilot representation, common target-volume bounds, and signed log-volume
packaging. Scholze-Stix's critique warns that losing track of identifications or
silently replacing one comparison object by another is exactly where the proof
must be audited most carefully.

The toy model now has enough local projections to collect those ingredients in
one named audit statement.

### Purpose

This milestone introduces an end-to-end audit summary:

```text
UnitThetaToySourceObligationAudit
```

and proves:

```text
unitThetaToy_endToEndAudit_from_sourceObligations
```

The audit records the main dependency chain:

```text
source certificate and charted container
q and Theta source points
selected thetaIndeterminacyComparison
membership in the selected comparison
q <= selected target volume
selected target volume <= Theta bound
q <= Theta bound
Corollary312Inequality packaging
Stage1Comparison comparison/recovery fields
```

### Lean Declarations

In `ToySourceObligations.lean`:

```text
UnitThetaToySourceObligationAudit
unitThetaToy_endToEndAudit_from_sourceObligations
```

### What This Tests

The toy source-obligation path can now be consumed as a single named audit
object without hiding the individual proof obligations. Each field points back
to one of the previously audited projections, so the end-to-end theorem is a
summary of dependencies rather than a new shortcut.

### Design Trap Avoided

The trap would be to publish only the final toy `Stage1Comparison` theorem and
make a human reader reconstruct the dependency chain manually. This structure
keeps the full chain visible and mechanically checked.

### Next Step

The next milestone should decide whether to extend this audit-summary pattern
back to the general `SourceObligationLedger`, or to continue toy-side work by
exposing the same audit in a shorter public theorem suitable for examples and
future regression tests.

## Milestone 69: Toy Public Audit Theorem

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

The detailed audit record from Milestone 68 is useful for human inspection, but
examples and regression tests also need a compact public theorem. The public
statement should still keep the three essential checkpoints visible:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovers the same corollary packaging
```

This matches the formal strategy of keeping the final Corollary 3.12-shaped
output tied to the explicit q-to-target-to-Theta chain.

### Purpose

This milestone introduces:

```text
unitThetaToy_publicAudit_from_sourceObligations
```

It returns the compact conjunction:

```text
(Transport.map unitQToTheta (qAssignment h)).coord
  <= -(2 * h) + epsilonBound

Corollary312Inequality ...

corollary312_from_stage1_comparison
  unitThetaToyStage1Comparison_from_sourceObligations
  =
corollary312_of_signed_le
  unitThetaToy_qSigned_le_thetaSigned_from_sourceObligations
```

### Lean Declarations

In `ToySourceObligations.lean`:

```text
unitThetaToy_publicAudit_from_sourceObligations
```

### What This Tests

The theorem packages the practical end-to-end checks future examples will need
without hiding their source. Its proof pulls the q-to-Theta inequality and
corollary proof from `UnitThetaToySourceObligationAudit`, then uses the existing
Stage1Comparison recovery projection.

### Design Trap Avoided

The trap would be to make the public theorem a fresh direct proof. Instead, the
new theorem is only a small view of the detailed audit object.

### Next Step

The next milestone should extend the audit-summary pattern to the general
`SourceObligationLedger`, so non-toy source ledgers can expose the same
dependency checkpoints without relying on toy-specific names.

## Milestone 70: General Source-Obligation Audit Summary

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The toy audit summary should not remain toy-only. The central methodological
point is source-independent: a completed source-obligation ledger must expose
the charted q and Theta readings, the selected membership proof, both inequality
legs, the transitive q-to-Theta inequality, signed Corollary 3.12 packaging, and
the final `Stage1Comparison` recovery step.

This is also aligned with the Scholze-Stix pressure point: the ledger should
make real-line identifications and comparison dependencies inspectable before
any source-specific interpretation is accepted.

### Purpose

This milestone introduces the general audit summary:

```text
SourceObligationLedger.Audit
SourceObligationLedger.audit
```

The audit records:

```text
SHE datum matches certificate
common context matches certificate context
Theta chart is trivial
q and Theta signed values match charted source data
chosen comparison holds the q source point
q <= target
target <= theta
q <= theta
Corollary312Inequality packaging
Stage1Comparison comparison/recovery
normalization witness
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.Audit
SourceObligationLedger.audit
```

### What This Tests

Any future source-specific ledger can now expose the same dependency checklist
without adding a bespoke audit structure first. The toy audit remains richer
because it names toy-specific sources, but this general summary captures the
shared proof obligations.

### Design Trap Avoided

The trap would be to leave only toy-specific audit summaries and then let future
source-specific ledgers bypass the same bookkeeping. The general audit record
makes the expected checkpoints explicit at the common abstraction boundary.

### Next Step

The next milestone should add a compact general public-audit theorem analogous
to the toy public theorem, returning the q-to-Theta inequality, the signed
Corollary 3.12 statement, and the Stage1Comparison recovery equality from any
`SourceObligationLedger`.

## Milestone 71: General Public Audit Theorem

Lean file:

* `Iut/Stage1/SourceObligations.lean`

### Source Check

The general audit summary records many fields, but future source-specific
formalizations also need a compact target theorem analogous to the toy public
audit. The public theorem should expose exactly the common endpoint data:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovers the same corollary packaging
```

This keeps the final theorem small enough for examples while still tying it to
the audited source-obligation ledger.

### Purpose

This milestone introduces:

```text
SourceObligationLedger.publicAudit
```

For any completed ledger it returns:

```text
qSigned <= thetaSigned

Corollary312Inequality
  (signedPilotLogVolume PilotSide.theta thetaSigned)
  (signedPilotLogVolume PilotSide.q qSigned)

corollary312_from_stage1_comparison ledger.stage1Comparison
  =
corollary312_of_signed_le ledger.qSigned_le_thetaSigned
```

### Lean Declarations

In `SourceObligations.lean`:

```text
SourceObligationLedger.publicAudit
```

### What This Tests

The compact theorem is a small view over `SourceObligationLedger.audit`: it uses
the audited q-to-Theta inequality, the ledger's signed Corollary 3.12 proof, and
the definitional recovery of the same proof from the final `Stage1Comparison`.

### Design Trap Avoided

The trap would be to make each future source formalization invent its own final
public theorem, risking slightly different endpoints. This theorem fixes the
shared public endpoint once at the ledger abstraction boundary.

### Next Step

The next milestone should update the toy public audit theorem, if useful, to
factor through the new general `SourceObligationLedger.publicAudit` theorem, so
the toy and general public endpoints stay aligned.

## Milestone 72: Toy Public Audit via the General Ledger Theorem

Lean file:

* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

After introducing `SourceObligationLedger.publicAudit`, the toy public audit
should not remain an independent proof of the same endpoint. The toy theorem
should be a specialization of the general ledger theorem, with only the
toy-specific names unfolded.

This keeps the toy model useful as a concrete example while ensuring it tests
the same public abstraction that future non-toy source ledgers will use.

### Purpose

This milestone refactors:

```text
unitThetaToy_publicAudit_from_sourceObligations
```

so that its proof is obtained from:

```text
(unitThetaToySourceObligationLedger ...).publicAudit
```

with only definitional unfolding of:

```text
unitThetaToyStage1Comparison_from_sourceObligations
unitThetaToy_qSigned_le_thetaSigned_from_sourceObligations
```

### Lean Declarations

No new declaration is introduced. The existing theorem

```text
unitThetaToy_publicAudit_from_sourceObligations
```

now factors through the general source-ledger public audit.

### What This Tests

The toy public theorem and the source-agnostic public theorem now have the same
proof path. The toy layer no longer carries a separate public-audit proof that
could drift from the general abstraction.

### Design Trap Avoided

The trap would be to maintain two parallel public endpoints: one toy-specific
and one general. This refactor makes the toy endpoint a regression test for the
general API.

### Next Step

The next milestone should look for the next abstraction boundary above Stage 1:
either a small example module that imports the public toy theorem as a
regression test, or the first non-toy scaffold that will eventually supply a
real source-specific `SourceObligationLedger`.

## Milestone 73: Toy Public Audit Regression Examples

Lean files:

* `Iut/Stage1/ToyPublicAuditExample.lean`
* `Iut/Basic.lean`

### Source Check

At this stage the formal work is still a scaffold, so regression examples are
important. They ensure that the public theorem can be used without reaching into
the detailed toy source ledger or the full audit record.

This matches the project discipline around Corollary 3.12: public consumers
should use named, audited interfaces rather than reconstructing hidden
identifications manually.

### Purpose

This milestone adds a small example module that imports:

```text
Iut.Stage1.ToySourceObligations
```

and recovers the three endpoints of the toy public audit theorem:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovery equality
```

The root module `Iut/Basic.lean` imports the example, so `lake build` checks it
with the rest of the project.

### Lean Declarations

In `ToyPublicAuditExample.lean`:

```text
unitThetaToy_publicAudit_q_le_theta_example
unitThetaToy_publicAudit_corollary_example
unitThetaToy_publicAudit_recovery_example
```

### What This Tests

The examples destruct only:

```text
unitThetaToy_publicAudit_from_sourceObligations
```

They do not inspect `UnitThetaToySourceObligationAudit` or the internal ledger
fields. This makes the public theorem an actual API boundary.

### Design Trap Avoided

The trap would be to prove examples by reaching back into all internal fields,
which would make the public theorem ornamental rather than useful. These
examples verify that the compact public theorem is sufficient for downstream
use.

### Next Step

The next milestone should begin the first non-toy source-ledger scaffold: a
named placeholder interface for future IUT-specific data that can eventually
produce a `SourceObligationLedger` without changing the Stage 1 public API.

## Milestone 74: Non-Toy IUT Source Provider Scaffold

Lean files:

* `Iut/Stage1/IUTSourceScaffold.lean`
* `Iut/Basic.lean`

### Source Check

Mochizuki's formalization progress report describes Stage 1 as the passage from
IUT III, Theorem 3.11 to Corollary 3.12, with skeletal Lean code intended to
clarify the logical structure. IUT III, Step `(xi-d)`, points to the same
ingredients we have been auditing: multiradial output data, IPL/SHE linkage,
log-volume comparison, and signed Corollary 3.12 packaging.

The non-toy scaffold must therefore avoid pretending that these ingredients have
already been formalized. It should only state the interface future IUT-specific
modules must satisfy.

### Purpose

This milestone introduces:

```text
IUTSourceObligationProvider
```

The provider has one substantive field:

```text
ledger : SourceObligationLedger ...
```

From that ledger, the module exposes:

```text
audit
qSigned_le_thetaSigned
corollary312
stage1Comparison
publicAudit
stage1Comparison_recovers_corollary312
hasNormalization
```

### Lean Declarations

In `IUTSourceScaffold.lean`:

```text
IUTSourceObligationProvider
IUTSourceObligationProvider.audit
IUTSourceObligationProvider.qSigned_le_thetaSigned
IUTSourceObligationProvider.corollary312
IUTSourceObligationProvider.stage1Comparison
IUTSourceObligationProvider.publicAudit
IUTSourceObligationProvider.stage1Comparison_recovers_corollary312
IUTSourceObligationProvider.hasNormalization
```

The root module imports this scaffold.

### What This Tests

The first non-toy interface is now in place without adding any unproved IUT
claim. A future IUT-specific construction must produce the same
`SourceObligationLedger` that the toy model produces, and then receives only the
general audited endpoint.

### Design Trap Avoided

The trap would be to introduce a named "IUT provider" that directly asserts
Corollary 3.12. This scaffold instead makes the ledger the sole proof boundary.

### Next Step

The next milestone should add regression examples for
`IUTSourceObligationProvider` using the toy ledger as an instance, verifying that
the non-toy scaffold consumes a ledger through the same public audit API.

## Milestone 75: IUT Source Provider Regression Examples

Lean files:

* `Iut/Stage1/IUTSourceScaffoldExample.lean`
* `Iut/Basic.lean`

### Source Check

The provider scaffold is intentionally source-agnostic. Before moving toward
more IUT-specific data, we need a regression check showing that an existing
ledger can be wrapped as a provider and consumed only through the provider API.

The toy ledger is a convenient sample because it already supplies all source
obligations without asserting any non-toy IUT mathematics.

### Purpose

This milestone introduces:

```text
unitThetaToyIUTSourceProvider
```

which wraps the toy source-obligation ledger as an
`IUTSourceObligationProvider`. It then proves examples through the provider API:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovers ledger.corollary312
```

### Lean Declarations

In `IUTSourceScaffoldExample.lean`:

```text
unitThetaToyIUTSourceProvider
unitThetaToy_provider_publicAudit_q_le_theta_example
unitThetaToy_provider_publicAudit_corollary_example
unitThetaToy_provider_stage_recovers_corollary_example
```

The root module imports the example.

### What This Tests

The non-toy scaffold can consume a completed ledger through the same public
audit API as future source-specific providers. The examples do not inspect the
toy audit record directly.

### Design Trap Avoided

The trap would be to create a provider interface that is not exercised anywhere.
These examples make the provider API concrete while keeping the toy ledger as
sample data, not as a substitute for future IUT source obligations.

### Next Step

The next milestone should introduce the first named placeholder interface for
IUT-specific Stage 1 input/output data, separating labels such as IPL, SHE,
multiradial output, and charted log-volume data before any attempt to construct
a full `SourceObligationLedger`.

## Milestone 76: IUT Stage 1 Pre-Ledger Data

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Basic.lean`

### Source Check

IUT III, Step `(xi-d)`, uses multiradial output data, IPL/SHE linkage, and
log-volume comparisons before arriving at the final Corollary 3.12 inequality.
Mochizuki's formalization progress report also emphasizes that Lean should make
the logical structure communicable, not merely verify a final endpoint.

This milestone therefore introduces a pre-ledger layer. It records named
source-side data before asserting that all obligations needed for a
`SourceObligationLedger` have been discharged.

### Purpose

This milestone adds inert identifiers:

```text
Stage1InputId
MultiradialOutputId
LogVolumeComparisonId
```

and the pre-ledger structure:

```text
IUTStage1PreLedgerData
```

The structure separates:

```text
input label
multiradial output label
log-volume comparison label
algorithmic output
measure, signed q/Theta reals, normalization proposition
structured IPL/SHE/APT certificate
charted common container
charted q and Theta values
chosen output and target volume
membership data
```

### Lean Declarations

In `IUTStage1Data.lean`:

```text
Stage1InputId
MultiradialOutputId
LogVolumeComparisonId
IUTStage1PreLedgerData
IUTStage1PreLedgerData.hasStructuredIPL
IUTStage1PreLedgerData.hasStructuredSHE
IUTStage1PreLedgerData.hasStructuredAPT
IUTStage1PreLedgerData.thetaChartTrivial
IUTStage1PreLedgerData.qSigned_eq_chartedQ
IUTStage1PreLedgerData.thetaSigned_eq_chartedTheta
IUTStage1PreLedgerData.chosenComparisonHoldsQ
IUTStage1PreLedgerData.qSigned_le_targetSigned
IUTStage1PreLedgerData.targetSigned_eq_choiceTargetVolume
IUTStage1PreLedgerData.choiceTargetVolume_le_thetaSigned
IUTStage1PreLedgerData.targetSigned_le_thetaSigned
IUTStage1PreLedgerData.Audit
IUTStage1PreLedgerData.audit
```

### What This Tests

The pre-ledger layer can already audit structured family-level IPL/SHE/APT
witnesses, charted q/Theta readings, chosen membership, and the two numerical
legs available from the charted container. But it does not claim to be a
`SourceObligationLedger`.

Lean forced an important distinction here: a
`QualitativeData.StructuredCertificate output.family` gives structured witnesses
for the transported family; it does not automatically prove the opaque
propositions `output.HasIPL`, `output.HasSHE`, or `output.HasAPT`. We keep the
pre-ledger audit at the structured-family level.

### Design Trap Avoided

The trap would be to identify structured witness data with the opaque
algorithmic-output certification propositions without an explicit bridge. This
would hide a source-specific obligation. The new pre-ledger layer keeps that
gap visible.

### Next Step

The next milestone should add a controlled promotion interface from
`IUTStage1PreLedgerData` to `SourceObligationLedger`, listing exactly the
remaining obligations: opaque output certification alignment, SHE/certificate
alignment, q-positivity, and normalization evidence.

## Milestone 77: Controlled Promotion from Pre-Ledger Data

Lean file:

* `Iut/Stage1/IUTStage1Data.lean`

### Source Check

The pre-ledger data from Milestone 76 records structured source information, but
it should not become a full `SourceObligationLedger` by definitional accident.
The missing ingredients are precisely the obligations that a future
source-specific formalization must discharge.

This matches the IUT Stage 1 discipline: qualitative labels such as IPL/SHE and
multiradial output are not enough by themselves; one must also supply the
alignment and positivity/normalization data needed by the final comparison.

### Purpose

This milestone introduces:

```text
IUTStage1PreLedgerData.LedgerPromotionObligations
```

with fields:

```text
certified : data.output.Certified
she_matches_certificate :
  data.chartedContainer.commonContainer.hddShe.sheArrow.datum =
    data.certificate.she
q_positive : 0 < -data.qSigned
normalization_proof : data.normalization
```

It then defines:

```text
IUTStage1PreLedgerData.toSourceObligationLedger
IUTStage1PreLedgerData.toSourceObligationProvider
```

and exposes audit/public-audit projections for the promoted data.

### Lean Declarations

In `IUTStage1Data.lean`:

```text
IUTStage1PreLedgerData.LedgerPromotionObligations
IUTStage1PreLedgerData.toSourceObligationLedger
IUTStage1PreLedgerData.toSourceObligationProvider
IUTStage1PreLedgerData.toSourceObligationLedger_audit
IUTStage1PreLedgerData.toSourceObligationProvider_publicAudit
```

### What This Tests

Promotion from pre-ledger data to the public Stage 1 endpoint now has an
explicit proof boundary. The structured certificate remains distinct from
`data.output.Certified`; the promotion obligation must supply that opaque
certification separately.

### Design Trap Avoided

The trap would be to silently convert pre-ledger bookkeeping into a full source
ledger. This milestone forces the remaining obligations to be named and supplied
explicitly.

### Next Step

The next milestone should add a toy regression example for this promotion path:
package the existing toy ledger ingredients as `IUTStage1PreLedgerData`, supply
the promotion obligations, and verify that the promoted provider reaches the
same public endpoint.

## Milestone 78: Toy Pre-Ledger Promotion Examples

Lean files:

* `Iut/Stage1/IUTStage1DataExample.lean`
* `Iut/Basic.lean`

### Source Check

The controlled promotion path from Milestone 77 should be exercised before it
is used for future non-toy work. The toy model already has enough data to test
the full path without asserting any new IUT mathematics.

This regression example packages the toy source data as pre-ledger data, supplies
the explicit promotion obligations, promotes to a provider, and checks the
public Stage 1 endpoint.

### Purpose

This milestone introduces:

```text
unitThetaToyPreLedgerData
unitThetaToyPromotionObligations
unitThetaToyPromotedProvider
```

and verifies through the promoted provider:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovers ledger.corollary312
```

### Lean Declarations

In `IUTStage1DataExample.lean`:

```text
unitThetaToyStage1Input
unitThetaToyMultiradialOutput
unitThetaToyLogVolumeComparison
unitThetaToyPreLedgerData
unitThetaToyPromotionObligations
unitThetaToyPromotedProvider
unitThetaToy_promotedProvider_publicAudit_q_le_theta_example
unitThetaToy_promotedProvider_publicAudit_corollary_example
unitThetaToy_promotedProvider_recovers_corollary_example
```

The root module imports the example.

### What This Tests

The example exercises the entire chain:

```text
toy source ingredients
  -> IUTStage1PreLedgerData
  -> LedgerPromotionObligations
  -> SourceObligationLedger
  -> IUTSourceObligationProvider
  -> public audit endpoint
```

The q-positivity proof remains a separate promotion obligation, exactly as in
the non-toy interface.

### Design Trap Avoided

The trap would be to test only direct toy ledgers and never test the new
pre-ledger promotion boundary. This milestone verifies that the boundary is
usable and that the explicit obligations are sufficient.

### Next Step

The next milestone should add a short public regression theorem over the
pre-ledger promotion path itself, analogous to the provider public audit theorem,
so future source-specific pre-ledger data can target one compact endpoint.

## Milestone 79: Pre-Ledger Public Audit Theorem

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`

### Source Check

The pre-ledger promotion path should expose a compact endpoint of its own. A
future source-specific module should be able to construct pre-ledger data, supply
promotion obligations, and then target a single public theorem, without manually
unfolding the promoted provider.

This keeps the same proof discipline as the provider layer: compact public
endpoints are views over explicit obligations, not independent proof shortcuts.

### Purpose

This milestone adds:

```text
IUTStage1PreLedgerData.publicAudit
```

It returns the same compact endpoint as the provider public audit:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovery equality
```

for any pre-ledger data and explicit promotion obligations.

### Lean Declarations

In `IUTStage1Data.lean`:

```text
IUTStage1PreLedgerData.publicAudit
```

In `IUTStage1DataExample.lean`:

```text
unitThetaToy_preLedger_publicAudit_q_le_theta_example
```

### What This Tests

The theorem is a direct view over:

```text
IUTStage1PreLedgerData.toSourceObligationProvider_publicAudit
```

The toy regression example proves that downstream users can consume pre-ledger
data through this compact theorem.

### Design Trap Avoided

The trap would be to require source-specific modules to manually navigate
promotion to the provider every time they want the public endpoint. This theorem
fixes the pre-ledger public API while preserving the explicit promotion
obligations.

### Next Step

The next milestone should expose additional toy examples for the pre-ledger
public theorem's Corollary 3.12 and recovery components, so all three public
endpoint projections are covered at the pre-ledger layer.

## Milestone 80: Complete Toy Pre-Ledger Public Audit Examples

Lean file:

* `Iut/Stage1/IUTStage1DataExample.lean`

### Source Check

Milestone 79 added the compact pre-ledger public audit theorem and one toy
example for the q-to-Theta inequality. The public theorem has three endpoint
components, so the example layer should cover all three.

This is a regression concern rather than a new mathematical claim.

### Purpose

This milestone adds toy examples for the remaining two pre-ledger public audit
components:

```text
Corollary312Inequality
Stage1Comparison recovery equality
```

### Lean Declarations

In `IUTStage1DataExample.lean`:

```text
unitThetaToy_preLedger_publicAudit_corollary_example
unitThetaToy_preLedger_publicAudit_recovery_example
```

### What This Tests

All three projections of

```text
IUTStage1PreLedgerData.publicAudit
```

are now exercised by toy examples:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovery equality
```

### Design Trap Avoided

The trap would be to test only the first projection of a nested public theorem,
leaving the Corollary and recovery fields unexercised. This milestone closes
that example coverage gap.

### Next Step

The next milestone should move from examples back to the interface itself:
add named projections for `IUTStage1PreLedgerData.publicAudit`, so users do not
need to destruct nested conjunctions manually.

## Milestone 81: Named Pre-Ledger Public Audit Projections

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`

### Source Check

The Stage 1 scaffold is still only a formal interface for the source-obligation
path into the Corollary 3.12-shaped endpoint. The source pressure remains the
same as in the previous milestones: comparisons should be passed through
explicit named obligations, so that no hidden real-line identification or
informal simplification enters through API convenience.

This milestone is therefore an interface refinement, not a new mathematical
assertion.

### Purpose

Milestone 80 showed that all three components of the pre-ledger public audit
can be consumed by destructing the nested conjunction returned by:

```text
IUTStage1PreLedgerData.publicAudit
```

This milestone gives those components names at the pre-ledger boundary:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovery equality
```

The goal is readability for future source-specific modules. A human reader
should see which endpoint is being used without decoding tuple projections such
as `.1`, `.2.1`, or `.2.2`.

### Lean Declarations

In `IUTStage1Data.lean`:

```text
IUTStage1PreLedgerData.publicAudit_qSigned_le_thetaSigned
IUTStage1PreLedgerData.publicAudit_corollary312
IUTStage1PreLedgerData.publicAudit_stage1Comparison_recovers_qSigned_le_thetaSigned
```

In `IUTStage1DataExample.lean`, the three toy pre-ledger public audit examples
now use these named projections instead of destructing the public theorem
directly.

### What This Tests

The examples verify that the named projections have the same usable endpoint
types as the previous tuple destructors:

```text
unitThetaToy_preLedger_publicAudit_q_le_theta_example
unitThetaToy_preLedger_publicAudit_corollary_example
unitThetaToy_preLedger_publicAudit_recovery_example
```

### Design Trap Avoided

The trap would be to let downstream source-specific code depend on the exact
nesting shape of a conjunction. That is brittle and makes the formal argument
harder to read. Named projections keep the API stable while preserving the fact
that all three endpoints are still derived from the same explicit promotion
obligations.

### Next Step

The next milestone should introduce a named pre-ledger recovery theorem whose
right-hand side is the promoted ledger's `corollary312` field itself, parallel
to `IUTSourceObligationProvider.stage1Comparison_recovers_corollary312`.

## Milestone 82: Pre-Ledger Recovery to Promoted Corollary Field

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`

### Source Check

The public audit equality in Milestone 81 targets the constructed proof:

```text
corollary312_of_signed_le ...qSigned_le_thetaSigned
```

The provider layer also has a more structural theorem saying that the
`Stage1Comparison` projection recovers the promoted ledger's named
`corollary312` field. Keeping both views matters because future source-specific
formalization should be able to audit either the explicit q-to-Theta proof path
or the named ledger field without changing the underlying argument.

This remains an API-alignment milestone. It does not assert any new IUT
mathematics beyond the already promoted source-obligation ledger.

### Purpose

This milestone adds the pre-ledger analogue of:

```text
IUTSourceObligationProvider.stage1Comparison_recovers_corollary312
```

The theorem is parameterized by the explicit promotion obligations, so the
pre-ledger data still cannot claim the promoted Corollary 3.12 endpoint until
the missing source obligations have been supplied.

### Lean Declarations

In `IUTStage1Data.lean`:

```text
IUTStage1PreLedgerData.stage1Comparison_recovers_corollary312
```

In `IUTStage1DataExample.lean`:

```text
unitThetaToy_preLedger_stage_recovers_corollary_example
```

### What This Tests

The toy example verifies that the pre-ledger data, once promoted, has the same
ledger-field recovery shape as the provider layer:

```text
corollary312_from_stage1_comparison promoted.stage1Comparison
  = promoted.ledger.corollary312
```

### Design Trap Avoided

The trap would be to expose only the normalized public-audit equality to
`corollary312_of_signed_le`. That is useful, but it hides the ledger field that
future source modules are likely to discuss by name. This theorem keeps the
formal API closer to the mathematical prose while still routing through the
explicit promoted provider.

### Next Step

The next milestone should add named accessors for the promoted provider and
ledger produced by a pre-ledger package, if that makes subsequent source
placeholder modules easier to state without repeating promotion expressions.

## Milestone 83: Named Promoted Pre-Ledger Accessors

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`

### Source Check

Milestones 77-82 deliberately kept promotion from pre-ledger data to a full
source-obligation ledger explicit. That remains essential: source-specific IUT
data should not be treated as a completed Corollary 3.12 proof until the
promotion obligations have been supplied.

At the same time, future modules need readable names for the promoted objects
once those obligations are present. This milestone adds those names without
changing the promotion boundary.

### Purpose

This milestone introduces named accessors for the two objects produced from
pre-ledger data plus explicit promotion obligations:

```text
promotedLedger
promotedProvider
```

They are definitional wrappers around the existing controlled constructors:

```text
toSourceObligationLedger
toSourceObligationProvider
```

### Lean Declarations

In `IUTStage1Data.lean`:

```text
IUTStage1PreLedgerData.promotedLedger
IUTStage1PreLedgerData.promotedProvider
IUTStage1PreLedgerData.promotedProvider_ledger
```

In `IUTStage1DataExample.lean`:

```text
unitThetaToy_preLedger_promotedProvider_eq_example
unitThetaToy_preLedger_promotedProvider_ledger_example
```

### What This Tests

The toy examples verify that the new names do not create a second promotion
path. They are definitionally the same promoted provider/ledger already used by
the examples.

### Design Trap Avoided

The trap would be to introduce a "convenient" source-specific provider that
silently manufactures the missing source obligations. These accessors still
require `LedgerPromotionObligations`; they only make the resulting promoted
objects easier to name and audit.

### Next Step

The next milestone should start a first non-toy source placeholder module that
packages named IUT Stage 1 pre-ledger labels and states, without proof, the
specific promotion obligations that future source mathematics must discharge.

## Milestone 84: First Non-Toy IUT Stage 1 Source Package

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Basic.lean`
* `README.md`

### Source Check

The local IUT III text states Corollary 3.12 under the situation of Theorem
3.11. In Step `(xi-b)`, Mochizuki says that, for the final discussion, the
multiradial construction may be treated qualitatively as "some" algorithm whose
output satisfies IPL, SHE, and APT. Step `(xi-d)` then adds the holomorphic hull,
determinant, and log-volume passage that makes the q-pilot and Theta-pilot
objects comparable in a common real-valued setting.

The April 2026 formalization report describes this same first target as Stage
1: Theorem 3.11 implies Corollary 3.12, with the skeletal code currently focused
on the final `3.11.5 => 3.12` comparison.

Scholze-Stix remain the guardrail for this milestone: a source-facing package
must not make the comparison automatic by silently identifying all histories or
real-line copies.

### Purpose

This milestone starts the first non-toy source-facing module:

```text
Iut.Stage1.IUTStage1Source
```

It introduces inert source labels for:

```text
Theta-pilot object
q-pilot object
log-Kummer correspondence
Ind1-Ind2-Ind3 profile
```

and packages them with an existing `IUTStage1PreLedgerData` value. The package
does not prove the source obligations. It only states the exact promotion
obligations that future IUT-specific mathematics must provide before the public
Stage 1 endpoint is available.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
PilotObjectId
LogKummerCorrespondenceId
IndeterminacyProfileId
IUTStage1SourceLabels
theorem311ToCorollary312Labels
IUTStage1SourcePackage
IUTStage1SourceObligations
IUTStage1SourceObligations.toLedgerPromotionObligations
IUTStage1SourcePackage.promotedLedger
IUTStage1SourcePackage.promotedProvider
IUTStage1SourcePackage.promotedProvider_ledger
IUTStage1SourcePackage.publicAudit
```

The root module `Iut.Basic` now imports `Iut.Stage1.IUTStage1Source`, and the
README module list records the new non-toy source-facing layer.

### What This Tests

Lean verifies that a source-facing package can expose the public audit theorem
only after converting explicitly supplied `IUTStage1SourceObligations` into the
existing `IUTStage1PreLedgerData.LedgerPromotionObligations`.

The route is:

```text
IUTStage1SourcePackage
  + IUTStage1SourceObligations
  -> IUTStage1PreLedgerData.LedgerPromotionObligations
  -> promoted provider
  -> public Stage 1 audit
```

### Design Trap Avoided

The trap would be to introduce a non-toy IUT module that simply asserts a
completed source provider. This milestone refuses that shortcut: the source
package is inert until the future source proof supplies certification, SHE
alignment, q-pilot positivity, and normalization.

### Next Step

The next milestone should add source-facing named projections for the four
obligation fields, so future formalization notes can refer to these obligations
without unpacking the source-obligation structure manually.

## Milestone 85: Source-Facing Obligation Projections

Lean file:

* `Iut/Stage1/IUTStage1Source.lean`

### Source Check

Milestone 84 introduced a non-toy source package, but the package still becomes
mathematically useful only after four explicit promotion obligations are
supplied. These obligations correspond to the formal boundary between the
qualitative Theorem 3.11 data and the completed source-obligation ledger used
for the Corollary 3.12 endpoint.

The source discipline is unchanged: the final comparison should not be available
merely because the source labels have been named.

### Purpose

This milestone adds named projection theorems for the four source-facing
obligations:

```text
algorithm certification
SHE arrow/certificate alignment
q-pilot positivity
normalization
```

The conversion to `IUTStage1PreLedgerData.LedgerPromotionObligations` now uses
these named projections, making the source-facing dependency list explicit.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourceObligations.algorithmCertified
IUTStage1SourceObligations.sheArrowMatchesCertificate
IUTStage1SourceObligations.qPilotPositive
IUTStage1SourceObligations.sourceNormalization
```

### What This Tests

Lean verifies that the source-facing obligation record projects exactly the
fields needed by the pre-ledger promotion API. No projection constructs new
mathematical content; each is a named view of an explicitly supplied field.

### Design Trap Avoided

The trap would be to hide the obligation conversion inside a record constructor.
By naming the projections, later source modules can cite the exact remaining
proof tasks without relying on positional structure fields.

### Next Step

The next milestone should add source-facing public-audit projection theorems
parallel to the pre-ledger public-audit projections, using
`IUTStage1SourcePackage.publicAudit` as the only route to the endpoint.

## Milestone 86: Source-Facing Public Audit Projections

Lean file:

* `Iut/Stage1/IUTStage1Source.lean`

### Source Check

The source-facing package now has an explicit theorem:

```text
IUTStage1SourcePackage.publicAudit
```

This theorem is available only after `IUTStage1SourceObligations` are supplied.
That matches the intended Stage 1 boundary: source labels and qualitative
Theorem 3.11 data do not themselves produce the Corollary 3.12-shaped endpoint.

### Purpose

This milestone exposes the three public endpoint components under source-facing
names:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovery equality
```

They are direct projections from `IUTStage1SourcePackage.publicAudit`.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.publicAudit_qSigned_le_thetaSigned
IUTStage1SourcePackage.publicAudit_corollary312
IUTStage1SourcePackage.publicAudit_stage1Comparison_recovers_qSigned_le_thetaSigned
```

### What This Tests

Lean verifies that the source-facing package has the same endpoint projection
shape as the pre-ledger API, but still requires source-facing obligations before
any projection can be used.

### Design Trap Avoided

The trap would be to let a future source module bypass the public-audit theorem
and independently assemble endpoint components. These projections keep the API
readable while forcing all three endpoints through the same obligation-gated
route.

### Next Step

The next milestone should add a source-facing recovery theorem to the promoted
ledger's `corollary312` field, parallel to the pre-ledger and provider recovery
theorems.

## Milestone 87: Source-Facing Recovery to Promoted Corollary Field

Lean file:

* `Iut/Stage1/IUTStage1Source.lean`

### Source Check

Milestone 86 exposed the public audit endpoints for a source package after the
source obligations are supplied. The provider and pre-ledger layers also expose
a structural recovery theorem saying that the `Stage1Comparison` projection
recovers the promoted ledger's named `corollary312` field.

This milestone adds the same shape at the source-facing package boundary. It is
not a new source proof; it is the same promoted-provider recovery theorem viewed
through the source package.

### Purpose

This milestone gives future source modules a readable theorem for the structural
recovery statement:

```text
corollary312_from_stage1_comparison promoted.stage1Comparison
  = promoted.ledger.corollary312
```

The theorem still requires explicit `IUTStage1SourceObligations`.

### Lean Declaration

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.stage1Comparison_recovers_corollary312
```

### What This Tests

Lean verifies that the source-facing package can use the same recovery theorem
as the promoted provider, with no alternate proof path and no implicit discharge
of the source obligations.

### Design Trap Avoided

The trap would be to discuss the promoted ledger's `corollary312` field in
source-facing prose while the Lean API only exposed the normalized public-audit
equality to `corollary312_of_signed_le`. This theorem keeps both views available
and obligation-gated.

### Next Step

The next milestone should add a small source-package example module that
specializes the generic source package to the existing toy pre-ledger data, so
the non-toy source-facing API is regression-tested against a concrete promoted
path without claiming toy data is genuine IUT data.

## Milestone 88: Toy-Backed Source Package Regression Examples

Lean files:

* `Iut/Stage1/IUTStage1SourceExample.lean`
* `Iut/Basic.lean`
* `README.md`

### Source Check

The non-toy source package from Milestones 84-87 is intentionally abstract. To
avoid mistaking that abstraction for mathematical progress on IUT itself, this
milestone tests the API using the existing toy pre-ledger data only as a
regression source.

This follows the project discipline used throughout the Stage 1 scaffold:
examples may verify API shape, but they must not be described as evidence that
the IUT source mathematics has been formalized.

### Purpose

This milestone adds a small example module:

```text
Iut.Stage1.IUTStage1SourceExample
```

It packages the existing toy pre-ledger data as an `IUTStage1SourcePackage`,
converts the toy promotion obligations into `IUTStage1SourceObligations`, and
then consumes the source-facing public/recovery API.

### Lean Declarations

In `IUTStage1SourceExample.lean`:

```text
unitThetaToyIUTStage1SourceLabels
unitThetaToyIUTStage1SourcePackage
unitThetaToyIUTStage1SourceObligations
unitThetaToy_source_publicAudit_q_le_theta_example
unitThetaToy_source_publicAudit_corollary_example
unitThetaToy_source_stage_recovers_corollary_example
```

The root module imports the example module, and the README records it in the
module list.

### What This Tests

The source-facing API can be exercised through a concrete promoted path:

```text
toy pre-ledger data
  -> toy promotion obligations
  -> source package obligations
  -> source public audit projections
  -> source stage-recovery theorem
```

### Design Trap Avoided

The trap would be to leave the new non-toy source API untested until genuine IUT
source data exists. This example tests the API mechanics while clearly keeping
toy data separate from the actual IUT source problem.

### Next Step

The next milestone should add a compact source-package audit theorem collecting
the source labels, source obligations, promoted-provider consistency, and public
endpoint projections into one human-readable checklist.

## Milestone 89: Source Package Audit Checklist

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The local IUT III Step `(xi-b)` through `(xi-d)` source check decomposes the
Stage 1 passage into named qualitative output data, IPL/SHE/APT-style
requirements, hull/determinant/log-volume comparison, and finally the signed
Corollary 3.12-shaped endpoint.

The source-facing API now has all of these as separate named projections. This
milestone collects the currently formalized boundary into one audit object so
future readers can inspect the package without searching across separate
theorems.

### Purpose

This milestone adds a compact audit record:

```text
IUTStage1SourcePackage.Audit
```

and a theorem:

```text
IUTStage1SourcePackage.audit
```

The audit checklist records:

```text
source label alignment
algorithm certification
SHE arrow/certificate alignment
q-pilot positivity
normalization
promoted provider/ledger consistency
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovery to qSigned_le_thetaSigned
Stage1Comparison recovery to promoted ledger.corollary312
```

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.Audit
IUTStage1SourcePackage.audit
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_example
```

### What This Tests

The toy example verifies that the source-facing audit theorem can be consumed
through a concrete promoted path while keeping the source obligations explicit.

### Design Trap Avoided

The trap would be to make the source package appear simpler by hiding the
remaining source obligations behind the public endpoint. The audit theorem does
the opposite: it puts the labels, obligations, promoted object consistency, and
public endpoint projections in one visible record.

### Next Step

The next milestone should expose named projections from
`IUTStage1SourcePackage.Audit`, so downstream modules can cite audit fields
without relying on record-field layout.

## Milestone 90: Source Package Audit Projections

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 89 made the source-facing Stage 1 boundary inspectable as one audit
record. The next readability step is to give the audit fields stable theorem
names, so later source modules and notes can cite the exact dependency they use.

This remains bookkeeping around the Theorem 3.11 to Corollary 3.12 interface. It
does not add a new source proof or weaken any obligation.

### Purpose

This milestone adds named projections from:

```text
IUTStage1SourcePackage.Audit
```

They cover the label-alignment fields, source-obligation fields,
promoted-provider consistency, and public endpoint fields.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.Audit.inputMatchesLabels
IUTStage1SourcePackage.Audit.multiradialOutputMatchesLabels
IUTStage1SourcePackage.Audit.logVolumeComparisonMatchesLabels
IUTStage1SourcePackage.Audit.algorithmCertified
IUTStage1SourcePackage.Audit.sheArrowMatchesCertificate
IUTStage1SourcePackage.Audit.qPilotPositive
IUTStage1SourcePackage.Audit.sourceNormalization
IUTStage1SourcePackage.Audit.promotedProviderLedger
IUTStage1SourcePackage.Audit.qSignedLeThetaSigned
IUTStage1SourcePackage.Audit.corollary312Endpoint
IUTStage1SourcePackage.Audit.stageRecoversQSignedLeThetaSigned
IUTStage1SourcePackage.Audit.stageRecoversCorollary312
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_q_le_theta_projection_example
unitThetaToy_source_audit_corollary_projection_example
unitThetaToy_source_audit_recovery_projection_example
```

### What This Tests

The toy examples verify that downstream users can consume the source-facing
public endpoint through:

```text
source package audit theorem -> named audit projection
```

rather than rebuilding the public audit theorem directly.

### Design Trap Avoided

The trap would be to make the audit record useful only by knowing its field
layout. The named projections make each dependency explicit and stable while
still deriving everything from the obligation-gated audit theorem.

### Next Step

The next milestone should start separating source-package labels for the
Theta-pilot and q-pilot objects into named projection theorems, so future
source-specific work can cite those labels before the analytic content is
formalized.

## Milestone 91: Source Pilot and Indeterminacy Label Projections

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

IUT III, Corollary 3.12 distinguishes the Theta-pilot object, the q-pilot
object, the relevant log-Kummer correspondence, and the indeterminacies
`(Ind1)`, `(Ind2)`, `(Ind3)`. These names occur before the current
formalization has any analytic model of the corresponding objects.

This milestone therefore adds label projections only. It does not assign
mathematical content to the labels and does not assert any new comparison.

### Purpose

This milestone exposes source-package accessors for:

```text
Theta-pilot label
q-pilot label
log-Kummer correspondence label
indeterminacy profile label
```

These are stable hooks for later source-specific formalization.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.thetaPilot
IUTStage1SourcePackage.qPilot
IUTStage1SourcePackage.logKummer
IUTStage1SourcePackage.indeterminacies
IUTStage1SourcePackage.thetaPilot_matches_labels
IUTStage1SourcePackage.qPilot_matches_labels
IUTStage1SourcePackage.logKummer_matches_labels
IUTStage1SourcePackage.indeterminacies_matches_labels
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_thetaPilot_label_example
unitThetaToy_source_qPilot_label_example
unitThetaToy_source_logKummer_label_example
unitThetaToy_source_indeterminacies_label_example
```

### What This Tests

The toy examples verify that a source package can override the generic
pre-ledger labels while retaining the default inert source-facing pilot,
log-Kummer, and indeterminacy labels.

### Design Trap Avoided

The trap would be to wait until the analytic content is formalized before naming
these source-facing objects. That would make later APIs harder to read and could
encourage overloading generic labels. Here the labels are available, but still
mathematically inert.

### Next Step

The next milestone should add source audit fields for these four source-facing
labels, so the compact source audit checklist records both the pre-ledger label
alignment and the source-facing pilot/log-Kummer/indeterminacy labels.

## Milestone 92: Source Audit Label Fields

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 91 added source-package projections for the Theta-pilot, q-pilot,
log-Kummer, and indeterminacy labels. Since the compact source audit is meant
to be the human-readable checklist for the Stage 1 boundary, it should record
these label facts as well.

This remains label bookkeeping. It does not make any claim about the analytic
content of the pilot objects or indeterminacies.

### Purpose

This milestone extends:

```text
IUTStage1SourcePackage.Audit
```

with fields for:

```text
thetaPilot_matches_labels
qPilot_matches_labels
logKummer_matches_labels
indeterminacies_matches_labels
```

and adds named audit projections for them.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.Audit.thetaPilotMatchesLabels
IUTStage1SourcePackage.Audit.qPilotMatchesLabels
IUTStage1SourcePackage.Audit.logKummerMatchesLabels
IUTStage1SourcePackage.Audit.indeterminaciesMatchesLabels
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_thetaPilot_label_projection_example
unitThetaToy_source_audit_qPilot_label_projection_example
unitThetaToy_source_audit_logKummer_label_projection_example
unitThetaToy_source_audit_indeterminacies_label_projection_example
```

### What This Tests

The toy examples verify that source-facing label facts can be consumed through
the compact audit record, not only through direct package projections.

### Design Trap Avoided

The trap would be to let the audit checklist cover only the public endpoint and
forget the source-facing labels that explain what is being promoted. The audit
now records both the named source objects and the endpoint facts.

### Next Step

The next milestone should add a source-facing theorem stating that the compact
audit's public endpoint fields agree with `IUTStage1SourcePackage.publicAudit`,
so the audit cannot drift from the public endpoint theorem.

## Milestone 93: Source Audit Public Endpoint Compatibility

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The source audit checklist now records the public endpoint components. Since
the public endpoint itself is already named by
`IUTStage1SourcePackage.publicAudit`, the audit should be tied back to that
theorem instead of becoming a parallel endpoint.

This is a proof-maintenance step around the Stage 1 boundary. It does not add a
new mathematical route to Corollary 3.12.

### Purpose

This milestone adds a theorem saying that the endpoint triple assembled from a
source audit is propositionally equal to the package's public audit theorem:

```text
audit endpoint fields = IUTStage1SourcePackage.publicAudit
```

The equality is proof-irrelevance over the same proposition, but the explicit
statement is useful for API discipline.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.Audit.publicAuditEq
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_publicAudit_eq_example
```

### What This Tests

The toy example verifies that the audit fields for:

```text
qSigned <= thetaSigned
Corollary312Inequality
Stage1Comparison recovery to qSigned_le_thetaSigned
```

assemble into exactly the same endpoint proposition as the source package's
public audit theorem.

### Design Trap Avoided

The trap would be to let the audit record evolve independently from the public
endpoint theorem. This compatibility theorem keeps the audit visibly a view over
the public endpoint, not an alternative proof boundary.

### Next Step

The next milestone should introduce a named source-stage endpoint theorem that
combines `IUTStage1SourcePackage.audit` and `Audit.publicAuditEq`, so downstream
modules have one theorem for "source obligations imply the audited public
endpoint".

## Milestone 94: Combined Source Audited Endpoint

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The source-facing package now has two complementary views: a compact audit
record and the public Stage 1 endpoint. Future source modules should be able to
ask for both at once after supplying source obligations.

This remains an API theorem over the already explicit obligation boundary. It
does not provide any new source proof of the obligations themselves.

### Purpose

This milestone adds a theorem that packages:

```text
IUTStage1SourcePackage.audit
Audit/publicAudit compatibility
```

as a single existential endpoint:

```text
source obligations -> exists audit, audit endpoint fields = publicAudit
```

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.auditedPublicEndpoint
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_auditedPublicEndpoint_example
```

### What This Tests

The toy example verifies that consumers can obtain the audit witness and the
public endpoint compatibility through one source-facing theorem.

### Design Trap Avoided

The trap would be to make downstream modules manually assemble the audit and
compatibility theorem every time they need to inspect the public endpoint. This
theorem is a convenience wrapper, but it still requires explicit
`IUTStage1SourceObligations`.

### Next Step

The next milestone should start an explicit "source obligation gap" record that
names the still-unproved mathematical tasks underneath
`IUTStage1SourceObligations`, beginning with algorithm certification and SHE
alignment.

## Milestone 95: Source Obligation Gap Record

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

IUT III, Step `(xi-b)` treats the multiradial construction qualitatively as an
algorithm satisfying IPL/SHE/APT, while Step `(xi-d)` uses the subsequent
holomorphic-hull, determinant, and log-volume comparison. The current Lean
source package cannot prove those source facts. It can only name the gap that a
future source-specific formalization must close.

This milestone makes that gap explicit below `IUTStage1SourceObligations`.

### Purpose

This milestone introduces:

```text
IUTStage1SourceObligationGap
```

with source-facing names for the still-unproved tasks:

```text
Theorem 3.11 algorithm certification
SHE alignment
q-pilot positivity
source normalization
```

The gap can be converted into `IUTStage1SourceObligations`, but only by
supplying all four fields.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourceObligationGap
IUTStage1SourceObligationGap.theorem311AlgorithmCertified
IUTStage1SourceObligationGap.sheAlignment
IUTStage1SourceObligationGap.qPilotPositive
IUTStage1SourceObligationGap.sourceNormalization
IUTStage1SourceObligationGap.toSourceObligations
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToyIUTStage1SourceObligationGap
unitThetaToy_source_gap_to_obligations_example
```

### What This Tests

The toy example verifies that the gap record is exactly strong enough to recover
the existing toy source obligations, without changing the promoted public
endpoint API.

### Design Trap Avoided

The trap would be to leave `IUTStage1SourceObligations` as the first visible
source boundary. The new gap record names the mathematical subgoals that remain
open before those obligations can be honestly supplied in a genuine IUT source
module.

### Next Step

The next milestone should add a theorem that derives the audited public endpoint
directly from `IUTStage1SourceObligationGap`, via
`IUTStage1SourceObligationGap.toSourceObligations`.

## Milestone 96: Audited Endpoint from Source Gap

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 95 named the source-level gap below `IUTStage1SourceObligations`.
The next check is that this gap really composes with the existing source-package
endpoint theorem, and does so only through the explicit conversion to source
obligations.

This matches the intended formalization discipline: the source gap is not a new
shortcut to Corollary 3.12. It is a named prerequisite package that must be
converted into the previously audited obligation layer.

### Purpose

This milestone adds:

```text
IUTStage1SourcePackage.auditedPublicEndpointOfGap
```

It derives the audited public endpoint from:

```text
IUTStage1SourceObligationGap.toSourceObligations
```

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.auditedPublicEndpointOfGap
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_gap_auditedPublicEndpoint_example
```

### What This Tests

The toy example verifies the route:

```text
source gap
  -> source obligations
  -> source audited public endpoint
```

with no additional proof path.

### Design Trap Avoided

The trap would be to let the source gap produce public endpoint fields directly.
This theorem factors through `toSourceObligations`, preserving the previously
audited boundary.

### Next Step

The next milestone should add named source-gap projections to the source audit
story, beginning with examples that recover algorithm certification and SHE
alignment from the toy gap.

## Milestone 97: Source Gap Projection Examples

Lean file:

* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 95 introduced source-facing names for the remaining proof tasks under
`IUTStage1SourceObligations`. Those names should be directly consumable by
future source modules, especially for Theorem 3.11 algorithm certification and
SHE alignment.

This milestone tests the projection API on the toy-backed gap record. It does
not add new mathematical source content.

### Purpose

This milestone adds toy examples for all four named gap projections:

```text
Theorem 3.11 algorithm certification
SHE alignment
q-pilot positivity
source normalization
```

### Lean Declarations

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_gap_algorithm_certified_example
unitThetaToy_source_gap_she_alignment_example
unitThetaToy_source_gap_qPilot_positive_example
unitThetaToy_source_gap_normalization_example
```

### What This Tests

The examples verify that consumers can use:

```text
IUTStage1SourceObligationGap.theorem311AlgorithmCertified
IUTStage1SourceObligationGap.sheAlignment
IUTStage1SourceObligationGap.qPilotPositive
IUTStage1SourceObligationGap.sourceNormalization
```

without unpacking the gap record.

### Design Trap Avoided

The trap would be to name the gap fields but never exercise them directly. These
examples keep the gap layer readable and ready for future non-toy source modules
that must prove the same fields from IUT mathematics.

### Next Step

The next milestone should add a compact gap audit record collecting these four
gap projections, parallel to the source package audit but intentionally stopping
before the public endpoint.

## Milestone 98: Source Gap Audit Checklist

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The source-obligation gap remains below the public endpoint. Its four fields are
the current source-facing placeholders for:

```text
Theorem 3.11 algorithm certification
SHE alignment
q-pilot positivity
source normalization
```

This matches the local Stage 1 reading strategy: isolate the proof obligations
that must eventually be justified from the IUT source material before allowing
the formalization to promote a source package to the public Corollary 3.12-style
audit interface.

### Purpose

This milestone adds a compact audit checklist for
`IUTStage1SourceObligationGap`. The checklist gathers the four gap projections
without producing a public endpoint and without claiming the Corollary 3.12
inequality.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourceObligationGap.Audit
IUTStage1SourceObligationGap.audit
IUTStage1SourceObligationGap.Audit.theorem311AlgorithmCertified
IUTStage1SourceObligationGap.Audit.sheAlignment
IUTStage1SourceObligationGap.Audit.qPilotPositive
IUTStage1SourceObligationGap.Audit.sourceNormalization
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_gap_audit_example
unitThetaToy_source_gap_audit_algorithm_certified_example
unitThetaToy_source_gap_audit_she_alignment_example
unitThetaToy_source_gap_audit_qPilot_positive_example
unitThetaToy_source_gap_audit_normalization_example
```

### What This Tests

The toy examples verify that a source-gap audit can be obtained from the toy gap
and that each audit projection can be used by downstream code without unpacking
the original gap record.

### Design Trap Avoided

The trap would be to make the gap audit look like a proof of the public
Corollary 3.12 endpoint. This milestone deliberately stops at the checklist of
source obligations. The path to the public endpoint still factors through:

```text
gap audit
  -> source gap
  -> source obligations
  -> source package audit/public endpoint
```

### Next Step

The next milestone should relate the compact gap audit back to the existing
`toSourceObligations` promotion, then start splitting the algorithm
certification placeholder into smaller source-facing subclaims.

## Milestone 99: Gap Audit Promotion Compatibility

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The gap audit is not an independent mathematical source of Corollary 3.12. It
only repackages the same four obligations already present in
`IUTStage1SourceObligationGap`.

This milestone records that relationship in Lean. It keeps the formal path
linear:

```text
gap audit
  -> source obligations
  -> promoted ledger/provider
  -> public audit endpoint
```

### Purpose

This milestone adds a projection from the compact gap audit back to
`IUTStage1SourceObligations`, plus compatibility theorems showing that this
projection agrees with the existing `gap.toSourceObligations` promotion.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourceObligationGap.Audit.toSourceObligations
IUTStage1SourceObligationGap.Audit.toSourceObligations_eq_gap
IUTStage1SourceObligationGap.Audit.canonical_toSourceObligations
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_gap_audit_to_obligations_example
```

### What This Tests

The toy example verifies that audit evidence from the toy source gap promotes to
the same toy source obligations as the original gap record.

### Design Trap Avoided

The trap would be to create parallel promotion paths whose equivalence is only
informal. This milestone forces the audit-promotion route to coincide with the
already audited source-gap promotion, using proof irrelevance only for equality
between proof records.

### Next Step

The next milestone should begin replacing the monolithic
`theorem311_algorithm_certified` placeholder with a structured source-facing
record of subclaims, beginning with separate names for the algorithmic output
certificate and the Hodge-theater/SHE alignment input it depends on.

## Milestone 100: Theorem 3.11 Source Subclaims

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Mochizuki's formalization progress report describes Stage 1 as the implication
from IUT III, Theorem 3.11 to Corollary 3.12, with the fourth triangle focusing
on the simultaneous comparison of the Theta-pilot and q-pilot relative to a
single common container. The same discussion separates the multiradial
algorithm, descent, `hull+det`, SHE, IPL, and APT aspects.

Scholze-Stix locate their objection near the end of Step (xi) of Corollary 3.12,
where they argue that the relevant identifications of real-number copies and
pilot objects must be made explicit. This milestone therefore only names the
subclaims feeding the Stage 1 source obligations. It does not identify pilots or
derive any new numerical inequality.

### Purpose

This milestone starts splitting the monolithic
`theorem311_algorithm_certified` gap field into a structured source-facing
record. The first split separates:

```text
algorithmic output certification
Hodge-theater/SHE alignment with the structured pre-ledger certificate
```

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311Subclaims
IUTStage1Theorem311Subclaims.algorithmOutputCertified
IUTStage1Theorem311Subclaims.hodgeTheaterSHEAlignment
IUTStage1SourceObligationGap.theorem311Subclaims
IUTStage1SourceObligationGap.Audit.theorem311Subclaims
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_subclaims_example
unitThetaToy_source_theorem311_algorithm_output_example
unitThetaToy_source_theorem311_she_alignment_example
unitThetaToy_source_gap_audit_theorem311_subclaims_example
```

### What This Tests

The toy examples verify that downstream modules can request the Theorem 3.11
subclaim record from either a source gap or a source-gap audit, then project the
algorithmic output certificate and SHE alignment separately.

### Design Trap Avoided

The trap would be to treat Theorem 3.11 as a single opaque token all the way down
to the disputed Corollary 3.12 comparison. This milestone keeps the token
opaque mathematically, but gives it internal named structure so future work can
replace each part with real source mathematics one at a time.

### Next Step

The next milestone should connect these subclaims to the already existing
structured IPL/SHE/APT certificates in `IUTStage1PreLedgerData.Audit`, without
allowing structured IPL/SHE/APT names alone to produce common-target bounds or
Corollary 3.12.

## Milestone 101: Theorem 3.11 Structured Inputs

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Mochizuki's formalization report separates the fourth triangle
`3.11.5 => 3.12` from the earlier first/second/third triangles, and explicitly
names SHE, IPL, and APT as parts of the surrounding decomposition. Our existing
pre-ledger audit already exposes structured IPL/SHE/APT evidence as inert
bookkeeping.

This milestone links the new Theorem 3.11 subclaim record to that pre-ledger
audit. It does not state that structured IPL/SHE/APT imply a common-target bound
or a Corollary 3.12 inequality.

### Purpose

This milestone introduces a source-facing structured-input record for Theorem
3.11. It pairs:

```text
the local pre-ledger audit
the Theorem 3.11 subclaims
```

This makes the relevant structured IPL/SHE/APT evidence available beside the
opaque algorithmic output certificate and SHE alignment.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311StructuredInputs
IUTStage1Theorem311StructuredInputs.hasStructuredIPL
IUTStage1Theorem311StructuredInputs.hasStructuredSHE
IUTStage1Theorem311StructuredInputs.hasStructuredAPT
IUTStage1Theorem311StructuredInputs.algorithmOutputCertified
IUTStage1Theorem311StructuredInputs.hodgeTheaterSHEAlignment
IUTStage1SourceObligationGap.theorem311StructuredInputs
IUTStage1SourceObligationGap.Audit.theorem311StructuredInputs
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_structured_inputs_example
unitThetaToy_source_theorem311_structured_hasIPL_example
unitThetaToy_source_theorem311_structured_hasSHE_example
unitThetaToy_source_theorem311_structured_hasAPT_example
unitThetaToy_source_gap_audit_theorem311_structured_inputs_example
```

### What This Tests

The toy examples verify that structured IPL/SHE/APT evidence can be projected
from the new structured-input record, while algorithm certification still comes
from the explicit Theorem 3.11 subclaims.

### Design Trap Avoided

The trap would be to let structured IPL/SHE/APT names become hidden axioms for
the numerical comparison. This milestone only exposes the names. The existing
bridge and source-obligation layers remain responsible for bounds and endpoint
promotion.

### Next Step

The next milestone should add compatibility lemmas from structured inputs back
to the older Theorem 3.11 subclaim projections, then consider a separate
source-facing record for the q-pilot positivity and normalization side
conditions.

## Milestone 102: Structured Input Subclaim Compatibility

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

This milestone is a coherence step inside the formal API. It does not add a new
mathematical assertion beyond the Stage 1 source-reading already recorded in
Milestones 100 and 101: Theorem 3.11 is still being decomposed into named
source-facing inputs, while the Corollary 3.12 public endpoint remains behind
the source-obligation promotion.

The Scholze-Stix warning about implicit identifications motivates this sort of
bookkeeping. If a later module uses "structured inputs", Lean should expose
exactly which Theorem 3.11 subclaims are being used instead of silently changing
the proof path.

### Purpose

This milestone adds compatibility projections showing that
`IUTStage1Theorem311StructuredInputs` contains the same
`IUTStage1Theorem311Subclaims` object used by the source-gap and source-gap-audit
layers.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311StructuredInputs.theorem311Subclaims
IUTStage1Theorem311StructuredInputs.algorithmOutputCertified_eq_subclaims
IUTStage1Theorem311StructuredInputs.hodgeTheaterSHEAlignment_eq_subclaims
IUTStage1SourceObligationGap.theorem311StructuredInputs_subclaims
IUTStage1SourceObligationGap.Audit.theorem311StructuredInputs_subclaims
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_structured_subclaims_example
unitThetaToy_source_theorem311_structured_algorithm_eq_subclaims_example
unitThetaToy_source_theorem311_structured_she_eq_subclaims_example
unitThetaToy_source_gap_audit_theorem311_structured_subclaims_example
```

### What This Tests

The toy examples verify that both the gap-derived and audit-derived structured
input records project back to the older subclaim records, and that their
algorithm and SHE projections agree with those subclaims.

### Design Trap Avoided

The trap would be to introduce a second source-facing Theorem 3.11 interface and
leave its relation to the first interface informal. This milestone makes that
relation explicit and machine-checkable.

### Next Step

The next milestone should introduce a separate source-facing record for the
q-pilot positivity and normalization side conditions, so that the Theorem 3.11
subclaim story remains distinct from the arithmetic sign/normalization
requirements needed for ledger promotion.

## Milestone 103: Source Side Conditions

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The Stage 1 source-obligation record contains two kinds of data: Theorem
3.11-facing algorithm/SHE data and separate side conditions needed for ledger
promotion. The q-pilot positivity and normalization hypotheses should therefore
not be folded into the Theorem 3.11 subclaim record.

This separation is also aligned with the dispute-aware reading strategy. The
critical Corollary 3.12 comparison must not be hidden behind a generic package
of assumptions. Each input to the promotion step should remain named.

### Purpose

This milestone introduces a source-facing side-condition record for:

```text
q-pilot positivity
source normalization
```

The record is projected from the source gap and from the source-gap audit.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourceSideConditions
IUTStage1SourceSideConditions.qPilotPositive
IUTStage1SourceSideConditions.sourceNormalization
IUTStage1SourceObligationGap.sideConditions
IUTStage1SourceObligationGap.Audit.sideConditions
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_side_conditions_example
unitThetaToy_source_side_conditions_qPilot_positive_example
unitThetaToy_source_side_conditions_normalization_example
unitThetaToy_source_gap_audit_side_conditions_example
```

### What This Tests

The toy examples verify that consumers can recover q-pilot positivity and source
normalization through the new side-condition record without unpacking the full
source gap or gap audit.

### Design Trap Avoided

The trap would be to enlarge the Theorem 3.11 subclaim record until it becomes a
bag of every remaining hypothesis. This milestone keeps algorithmic/SHE
subclaims separate from arithmetic sign and normalization side conditions.

### Next Step

The next milestone should add a clean constructor that combines Theorem 3.11
subclaims with side conditions to rebuild `IUTStage1SourceObligations`, making
the promotion boundary explicit.

## Milestone 104: Source Obligation Constructor from Parts

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The formal boundary now has two named input layers:

```text
Theorem 3.11 subclaims
source side conditions
```

This milestone adds the constructor that combines exactly these two layers into
`IUTStage1SourceObligations`. This mirrors the Stage 1 reading discipline: only
after both algorithmic/SHE data and side conditions are supplied may the package
be promoted toward the public endpoint.

### Purpose

This milestone makes the promotion boundary explicit by adding a constructor
from separated inputs to source obligations.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourceObligations.ofSubclaimsAndSideConditions
IUTStage1SourceObligationGap.toSourceObligations_eq_subclaimsAndSideConditions
IUTStage1SourceObligationGap.Audit.toSourceObligations_eq_subclaimsAndSideConditions
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_obligations_from_parts_example
unitThetaToy_source_gap_audit_obligations_from_parts_example
```

### What This Tests

The toy examples verify that rebuilding source obligations from Theorem 3.11
subclaims and side conditions produces the same obligations as the older
source-gap route.

### Design Trap Avoided

The trap would be to let a source gap remain the only way to construct source
obligations. This milestone gives future non-toy modules a clearer target:
prove the named Theorem 3.11 subclaims, prove the named side conditions, then
combine them.

### Next Step

The next milestone should add public projection examples that pass through this
constructor into the existing source audit/public endpoint, while still avoiding
any direct route from Theorem 3.11 subclaims alone to Corollary 3.12.

## Milestone 105: Public Audit from Separated Inputs

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestone made source-obligation construction explicit from:

```text
Theorem 3.11 subclaims
source side conditions
```

This milestone routes that constructed obligation record through the existing
source package public audit. It does not create a direct theorem from Theorem
3.11 subclaims alone to Corollary 3.12.

### Purpose

This milestone adds a source-package API for using separated inputs at the
public audit boundary. The implementation first constructs
`IUTStage1SourceObligations`, then calls the existing `publicAudit` route.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.obligationsFromParts
IUTStage1SourcePackage.publicAuditOfParts
IUTStage1SourcePackage.publicAuditOfParts_qSigned_le_thetaSigned
IUTStage1SourcePackage.publicAuditOfParts_corollary312
IUTStage1SourcePackage.publicAuditOfParts_stage1Comparison_recovers_qSigned_le_thetaSigned
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_publicAudit_from_parts_q_le_theta_example
unitThetaToy_source_publicAudit_from_parts_corollary_example
unitThetaToy_source_publicAudit_from_parts_recovery_example
```

### What This Tests

The toy examples verify that separated inputs can be used to obtain the same
public audit projections as the older direct source-obligation examples.

### Design Trap Avoided

The trap would be to add a convenient public endpoint that consumes only the
Theorem 3.11 subclaim record. This milestone requires both the subclaims and the
side-condition record, and the implementation visibly factors through
`IUTStage1SourceObligations`.

### Next Step

The next milestone should add source-audit examples from separated inputs, so
that the compact audit record and public projection route are tested together.

## Milestone 106: Source Audit from Separated Inputs

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The separated-input route now has:

```text
Theorem 3.11 subclaims
source side conditions
source obligations
public audit projections
```

This milestone adds the compact source audit to that route. The formal path
still factors through `IUTStage1SourceObligations`; it does not bypass the
promotion boundary or make Theorem 3.11 subclaims alone imply Corollary 3.12.

### Purpose

This milestone adds an audit endpoint for separated inputs, then tests audit
projections in the toy model.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.auditOfParts
IUTStage1SourcePackage.auditedPublicEndpointOfParts
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_from_parts_example
unitThetaToy_source_audit_from_parts_q_le_theta_projection_example
unitThetaToy_source_audit_from_parts_corollary_projection_example
```

### What This Tests

The toy examples verify that separated inputs can produce the compact source
audit and that the audit projections recover the q-bound and Corollary
3.12-shaped endpoint.

### Design Trap Avoided

The trap would be to duplicate public endpoint logic in a separate
parts-specific proof. The implementation reuses the existing source audit and
public endpoint machinery after constructing source obligations from the named
parts.

### Next Step

The next milestone should expose label and recovery projections from the
parts-based audit, then start replacing toy-only side-condition proofs with
source-facing hypotheses closer to the IUT III notation.

## Milestone 107: Parts-Based Audit Projection Coverage

Lean file:

* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The compact audit record contains both public comparison data and source-label
bookkeeping. Since the parts-based audit route is meant to be a transparent
wrapper around the existing source audit, it should expose both kinds of fields.

This milestone adds no new mathematical implication. It only checks that the
parts-based route preserves the same recovery and label projections available
from the older source-obligation audit.

### Purpose

This milestone extends the toy examples for the parts-based source audit by
projecting:

```text
Stage 1 recovery of the Corollary 3.12 endpoint
Theta-pilot source label
q-pilot source label
```

### Lean Declarations

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_from_parts_recovery_projection_example
unitThetaToy_source_audit_from_parts_thetaPilot_label_projection_example
unitThetaToy_source_audit_from_parts_qPilot_label_projection_example
```

### What This Tests

The examples verify that the separated-input audit path is usable for both the
mathematical endpoint recovery theorem and the source-facing label projections.

### Design Trap Avoided

The trap would be to test only the numerical-looking endpoint and leave the
source-label bookkeeping unexercised. The label projections matter because they
make explicit which Stage 1 source objects are being routed into the audit.

### Next Step

The next milestone should start replacing toy-only side-condition proofs with a
source-facing side-condition hypothesis record closer to the IUT III notation.

## Milestone 108: Source Side-Condition Hypotheses

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The q-pilot sign condition and source normalization assumption are not Theorem
3.11 algorithmic content. They are side hypotheses needed before the source
package can be promoted to the public Stage 1 endpoint.

This milestone gives those assumptions a source-facing hypothesis record, while
keeping the existing `IUTStage1SourceSideConditions` record as the constructor
input used by source obligations.

### Purpose

This milestone introduces a named hypothesis layer for:

```text
q-pilot log-volume positivity
source normalization
```

and provides a conversion to the existing side-condition record.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourceSideConditionHypotheses
IUTStage1SourceSideConditionHypotheses.qPilotLogVolumePositive
IUTStage1SourceSideConditionHypotheses.sourceNormalized
IUTStage1SourceSideConditionHypotheses.toSideConditions
IUTStage1SourceSideConditionHypotheses.ofSideConditions
IUTStage1SourceSideConditionHypotheses.toSideConditions_ofSideConditions
IUTStage1SourceObligationGap.sideConditionHypotheses
IUTStage1SourceObligationGap.Audit.sideConditionHypotheses
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_side_condition_hypotheses_example
unitThetaToy_source_side_condition_hypotheses_qPilot_example
unitThetaToy_source_side_condition_hypotheses_normalization_example
unitThetaToy_source_side_condition_hypotheses_to_side_conditions_example
```

### What This Tests

The toy examples verify that source-facing hypotheses can be projected and then
converted back into the side-condition record used by the source-obligation
constructor.

### Design Trap Avoided

The trap would be to keep relying on toy-specific proofs as if they were the
eventual source API. This milestone introduces a named target that future
IUT-specific modules can prove without changing the public audit route.

### Next Step

The next milestone should allow source obligations to be built directly from
Theorem 3.11 subclaims and side-condition hypotheses by composing through
`toSideConditions`.

## Milestone 109: Obligations from Side-Condition Hypotheses

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The source-facing side-condition hypotheses introduced in Milestone 108 are
closer to the way future source modules should state the q-pilot sign and
normalization assumptions. The source-obligation constructor still consumes the
more compact `IUTStage1SourceSideConditions` record.

This milestone connects those layers without changing the public endpoint. The
route is:

```text
Theorem 3.11 subclaims
side-condition hypotheses
  -> side conditions
  -> source obligations
```

### Purpose

This milestone adds a source-obligation constructor that accepts side-condition
hypotheses directly, while definitionally factoring through
`IUTStage1SourceSideConditionHypotheses.toSideConditions`.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses
IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses_eq_sideConditions
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_obligations_from_hypotheses_example
```

### What This Tests

The toy example verifies that obligations built from source-facing hypotheses
recover the same toy obligations as the older route through side conditions.

### Design Trap Avoided

The trap would be to create a second unrelated way to build source obligations.
This milestone makes the new source-facing hypothesis route explicitly compose
through the existing side-condition constructor.

### Next Step

The next milestone should add `IUTStage1SourcePackage` helpers that use
side-condition hypotheses at the package audit/public-audit boundary, again
factoring through the existing side-condition route.

## Milestone 110: Package Audit Helpers from Hypotheses

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 109 allowed source obligations to be built from side-condition
hypotheses by composing through `toSideConditions`. This milestone lifts that
route to the package audit boundary.

The route remains explicit:

```text
Theorem 3.11 subclaims
side-condition hypotheses
  -> side conditions
  -> source obligations
  -> source public audit / compact source audit
```

No direct path is introduced from side-condition hypotheses or Theorem 3.11
subclaims alone to Corollary 3.12.

### Purpose

This milestone adds package-level helpers that accept side-condition hypotheses
and reuse the existing parts-based public/audit machinery.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.obligationsFromHypotheses
IUTStage1SourcePackage.obligationsFromHypotheses_eq_parts
IUTStage1SourcePackage.publicAuditOfHypotheses
IUTStage1SourcePackage.publicAuditOfHypotheses_qSigned_le_thetaSigned
IUTStage1SourcePackage.publicAuditOfHypotheses_corollary312
IUTStage1SourcePackage.auditOfHypotheses
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_publicAudit_from_hypotheses_q_le_theta_example
unitThetaToy_source_publicAudit_from_hypotheses_corollary_example
unitThetaToy_source_audit_from_hypotheses_example
unitThetaToy_source_audit_from_hypotheses_q_le_theta_projection_example
```

### What This Tests

The toy examples verify that the hypothesis-based route reaches the same public
q-bound and Corollary-shaped endpoint, and that it also produces the compact
source audit.

### Design Trap Avoided

The trap would be to make hypothesis names function as endpoint assumptions.
This milestone keeps hypotheses below source obligations and makes the
conversion through `toSideConditions` part of the API.

### Next Step

The next milestone should add recovery and label projections for the
hypothesis-based source audit, mirroring the parts-based audit coverage.

## Milestone 111: Hypothesis-Based Audit Projection Coverage

Lean file:

* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 110 introduced package helpers that accept source-facing
side-condition hypotheses. Those helpers are only wrappers around the existing
parts route, but they should still expose the same audit projections.

This milestone tests that the hypothesis-based audit route preserves both the
public endpoint projections and source-label bookkeeping.

### Purpose

This milestone adds toy projection examples for the hypothesis-based source
audit.

### Lean Declarations

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_from_hypotheses_corollary_projection_example
unitThetaToy_source_audit_from_hypotheses_recovery_projection_example
unitThetaToy_source_audit_from_hypotheses_thetaPilot_label_projection_example
unitThetaToy_source_audit_from_hypotheses_qPilot_label_projection_example
```

### What This Tests

The examples verify that the hypothesis-based audit path supports the
Corollary-shaped endpoint, the Stage 1 recovery theorem, and the source labels
for the Theta-pilot and q-pilot.

### Design Trap Avoided

The trap would be to provide a hypothesis-based audit wrapper that is tested
only for the q-bound. This milestone checks that it behaves like the established
source audit for both mathematical and label projections.

### Next Step

The next milestone should add an audited public endpoint from side-condition
hypotheses, again factoring through `obligationsFromHypotheses`.

## Milestone 112: Audited Public Endpoint from Hypotheses

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The hypothesis-based route now reaches public audit projections and compact
audit projections. This milestone adds the audited public endpoint statement
for that route.

The formal path remains:

```text
Theorem 3.11 subclaims
side-condition hypotheses
  -> obligationsFromHypotheses
  -> audited public endpoint
```

### Purpose

This milestone adds the existential audited endpoint for package inputs stated
using side-condition hypotheses.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.auditedPublicEndpointOfHypotheses
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_hypotheses_auditedPublicEndpoint_example
```

### What This Tests

The toy example verifies that the hypothesis-based route can produce the same
audited public endpoint shape as the source-obligation and gap routes.

### Design Trap Avoided

The trap would be to state an endpoint directly from hypotheses. This theorem
uses `obligationsFromHypotheses`, so the promotion boundary remains explicit.

### Next Step

The next milestone should add compatibility lemmas showing that the
hypothesis-based audited endpoint agrees with the parts-based endpoint after
converting hypotheses to side conditions.

## Milestone 113: Hypotheses-to-Parts Compatibility

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The hypothesis-based API is intended to be notation for source-facing
side-condition assumptions, not a new mathematical route. It should therefore
agree with the parts-based API after applying `toSideConditions`.

This milestone records that compatibility explicitly at the obligations,
public-audit, compact-audit, and audited-endpoint levels.

### Purpose

This milestone adds compatibility lemmas showing that the hypothesis route is a
wrapper around the side-condition route.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.obligationsFromHypotheses_eq_ofHypotheses
IUTStage1SourcePackage.publicAuditOfHypotheses_eq_parts
IUTStage1SourcePackage.auditOfHypotheses_eq_parts
IUTStage1SourcePackage.auditedPublicEndpointOfHypotheses_eq_parts
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_obligations_from_hypotheses_eq_parts_example
unitThetaToy_source_publicAudit_from_hypotheses_eq_parts_example
unitThetaToy_source_audit_from_hypotheses_eq_parts_example
unitThetaToy_source_hypotheses_auditedPublicEndpoint_eq_parts_example
```

### What This Tests

The toy examples verify that replacing side-condition hypotheses by their
`toSideConditions` image leaves the obligation, audit, public audit, and audited
endpoint routes unchanged.

### Design Trap Avoided

The trap would be to let the hypothesis route drift into a second proof path.
These compatibility lemmas make the wrapping relationship machine-checkable.

### Next Step

The next milestone should introduce source-facing names for the q-pilot
log-volume and normalization objects themselves, so later non-toy hypotheses can
refer to named source labels rather than only pre-ledger fields.

## Milestone 114: Side-Condition Source Labels

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The side-condition hypotheses refer to q-pilot log-volume positivity and source
normalization. Until this milestone, those hypotheses were attached only to raw
pre-ledger fields. The source-facing API should also name the corresponding
source objects, just as it already names the pilots, log-Kummer correspondence,
and indeterminacy profile.

These names remain inert labels. They add no proof of positivity,
normalization, or Corollary 3.12.

### Purpose

This milestone adds source-facing labels for:

```text
q-pilot log-volume sign datum
source normalization datum
```

and threads them through the compact source audit.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
QPilotLogVolumeId
SourceNormalizationId
IUTStage1SourceLabels.qPilotLogVolume
IUTStage1SourceLabels.sourceNormalization
IUTStage1SourcePackage.qPilotLogVolume
IUTStage1SourcePackage.sourceNormalizationLabel
IUTStage1SourcePackage.qPilotLogVolume_matches_labels
IUTStage1SourcePackage.sourceNormalization_matches_labels
IUTStage1SourcePackage.Audit.qPilotLogVolumeMatchesLabels
IUTStage1SourcePackage.Audit.sourceNormalizationMatchesLabels
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_qPilotLogVolume_label_example
unitThetaToy_source_sourceNormalization_label_example
unitThetaToy_source_audit_qPilotLogVolume_label_projection_example
unitThetaToy_source_audit_sourceNormalization_label_projection_example
```

### What This Tests

The toy examples verify that the new labels are available on source packages and
that the compact source audit preserves them.

### Design Trap Avoided

The trap would be to let side-condition hypotheses refer only to anonymous real
or normalization fields. This milestone gives future non-toy modules stable
source-facing names without assigning mathematical consequences to those names.

### Next Step

The next milestone should connect side-condition hypotheses to these labels in a
small audit record, so source modules can state which labeled q-pilot log-volume
and normalization data their hypotheses concern.

## Milestone 115: Labeled Side-Condition Hypothesis Audit

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 114 introduced inert source labels for the q-pilot log-volume sign
datum and source normalization datum. This milestone connects those labels to
the side-condition hypotheses that state positivity and normalization.

The audit still carries no new mathematical consequence. It only records that
the hypotheses concern the labeled source objects.

### Purpose

This milestone adds a compact audit record for source side-condition
hypotheses.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourceSideConditionHypotheses.Audit
IUTStage1SourceSideConditionHypotheses.audit
IUTStage1SourceSideConditionHypotheses.Audit.qPilotLogVolumeMatchesLabels
IUTStage1SourceSideConditionHypotheses.Audit.sourceNormalizationMatchesLabels
IUTStage1SourceSideConditionHypotheses.Audit.qPilotLogVolumePositive
IUTStage1SourceSideConditionHypotheses.Audit.sourceNormalized
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_side_condition_hypotheses_audit_example
unitThetaToy_source_side_condition_hypotheses_audit_q_label_example
unitThetaToy_source_side_condition_hypotheses_audit_normalization_label_example
unitThetaToy_source_side_condition_hypotheses_audit_q_positive_example
unitThetaToy_source_side_condition_hypotheses_audit_normalization_example
```

### What This Tests

The toy examples verify that the side-condition hypothesis audit exposes both
label matches and the underlying q-positivity/normalization hypotheses.

### Design Trap Avoided

The trap would be to add source labels but never tie them to the hypotheses they
are meant to name. This audit keeps the association explicit without upgrading
labels into proof-producing objects.

### Next Step

The next milestone should thread this side-condition hypothesis audit into the
package-level hypothesis route, so consumers can recover it next to the public
audit data.

## Milestone 116: Hypothesis Route Combined Audit

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestone made the side-condition hypothesis audit label-aware.
The package-level hypothesis route already builds source obligations from
Theorem 3.11-style subclaims plus side-condition hypotheses.

This milestone connects those two pieces without identifying them. The
side-condition audit still concerns the labeled q-pilot log-volume positivity
and source normalization hypotheses. The source package audit still concerns
the promoted public comparison data and the resulting Corollary 3.12 endpoint.

### Purpose

This milestone adds a combined audit for the hypothesis-based package route.
Consumers can now recover both the side-condition audit and the package/source
audit from one route object.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.sideConditionAuditOfHypotheses
IUTStage1SourcePackage.HypothesisRouteAudit
IUTStage1SourcePackage.hypothesisRouteAudit
IUTStage1SourcePackage.HypothesisRouteAudit.sideConditionAudit
IUTStage1SourcePackage.HypothesisRouteAudit.sourceAudit
IUTStage1SourcePackage.HypothesisRouteAudit.qPilotLogVolumePositive
IUTStage1SourcePackage.HypothesisRouteAudit.qSignedLeThetaSigned
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_hypothesis_route_audit_example
unitThetaToy_source_hypothesis_route_side_condition_audit_example
unitThetaToy_source_hypothesis_route_source_audit_example
unitThetaToy_source_hypothesis_route_q_positive_example
unitThetaToy_source_hypothesis_route_q_le_theta_example
```

### What This Tests

The toy examples verify that the hypothesis route can expose:

* the side-condition hypothesis audit;
* the source package audit for obligations built from those hypotheses;
* q-pilot log-volume positivity from the side-condition side;
* the q/theta signed comparison from the source package side.

### Design Trap Avoided

The trap would be to merge side-condition evidence into the source comparison
audit and thereby hide which assumptions power which conclusion. The combined
audit is deliberately a product-like record: one field for side conditions, one
field for the source audit.

This keeps us from turning labels or side-condition hypotheses into an
unexamined proof of Corollary 3.12. The controversial endpoint remains only in
the source audit path already present in the Stage 1 skeleton.

### Next Step

The next milestone should add compatibility lemmas showing that the combined
route projections agree definitionally with the standalone side-condition audit
and the existing source audit from hypotheses. After that, we can begin
splitting the Theorem 3.11 subclaims into more explicit algorithmic-output and
SHE-input components.

## Milestone 117: Hypothesis Route Projection Compatibility

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 116 introduced a combined route audit with two fields. This milestone
checks that the fields are not new evidence paths. They are definitionally the
same audits that were already available separately from the side-condition
hypotheses and from the package-level source audit.

### Purpose

This milestone adds compatibility lemmas for rewriting between the compact
hypothesis route audit and the older standalone audit constructors.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.hypothesisRouteAudit_sideConditionAudit_eq
IUTStage1SourcePackage.hypothesisRouteAudit_sourceAudit_eq
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_hypothesis_route_side_condition_audit_eq_example
unitThetaToy_source_hypothesis_route_source_audit_eq_example
```

### What This Tests

The toy examples verify that the two projections from
`HypothesisRouteAudit` reduce to:

* `sideConditionAuditOfHypotheses`;
* `auditOfHypotheses`.

These are `rfl`-level compatibility facts in the abstract API.

### Design Trap Avoided

The trap would be to make the combined route object a second, independent
construction that later has to be trusted separately. These compatibility
lemmas show that the combined route is only packaging.

### Next Step

The next milestone should start separating the current monolithic
`IUTStage1Theorem311Subclaims` record into smaller labeled components, beginning
with the algorithmic-output certification component.

## Milestone 118: Theorem 3.11 Algorithmic-Output Component

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Our Stage 1 skeleton currently represents the Theorem 3.11 input as one
source-facing subclaim record with two fields: an algorithmic-output certificate
and a Hodge-theater/SHE alignment datum. This milestone begins splitting that
bundle into smaller components.

The split is intentionally conservative. It does not assert any new
mathematical content about Theorem 3.11. It only names the algorithmic-output
certificate as its own component so that later milestones can track exactly
which part of the Theorem 3.11 route supplies which obligation.

### Purpose

This milestone isolates the algorithmic-output certificate from the rest of the
Theorem 3.11 subclaim bundle.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311AlgorithmicOutput
IUTStage1Theorem311AlgorithmicOutput.algorithmOutputCertified
IUTStage1Theorem311Subclaims.algorithmicOutput
IUTStage1Theorem311Subclaims.ofAlgorithmicOutputAndSHEAlignment
IUTStage1Theorem311Subclaims.algorithmicOutput_certified_eq
IUTStage1Theorem311Subclaims.ofAlgorithmicOutputAndSHEAlignment_algorithmicOutput_eq
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_algorithmic_output_component_example
unitThetaToy_source_theorem311_algorithmic_output_component_certified_example
unitThetaToy_source_theorem311_algorithmic_output_certified_eq_example
unitThetaToy_source_theorem311_subclaims_from_algorithmic_output_example
unitThetaToy_source_theorem311_subclaims_from_algorithmic_output_eq_example
```

### What This Tests

The toy examples verify that:

* a Theorem 3.11 subclaim bundle exposes its algorithmic-output component;
* the component recovers the same output certification proof;
* a subclaim bundle can be rebuilt from the algorithmic-output component plus
  the existing SHE-alignment datum.

### Design Trap Avoided

The trap would be to keep treating Theorem 3.11 as a single opaque source of
all Stage 1 obligations. This split makes one dependency explicit while keeping
the endpoint unchanged.

Just as importantly, this component does not say anything about Corollary 3.12.
It only supplies the algorithmic-output certification needed before source
obligations can be assembled.

### Next Step

The next milestone should isolate the Hodge-theater/SHE-alignment datum as a
second small Theorem 3.11 component, then rebuild the subclaim bundle from the
two named components.

## Milestone 119: Theorem 3.11 SHE-Alignment Component

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 118 isolated the algorithmic-output certificate. This milestone
isolates the second field of the Theorem 3.11 subclaim bundle: the
Hodge-theater/SHE alignment datum connecting the common-container SHE arrow to
the structured SHE certificate in the pre-ledger.

This is only a naming and packaging step. It does not assert that the alignment
is available in a non-toy source theory, and it does not promote the alignment
to Corollary 3.12.

### Purpose

This milestone gives the Theorem 3.11 route two named components:

* algorithmic-output certification;
* Hodge-theater/SHE alignment.

The existing subclaim bundle can now be rebuilt from these two components.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311SHEAlignment
IUTStage1Theorem311SHEAlignment.hodgeTheaterSHEAlignment
IUTStage1Theorem311Subclaims.sheAlignment
IUTStage1Theorem311Subclaims.ofComponents
IUTStage1Theorem311Subclaims.sheAlignment_hodgeTheaterSHEAlignment_eq
IUTStage1Theorem311Subclaims.ofComponents_algorithmicOutput_eq
IUTStage1Theorem311Subclaims.ofComponents_sheAlignment_eq
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_she_alignment_component_example
unitThetaToy_source_theorem311_she_alignment_component_alignment_example
unitThetaToy_source_theorem311_she_alignment_eq_example
unitThetaToy_source_theorem311_subclaims_from_components_example
unitThetaToy_source_theorem311_subclaims_from_components_algorithmic_eq_example
unitThetaToy_source_theorem311_subclaims_from_components_she_eq_example
```

### What This Tests

The toy examples verify that:

* a Theorem 3.11 subclaim bundle exposes its SHE-alignment component;
* the SHE-alignment component recovers the same alignment proof;
* the full subclaim bundle can be rebuilt from the algorithmic-output component
  and the SHE-alignment component;
* both components can be recovered from that rebuilt bundle.

### Design Trap Avoided

The trap would be to use the phrase "Hodge theater" as an opaque license to
derive downstream inequalities. In Lean, this milestone only records a precise
alignment equality. It is not a transport principle, not a reconstruction
principle, and not a Corollary 3.12 proof.

### Next Step

The next milestone should thread the two named Theorem 3.11 components into
`IUTStage1Theorem311StructuredInputs`, so structured inputs expose the same
component-level API as raw subclaim bundles.

## Milestone 120: Structured-Input Component Projections

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous two milestones split the Theorem 3.11 subclaim bundle into
algorithmic-output and Hodge-theater/SHE-alignment components. Structured
inputs pair that subclaim bundle with the local pre-ledger audit.

This milestone exposes the same component-level API through structured inputs.
It does not change what structured inputs assume: they still consist of a
pre-ledger audit plus the existing Theorem 3.11 subclaim bundle.

### Purpose

This milestone lets downstream code work with structured Theorem 3.11 inputs at
the component level without bypassing the subclaim bundle.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1Theorem311StructuredInputs.algorithmicOutput
IUTStage1Theorem311StructuredInputs.sheAlignment
IUTStage1Theorem311StructuredInputs.algorithmicOutput_eq_subclaims
IUTStage1Theorem311StructuredInputs.sheAlignment_eq_subclaims
IUTStage1Theorem311StructuredInputs.components_rebuild_subclaims
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_theorem311_structured_algorithmic_component_example
unitThetaToy_source_theorem311_structured_algorithmic_eq_subclaims_example
unitThetaToy_source_theorem311_structured_she_component_example
unitThetaToy_source_theorem311_structured_she_component_eq_subclaims_example
unitThetaToy_source_theorem311_structured_components_rebuild_example
```

### What This Tests

The toy examples verify that structured inputs expose:

* the algorithmic-output component;
* the Hodge-theater/SHE-alignment component;
* definitional agreement between these projections and the underlying subclaim
  projections;
* reconstruction of the subclaim bundle from the two projected components.

### Design Trap Avoided

The trap would be to introduce a second component source at the structured-input
level. The new projections are only views of `theorem311Subclaims`, and the
rebuild lemma records that the component split is packaging rather than an
additional assumption.

### Next Step

The next milestone should use these structured-input components when assembling
source obligations, so the path from structured Theorem 3.11 data to source
obligations names each dependency separately.

## Milestone 121: Structured-Input Obligation Assembly

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Structured inputs now expose the algorithmic-output component and the
Hodge-theater/SHE-alignment component. Source obligations also require the
side-condition data: q-pilot positivity and source normalization.

This milestone assembles source obligations from structured inputs plus side
conditions. The construction is deliberately equivalent to the earlier
subclaim-based constructor.

### Purpose

This milestone gives us a named route:

```text
structured Theorem 3.11 inputs + source side conditions
  -> source obligations
```

It also gives the corresponding route from side-condition hypotheses.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourceObligations.ofStructuredInputsAndSideConditions
IUTStage1SourceObligations.ofStructuredInputsAndSideConditions_eq_subclaims
IUTStage1SourceObligations.ofStructuredInputsAndSideConditionHypotheses
IUTStage1SourceObligations.ofStructuredInputsAndSideConditionHypotheses_eq_sideConditions
IUTStage1SourceObligations.ofStructuredInputsAndSideConditionHypotheses_eq_subclaims
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_obligations_from_structured_inputs_example
unitThetaToy_source_obligations_from_structured_hypotheses_example
```

### What This Tests

The toy examples verify that assembling obligations from structured inputs
recovers the same unit-theta source obligations as the older subclaim route,
both with raw side conditions and with side-condition hypotheses.

### Design Trap Avoided

The trap would be to let structured inputs silently become a new assumption
source for the q-pilot positivity or normalization side conditions. The new
constructors still require side conditions separately. The structured inputs
only provide the Theorem 3.11 components.

### Next Step

The next milestone should expose this structured-input obligation route at the
`IUTStage1SourcePackage` level, parallel to `obligationsFromParts` and
`obligationsFromHypotheses`.

## Milestone 122: Package-Level Structured Obligation Route

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Mochizuki's recent formalization overview explicitly presents Stage 1 as the
route from `[IUTchIII] Theorem 3.11` to Corollary 3.12. The Scholze-Stix note
focuses its criticism on the Corollary 3.12 passage and the interpretation of
pilot objects across Hodge theaters.

This milestone remains on the source-obligation side of that route. It exposes
the structured Theorem 3.11 input route at the package level, but it does not
add a new public audit or endpoint theorem.

### Purpose

This milestone adds package-level obligation constructors parallel to the
existing `obligationsFromParts` and `obligationsFromHypotheses` constructors.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.obligationsFromStructuredInputs
IUTStage1SourcePackage.obligationsFromStructuredInputs_eq_parts
IUTStage1SourcePackage.obligationsFromStructuredInputs_eq_ofStructuredInputs
IUTStage1SourcePackage.obligationsFromStructuredHypotheses
IUTStage1SourcePackage.obligationsFromStructuredHypotheses_eq_parts
IUTStage1SourcePackage.obligationsFromStructuredHypotheses_eq_hypotheses
IUTStage1SourcePackage.obligationsFromStructuredHypotheses_eq_ofStructuredHypotheses
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_package_obligations_from_structured_inputs_example
unitThetaToy_source_package_obligations_from_structured_inputs_eq_parts_example
unitThetaToy_source_package_obligations_from_structured_hypotheses_example
unitThetaToy_source_package_obligations_from_structured_hypotheses_eq_parts_example
unitThetaToy_source_package_obligations_from_structured_hypotheses_eq_hypotheses_example
```

### What This Tests

The toy examples verify that package-level structured-input routes recover the
same unit-theta source obligations and reduce to the earlier package-level
subclaim routes.

### Design Trap Avoided

The trap would be to expose structured inputs at the package level as if they
were a new route to Corollary 3.12. The new declarations only assemble source
obligations, and the compatibility lemmas show that they are wrappers around the
existing obligation constructors.

### Next Step

The next milestone should add package-level public audits for the structured
routes, still keeping them definitionally tied to the existing public audits
from parts and hypotheses.

## Milestone 123: Structured Route Public Audits

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The package-level structured route introduced in Milestone 122 assembles source
obligations. Existing package public audits then expose the public Stage 1
comparison and Corollary 3.12 endpoint associated to any assembled source
obligations.

This milestone adds public-audit accessors for the structured routes, while
proving that they are definitionally tied to the older public audits from parts
and hypotheses.

### Purpose

This milestone lets downstream code request the public audit along the
structured-input route without rewriting through the subclaim route manually.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.publicAuditOfStructuredInputs
IUTStage1SourcePackage.publicAuditOfStructuredInputs_qSigned_le_thetaSigned
IUTStage1SourcePackage.publicAuditOfStructuredInputs_corollary312
IUTStage1SourcePackage.publicAuditOfStructuredInputs_eq_parts
IUTStage1SourcePackage.publicAuditOfStructuredHypotheses
IUTStage1SourcePackage.publicAuditOfStructuredHypotheses_qSigned_le_thetaSigned
IUTStage1SourcePackage.publicAuditOfStructuredHypotheses_corollary312
IUTStage1SourcePackage.publicAuditOfStructuredHypotheses_eq_parts
IUTStage1SourcePackage.publicAuditOfStructuredHypotheses_eq_hypotheses
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_publicAudit_from_structured_inputs_q_le_theta_example
unitThetaToy_source_publicAudit_from_structured_inputs_corollary_example
unitThetaToy_source_publicAudit_from_structured_inputs_eq_parts_example
unitThetaToy_source_publicAudit_from_structured_hypotheses_q_le_theta_example
unitThetaToy_source_publicAudit_from_structured_hypotheses_corollary_example
unitThetaToy_source_publicAudit_from_structured_hypotheses_eq_parts_example
unitThetaToy_source_publicAudit_from_structured_hypotheses_eq_hypotheses_example
```

### What This Tests

The toy examples verify that the structured public audit route exposes the same
q/theta signed comparison and Corollary 3.12 inequality already available from
the existing public audit route.

### Design Trap Avoided

The trap would be to make the structured route appear to justify the public
endpoint independently. The equality lemmas make the opposite explicit: the
structured public audits are just named wrappers around the previously existing
public audits.

### Next Step

The next milestone should add compact package audits for the structured routes,
parallel to `auditOfParts` and `auditOfHypotheses`.

## Milestone 124: Structured Route Compact Audits

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Milestone 123 exposed public audits for the structured routes. This milestone
adds compact source-package audits for the same routes, parallel to the existing
`auditOfParts` and `auditOfHypotheses` APIs.

The compact audit still packages source labels, source obligations, promoted
provider data, and the public comparison endpoint. It does not supply new
mathematical content beyond the assembled source obligations.

### Purpose

This milestone lets downstream code request the full package audit along the
structured-input route without manually rewriting through the older subclaim
route.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.auditOfStructuredInputs
IUTStage1SourcePackage.auditOfStructuredHypotheses
IUTStage1SourcePackage.auditOfStructuredInputs_eq_parts
IUTStage1SourcePackage.auditOfStructuredHypotheses_eq_parts
IUTStage1SourcePackage.auditOfStructuredHypotheses_eq_hypotheses
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_from_structured_inputs_example
unitThetaToy_source_audit_from_structured_hypotheses_example
unitThetaToy_source_audit_from_structured_inputs_q_le_theta_projection_example
unitThetaToy_source_audit_from_structured_hypotheses_q_le_theta_projection_example
unitThetaToy_source_audit_from_structured_inputs_eq_parts_example
unitThetaToy_source_audit_from_structured_hypotheses_eq_parts_example
unitThetaToy_source_audit_from_structured_hypotheses_eq_hypotheses_example
```

### What This Tests

The toy examples verify that structured route audits expose the same q/theta
signed comparison and reduce definitionally to the existing source audits.

### Design Trap Avoided

The trap would be to create an apparently independent audit path for structured
inputs. The equality lemmas keep the structured audits tied to the already
audited subclaim and hypothesis routes.

### Next Step

The next milestone should extend the combined hypothesis-route audit so that it
can also carry structured inputs while still separating side-condition audit
data from source-package audit data.

## Milestone 125: Structured Hypothesis Route Audit

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestone added compact audits for structured routes. This
milestone mirrors the earlier combined hypothesis-route audit, but uses
structured Theorem 3.11 inputs instead of raw subclaims.

The source-side separation remains unchanged: side-condition hypotheses are
audited separately from the source-package audit.

### Purpose

This milestone gives downstream code a single audit object for the structured
hypothesis route while preserving the two distinct audit components:

```text
side-condition hypothesis audit
source-package audit from structured inputs and hypotheses
```

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.StructuredHypothesisRouteAudit
IUTStage1SourcePackage.structuredHypothesisRouteAudit
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.sideConditionAudit
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.sourceAudit
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.qPilotLogVolumePositive
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.qSignedLeThetaSigned
IUTStage1SourcePackage.structuredHypothesisRouteAudit_sideConditionAudit_eq
IUTStage1SourcePackage.structuredHypothesisRouteAudit_sourceAudit_eq
IUTStage1SourcePackage.structuredHypothesisRouteAudit_sourceAudit_eq_hypothesisRoute
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_structured_hypothesis_route_audit_example
unitThetaToy_source_structured_hypothesis_route_side_condition_audit_example
unitThetaToy_source_structured_hypothesis_route_source_audit_example
unitThetaToy_source_structured_hypothesis_route_side_condition_audit_eq_example
unitThetaToy_source_structured_hypothesis_route_source_audit_eq_example
unitThetaToy_source_structured_hypothesis_route_source_audit_eq_hypothesis_route_example
unitThetaToy_source_structured_hypothesis_route_q_positive_example
unitThetaToy_source_structured_hypothesis_route_q_le_theta_example
```

### What This Tests

The toy examples verify that the structured combined route exposes the same
side-condition audit, source audit, q-pilot positivity, and q/theta signed
comparison as the corresponding standalone routes.

### Design Trap Avoided

The trap would be to hide the side-condition hypotheses inside structured
Theorem 3.11 inputs. This audit object keeps them separate. It also records that
the structured route source audit is definitionally the same source audit as the
older hypothesis route once the structured inputs are viewed through their
underlying subclaims.

### Next Step

The next milestone should expose the structured combined route as an audited
public endpoint, still reusing the existing source-package endpoint machinery.

## Milestone 126: Structured Audited Public Endpoints

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The current Stage 1 skeleton treats the public endpoint as a projection from
assembled source obligations through the existing public-audit machinery. This
milestone adds structured-input wrappers for that endpoint.

This is intentionally not a new proof of the debated Theorem 3.11 to Corollary
3.12 passage. It packages the same audit witness and the same equality to the
public audit, but along the structured routes introduced in the previous
milestones.

### Purpose

This milestone makes the structured routes usable at the same endpoint layer as
the older gap, parts, and hypotheses routes.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.auditedPublicEndpoint
IUTStage1SourcePackage.auditedPublicEndpointOfStructuredInputs
IUTStage1SourcePackage.auditedPublicEndpointOfStructuredHypotheses
IUTStage1SourcePackage.auditedPublicEndpointOfStructuredInputs_eq_parts
IUTStage1SourcePackage.auditedPublicEndpointOfStructuredHypotheses_eq_parts
IUTStage1SourcePackage.auditedPublicEndpointOfStructuredHypotheses_eq_hypotheses
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_structured_inputs_auditedPublicEndpoint_example
unitThetaToy_source_structured_hypotheses_auditedPublicEndpoint_example
unitThetaToy_source_structured_route_auditedPublicEndpoint_example
unitThetaToy_source_structured_inputs_auditedPublicEndpoint_eq_parts_example
unitThetaToy_source_structured_hypotheses_auditedPublicEndpoint_eq_parts_example
unitThetaToy_source_structured_hypotheses_auditedPublicEndpoint_eq_hypotheses_example
```

### What This Tests

The toy examples verify that structured inputs and structured hypotheses can be
fed to the audited endpoint layer, and that the resulting endpoint objects agree
with the existing parts and hypotheses endpoint routes.

### Design Trap Avoided

The trap would be to let an "audited endpoint" sound like a new mathematical
endpoint theorem. It is not. The endpoint is an existential package of a source
audit witness plus an equality to the public audit. The structured versions
reuse the same source-package machinery and are definitionally tied to the
older routes.

### Next Step

The next milestone should start replacing the toy-only q/theta comparison
payload with a more explicit abstract interface for the Corollary 3.12
comparison data, so the debated endpoint can be isolated from the toy model.

## Milestone 127: Abstract Corollary 3.12 Comparison Data

Lean files:

* `Iut/Stage1/CorollarySchema.lean`
* `Iut/Stage1/SourceObligations.lean`
* `Iut/Stage1/ToyCorollarySchema.lean`
* `Iut/Stage1/ToySourceObligations.lean`

### Source Check

Mochizuki's formalization report isolates Stage 1 as the implication from
IUT III, Theorem 3.11, to Corollary 3.12, and then further separates the final
`3.11.5 => 3.12` comparison. The same report describes this final comparison
as a simultaneous comparison of the `Theta`-pilot and `q`-pilot data in a
common container.

IUT III, Corollary 3.12, Step `(xi-d)`, is the source passage behind the signed
real comparison currently modeled here: after the relevant determinant and
log-volume operations, the endpoint is a signed real inequality comparing the
Theta-side upper bound with the q-side pilot quantity.

Scholze-Stix's critique focuses on whether the passage from abstract pilot data
to concrete pilot-object log-volumes is legitimate, especially when the
different Hodge-theater histories and real-line identifications are made
explicit. This milestone therefore does not claim that the comparison data has
been produced by IUT. It only names the data that the final endpoint consumes.

### Purpose

The previous toy endpoint mixed two roles:

* computing the toy q-side and Theta-side signed real values;
* packaging those values into the Corollary-3.12-shaped endpoint.

This milestone separates those roles. The new `Corollary312ComparisonData`
record is an abstract payload for the final Stage 1 endpoint. It stores the
Theta-side signed real, the q-side signed real, q-pilot positivity, and the
signed inequality `qSigned <= thetaSigned`. From this record, Lean constructs
the tagged pilot log-volumes, the `Stage1Comparison`, the Corollary 3.12-shaped
inequality, and a small public audit.

This is a deliberate boundary. Future source-facing modules should prove that
their own obligations produce `Corollary312ComparisonData`; they should not
rebuild the final endpoint from toy-specific arithmetic.

### Lean Declarations

In `CorollarySchema.lean`:

```text
Corollary312ComparisonData
Corollary312ComparisonData.thetaPilot
Corollary312ComparisonData.qPilot
Corollary312ComparisonData.qPilot_positive
Corollary312ComparisonData.corollary312
Corollary312ComparisonData.stage1Comparison
Corollary312ComparisonData.publicAudit
Corollary312ComparisonData.publicAudit_qSigned_le_thetaSigned
Corollary312ComparisonData.publicAudit_corollary312
Corollary312ComparisonData.publicAudit_stage1Comparison_recovers
```

In `SourceObligations.lean`:

```text
SourceObligationLedger.comparisonData
SourceObligationLedger.comparisonData_thetaSigned
SourceObligationLedger.comparisonData_qSigned
SourceObligationLedger.comparisonData_corollary312_eq
SourceObligationLedger.comparisonData_stage1Comparison_eq
SourceObligationLedger.comparisonData_publicAudit_eq
```

In `ToyCorollarySchema.lean`:

```text
unitThetaToyComparisonData
unitThetaToyComparisonData_corollary312
unitThetaToyStage1Comparison_eq_comparisonData
unitThetaToyStructuredStage1Comparison_eq_comparisonData
```

In `ToySourceObligations.lean`:

```text
unitThetaToyComparisonData_from_sourceObligations
unitThetaToyComparisonData_corollary312_from_sourceObligations
unitThetaToyComparisonData_stage1Comparison_eq_sourceObligations
```

### What This Tests

Lean now verifies that an abstract comparison payload alone is enough to recover
the signed Corollary 3.12 statement and the `Stage1Comparison` package. The toy
code verifies that the existing toy bridge and the source-obligation ledger both
factor through this same payload interface.

### Design Trap Avoided

The trap would be to make the final Corollary 3.12 endpoint look like a theorem
about the toy model itself. That would make it too easy to hide the disputed
transition inside the toy arithmetic or inside a generic source ledger.

This milestone keeps the final comparison payload small and explicit. It also
does not identify any Hodge theaters, real-line copies, or concrete pilot
objects. The only mathematical content of the payload is the signed real
comparison plus q-positivity. Producing that payload from genuine IUT data
remains a separate source obligation.

### Next Step

The next milestone should push this payload interface upward into the
source-package audit layer, so the public Stage 1 endpoint can expose the
comparison data record directly alongside the existing audit witness.

## Milestone 128: Source-Package Comparison Data Endpoint

Lean files:

* `Iut/Stage1/IUTSourceScaffold.lean`
* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The source check is the same boundary as Milestone 127, now moved one layer
upward. Mochizuki's formalization report separates the final `3.11.5 => 3.12`
comparison from the earlier source construction. Scholze-Stix's critique asks
whether the comparison of the relevant pilot-object data has really been
justified. Therefore the source-facing public endpoint should expose not only
the final signed inequality, but also the exact comparison payload that the
endpoint consumed.

This milestone still does not prove that genuine IUT data supplies the payload.
It only ensures that, once the source obligations have been promoted to a
ledger, the public source package can name and audit the resulting
`Corollary312ComparisonData`.

### Purpose

Milestone 127 introduced `Corollary312ComparisonData` at the ledger and toy
layers. This milestone exposes it through the non-toy source-package API.

The new source-package endpoint records:

* a source audit witness;
* the exact `Corollary312ComparisonData` produced by the promoted provider;
* the equality identifying that data with the package-level comparison data;
* the signed inequality, Corollary-3.12-shaped statement, and recovery theorem
  obtained from the data itself.

This gives future formalization work a narrower target: prove the source
obligations, then inspect the resulting comparison payload at the package
boundary.

### Lean Declarations

In `IUTSourceScaffold.lean`:

```text
IUTSourceObligationProvider.comparisonData
IUTSourceObligationProvider.comparisonData_corollary312_eq
IUTSourceObligationProvider.comparisonData_stage1Comparison_eq
```

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.comparisonData
IUTStage1SourcePackage.comparisonData_thetaSigned
IUTStage1SourcePackage.comparisonData_qSigned
IUTStage1SourcePackage.comparisonData_stage1Comparison_eq
IUTStage1SourcePackage.comparisonData_corollary312_eq
IUTStage1SourcePackage.ComparisonDataEndpoint
IUTStage1SourcePackage.auditedComparisonDataEndpoint
IUTStage1SourcePackage.auditedComparisonDataEndpointOfGap
IUTStage1SourcePackage.auditedComparisonDataEndpointOfParts
IUTStage1SourcePackage.auditedComparisonDataEndpointOfHypotheses
IUTStage1SourcePackage.auditedComparisonDataEndpointOfStructuredInputs
IUTStage1SourcePackage.auditedComparisonDataEndpointOfStructuredHypotheses
IUTStage1SourcePackage.Audit.comparisonData
IUTStage1SourcePackage.Audit.comparisonDataStage1Comparison
IUTStage1SourcePackage.Audit.comparisonDataCorollary312
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_auditedComparisonDataEndpoint_example
unitThetaToy_source_structured_hypotheses_auditedComparisonDataEndpoint_example
```

### What This Tests

The toy source example verifies that the package-level source endpoint can now
return the comparison-data endpoint directly. The structured-hypotheses example
checks the same route after the Theorem 3.11 subclaims and side-condition
hypotheses are assembled through the structured source interface.

### Design Trap Avoided

The trap would be to keep the new comparison-data record only at the toy or
ledger layer. Then the public source package would still expose only the old
triple of final facts, and future readers would have to reconstruct which
payload generated those facts.

This milestone keeps the endpoint honest: the source package names the data,
the data proves its own public audit, and the source audit witness remains
separate from the data. This separation is important for the Corollary 3.12
debate because the existence of an audit witness is not the same assertion as
the mathematical legitimacy of the source construction that produced it.

### Next Step

The next milestone should add projection theorems for the comparison-data
endpoint itself, so consumers can recover the audit witness, the data object,
and the three data-level public facts without unpacking the existential by hand.

## Milestone 129: Comparison Data Endpoint Projections

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Mochizuki's formalization report treats the final `3.11.5 => 3.12` portion as
the comparison of the q-pilot and Theta-pilot data after the preceding source
construction has supplied the needed common-container information. The
Scholze-Stix critique stresses that this comparison is exactly where hidden
identifications or untracked pilot-object transitions would matter.

The previous milestone exposed the comparison-data endpoint. This milestone
does not add new mathematical content. It makes the endpoint readable by adding
projection theorems, so future reviewers can inspect the source audit witness,
the comparison data object, and the data-level public facts without manually
destructing nested existential proofs.

### Purpose

`ComparisonDataEndpoint` is a proposition. That is intentional: it is an
audited theorem-level package, not computational data extracted from a proof.
Because proof-level existential data is awkward to consume directly, this
milestone adds a namespace of projection theorems.

The projections recover:

* the existence of the source audit witness;
* the existence of the comparison data object and its equality to the package
  comparison data;
* the signed q-to-Theta inequality;
* the Corollary-3.12-shaped endpoint;
* the Stage 1 recovery equality;
* equality with the comparison data's own public audit.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.ComparisonDataEndpoint.sourceAuditExists
IUTStage1SourcePackage.ComparisonDataEndpoint.comparisonDataExists
IUTStage1SourcePackage.ComparisonDataEndpoint.qSignedLeThetaSigned
IUTStage1SourcePackage.ComparisonDataEndpoint.corollary312Endpoint
IUTStage1SourcePackage.ComparisonDataEndpoint.stageRecoversQSignedLeThetaSigned
IUTStage1SourcePackage.ComparisonDataEndpoint.publicAudit
IUTStage1SourcePackage.ComparisonDataEndpoint.publicAudit_eq_comparisonData_publicAudit
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_comparisonDataEndpoint_q_le_theta_example
unitThetaToy_source_comparisonDataEndpoint_corollary_example
unitThetaToy_source_structured_hypotheses_comparisonDataEndpoint_publicAudit_example
```

### What This Tests

The toy examples verify that the projections work both for the direct source
obligation route and for the structured-hypotheses route. In particular, the
examples recover the q-to-Theta comparison, the Corollary-3.12-shaped statement,
and the equality to the comparison data's own public audit.

### Design Trap Avoided

The trap would be to make `ComparisonDataEndpoint` opaque in practice. If every
consumer must manually unpack nested existentials, reviewers will have a harder
time seeing whether a later proof uses the source audit, the data payload, or
the final inequality. The projection theorems keep those roles visible.

The other trap would be to turn the endpoint into computational data extracted
from a proposition. We avoid that. The projections are theorem-level facts, so
they preserve the distinction between audited proof packaging and genuine
mathematical construction of the source comparison data.

### Next Step

The next milestone should connect these comparison-data endpoint projections
back to the older public endpoint, showing explicitly that the old public audit
triple and the new comparison-data endpoint present the same final
Corollary-3.12-shaped information.

## Milestone 130: Comparison Endpoint to Public Audit Bridge

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The local source checks for Milestones 127-129 remain controlling here. The
formalization report identifies the final Stage 1 target as the `3.11.5 =>
3.12` comparison, while the Scholze-Stix critique asks whether the final
pilot-object comparison has been justified rather than merely restated.

This milestone is bookkeeping at that boundary. It verifies that the older
public audit triple and the newer comparison-data endpoint are two presentations
of the same package-level endpoint, not two independent endpoint notions.

### Purpose

After adding `ComparisonDataEndpoint`, there are now two public views of the
same final Stage 1 information:

* `package.publicAudit obligations`, the older triple of q-to-Theta inequality,
  Corollary-3.12-shaped statement, and Stage 1 recovery equality;
* `package.ComparisonDataEndpoint obligations`, the newer audited package that
  also names the comparison-data payload.

This milestone adds theorem-level bridges from the newer endpoint back to the
older public audit and audited-public-endpoint existential.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.ComparisonDataEndpoint.publicAudit_eq_package_publicAudit
IUTStage1SourcePackage.ComparisonDataEndpoint.auditedPublicEndpoint
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_comparisonDataEndpoint_publicAudit_eq_publicAudit_example
unitThetaToy_source_comparisonDataEndpoint_auditedPublicEndpoint_example
```

### What This Tests

The toy examples verify that a comparison-data endpoint can be projected back
to the older public audit equality and to the older audited public endpoint
existential. This gives downstream consumers permission to use either public
view without changing the final Corollary-3.12-shaped statement.

### Design Trap Avoided

The trap would be to let `ComparisonDataEndpoint` become a parallel endpoint
with subtly different meaning. That would be especially bad in the Corollary
3.12 setting, where hidden changes of comparison target are exactly what we are
trying to avoid.

The bridge theorems make the relationship explicit: the comparison-data endpoint
adds a named payload, but it does not change the public audit's mathematical
content.

### Next Step

The next milestone should start naming the source-side comparison payload
inputs more explicitly, so future work can distinguish the signed real payload
from the pre-ledger chart, selected output, and q-membership data that produce
it.

## Milestone 131: Source-Side Comparison Payload Inputs

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`
* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The relevant source boundary is still the final `3.11.5 => 3.12` comparison
identified in Mochizuki's formalization report. That passage treats the final
comparison as something obtained after earlier source data have supplied a
common-container setting, selected output data, and log-volume comparison data.

Scholze-Stix's critique emphasizes that the crucial issue is not the formal
shape of the final real inequality by itself, but whether the pilot-object data
and the identifications leading to it have been legitimately produced. This
milestone responds to that pressure by naming the pre-ledger inputs that feed
the signed comparison payload, rather than letting them disappear behind the
ledger promotion.

### Purpose

`Corollary312ComparisonData` is the final signed payload. It contains only the
Theta signed real, the q signed real, q-positivity, and the signed comparison.
It should not be confused with the source-side chart and membership data that
produce the signed comparison.

This milestone introduces `IUTStage1PreLedgerData.ComparisonPayloadInputs`.
It records the pre-ledger facts used to derive the q-to-Theta signed inequality:

* theta chart triviality;
* q-side charting;
* Theta-side charting;
* the selected comparison object holding the q point;
* the q-to-target-volume inequality;
* the target-volume-to-Theta inequality.

Q-positivity remains outside this record. That is deliberate: q-positivity is a
promotion side condition, not a chart/membership input. Combining
`ComparisonPayloadInputs` with q-positivity produces a
`Corollary312ComparisonData` object.

### Lean Declarations

In `IUTStage1Data.lean`:

```text
IUTStage1PreLedgerData.ComparisonPayloadInputs
IUTStage1PreLedgerData.comparisonPayloadInputs
IUTStage1PreLedgerData.ComparisonPayloadInputs.qSignedLeTargetSigned
IUTStage1PreLedgerData.ComparisonPayloadInputs.targetSignedLeThetaSigned
IUTStage1PreLedgerData.ComparisonPayloadInputs.qSignedLeThetaSigned
IUTStage1PreLedgerData.ComparisonPayloadInputs.comparisonData
IUTStage1PreLedgerData.ComparisonPayloadInputs.comparisonData_corollary312
```

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.comparisonPayloadInputs
IUTStage1SourcePackage.comparisonPayloadInputs_qSigned_le_thetaSigned
IUTStage1SourcePackage.comparisonDataFromPayloadInputs
IUTStage1SourcePackage.comparisonDataFromPayloadInputs_thetaSigned
IUTStage1SourcePackage.comparisonDataFromPayloadInputs_qSigned
IUTStage1SourcePackage.comparisonDataFromPayloadInputs_corollary312
```

In the toy examples:

```text
unitThetaToyComparisonPayloadInputs
unitThetaToy_comparisonPayloadInputs_q_le_theta_example
unitThetaToy_comparisonPayloadInputs_corollary_example
unitThetaToy_source_comparisonPayloadInputs_q_le_theta_example
unitThetaToy_source_comparisonDataFromPayloadInputs_corollary_example
```

### What This Tests

The toy pre-ledger examples verify that the new source-side input record
recovers the q-to-Theta comparison and, with q-positivity from the promotion
obligations, recovers the Corollary-3.12-shaped statement. The source-package
examples verify that the same record is available through the public source API.

### Design Trap Avoided

The trap would be to treat the final signed payload as if it were the source
construction itself. This milestone keeps the two layers separate:

* `ComparisonPayloadInputs` records source-side chart, selected-output, and
  membership facts;
* `Corollary312ComparisonData` records the final signed real payload;
* q-positivity remains a promotion obligation.

This separation matters for the Corollary 3.12 debate because the hard question
is exactly whether the source-side construction legitimately supplies the final
payload.

### Next Step

The next milestone should add an audit namespace for `ComparisonPayloadInputs`,
parallel to the endpoint projection namespace, so later modules can recover
each source-side input without depending on the internal record field names.

## Milestone 132: Comparison Payload Input Projections

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`
* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

This remains source-side bookkeeping for the `3.11.5 => 3.12` comparison
boundary. The formalization report separates this final comparison from the
earlier construction, while the Scholze-Stix critique warns against hiding
pilot-object identifications or comparison choices. Making the source-side
payload inputs projectable keeps the pre-ledger route inspectable.

### Purpose

Milestone 131 introduced `ComparisonPayloadInputs`. This milestone adds public
projection names for its fields, and source-package wrappers for the same facts.

The projections expose:

* theta chart triviality;
* q-side charting;
* Theta-side charting;
* the selected comparison object holding the q point;
* the q-to-target-volume inequality;
* the target-volume-to-Theta inequality;
* the resulting q-to-Theta inequality.

### Lean Declarations

In `IUTStage1Data.lean`:

```text
IUTStage1PreLedgerData.ComparisonPayloadInputs.thetaChartTrivial
IUTStage1PreLedgerData.ComparisonPayloadInputs.qCharted
IUTStage1PreLedgerData.ComparisonPayloadInputs.thetaCharted
IUTStage1PreLedgerData.ComparisonPayloadInputs.chosenHolds
```

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.comparisonPayloadInputs_thetaChartTrivial
IUTStage1SourcePackage.comparisonPayloadInputs_qCharted
IUTStage1SourcePackage.comparisonPayloadInputs_thetaCharted
IUTStage1SourcePackage.comparisonPayloadInputs_chosenHolds
IUTStage1SourcePackage.comparisonPayloadInputs_qSigned_le_targetSigned
IUTStage1SourcePackage.comparisonPayloadInputs_targetSigned_le_thetaSigned
```

In the toy examples:

```text
unitThetaToy_comparisonPayloadInputs_thetaChartTrivial_example
unitThetaToy_comparisonPayloadInputs_qCharted_example
unitThetaToy_comparisonPayloadInputs_chosenHolds_example
unitThetaToy_source_comparisonPayloadInputs_qCharted_example
unitThetaToy_source_comparisonPayloadInputs_target_le_theta_example
```

### What This Tests

The toy examples verify that downstream modules can recover the charting,
chosen-output, and target-bound facts through named projections rather than by
accessing the internal structure fields directly.

### Design Trap Avoided

The trap would be to make the source-side input record visible but practically
opaque. If reviewers have to remember exact field names or destruct the record
manually, the formalization becomes harder to audit. The projection theorems
make the intended public API explicit.

This also keeps the final signed payload separate from the source-side route:
these projections expose how the q-to-Theta comparison is sourced, but they do
not add q-positivity or collapse the result into the final
`Corollary312ComparisonData`.

### Next Step

The next milestone should relate `ComparisonPayloadInputs` to the older
`IUTStage1PreLedgerData.Audit`, showing explicitly that the pre-ledger audit
contains the same chart/membership comparison facts.

## Milestone 133: Pre-Ledger Audit to Payload Inputs

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`

### Source Check

This milestone continues the source-side bookkeeping around the final
`3.11.5 => 3.12` comparison. The local source model now distinguishes the
pre-ledger audit, the source-side comparison payload inputs, and the final
signed comparison payload. The Scholze-Stix concern about hidden comparison
steps motivates making these relationships explicit.

### Purpose

`IUTStage1PreLedgerData.Audit` predates `ComparisonPayloadInputs`. It already
contains the charting, selected-output, q-membership, and target-bound facts
needed for the q-to-Theta comparison. This milestone adds explicit bridges from
the older audit to the newer source-side payload-input record.

### Lean Declarations

In `IUTStage1Data.lean`:

```text
IUTStage1PreLedgerData.Audit.comparisonPayloadInputs
IUTStage1PreLedgerData.Audit.comparisonPayloadInputs_eq_data
IUTStage1PreLedgerData.Audit.comparisonPayloadInputs_qSignedLeThetaSigned
IUTStage1PreLedgerData.Audit.qSignedLeThetaSigned
```

In `IUTStage1DataExample.lean`:

```text
unitThetaToy_preLedgerAudit_comparisonPayloadInputs_eq_example
unitThetaToy_preLedgerAudit_q_le_theta_example
```

### What This Tests

The toy examples verify that the canonical pre-ledger audit yields the same
payload-input record as `data.comparisonPayloadInputs`, and that the q-to-Theta
comparison can be recovered through the audit-to-payload bridge.

### Design Trap Avoided

The trap would be to maintain two independent sources of the same chart and
membership facts: the older pre-ledger audit and the newer payload-input record.
This milestone ties them together, so the payload-input route is visibly a
projection of the already-audited pre-ledger data.

This still does not add q-positivity or source normalization. Those remain
promotion obligations, preserving the separation between source-side comparison
inputs and the final signed payload.

### Next Step

The next milestone should lift the audit-to-payload bridge to the
`IUTStage1SourcePackage` level, so source-package audits can recover the
comparison payload inputs without going back through `preLedger.audit`
manually.

## Milestone 134: Source Audit to Payload Inputs

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The source-facing package audit is the public checklist for the local Stage 1
scaffold. Since the contested `3.11.5 => 3.12` endpoint depends on the
source-side comparison route, the source audit should be able to point directly
to the comparison payload inputs, not only to the final signed endpoint.

This follows the same source-pressure from the formalization report and the
Scholze-Stix critique: the comparison payload must remain connected to the
charting, chosen-output, and membership facts that produce it.

### Purpose

Milestone 133 related the pre-ledger audit to `ComparisonPayloadInputs`. This
milestone lifts that bridge to `IUTStage1SourcePackage.Audit`, which is the
source-package audit object used by the public source endpoints.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.Audit.comparisonPayloadInputs
IUTStage1SourcePackage.Audit.comparisonPayloadInputsEqPackage
IUTStage1SourcePackage.Audit.comparisonPayloadInputsQSignedLeThetaSigned
IUTStage1SourcePackage.Audit.comparisonPayloadInputsEqPreLedgerAudit
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_comparisonPayloadInputs_eq_package_example
unitThetaToy_source_audit_comparisonPayloadInputs_eq_preLedgerAudit_example
```

### What This Tests

The toy source examples verify that a source-package audit recovers the same
payload-input record as the package accessor and as the underlying pre-ledger
audit. Thus, the package audit, package accessor, and pre-ledger audit all
agree about the source-side facts behind the q-to-Theta comparison.

### Design Trap Avoided

The trap would be to make source-package audits talk only about final endpoint
facts while the source-side payload-input route lives elsewhere. That would
make it easier for later code to use the endpoint without showing how the
comparison route was audited.

This milestone keeps the audit path explicit: source audit to payload inputs,
payload inputs to signed comparison, and signed comparison to the public
Corollary-3.12-shaped endpoint.

### Next Step

The next milestone should relate `comparisonDataFromPayloadInputs` to the
promoted ledger's `comparisonData`, showing explicitly where the payload built
from source-side inputs meets the payload exported by the promoted source
ledger.

## Milestone 135: Payload Inputs Meet Promoted Ledger Data

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

Mochizuki's formalization report isolates the final `3.11.5 => 3.12` step as
the place where the comparison data becomes the Corollary 3.12 endpoint. The
same report describes this as the comparison of the q-pilot data and
Theta-pilot data in a common-container setting.

Scholze-Stix's critique focuses on whether the passage from the source-side
pilot-object discussion to the final real inequality is legitimate. In our
local scaffold, that passage now has two adjacent objects: the comparison data
built directly from source-side payload inputs, and the comparison data exported
by the promoted source ledger. This milestone proves that these are the same
payload.

### Purpose

The source route now has three layers:

* `ComparisonPayloadInputs`: chart, selected-output, membership, and
  target-bound facts;
* `comparisonDataFromPayloadInputs`: the signed payload built from those inputs
  plus q-positivity;
* `comparisonData`: the signed payload exported by the promoted ledger/provider.

This milestone relates the second and third layers. That gives future work an
explicit point where source-side audit facts meet the public promoted-ledger
endpoint.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.comparisonDataFromPayloadInputs_eq_comparisonData
IUTStage1SourcePackage.comparisonDataFromPayloadInputs_stage1Comparison_eq
IUTStage1SourcePackage.comparisonDataFromPayloadInputs_corollary312_eq
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_comparisonDataFromPayloadInputs_eq_comparisonData_example
unitThetaToy_source_comparisonDataFromPayloadInputs_stage_eq_example
```

### What This Tests

The toy examples verify that the source-side payload construction and promoted
ledger payload agree, both as comparison data and after packaging into
`Stage1Comparison`.

### Design Trap Avoided

The trap would be to let the source-side payload and the promoted-ledger payload
drift into two independent presentations of the endpoint. The equality bridge
ensures that future code cannot silently use a different final signed payload
when moving from source inputs to the promoted ledger.

This is still not a proof of IUT. It is a formal interface check: once the
source obligations are supplied, the payload computed from the audited
source-side comparison route is the payload exported at the public endpoint.

### Next Step

The next milestone should expose this equality through
`IUTStage1SourcePackage.Audit`, so source audits can recover not only the
payload inputs and final comparison data, but also the bridge between them.

## Milestone 136: Source Audit Payload-to-Data Bridge

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The local Stage 1 source scaffold now has a named bridge between the source-side
payload inputs and the promoted ledger comparison data. This milestone exposes
that bridge through the source audit object itself. That matches the project
discipline around the Scholze-Stix/Mochizuki disagreement: an audit should not
only certify the final endpoint, but also show how the source-side comparison
route reaches that endpoint.

### Purpose

Milestone 135 added package-level equality between
`comparisonDataFromPayloadInputs` and `comparisonData`. This milestone adds the
same bridge as an `IUTStage1SourcePackage.Audit` projection.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.Audit.comparisonDataFromPayloadInputsEqComparisonData
IUTStage1SourcePackage.Audit.comparisonDataFromPayloadInputsStage1ComparisonEq
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_payloadData_eq_comparisonData_example
unitThetaToy_source_audit_payloadStage_eq_comparisonStage_example
```

### What This Tests

The toy source-audit examples verify that the audit object can recover the
equality between the source-built payload and the final comparison data, and
also the equality after packaging both sides as `Stage1Comparison`.

### Design Trap Avoided

The trap would be to make the audit expose payload inputs and final data as two
unrelated facts. The new audit projections show that the source-side payload
route and promoted-ledger route meet at the same comparison data object.

### Next Step

The next milestone should add a compact source audit summary for the complete
payload route: source payload inputs, payload-to-data equality, final
comparison data, and public endpoint recovery.

## Milestone 137: Source Audit Payload Route Summary

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The formalization report frames the final Stage 1 comparison as the
`3.11.5 => 3.12` endpoint, while Scholze-Stix focus on whether the source-side
pilot-object comparison legitimately reaches the final real inequality. The
local scaffold now has individual bridge theorems for this route. This
milestone packages those theorem-level facts into one source-audit summary.

### Purpose

`IUTStage1SourcePackage.Audit.PayloadRouteSummary` records the complete audited
path from source payload inputs to endpoint data:

* payload inputs agree with the package payload inputs;
* payload-built comparison data equals the source audit's final comparison data;
* final comparison data agrees with the package comparison data;
* the final comparison data has the same `Stage1Comparison` and Corollary 3.12
  proof as the promoted provider;
* the comparison data recovers its own signed inequality endpoint.

This does not add new mathematical assumptions. It is a compact public view of
the route already proved by earlier milestones.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.Audit.PayloadRouteSummary
IUTStage1SourcePackage.Audit.payloadRouteSummary
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_audit_payloadRouteSummary_example
unitThetaToy_source_audit_payloadRouteSummary_stage_eq_example
```

### What This Tests

The toy examples verify that the source audit can produce the compact payload
route summary and that downstream code can recover a concrete summary field,
namely equality of the final `Stage1Comparison` with the promoted provider's
`Stage1Comparison`.

### Design Trap Avoided

The trap would be to leave the source-to-endpoint route scattered across many
projection names. That is hard to audit and increases the chance that later code
uses only the final endpoint while bypassing the source-side route. The summary
keeps the full path visible as a single theorem-level package.

### Next Step

The next milestone should connect this payload route summary to
`ComparisonDataEndpoint`, so the compact audit route is available at the same
public endpoint boundary as the comparison-data endpoint.

## Milestone 138: Payload Route Summary at the Comparison Endpoint

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The comparison-data endpoint is the public boundary for the local
Corollary-3.12-shaped comparison. Since the source audit route now has a compact
payload summary, the endpoint should expose that summary as well. This keeps the
endpoint aligned with the source-side route from chart/membership data to final
comparison data, which is precisely the kind of route that matters in the
Scholze-Stix/Mochizuki disagreement.

### Purpose

Milestone 137 added `IUTStage1SourcePackage.Audit.PayloadRouteSummary`. This
milestone connects it to `ComparisonDataEndpoint`, so consumers of the endpoint
can recover a source audit witness together with the full payload route summary.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.ComparisonDataEndpoint.payloadRouteSummaryExists
IUTStage1SourcePackage.ComparisonDataEndpoint.payloadRouteSummaryAndPublicAudit
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_endpoint_payloadRouteSummary_exists_example
unitThetaToy_source_endpoint_payloadRouteSummary_publicAudit_example
```

### What This Tests

The toy endpoint examples verify that the public comparison-data endpoint can
recover the compact source audit payload route summary, and can do so while
also preserving the equality to the package public audit.

### Design Trap Avoided

The trap would be to make `ComparisonDataEndpoint` expose only the final signed
payload while the source-side route summary remains available only through a
separate audit theorem. This bridge keeps the public endpoint tied to the route
that produced it.

### Next Step

The next milestone should expose the same endpoint-level payload route summary
through the structured-hypothesis route, so the highest-level structured source
path carries the complete source-to-endpoint audit.

## Milestone 139: Structured Route Payload Summary at the Endpoint

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The structured-hypothesis route is our current highest-level local abstraction
for the Theorem 3.11 input package plus source side conditions. IUT III,
Corollary 3.12, Step `(xi)` treats the multiradial construction of Theorem 3.11
as producing output data that is then fed into the final comparison. Scholze and
Stix focus on whether this passage hides identifications when one reaches the
real-valued comparison. Therefore the structured route should not merely produce
the final public endpoint; it should also expose the same payload-route audit
summary that the lower source audit and comparison endpoint expose.

### Purpose

Milestone 138 made `ComparisonDataEndpoint` recover a compact source-audit
payload route summary. This milestone lifts that visibility to
`StructuredHypothesisRouteAudit`, so the route that starts from structured
Theorem 3.11 inputs can carry the complete source-to-endpoint audit package.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.payloadRouteSummary
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.comparisonDataEndpointPayloadRouteSummary
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_structured_route_payloadRouteSummary_example
unitThetaToy_source_structured_route_endpoint_payloadRouteSummary_example
```

### What This Tests

The toy route examples verify that the structured-hypothesis audit can recover
the compact payload summary from its source audit, and that the corresponding
structured comparison-data endpoint has the same public audit as
`publicAuditOfStructuredHypotheses`.

### Design Trap Avoided

The trap would be to let the structured route become a clean-looking wrapper
that forgets the route from source-side payload inputs to final comparison data.
That would make later code easier to write but harder to audit. The new theorem
keeps the endpoint equality and payload route summary visible at the same
structured boundary.

### Next Step

The next milestone should expose individual fields of the structured route
payload summary, especially the equalities from structured route source audit to
comparison data, so downstream proof scripts can cite named facts without
unfolding the compact summary.

## Milestone 140: Structured Route Payload Projection Theorems

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The source issue is unchanged from Milestone 139: the final Stage 1 boundary
must keep visible how structured Theorem 3.11 data reaches the
Corollary-3.12-shaped comparison. The local paper trail points to IUT III,
Corollary 3.12, Step `(xi)`, where Theorem 3.11 output is fed into the final
comparison, and to Scholze-Stix's warning that real-valued comparisons should
not hide identifications. Named projections are a small but important response:
they let later proof steps cite each equality in the route explicitly.

### Purpose

Milestone 139 exposed the compact payload summary at the structured route. This
milestone adds named projection theorems for its fields. The compact summary is
still useful as one package, but individual fields are now available without
manual record projection.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.payloadInputsEqPackage
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.payloadDataEqComparisonData
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.comparisonDataEqPackage
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.stage1ComparisonEqProvider
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.corollary312EqProvider
IUTStage1SourcePackage.StructuredHypothesisRouteAudit.comparisonDataRecovers
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_structured_route_payloadData_eq_comparisonData_example
unitThetaToy_source_structured_route_comparisonData_eq_package_example
unitThetaToy_source_structured_route_comparisonData_recovers_example
```

### What This Tests

The toy examples verify the most important downstream uses: recovering the
payload-built comparison data, identifying the route audit's comparison data
with the package comparison data, and recovering the final
Corollary-3.12-shaped statement from the route audit's `Stage1Comparison`.

### Design Trap Avoided

The trap would be to make all later proofs unfold
`Audit.PayloadRouteSummary`. That would work in Lean but would make human
review harder. The named projections keep the audit route readable while
preserving the compact summary as the canonical package.

### Next Step

The next milestone should add the analogous named projection layer at the
comparison endpoint itself, so endpoint-level consumers can cite the payload
route fields directly.

## Milestone 141: Endpoint Payload Projection Theorems

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The comparison-data endpoint is the public boundary for the current Stage 1
formalization of the `3.11.5 => 3.12` comparison. IUT III, Corollary 3.12,
Step `(xi)`, is where the source-side Theorem 3.11 output is used to reach the
real-valued comparison. Since Scholze-Stix's objection concerns hidden
identifications at that boundary, endpoint-level users should be able to cite
the route facts without unfolding either the endpoint existential or the compact
payload summary.

### Purpose

Milestone 140 added named payload projections for the structured route audit.
This milestone adds the corresponding endpoint-level projections. Because
`ComparisonDataEndpoint` stores its source audit witness existentially, each
projection returns an existential witness together with the requested route
field.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.ComparisonDataEndpoint.payloadInputsEqPackageExists
IUTStage1SourcePackage.ComparisonDataEndpoint.payloadDataEqComparisonDataExists
IUTStage1SourcePackage.ComparisonDataEndpoint.comparisonDataEqPackageExists
IUTStage1SourcePackage.ComparisonDataEndpoint.stage1ComparisonEqProviderExists
IUTStage1SourcePackage.ComparisonDataEndpoint.corollary312EqProviderExists
IUTStage1SourcePackage.ComparisonDataEndpoint.comparisonDataRecoversExists
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_endpoint_payloadData_eq_comparisonData_exists_example
unitThetaToy_source_endpoint_comparisonData_recovers_exists_example
```

### What This Tests

The toy examples verify that a public comparison-data endpoint can recover a
source audit witnessing equality between payload-built comparison data and the
audit comparison data, and can recover the final Corollary-3.12-shaped
`Stage1Comparison` statement.

### Design Trap Avoided

The trap would be to use the endpoint only as a black-box proof of the final
comparison. These existential projection theorems keep the endpoint honest:
the final comparison remains connected to the audited payload route, even when
the caller starts from the public endpoint.

### Next Step

The next milestone should connect the structured route and endpoint projection
layers by proving that the structured endpoint exposes the same existential
payload facts as the ordinary comparison endpoint.

## Milestone 142: Structured Endpoint Payload Projection Bridges

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The structured-hypothesis endpoint is the formal route from structured
Theorem 3.11 inputs and source side conditions to the current
Corollary-3.12-shaped comparison endpoint. IUT III, Corollary 3.12, Step
`(xi)`, treats the Theorem 3.11 output as the source of the final comparison,
while the Scholze-Stix critique asks whether the comparison endpoint hides an
identification of real-line copies. This milestone keeps the structured endpoint
from becoming a parallel endpoint notion: its payload facts are explicitly
obtained by applying the ordinary `ComparisonDataEndpoint` projections to
`auditedComparisonDataEndpointOfStructuredHypotheses`.

### Purpose

Milestone 141 added existential payload projections for arbitrary comparison
data endpoints. This milestone adds structured-endpoint bridge theorems that
specialize those projections to the structured-hypothesis route.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.structuredEndpointPayloadInputsEqPackageExists
IUTStage1SourcePackage.structuredEndpointPayloadDataEqComparisonDataExists
IUTStage1SourcePackage.structuredEndpointComparisonDataEqPackageExists
IUTStage1SourcePackage.structuredEndpointStage1ComparisonEqProviderExists
IUTStage1SourcePackage.structuredEndpointCorollary312EqProviderExists
IUTStage1SourcePackage.structuredEndpointComparisonDataRecoversExists
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_structured_endpoint_payloadData_eq_comparisonData_exists_example
unitThetaToy_source_structured_endpoint_comparisonData_recovers_exists_example
```

### What This Tests

The toy examples verify that the structured endpoint can recover the same
existential payload-built-data equality and comparison-data recovery facts as
the ordinary comparison endpoint.

### Design Trap Avoided

The trap would be to duplicate endpoint reasoning for structured hypotheses and
accidentally create two subtly different endpoint APIs. The bridge theorems
avoid that: they are thin specializations of the ordinary endpoint projections.

### Next Step

The next milestone should add a compact structured endpoint audit summary that
packages these existential endpoint projections with the equality to
`publicAuditOfStructuredHypotheses`.

## Milestone 143: Compact Structured Endpoint Audit Summary

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The formalization is still operating at the local Stage 1 boundary around IUT
III, Theorem 3.11, and Corollary 3.12, Step `(xi)`. The relevant issue for this
milestone is auditability rather than new mathematics: the endpoint should carry
one coherent source-audit witness from structured Theorem 3.11 input data to
the public Corollary-3.12-shaped comparison. This is aligned with the
Scholze-Stix diagnostic requirement that endpoint comparisons not hide the
route by which source-side objects became comparable.

### Purpose

Milestone 142 exposed structured endpoint facts as existential projections.
This milestone packages the same information into one compact summary with a
single source audit witness. That avoids the ambiguity of several existential
facts that might, syntactically, be witnessed by different source audits.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.StructuredEndpointAuditSummary
IUTStage1SourcePackage.structuredEndpointAuditSummary
IUTStage1SourcePackage.StructuredEndpointAuditSummary.sourceAudit
IUTStage1SourcePackage.StructuredEndpointAuditSummary.payloadRouteSummary
IUTStage1SourcePackage.StructuredEndpointAuditSummary.endpointPublicAuditEq
IUTStage1SourcePackage.StructuredEndpointAuditSummary.payloadDataEqComparisonData
IUTStage1SourcePackage.StructuredEndpointAuditSummary.comparisonDataEqPackage
IUTStage1SourcePackage.StructuredEndpointAuditSummary.comparisonDataRecovers
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_structured_endpoint_audit_summary_example
unitThetaToy_source_structured_endpoint_summary_publicAudit_eq_example
unitThetaToy_source_structured_endpoint_summary_payloadData_eq_example
unitThetaToy_source_structured_endpoint_summary_recovers_example
```

### What This Tests

The toy examples verify construction of the compact summary and its main
projections: public-audit equality, payload-built comparison data equality, and
recovery of the final Corollary-3.12-shaped statement from the summary's
`Stage1Comparison`.

### Design Trap Avoided

The trap would be to accumulate many endpoint-level existential facts without
recording that they come from a single route. The compact summary makes the
single-witness discipline explicit while still allowing downstream code to use
the more flexible existential projections when appropriate.

### Next Step

The next milestone should compare the compact structured endpoint summary with
the structured route audit directly, proving that its source audit and payload
summary are exactly the ones obtained from `structuredHypothesisRouteAudit`.

## Milestone 144: Structured Endpoint Summary Route Coherence

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The source-side concern remains the same: at the IUT III, Theorem 3.11 to
Corollary 3.12 boundary, the public endpoint should not obscure how structured
input data reaches the comparison. This milestone is a bookkeeping check
against a formalization trap rather than a new mathematical assertion. It
records that the compact structured endpoint summary is built from the same
structured route audit introduced for the Theorem 3.11 input and side-condition
route.

### Purpose

Milestone 143 introduced `StructuredEndpointAuditSummary`. This milestone adds
explicit coherence theorems tying that summary back to
`structuredHypothesisRouteAudit`. Reviewers can now cite named theorems instead
of unfolding the summary constructor to see where the source audit and payload
summary came from.

### Lean Declarations

In `IUTStage1Source.lean`:

```text
IUTStage1SourcePackage.structuredEndpointAuditSummary_sourceAudit_eq_routeAudit
IUTStage1SourcePackage.structuredEndpointAuditSummary_sourceAudit_eq_auditOfStructuredHypotheses
IUTStage1SourcePackage.structuredEndpointAuditSummary_payloadRouteSummary_eq_routeAudit
IUTStage1SourcePackage.structuredEndpointAuditSummary_publicAuditEq_eq_routeAudit
```

In `IUTStage1SourceExample.lean`:

```text
unitThetaToy_source_structured_endpoint_summary_sourceAudit_eq_route_example
unitThetaToy_source_structured_endpoint_summary_payloadRoute_eq_route_example
```

### What This Tests

The toy examples verify that the compact structured endpoint summary's source
audit and payload route summary are definitionally the same data obtained from
the structured route audit.

### Design Trap Avoided

The trap would be for the compact summary to improve readability while silently
introducing a second route witness. The coherence theorems rule that out at the
API level: the summary is a wrapper around the existing structured route audit.

### Next Step

The next milestone should start moving from endpoint packaging back into the
source-side mathematical content by adding a compact checklist for the
structured Theorem 3.11 input claims used by the route.

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
by case analysis and `simp`.

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

### Source Check

In IUT I, Remark 3.1.2 describes reconstruction of the function field of
`X_K` equipped with the natural action of

```text
Gal(X_K / C_K) ~= Pi_CK / Pi_XK.
```

For this to behave as an actual deck/Galois group action on the reconstructed
function field, the quotient group must act faithfully. Otherwise a nontrivial
deck element could be invisible on the reconstructed function field, weakening
the interpretation of the quotient as the Galois group of the cover.

This milestone also records the exact kernel of the induced `Pi_CK` action:
the subgroup `Pi_XK` acts trivially after quotienting, and no larger subgroup
does.

### Lean Move

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

### Lean Move

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

### Lean Move

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

### Lean Move

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

### Lean Move

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

### Lean Move

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

### Source Check

IUT I, Remark 3.1.2, frames the theta reconstruction around the inclusion
`Pi_XK <= Pi_CK` and the corresponding cover relation between `X_K` and `C_K`.
The formal model should therefore remember not only labels for `X_K` and `C_K`,
but also the morphism connecting the source and target orbicurves.

This milestone is still below the actual construction of finite etale morphisms
in algebraic geometry. It replaces an untyped string slot with a typed morphism
placeholder whose source and target are fixed by Lean.

### Lean Move

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

## Stage 1 Math Milestone 104: Common Hulls from Union Containment

Lean files:

* `Iut/Foundations/IndeterminacyRelation.lean`
* `Iut/Foundations/CommonTargetBound.lean`
* `Iut/Stage1/ToyFamilyBounds.lean`

### Source Check

IUT III describes the Theta-side quantity in Corollary 3.12 as the log-volume
of a holomorphic hull of the union of possible images of the Theta-pilot object,
with those possible images subject to the indeterminacies `(Ind1)`, `(Ind2)`,
and `(Ind3)`. This is also the point isolated in the Scholze-Stix discussion:
one has to know exactly which concrete/abstract pilot images are being compared
and which real-line identifications are in force.

The previous formal layer had a `targetUnion`, but the toy common hull was
still built by direct family-wise containment. This milestone makes the union
route primary.

### Lean/API Check

The region-family layer now defines:

```text
RegionFamily.CommonHull.ofUnionSubset
RegionFamily.CommonHull.union_subset_hull
```

The comparison-family layer now defines:

```text
RegionComparisonFamily.commonTargetHullOfUnionSubset
```

The measured-bound layer now defines:

```text
RegionComparisonFamily.commonTargetHullBoundOfUnionSubset
```

The toy Theta family now constructs:

```text
thetaIndeterminacyCommonTargetHull
thetaIndeterminacyCommonTargetHullBound
```

from:

```text
thetaIndeterminacyFamily_targetUnion_subset_commonTarget
```

instead of constructing the common hull directly from the choice-wise family.

### Lean Decisions

The new constructor is deliberately weaker than a global `HullOperator`.
It needs only:

```text
Region.Subset family.union hull
```

This is closer to the current IUT target: the formal object we need next is a
specific holomorphic hull of the union of possible Theta images, not yet a
globally defined hull operator on every region of every real-line copy.

### What This Tests

Lean verifies:

```text
family.union <= hull
```

implies:

```text
choice target region <= hull
```

and that a measured bound on this same hull gives a
`CommonTargetHullBound`. The toy Theta common-hull bound now follows this
route, and the focused build for `Iut.Stage1.ToyFamilyBounds` passes.

### Design Trap Avoided

The trap would be to introduce the phrase "union of possible images" but leave
the actual common-hull construction dependent only on unrelated choice-wise
containment. The new Lean route makes the union containment the source of the
common hull.

### Remaining Gap

The union is still a family of toy upper-ray target regions. The next
mathematical replacement is a non-toy family of possible Theta-pilot images,
together with a holomorphic-hull datum and a determinant/log-volume bound for
that datum.

## Stage 1 Math Milestone 105: Union Containment in Hull+Det Audits

Lean files:

* `Iut/Foundations/AlgorithmicBridge.lean`
* `Iut/Stage1/ToyBridge.lean`

### Source Check

The previous milestone made common hulls constructible from containment of the
union of possible images. For the Corollary 3.12 dispute, this fact must remain
visible at the hull+det audit boundary. Otherwise the formalization could still
hide the union-of-possible-images step inside the bridge internals.

### Lean/API Check

The measured hull+det audit:

```text
AlgorithmicOutput.HullDetHullBridgeData.HullAudit
```

now stores and exposes:

```text
target_union_subset_common_hull
HullAudit.targetUnion_subset_commonHull
```

The split hull/determinant audit:

```text
AlgorithmicOutput.StructuredHullDetBridgeData.StepAudit
```

now stores and exposes:

```text
target_union_subset_hull
StepAudit.targetUnion_subset_hull
```

The toy bridge now exposes:

```text
thetaToyHullDetHull_targetUnion_subset_commonHull
```

### Lean Decisions

The new audit fields are derived from:

```text
CommonHull.union_subset_hull
```

not restated by hand. This keeps the proof path canonical:

```text
union containment -> common hull -> measured hull bound -> target-volume bound
```

### What This Tests

Lean verifies that the hull+det hull audit carries the containment of the
entire target union in the measured common hull. The focused build for
`Iut.Foundations.AlgorithmicBridge` and `Iut.Stage1.ToyBridge` passes.

### Design Trap Avoided

The trap would be to expose only the final choice-wise target-volume bound at
the hull+det boundary. The audit now exposes the stronger geometric statement:
the union of all possible target regions lies inside the hull being measured.

### Remaining Gap

The source-facing pre-ledger still stores the older common-target bridge
downstream, so the hull-specific audit is available through the hull bridge
data but not yet part of every final charted source package. A future milestone
should decide whether to store the split hull+det data in the Stage 1
pre-ledger, or keep it as a separately audited source obligation.

## Stage 1 Math Milestone 106: Split Hull+Det Evidence at the Pre-Ledger Boundary

Lean files:

* `Iut/Stage1/IUTStage1Data.lean`
* `Iut/Stage1/IUTStage1DataExample.lean`

### Source Check

The final Stage 1 pre-ledger already contains the common-container, HDD/SHE
composite, selected output, membership data, and charted q-to-Theta comparison
data. But the stronger split hull+det bridge was still external to this
pre-ledger boundary.

The IUT III/Scholze-Stix dispute requires exactly this boundary to be auditable:
one must know whether the final charted comparison is backed by a measured hull
of the union of possible Theta images, or only by a terminal common-target
bound.

### Lean/API Check

The pre-ledger layer now defines:

```text
IUTStage1PreLedgerData.HullDetSourceData
```

with fields:

```text
structuredHullDet
hull_det_bridge_eq
```

The equality states that the pre-ledger's downstream named hull+det bridge is
the bridge obtained by forgetting the supplied split hull+det data:

```text
data.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
  structuredHullDet.toHullDetHullBridgeData.toHullDetBridgeData
```

The namespace exposes:

```text
stepAudit
targetUnion_subset_hull
determinantVolumeBound
hullDetBridge_eq
choiceTargetVolume_le_thetaSigned
allTargetsAtMost
```

The toy example now defines:

```text
unitThetaToyPreLedgerHullDetSourceData
```

and checks:

```text
unitThetaToy_preLedgerHullDet_targetUnion_subset_hull_example
unitThetaToy_preLedgerHullDet_determinantVolumeBound_example
```

### Lean Decisions

This data is optional and separate from the core `IUTStage1PreLedgerData`
record. That is deliberate. Existing public endpoint code still accepts older
pre-ledger data, but a stronger source proof can now provide a split hull+det
audit and prove that it matches the bridge actually used downstream.

### What This Tests

Lean verifies that the toy pre-ledger's existing common-container route is
definitionally backed by:

```text
thetaToyStructuredHullDetBridgeData
```

and that this data provides:

```text
targetUnion <= constructed hull
measure constructed hull <= thetaSigned
```

The focused build for `Iut.Stage1.IUTStage1DataExample` passes.

### Design Trap Avoided

The trap would be to keep the split hull+det data as a standalone toy theorem
while the actual pre-ledger used by the final comparison still routes through
an opaque common-target bridge. This milestone gives the pre-ledger a formal
place to record the stronger provenance.

### Remaining Gap

The pre-ledger does not yet require `HullDetSourceData`; it only permits it.
A future source-specific proof of the IUT route should supply such data as one
of its obligations, with a non-toy holomorphic hull and determinant/log-volume
bound.

## Stage 1 Math Milestone 107: Source-Package Split Hull+Det Evidence

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestone placed split hull+det evidence at the pre-ledger
boundary. The source-facing package is the boundary intended to represent the
IUT III Theorem 3.11 to Corollary 3.12 situation. The hull evidence therefore
needs to be recoverable from that source package, not just from the toy
pre-ledger constructor.

### Lean/API Check

The source layer now defines:

```text
IUTStage1SourceHullDetData
```

with field:

```text
sourceData : package.preLedger.HullDetSourceData
```

and accessors:

```text
stepAudit
targetUnion_subset_hull
determinantVolumeBound
hullDetBridge_eq
choiceTargetVolume_le_thetaSigned
allTargetsAtMost
```

The toy source example now defines:

```text
unitThetaToyIUTStage1SourceHullDetData
```

and checks:

```text
unitThetaToy_source_hullDet_targetUnion_subset_hull_example
unitThetaToy_source_hullDet_determinantVolumeBound_example
```

### Lean Decisions

This is again optional source evidence, not a required field of
`IUTStage1SourcePackage`. That keeps the old public endpoint stable while
letting stronger source packages expose the exact hull provenance of their
charted comparison.

### What This Tests

Lean verifies that the toy source package carries a split hull+det datum whose
hull contains the whole union of possible target images and whose determinant/
log-volume-style bound is the package's `thetaSigned` bound.

Focused builds for `Iut.Stage1.IUTStage1Source` and
`Iut.Stage1.IUTStage1SourceExample` pass.

### Design Trap Avoided

The trap would be to have a strong pre-ledger audit but lose it when passing to
the source-facing IUT package. The source package now has its own explicit
wrapper for the split hull+det evidence.

### Remaining Gap

The source package still does not require this evidence to produce the older
public comparison endpoint. Eventually the non-toy IUT source obligations
should include this split hull+det datum as part of the route from Theorem 3.11
to the Corollary 3.12 comparison.

## Stage 1 Math Milestone 108: Strengthened Source Obligations with Hull+Det Evidence

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The previous milestone made split hull+det data available at the source-package
level, but it was still separate from the obligations used to promote the
package to the public Stage 1 endpoint. This milestone adds a strengthened
obligation package that requires both the older promotion obligations and the
split hull+det evidence.

This follows the source discipline from IUT III and Mochizuki's formalization
report: the final comparison should be backed by SHE/common-container data and
by the `(hull+det)` construction, not merely by a terminal target-volume bound.

### Lean/API Check

The source layer now defines:

```text
IUTStage1SourceHullDetObligations
```

with fields:

```text
sourceObligations : IUTStage1SourceObligations package
hullDetData : IUTStage1SourceHullDetData package
```

It exposes:

```text
toSourceObligations
algorithmCertified
sheArrowMatchesCertificate
qPilotPositive
normalization
targetUnion_subset_hull
determinantVolumeBound
choiceTargetVolume_le_thetaSigned
allTargetsAtMost
```

The toy source example now defines:

```text
unitThetaToyIUTStage1SourceHullDetObligations
```

and verifies that it forgets to the previous obligations while retaining the
union-containment and determinant/log-volume bound:

```text
unitThetaToy_source_hullDetObligations_to_sourceObligations_example
unitThetaToy_source_hullDetObligations_targetUnion_subset_hull_example
unitThetaToy_source_hullDetObligations_determinantVolumeBound_example
```

### Lean Decisions

The strengthened obligations are a new structure rather than a modification of
`IUTStage1SourceObligations`. This avoids breaking the existing public endpoint
while providing a stricter target for future non-toy IUT proofs.

### What This Tests

Lean verifies that the toy source can satisfy the stricter obligation shape and
that this stricter shape still projects to the old obligations. The focused
build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Design Trap Avoided

The trap would be to keep the hull+det provenance as optional data forever,
with no path toward making it part of the source obligations. This milestone
creates the stronger obligation package explicitly.

### Remaining Gap

The public endpoint constructors still consume the older obligations. A future
milestone can either add parallel endpoint constructors for
`IUTStage1SourceHullDetObligations` or gradually make the hull+det evidence a
required component of the main source-obligation route.

## Stage 1 Math Milestone 109: Endpoint Projection from Hull+Det Obligations

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The strengthened source obligations now require split hull+det evidence, but
the public comparison endpoint still runs through the older obligation record.
This milestone adds explicit endpoint-facing projections from the strengthened
obligations.

This matters because future non-toy work should be able to use the stricter
route without manually forgetting the hull evidence every time it wants the
Corollary 3.12-shaped comparison.

### Lean/API Check

The source package namespace now defines:

```text
comparisonDataOfHullDetObligations
comparisonDataOfHullDetObligations_eq
comparisonDataOfHullDetObligations_corollary312
publicAuditOfHullDetObligations
publicAuditOfHullDetObligations_corollary312
```

The toy source example checks:

```text
unitThetaToy_source_hullDetObligations_publicAudit_corollary_example
unitThetaToy_source_hullDetObligations_comparisonData_corollary_example
```

### Lean Decisions

The new endpoint functions project through:

```text
IUTStage1SourceHullDetObligations.toSourceObligations
```

The hull+det evidence is not used to re-prove the final real inequality. It is
carried as required provenance while the existing endpoint machinery remains
the verified route from q/target/Theta bounds to the public comparison.

### What This Tests

Lean verifies that the toy strengthened obligations can produce the same
Corollary 3.12-shaped public audit and comparison data as the older obligations.
The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Design Trap Avoided

The trap would be to create stronger obligations that are awkward to use, so
future work silently returns to the weaker route. This milestone makes the
stronger route endpoint-compatible.

### Remaining Gap

The endpoint still does not inspect the hull evidence directly. A later audit
object should package both facts together: the public comparison and the
source-facing proof that the Theta-side bound came from a measured hull of the
union of possible images.

## Stage 1 Math Milestone 110: Hull+Det Comparison Endpoint

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

The strengthened hull+det obligations could already project to the old public
endpoint. The remaining audit issue was ergonomic but important: the public
comparison and the hull provenance were still inspected through separate
objects. For the Corollary 3.12 dispute, a useful endpoint should display both
at once.

This milestone packages the final Corollary-3.12-shaped comparison together
with the statement that the Theta-side bound comes from a measured hull
containing the union of possible target images.

### Lean/API Check

The source package namespace now defines:

```text
IUTStage1SourcePackage.HullDetComparisonEndpoint
IUTStage1SourcePackage.auditedHullDetComparisonEndpoint
```

The endpoint stores:

```text
comparison_endpoint
public_audit
target_union_subset_hull
determinant_volume_bound
all_targets_at_most
```

and exposes:

```text
HullDetComparisonEndpoint.corollary312Endpoint
HullDetComparisonEndpoint.qSignedLeThetaSigned
HullDetComparisonEndpoint.targetUnion_subset_hull
HullDetComparisonEndpoint.determinantVolumeBound
HullDetComparisonEndpoint.allTargetsAtMost
HullDetComparisonEndpoint.comparisonEndpointCorollary312
```

The toy source example now checks:

```text
unitThetaToy_source_hullDetComparisonEndpoint_example
unitThetaToy_source_hullDetComparisonEndpoint_corollary_example
unitThetaToy_source_hullDetComparisonEndpoint_targetUnion_subset_hull_example
unitThetaToy_source_hullDetComparisonEndpoint_determinantVolumeBound_example
```

### Lean Decisions

The endpoint is a proposition-valued structure rather than a new computation.
It packages already verified facts:

```text
old comparison endpoint
public audit
union containment in the hull
measured bound on that hull
all-targets-at-most
```

This keeps the final comparison and hull provenance synchronized without
changing the existing comparison-data construction.

### What This Tests

Lean verifies that the toy source package has a single endpoint object from
which one can extract both:

```text
Corollary312Inequality ...
```

and:

```text
targetUnion <= constructed hull
measure constructed hull <= thetaSigned
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Design Trap Avoided

The trap would be to let users inspect the public comparison while missing the
fact that the Theta-side bound is supposed to come from the union/hull route.
The new endpoint object puts these facts together at the same boundary.

### Remaining Gap

The endpoint still uses the toy upper-ray hull. The next non-toy step should
begin replacing the toy possible-image family with a source-level
Theta-pilot-image family indexed by indeterminacy choices.

## Stage 1 Math Milestone 111: Source-Level Theta-Pilot Possible Images

Lean files:

* `Iut/Stage1/IUTStage1Source.lean`
* `Iut/Stage1/IUTStage1SourceExample.lean`

### Source Check

IUT III describes the Theta-side quantity as the log-volume of the holomorphic
hull of the union of possible images of the Theta-pilot object, subject to
indeterminacies. The previous formal endpoint exposed `targetUnion`, but this
was still named generically as a comparison-family union.

This milestone introduces a source-level object that reads the pre-ledger
target-region family as the family of possible Theta-pilot images indexed by
the current indeterminacy choices.

### Lean/API Check

The source layer now defines:

```text
IUTStage1ThetaPilotPossibleImages
```

with fields:

```text
thetaPilot
indeterminacies
images
theta_pilot_eq
indeterminacies_eq
images_eq_targetRegions
```

The namespace exposes:

```text
ofPackage
union
union_eq_targetUnion
choice_region_eq_targetRegion
union_subset_target
thetaPilotMatchesPackage
indeterminaciesMatchPackage
```

The toy source example now checks:

```text
unitThetaToyThetaPilotPossibleImages
unitThetaToy_thetaPilotPossibleImages_union_eq_targetUnion_example
unitThetaToy_thetaPilotPossibleImages_choice_region_eq_example
unitThetaToy_thetaPilotPossibleImages_union_subset_hull_example
```

### Lean Decisions

The possible-image family is defined as a source-facing wrapper around:

```text
package.preLedger.output.comparisons.targetRegions
```

This is conservative. It does not assert a new construction of Theta-pilot
images. Instead, it records the intended source interpretation of the existing
comparison-family targets and proves that its union is the `targetUnion` used
by the hull endpoint.

### What This Tests

Lean verifies that the source-level possible-image union is definitionally the
target union used by the hull+det endpoint, and that the already-audited hull
containment applies to this possible-image union.

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Design Trap Avoided

The trap would be to keep speaking about "possible Theta images" in prose while
the Lean code only contains anonymous target regions. The new wrapper ties the
target-region family to the source labels for the Theta pilot and the
indeterminacy profile.

### Remaining Gap

The source-level possible images still come from the toy upper-ray comparison
family. The next replacement should define non-toy possible Theta-pilot images
from multiradial/indeterminacy data rather than merely wrapping the existing
target regions.

## 112. Theta-Pilot Possible Images at the Hull Endpoint

### Goal

The previous milestone gave the source package a named family of Theta-pilot
possible images. This milestone attaches that family directly to the final
hull+det comparison endpoint.

The point is to make the endpoint say the mathematically relevant thing:
the holomorphic hull contains the union of possible images of the Theta-pilot
object, not merely an anonymous `targetUnion`.

### Lean/API Check

The source package now defines:

```text
IUTStage1SourcePackage.ThetaPilotHullEndpoint
IUTStage1SourcePackage.auditedThetaPilotHullEndpoint
```

The endpoint contains:

```text
possible_images
hull_endpoint
possible_images_union_subset_hull
possible_images_union_eq_targetUnion
```

The accessor namespace exposes:

```text
ThetaPilotHullEndpoint.corollary312Endpoint
ThetaPilotHullEndpoint.possibleImagesUnion_subset_hull
ThetaPilotHullEndpoint.possibleImagesUnion_eq_targetUnion
ThetaPilotHullEndpoint.determinantVolumeBound
ThetaPilotHullEndpoint.thetaPilotMatchesPackage
ThetaPilotHullEndpoint.indeterminaciesMatchPackage
```

The toy source example now checks:

```text
unitThetaToy_source_thetaPilotHullEndpoint_example
unitThetaToy_source_thetaPilotHullEndpoint_corollary_example
unitThetaToy_source_thetaPilotHullEndpoint_possibleImages_union_subset_hull_example
unitThetaToy_source_thetaPilotHullEndpoint_union_eq_targetUnion_example
```

### Lean Decisions

`ThetaPilotHullEndpoint` is a data-bearing structure, not a `Prop`.

Lean forced this distinction: the endpoint stores
`IUTStage1ThetaPilotPossibleImages package`, which is mathematical data, not a
proof. A `Prop`-valued structure can only have proof fields. This is the right
modeling pressure for the formalization: the source-level possible-image
family must be an explicit object available for inspection, while the hull
containment and endpoint inequalities remain proof fields.

### Source Check

This follows the formulation of IUT III Corollary 3.12 / Theorem B in terms of
the log-volume of the holomorphic hull of the union of possible images of the
Theta-pilot object. It also follows the formalization report's decomposition of
the route through the hull+det step before the final `3.11.5 => 3.12`
transition.

### What This Tests

Lean verifies that the possible-image union is equal to the comparison
`targetUnion`, that this union is contained in the audited hull, and that the
same endpoint still yields the Corollary 3.12 signed pilot inequality.

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The possible-image family is still source-level wrapping over the current
target-region family. The next substantive mathematical step is to replace
that wrapper by an actual multiradial/indeterminacy construction of the
Theta-pilot possible images, then prove that its union is the comparison union
used by the hull+det bridge.

## 113. Indeterminacy Quotient for Multiradial Theta Images

### Goal

We started replacing the plain possible-image wrapper by a multiradial
construction interface. The source issue is that the multiradial representation
of the Theta-pilot is described as a quotient of the relevant 0-column data by
the indeterminacies `(Ind1)`, `(Ind2)`, `(Ind3)`.

The Lean move is to make this quotient explicit at the choice-index level.

### Lean/API Check

The source layer now defines named placeholders:

```text
theorem311Ind1
theorem311Ind2
theorem311Ind3
theorem311IndeterminacyProfile
```

It also defines:

```text
IUTStage1IndeterminacyQuotient
IUTStage1MultiradialThetaImages
```

The quotient carries:

```text
ind1
ind2
ind3
relation
is_equivalence
ind1_name
ind2_name
ind3_name
```

The multiradial image object carries:

```text
multiradialOutput
possibleImages
quotient
multiradial_output_eq
image_invariant
```

The key new proof obligation is:

```text
∀ {choice₁ choice₂},
  quotient.relation choice₁ choice₂ ->
    possibleImages.images.region choice₁ =
      possibleImages.images.region choice₂
```

### Lean Decisions

The quotient is modeled as an equivalence relation on the index type rather
than immediately as a quotient type. This is deliberate. The existing Stage 1
comparison family is indexed by explicit choices, and the next thing we need is
to prove that the possible-image region does not depend on representatives.

Actual quotient types can be introduced later when a construction genuinely
needs representatives to be erased. For now, representative invariance is the
more inspectable mathematical condition.

### Source Check

Mochizuki's formalization report describes the multiradial representation as
constructed by regarding the 0-column data up to the indeterminacies
`(Ind1,2,3)`. IUT II describes multiradial algorithms as expressions in terms
of corically constructed objects that make sense from other spokes, and notes
that indeterminacy is typically needed to obtain such multiradial descriptions.

This milestone encodes exactly the first formal consequence needed by our
current Stage 1 route: related indeterminacy choices must give the same
possible-image region.

### Toy Check

The toy model uses the discrete quotient:

```text
IUTStage1IndeterminacyQuotient.discrete
```

This identifies only equal choices, so the invariance proof is by `cases hrel`
and `rfl`. This is intentionally weak mathematically but useful as a regression
baseline.

The toy source example now checks:

```text
unitThetaToyIndeterminacyQuotient
unitThetaToyIndeterminacyQuotient_profile_example
unitThetaToyMultiradialThetaImages
unitThetaToy_multiradialThetaImages_union_eq_targetUnion_example
unitThetaToy_multiradialThetaImages_region_eq_of_related_example
unitThetaToy_multiradialThetaImages_output_matches_package_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The real mathematical work is to define a non-discrete relation generated by
the actual `(Ind1)`, `(Ind2)`, `(Ind3)` actions and prove `image_invariant` for
the genuine Theta-pilot construction. This is one of the places where vague or
choice-sensitive source definitions must be handled carefully: if the relation
is too coarse, Lean will demand impossible equalities; if it is too fine, the
formalization will fail to capture the intended quotient.

## 114. Multiradial Theta Images at the Hull Endpoint

### Goal

The previous milestone introduced multiradial Theta images with an explicit
Ind1/2/3 quotient-invariance obligation. This milestone connects that object to
the hull+det endpoint.

The resulting endpoint keeps the following data together:

```text
multiradial images
Ind1/2/3 quotient relation
possible-image union
hull containment
determinant/log-volume bound
Corollary 3.12 signed pilot inequality
```

### Lean/API Check

The source package now defines:

```text
IUTStage1SourcePackage.MultiradialThetaHullEndpoint
IUTStage1SourcePackage.auditedMultiradialThetaHullEndpoint
```

The endpoint fields are:

```text
multiradial_images
theta_hull_endpoint
multiradial_union_eq_endpoint_union
multiradial_union_subset_hull
```

The accessor namespace exposes:

```text
MultiradialThetaHullEndpoint.corollary312Endpoint
MultiradialThetaHullEndpoint.multiradialUnion_subset_hull
MultiradialThetaHullEndpoint.multiradialUnion_eq_possibleImagesUnion
MultiradialThetaHullEndpoint.determinantVolumeBound
MultiradialThetaHullEndpoint.region_eq_of_related
MultiradialThetaHullEndpoint.multiradialOutputMatchesPackage
```

### Lean Decisions

The constructor takes an already supplied `IUTStage1MultiradialThetaImages`
object. It does not construct the multiradial representation itself.

This separation is important. The hull+det endpoint should be reusable once the
actual Ind1/2/3-generated quotient and image construction are available. For
now it verifies that any object satisfying the multiradial image interface has
the same union as the endpoint possible images and hence inherits the audited
hull containment.

### Source Check

This matches the formalization report's decomposition:

```text
(HDD) := (hull+det) o (dsc)
```

and then the final Stage 1 comparison after applying `(SHE)`. The new endpoint
does not identify source histories or ring structures. It only says that, after
the multiradial representation has been supplied up to Ind1/2/3, the hull+det
bound applies to the resulting union.

### Toy Check

The toy source example now checks:

```text
unitThetaToy_source_multiradialThetaHullEndpoint_example
unitThetaToy_source_multiradialThetaHullEndpoint_corollary_example
unitThetaToy_source_multiradialThetaHullEndpoint_union_subset_hull_example
unitThetaToy_source_multiradialThetaHullEndpoint_region_eq_related_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The endpoint is now ready for genuine mathematical content, but the current toy
image object still uses the discrete quotient. The next target is to model
Ind1/2/3 as generated transformations/actions on choices, then build the
quotient relation from those generators and prove image invariance from
generator invariance.

## 115. Generated Ind1/2/3 Relation

### Goal

We introduced a formal closure operation for the three Stage 1 indeterminacy
steps. Instead of treating "up to `(Ind1)`, `(Ind2)`, `(Ind3)`" as a single
opaque equivalence relation, Lean now has generator relations and the
equivalence relation generated by them.

### Lean/API Check

The source layer now defines:

```text
IUTStage1IndeterminacyGenerators
IUTStage1GeneratedIndeterminacyRelation
IUTStage1IndeterminacyQuotient.generated
IUTStage1MultiradialThetaImages.ofPackageWithGeneratedQuotient
```

The generator object contains:

```text
ind1_step
ind2_step
ind3_step
```

The generated relation has constructors:

```text
refl
ind1
ind2
ind3
symm
trans
```

Lean verifies:

```text
IUTStage1GeneratedIndeterminacyRelation.is_equivalence
```

and the important induction theorem:

```text
IUTStage1GeneratedIndeterminacyRelation.image_invariant
```

which says that if possible-image regions are invariant under each generator,
then they are invariant under the generated equivalence relation.

### Lean Decisions

We use an explicit inductive generated relation instead of immediately using a
library quotient construction. This keeps the proof obligations readable:

```text
prove invariance under Ind1
prove invariance under Ind2
prove invariance under Ind3
then Lean derives invariance under refl/symm/trans closure
```

This also avoids hiding the mathematical content inside an opaque quotient
object. The closure rules are inspectable by a human reader.

### Source Check

The formalization report describes the multiradial representation as a quotient
of the 0-column by suitable indeterminacies `(Ind1,2,3)`. This milestone gives
that phrase a precise Lean target: define the three generating relations and
prove possible-image invariance for each.

### Toy Check

The toy source example uses empty generator relations:

```text
unitThetaToyIndeterminacyGenerators
unitThetaToyGeneratedIndeterminacyQuotient
unitThetaToyGeneratedMultiradialThetaImages
```

The generator invariance proofs are vacuous by `cases hstep`, but Lean still
checks the generated-relation induction path.

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

We still need genuine definitions of the three generator relations. The next
mathematical step should identify what the choice type must contain so that
`ind1_step`, `ind2_step`, and `ind3_step` can be stated in terms of actual
source data rather than as abstract relations.

## 116. Coordinate Choices and Coric Preservation

### Goal

We introduced a concrete shape for choices before quotienting by the three
indeterminacies. A choice now may be modeled as:

```text
coric data
Ind1 representative state
Ind2 representative state
Ind3 representative state
```

The mathematical intent is that the generated Ind1/2/3 relation may change the
representative-dependent coordinates but must preserve the coric coordinate.

### Lean/API Check

The source layer now defines:

```text
IUTStage1IndeterminacyChoice
IUTStage1IndeterminacyChoice.coordinateGenerators
IUTStage1IndeterminacyChoice.generated_coric_eq
IUTStage1IndeterminacyChoice.image_invariant_of_coric
IUTStage1MultiradialThetaImages.ofPackageWithCoordinateQuotient
```

The coordinate generators are:

```text
Ind1 step: preserve coric, Ind2 state, Ind3 state
Ind2 step: preserve coric, Ind1 state, Ind3 state
Ind3 step: preserve coric, Ind1 state, Ind2 state
```

Lean proves that any relation generated by these steps preserves the coric
coordinate:

```text
generated relation choice₁ choice₂ -> choice₁.coric = choice₂.coric
```

and therefore any possible-image family depending only on coric data is
invariant under the generated relation.

### Lean Decisions

This is still a model of the dependency pattern, not a definition of the actual
IUT indeterminacy actions. The important point is structural: if the
multiradial image construction can be shown to depend only on coric data, then
Lean can derive invariance under all generated Ind1/2/3 moves.

This is preferable to baking invariance directly into an opaque quotient proof,
because it separates two mathematical claims:

```text
each generator preserves coric data
the image construction depends only on coric data
```

### Source Check

IUT II describes multiradial algorithms as constructions in terms of corically
constructed objects, i.e. objects meaningful from other spokes. The
formalization report describes the multiradial representation as a quotient of
0-column data by `(Ind1,2,3)`. The coordinate-choice model is a conservative
formal skeleton for that idea.

### Toy Check

The source example now checks:

```text
coordinateIndeterminacy_generated_coric_eq_example
coordinateIndeterminacy_image_invariant_of_coric_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The `coric` coordinate is still abstract. The next step should identify which
existing source records correspond to coric data in our Stage 1 package:
likely the common-container/SHE/HDD labels and the parts of the multiradial
output that are supposed to survive the erasure of ring/scheme history.

## 117. Source-Facing Coric Data

### Goal

We connected the abstract `coric` coordinate to existing Stage 1 source
records. The new wrapper extracts the common-container/SHE/HDD data that is
visible at the Theorem 3.11 to Corollary 3.12 boundary.

### Lean/API Check

The source layer now defines:

```text
IUTStage1CoricData
IUTStage1CoricData.ofPackage
```

with fields:

```text
multiradialOutput
commonContainer
sharedContext
commonLanguage
hdd
multiradial_output_eq
common_container_eq
shared_context_eq
common_language_eq
hdd_eq
```

The accessors expose that this data is exactly the package's common-container
and HDD/SHE data:

```text
multiradialOutputMatchesPackage
commonContainerMatchesPackage
sharedContextMatchesPackage
commonLanguageMatchesSharedContext
hddMatchesPackage
```

### Lean Decisions

This is a wrapper around existing records, not a new construction. That is
intentional. We should not invent a separate coric object disconnected from the
actual package route. The next non-toy quotient should use this wrapper, or a
refinement of it, as the coric coordinate in `IUTStage1IndeterminacyChoice`.

### Source Check

The formalization report stresses common containers and the route through
`(HDD) o (SHE)`. The existing Lean package already has:

```text
commonContainer.context
commonContainer.hddShe
commonContainer.hddShe.hdd
```

This milestone records those components as the current formal approximation to
the coric data that survives indeterminacy-coordinate erasure.

### Toy Check

The toy source example now checks:

```text
unitThetaToyIUTStage1CoricData
unitThetaToy_coricData_commonLanguage_example
unitThetaToy_coricData_hdd_matches_package_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The wrapper still does not prove that the possible-image construction depends
only on this coric data. That dependency is the next mathematical obligation:
if two choices have the same `IUTStage1CoricData`, their Theta-pilot
possible-image regions should agree.

## 118. Coric Dependence Obligation for Theta Images

### Goal

We isolated the exact obligation needed to turn coordinate choices into
multiradial Theta-pilot images:

```text
same coric coordinate -> same possible-image region
```

Once this is proved, Lean constructs the multiradial image object with the
generated Ind1/2/3 quotient.

### Lean/API Check

The source layer now defines:

```text
IUTStage1ThetaImagesDependOnlyOnCoric
IUTStage1ThetaImagesDependOnlyOnCoric.toMultiradialThetaImages
IUTStage1ThetaImagesDependOnlyOnCoric.imageInvariant
IUTStage1ThetaImagesDependOnlyOnCoric.union_eq_targetUnion
```

The core field is:

```text
region_eq_of_coric_eq :
  ∀ choice₁ choice₂,
    choice₁.coric = choice₂.coric ->
      image choice₁ = image choice₂
```

### Lean Decisions

This obligation is a `Prop`, not data. It should be supplied by the actual
multiradial construction once the source definitions are refined. The
constructor from this obligation to `IUTStage1MultiradialThetaImages` is data,
because it produces the actual image object carrying the generated quotient.

### Source Check

This matches the intended use of multiradiality: the expression of the
Theta-pilot image must be meaningful from the common/coric viewpoint, hence
must not depend on the representative-dependent indeterminacy coordinates.

This is directly relevant to the 3.11 -> 3.12 dispute. If this obligation is
too weak or cannot be supplied from the official definitions, the formal route
to Corollary 3.12 gets stuck before the hull+det endpoint.

### Toy Check

The source example now checks:

```text
thetaImagesDependOnlyOnCoric_to_multiradial_example
thetaImagesDependOnlyOnCoric_union_eq_targetUnion_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The project still has not supplied a real proof of coric dependence for IUT
Theta images. The next useful step is to connect `IUTStage1CoricData` to the
coordinate-choice `coric` field in a source-package-level choice type, then
state the non-toy source obligation against that choice type.

## 119. Theorem 3.11 Indeterminacy Source Names

### Goal

We refined the generic Ind1/2/3 generator interface with the source names used
in IUT III Theorem 3.11.

### Source Check

In the statement of Theorem 3.11:

```text
Ind1: automorphisms of the procession of D-prime-strips
Ind2: independent local tensor-factor / order-two symmetries
Ind3: upper semi-compatibility as m varies in the log-theta lattice
```

This milestone maps those three named source descriptions into the existing
generator slots.

### Lean/API Check

The source layer now defines:

```text
IUTStage1Theorem311IndeterminacySourceData
IUTStage1Theorem311IndeterminacySourceData.generators
IUTStage1Theorem311IndeterminacySourceData.quotient
IUTStage1MultiradialThetaImages.ofPackageWithTheorem311Indeterminacies
```

The source-data fields are:

```text
procession_automorphism_step
local_tensor_symmetry_step
upper_semi_compatibility_step
```

and Lean checks that they feed:

```text
Ind1 -> procession_automorphism_step
Ind2 -> local_tensor_symmetry_step
Ind3 -> upper_semi_compatibility_step
```

### Lean Decisions

This is still an interface, not the real construction of those relations. The
important improvement is that future proofs can no longer hide the three
indeterminacies behind anonymous fields named only `ind1_step`, `ind2_step`,
and `ind3_step`. They must now say which Theorem 3.11 source mechanism they
are implementing.

### Toy Check

The toy source example uses empty relations for all three source mechanisms:

```text
unitThetaToyTheorem311IndeterminacySourceData
unitThetaToyTheorem311MultiradialThetaImages
unitThetaToy_theorem311MultiradialThetaImages_union_eq_targetUnion_example
```

This checks the API without pretending the toy model contains procession
automorphisms, tensor-factor symmetries, or upper semi-compatibility data.

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The next mathematical step is to define actual choice records rich enough to
state these three source mechanisms nontrivially. In particular, Ind1 needs
procession data, Ind2 needs local tensor-factor symmetry data, and Ind3 needs
variation in the `m` coordinate together with upper-semi-compatibility evidence.

## 120. Theorem 3.11-Shaped Choice Records

### Goal

We introduced a source-shaped choice record for Theorem 3.11. This is more
specific than the earlier generic coordinate-choice model.

### Lean/API Check

The source layer now defines:

```text
IUTStage1Theorem311Choice
IUTStage1Theorem311Choice.ProcessionAutomorphismStep
IUTStage1Theorem311Choice.LocalTensorSymmetryStep
IUTStage1Theorem311Choice.UpperSemiCompatibilityStep
IUTStage1Theorem311Choice.indeterminacySourceData
IUTStage1Theorem311Choice.generated_coric_eq
IUTStage1Theorem311Choice.generated_column_eq
IUTStage1Theorem311Choice.image_invariant_of_coric
```

The choice fields are:

```text
column : Int
row : Int
coric
procession_state
local_tensor_state
upper_semi_state
```

The generator permissions are:

```text
Ind1: may change procession_state; preserves column, row, coric, local tensor, upper-semi state
Ind2: may change local_tensor_state; preserves column, row, coric, procession, upper-semi state
Ind3: may change row and upper_semi_state; preserves column, coric, procession, local tensor state
```

Lean proves that the generated relation preserves:

```text
column
coric
```

and therefore possible-image families depending only on coric data are
invariant under the Theorem 3.11-shaped generated relation.

### Source Check

This follows the statement of IUT III Theorem 3.11:

```text
Ind1: automorphisms of the procession of D-prime-strips
Ind2: local tensor-factor symmetries
Ind3: upper semi-compatibility as m varies
```

The model is still schematic, but the allowed coordinate changes now mirror the
roles of the three indeterminacies in the statement.

### Toy Check

The source example now checks:

```text
theorem311Choice_generated_coric_eq_example
theorem311Choice_generated_column_eq_example
theorem311Choice_image_invariant_of_coric_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The state coordinates are still abstract. To become non-toy, these must be
replaced by records for processions of D-prime-strips, local tensor packet
symmetry data, and upper-semi-compatible Kummer/log-link data.

## 121. Typed Theorem 3.11 State Records

### Goal

We replaced the fully abstract state coordinates of the Theorem 3.11 choice
model by named records for the three source mechanisms that appear in the
statement of Theorem 3.11.

### Source Check

The relevant Theorem 3.11 text describes:

```text
Ind1: automorphisms of the procession of D-prime-strips
Ind2: independent local tensor-factor symmetries
Ind3: upper semi-compatibility as m varies, involving inclusions at nonarchimedean places,
      surjections at archimedean places, and log-volume compatibility
```

The new records are deliberately still skeletal, but they name these three
pieces directly.

### Lean/API Check

The source layer now defines:

```text
ProcessionPrimeStripId
LocalTensorSymmetryId
LogThetaColumnId
UpperSemiCompatibilityId
IUTStage1ProcessionState
IUTStage1LocalTensorState
IUTStage1UpperSemiCompatibilityState
IUTStage1StructuredTheorem311Choice
```

The typed state records expose:

```text
procession label and column
local tensor symmetry label and direct-summand count
log-theta column, upper-semi compatibility label,
nonarchimedean-inclusion flag, archimedean-surjection flag,
and log-volume compatibility proof
```

The structured choice namespace defines source-shaped generator relations:

```text
IUTStage1StructuredTheorem311Choice.ProcessionAutomorphismStep
IUTStage1StructuredTheorem311Choice.LocalTensorSymmetryStep
IUTStage1StructuredTheorem311Choice.UpperSemiCompatibilityStep
IUTStage1StructuredTheorem311Choice.indeterminacySourceData
```

Lean now checks:

```text
Ind1 preserves the procession column
Ind2 preserves the local direct-summand count
Ind3 preserves the log-theta column
the generated relation preserves the choice column and coric coordinate
```

### Lean Decisions

The structured generator relations are separate from the older generic
`IUTStage1Theorem311Choice` generators. This avoids over-constraining the
generic interface. For example, a generic upper-semi state is opaque, so it
would be wrong to force equality of the whole state just to prove preservation
of a log-theta column. The structured relation can state exactly the partial
invariants we currently know how to name.

The `logVolumeCompatible` field remains a proposition carried by the
upper-semi state. This records that log-volume compatibility is a required
source datum, not something the current skeletal record proves internally.

### Toy Check

The source example now checks:

```text
structuredTheorem311_ind1_preserves_procession_column_example
structuredTheorem311_ind2_preserves_directSummandCount_example
structuredTheorem311_ind3_preserves_logThetaColumn_example
structuredTheorem311_generated_preserves_coric_example
structuredTheorem311_generated_preserves_column_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The records are still identifiers plus invariant fields. The next mathematical
step should refine `IUTStage1UpperSemiCompatibilityState`, because this is the
part closest to Corollary 3.12: it should eventually carry typed local data for
the nonarchimedean inclusions, archimedean surjections, and compatibility of
the relevant log-volumes under the log-link.

## 122. Local Upper-Semi Compatibility Data

### Goal

We refined the upper-semi compatibility state so that `(Ind3)` no longer
contains only boolean flags. It now carries local data for the pieces named in
IUT III Theorem 3.11 and Proposition 3.5:

```text
nonarchimedean inclusions
archimedean surjections
one-sided log-volume compatibility
```

### Source Check

Theorem 3.11 describes `(Ind3)` as upper semi-compatibility as `m` varies,
relative to log-links in a fixed `n`-column. It explicitly points to natural
inclusions at nonarchimedean places, natural surjections at archimedean places,
and compatibility with log-volumes.

This milestone encodes those three features as named local fields.

### Lean/API Check

The source layer now defines:

```text
IUTStage1NonarchimedeanInclusionData
IUTStage1ArchimedeanSurjectionData
IUTStage1LogVolumeCompatibilityData
```

and extends:

```text
IUTStage1UpperSemiCompatibilityState
```

with:

```text
nonarchimedeanInclusions
archimedeanSurjections
logVolumeCompatibility
```

The log-volume compatibility datum is one-sided:

```text
sourceLogVolume <= targetLogVolume
```

The structured `(Ind3)` relation now preserves:

```text
logThetaColumn
nonarchimedeanInclusions
archimedeanSurjections
logVolumeCompatibility
```

and Lean exposes:

```text
ind3_preserves_nonarchimedeanInclusions
ind3_preserves_archimedeanSurjections
ind3_preserves_logVolumeCompatibility
ind3_target_logVolumeUpperBound
```

### Lean Decisions

The log-volume relation is an inequality, not an equality. This is deliberate:
the source discussion is upper-semi and one-sided. If later source work proves a
stronger equality in a specific subcase, that can be added as extra data without
weakening the current interface.

The local inclusion and surjection records still store labels and proof fields
rather than concrete local analytic objects. This keeps the milestone aligned
without pretending that Proposition 3.5 has already been formalized.

### Toy Check

The source example now checks:

```text
upperSemi_nonarchimedeanInclusion_valid_example
upperSemi_archimedeanSurjection_valid_example
upperSemi_logVolumeCompatibility_upperBound_example
structuredTheorem311_ind3_preserves_nonarchimedeanInclusions_example
structuredTheorem311_ind3_preserves_archimedeanSurjections_example
structuredTheorem311_ind3_target_logVolumeUpperBound_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The local records still need to be refined from labels to actual local objects:
places over `vQ`, local tensor packets/log-shells, the concrete inclusion and
surjection maps, and the log-volume maps of Proposition 3.9. This should be the
next source-facing refinement before attempting a stronger Corollary 3.12
endpoint.

## 123. Typed Places for Upper-Semi Local Data

### Goal

We refined the local upper-semi data so that the nonarchimedean/archimedean
distinction is enforced by Lean types.

### Lean/API Check

The source layer now defines:

```text
IUTStage1PlaceKind
IUTStage1PlaceId
IUTStage1LocalObjectId
```

with two place kinds:

```text
nonarchimedean
archimedean
```

The local upper-semi records now carry typed places and typed local objects:

```text
IUTStage1NonarchimedeanInclusionData.place :
  IUTStage1PlaceId nonarchimedean

IUTStage1ArchimedeanSurjectionData.place :
  IUTStage1PlaceId archimedean
```

The source and target local objects are required to lie over the same typed
place:

```text
source_place_eq
target_place_eq
```

### Lean Decisions

We retained the older string labels as human-readable names, but the
mathematical split is now type-level. This prevents accidentally using an
archimedean surjection datum where a nonarchimedean inclusion datum is expected.

### Source Check

This follows the Theorem 3.11 `(Ind3)` wording that separates natural
inclusions at `vQ ∈ Vnon_Q` from natural surjections at `vQ ∈ Varc_Q`.

### Toy Check

The source example now checks:

```text
upperSemi_nonarchimedeanInclusion_source_place_example
upperSemi_nonarchimedeanInclusion_target_place_example
upperSemi_archimedeanSurjection_source_place_example
upperSemi_archimedeanSurjection_target_place_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The typed local objects are still identifiers, not the actual tensor packets or
log-shells. The next refinement should introduce a local log-shell/tensor-packet
object interface with a log-volume map, so the compatibility datum can refer to
actual local objects rather than standalone real numbers.

## 124. Local Log-Volume Objects

### Goal

We introduced a source-facing interface for local log-shell/tensor-packet
objects equipped with log-volumes. This moves upper-semi compatibility one step
closer to Proposition 3.9: the local inclusion/surjection data now refers to
typed local objects with finite log-volumes instead of only labels and isolated
real numbers.

### Source Check

IUT III Proposition 3.9 defines packet-normalized and procession-normalized
log-volumes for local holomorphic packets, mono-analytic log-shells, and
processions. Remark 3.9.6 emphasizes that log-link compatibility concerns
log-volumes of certain sufficiently small regions rather than arbitrary regions.

This milestone does not construct those analytic regions. It records the
interface that future local objects must satisfy: a typed place, a local object,
a normalization, and a real log-volume.

### Lean/API Check

The source layer now defines:

```text
IUTStage1LogVolumeNormalization
IUTStage1LocalLogVolumeObject
IUTStage1FiniteLocalLogVolumeObject
```

with normalizations:

```text
packet
procession
global
```

The nonarchimedean inclusion data now carries:

```text
sourceLogVolume
targetLogVolume
source_log_volume_object_eq
target_log_volume_object_eq
source_logVolume_le_target_logVolume
```

The archimedean surjection data now carries:

```text
sourceLogVolume
targetLogVolume
source_log_volume_object_eq
target_log_volume_object_eq
target_logVolume_le_source_logVolume
```

### Lean Decisions

The inequalities are oriented to match the current source-facing role:

```text
nonarchimedean inclusion: source volume <= target volume
archimedean surjection: target volume <= source volume
```

This is a conservative one-sided interface. It does not assume equality of
log-volumes except where a later source theorem provides it.

### Toy Check

The source example now checks:

```text
upperSemi_nonarchimedeanInclusion_source_logVolume_object_example
upperSemi_nonarchimedeanInclusion_target_logVolume_object_example
upperSemi_nonarchimedeanInclusion_logVolume_le_example
upperSemi_archimedeanSurjection_source_logVolume_object_example
upperSemi_archimedeanSurjection_target_logVolume_object_example
upperSemi_archimedeanSurjection_logVolume_le_example
upperSemi_finiteLocalLogVolume_eq_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The analytic construction of local objects is still absent. The next refinement
should separate packet-normalized and procession-normalized log-volume data
more explicitly, especially the averaging over capsules/processions described
in Proposition 3.9.

## 125. Procession-Normalized Log Volume

### Goal

We added a source-facing record for procession-normalized local log-volume.
This captures the averaging step in Proposition 3.9 without yet constructing
the full family of capsules.

### Source Check

Proposition 3.9 says that, for collections of capsules in a procession, the
local log-volumes are normalized by taking the average over the capsules under
consideration. This is the source of the name "procession-normalization".

### Lean/API Check

The source layer now defines:

```text
IUTStage1ProcessionNormalizedLogVolume
```

with fields:

```text
localObject
capsuleCount
positive_capsule_count
totalLogVolume
normalizedLogVolume
normalized_eq_average
```

The key equation is:

```text
normalizedLogVolume = totalLogVolume / capsuleCount
```

with `capsuleCount` coerced to `Real` and a proof that `0 < capsuleCount`.

### Lean Decisions

The capsule family is not yet represented. We record only the finite count and
the average equation. This is enough to prevent the procession-normalized
quantity from being treated as an arbitrary real, while keeping the next
mathematical refinement clear: replace the total with a finite sum over typed
capsule log-volume objects.

### Toy Check

The source example now checks:

```text
upperSemi_processionNormalizedLogVolume_eq_example
upperSemi_processionNormalizedLogVolume_capsuleCount_pos_example
upperSemi_processionNormalized_to_finite_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The next refinement should introduce an indexed finite capsule family and prove
that the recorded `totalLogVolume` is the sum of the capsule log-volumes.

## 126. Capsule-Family Log-Volume Sums

### Goal

We refined procession-normalized log-volume so that the total log-volume is no
longer an arbitrary real. It is now tied to a finite sum over an indexed family
of capsule log-volumes.

### Source Check

IUT III Proposition 3.9 says that procession-normalized log-volumes arise by
taking averages over the capsules under consideration. Milestone 125 recorded
the average equation. This milestone records the finite sum that supplies the
total being averaged.

### Lean/API Check

The source layer now defines:

```text
IUTStage1CapsuleFamilyLogVolume
```

with fields:

```text
localObject
capsuleCount
positive_capsule_count
capsuleLogVolume : Fin capsuleCount -> Real
totalLogVolume
total_eq_sum
normalizedLogVolume
normalized_eq_average
```

The key new equation is:

```text
totalLogVolume = Finset.univ.sum capsuleLogVolume
```

and the record converts back to:

```text
IUTStage1ProcessionNormalizedLogVolume
```

without losing the total-as-sum theorem.

### Lean Decisions

The capsule family is represented by `Fin capsuleCount -> Real`. This is the
smallest useful finite indexed form: it gives Lean a real finite sum while
leaving the actual capsule objects for the next refinement.

The positivity proof `0 < capsuleCount` is retained because the normalized
average divides by the capsule count.

### Toy Check

The source example now checks:

```text
upperSemi_capsuleFamilyLogVolume_total_eq_sum_example
upperSemi_capsuleFamilyLogVolume_normalized_eq_example
upperSemi_capsuleFamily_to_processionNormalized_example
upperSemi_capsuleFamily_to_procession_total_eq_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The indexed capsules are still represented only by their log-volume values. The
next refinement should introduce typed capsule identifiers/objects and make
`capsuleLogVolume` a projection from those capsule objects.

## 127. Typed Capsule Log-Volume Objects

### Goal

We refined capsule-family log-volume once more so that the finite sum ranges
over typed capsule objects, not just raw real values.

### Lean/API Check

The source layer now defines:

```text
IUTStage1CapsuleLogVolumeObject
IUTStage1TypedCapsuleFamilyLogVolume
```

A capsule object carries:

```text
capsuleLabel
localObject
logVolume
log_volume_eq
```

The typed family carries:

```text
capsule : Fin capsuleCount -> IUTStage1CapsuleLogVolumeObject kind
capsule_local_object_eq
total_eq_sum
normalized_eq_average
```

The sum is now:

```text
totalLogVolume = Finset.univ.sum fun i => (capsule i).logVolume
```

and the record converts to the previous value-only capsule family.

### Source Check

This continues the Proposition 3.9 formalization path. We still do not
construct the analytic capsule objects of the paper, but the Lean API now has a
place for typed capsule records, their local objects, and their log-volume
projections.

### Toy Check

The source example now checks:

```text
upperSemi_capsuleLogVolumeObject_eq_example
upperSemi_typedCapsuleFamily_localObject_eq_example
upperSemi_typedCapsuleFamily_total_eq_sum_example
upperSemi_typedCapsuleFamily_to_capsuleFamily_example
```

The focused build for `Iut.Stage1.IUTStage1SourceExample` passes.

### Remaining Gap

The capsule object is still a record with labels and a log-volume equality. The
next refinement should connect these capsule objects to local tensor packets or
log-shell objects from the Theorem 3.11 state records.
