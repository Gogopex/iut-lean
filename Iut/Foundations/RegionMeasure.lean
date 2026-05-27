/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.IndeterminacyRelation

/-!
Abstract real-valued measures of regions.

This file records only the monotonicity shape needed for log-volume estimates:
if one region is contained in another, then its assigned real value is no larger.
It does not define IUT log-volume analytically.
-/

namespace Iut
namespace RealLineCopy

/-- A monotone real-valued measure on regions of a labeled real-line copy. -/
structure RegionMeasure (line : Copy) where
  volume : Region line -> Real
  monotone : ∀ {small large : Region line},
    Region.Subset small large -> volume small <= volume large

namespace RegionMeasure

variable {line source target : Copy} {index : Type u}

theorem le_of_subset (measure : RegionMeasure line) {small large : Region line}
    (hsubset : Region.Subset small large) :
    measure.volume small <= measure.volume large :=
  measure.monotone hsubset

theorem le_hull (measure : RegionMeasure line) (operator : HullOperator line)
    (region : Region line) :
    measure.volume region <= measure.volume (operator.hull region) :=
  measure.monotone (operator.extensive region)

theorem le_common_of_choice (measure : RegionMeasure line)
    {family : RegionFamily line index} {common : Region line}
    (hcommon : family.ContainedIn common) (choice : index) :
    measure.volume (family.region choice) <= measure.volume common :=
  measure.monotone (hcommon choice)

theorem le_commonHull_of_choice (measure : RegionMeasure line)
    {family : RegionFamily line index} (commonHull : family.CommonHull)
    (choice : index) :
    measure.volume (family.region choice) <= measure.volume commonHull.hull :=
  measure.monotone (commonHull.contains_each choice)

/-- A region has volume at most a chosen real bound. -/
def HasVolumeAtMost (measure : RegionMeasure line) (region : Region line)
    (bound : Real) : Prop :=
  measure.volume region <= bound

theorem atMost_of_subset_of_atMost (measure : RegionMeasure line)
    {small large : Region line} {bound : Real}
    (hsubset : Region.Subset small large)
    (hlarge : HasVolumeAtMost measure large bound) :
    HasVolumeAtMost measure small bound :=
  le_trans (measure.monotone hsubset) hlarge

theorem choice_atMost_of_common_atMost (measure : RegionMeasure line)
    {family : RegionFamily line index} {common : Region line} {bound : Real}
    (hcommon : family.ContainedIn common)
    (hbound : HasVolumeAtMost measure common bound) (choice : index) :
    HasVolumeAtMost measure (family.region choice) bound :=
  atMost_of_subset_of_atMost measure (hcommon choice) hbound

/-- The target-region volume of a region comparison. -/
def targetVolume (measure : RegionMeasure target)
    (comparison : RegionComparison source target) : Real :=
  measure.volume comparison.targetRegion

theorem targetVolume_le_enlarge (measure : RegionMeasure target)
    (comparison : RegionComparison source target) {larger : Region target}
    (hsubset : Region.Subset comparison.targetRegion larger) :
    targetVolume measure comparison <=
      targetVolume measure (RegionComparison.enlargeTarget comparison larger) :=
  measure.monotone hsubset

theorem targetVolume_le_hullTarget (measure : RegionMeasure target)
    (operator : HullOperator target) (comparison : RegionComparison source target) :
    targetVolume measure comparison <=
      targetVolume measure (RegionComparison.hullTarget operator comparison) :=
  measure.monotone (operator.extensive comparison.targetRegion)

theorem choice_targetVolume_le_common (measure : RegionMeasure target)
    {family : RegionComparisonFamily source target index} {common : Region target}
    (hcommon : family.CommonTarget common) (choice : index) :
    targetVolume measure (family.comparison choice) <= measure.volume common :=
  measure.monotone (hcommon choice)

theorem choice_targetVolume_le_commonHull (measure : RegionMeasure target)
    {family : RegionComparisonFamily source target index}
    (commonHull : family.CommonTargetHull) (choice : index) :
    targetVolume measure (family.comparison choice) <= measure.volume commonHull.hull :=
  measure.monotone (commonHull.contains_each choice)

end RegionMeasure

end RealLineCopy
end Iut
