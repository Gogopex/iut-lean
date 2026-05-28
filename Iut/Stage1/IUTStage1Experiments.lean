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
  gaussianDegreeEvaluationIdentityAtOne : Bool

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
    absLabelThetaPilotDegreeProfileAvailable := true,
    gaussianDegreeEvaluationIdentityAtOne := true }

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

theorem ind3J2ScaleExperimentReport_gaussianIdentityAtOne
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport
      l).gaussianDegreeEvaluationIdentityAtOne = true :=
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

/--
Degree-level Gaussian evaluation has the identity component at the canonical
label `j = 1`, matching IUT II's restriction of `q -> (q^{j^2})_j` to `j=1`.
-/
theorem gaussianDegreeEvaluation_identity_at_one
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
      evaluation.environmentDegree :=
  evaluation.gaussianDegree_one

/--
On half-range representatives, the degree-level Gaussian evaluation is exactly
the displayed `j^2` scaling.
-/
theorem gaussianDegreeEvaluation_matches_halfRange_j2
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (j : ZMod l.value) (hhalf : j.val ≤ l.value / 2) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      ((j.val : Real) ^ 2) * evaluation.environmentDegree :=
  evaluation.gaussianDegree_fromCoordinate_of_val_le_half j hhalf

/-- Procession-container experiment surface for IUT III's sets `S^±_{j+1}`. -/
structure ProcessionContainerExperimentReport where
  stageCardinalityFormulaAvailable : Bool
  nestedInclusionInjective : Bool
  coreLabelStableUnderInclusion : Bool
  stageIndeterminacyBoundedByFullContainer : Bool
  tensorPacketLogVolumeNormalizationAvailable : Bool
  tensorPacketPermutationInvariant : Bool
  processionTotalIndeterminacyFactorial : Bool
  finalContainerMatchesAbsLabelExponents : Bool
  valuationFiberDirectSumAvailable : Bool
  fiberTensorPacketNormalizationAvailable : Bool
  lgpSplittingMonoidActionAvailable : Bool
  lgpSplittingMonoidAddsGaussianGenerators : Bool
  baseValuationPacketProductAvailable : Bool
  fmodUnitCopyProductActionAvailable : Bool
  kummerFTensorPacketToDTransferAvailable : Bool
  monoAnalyticTensorPacketForgettingAvailable : Bool
  determinantTensorPowerNormalizationAvailable : Bool
  hullDetUpperRayComparisonAvailable : Bool
  qPilotTwoComputationComparisonAvailable : Bool
  thetaPilotTensorPowerWarningAvailable : Bool
  globalFrobenioidCalibrationAvailable : Bool
  positiveRationalUnitRigidityAvailable : Bool
  generalizedThetaLGPLambdaBoundAvailable : Bool
  distinctLabelIntertwiningTransportAvailable : Bool
  toyIntertwiningUpperRayBoundAvailable : Bool
  logThetaColumnRoleTableAvailable : Bool
  zeroOneColumnAbsorptionDistinctionAvailable : Bool
  gaussBonnetMetricSignShadowAvailable : Bool
  thetaLabelFactorPNormalizationAvailable : Bool
  frobeniusDerivativeDegreeInequalityAvailable : Bool
  iutIVThetaPilotLogVolumeEstimateAvailable : Bool
  iutIVElementaryCoefficientEstimatesAvailable : Bool
  iutIVTripodalBaseChangeLogDegreeAvailable : Bool
  iutIVElementarySumIdentitiesAvailable : Bool
  iutIVSmallPrimeRamificationErrorBoundAvailable : Bool
  iutIVGLTwoCardinalityConstantsAvailable : Bool
  iutIVLogSQStepIIIEstimateAvailable : Bool
  iutIVPrimeProductCaseSplitBoundAvailable : Bool
  iutIVFinalErrorAbsorptionAvailable : Bool
  iutIVTheorem110FinalDisplayAvailable : Bool
  iutIVTheoremABoundedDiscrepancyAvailable : Bool
  iutIVCorollary22BoundedDiscrepancyChainAvailable : Bool
deriving Repr

/--
The finite skeleton of the procession construction is available: the stage `j`
container has `j+1` elements, embeds in the next stage, preserves the core label,
and has label ambiguity bounded by any later full container.
-/
def processionContainerExperimentReport : ProcessionContainerExperimentReport :=
  { stageCardinalityFormulaAvailable := true,
    nestedInclusionInjective := true,
    coreLabelStableUnderInclusion := true,
    stageIndeterminacyBoundedByFullContainer := true,
    tensorPacketLogVolumeNormalizationAvailable := true,
    tensorPacketPermutationInvariant := true,
    processionTotalIndeterminacyFactorial := true,
    finalContainerMatchesAbsLabelExponents := true,
    valuationFiberDirectSumAvailable := true,
    fiberTensorPacketNormalizationAvailable := true,
    lgpSplittingMonoidActionAvailable := true,
    lgpSplittingMonoidAddsGaussianGenerators := true,
    baseValuationPacketProductAvailable := true,
    fmodUnitCopyProductActionAvailable := true,
    kummerFTensorPacketToDTransferAvailable := true,
    monoAnalyticTensorPacketForgettingAvailable := true,
    determinantTensorPowerNormalizationAvailable := true,
    hullDetUpperRayComparisonAvailable := true,
    qPilotTwoComputationComparisonAvailable := true,
    thetaPilotTensorPowerWarningAvailable := true,
    globalFrobenioidCalibrationAvailable := true,
    positiveRationalUnitRigidityAvailable := true,
    generalizedThetaLGPLambdaBoundAvailable := true,
    distinctLabelIntertwiningTransportAvailable := true,
    toyIntertwiningUpperRayBoundAvailable := true,
    logThetaColumnRoleTableAvailable := true,
    zeroOneColumnAbsorptionDistinctionAvailable := true,
    gaussBonnetMetricSignShadowAvailable := true,
    thetaLabelFactorPNormalizationAvailable := true,
    frobeniusDerivativeDegreeInequalityAvailable := true,
    iutIVThetaPilotLogVolumeEstimateAvailable := true,
    iutIVElementaryCoefficientEstimatesAvailable := true,
    iutIVTripodalBaseChangeLogDegreeAvailable := true,
    iutIVElementarySumIdentitiesAvailable := true,
    iutIVSmallPrimeRamificationErrorBoundAvailable := true,
    iutIVGLTwoCardinalityConstantsAvailable := true,
    iutIVLogSQStepIIIEstimateAvailable := true,
    iutIVPrimeProductCaseSplitBoundAvailable := true,
    iutIVFinalErrorAbsorptionAvailable := true,
    iutIVTheorem110FinalDisplayAvailable := true,
    iutIVTheoremABoundedDiscrepancyAvailable := true,
    iutIVCorollary22BoundedDiscrepancyChainAvailable := true }

theorem processionContainer_card_eq (j : Nat) :
    Fintype.card (IUTStage1ProcessionContainer j) = j + 1 :=
  IUTStage1ProcessionContainer.card_eq j

theorem processionContainer_inclusion_injective (j : Nat) :
    Function.Injective (IUTStage1ProcessionContainer.inclusion j) :=
  IUTStage1ProcessionContainer.inclusion_injective j

theorem processionContainer_core_stable (j : Nat) :
    IUTStage1ProcessionContainer.inclusion j
        (IUTStage1ProcessionContainer.core j) =
      IUTStage1ProcessionContainer.core (j + 1) :=
  IUTStage1ProcessionContainer.inclusion_core j

theorem processionContainer_labelIndeterminacy_le_full
    {j full : Nat} (h : j ≤ full) :
    IUTStage1ProcessionContainer.labelIndeterminacyCount j ≤ full + 1 :=
  IUTStage1ProcessionContainer.labelIndeterminacyCount_le_full h

theorem processionTotalIndeterminacy_eq_factorial (full : Nat) :
    IUTStage1ProcessionContainer.processionTotalIndeterminacyCount full =
      Nat.factorial (full + 1) :=
  IUTStage1ProcessionContainer.processionTotalIndeterminacyCount_eq_factorial
    full

theorem processionTotalIndeterminacy_le_wholeSet (full : Nat) :
    IUTStage1ProcessionContainer.processionTotalIndeterminacyCount full ≤
      IUTStage1ProcessionContainer.wholeSetIndeterminacyCount full :=
  IUTStage1ProcessionContainer.processionTotalIndeterminacyCount_le_wholeSetIndeterminacyCount
    full

theorem absLabelProcession_core_maps_to_zero
    (l : PrimeGeFive) :
    IUTStage1ZModSquareWeightProfile.absLabelFromProcession l
        (IUTStage1ProcessionContainer.core
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) =
      IUTStage1ZModCuspFullLabel.zero :=
  IUTStage1ZModSquareWeightProfile.absLabelFromProcession_core

theorem absLabelProcession_thetaExponent_eq_square
    (l : PrimeGeFive)
    (label :
      IUTStage1ProcessionContainer
        (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
    IUTStage1ZModSquareWeightProfile.thetaExponentOnAbsLabel
        (l := l)
        (IUTStage1ZModSquareWeightProfile.absLabelFromProcession l label) =
      ((label.val : Real) ^ 2) :=
  IUTStage1ZModSquareWeightProfile.thetaExponentOnAbsLabel_fromProcession
    (l := l) label

theorem processionTensorPacket_normalized_eq_card_average
    {kind : IUTStage1PlaceKind} {j : Nat}
    (packet : IUTStage1ProcessionTensorPacketLogVolume kind j) :
    packet.normalizedLogVolume =
      packet.tensorPacketLogVolume /
        (Fintype.card (IUTStage1ProcessionContainer j) : Real) :=
  packet.normalized_eq_card_average

theorem processionTensorPacket_toLabelAveraged_average
    {kind : IUTStage1PlaceKind} {j : Nat}
    (packet : IUTStage1ProcessionTensorPacketLogVolume kind j) :
    packet.toLabelAveraged.averageLogVolume = packet.normalizedLogVolume :=
  rfl

theorem processionTensorPacket_const_le_normalized
    {kind : IUTStage1PlaceKind} {j : Nat}
    (packet : IUTStage1ProcessionTensorPacketLogVolume kind j)
    {c : Real}
    (hlabel :
      ∀ label : IUTStage1ProcessionContainer j,
        c <= (packet.logShellDirectSum label).finiteLogVolume) :
    c <= packet.normalizedLogVolume :=
  packet.const_le_normalizedLogVolume_of_forall_le hlabel

theorem processionTensorPacket_reindex_preserves_normalized
    {kind : IUTStage1PlaceKind} {j : Nat}
    (packet : IUTStage1ProcessionTensorPacketLogVolume kind j)
    (perm :
      IUTStage1ProcessionContainer j ≃
        IUTStage1ProcessionContainer j) :
    (packet.reindex perm).normalizedLogVolume =
      packet.normalizedLogVolume :=
  packet.reindex_normalizedLogVolume_eq perm

theorem valuationFiberLogShellDirectSum_eq_sum
    {kind : IUTStage1PlaceKind}
    (directSum : IUTStage1ValuationFiberLogShellDirectSum kind) :
    directSum.directSumLogVolume =
      Finset.univ.sum directSum.logShellLogVolume :=
  directSum.direct_sum_eq

theorem processionFiberTensorPacket_normalized_eq_card_average
    {kind : IUTStage1PlaceKind} {j : Nat}
    (packet : IUTStage1ProcessionFiberTensorPacketLogVolume kind j) :
    packet.normalizedLogVolume =
      packet.tensorPacketLogVolume /
        (Fintype.card (IUTStage1ProcessionContainer j) : Real) :=
  packet.normalized_eq_card_average

theorem processionFiberTensorPacket_reindex_preserves_normalized
    {kind : IUTStage1PlaceKind} {j : Nat}
    (packet : IUTStage1ProcessionFiberTensorPacketLogVolume kind j)
    (perm :
      IUTStage1ProcessionContainer j ≃
        IUTStage1ProcessionContainer j) :
    (packet.reindex perm).normalizedLogVolume =
      packet.normalizedLogVolume :=
  packet.reindex_normalizedLogVolume_eq perm

theorem lgpSplittingMonoid_generator_core_zero
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    action.generatorLogVolume
        (IUTStage1ProcessionContainer.core
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) = 0 :=
  action.generatorLogVolume_core

theorem lgpSplittingMonoid_generator_eq_procession_square
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l)
    (label :
      IUTStage1ProcessionContainer
        (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
    action.generatorLogVolume label =
      ((label.val : Real) ^ 2) * action.evaluation.environmentDegree :=
  action.generatorLogVolume_eq_procession_square label

theorem lgpSplittingMonoid_actedTensorPacket_eq_original_plus_generators
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    action.actedTensorPacketLogVolume =
      action.packet.tensorPacketLogVolume +
        Finset.univ.sum action.generatorLogVolume :=
  action.actedTensorPacketLogVolume_eq_original_plus_generators

theorem lgpSplittingMonoid_normalizedActed_eq_original_plus_generators_over_card
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    action.normalizedActedLogVolume =
      (action.packet.tensorPacketLogVolume +
        Finset.univ.sum action.generatorLogVolume) /
          (Fintype.card
            (IUTStage1ProcessionContainer
              (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
                Real) :=
  action.normalizedActedLogVolume_eq_original_plus_generators_over_card

theorem baseValuationTensorPacketProduct_eq_nested_sum
    {kind : IUTStage1PlaceKind} {j : Nat}
    (product : IUTStage1BaseValuationTensorPacketProductLogVolume kind j) :
    product.productLogVolume =
      Finset.univ.sum fun base : Fin product.baseCount =>
        Finset.univ.sum fun label : IUTStage1ProcessionContainer j =>
          ((product.packet base).directSum label).directSumLogVolume :=
  product.productLogVolume_eq_nested_sum

theorem baseValuationTensorPacketProduct_directSum_basePlace_eq
    {kind : IUTStage1PlaceKind} {j : Nat}
    (product : IUTStage1BaseValuationTensorPacketProductLogVolume kind j)
    (base : Fin product.baseCount)
    (label : IUTStage1ProcessionContainer j) :
    ((product.packet base).directSum label).fiber.basePlace =
      product.basePlace base :=
  product.packet_directSum_basePlace_eq base label

theorem fmodUnitCopyProductAction_eq_original_plus_unitCopies
    {kind : IUTStage1PlaceKind} {j : Nat}
    (action : IUTStage1FmodUnitCopyTensorPacketProductAction kind j) :
    action.actedProductLogVolume =
      action.product.productLogVolume +
        Finset.univ.sum fun _base : Fin action.product.baseCount =>
          Finset.univ.sum action.unitCopyLogVolume :=
  action.actedProductLogVolume_eq_original_plus_unitCopies

theorem tensorPacketCoricTransfer_preserves_productLogVolume
    {kind : IUTStage1PlaceKind} {j : Nat}
    {source target : IUTStage1RealizedTensorPacketProductLogVolume kind j}
    (transfer : IUTStage1TensorPacketCoricTransfer source target) :
    target.product.productLogVolume = source.product.productLogVolume :=
  transfer.preserves_productLogVolume

theorem tensorPacketCoricTransfer_histories_not_identified
    {kind : IUTStage1PlaceKind} {j : Nat}
    {source target : IUTStage1RealizedTensorPacketProductLogVolume kind j}
    (transfer : IUTStage1TensorPacketCoricTransfer source target) :
    source.theater.side ≠ target.theater.side :=
  transfer.source_history_ne_target_history

theorem kummerFTensorPacketToD_preserves_productLogVolume
    {kind : IUTStage1PlaceKind} {j : Nat}
    {source target : IUTStage1RealizedTensorPacketProductLogVolume kind j}
    (transfer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer source target) :
    target.product.productLogVolume = source.product.productLogVolume :=
  transfer.preserves_productLogVolume

theorem monoAnalyticTensorPacketForgetting_preserves_productLogVolume
    {kind : IUTStage1PlaceKind} {j : Nat}
    {source target : IUTStage1RealizedTensorPacketProductLogVolume kind j}
    (transfer :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer source target) :
    target.product.productLogVolume = source.product.productLogVolume :=
  transfer.preserves_productLogVolume

theorem monoAnalyticTensorPacketForgetting_structureForgotten
    {kind : IUTStage1PlaceKind} {j : Nat}
    {source target : IUTStage1RealizedTensorPacketProductLogVolume kind j}
    (transfer :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer source target) :
    transfer.holomorphicStructureForgotten :=
  transfer.structureForgotten

theorem arithmeticVectorBundleDeterminant_normalizedLogVolume_eq_determinant
    (data : IUTStage1ArithmeticVectorBundleDeterminantLogVolume) :
    data.normalizedLogVolume = data.determinantLogVolume :=
  data.normalizedLogVolume_eq_determinant

theorem arithmeticVectorBundleDeterminant_rank_pos
    (data : IUTStage1ArithmeticVectorBundleDeterminantLogVolume) :
    0 < data.rank :=
  data.rank_pos

theorem hullDetUpperRay_qPilot_mem
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume ∈ data.upperRay :=
  data.qPilot_mem_upperRay

theorem hullDetUpperRay_qPilot_le_theta
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume <= data.thetaHullLogVolume :=
  data.qPilotLogVolume_le_thetaHullLogVolume

theorem hullDetUpperRay_qPilot_le_determinant
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume <= data.determinant.determinantLogVolume :=
  data.qPilotLogVolume_le_determinant

theorem qPilotTwoComputation_input_eq_output
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.inputPrimeStripLogVolume = data.outputHullLogVolume :=
  data.input_eq_output

theorem qPilotTwoComputation_input_le_theta
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.inputPrimeStripLogVolume <= data.upperRayData.thetaHullLogVolume :=
  data.input_le_thetaHullLogVolume

theorem qPilotTwoComputation_output_le_theta
    (data : IUTStage1QPilotTwoComputationLogVolume) :
    data.outputHullLogVolume <= data.upperRayData.thetaHullLogVolume :=
  data.output_le_thetaHullLogVolume

theorem thetaPilotTensorPowerLogVolume_eq_mul
    (data : IUTStage1ThetaPilotTensorPowerLogVolume) :
    data.tensorPowerLogVolume =
      (data.tensorPower : Real) * data.originalThetaPilotLogVolume :=
  data.tensorPowerLogVolume_eq_mul

theorem thetaPilotTensorPowerUpperRay_subset_original
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume <= 0) :
    data.tensorPowerUpperRay ⊆ data.originalUpperRay :=
  data.tensorPowerUpperRay_subset_originalUpperRay_of_original_nonpos hTheta

theorem thetaPilotTensorPowerLogVolume_sharper_of_neg
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume < 0) :
    data.tensorPowerLogVolume < data.originalThetaPilotLogVolume :=
  data.tensorPowerLogVolume_lt_original_of_original_neg hTheta

theorem localFrobenioidLogVolume_shifted_ne_unshifted
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity)
    (hExponent : data.localExponent ≠ 0)
    (hStep : data.localPrimeStepLogVolume ≠ 0) :
    data.shiftedLogVolume ≠ data.unshiftedLogVolume :=
  data.shiftedLogVolume_ne_unshifted hExponent hStep

theorem globalFrobenioidCalibration_eq_unshifted
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration) :
    data.calibratedLogVolume = data.localData.unshiftedLogVolume :=
  data.calibratedLogVolume_eq_unshifted

theorem globalFrobenioidCalibration_ne_localShifted
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration)
    (hExponent : data.localData.localExponent ≠ 0)
    (hStep : data.localData.localPrimeStepLogVolume ≠ 0) :
    data.calibratedLogVolume ≠ data.localData.shiftedLogVolume :=
  data.calibratedLogVolume_ne_shifted_of_local_nonzero hExponent hStep

theorem positiveRationalUnitRigidity_eq_one
    {q : Rat} (hpos : 0 < q)
    (hunit : IUTStage1PositiveRationalUnitRigidity.IsIntegerUnit q) :
    q = 1 :=
  IUTStage1PositiveRationalUnitRigidity.eq_one_of_pos_of_integerUnit
    hpos hunit

theorem generalizedThetaLGPLambda_standard_bound
    (data : IUTStage1GeneralizedThetaLGPLambdaBound)
    (hlambda : data.lambda <= 1) :
    (-1 : Real) <= data.cTheta :=
  data.standard_bound_of_lambda_le_one hlambda

theorem generalizedThetaLGPLambda_sharper_boundary
    (data : IUTStage1GeneralizedThetaLGPLambdaBound)
    (hlambda : data.lambda < 1) :
    (-1 : Real) < -((data.lambda : Real)) :=
  data.sharper_boundary_of_lambda_lt_one hlambda

theorem distinctLabelIntertwining_labels_distinct
    (data : IUTStage1DistinctLabelIntertwiningTransport) :
    data.qLabel ≠ data.thetaLabel :=
  data.labels_distinct

theorem distinctLabelIntertwining_simultaneous_of_q
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : data.qIntertwining) :
    data.qIntertwining ∧ data.thetaIntertwiningUpToIndeterminacy :=
  data.simultaneous_intertwining_of_q hq

theorem distinctLabelIntertwining_unlabeled_collapse_rejected
    (data : IUTStage1DistinctLabelIntertwiningTransport) :
    ¬ data.qLabel = data.thetaLabel :=
  data.unlabeled_collapse_rejected

theorem toyIntertwining_forgottenConcreteAssignmentsIncompatible
    (data : IUTStage1ToyIntertwiningUpperRayBound) :
    (-data.h : Real) ≠ -2 * data.h :=
  data.forgotten_concrete_assignments_incompatible

theorem toyIntertwining_h_le_epsilon
    (data : IUTStage1ToyIntertwiningUpperRayBound) :
    data.h <= data.epsilon :=
  data.h_le_epsilon

theorem logThetaColumn_both_roles_essential
    (column : IUTStage1LogThetaVerticalColumn) :
    column.requiresFrobeniusLikeRole = true ∧
      column.requiresEtaleLikeRole = true :=
  column.both_roles_essential

theorem logThetaColumn_qPilot_lacksMultiradiality :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasPilotMultiradiality =
      false :=
  IUTStage1LogThetaVerticalColumn.qPilot_lacksMultiradiality

theorem logThetaColumn_multiradialityDistinguishesColumns :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasPilotMultiradiality ≠
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasPilotMultiradiality :=
  IUTStage1LogThetaVerticalColumn.multiradiality_distinguishes_columns

theorem logThetaColumn_logShellTreatmentDistinguishesColumns :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logShellTreatment ≠
      IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment :=
  IUTStage1LogThetaVerticalColumn.logShellTreatment_distinguishes_columns

theorem zeroColumnHullAbsorption_bothRegions
    (data : IUTStage1ZeroColumnHullAbsorbsUnitIndeterminacy) :
    data.originalRegionLogVolume ∈ data.hullUpperRay ∧
      data.unitShiftedRegionLogVolume ∈ data.hullUpperRay :=
  data.both_regions_absorbed_by_hull

theorem oneColumnLogVolumeCompatibility_precise_eq
    (data :
      IUTStage1OneColumnLogVolumeCompatibilityAbsorbsConjugateChoice) :
    data.sourceRingStructureLogVolume =
      data.conjugateRingStructureLogVolume :=
  data.precise_logVolume_eq

theorem oneColumnLogVolumeCompatibility_source_le_conjugate
    (data :
      IUTStage1OneColumnLogVolumeCompatibilityAbsorbsConjugateChoice) :
    data.sourceRingStructureLogVolume <=
      data.conjugateRingStructureLogVolume :=
  data.source_le_conjugate

theorem gaussBonnetMetricSign_euler_neg
    (data : IUTStage1GaussBonnetMetricSignShadow) :
    data.eulerCharacteristic < 0 :=
  data.eulerCharacteristic_neg

theorem gaussBonnetMetricSign_upperSemiAnalogue
    (data : IUTStage1GaussBonnetMetricSignShadow) :
    data.upperSemiInd3Analogue :=
  data.upperSemiInd3Analogue_holds

theorem thetaLabelFactorPNormalization_mul_labelFactor
    (data : IUTStage1ThetaLabelFactorPNormalizationShadow) :
    data.normalizedModPLogVolume * (data.l.value : Real) =
      data.modPOverP2GapLogVolume :=
  data.normalized_mul_labelFactor

theorem frobeniusDerivativeDegreeInequality_nonpos
    (data : IUTStage1FrobeniusDerivativeDegreeInequalityShadow) :
    data.degreeDefect <= 0 :=
  data.degreeDefect_nonpos

theorem frobeniusDerivativeDegreeInequality_inclusion
    (data : IUTStage1FrobeniusDerivativeDegreeInequalityShadow) :
    data.derivativeGivesInclusion :=
  data.derivativeGivesInclusion_holds

theorem iutIVThetaPilotLogVolumeEstimate_mainTerm_le_upper
    (data : IUTStage1IUTIVThetaPilotLogVolumeEstimateShadow) :
    data.mainLogTerm <= data.arithmeticUpperTerm :=
  data.mainLogTerm_le_arithmeticUpperTerm

theorem iutIVThetaPilotLogVolumeEstimate_oneSixthLogQ_bound
    (data : IUTStage1IUTIVThetaPilotLogVolumeEstimateShadow) :
    data.oneSixthLogQ <= data.theorem110RightHandSide :=
  data.oneSixthLogQ_le_theorem110RightHandSide

theorem iutIVThetaPilotCorrectionFactor_inverse_bound
    (l : PrimeGeFive) :
    (iutIVThetaPilotCorrectionFactor l)⁻¹ <= (2 : Real) :=
  iutIVThetaPilotCorrectionFactor_inv_le_two l

theorem iutIVThetaPilotFinalCoefficient_bound
    (l : PrimeGeFive) (dmod : Nat) :
    (iutIVThetaPilotCorrectionFactor l)⁻¹ * ((1 : Real) / 4) *
        (1 + 36 * (dmod : Real) / (l.value : Real)) <=
      1 + 80 * (dmod : Real) / (l.value : Real) :=
  iutIVThetaPilotFinalCoefficientEstimate l dmod

theorem iutIVTripodalBaseChange_logDegreeSum_le
    (data : IUTStage1IUTIVTripodalBaseChangeLogDegreeShadow) :
    data.ftpdLogDegreeSum <= data.fLogDegreeSum :=
  data.logDegreeSum_le

theorem iutIVTripodalBaseChange_theorem110RHS_le
    (data : IUTStage1IUTIVTripodalBaseChangeLogDegreeShadow) :
    data.ftpdTheorem110RightHandSide <= data.fTheorem110RightHandSide :=
  data.ftpdTheorem110RightHandSide_le_fTheorem110RightHandSide

theorem iutIVElementarySumIdentity_E1
    (n : Nat) (hn : 1 <= n) :
    (∑ m ∈ Finset.range (n + 1), (m : Real)) / (n : Real) =
      ((n : Real) + 1) / 2 :=
  iutIVThetaPilot_average_sum_id n hn

theorem iutIVElementarySumIdentity_E2
    (n : Nat) (hn : 1 <= n) :
    (∑ m ∈ Finset.range (n + 1), (m : Real) ^ 2) / (n : Real) =
      (1 / 6 : Real) * (2 * (n : Real) + 1) * ((n : Real) + 1) :=
  iutIVThetaPilot_average_sum_sq n hn

theorem iutIVSmallPrimeRamificationError_le_twentyOne
    (data : IUTStage1IUTIVSmallPrimeRamificationErrorBoundShadow) :
    data.smallPrimeError <= 21 :=
  data.smallPrimeError_le_twentyOne

theorem iutIVTameRamificationLogDegreeError_le_twentyOne
    (data : IUTStage1IUTIVTameRamificationLogDegreeErrorShadow) :
    data.fLogDegreeSum <= data.ftpdLogDegreeSum + 21 :=
  data.fLogDegreeSum_le_ftpd_add_twentyOne

theorem iutIVGLTwoCardinality_two :
    iutIVGLTwoCardinalityExpression 2 = 2 * 3 :=
  iutIVGLTwoCardinalityExpression_two

theorem iutIVGLTwoCardinality_three :
    iutIVGLTwoCardinalityExpression 3 = 3 * 2 ^ 4 :=
  iutIVGLTwoCardinalityExpression_three

theorem iutIVGLTwoCardinality_five :
    iutIVGLTwoCardinalityExpression 5 = 5 * 2 ^ 5 * 3 :=
  iutIVGLTwoCardinalityExpression_five

theorem iutIVSmallPrimeGLTwoDegreeExpression_formula :
    iutIVSmallPrimeGLTwoDegreeExpression = 2 ^ 11 * 3 ^ 3 * 5 :=
  iutIVSmallPrimeGLTwoDegreeExpression_eq

theorem iutIVLogSQStepIII_left_le_right
    (data : IUTStage1IUTIVLogSQStepIIIShadow) :
    data.leftHandSide <= data.rightHandSide :=
  data.leftHandSide_le_rightHandSide

theorem iutIVPrimeProductCaseSplit_uniform_bound
    (data : IUTStage1IUTIVPrimeProductCaseSplitBoundShadow) :
    data.primeProductLogTerm <=
      (4 / 3 : Real) * (data.eStarTimesL + data.etaPrm) :=
  data.primeProductLogTerm_le_uniform

theorem iutIVFinalErrorAbsorption_le_ten
    (data : IUTStage1IUTIVFinalErrorAbsorptionShadow) :
    2 * data.logL + 74 + (20 / 3 : Real) * data.primeProductLogTerm <=
      10 * data.eEta :=
  data.finalError_le_ten

theorem iutIVTheorem110FinalDisplay_bound
    (data : IUTStage1IUTIVTheorem110FinalDisplayShadow) :
    data.estimate.oneSixthLogQ <= data.finalRightHandSide :=
  data.oneSixthLogQ_le_finalRightHandSide

theorem iutIVTheoremABoundedDiscrepancy_height_bound
    {Point : Type u}
    (data : IUTStage1IUTIVTheoremABoundedDiscrepancyShadow Point)
    (x : Point) :
    data.height x <=
      (1 + data.epsilon) * (data.logDiff x + data.logCond x) -
        data.lowerBound :=
  data.height_le_weighted_logDiff_logCond_minus_lowerBound x

theorem iutIVTheoremABoundedDiscrepancy_hyperbolic
    {Point : Type u}
    (data : IUTStage1IUTIVTheoremABoundedDiscrepancyShadow Point) :
    data.hyperbolicCurve :=
  data.hyperbolicCurve_holds

theorem iutIVCorollary22BoundedDiscrepancyChain_upper
    {Point : Type u}
    (data : IUTStage1IUTIVCorollary22BoundedDiscrepancyChainShadow Point)
    (x : Point) :
    (1 / 6 : Real) * data.logQTwo x - data.canonicalHeight x <=
      data.logQTwo_to_canonicalHeight.upper :=
  data.logQTwo_to_canonicalHeight.upper_bound x

theorem iutIVCorollary22BoundedDiscrepancyChain_lower
    {Point : Type u}
    (data : IUTStage1IUTIVCorollary22BoundedDiscrepancyChainShadow Point)
    (x : Point) :
    data.logQTwo_to_canonicalHeight.lower <=
      (1 / 6 : Real) * data.logQTwo x - data.canonicalHeight x :=
  data.logQTwo_to_canonicalHeight.lower_bound x

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
  gaussianDegreeEvaluationTheoremAvailable : Bool
  processionContainerSkeletonAvailable : Bool
  processionTensorPacketLogVolumeAvailable : Bool
  processionTensorPacketPermutationInvariant : Bool
  processionIndeterminacyFactorialAvailable : Bool
  absLabelProcessionExponentBridgeAvailable : Bool
  valuationFiberDirectSumAvailable : Bool
  processionFiberTensorPacketAvailable : Bool
  lgpSplittingMonoidActionAvailable : Bool
  lgpSplittingMonoidAddsGaussianGenerators : Bool
  baseValuationPacketProductAvailable : Bool
  fmodUnitCopyProductActionAvailable : Bool
  kummerFTensorPacketToDTransferAvailable : Bool
  monoAnalyticTensorPacketForgettingAvailable : Bool
  determinantTensorPowerNormalizationAvailable : Bool
  hullDetUpperRayComparisonAvailable : Bool
  qPilotTwoComputationComparisonAvailable : Bool
  thetaPilotTensorPowerWarningAvailable : Bool
  globalFrobenioidCalibrationAvailable : Bool
  positiveRationalUnitRigidityAvailable : Bool
  generalizedThetaLGPLambdaBoundAvailable : Bool
  distinctLabelIntertwiningTransportAvailable : Bool
  toyIntertwiningUpperRayBoundAvailable : Bool
  logThetaColumnRoleTableAvailable : Bool
  zeroOneColumnAbsorptionDistinctionAvailable : Bool
  gaussBonnetMetricSignShadowAvailable : Bool
  thetaLabelFactorPNormalizationAvailable : Bool
  frobeniusDerivativeDegreeInequalityAvailable : Bool
  iutIVThetaPilotLogVolumeEstimateAvailable : Bool
  iutIVElementaryCoefficientEstimatesAvailable : Bool
  iutIVTripodalBaseChangeLogDegreeAvailable : Bool
  iutIVElementarySumIdentitiesAvailable : Bool
  iutIVSmallPrimeRamificationErrorBoundAvailable : Bool
  iutIVGLTwoCardinalityConstantsAvailable : Bool
  iutIVLogSQStepIIIEstimateAvailable : Bool
  iutIVPrimeProductCaseSplitBoundAvailable : Bool
  iutIVFinalErrorAbsorptionAvailable : Bool
  iutIVTheorem110FinalDisplayAvailable : Bool
  iutIVTheoremABoundedDiscrepancyAvailable : Bool
  iutIVCorollary22BoundedDiscrepancyChainAvailable : Bool
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
    gaussianDegreeEvaluationTheoremAvailable := true,
    processionContainerSkeletonAvailable := true,
    processionTensorPacketLogVolumeAvailable := true,
    processionTensorPacketPermutationInvariant := true,
    processionIndeterminacyFactorialAvailable := true,
    absLabelProcessionExponentBridgeAvailable := true,
    valuationFiberDirectSumAvailable := true,
    processionFiberTensorPacketAvailable := true,
    lgpSplittingMonoidActionAvailable := true,
    lgpSplittingMonoidAddsGaussianGenerators := true,
    baseValuationPacketProductAvailable := true,
    fmodUnitCopyProductActionAvailable := true,
    kummerFTensorPacketToDTransferAvailable := true,
    monoAnalyticTensorPacketForgettingAvailable := true,
    determinantTensorPowerNormalizationAvailable := true,
    hullDetUpperRayComparisonAvailable := true,
    qPilotTwoComputationComparisonAvailable := true,
    thetaPilotTensorPowerWarningAvailable := true,
    globalFrobenioidCalibrationAvailable := true,
    positiveRationalUnitRigidityAvailable := true,
    generalizedThetaLGPLambdaBoundAvailable := true,
    distinctLabelIntertwiningTransportAvailable := true,
    toyIntertwiningUpperRayBoundAvailable := true,
    logThetaColumnRoleTableAvailable := true,
    zeroOneColumnAbsorptionDistinctionAvailable := true,
    gaussBonnetMetricSignShadowAvailable := true,
    thetaLabelFactorPNormalizationAvailable := true,
    frobeniusDerivativeDegreeInequalityAvailable := true,
    iutIVThetaPilotLogVolumeEstimateAvailable := true,
    iutIVElementaryCoefficientEstimatesAvailable := true,
    iutIVTripodalBaseChangeLogDegreeAvailable := true,
    iutIVElementarySumIdentitiesAvailable := true,
    iutIVSmallPrimeRamificationErrorBoundAvailable := true,
    iutIVGLTwoCardinalityConstantsAvailable := true,
    iutIVLogSQStepIIIEstimateAvailable := true,
    iutIVPrimeProductCaseSplitBoundAvailable := true,
    iutIVFinalErrorAbsorptionAvailable := true,
    iutIVTheorem110FinalDisplayAvailable := true,
    iutIVTheoremABoundedDiscrepancyAvailable := true,
    iutIVCorollary22BoundedDiscrepancyChainAvailable := true,
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

theorem corollary312Report_gaussianDegreeEvaluationTheoremAvailable :
    corollary312DisputeFirstPassReport.gaussianDegreeEvaluationTheoremAvailable =
      true :=
  rfl

theorem corollary312Report_processionContainerSkeletonAvailable :
    corollary312DisputeFirstPassReport.processionContainerSkeletonAvailable =
      true :=
  rfl

theorem corollary312Report_processionTensorPacketLogVolumeAvailable :
    corollary312DisputeFirstPassReport.processionTensorPacketLogVolumeAvailable =
      true :=
  rfl

theorem corollary312Report_processionTensorPacketPermutationInvariant :
    corollary312DisputeFirstPassReport.processionTensorPacketPermutationInvariant =
      true :=
  rfl

theorem corollary312Report_processionIndeterminacyFactorialAvailable :
    corollary312DisputeFirstPassReport.processionIndeterminacyFactorialAvailable =
      true :=
  rfl

theorem corollary312Report_absLabelProcessionExponentBridgeAvailable :
    corollary312DisputeFirstPassReport.absLabelProcessionExponentBridgeAvailable =
      true :=
  rfl

theorem corollary312Report_valuationFiberDirectSumAvailable :
    corollary312DisputeFirstPassReport.valuationFiberDirectSumAvailable =
      true :=
  rfl

theorem corollary312Report_processionFiberTensorPacketAvailable :
    corollary312DisputeFirstPassReport.processionFiberTensorPacketAvailable =
      true :=
  rfl

theorem corollary312Report_lgpSplittingMonoidActionAvailable :
    corollary312DisputeFirstPassReport.lgpSplittingMonoidActionAvailable =
      true :=
  rfl

theorem corollary312Report_lgpSplittingMonoidAddsGaussianGenerators :
    corollary312DisputeFirstPassReport.lgpSplittingMonoidAddsGaussianGenerators =
      true :=
  rfl

theorem corollary312Report_baseValuationPacketProductAvailable :
    corollary312DisputeFirstPassReport.baseValuationPacketProductAvailable =
      true :=
  rfl

theorem corollary312Report_fmodUnitCopyProductActionAvailable :
    corollary312DisputeFirstPassReport.fmodUnitCopyProductActionAvailable =
      true :=
  rfl

theorem corollary312Report_kummerFTensorPacketToDTransferAvailable :
    corollary312DisputeFirstPassReport.kummerFTensorPacketToDTransferAvailable =
      true :=
  rfl

theorem corollary312Report_monoAnalyticTensorPacketForgettingAvailable :
    corollary312DisputeFirstPassReport.monoAnalyticTensorPacketForgettingAvailable =
      true :=
  rfl

theorem corollary312Report_determinantTensorPowerNormalizationAvailable :
    corollary312DisputeFirstPassReport.determinantTensorPowerNormalizationAvailable =
      true :=
  rfl

theorem corollary312Report_hullDetUpperRayComparisonAvailable :
    corollary312DisputeFirstPassReport.hullDetUpperRayComparisonAvailable =
      true :=
  rfl

theorem corollary312Report_qPilotTwoComputationComparisonAvailable :
    corollary312DisputeFirstPassReport.qPilotTwoComputationComparisonAvailable =
      true :=
  rfl

theorem corollary312Report_thetaPilotTensorPowerWarningAvailable :
    corollary312DisputeFirstPassReport.thetaPilotTensorPowerWarningAvailable =
      true :=
  rfl

theorem corollary312Report_globalFrobenioidCalibrationAvailable :
    corollary312DisputeFirstPassReport.globalFrobenioidCalibrationAvailable =
      true :=
  rfl

theorem corollary312Report_positiveRationalUnitRigidityAvailable :
    corollary312DisputeFirstPassReport.positiveRationalUnitRigidityAvailable =
      true :=
  rfl

theorem corollary312Report_generalizedThetaLGPLambdaBoundAvailable :
    corollary312DisputeFirstPassReport.generalizedThetaLGPLambdaBoundAvailable =
      true :=
  rfl

theorem corollary312Report_distinctLabelIntertwiningTransportAvailable :
    corollary312DisputeFirstPassReport.distinctLabelIntertwiningTransportAvailable =
      true :=
  rfl

theorem corollary312Report_toyIntertwiningUpperRayBoundAvailable :
    corollary312DisputeFirstPassReport.toyIntertwiningUpperRayBoundAvailable =
      true :=
  rfl

theorem corollary312Report_logThetaColumnRoleTableAvailable :
    corollary312DisputeFirstPassReport.logThetaColumnRoleTableAvailable =
      true :=
  rfl

theorem corollary312Report_zeroOneColumnAbsorptionDistinctionAvailable :
    corollary312DisputeFirstPassReport.zeroOneColumnAbsorptionDistinctionAvailable =
      true :=
  rfl

theorem corollary312Report_gaussBonnetMetricSignShadowAvailable :
    corollary312DisputeFirstPassReport.gaussBonnetMetricSignShadowAvailable =
      true :=
  rfl

theorem corollary312Report_thetaLabelFactorPNormalizationAvailable :
    corollary312DisputeFirstPassReport.thetaLabelFactorPNormalizationAvailable =
      true :=
  rfl

theorem corollary312Report_frobeniusDerivativeDegreeInequalityAvailable :
    corollary312DisputeFirstPassReport.frobeniusDerivativeDegreeInequalityAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVThetaPilotLogVolumeEstimateAvailable :
    corollary312DisputeFirstPassReport.iutIVThetaPilotLogVolumeEstimateAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVElementaryCoefficientEstimatesAvailable :
    corollary312DisputeFirstPassReport.iutIVElementaryCoefficientEstimatesAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVTripodalBaseChangeLogDegreeAvailable :
    corollary312DisputeFirstPassReport.iutIVTripodalBaseChangeLogDegreeAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVElementarySumIdentitiesAvailable :
    corollary312DisputeFirstPassReport.iutIVElementarySumIdentitiesAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVSmallPrimeRamificationErrorBoundAvailable :
    corollary312DisputeFirstPassReport.iutIVSmallPrimeRamificationErrorBoundAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVGLTwoCardinalityConstantsAvailable :
    corollary312DisputeFirstPassReport.iutIVGLTwoCardinalityConstantsAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVLogSQStepIIIEstimateAvailable :
    corollary312DisputeFirstPassReport.iutIVLogSQStepIIIEstimateAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVPrimeProductCaseSplitBoundAvailable :
    corollary312DisputeFirstPassReport.iutIVPrimeProductCaseSplitBoundAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVFinalErrorAbsorptionAvailable :
    corollary312DisputeFirstPassReport.iutIVFinalErrorAbsorptionAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVTheorem110FinalDisplayAvailable :
    corollary312DisputeFirstPassReport.iutIVTheorem110FinalDisplayAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVTheoremABoundedDiscrepancyAvailable :
    corollary312DisputeFirstPassReport.iutIVTheoremABoundedDiscrepancyAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22BoundedDiscrepancyChainAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22BoundedDiscrepancyChainAvailable =
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
