/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.AlgorithmicBridge
import Iut.Stage1.PilotComparison
import Mathlib.Tactic

/-!
Stage 1 schema for the Corollary 3.12 signed real inequality.

The display near the end of IUT III, Corollary 3.12 compares signed real
log-volume values such as `-|log(q)| <= -|log(Theta)|`. The existing
`PilotLogVolume.value` stores the corresponding positive magnitude. This file
keeps the sign conversion explicit.
-/

namespace Iut
namespace Stage1

open RealLineCopy

/--
Turn a signed real log-volume, such as `-|log(q)|`, into a tagged pilot
log-volume whose stored value is the positive magnitude.
-/
def signedPilotLogVolume (side : PilotSide) (signedValue : Real) : PilotLogVolume :=
  { side := side, value := -signedValue }

@[simp]
theorem signedPilotLogVolume_side (side : PilotSide) (signedValue : Real) :
    (signedPilotLogVolume side signedValue).side = side :=
  rfl

@[simp]
theorem signedPilotLogVolume_value (side : PilotSide) (signedValue : Real) :
    (signedPilotLogVolume side signedValue).value = -signedValue :=
  rfl

theorem corollary312_of_signed_le {thetaSigned qSigned : Real}
    (hle : qSigned <= thetaSigned) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta thetaSigned)
      (signedPilotLogVolume PilotSide.q qSigned) := by
  unfold Corollary312Inequality signedPilotLogVolume
  linarith

def stage1Comparison_of_signed_le {thetaSigned qSigned : Real}
    (hq_positive : 0 < -qSigned) (hle : qSigned <= thetaSigned) :
    Stage1Comparison :=
  { theta := signedPilotLogVolume PilotSide.theta thetaSigned,
    q := signedPilotLogVolume PilotSide.q qSigned,
    theta_side := rfl,
    q_side := rfl,
    q_positive := hq_positive,
    comparison := corollary312_of_signed_le hle }

theorem corollary312_from_bridge
    {source target : Copy} {index : Type u}
    {output : AlgorithmicOutput source target index}
    {measure : RegionMeasure target} {thetaSigned qSigned : Real}
    (bridge : output.CommonTargetBoundBridge measure thetaSigned)
    (certified : output.Certified) (choice : index)
    (hq_le_choice :
      qSigned <= RegionMeasure.targetVolume measure (output.comparison choice)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta thetaSigned)
      (signedPilotLogVolume PilotSide.q qSigned) := by
  exact corollary312_of_signed_le
    (le_trans hq_le_choice (bridge.choice_targetVolume_le certified choice))

theorem corollary312_from_structured_bridge
    {source target : Copy} {index : Type u}
    {output : AlgorithmicOutput source target index}
    {measure : RegionMeasure target} {thetaSigned qSigned : Real}
    (bridge : output.StructuredCommonTargetBoundBridge measure thetaSigned)
    (certificate : QualitativeData.StructuredCertificate output.family)
    (choice : index)
    (hq_le_choice :
      qSigned <= RegionMeasure.targetVolume measure (output.comparison choice)) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta thetaSigned)
      (signedPilotLogVolume PilotSide.q qSigned) := by
  exact corollary312_of_signed_le
    (le_trans hq_le_choice (bridge.choice_targetVolume_le certificate choice))

def stage1Comparison_from_bridge
    {source target : Copy} {index : Type u}
    {output : AlgorithmicOutput source target index}
    {measure : RegionMeasure target} {thetaSigned qSigned : Real}
    (bridge : output.CommonTargetBoundBridge measure thetaSigned)
    (certified : output.Certified) (choice : index)
    (hq_positive : 0 < -qSigned)
    (hq_le_choice :
      qSigned <= RegionMeasure.targetVolume measure (output.comparison choice)) :
    Stage1Comparison :=
  stage1Comparison_of_signed_le hq_positive
    (le_trans hq_le_choice (bridge.choice_targetVolume_le certified choice))

def stage1Comparison_from_structured_bridge
    {source target : Copy} {index : Type u}
    {output : AlgorithmicOutput source target index}
    {measure : RegionMeasure target} {thetaSigned qSigned : Real}
    (bridge : output.StructuredCommonTargetBoundBridge measure thetaSigned)
    (certificate : QualitativeData.StructuredCertificate output.family)
    (choice : index)
    (hq_positive : 0 < -qSigned)
    (hq_le_choice :
      qSigned <= RegionMeasure.targetVolume measure (output.comparison choice)) :
    Stage1Comparison :=
  stage1Comparison_of_signed_le hq_positive
    (le_trans hq_le_choice (bridge.choice_targetVolume_le certificate choice))

end Stage1
end Iut
