/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.RegionMeasure
import Iut.Stage1.ToyModel
import Mathlib.Tactic

/-!
Toy upper-ray comparisons with an abstract region measure.

This file connects the real-valued toy model from IUT III, Remark 3.12.2, to the
abstract monotone measure interface. The only additional assumption is an
explicit calibration: on upper rays, the measure returns the displayed upper-ray
bound. This keeps the arithmetic toy calculation separate from any future
analytic construction of IUT log-volume.
-/

namespace Iut
namespace Stage1
namespace ToyModel

open RealLineCopy

variable (measure : RegionMeasure thetaLine)

theorem thetaIndeterminacy_target_subset_iff_epsilon_le
    (f : Transport qLine thetaLine) (h epsilon₁ epsilon₂ : Real) :
    Region.Subset
        (thetaIndeterminacyComparison f h epsilon₁).targetRegion
        (thetaIndeterminacyComparison f h epsilon₂).targetRegion ↔
      epsilon₁ <= epsilon₂ := by
  constructor
  · intro hsubset
    have hbound :
        -(2 * h) + epsilon₁ <= -(2 * h) + epsilon₂ := by
      exact (Region.upperRay_subset_upperRay_iff).mp hsubset
    linarith
  · intro hepsilon
    apply Region.upperRay_subset_upperRay
    linarith

theorem thetaIndeterminacy_targetVolume_eq_bound
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h epsilon : Real) :
    RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison f h epsilon) =
      -(2 * h) + epsilon := by
  exact hnormalized (-(2 * h) + epsilon)

theorem thetaIndeterminacy_targetVolume_le_of_epsilon_le
    (f : Transport qLine thetaLine) {h epsilon₁ epsilon₂ : Real}
    (hepsilon : epsilon₁ <= epsilon₂) :
    RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison f h epsilon₁) <=
      RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison f h epsilon₂) := by
  exact measure.monotone
    ((thetaIndeterminacy_target_subset_iff_epsilon_le f h epsilon₁ epsilon₂).mpr hepsilon)

theorem thetaIndeterminacy_targetVolume_le_iff_epsilon_le
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h epsilon₁ epsilon₂ : Real) :
    RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison f h epsilon₁) <=
      RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison f h epsilon₂) ↔
      epsilon₁ <= epsilon₂ := by
  rw [thetaIndeterminacy_targetVolume_eq_bound measure hnormalized f h epsilon₁,
    thetaIndeterminacy_targetVolume_eq_bound measure hnormalized f h epsilon₂]
  constructor <;> intro hle <;> linarith

theorem thetaIndeterminacy_membershipControlsTargetVolume
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h epsilon : Real) :
    (thetaIndeterminacyComparison f h epsilon).MembershipControlsTargetVolume
      measure :=
  RegionComparison.upperRay_membershipControlsTargetVolume_of_normalized
    measure hnormalized f (-(2 * h) + epsilon)

theorem thetaIndeterminacy_holds_iff_coord_le_targetVolume
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h epsilon : Real) :
    (thetaIndeterminacyComparison f h epsilon).Holds (qAssignment h) ↔
      (Transport.map f (qAssignment h)).coord <=
        RegionMeasure.targetVolume measure
          (thetaIndeterminacyComparison f h epsilon) := by
  rw [thetaIndeterminacy_targetVolume_eq_bound measure hnormalized f h epsilon]
  rfl

theorem unitThetaIndeterminacy_coord_le_targetVolume_iff_bound
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (h epsilon : Real) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
        RegionMeasure.targetVolume measure
          (thetaIndeterminacyComparison unitQToTheta h epsilon) ↔
      h <= epsilon := by
  rw [← thetaIndeterminacy_holds_iff_coord_le_targetVolume measure hnormalized
    unitQToTheta h epsilon]
  exact unitThetaIndeterminacyComparison_holds_iff_bound h epsilon

end ToyModel
end Stage1
end Iut
