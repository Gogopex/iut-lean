/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Stage1.IUTStage1Source

/-!
First experiment surface for the IUT III Corollary 3.12 corridor.

These are not numerical experiments.  They are Lean-level diagnostic passes
that expose which local `(Ind3)` data can feed the current Hodge-descent
packet-to-theta route and which real/log-volume alignments remain missing.
-/

namespace Iut
namespace Stage1
namespace Experiments

open RealLineCopy
open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
open FLZModCuspLabelThetaHodgeDescentPacketTransportAudit
open FLZModCuspLabelThetaCuspClassContainerAudit

/-- First pass: no real-line/log-volume alignment has been supplied. -/
def ind3MissingRealAlignmentReport :
    IUTStage1Ind3AlignmentExperimentReport :=
  IUTStage1Ind3AlignmentExperimentReport.missingRealAlignment

theorem ind3MissingRealAlignment_blocks :
    ind3MissingRealAlignmentReport.canBuildSourceTargetAlignment = false :=
  IUTStage1Ind3AlignmentExperimentReport.missingRealAlignment_cannotBuild

theorem ind3MissingRealAlignment_packetSourceGap :
    IUTStage1Ind3AlignmentMissingDatum.packetLocalObjectFinite_eq_ind3Source ∈
      ind3MissingRealAlignmentReport.missing :=
  IUTStage1Ind3AlignmentExperimentReport.missingRealAlignment_packetSource_missing

theorem ind3MissingRealAlignment_thetaTargetGap :
    IUTStage1Ind3AlignmentMissingDatum.thetaAverage_eq_ind3Target ∈
      ind3MissingRealAlignmentReport.missing :=
  IUTStage1Ind3AlignmentExperimentReport.missingRealAlignment_thetaTarget_missing

/-- Nonarchimedean local `(Ind3)` inclusion has the route-compatible orientation. -/
def nonarchimedeanInd3LocalReport
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {thetaAverage : Real}
    (alignment :
      NonarchimedeanInd3EntryAlignment audited entry thetaAverage) :
    IUTStage1Ind3LocalExperimentReport :=
  alignment.experimentReport

theorem nonarchimedeanInd3Local_canFeed
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {thetaAverage : Real}
    (alignment :
      NonarchimedeanInd3EntryAlignment audited entry thetaAverage) :
    (nonarchimedeanInd3LocalReport alignment).canFeedPacketToThetaRoute = true :=
  alignment.experimentReport_canFeed

/-- Archimedean local `(Ind3)` surjection has the reverse orientation here. -/
def archimedeanInd3LocalReport
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    {entry : IUTStage1ArchimedeanSurjectionData}
    {thetaAverage : Real}
    (alignment :
      ArchimedeanInd3EntryAlignment audited entry thetaAverage) :
    IUTStage1Ind3LocalExperimentReport :=
  alignment.experimentReport

theorem archimedeanInd3Local_cannotFeed
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    {entry : IUTStage1ArchimedeanSurjectionData}
    {thetaAverage : Real}
    (alignment :
      ArchimedeanInd3EntryAlignment audited entry thetaAverage) :
    (archimedeanInd3LocalReport alignment).canFeedPacketToThetaRoute = false :=
  alignment.experimentReport_cannotFeed

theorem ind3LocalOrientations_differ :
    IUTStage1Ind3LocalOrientation.packet_le_theta ≠
      IUTStage1Ind3LocalOrientation.theta_le_packet :=
  IUTStage1Ind3LocalOrientation.packet_le_theta_ne_theta_le_packet

/-- Summary of the first diagnostic pass through the local `(Ind3)` route. -/
structure Ind3FirstPassDashboard where
  missingRealAlignmentBlocks : Bool
  nonarchimedeanEntryCanFeed : Bool
  archimedeanEntryCanFeed : Bool
  localOrientationsSeparated : Bool
deriving Repr

/--
Current first-pass outcome.

This value records the results proved above: real alignment is still an
explicit missing layer; nonarchimedean local upper-semi entries have the
orientation needed by the current route; archimedean entries do not; and Lean
distinguishes the two orientations.
-/
def ind3FirstPassDashboard : Ind3FirstPassDashboard :=
  { missingRealAlignmentBlocks := true,
    nonarchimedeanEntryCanFeed := true,
    archimedeanEntryCanFeed := false,
    localOrientationsSeparated := true }

theorem ind3FirstPassDashboard_missingRealAlignmentBlocks :
    ind3FirstPassDashboard.missingRealAlignmentBlocks = true :=
  rfl

theorem ind3FirstPassDashboard_nonarchimedeanEntryCanFeed :
    ind3FirstPassDashboard.nonarchimedeanEntryCanFeed = true :=
  rfl

theorem ind3FirstPassDashboard_archimedeanEntryCanFeed :
    ind3FirstPassDashboard.archimedeanEntryCanFeed = false :=
  rfl

theorem ind3FirstPassDashboard_localOrientationsSeparated :
    ind3FirstPassDashboard.localOrientationsSeparated = true :=
  rfl

/-- Final-route experiment status for the current `(Ind3)` corridor. -/
structure Ind3FinalRouteExperimentReport where
  finalQThetaRouteAvailable : Bool
  localOrientation : Option IUTStage1Ind3LocalOrientation
  missingAlignment : Finset IUTStage1Ind3AlignmentMissingDatum

/-- No source/target real alignment: the final q/Theta route is unavailable. -/
def missingAlignmentFinalRouteReport : Ind3FinalRouteExperimentReport :=
  { finalQThetaRouteAvailable := false,
    localOrientation := none,
    missingAlignment := IUTStage1Ind3AlignmentMissingDatum.all }

theorem missingAlignmentFinalRouteReport_unavailable :
    missingAlignmentFinalRouteReport.finalQThetaRouteAvailable = false :=
  rfl

theorem missingAlignmentFinalRouteReport_packetSourceGap :
    IUTStage1Ind3AlignmentMissingDatum.packetLocalObjectFinite_eq_ind3Source ∈
      missingAlignmentFinalRouteReport.missingAlignment :=
  IUTStage1Ind3AlignmentMissingDatum.packetLocalObjectFinite_eq_ind3Source_mem_all

theorem missingAlignmentFinalRouteReport_thetaTargetGap :
    IUTStage1Ind3AlignmentMissingDatum.thetaAverage_eq_ind3Target ∈
      missingAlignmentFinalRouteReport.missingAlignment :=
  IUTStage1Ind3AlignmentMissingDatum.thetaAverage_eq_ind3Target_mem_all

/-- Nonarchimedean local alignment: the current final q/Theta route is available. -/
def nonarchimedeanFinalRouteReport
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {thetaAverage : Real}
    (_alignment :
      NonarchimedeanInd3EntryAlignment audited entry thetaAverage) :
    Ind3FinalRouteExperimentReport :=
  { finalQThetaRouteAvailable := true,
    localOrientation := some IUTStage1Ind3LocalOrientation.packet_le_theta,
    missingAlignment := ∅ }

theorem nonarchimedeanFinalRouteReport_available
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {thetaAverage : Real}
    (alignment :
      NonarchimedeanInd3EntryAlignment audited entry thetaAverage) :
    (nonarchimedeanFinalRouteReport alignment).finalQThetaRouteAvailable = true :=
  rfl

theorem nonarchimedeanFinalRouteReport_orientation
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {thetaAverage : Real}
    (alignment :
      NonarchimedeanInd3EntryAlignment audited entry thetaAverage) :
    (nonarchimedeanFinalRouteReport alignment).localOrientation =
      some IUTStage1Ind3LocalOrientation.packet_le_theta :=
  rfl

/-- Archimedean local alignment: reverse orientation, so this route is unavailable. -/
def archimedeanFinalRouteReport
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    {entry : IUTStage1ArchimedeanSurjectionData}
    {thetaAverage : Real}
    (_alignment :
      ArchimedeanInd3EntryAlignment audited entry thetaAverage) :
    Ind3FinalRouteExperimentReport :=
  { finalQThetaRouteAvailable := false,
    localOrientation := some IUTStage1Ind3LocalOrientation.theta_le_packet,
    missingAlignment := ∅ }

theorem archimedeanFinalRouteReport_unavailable
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    {entry : IUTStage1ArchimedeanSurjectionData}
    {thetaAverage : Real}
    (alignment :
      ArchimedeanInd3EntryAlignment audited entry thetaAverage) :
    (archimedeanFinalRouteReport alignment).finalQThetaRouteAvailable = false :=
  rfl

theorem archimedeanFinalRouteReport_orientation
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    {entry : IUTStage1ArchimedeanSurjectionData}
    {thetaAverage : Real}
    (alignment :
      ArchimedeanInd3EntryAlignment audited entry thetaAverage) :
    (archimedeanFinalRouteReport alignment).localOrientation =
      some IUTStage1Ind3LocalOrientation.theta_le_packet :=
  rfl

/--
Route theorem used by the final-route experiment: a nonarchimedean local
`(Ind3)` entry with the required alignments reaches the q/Theta comparison.
-/
theorem nonarchimedeanEntry_finalQTheta
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean)
    (transport_audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package part.bundle l)
    (source_profile_eq :
      profile = transport_audit.preservationAudit.sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        transport_audit.preservationAudit.sourceLogVolume)
    (target_log_volume_eq_theta :
      transport_audit.preservationAudit.targetLogVolume =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {entry : IUTStage1NonarchimedeanInclusionData}
    (entryAlignment :
      NonarchimedeanInd3EntryAlignment audited entry
        (part.insulated_route.theta_source.thetaSourceAverage audited)) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  let sourceAudit :=
    part.toInd3SourceZeroCuspTargetThetaAuditOfNonarchimedeanEntry
      profile audited transport_audit source_profile_eq source_log_volume_eq
      target_log_volume_eq_theta entryAlignment
  (part.toThetaCuspClassContainerAudit
    |>.weightedThetaComparisonRouteOfInd3SourceZeroCuspTarget
      part.bundle profile audited sourceAudit).qSigned_le_thetaSigned

/-- Scale-level status for transport-explicit real-line cancellation. -/
structure Ind3TransportScaleExperimentReport where
  sourceScaleMatched : Bool
  targetScaleMatched : Bool
  canCancelToRawAlignment : Bool
deriving Repr

/-- Matched source and target scales allow the transport-explicit alignment to feed the route. -/
def matchedTransportScaleReport
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    {part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l}
    {audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (_alignment : Ind3OrderedRealLineAlignment part audited) :
    Ind3TransportScaleExperimentReport :=
  { sourceScaleMatched := true,
    targetScaleMatched := true,
    canCancelToRawAlignment := true }

theorem matchedTransportScaleReport_canCancel
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    {part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l}
    {audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (alignment : Ind3OrderedRealLineAlignment part audited) :
    (matchedTransportScaleReport alignment).canCancelToRawAlignment = true :=
  rfl

/--
Route theorem using transport-explicit real-line alignment rather than raw
source/target equalities.
-/
theorem orderedRealLineAlignment_finalQTheta
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (transport_audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package part.bundle l)
    (source_profile_eq :
      profile = transport_audit.preservationAudit.sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        transport_audit.preservationAudit.sourceLogVolume)
    (target_log_volume_eq_theta :
      transport_audit.preservationAudit.targetLogVolume =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    (alignment : Ind3OrderedRealLineAlignment part audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  let sourceAudit :=
    part.toInd3SourceZeroCuspTargetThetaAudit profile audited transport_audit
      source_profile_eq source_log_volume_eq target_log_volume_eq_theta
      alignment.toInd3SourceTargetAlignment
  (part.toThetaCuspClassContainerAudit
    |>.weightedThetaComparisonRouteOfInd3SourceZeroCuspTarget
      part.bundle profile audited sourceAudit).qSigned_le_thetaSigned

/-- A concrete positive scale `2`, used to test mismatched real-line transports. -/
def positiveScaleTwo : PositiveScale :=
  { val := 2, pos := by norm_num }

def scaleMismatchPacketLine : Copy :=
  { label := "Ind3 scale-mismatch packet line" }

def scaleMismatchSourceLine : Copy :=
  { label := "Ind3 scale-mismatch source line" }

def scaleMismatchCommonLine : Copy :=
  { label := "Ind3 scale-mismatch common line" }

def scaleMismatchPacketToCommon :
    Transport scaleMismatchPacketLine scaleMismatchCommonLine :=
  { scale := PositiveScale.one }

def scaleMismatchSourceToCommon :
    Transport scaleMismatchSourceLine scaleMismatchCommonLine :=
  { scale := positiveScaleTwo }

def scaleMismatchPacketPoint : Point scaleMismatchPacketLine :=
  point scaleMismatchPacketLine 2

def scaleMismatchSourcePoint : Point scaleMismatchSourceLine :=
  point scaleMismatchSourceLine 1

/--
Transported coordinates can agree under mismatched positive scales even when
the raw coordinates do not.
-/
theorem scaleMismatch_transported_coords_equal :
    (Transport.map scaleMismatchPacketToCommon scaleMismatchPacketPoint).coord =
      (Transport.map scaleMismatchSourceToCommon scaleMismatchSourcePoint).coord := by
  norm_num [scaleMismatchPacketToCommon, scaleMismatchSourceToCommon,
    scaleMismatchPacketPoint, scaleMismatchSourcePoint, Transport.map,
    PositiveScale.one, positiveScaleTwo, point]

theorem scaleMismatch_transport_scales_differ :
    scaleMismatchPacketToCommon.scale.val ≠
      scaleMismatchSourceToCommon.scale.val := by
  norm_num [scaleMismatchPacketToCommon, scaleMismatchSourceToCommon,
    PositiveScale.one, positiveScaleTwo]

theorem scaleMismatch_raw_coords_differ :
    scaleMismatchPacketPoint.coord ≠ scaleMismatchSourcePoint.coord := by
  norm_num [scaleMismatchPacketPoint, scaleMismatchSourcePoint, point]

def mismatchedTransportScaleReport : Ind3TransportScaleExperimentReport :=
  { sourceScaleMatched := false,
    targetScaleMatched := true,
    canCancelToRawAlignment := false }

theorem mismatchedTransportScaleReport_cannotCancel :
    mismatchedTransportScaleReport.canCancelToRawAlignment = false :=
  rfl

/-- Experiment report for the label-dependent representative `j^2` scales. -/
structure Ind3J2ScaleExperimentReport where
  oneScale : Real
  twoScale : Real
  scalesDiffer : Bool
  labelIndependentScaleCanMatchAll : Bool
  nonzeroQPilotDegreeRejectsLabelIndependentThetaScale : Bool
  representativeJ2SignQuotientDescentRejected : Bool
  balancedThetaPilotDegreeDescendsToSignQuotient : Bool
  absLabelThetaExponentMatchesHalfRangeJ2 : Bool
  absLabelThetaPilotDegreeProfileAvailable : Bool

/--
For every `l >= 5`, the representative square scales at `j = 1` and `j = 2`
already differ.  At the sign-quotient level, the raw representative `j^2`
profile does not descend, while the balanced sign-compatible profile does.
-/
def ind3J2ScaleExperimentReport (l : PrimeGeFive) :
    Ind3J2ScaleExperimentReport :=
  { oneScale :=
      IUTStage1ZModSquareWeightProfile.representativeSquareScale
        (l := l) (1 : ZMod l.value),
    twoScale :=
      IUTStage1ZModSquareWeightProfile.representativeSquareScale
        (l := l) (2 : ZMod l.value),
    scalesDiffer := true,
    labelIndependentScaleCanMatchAll := false,
    nonzeroQPilotDegreeRejectsLabelIndependentThetaScale := true,
    representativeJ2SignQuotientDescentRejected := true,
    balancedThetaPilotDegreeDescendsToSignQuotient := true,
    absLabelThetaExponentMatchesHalfRangeJ2 := true,
    absLabelThetaPilotDegreeProfileAvailable := true }

theorem ind3J2ScaleExperimentReport_oneScale
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport l).oneScale = 1 :=
  IUTStage1ZModSquareWeightProfile.representativeSquareScale_one

theorem ind3J2ScaleExperimentReport_twoScale
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport l).twoScale = 4 :=
  IUTStage1ZModSquareWeightProfile.representativeSquareScale_two

theorem ind3J2ScaleExperimentReport_scalesDiffer
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport l).scalesDiffer = true :=
  rfl

theorem ind3J2ScaleExperimentReport_noLabelIndependentScale
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport l).labelIndependentScaleCanMatchAll = false :=
  rfl

theorem ind3J2ScaleExperimentReport_noThetaPilotDegreeScale
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport
      l).nonzeroQPilotDegreeRejectsLabelIndependentThetaScale = true :=
  rfl

theorem ind3J2ScaleExperimentReport_noSignQuotientDescent
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport
      l).representativeJ2SignQuotientDescentRejected = true :=
  rfl

theorem ind3J2ScaleExperimentReport_balancedDescends
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport
      l).balancedThetaPilotDegreeDescendsToSignQuotient = true :=
  rfl

theorem ind3J2ScaleExperimentReport_absLabelExponent
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport
      l).absLabelThetaExponentMatchesHalfRangeJ2 = true :=
  rfl

theorem ind3J2ScaleExperimentReport_absLabelProfile
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport
      l).absLabelThetaPilotDegreeProfileAvailable = true :=
  rfl

theorem no_labelIndependent_transport_scale_absorbs_j2
    (l : PrimeGeFive) (scale : Real) :
    ¬ ∀ j : ZMod l.value,
      scale =
        IUTStage1ZModSquareWeightProfile.representativeSquareScale
          (l := l) j :=
  IUTStage1ZModSquareWeightProfile.no_label_independent_scale_matches_all_representative_squares
    (l := l) scale

/--
Concrete pilot-degree collapse test for the representative relation
`Theta_j ~ q^{j^2}`.

If the q-pilot degree is nonzero, no single label-independent scale can make all
representative theta-pilot degrees equal to that scale times the q-pilot degree.
-/
theorem no_labelIndependent_thetaPilot_degree_scale
    {l : PrimeGeFive}
    (profile :
      IUTStage1ZModSquareWeightProfile.RepresentativeThetaPilotDegreeProfile l)
    (q_ne_zero : profile.qPilotDegree ≠ 0)
    (scale : Real) :
    ¬ ∀ j : ZMod l.value,
      profile.thetaPilotDegree j = scale * profile.qPilotDegree :=
  profile.no_labelIndependent_scale_matches_theta_degrees q_ne_zero scale

/--
Raw representative theta-pilot degrees cannot be pushed down to
`F_l / {±1}` when the q-pilot degree is nonzero.
-/
theorem no_signQuotient_representativeThetaPilot_degree
    {l : PrimeGeFive}
    (qPilotDegree : Real) (q_ne_zero : qPilotDegree ≠ 0) :
    ¬ ∃ thetaOnQuotient :
        (zmodSignAction l).SignLabelQuotient -> Real,
      ∀ (j : ZMod l.value) (hj : j ≠ 0),
        thetaOnQuotient (zmodSignLabelFromCoordinate l j hj) =
          IUTStage1ZModSquareWeightProfile.representativeSquareScale
            (l := l) j * qPilotDegree :=
  IUTStage1ZModSquareWeightProfile.not_exists_signQuotient_representativeThetaPilotDegree
    (l := l) qPilotDegree q_ne_zero

/--
The balanced sign-compatible theta-pilot profile has the expected quotient-level
coordinate equation.
-/
theorem balanced_signQuotient_thetaPilot_degree_fromCoordinate
    {l : PrimeGeFive}
    (profile :
      IUTStage1ZModSquareWeightProfile.BalancedThetaPilotDegreeProfile l)
    (j : ZMod l.value) (hj : j ≠ 0) :
    profile.thetaPilotDegree (zmodSignLabelFromCoordinate l j hj) =
      IUTStage1ZModSquareWeightProfile.balancedSquareWeight
        (l := l) j * profile.qPilotDegree :=
  profile.thetaPilotDegree_fromCoordinate j hj

/--
On the canonical half-range representatives of `|F_l|`, the full-label exponent
is the displayed `j^2` exponent from the IUT theta-value formula.
-/
theorem absLabel_thetaExponent_matches_halfRange_j2
    {l : PrimeGeFive}
    (j : ZMod l.value) (hhalf : j.val ≤ l.value / 2) :
    IUTStage1ZModSquareWeightProfile.thetaExponentOnAbsLabel
        (l := l) (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      ((j.val : Real) ^ 2) :=
  IUTStage1ZModSquareWeightProfile.thetaExponentOnAbsLabel_fromCoordinate_of_val_le_half
    (l := l) j hhalf

/--
The full `|F_l|` theta-pilot degree profile gives the displayed
`deg(Theta_j)=j^2 deg(q)` formula on half-range representatives.
-/
theorem absLabel_thetaPilot_degree_matches_halfRange_j2
    {l : PrimeGeFive}
    (profile :
      IUTStage1ZModSquareWeightProfile.AbsThetaPilotDegreeProfile l)
    (j : ZMod l.value) (hhalf : j.val ≤ l.value / 2) :
    profile.thetaPilotDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      ((j.val : Real) ^ 2) * profile.qPilotDegree :=
  profile.thetaPilotDegree_fromCoordinate_of_val_le_half j hhalf

/-- Experiment report separating representative, balanced, and aggregate levels. -/
structure Ind3SquareWeightLevelExperimentReport where
  representativeAuditForcesIdentity : Bool
  representativeAuditRejectsNegation : Bool
  balancedNegPreservesBalancedWeights : Bool
  balancedNegFailsRepresentativeSummands : Bool
  balancedLevelIsNotPointwise : Bool
  aggregateLevelIsNotPointwise : Bool
deriving Repr

/--
Current level diagnostic for the `j^2` branch of the 3.12 corridor.

Representative pointwise transport is rigid; balanced sign-compatible transport
preserves the balanced branch but not the representative `j.val^2` branch; and
aggregate/hull levels are tracked as separate comparison levels.
-/
def ind3SquareWeightLevelExperimentReport :
    Ind3SquareWeightLevelExperimentReport :=
  { representativeAuditForcesIdentity := true,
    representativeAuditRejectsNegation := true,
    balancedNegPreservesBalancedWeights := true,
    balancedNegFailsRepresentativeSummands := true,
    balancedLevelIsNotPointwise := true,
    aggregateLevelIsNotPointwise := true }

theorem representativeSquareWeightAudit_forcesIdentity
    {l : PrimeGeFive}
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l) :
    audit.coordinateEquiv = Equiv.refl (ZMod l.value) :=
  audit.coordinateEquiv_eq_refl

theorem representativeSquareWeightAudit_rejectsNegation
    {l : PrimeGeFive}
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l) :
    audit.coordinateEquiv ≠ Equiv.neg (ZMod l.value) :=
  audit.coordinateEquiv_ne_neg

theorem balancedNeg_preservesBalancedWeights
    {l : PrimeGeFive}
    (logVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    ∀ j : ZMod l.value,
      IUTStage1ZModSquareWeightProfile.balancedSquareWeight
          (l := l)
          ((IUTStage1BalancedSquareFullLabelTransport.negSelf
            logVolume).coordinateEquiv j) =
        IUTStage1ZModSquareWeightProfile.balancedSquareWeight
          (l := l) j :=
  (IUTStage1BalancedSquareFullLabelTransport.negSelf
    logVolume).balancedSquareWeight_preserved

theorem balancedNeg_failsRepresentativeSummands
    {l : PrimeGeFive}
    (logVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    ¬ ∀ j : ZMod l.value,
      IUTStage1ZModSquareWeightProfile.representativeFullLabelWeightedSummand
          (l := l)
          (IUTStage1ZModCuspLabelLogVolumeCompatibility.constant
            (l := l) (1 : Real))
          ((IUTStage1BalancedSquareFullLabelTransport.negSelf
            logVolume).coordinateEquiv j) =
        IUTStage1ZModSquareWeightProfile.representativeFullLabelWeightedSummand
          (l := l)
          (IUTStage1ZModCuspLabelLogVolumeCompatibility.constant
            (l := l) (1 : Real))
          j :=
  IUTStage1BalancedSquareFullLabelTransport.negSelf_not_representativeSummand_constant_one_preserved
    logVolume

theorem balancedNeg_levelIsNotPointwise
    {l : PrimeGeFive}
    (logVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    (IUTStage1BalancedSquareFullLabelTransport.negSelf
        logVolume).comparisonLevel ≠
      IUTStage1SquareComparisonLevel.pointwiseRepresentative :=
  (IUTStage1BalancedSquareFullLabelTransport.negSelf
    logVolume).comparisonLevel_ne_pointwiseRepresentative

theorem aggregateLevelIsNotPointwise :
    IUTStage1ZModSquareWeightProfile.representativeAggregateComparisonLevel ≠
      IUTStage1ZModSquareWeightProfile.representativePointwiseComparisonLevel :=
  IUTStage1ZModSquareWeightProfile.representativeAggregateComparisonLevel_ne_pointwise

theorem ind3SquareWeightLevelExperimentReport_representativeIdentity :
    ind3SquareWeightLevelExperimentReport.representativeAuditForcesIdentity =
      true :=
  rfl

theorem ind3SquareWeightLevelExperimentReport_representativeRejectsNegation :
    ind3SquareWeightLevelExperimentReport.representativeAuditRejectsNegation =
      true :=
  rfl

theorem ind3SquareWeightLevelExperimentReport_balancedNotPointwise :
    ind3SquareWeightLevelExperimentReport.balancedLevelIsNotPointwise = true :=
  rfl

theorem ind3SquareWeightLevelExperimentReport_aggregateNotPointwise :
    ind3SquareWeightLevelExperimentReport.aggregateLevelIsNotPointwise = true :=
  rfl

/-- Experiment report for the comparison level consumed by the final q/Theta route. -/
structure Ind3FinalRouteLevelExperimentReport where
  finalRouteIsHullLogVolume : Bool
  finalRouteRejectsPointwise : Bool
  finalRouteRejectsAggregate : Bool
  finalRouteRejectsBalanced : Bool
  missingComparisonDatumIsHullLevel : Bool
deriving Repr

/--
The current final weighted-theta route is a hull/log-volume comparison, not a
representative pointwise, aggregate-only, or balanced sign-compatible comparison.
-/
def ind3FinalRouteLevelExperimentReport :
    Ind3FinalRouteLevelExperimentReport :=
  { finalRouteIsHullLogVolume := true,
    finalRouteRejectsPointwise := true,
    finalRouteRejectsAggregate := true,
    finalRouteRejectsBalanced := true,
    missingComparisonDatumIsHullLevel := true }

theorem finalWeightedThetaRoute_levelIsHull
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    {part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l}
    {profile : IUTStage1ZModSquareWeightProfile l}
    {audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (route :
      FLZModCuspLabelThetaCuspClassContainerAudit.WeightedThetaComparisonRoute
        part profile audited) :
    FLZModCuspLabelThetaCuspClassContainerAudit.weightedThetaComparisonRouteLevel
        route =
      IUTStage1SquareComparisonLevel.hullLogVolume :=
  weightedThetaComparisonRouteLevel_eq_hullLogVolume route

theorem finalWeightedThetaRoute_rejectsBalanced
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    {part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l}
    {profile : IUTStage1ZModSquareWeightProfile l}
    {audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (route :
      FLZModCuspLabelThetaCuspClassContainerAudit.WeightedThetaComparisonRoute
        part profile audited) :
    FLZModCuspLabelThetaCuspClassContainerAudit.weightedThetaComparisonRouteLevel
        route ≠
      IUTStage1SquareComparisonLevel.balancedSignCompatible :=
  weightedThetaComparisonRouteLevel_ne_balancedSignCompatible route

theorem finalWeightedThetaRoute_rejectsPointwise
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    {part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l}
    {profile : IUTStage1ZModSquareWeightProfile l}
    {audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (route :
      FLZModCuspLabelThetaCuspClassContainerAudit.WeightedThetaComparisonRoute
        part profile audited) :
    FLZModCuspLabelThetaCuspClassContainerAudit.weightedThetaComparisonRouteLevel
        route ≠
      IUTStage1SquareComparisonLevel.pointwiseRepresentative :=
  weightedThetaComparisonRouteLevel_ne_pointwiseRepresentative route

theorem finalWeightedThetaRoute_rejectsAggregate
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    {part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l}
    {profile : IUTStage1ZModSquareWeightProfile l}
    {audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (route :
      FLZModCuspLabelThetaCuspClassContainerAudit.WeightedThetaComparisonRoute
        part profile audited) :
    FLZModCuspLabelThetaCuspClassContainerAudit.weightedThetaComparisonRouteLevel
        route ≠
      IUTStage1SquareComparisonLevel.aggregateRepresentative :=
  weightedThetaComparisonRouteLevel_ne_aggregateRepresentative route

theorem missingWeightedThetaComparisonDatum_rejectsBalanced :
    (IUTStage1WeightedThetaComparisonMissingDatum.weightedAverage_le_thetaAverage
        |>.comparisonLevel) ≠
      IUTStage1SquareComparisonLevel.balancedSignCompatible :=
  IUTStage1WeightedThetaComparisonMissingDatum.comparisonLevel_ne_balancedSignCompatible
    IUTStage1WeightedThetaComparisonMissingDatum.weightedAverage_le_thetaAverage

theorem ind3FinalRouteLevelExperimentReport_rejectsBalanced :
    ind3FinalRouteLevelExperimentReport.finalRouteRejectsBalanced = true :=
  rfl

/-- First Lean-level conclusion about the Corollary 3.12 disputed passage. -/
structure Corollary312DisputeFirstPassReport where
  orderedRealLineRouteTheoremAvailable : Bool
  nonarchimedeanEntryCanonicalAlignmentTheoremAvailable : Bool
  factoredSHEBridgeTheoremAvailable : Bool
  mismatchCounterexampleBlocksRawCancellation : Bool
  labelIndependentJ2CollapseRejectedInZModModel : Bool
  representativeJ2SignQuotientDescentRejectedInZModModel : Bool
  absLabelThetaDegreeHalfRangeModelAvailable : Bool
  balancedLevelRejectedAtFinalRouteTheoremAvailable : Bool
  disputeSettledByCurrentStage : Bool
deriving Repr

/--
Current experimental reading of the formalized 3.11 to 3.12 corridor.

The route can reach the final q/Theta inequality after explicit ordered
real-line alignment.  The two tested collapse mechanisms are blocked:
mismatched real-line scales do not cancel to raw equality, and the
representative `j^2` scale is not label-independent.  This is still a
first-pass result, so it records that the full dispute is not settled at this
stage.
-/
def corollary312DisputeFirstPassReport :
    Corollary312DisputeFirstPassReport :=
  { orderedRealLineRouteTheoremAvailable := true,
    nonarchimedeanEntryCanonicalAlignmentTheoremAvailable := true,
    factoredSHEBridgeTheoremAvailable := true,
    mismatchCounterexampleBlocksRawCancellation := true,
    labelIndependentJ2CollapseRejectedInZModModel := true,
    representativeJ2SignQuotientDescentRejectedInZModModel := true,
    absLabelThetaDegreeHalfRangeModelAvailable := true,
    balancedLevelRejectedAtFinalRouteTheoremAvailable := true,
    disputeSettledByCurrentStage := false }

theorem corollary312Report_orderedRealLineRouteTheoremAvailable :
    corollary312DisputeFirstPassReport.orderedRealLineRouteTheoremAvailable =
      true :=
  rfl

theorem corollary312Report_nonarchimedeanEntryCanonicalAlignmentTheoremAvailable :
    corollary312DisputeFirstPassReport.nonarchimedeanEntryCanonicalAlignmentTheoremAvailable =
      true :=
  rfl

theorem corollary312Report_factoredSHEBridgeTheoremAvailable :
    corollary312DisputeFirstPassReport.factoredSHEBridgeTheoremAvailable =
      true :=
  rfl

theorem corollary312Report_mismatchCounterexampleBlocksRawCancellation :
    corollary312DisputeFirstPassReport.mismatchCounterexampleBlocksRawCancellation =
      true :=
  rfl

theorem corollary312Report_labelIndependentJ2CollapseRejectedInZModModel :
    corollary312DisputeFirstPassReport.labelIndependentJ2CollapseRejectedInZModModel =
      true :=
  rfl

theorem corollary312Report_representativeJ2SignQuotientDescentRejected :
    corollary312DisputeFirstPassReport.representativeJ2SignQuotientDescentRejectedInZModModel =
      true :=
  rfl

theorem corollary312Report_absLabelThetaDegreeHalfRangeModelAvailable :
    corollary312DisputeFirstPassReport.absLabelThetaDegreeHalfRangeModelAvailable =
      true :=
  rfl

theorem corollary312Report_balancedLevelRejectedAtFinalRouteTheoremAvailable :
    corollary312DisputeFirstPassReport.balancedLevelRejectedAtFinalRouteTheoremAvailable =
      true :=
  rfl

theorem corollary312Report_notSettledByCurrentStage :
    corollary312DisputeFirstPassReport.disputeSettledByCurrentStage = false :=
  rfl

/--
Corollary 3.12 first-pass route theorem.

This is the positive side of the current experiment: with the ordered real-line
alignment required by the `(Ind3)` corridor, the formal route reaches the final
q/Theta inequality.
-/
theorem corollary312_firstPass_finalQTheta_from_orderedRealLineAlignment
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (transport_audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package part.bundle l)
    (source_profile_eq :
      profile = transport_audit.preservationAudit.sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        transport_audit.preservationAudit.sourceLogVolume)
    (target_log_volume_eq_theta :
      transport_audit.preservationAudit.targetLogVolume =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    (alignment : Ind3OrderedRealLineAlignment part audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  orderedRealLineAlignment_finalQTheta part profile audited transport_audit
    source_profile_eq source_log_volume_eq target_log_volume_eq_theta alignment

/--
Corollary 3.12 first-pass route from a nonarchimedean `(Ind3)` entry through
the canonical ordered-real-line presentation.

This theorem removes the independent ordered-alignment assumption in the
nonarchimedean entry case: the entry alignment supplies source/target equalities,
and those equalities induce a matched unit-scale ordered-real-line alignment.
-/
theorem corollary312_firstPass_finalQTheta_from_nonarchimedeanEntryCanonicalAlignment
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean)
    (transport_audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package part.bundle l)
    (source_profile_eq :
      profile = transport_audit.preservationAudit.sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        transport_audit.preservationAudit.sourceLogVolume)
    (target_log_volume_eq_theta :
      transport_audit.preservationAudit.targetLogVolume =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {entry : IUTStage1NonarchimedeanInclusionData}
    (entryAlignment :
      NonarchimedeanInd3EntryAlignment audited entry
        (part.insulated_route.theta_source.thetaSourceAverage audited)) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  orderedRealLineAlignment_finalQTheta part profile audited transport_audit
    source_profile_eq source_log_volume_eq target_log_volume_eq_theta
    entryAlignment.toCanonicalOrderedRealLineAlignment

/--
Corollary 3.12 first-pass route from factored square/full-label SHE data and a
nonarchimedean `(Ind3)` entry.

This reduces the transport assumption: the route receives separate
coordinate-square and full-label preservation data, then derives the structured
SHE square-weight transport audit internally.
-/
theorem corollary312_firstPass_finalQTheta_from_factoredSHEAndNonarchimedeanEntry
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (profile : IUTStage1ZModSquareWeightProfile l)
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean)
    (factored :
      IUTStage1StructuredSHEFactoredSquareFullLabelObligations
        package part.bundle l)
    (source_profile_eq : profile = factored.sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        factored.sourceLogVolume)
    (target_log_volume_eq_theta :
      factored.targetLogVolume =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {entry : IUTStage1NonarchimedeanInclusionData}
    (entryAlignment :
      NonarchimedeanInd3EntryAlignment audited entry
        (part.insulated_route.theta_source.thetaSourceAverage audited)) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  corollary312_firstPass_finalQTheta_from_nonarchimedeanEntryCanonicalAlignment
    part profile audited factored.toStructuredSHESquareWeightTransportAudit
    (by simpa using source_profile_eq)
    (by simpa using source_log_volume_eq)
    (by simpa using target_log_volume_eq_theta)
    entryAlignment

/--
Scholze-Stix-style collapse test for the representative `j^2` factors.

The current finite-label model rejects a single label-independent real-line
scale that simultaneously accounts for all representative square factors.
-/
theorem corollary312_firstPass_rejects_labelIndependentJ2Collapse
    (l : PrimeGeFive) (scale : Real) :
    ¬ ∀ j : ZMod l.value,
      scale =
        IUTStage1ZModSquareWeightProfile.representativeSquareScale
          (l := l) j :=
  no_labelIndependent_transport_scale_absorbs_j2 l scale

/--
Balanced sign-compatible evidence is not accepted as the final Corollary 3.12
comparison level.
-/
theorem corollary312_firstPass_rejects_balancedAsFinalRouteLevel
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    {part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l}
    {profile : IUTStage1ZModSquareWeightProfile l}
    {audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (route :
      FLZModCuspLabelThetaCuspClassContainerAudit.WeightedThetaComparisonRoute
        part profile audited) :
    FLZModCuspLabelThetaCuspClassContainerAudit.weightedThetaComparisonRouteLevel
        route ≠
      IUTStage1SquareComparisonLevel.balancedSignCompatible :=
  finalWeightedThetaRoute_rejectsBalanced route

end Experiments
end Stage1
end Iut
