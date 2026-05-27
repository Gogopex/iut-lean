/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.AlgorithmicOutput
import Iut.Foundations.QualitativeData

/-!
Bridge schema from certified algorithmic output to common-target bounds.

This file does not assert that IPL, SHE, or APT imply any bound. It packages the
extra source-specific construction that would turn a certified output into a
measured common-target bound.
-/

namespace Iut
namespace RealLineCopy

namespace AlgorithmicOutput

variable {source target : Copy} {index : Type u}

/--
A source-specific constructor that turns certification of an algorithmic output
into measured common-target-bound data.

For the IUT project this is the abstract place where a future formalization of
the "3.11 => 3.11.5" step should live.
-/
structure CommonTargetBoundBridge (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target) (bound : Real) where
  build : output.Certified -> output.CommonTargetBound measure bound

namespace CommonTargetBoundBridge

variable {measure : RegionMeasure target}
variable {output : AlgorithmicOutput source target index}
variable {bound : Real}

def apply (bridge : CommonTargetBoundBridge output measure bound)
    (certified : output.Certified) :
    output.CertifiedCommonTargetBound measure bound :=
  { certified := certified,
    commonBound := bridge.build certified }

theorem choice_targetVolume_le (bridge : CommonTargetBoundBridge output measure bound)
    (certified : output.Certified) (choice : index) :
    RegionMeasure.targetVolume measure (output.comparison choice) <= bound :=
  (bridge.apply certified).choice_targetVolume_le choice

theorem allTargetsAtMost (bridge : CommonTargetBoundBridge output measure bound)
    (certified : output.Certified) :
    RegionComparisonFamily.AllTargetsAtMost measure output.comparisons bound :=
  (bridge.apply certified).allTargetsAtMost

theorem preserves_hasIPL (bridge : CommonTargetBoundBridge output measure bound)
    (certified : output.Certified) :
    output.HasIPL :=
  (bridge.apply certified).hasIPL

theorem preserves_hasSHE (bridge : CommonTargetBoundBridge output measure bound)
    (certified : output.Certified) :
    output.HasSHE :=
  (bridge.apply certified).hasSHE

theorem preserves_hasAPT (bridge : CommonTargetBoundBridge output measure bound)
    (certified : output.Certified) :
    output.HasAPT :=
  (bridge.apply certified).hasAPT

end CommonTargetBoundBridge

/--
A bridge whose source-specific construction consumes structured IPL/SHE/APT data
for the transported family.

This is still only a schema: the bridge is supplied explicitly and is not
derived from the qualitative data by automation or axioms.
-/
structure StructuredCommonTargetBoundBridge
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target) (bound : Real) where
  build :
    QualitativeData.StructuredCertificate output.family ->
      output.CommonTargetBound measure bound

namespace StructuredCommonTargetBoundBridge

variable {measure : RegionMeasure target}
variable {output : AlgorithmicOutput source target index}
variable {bound : Real}

def apply (bridge : StructuredCommonTargetBoundBridge output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    output.CommonTargetBound measure bound :=
  bridge.build certificate

theorem choice_targetVolume_le
    (bridge : StructuredCommonTargetBoundBridge output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family)
    (choice : index) :
    RegionMeasure.targetVolume measure (output.comparison choice) <= bound :=
  TransportedRegionFamily.choice_targetVolume_le_of_commonBound
    (bridge.apply certificate) choice

theorem allTargetsAtMost
    (bridge : StructuredCommonTargetBoundBridge output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    RegionComparisonFamily.AllTargetsAtMost measure output.comparisons bound :=
  TransportedRegionFamily.allTargetsAtMost_of_commonBound
    (bridge.apply certificate)

end StructuredCommonTargetBoundBridge

end AlgorithmicOutput

end RealLineCopy
end Iut
