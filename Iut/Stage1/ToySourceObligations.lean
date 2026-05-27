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

end ToyModel
end Stage1
end Iut
