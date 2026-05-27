/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.TransportedRegionFamily
import Iut.Stage1.ToyFamilyBounds

/-!
Toy APT-style transported output data.

This file separates the toy "algorithmic transport" output from the later common
target estimate. Each possible output has an explicit transport and target region;
only after forgetting this structured output to a `RegionComparisonFamily` do we
reuse the common-target bound layer.
-/

namespace Iut
namespace Stage1
namespace ToyModel

open RealLineCopy

variable {index : Type u}

/--
Toy transported output data: every choice uses the same named transport, while
the target region varies with the chosen epsilon.
-/
def thetaAPTOutput (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) : TransportedRegionFamily qLine thetaLine index :=
  { transport := fun _ => f,
    targetRegion := fun choice => Region.upperRay thetaLine (-(2 * h) + epsilon choice) }

@[simp]
theorem thetaAPTOutput_comparison
    (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) (choice : index) :
    (thetaAPTOutput f h epsilon).comparison choice =
      thetaIndeterminacyComparison f h (epsilon choice) :=
  rfl

@[simp]
theorem thetaAPTOutput_comparisons
    (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) :
    (thetaAPTOutput f h epsilon).comparisons =
      thetaIndeterminacyFamily f h epsilon :=
  rfl

theorem thetaAPTOutput_holds_iff_family_holds
    (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) (choice : index) (sourcePoint : Point qLine) :
    (thetaAPTOutput f h epsilon).Holds choice sourcePoint ↔
      ((thetaIndeterminacyFamily f h epsilon).comparison choice).Holds sourcePoint :=
  Iff.rfl

theorem thetaAPTOutput_commonTarget
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaAPTOutput f h epsilon).CommonTarget
      (thetaIndeterminacyCommonTarget h epsilonBound) :=
  thetaIndeterminacyFamily_commonTarget f h hbound

def thetaAPTOutputCommonTargetHull
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaAPTOutput f h epsilon).CommonTargetHull :=
  thetaIndeterminacyCommonTargetHull f h hbound

def thetaAPTOutputCommonTargetHullBound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaAPTOutput f h epsilon).CommonTargetHullBound
      measure (-(2 * h) + epsilonBound) :=
  thetaIndeterminacyCommonTargetHullBound measure hnormalized f h hbound

def thetaAPTOutputCommonTargetBound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaAPTOutput f h epsilon).CommonTargetBound measure (-(2 * h) + epsilonBound) :=
  (thetaAPTOutputCommonTargetHullBound measure hnormalized f h hbound).toCommonTargetBound

theorem thetaAPTOutput_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaAPTOutput f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  TransportedRegionFamily.choice_targetVolume_le_of_commonBound
    (thetaAPTOutputCommonTargetBound measure hnormalized f h hbound) choice

theorem thetaAPTOutput_holds_common_of_choice
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index} {sourcePoint : Point qLine}
    (hholds : (thetaAPTOutput f h epsilon).Holds choice sourcePoint) :
    (RegionComparison.enlargeTarget
      ((thetaAPTOutput f h epsilon).comparison choice)
      (thetaIndeterminacyCommonTarget h epsilonBound)).Holds sourcePoint :=
  TransportedRegionFamily.holds_common_of_choice
    (thetaAPTOutput_commonTarget f h hbound) hholds

theorem unitThetaAPTOutput_bound_of_choice_holds
    (h : Real) {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaAPTOutput unitQToTheta h epsilon).Holds choice (qAssignment h)) :
    h <= epsilonBound :=
  unitThetaIndeterminacyFamily_bound_of_choice_holds h hbound hholds

end ToyModel
end Stage1
end Iut
