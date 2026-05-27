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
