/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.CommonTargetBound
import Iut.Stage1.ToyMeasuredComparison
import Mathlib.Tactic

/-!
Toy families of upper-ray comparisons.

This file instantiates the common-target bound interface for a family of toy
Theta-side upper-ray regions indexed by possible epsilon values. A single
epsilon cap gives a common target only through explicit containment proofs.
-/

namespace Iut
namespace Stage1
namespace ToyModel

open RealLineCopy

variable {index : Type u}

/-- A family of toy Theta indeterminacy comparisons indexed by possible epsilons. -/
def thetaIndeterminacyFamily (f : Transport qLine thetaLine) (h : Real)
    (epsilon : index -> Real) : RegionComparisonFamily qLine thetaLine index :=
  RegionComparisonFamily.upperRayFamily
    (fun _ => f) (fun choice => -(2 * h) + epsilon choice)

/-- The common upper-ray target determined by a single epsilon cap. -/
def thetaIndeterminacyCommonTarget (h epsilonBound : Real) : Region thetaLine :=
  Region.upperRay thetaLine (-(2 * h) + epsilonBound)

theorem thetaIndeterminacyFamily_commonTarget
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaIndeterminacyFamily f h epsilon).CommonTarget
      (thetaIndeterminacyCommonTarget h epsilonBound) := by
  unfold thetaIndeterminacyFamily thetaIndeterminacyCommonTarget
  apply RegionComparisonFamily.upperRayFamily_commonTarget
  intro choice
  linarith [hbound choice]

def thetaIndeterminacyCommonTargetHull
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaIndeterminacyFamily f h epsilon).CommonTargetHull :=
  by
    unfold thetaIndeterminacyFamily
    exact RegionComparisonFamily.upperRayFamily_commonTargetHull
      (fun _ => f) (fun choice => -(2 * h) + epsilon choice)
      (commonBound := -(2 * h) + epsilonBound) (by
        intro choice
        linarith [hbound choice])

def thetaIndeterminacyCommonTargetHullBound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.CommonTargetHullBound measure
      (thetaIndeterminacyFamily f h epsilon) (-(2 * h) + epsilonBound) :=
  by
    unfold thetaIndeterminacyFamily
    exact RegionComparisonFamily.upperRayFamily_commonTargetHullBound
      measure hnormalized (fun _ => f) (fun choice => -(2 * h) + epsilon choice)
      (commonBound := -(2 * h) + epsilonBound) (by
        intro choice
        linarith [hbound choice])

def thetaIndeterminacyCommonTargetBound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.CommonTargetBound measure
      (thetaIndeterminacyFamily f h epsilon) (-(2 * h) + epsilonBound) :=
  (thetaIndeterminacyCommonTargetHullBound measure hnormalized f h hbound).toCommonTargetBound

theorem thetaIndeterminacyFamily_allTargetsAtMost
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.AllTargetsAtMost measure
      (thetaIndeterminacyFamily f h epsilon) (-(2 * h) + epsilonBound) :=
  (thetaIndeterminacyCommonTargetBound measure hnormalized f h hbound).allTargetsAtMost

theorem thetaIndeterminacyFamily_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaIndeterminacyFamily f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  thetaIndeterminacyFamily_allTargetsAtMost measure hnormalized f h hbound choice

theorem thetaIndeterminacyFamily_choice_holds_common
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index} {sourcePoint : Point qLine}
    (hholds : ((thetaIndeterminacyFamily f h epsilon).comparison choice).Holds sourcePoint) :
    (RegionComparison.enlargeTarget
      ((thetaIndeterminacyFamily f h epsilon).comparison choice)
      (thetaIndeterminacyCommonTarget h epsilonBound)).Holds sourcePoint :=
  RegionComparisonFamily.holds_commonTarget_of_choice
    (thetaIndeterminacyFamily_commonTarget f h hbound) hholds

theorem unitThetaIndeterminacyFamily_choice_holds_iff_bound
    (h : Real) (epsilon : index -> Real) (choice : index) :
    ((thetaIndeterminacyFamily unitQToTheta h epsilon).comparison choice).Holds
        (qAssignment h) ↔
      h <= epsilon choice :=
  unitThetaIndeterminacyComparison_holds_iff_bound h (epsilon choice)

theorem unitThetaIndeterminacyFamily_bound_of_choice_holds
    (h : Real) {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : ((thetaIndeterminacyFamily unitQToTheta h epsilon).comparison choice).Holds
      (qAssignment h)) :
    h <= epsilonBound := by
  have hchoice : h <= epsilon choice :=
    (unitThetaIndeterminacyFamily_choice_holds_iff_bound h epsilon choice).mp hholds
  exact le_trans hchoice (hbound choice)

end ToyModel
end Stage1
end Iut
