/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.AlgorithmicBridge
import Iut.Stage1.ToyQualitativeOutput

/-!
Toy bridge from qualitative output certification to common-target bounds.

The bridge is intentionally supplied as explicit data. In the toy model it uses
the epsilon cap and upper-ray normalization to build the common-target bound.
-/

namespace Iut
namespace Stage1
namespace ToyModel

open RealLineCopy

variable {index : Type u}

def thetaToyCommonTargetBoundBridge
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).CommonTargetBoundBridge
      measure (-(2 * h) + epsilonBound) :=
  { build := fun _ =>
      thetaAPTOutputCommonTargetBound measure hnormalized f h hbound }

def thetaToyStructuredCommonTargetHullBridge
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).StructuredCommonTargetHullBridge
      measure (-(2 * h) + epsilonBound) :=
  { build := fun _ =>
      thetaAPTOutputCommonTargetHullBound measure hnormalized f h hbound }

def thetaToyStructuredCommonTargetBoundBridge
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).StructuredCommonTargetBoundBridge
      measure (-(2 * h) + epsilonBound) :=
  (thetaToyStructuredCommonTargetHullBridge
    measure hnormalized f h hbound).toStructuredCommonTargetBoundBridge

def thetaToyHullDetOperation : AlgorithmicOutput.HullDetOperationId :=
  { label := "toy-upper-ray-hull-det" }

def thetaToyDescentOperation : AlgorithmicOutput.DescentOperationId :=
  { label := "toy-upper-ray-descent" }

def thetaToySHEArrow : AlgorithmicOutput.SHEArrowId :=
  { label := "toy-upper-ray-she" }

def thetaToyCommonContainer : AlgorithmicOutput.CommonContainerId :=
  { label := "toy-common-upper-ray-container" }

def thetaToyRealComparisonChart : AlgorithmicOutput.RealComparisonChartId :=
  { label := "toy-real-comparison-chart" }

def thetaToySHEArrowData
    (f : Transport qLine thetaLine) (h : Real) (epsilon : index -> Real) :
    (thetaToyAlgorithmOutput f h epsilon).SHEArrowData :=
  { arrow := thetaToySHEArrow,
    datum := thetaToySHED f h epsilon }

def thetaToyHullDetHullBridgeData
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).HullDetHullBridgeData
      measure (-(2 * h) + epsilonBound) :=
  { operation := thetaToyHullDetOperation,
    bridge := thetaToyStructuredCommonTargetHullBridge
      measure hnormalized f h hbound }

def thetaToyHullDetBridgeData
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).HullDetBridgeData
      measure (-(2 * h) + epsilonBound) :=
  (thetaToyHullDetHullBridgeData measure hnormalized f h hbound).toHullDetBridgeData

def thetaToyHDDCompositeData
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).HDDCompositeData
      measure (-(2 * h) + epsilonBound) :=
  { descent := thetaToyDescentOperation,
    hullDetBridge := thetaToyHullDetBridgeData
      measure hnormalized f h hbound }

def thetaToyHDDSHECompositeData
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).HDDSHECompositeData
      measure (-(2 * h) + epsilonBound) :=
  { sheArrow := thetaToySHEArrowData f h epsilon,
    hdd := thetaToyHDDCompositeData measure hnormalized f h hbound }

def thetaToyCommonContainerData
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).CommonContainerData
      measure (-(2 * h) + epsilonBound) :=
  { container := thetaToyCommonContainer,
    context := thetaToySharedHolomorphicContext,
    hddShe := thetaToyHDDSHECompositeData measure hnormalized f h hbound,
    she_context_matches := rfl }

def thetaToyRealComparisonChartData
    (measure : RegionMeasure thetaLine)
    (f : Transport qLine thetaLine) (h : Real) (epsilon : index -> Real) :
    (thetaToyAlgorithmOutput f h epsilon).RealComparisonChartData measure :=
  { chart := thetaToyRealComparisonChart,
    qToTarget := f,
    thetaToTarget := Transport.id thetaLine,
    theta_trivial := by
      rw [Transport.trivialMonodromy_iff_scale_eq_one]
      rfl }

def thetaToyChartedCommonContainerData
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).ChartedCommonContainerData
      measure (-(2 * h) + epsilonBound) :=
  { commonContainer :=
      thetaToyCommonContainerData measure hnormalized f h hbound,
    chart := thetaToyRealComparisonChartData measure f h epsilon }

def thetaToyCertifiedBridgeBound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).CertifiedCommonTargetBound
      measure (-(2 * h) + epsilonBound) :=
  (thetaToyCommonTargetBoundBridge measure hnormalized f h hbound).apply
    (thetaToyAlgorithmOutput_certified f h epsilon)

theorem thetaToyBridge_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  (thetaToyCommonTargetBoundBridge measure hnormalized f h hbound).choice_targetVolume_le
    (thetaToyAlgorithmOutput_certified f h epsilon) choice

theorem thetaToyStructuredBridge_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  (thetaToyStructuredCommonTargetBoundBridge measure hnormalized f h hbound).choice_targetVolume_le
    (thetaToyStructuredCertificate f h epsilon) choice

theorem thetaToyHullDet_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  (thetaToyHullDetBridgeData measure hnormalized f h hbound).choice_targetVolume_le
    (thetaToyStructuredCertificate f h epsilon) choice

def thetaToyHullDetHullAudit
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyHullDetHullBridgeData measure hnormalized f h hbound).HullAudit
      (thetaToyStructuredCertificate f h epsilon) :=
  (thetaToyHullDetHullBridgeData measure hnormalized f h hbound).hullAudit
    (thetaToyStructuredCertificate f h epsilon)

theorem thetaToyHullDetHull_commonHull_volume_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionMeasure.HasVolumeAtMost measure
      ((thetaToyHullDetHullBridgeData
        measure hnormalized f h hbound).applyHull
          (thetaToyStructuredCertificate f h epsilon)).commonHull.hull
      (-(2 * h) + epsilonBound) :=
  (thetaToyHullDetHullAudit measure hnormalized f h hbound).commonHullVolumeBound

theorem thetaToyHullDetHull_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  (thetaToyHullDetHullAudit measure hnormalized f h hbound).choiceTargetVolume_le
    choice

theorem thetaToyHDD_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  (thetaToyHDDCompositeData measure hnormalized f h hbound).choice_targetVolume_le
    (thetaToyStructuredCertificate f h epsilon) choice

theorem thetaToyHDDSHE_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  (thetaToyHDDSHECompositeData measure hnormalized f h hbound).choice_targetVolume_le
    (thetaToyStructuredCertificate f h epsilon) choice

theorem thetaToyCommonContainer_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  (thetaToyCommonContainerData measure hnormalized f h hbound).choice_targetVolume_le
    (thetaToyStructuredCertificate f h epsilon) choice

theorem thetaToyChartedCommonContainer_choice_targetVolume_le_bound
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    (choice : index) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput f h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  (thetaToyChartedCommonContainerData measure hnormalized f h hbound).choice_targetVolume_le
    (thetaToyStructuredCertificate f h epsilon) choice

theorem thetaToyBridge_allTargetsAtMost
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.AllTargetsAtMost measure
      (thetaToyAlgorithmOutput f h epsilon).comparisons (-(2 * h) + epsilonBound) :=
  (thetaToyCommonTargetBoundBridge measure hnormalized f h hbound).allTargetsAtMost
    (thetaToyAlgorithmOutput_certified f h epsilon)

theorem thetaToyStructuredBridge_allTargetsAtMost
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.AllTargetsAtMost measure
      (thetaToyAlgorithmOutput f h epsilon).comparisons (-(2 * h) + epsilonBound) :=
  (thetaToyStructuredCommonTargetBoundBridge measure hnormalized f h hbound).allTargetsAtMost
    (thetaToyStructuredCertificate f h epsilon)

theorem thetaToyHullDet_allTargetsAtMost
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.AllTargetsAtMost measure
      (thetaToyAlgorithmOutput f h epsilon).comparisons (-(2 * h) + epsilonBound) :=
  (thetaToyHullDetBridgeData measure hnormalized f h hbound).allTargetsAtMost
    (thetaToyStructuredCertificate f h epsilon)

theorem thetaToyHullDetHull_allTargetsAtMost
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.AllTargetsAtMost measure
      (thetaToyAlgorithmOutput f h epsilon).comparisons (-(2 * h) + epsilonBound) :=
  (thetaToyHullDetHullAudit measure hnormalized f h hbound).allTargetsAtMost

theorem thetaToyHDD_allTargetsAtMost
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.AllTargetsAtMost measure
      (thetaToyAlgorithmOutput f h epsilon).comparisons (-(2 * h) + epsilonBound) :=
  (thetaToyHDDCompositeData measure hnormalized f h hbound).allTargetsAtMost
    (thetaToyStructuredCertificate f h epsilon)

theorem thetaToyHDDSHE_allTargetsAtMost
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.AllTargetsAtMost measure
      (thetaToyAlgorithmOutput f h epsilon).comparisons (-(2 * h) + epsilonBound) :=
  (thetaToyHDDSHECompositeData measure hnormalized f h hbound).allTargetsAtMost
    (thetaToyStructuredCertificate f h epsilon)

theorem thetaToyCommonContainer_allTargetsAtMost
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.AllTargetsAtMost measure
      (thetaToyAlgorithmOutput f h epsilon).comparisons (-(2 * h) + epsilonBound) :=
  (thetaToyCommonContainerData measure hnormalized f h hbound).allTargetsAtMost
    (thetaToyStructuredCertificate f h epsilon)

theorem thetaToyChartedCommonContainer_allTargetsAtMost
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    RegionComparisonFamily.AllTargetsAtMost measure
      (thetaToyAlgorithmOutput f h epsilon).comparisons (-(2 * h) + epsilonBound) :=
  (thetaToyChartedCommonContainerData measure hnormalized f h hbound).allTargetsAtMost
    (thetaToyStructuredCertificate f h epsilon)

theorem thetaToyChartedCommonContainer_theta_trivial
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    Transport.TrivialMonodromy
      (thetaToyChartedCommonContainerData
        measure hnormalized f h hbound).chart.thetaToTarget :=
  (thetaToyChartedCommonContainerData measure hnormalized f h hbound).thetaTrivial

theorem thetaToyBridge_hasAPT
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    (f : Transport qLine thetaLine) (h : Real)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound) :
    (thetaToyAlgorithmOutput f h epsilon).HasAPT :=
  (thetaToyCommonTargetBoundBridge measure hnormalized f h hbound).preserves_hasAPT
    (thetaToyAlgorithmOutput_certified f h epsilon)

end ToyModel
end Stage1
end Iut
