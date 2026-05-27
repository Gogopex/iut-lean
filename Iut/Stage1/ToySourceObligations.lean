/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Stage1.SourceObligations
import Iut.Stage1.ToyCorollarySchema

/-!
Toy completion of the Stage 1 source-obligation ledger.

The toy ledger uses upper-ray normalization as its normalization obligation and
the named toy charted common container as its bridge obligation.
-/

namespace Iut
namespace Stage1
namespace ToyModel

open RealLineCopy

variable {index : Type u}

def unitThetaToySourceObligationLedger
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    SourceObligationLedger
      (thetaToyAlgorithmOutput unitQToTheta h epsilon)
      measure
      (-(2 * h) + epsilonBound)
      (Transport.map unitQToTheta (qAssignment h)).coord
      (RegionMeasure.NormalizesUpperRays measure) :=
  { certificate := thetaToyStructuredCertificate unitQToTheta h epsilon,
    chartedContainer :=
      thetaToyChartedCommonContainerData measure hnormalized unitQToTheta h hbound,
    she_matches_certificate := rfl,
    qValue := { qPoint := qAssignment h, qSigned_eq := rfl },
    thetaBound :=
      { thetaPoint := point thetaLine (-(2 * h) + epsilonBound),
        thetaSigned_eq := by
          simp [thetaToyChartedCommonContainerData,
            thetaToyRealComparisonChartData] },
    theta_commonBound :=
      (thetaToyChartedCommonContainerData
        measure hnormalized unitQToTheta h hbound).apply
        (thetaToyStructuredCertificate unitQToTheta h epsilon),
    chosenOutput :=
      { choice := choice,
        comparison := (thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice,
        comparison_eq := rfl },
    targetVolume :=
      { targetSigned :=
          RegionMeasure.targetVolume measure
            ((thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice),
        targetSigned_eq := rfl },
    membership :=
      { holds := by
          simpa [AlgorithmicOutput.Holds, TransportedRegionFamily.Holds]
            using hholds,
        q_le_target :=
          unitThetaToy_qSigned_le_choiceTargetVolume
            measure hnormalized h epsilon choice hholds },
    q_positive := by
      unfold qAssignment unitQToTheta Transport.map point PositiveScale.one
      linarith,
    normalization_proof := hnormalized }

theorem unitThetaToyCorollary312_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  (unitThetaToySourceObligationLedger measure hnormalized hh hbound hholds).corollary312

def unitThetaToyStage1Comparison_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Stage1Comparison :=
  (unitThetaToySourceObligationLedger measure hnormalized hh hbound hholds).stage1Comparison

theorem unitThetaToy_certificate_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).certificate =
      thetaToyStructuredCertificate unitQToTheta h epsilon :=
  rfl

theorem unitThetaToy_chartedContainer_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chartedContainer =
      thetaToyChartedCommonContainerData
        measure hnormalized unitQToTheta h hbound :=
  rfl

theorem unitThetaToy_commonContainer_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chartedContainer.commonContainer =
      thetaToyCommonContainerData measure hnormalized unitQToTheta h hbound :=
  rfl

theorem unitThetaToy_realComparisonChart_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chartedContainer.chart =
      thetaToyRealComparisonChartData measure unitQToTheta h epsilon :=
  rfl

theorem unitThetaToy_qToTarget_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chartedContainer.chart.qToTarget =
      unitQToTheta :=
  rfl

theorem unitThetaToy_thetaToTarget_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chartedContainer.chart.thetaToTarget =
      Transport.id thetaLine :=
  rfl

theorem unitThetaToy_theta_trivial_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chartedContainer.chart.theta_trivial =
      (by
        rw [Transport.trivialMonodromy_iff_scale_eq_one]
        rfl) :=
  rfl

theorem unitThetaToy_qPoint_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).qValue.qPoint =
      qAssignment h :=
  rfl

theorem unitThetaToy_qSigned_eq_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).qValue.qSigned_eq = rfl :=
  rfl

theorem unitThetaToy_thetaPoint_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).thetaBound.thetaPoint =
      point thetaLine (-(2 * h) + epsilonBound) :=
  rfl

theorem unitThetaToy_chosenChoice_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chosenOutput.choice =
      choice :=
  rfl

theorem unitThetaToy_chosenComparison_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chosenOutput.comparison =
      (thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice :=
  rfl

theorem unitThetaToy_chosenThetaComparison_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chosenOutput.comparison =
      thetaIndeterminacyComparison unitQToTheta h (epsilon choice) :=
  rfl

theorem unitThetaToy_chosenComparison_eq_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chosenOutput.comparison_eq =
      rfl :=
  rfl

theorem unitThetaToy_targetSigned_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).targetVolume.targetSigned =
      RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice) :=
  rfl

theorem unitThetaToy_targetSigned_thetaComparison_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).targetVolume.targetSigned =
      RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison unitQToTheta h (epsilon choice)) :=
  rfl

theorem unitThetaToy_targetSigned_eq_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).targetVolume.targetSigned_eq =
      rfl :=
  rfl

theorem unitThetaToy_membership_q_le_target_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).membership.q_le_target =
      unitThetaToy_qSigned_le_choiceTargetVolume
        measure hnormalized h epsilon choice hholds :=
  rfl

theorem unitThetaToy_membership_holds_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).membership.holds =
      (by
        simpa [AlgorithmicOutput.Holds, TransportedRegionFamily.Holds]
          using hholds) :=
  rfl

theorem unitThetaToy_membership_holds_thetaComparison_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (thetaIndeterminacyComparison unitQToTheta h (epsilon choice)).Holds
      (qAssignment h) :=
  (unitThetaToySourceObligationLedger
    measure hnormalized hh hbound hholds).membership.holds

theorem unitThetaToy_membership_coord_le_choiceBound_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilon choice := by
  exact
    unitThetaToy_membership_holds_thetaComparison_from_sourceObligations
      measure hnormalized hh hbound hholds

theorem unitThetaToy_qSigned_le_targetSigned_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      (unitThetaToySourceObligationLedger
        measure hnormalized hh hbound hholds).targetVolume.targetSigned :=
  (unitThetaToySourceObligationLedger
    measure hnormalized hh hbound hholds).membership.q_le_target

theorem unitThetaToy_qSigned_le_thetaTargetVolume_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison unitQToTheta h (epsilon choice)) := by
  simpa using
    unitThetaToy_qSigned_le_targetSigned_from_sourceObligations
      measure hnormalized hh hbound hholds

theorem unitThetaToy_qSigned_le_thetaTargetVolume_from_membership
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison unitQToTheta h (epsilon choice)) :=
  (thetaIndeterminacy_holds_iff_coord_le_targetVolume measure hnormalized
    unitQToTheta h (epsilon choice)).mp
    (unitThetaToy_membership_holds_thetaComparison_from_sourceObligations
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_targetSigned_le_thetaSigned_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).targetVolume.targetSigned <=
      -(2 * h) + epsilonBound :=
  (unitThetaToySourceObligationLedger
    measure hnormalized hh hbound hholds).targetSigned_le_thetaSigned

theorem unitThetaToy_targetSigned_le_thetaSigned_from_chartedContainer
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).targetVolume.targetSigned <=
      -(2 * h) + epsilonBound := by
  let ledger := unitThetaToySourceObligationLedger
    measure hnormalized hh hbound hholds
  rw [ledger.targetVolume.targetSigned_eq]
  exact ledger.chartedContainer.choice_targetVolume_le
    ledger.certificate ledger.chosenOutput.choice

theorem unitThetaToy_choiceTargetVolume_le_thetaBound_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound := by
  simpa using
    unitThetaToy_targetSigned_le_thetaSigned_from_sourceObligations
      measure hnormalized hh hbound hholds

theorem unitThetaToy_thetaTargetVolume_le_thetaBound_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison unitQToTheta h (epsilon choice)) <=
      -(2 * h) + epsilonBound := by
  simpa using
    unitThetaToy_choiceTargetVolume_le_thetaBound_from_sourceObligations
      measure hnormalized hh hbound hholds

theorem unitThetaToy_qSigned_le_thetaSigned_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToySourceObligationLedger
    measure hnormalized hh hbound hholds).qSigned_le_thetaSigned

theorem unitThetaToy_qSigned_le_thetaSigned_from_threeTerm
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToySourceObligationLedger
    measure hnormalized hh hbound hholds).threeTermComparison.q_le_theta

theorem unitThetaToy_qSigned_le_thetaSigned_via_targetSigned
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  le_trans
    (unitThetaToy_qSigned_le_targetSigned_from_sourceObligations
      measure hnormalized hh hbound hholds)
    (unitThetaToy_targetSigned_le_thetaSigned_from_sourceObligations
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_qSigned_le_thetaBound_via_thetaTargetVolume
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  le_trans
    (unitThetaToy_qSigned_le_thetaTargetVolume_from_membership
      measure hnormalized hh hbound hholds)
    (unitThetaToy_thetaTargetVolume_le_thetaBound_from_sourceObligations
      measure hnormalized hh hbound hholds)

theorem unitThetaToyCorollary312_from_qThetaChain
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  corollary312_of_signed_le
    (unitThetaToy_qSigned_le_thetaSigned_from_sourceObligations
      measure hnormalized hh hbound hholds)

theorem unitThetaToyCorollary312_from_threeTermChain
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  corollary312_of_signed_le
    (unitThetaToy_qSigned_le_thetaSigned_from_threeTerm
      measure hnormalized hh hbound hholds)

theorem unitThetaToyCorollary312_from_targetSignedChain
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  corollary312_of_signed_le
    (unitThetaToy_qSigned_le_thetaSigned_via_targetSigned
      measure hnormalized hh hbound hholds)

theorem unitThetaToyCorollary312_from_thetaTargetVolumeChain
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord) :=
  corollary312_of_signed_le
    (unitThetaToy_qSigned_le_thetaBound_via_thetaTargetVolume
      measure hnormalized hh hbound hholds)

theorem unitThetaToyCorollary312_eq_qThetaChain_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).corollary312 =
      corollary312_of_signed_le
        (unitThetaToy_qSigned_le_thetaSigned_from_sourceObligations
          measure hnormalized hh hbound hholds) :=
  rfl

theorem unitThetaToyStage1Comparison_theta_eq_signed_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyStage1Comparison_from_sourceObligations
      measure hnormalized hh hbound hholds).theta =
      signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound) :=
  rfl

theorem unitThetaToyStage1Comparison_q_eq_signed_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyStage1Comparison_from_sourceObligations
      measure hnormalized hh hbound hholds).q =
      signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord :=
  rfl

theorem unitThetaToyStage1Comparison_theta_side_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyStage1Comparison_from_sourceObligations
      measure hnormalized hh hbound hholds).theta.side =
      PilotSide.theta :=
  rfl

theorem unitThetaToyStage1Comparison_q_side_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyStage1Comparison_from_sourceObligations
      measure hnormalized hh hbound hholds).q.side =
      PilotSide.q :=
  rfl

theorem unitThetaToyStage1Comparison_q_positive_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 <
      (unitThetaToyStage1Comparison_from_sourceObligations
        measure hnormalized hh hbound hholds).q.value :=
  (unitThetaToyStage1Comparison_from_sourceObligations
    measure hnormalized hh hbound hholds).q_positive

theorem unitThetaToyStage1Comparison_comparison_eq_corollary312_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyStage1Comparison_from_sourceObligations
      measure hnormalized hh hbound hholds).comparison =
      (unitThetaToySourceObligationLedger
        measure hnormalized hh hbound hholds).corollary312 :=
  rfl

theorem unitThetaToyStage1Comparison_comparison_eq_qThetaChain
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyStage1Comparison_from_sourceObligations
      measure hnormalized hh hbound hholds).comparison =
      corollary312_of_signed_le
        (unitThetaToy_qSigned_le_thetaSigned_from_sourceObligations
          measure hnormalized hh hbound hholds) :=
  rfl

theorem unitThetaToyStage1Comparison_recovers_corollary312
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    corollary312_from_stage1_comparison
      (unitThetaToyStage1Comparison_from_sourceObligations
        measure hnormalized hh hbound hholds) =
      (unitThetaToySourceObligationLedger
        measure hnormalized hh hbound hholds).corollary312 :=
  rfl

theorem unitThetaToyStage1Comparison_recovers_qThetaChain
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    corollary312_from_stage1_comparison
      (unitThetaToyStage1Comparison_from_sourceObligations
        measure hnormalized hh hbound hholds) =
      corollary312_of_signed_le
        (unitThetaToy_qSigned_le_thetaSigned_from_sourceObligations
          measure hnormalized hh hbound hholds) :=
  rfl

theorem unitThetaToyStage1Comparison_recovers_threeTermChain
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    corollary312_from_stage1_comparison
      (unitThetaToyStage1Comparison_from_sourceObligations
        measure hnormalized hh hbound hholds) =
      corollary312_of_signed_le
        (unitThetaToy_qSigned_le_thetaSigned_from_threeTerm
          measure hnormalized hh hbound hholds) :=
  rfl

/-- End-to-end audit summary for the unit-transport toy source ledger. -/
structure UnitThetaToySourceObligationAudit
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) : Prop where
  certificate_from_source :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).certificate =
      thetaToyStructuredCertificate unitQToTheta h epsilon
  chartedContainer_from_source :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chartedContainer =
      thetaToyChartedCommonContainerData
        measure hnormalized unitQToTheta h hbound
  qPoint_from_source :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).qValue.qPoint =
      qAssignment h
  thetaPoint_from_source :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).thetaBound.thetaPoint =
      point thetaLine (-(2 * h) + epsilonBound)
  chosenComparison_from_source :
    (unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds).chosenOutput.comparison =
      thetaIndeterminacyComparison unitQToTheta h (epsilon choice)
  membership_from_source :
    (thetaIndeterminacyComparison unitQToTheta h (epsilon choice)).Holds
      (qAssignment h)
  q_le_targetVolume_from_membership :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison unitQToTheta h (epsilon choice))
  targetVolume_le_thetaBound_from_container :
    RegionMeasure.targetVolume measure
        (thetaIndeterminacyComparison unitQToTheta h (epsilon choice)) <=
      -(2 * h) + epsilonBound
  q_le_thetaBound_from_chain :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound
  corollary_from_chain :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
      (signedPilotLogVolume PilotSide.q
        (Transport.map unitQToTheta (qAssignment h)).coord)
  stage_comparison_from_chain :
    (unitThetaToyStage1Comparison_from_sourceObligations
      measure hnormalized hh hbound hholds).comparison =
      corollary312_of_signed_le
        (unitThetaToy_qSigned_le_thetaSigned_from_sourceObligations
          measure hnormalized hh hbound hholds)
  stage_recovers_corollary :
    corollary312_from_stage1_comparison
      (unitThetaToyStage1Comparison_from_sourceObligations
        measure hnormalized hh hbound hholds) =
      (unitThetaToySourceObligationLedger
        measure hnormalized hh hbound hholds).corollary312

theorem unitThetaToy_endToEndAudit_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    UnitThetaToySourceObligationAudit measure hnormalized hh hbound hholds :=
  { certificate_from_source :=
      unitThetaToy_certificate_from_sourceObligations
        measure hnormalized hh hbound hholds,
    chartedContainer_from_source :=
      unitThetaToy_chartedContainer_from_sourceObligations
        measure hnormalized hh hbound hholds,
    qPoint_from_source :=
      unitThetaToy_qPoint_from_sourceObligations
        measure hnormalized hh hbound hholds,
    thetaPoint_from_source :=
      unitThetaToy_thetaPoint_from_sourceObligations
        measure hnormalized hh hbound hholds,
    chosenComparison_from_source :=
      unitThetaToy_chosenThetaComparison_from_sourceObligations
        measure hnormalized hh hbound hholds,
    membership_from_source :=
      unitThetaToy_membership_holds_thetaComparison_from_sourceObligations
        measure hnormalized hh hbound hholds,
    q_le_targetVolume_from_membership :=
      unitThetaToy_qSigned_le_thetaTargetVolume_from_membership
        measure hnormalized hh hbound hholds,
    targetVolume_le_thetaBound_from_container :=
      unitThetaToy_thetaTargetVolume_le_thetaBound_from_sourceObligations
        measure hnormalized hh hbound hholds,
    q_le_thetaBound_from_chain :=
      unitThetaToy_qSigned_le_thetaBound_via_thetaTargetVolume
        measure hnormalized hh hbound hholds,
    corollary_from_chain :=
      unitThetaToyCorollary312_from_thetaTargetVolumeChain
        measure hnormalized hh hbound hholds,
    stage_comparison_from_chain :=
      unitThetaToyStage1Comparison_comparison_eq_qThetaChain
        measure hnormalized hh hbound hholds,
    stage_recovers_corollary :=
      unitThetaToyStage1Comparison_recovers_corollary312
        measure hnormalized hh hbound hholds }

theorem unitThetaToy_theta_commonBound_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let ledger := unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds
    ledger.theta_commonBound =
      ledger.chartedContainer.apply ledger.certificate :=
  rfl

theorem unitThetaToy_thetaCommonBound_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let ledger := unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds
    ledger.thetaCommonBound =
      ledger.chartedContainer.apply ledger.certificate :=
  rfl

theorem unitThetaToy_threeTerm_q_le_target_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let ledger := unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds
    ledger.threeTermComparison.q_le_target =
      ledger.membership.q_le_target :=
  rfl

theorem unitThetaToy_threeTerm_target_le_theta_from_sourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let ledger := unitThetaToySourceObligationLedger
      measure hnormalized hh hbound hholds
    ledger.threeTermComparison.target_le_theta =
      (by
        rw [ledger.targetVolume.targetSigned_eq]
        exact TransportedRegionFamily.choice_targetVolume_le_of_commonBound
          ledger.theta_commonBound ledger.chosenOutput.choice) :=
  rfl

end ToyModel
end Stage1
end Iut
