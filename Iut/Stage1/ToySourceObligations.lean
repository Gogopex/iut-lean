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
the named toy HDD composite as its bridge obligation.
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
    hdd :=
      thetaToyHDDCompositeData measure hnormalized unitQToTheta h hbound,
    choice := choice,
    q_le_choice :=
      unitThetaToy_qSigned_le_choiceTargetVolume measure hnormalized h epsilon choice hholds,
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

end ToyModel
end Stage1
end Iut
