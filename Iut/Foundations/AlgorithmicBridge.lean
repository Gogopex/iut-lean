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

/--
Inert identifier for the hull+det operation used in the source-specific bridge.

This name carries no mathematical content by itself. It only prevents the
eventual determinant/log-volume passage from being hidden inside an unnamed
bridge.
-/
structure HullDetOperationId where
  label : String

/--
Inert identifier for the descent operation that precedes hull+det in the HDD
composite.
-/
structure DescentOperationId where
  label : String

/-- Inert identifier for the SHE arrow used to restrict HDD input data. -/
structure SHEArrowId where
  label : String

/-- Inert identifier for a common container/common ring-structure context. -/
structure CommonContainerId where
  label : String

/-- Inert identifier for a chart of real-line copies used in the final comparison. -/
structure RealComparisonChartId where
  label : String

/--
A named hull+det operation together with the structured bridge it supplies.

The bridge remains explicit data: this record does not derive a bound from the
identifier. Future milestones should refine the identifier into actual descent,
holomorphic-hull, determinant, and log-volume constructions.
-/
structure HullDetBridgeData
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target) (bound : Real) where
  operation : HullDetOperationId
  bridge : output.StructuredCommonTargetBoundBridge measure bound

namespace HullDetBridgeData

variable {measure : RegionMeasure target}
variable {output : AlgorithmicOutput source target index}
variable {bound : Real}

def apply (data : HullDetBridgeData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    output.CommonTargetBound measure bound :=
  data.bridge.apply certificate

theorem choice_targetVolume_le
    (data : HullDetBridgeData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family)
    (choice : index) :
    RegionMeasure.targetVolume measure (output.comparison choice) <= bound :=
  data.bridge.choice_targetVolume_le certificate choice

theorem allTargetsAtMost
    (data : HullDetBridgeData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    RegionComparisonFamily.AllTargetsAtMost measure output.comparisons bound :=
  data.bridge.allTargetsAtMost certificate

end HullDetBridgeData

/--
The named HDD composite, modeled as descent followed by a named hull+det bridge.

This record exposes the source decomposition `(HDD) = (hull+det) o (dsc)` while
still requiring the structured bridge as explicit data.
-/
structure HDDCompositeData
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target) (bound : Real) where
  descent : DescentOperationId
  hullDetBridge : output.HullDetBridgeData measure bound

namespace HDDCompositeData

variable {measure : RegionMeasure target}
variable {output : AlgorithmicOutput source target index}
variable {bound : Real}

def structuredBridge (data : HDDCompositeData output measure bound) :
    output.StructuredCommonTargetBoundBridge measure bound :=
  data.hullDetBridge.bridge

def apply (data : HDDCompositeData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    output.CommonTargetBound measure bound :=
  data.hullDetBridge.apply certificate

theorem choice_targetVolume_le
    (data : HDDCompositeData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family)
    (choice : index) :
    RegionMeasure.targetVolume measure (output.comparison choice) <= bound :=
  data.hullDetBridge.choice_targetVolume_le certificate choice

theorem allTargetsAtMost
    (data : HDDCompositeData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    RegionComparisonFamily.AllTargetsAtMost measure output.comparisons bound :=
  data.hullDetBridge.allTargetsAtMost certificate

end HDDCompositeData

/--
Named SHE-arrow data for the final restricted composite.

The datum records which structured SHE witness is used to view the q-pilot data
in the common holomorphic context.
-/
structure SHEArrowData
    (output : AlgorithmicOutput source target index) where
  arrow : SHEArrowId
  datum : QualitativeData.SHEDatum output.family

/--
The fourth-triangle composite `(HDD) o (SHE)`.

This is still inert bookkeeping: the SHE arrow and HDD composite are supplied
explicitly, and no mathematical implication is derived from their names.
-/
structure HDDSHECompositeData
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target) (bound : Real) where
  sheArrow : SHEArrowData output
  hdd : output.HDDCompositeData measure bound

namespace HDDSHECompositeData

variable {measure : RegionMeasure target}
variable {output : AlgorithmicOutput source target index}
variable {bound : Real}

def structuredBridge (data : HDDSHECompositeData output measure bound) :
    output.StructuredCommonTargetBoundBridge measure bound :=
  data.hdd.structuredBridge

def apply (data : HDDSHECompositeData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    output.CommonTargetBound measure bound :=
  data.hdd.apply certificate

theorem choice_targetVolume_le
    (data : HDDSHECompositeData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family)
    (choice : index) :
    RegionMeasure.targetVolume measure (output.comparison choice) <= bound :=
  data.hdd.choice_targetVolume_le certificate choice

theorem allTargetsAtMost
    (data : HDDSHECompositeData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    RegionComparisonFamily.AllTargetsAtMost measure output.comparisons bound :=
  data.hdd.allTargetsAtMost certificate

end HDDSHECompositeData

/--
A named common container for the final simultaneous comparison.

The container records the shared holomorphic context supplied by SHE, the final
`HDD o SHE` composite, and the target-side measure appearing in the type.
-/
structure CommonContainerData
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target) (bound : Real) where
  container : CommonContainerId
  context : QualitativeData.SharedHolomorphicContext
  hddShe : output.HDDSHECompositeData measure bound
  she_context_matches : hddShe.sheArrow.datum.sharedContext = context

namespace CommonContainerData

variable {measure : RegionMeasure target}
variable {output : AlgorithmicOutput source target index}
variable {bound : Real}

def structuredBridge (data : CommonContainerData output measure bound) :
    output.StructuredCommonTargetBoundBridge measure bound :=
  data.hddShe.structuredBridge

def apply (data : CommonContainerData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    output.CommonTargetBound measure bound :=
  data.hddShe.apply certificate

theorem choice_targetVolume_le
    (data : CommonContainerData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family)
    (choice : index) :
    RegionMeasure.targetVolume measure (output.comparison choice) <= bound :=
  data.hddShe.choice_targetVolume_le certificate choice

theorem allTargetsAtMost
    (data : CommonContainerData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    RegionComparisonFamily.AllTargetsAtMost measure output.comparisons bound :=
  data.hddShe.allTargetsAtMost certificate

end CommonContainerData

/--
A named chart of the real-line copies used by the final comparison.

The q-side real line is transported into the target-side real line, while the
Theta-side line is already the target. The Theta transport is recorded anyway so
that its triviality is an explicit hypothesis rather than an implicit convention.
-/
structure RealComparisonChartData
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target) where
  chart : RealComparisonChartId
  qToTarget : Transport source target
  thetaToTarget : Transport target target
  theta_trivial : Transport.TrivialMonodromy thetaToTarget

namespace RealComparisonChartData

variable {measure : RegionMeasure target}
variable {output : AlgorithmicOutput source target index}

/-- The q-to-target map is being used as a chart reading, not as a history map. -/
def QToTargetAllowedReading
    (chartData : RealComparisonChartData output measure) : Prop :=
  Transport.PointwiseEqual chartData.qToTarget chartData.qToTarget

/--
The Theta-side target transport is allowed as a chart reading only together
with its explicit triviality proof.
-/
def ThetaToTargetAllowedReading
    (chartData : RealComparisonChartData output measure) : Prop :=
  Transport.TrivialMonodromy chartData.thetaToTarget

/--
Chart-level discipline for the real-comparison transports.

This record belongs to the chart itself. It does not identify Hodge-theater
histories; it only records which real-line-copy transports are allowed as chart
readings.
-/
structure TransportDiscipline
    (chartData : RealComparisonChartData output measure) where
  q_to_target_allowed : chartData.QToTargetAllowedReading
  theta_to_target_allowed : chartData.ThetaToTargetAllowedReading

def transportDiscipline
    (chartData : RealComparisonChartData output measure) :
    chartData.TransportDiscipline :=
  { q_to_target_allowed := Transport.pointwiseEqual_of_scale_eq rfl,
    theta_to_target_allowed := chartData.theta_trivial }

theorem qToTargetAllowedReading
    (chartData : RealComparisonChartData output measure) :
    chartData.QToTargetAllowedReading :=
  chartData.transportDiscipline.q_to_target_allowed

theorem thetaToTargetAllowedReading
    (chartData : RealComparisonChartData output measure) :
    chartData.ThetaToTargetAllowedReading :=
  chartData.transportDiscipline.theta_to_target_allowed

end RealComparisonChartData

/--
The q-side value as read through a specific real-comparison chart.

This record keeps the q-side point and the target-coordinate real number tied
by the chart transport.
-/
structure ChartedQValueData
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target)
    (chart : output.RealComparisonChartData measure)
    (qSigned : Real) where
  qPoint : Point source
  qSigned_eq : (Transport.map chart.qToTarget qPoint).coord = qSigned

/--
The Theta-side bound as read through a specific real-comparison chart.

The point lives on the target side; the explicit chart transport prevents the
Theta-side bound from being silently read in an unnamed copy of the reals.
-/
structure ChartedThetaBoundData
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target)
    (chart : output.RealComparisonChartData measure)
    (thetaSigned : Real) where
  thetaPoint : Point target
  thetaSigned_eq : (Transport.map chart.thetaToTarget thetaPoint).coord = thetaSigned

/--
The selected output comparison from the transported output family.

This names the chosen possibility before any target-volume measurement is
applied.
-/
structure ChosenOutputData
    (output : AlgorithmicOutput source target index) where
  choice : index
  comparison : RegionComparison source target
  comparison_eq : comparison = output.comparison choice

/--
The chosen output target volume as a named middle term in the final comparison.

The `chart` parameter records that this target-side real is being read in the
same real-comparison chart as the q- and Theta-side values.
-/
structure ChartedTargetVolumeData
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target)
    (chart : output.RealComparisonChartData measure)
    (choice : index) where
  targetSigned : Real
  targetSigned_eq :
    targetSigned = RegionMeasure.targetVolume measure (output.comparison choice)

/--
Membership of the charted q-point in the selected output comparison.

The inequality field records the current abstraction boundary: in concrete
upper-ray models this follows from membership and normalization, while the
general source-obligation ledger still stores it explicitly.
-/
structure ChartedMembershipData
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target)
    (chart : output.RealComparisonChartData measure)
    {qSigned : Real}
    (qValue : output.ChartedQValueData measure chart qSigned)
    (chosenOutput : output.ChosenOutputData)
    (targetVolume :
      output.ChartedTargetVolumeData measure chart chosenOutput.choice) where
  holds : chosenOutput.comparison.Holds qValue.qPoint
  q_le_target : qSigned <= targetVolume.targetSigned

/--
A common container together with the real-line comparison chart used to read its
final q- and Theta-side real numbers in the target copy.
-/
structure ChartedCommonContainerData
    (output : AlgorithmicOutput source target index)
    (measure : RegionMeasure target) (bound : Real) where
  commonContainer : output.CommonContainerData measure bound
  chart : output.RealComparisonChartData measure

namespace ChartedCommonContainerData

variable {measure : RegionMeasure target}
variable {output : AlgorithmicOutput source target index}
variable {bound : Real}

def structuredBridge (data : ChartedCommonContainerData output measure bound) :
    output.StructuredCommonTargetBoundBridge measure bound :=
  data.commonContainer.structuredBridge

def apply (data : ChartedCommonContainerData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    output.CommonTargetBound measure bound :=
  data.commonContainer.apply certificate

theorem choice_targetVolume_le
    (data : ChartedCommonContainerData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family)
    (choice : index) :
    RegionMeasure.targetVolume measure (output.comparison choice) <= bound :=
  data.commonContainer.choice_targetVolume_le certificate choice

theorem allTargetsAtMost
    (data : ChartedCommonContainerData output measure bound)
    (certificate : QualitativeData.StructuredCertificate output.family) :
    RegionComparisonFamily.AllTargetsAtMost measure output.comparisons bound :=
  data.commonContainer.allTargetsAtMost certificate

theorem thetaTrivial
    (data : ChartedCommonContainerData output measure bound) :
    Transport.TrivialMonodromy data.chart.thetaToTarget :=
  data.chart.theta_trivial

end ChartedCommonContainerData

end AlgorithmicOutput

end RealLineCopy
end Iut
