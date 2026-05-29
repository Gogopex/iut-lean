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
open IUTStage1ZModCuspFullLabel
open IUTStage1ZModSquareWeightProfile
open IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation
open IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction

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

theorem structuredSHETargetBound_finalQTheta
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
    (target_fullLabel_le_thetaAverage :
      ∀ j : ZMod l.value,
        transport_audit.preservationAudit.targetLogVolume.fullLabelLogVolume
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (transport_audit.preservationAudit.coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit.qSigned_le_thetaSigned_via_structuredSHEBound
    profile audited transport_audit source_profile_eq source_log_volume_eq
    target_fullLabel_le_thetaAverage

theorem factoredSHETargetBound_finalQTheta
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
    (factored :
      IUTStage1StructuredSHEFactoredSquareFullLabelObligations
        package part.bundle l)
    (source_profile_eq : profile = factored.sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        factored.sourceLogVolume)
    (target_fullLabel_le_thetaAverage :
      ∀ j : ZMod l.value,
        factored.targetLogVolume.fullLabelLogVolume
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (factored.coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit.qSigned_le_thetaSigned_via_factoredSHEBound
    profile audited factored source_profile_eq source_log_volume_eq
    target_fullLabel_le_thetaAverage

theorem factoredSHENonzeroTargetBound_finalQTheta
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
    (factored :
      IUTStage1StructuredSHEFactoredSquareFullLabelObligations
        package part.bundle l)
    (source_profile_eq : profile = factored.sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        factored.sourceLogVolume)
    (target_nonzero_fullLabel_le_thetaAverage :
      ∀ j : ZMod l.value,
        factored.coordinateEquiv j ≠ 0 ->
          factored.targetLogVolume.fullLabelLogVolume
              (IUTStage1ZModCuspFullLabel.fromCoordinate l
                (factored.coordinateEquiv j)) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit.qSigned_le_thetaSigned_via_factoredSHENonzeroBound
    profile audited factored source_profile_eq source_log_volume_eq
    target_nonzero_fullLabel_le_thetaAverage

theorem gaussianFactoredSHETargetBound_finalQTheta
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
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (coordinate_square_preserved :
      IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
        (l := l) coordinateEquiv)
    (fullLabelMap_preserved :
      IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l) coordinateEquiv)
    (environmentDegree_preserved :
      targetEvaluation.environmentDegree =
        sourceEvaluation.environmentDegree)
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned := by
  let factored :=
    IUTStage1StructuredSHEFactoredSquareFullLabelObligations.fromGaussianDegreeEvaluations
      (package := package) (bundle := part.bundle)
      coordinateEquiv sourceProfile targetProfile
      sourceEvaluation targetEvaluation coordinate_square_preserved
      fullLabelMap_preserved environmentDegree_preserved
  exact factoredSHETargetBound_finalQTheta
    part profile audited factored source_profile_eq source_log_volume_eq
    (by
      intro j
      dsimp [factored,
        IUTStage1StructuredSHEFactoredSquareFullLabelObligations.fromGaussianDegreeEvaluations]
      have hfull :=
        targetEvaluation.toCuspLabelLogVolumeCompatibility_fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (coordinateEquiv j))
      rw [hfull]
      exact target_gaussian_le_thetaAverage j)

theorem gaussianFactoredSHENonzeroTargetBound_finalQTheta
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
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (coordinate_square_preserved :
      IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
        (l := l) coordinateEquiv)
    (fullLabelMap_preserved :
      IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l) coordinateEquiv)
    (environmentDegree_preserved :
      targetEvaluation.environmentDegree =
        sourceEvaluation.environmentDegree)
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_nonzero_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        coordinateEquiv j ≠ 0 ->
          targetEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l
                (coordinateEquiv j)) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned := by
  let factored :=
    IUTStage1StructuredSHEFactoredSquareFullLabelObligations.fromGaussianDegreeEvaluations
      (package := package) (bundle := part.bundle)
      coordinateEquiv sourceProfile targetProfile
      sourceEvaluation targetEvaluation coordinate_square_preserved
      fullLabelMap_preserved environmentDegree_preserved
  exact factoredSHENonzeroTargetBound_finalQTheta
    part profile audited factored source_profile_eq source_log_volume_eq
    (by
      intro j hj
      dsimp [factored,
        IUTStage1StructuredSHEFactoredSquareFullLabelObligations.fromGaussianDegreeEvaluations]
      have hfull :=
        targetEvaluation.toCuspLabelLogVolumeCompatibility_fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (coordinateEquiv j))
      rw [hfull]
      exact target_nonzero_gaussian_le_thetaAverage j hj)

theorem gaussianFactoredSHETargetBound_finalQTheta_of_nonpositive_environment
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
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (coordinate_square_preserved :
      IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
        (l := l) coordinateEquiv)
    (fullLabelMap_preserved :
      IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l) coordinateEquiv)
    (environmentDegree_preserved :
      targetEvaluation.environmentDegree =
        sourceEvaluation.environmentDegree)
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (theta_average_nonnegative :
      0 <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  gaussianFactoredSHETargetBound_finalQTheta
    part profile audited coordinateEquiv sourceProfile targetProfile
    sourceEvaluation targetEvaluation coordinate_square_preserved
    fullLabelMap_preserved environmentDegree_preserved source_profile_eq
    source_log_volume_eq
    (by
      intro j
      exact targetEvaluation.gaussianDegree_le_of_environment_nonpositive_of_nonnegative_bound
        target_environment_nonpositive theta_average_nonnegative
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (coordinateEquiv j)))

theorem gaussianFactoredSHENonzeroTargetBound_finalQTheta_of_environment_le
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
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (coordinate_square_preserved :
      IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
        (l := l) coordinateEquiv)
    (fullLabelMap_preserved :
      IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l) coordinateEquiv)
    (environmentDegree_preserved :
      targetEvaluation.environmentDegree =
        sourceEvaluation.environmentDegree)
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (environment_le_thetaAverage :
      targetEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHENonzeroEnvironment
      (bundle := part.bundle)
      profile audited coordinateEquiv sourceProfile targetProfile
    sourceEvaluation targetEvaluation coordinate_square_preserved
    fullLabelMap_preserved environmentDegree_preserved source_profile_eq
    source_log_volume_eq target_environment_nonpositive
    environment_le_thetaAverage

theorem gaussianFactoredSHEIdentityNonzeroTargetBound_finalQTheta_of_environment_le
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (environmentDegree_preserved :
      targetEvaluation.environmentDegree =
        sourceEvaluation.environmentDegree)
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (environment_le_thetaAverage :
      targetEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHEIdentityNonzeroEnvironment
      (bundle := part.bundle)
      profile audited sourceProfile targetProfile
    sourceEvaluation targetEvaluation environmentDegree_preserved
    source_profile_eq source_log_volume_eq target_environment_nonpositive
    environment_le_thetaAverage

theorem gaussianFactoredSHEIdentityCanonicalOne_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (environment_le_thetaAverage :
      targetEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHEIdentityCanonicalOne
      (bundle := part.bundle)
      profile audited sourceProfile targetProfile
    sourceEvaluation targetEvaluation canonical_one_preserved
    source_profile_eq source_log_volume_eq target_environment_nonpositive
    environment_le_thetaAverage

theorem gaussianFactoredSHEIdentityCanonicalOneSourceEnvironment_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (source_environment_nonpositive :
      sourceEvaluation.environmentDegree <= 0)
    (source_environment_le_thetaAverage :
      sourceEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHEIdentityCanonicalOneSourceEnvironment
      (bundle := part.bundle)
      profile audited sourceProfile targetProfile
    sourceEvaluation targetEvaluation canonical_one_preserved
    source_profile_eq source_log_volume_eq source_environment_nonpositive
    source_environment_le_thetaAverage

theorem gaussianFactoredSHEIdentityCanonicalOneAllLabelNonnegative_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (theta_average_nonnegative :
      0 <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHEIdentityCanonicalOneAllLabelNonnegative
      (bundle := part.bundle)
      profile audited sourceProfile targetProfile
    sourceEvaluation targetEvaluation canonical_one_preserved
    source_profile_eq source_log_volume_eq target_environment_nonpositive
    theta_average_nonnegative

theorem gaussianFactoredSHEIdentityCanonicalOneAllLabelBound_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHEIdentityCanonicalOneAllLabelBound
      (bundle := part.bundle)
      profile audited sourceProfile targetProfile
    sourceEvaluation targetEvaluation canonical_one_preserved
    source_profile_eq source_log_volume_eq target_gaussian_le_thetaAverage

theorem gaussianFactoredSHEIdentityCanonicalOneAllLabelSourceEnvironment_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (source_environment_nonpositive :
      sourceEvaluation.environmentDegree <= 0)
    (theta_average_nonnegative :
      0 <= part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
        audited)
    (source_environment_le_thetaAverage :
      sourceEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHEIdentityCanonicalOneAllLabelSourceEnvironment
      (bundle := part.bundle)
      profile audited sourceProfile targetProfile
    sourceEvaluation targetEvaluation canonical_one_preserved
    source_profile_eq source_log_volume_eq source_environment_nonpositive
    theta_average_nonnegative source_environment_le_thetaAverage

theorem gaussianFactoredSHEIdentityCanonicalOneSourceAllLabelBound_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (source_environment_nonpositive :
      sourceEvaluation.environmentDegree <= 0)
    (source_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        sourceEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHEIdentityCanonicalOneSourceAllLabelBound
      (bundle := part.bundle)
      profile audited sourceProfile targetProfile
    sourceEvaluation targetEvaluation canonical_one_preserved
    source_profile_eq source_log_volume_eq source_environment_nonpositive
    source_gaussian_le_thetaAverage

theorem gaussianFactoredSHEIdentityCanonicalOneZeroNonzeroBound_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (theta_average_nonnegative :
      0 <= part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
        audited)
    (target_nonzero_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        j ≠ 0 ->
          targetEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHEIdentityCanonicalOneZeroNonzeroBound
      (bundle := part.bundle)
      profile audited sourceProfile targetProfile
    sourceEvaluation targetEvaluation canonical_one_preserved
    source_profile_eq source_log_volume_eq theta_average_nonnegative
    target_nonzero_gaussian_le_thetaAverage

theorem gaussianFactoredSHEIdentityCanonicalOneNonzeroBound_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_nonzero_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        j ≠ 0 ->
          targetEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHEIdentityCanonicalOneNonzeroBound
      (bundle := part.bundle)
      profile audited sourceProfile targetProfile
    sourceEvaluation targetEvaluation canonical_one_preserved
    source_profile_eq source_log_volume_eq
    target_nonzero_gaussian_le_thetaAverage

theorem gaussianFactoredSHEIdentityCanonicalOneSourceNonzeroBound_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (source_environment_nonpositive :
      sourceEvaluation.environmentDegree <= 0)
    (source_nonzero_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        j ≠ 0 ->
          sourceEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.toThetaCuspClassContainerAudit
    |>.qSigned_le_thetaSigned_via_gaussianFactoredSHEIdentityCanonicalOneSourceNonzeroBound
      (bundle := part.bundle)
      profile audited sourceProfile targetProfile
    sourceEvaluation targetEvaluation canonical_one_preserved
    source_profile_eq source_log_volume_eq source_environment_nonpositive
    source_nonzero_gaussian_le_thetaAverage

theorem gaussianAllLabelTargetBound_implies_thetaAverage_nonnegative
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) :
    0 <=
      part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
        audited :=
  targetEvaluation.forall_coordinateFullLabel_le_implies_bound_nonnegative
    coordinateEquiv target_gaussian_le_thetaAverage

theorem gaussianAllLabelTargetBound_rejects_negative_thetaAverage
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (theta_average_negative :
      part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited < 0) :
    ¬ ∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited :=
  targetEvaluation.not_forall_coordinateFullLabel_le_of_negative_bound
    coordinateEquiv theta_average_negative

theorem gaussianNegativeTheta_separates_allLabel_from_nonzeroTargetBound
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (theta_average_negative :
      part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited < 0)
    (environment_le_thetaAverage :
      targetEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    (¬ ∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) ∧
      ∀ j : ZMod l.value,
        coordinateEquiv j ≠ 0 ->
          targetEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l
                (coordinateEquiv j)) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited := by
  constructor
  · exact gaussianAllLabelTargetBound_rejects_negative_thetaAverage
      part audited coordinateEquiv targetEvaluation theta_average_negative
  · have target_environment_nonpositive : targetEvaluation.environmentDegree <= 0 :=
      le_trans environment_le_thetaAverage (le_of_lt theta_average_negative)
    exact
      (targetEvaluation
        |>.forall_coordinateFullLabel_nonzero_le_iff_environment_le_bound
          coordinateEquiv target_environment_nonpositive).mpr
        environment_le_thetaAverage

theorem gaussianNegativeTheta_nonzeroRoute_finalQTheta_and_rejects_allLabel
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (theta_average_negative :
      part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited < 0)
    (target_environment_le_thetaAverage :
      targetEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    (¬ ∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned := by
  have hsep :=
    gaussianNegativeTheta_separates_allLabel_from_nonzeroTargetBound
      part audited (Equiv.refl (ZMod l.value)) targetEvaluation
      theta_average_negative target_environment_le_thetaAverage
  exact
    ⟨hsep.1,
      gaussianFactoredSHEIdentityCanonicalOneNonzeroBound_finalQTheta
        part profile audited sourceProfile targetProfile sourceEvaluation
        targetEvaluation canonical_one_preserved source_profile_eq
        source_log_volume_eq hsep.2⟩

theorem gaussianNegativeTheta_targetNonpositive_but_rejects_nonnegativeTheta_and_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (theta_average_negative :
      part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited < 0)
    (target_environment_le_thetaAverage :
      targetEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    targetEvaluation.environmentDegree <= 0 ∧
      (¬ 0 <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned := by
  have hroute :=
    gaussianNegativeTheta_nonzeroRoute_finalQTheta_and_rejects_allLabel
      part profile audited sourceProfile targetProfile sourceEvaluation
      targetEvaluation canonical_one_preserved source_profile_eq
      source_log_volume_eq theta_average_negative
      target_environment_le_thetaAverage
  exact
    ⟨le_trans target_environment_le_thetaAverage
        (le_of_lt theta_average_negative),
      not_le_of_gt theta_average_negative,
      hroute.2⟩

theorem gaussianNegativeTheta_sourceNonzeroRoute_finalQTheta_and_rejects_sourceAllLabel
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (theta_average_negative :
      part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited < 0)
    (source_environment_le_thetaAverage :
      sourceEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    (¬ ∀ j : ZMod l.value,
        sourceEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned := by
  have source_environment_nonpositive : sourceEvaluation.environmentDegree <= 0 :=
    le_trans source_environment_le_thetaAverage (le_of_lt theta_average_negative)
  have source_nonzero_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        j ≠ 0 ->
          sourceEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited :=
    (sourceEvaluation
      |>.forall_coordinateFullLabel_nonzero_le_iff_environment_le_bound
        (Equiv.refl (ZMod l.value)) source_environment_nonpositive).mpr
      source_environment_le_thetaAverage
  exact
    ⟨sourceEvaluation.not_forall_coordinateFullLabel_le_of_negative_bound
        (Equiv.refl (ZMod l.value)) theta_average_negative,
      gaussianFactoredSHEIdentityCanonicalOneSourceNonzeroBound_finalQTheta
        part profile audited sourceProfile targetProfile sourceEvaluation
        targetEvaluation canonical_one_preserved source_profile_eq
        source_log_volume_eq source_environment_nonpositive
        source_nonzero_gaussian_le_thetaAverage⟩

theorem gaussianNegativeTheta_sourceEnvironmentRoute_finalQTheta_and_rejects_allLabels
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (theta_average_negative :
      part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited < 0)
    (source_environment_le_thetaAverage :
      sourceEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    (¬ ∀ j : ZMod l.value,
        sourceEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) ∧
      (¬ ∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned := by
  have hsource :=
    gaussianNegativeTheta_sourceNonzeroRoute_finalQTheta_and_rejects_sourceAllLabel
      part profile audited sourceProfile targetProfile sourceEvaluation
      targetEvaluation canonical_one_preserved source_profile_eq
      source_log_volume_eq theta_average_negative
      source_environment_le_thetaAverage
  exact
    ⟨hsource.1,
      targetEvaluation.not_forall_coordinateFullLabel_le_of_negative_bound
        (Equiv.refl (ZMod l.value)) theta_average_negative,
      hsource.2⟩

theorem gaussianNegativeTheta_rejects_zeroNonzeroZeroHypothesis_and_finalQTheta
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
    (sourceProfile targetProfile : IUTStage1ZModSquareWeightProfile l)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq : profile = sourceProfile)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceEvaluation.toCuspLabelLogVolumeCompatibility)
    (theta_average_negative :
      part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited < 0)
    (source_environment_le_thetaAverage :
      sourceEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    (¬ 0 <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned := by
  have hroute :=
    gaussianNegativeTheta_sourceNonzeroRoute_finalQTheta_and_rejects_sourceAllLabel
      part profile audited sourceProfile targetProfile sourceEvaluation
      targetEvaluation canonical_one_preserved source_profile_eq
      source_log_volume_eq theta_average_negative
      source_environment_le_thetaAverage
  exact ⟨not_le_of_gt theta_average_negative, hroute.2⟩

theorem gaussianAllLabelTargetBound_iff_thetaAverage_nonnegative
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0) :
    (∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) ↔
      0 <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited :=
  targetEvaluation.forall_coordinateFullLabel_le_iff_bound_nonnegative
    coordinateEquiv target_environment_nonpositive

theorem gaussianAllLabelTargetBound_iff_thetaAverage_nonnegative_and_nonzeroBound
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    (∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) ↔
      0 <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited ∧
        ∀ j : ZMod l.value,
          coordinateEquiv j ≠ 0 ->
            targetEvaluation.gaussianDegree
                (IUTStage1ZModCuspFullLabel.fromCoordinate l
                  (coordinateEquiv j)) <=
              part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
                audited :=
  targetEvaluation.forall_coordinateFullLabel_le_iff_bound_nonnegative_and_nonzero_le
    coordinateEquiv

theorem gaussianAllLabelTargetBound_iff_thetaAverage_nonnegative_and_sourceEnvironment
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value))) :
    (∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) ↔
      0 <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited ∧
        sourceEvaluation.environmentDegree <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited :=
  sourceEvaluation
    |>.target_allLabelBound_iff_nonnegative_and_source_environment_le_of_gaussianDegree_one_eq
      targetEvaluation coordinateEquiv target_environment_nonpositive
      canonical_one_preserved

theorem gaussianAllLabelSourceBound_iff_thetaAverage_nonnegative_and_sourceEnvironment
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (sourceEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (source_environment_nonpositive :
      sourceEvaluation.environmentDegree <= 0) :
    (∀ j : ZMod l.value,
        sourceEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) ↔
      0 <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited ∧
        sourceEvaluation.environmentDegree <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited :=
  sourceEvaluation
    |>.forall_coordinateFullLabel_le_iff_bound_nonnegative_and_environment_le
      (Equiv.refl (ZMod l.value)) source_environment_nonpositive

theorem gaussianAllLabelTargetBound_iff_sourceAllLabelBound
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (targetCoordinateEquiv sourceCoordinateEquiv :
      ZMod l.value ≃ ZMod l.value)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (source_environment_nonpositive :
      sourceEvaluation.environmentDegree <= 0)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value))) :
    (∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (targetCoordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) ↔
      ∀ j : ZMod l.value,
        sourceEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (sourceCoordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited :=
  sourceEvaluation
    |>.target_allLabelBound_iff_source_allLabelBound_of_gaussianDegree_one_eq
      targetEvaluation targetCoordinateEquiv sourceCoordinateEquiv
      target_environment_nonpositive source_environment_nonpositive
      canonical_one_preserved

theorem gaussianNonzeroTargetBound_of_environment_le_thetaAverage
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (environment_le_thetaAverage :
      targetEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    ∀ label : (zmodSignAction l).SignLabelQuotient,
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.nonzero label) <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited := by
  intro label
  exact targetEvaluation.gaussianDegree_nonzero_le_of_environment_le_bound
    target_environment_nonpositive environment_le_thetaAverage label

theorem gaussianCoordinateNonzeroTargetBound_iff_environment_le_thetaAverage
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0) :
    (∀ j : ZMod l.value,
        coordinateEquiv j ≠ 0 ->
          targetEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l
                (coordinateEquiv j)) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited) ↔
      targetEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited :=
  targetEvaluation.forall_coordinateFullLabel_nonzero_le_iff_environment_le_bound
    coordinateEquiv target_environment_nonpositive

theorem gaussianCoordinateNonzeroTargetBound_iff_sourceEnvironment_le_thetaAverage
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value))) :
    (∀ j : ZMod l.value,
        coordinateEquiv j ≠ 0 ->
          targetEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l
                (coordinateEquiv j)) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited) ↔
      sourceEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited :=
  sourceEvaluation
    |>.target_nonzeroBound_iff_source_environment_le_of_gaussianDegree_one_eq
      targetEvaluation coordinateEquiv target_environment_nonpositive
      canonical_one_preserved

theorem gaussianCoordinateNonzeroSourceBound_iff_sourceEnvironment_le_thetaAverage
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (sourceEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (source_environment_nonpositive :
      sourceEvaluation.environmentDegree <= 0) :
    (∀ j : ZMod l.value,
        coordinateEquiv j ≠ 0 ->
          sourceEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l
                (coordinateEquiv j)) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited) ↔
      sourceEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited :=
  sourceEvaluation.forall_coordinateFullLabel_nonzero_le_iff_environment_le_bound
    coordinateEquiv source_environment_nonpositive

theorem gaussianCoordinateNonzeroTargetBound_iff_sourceNonzeroBound
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (targetCoordinateEquiv sourceCoordinateEquiv :
      ZMod l.value ≃ ZMod l.value)
    (sourceEvaluation targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (source_environment_nonpositive :
      sourceEvaluation.environmentDegree <= 0)
    (canonical_one_preserved :
      targetEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value))) :
    (∀ j : ZMod l.value,
        targetCoordinateEquiv j ≠ 0 ->
          targetEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l
                (targetCoordinateEquiv j)) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited) ↔
      ∀ j : ZMod l.value,
        sourceCoordinateEquiv j ≠ 0 ->
          sourceEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l
                (sourceCoordinateEquiv j)) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited :=
  sourceEvaluation
    |>.target_nonzeroBound_iff_source_nonzeroBound_of_gaussianDegree_one_eq
      targetEvaluation targetCoordinateEquiv sourceCoordinateEquiv
      target_environment_nonpositive source_environment_nonpositive
      canonical_one_preserved

theorem gaussianCoordinateNonzeroTargetBound_implies_environment_le_thetaAverage
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_nonzero_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        coordinateEquiv j ≠ 0 ->
          targetEvaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l
                (coordinateEquiv j)) <=
            part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
              audited) :
    targetEvaluation.environmentDegree <=
      part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
        audited :=
  targetEvaluation.environment_le_bound_of_forall_coordinateFullLabel_nonzero_le
    coordinateEquiv target_nonzero_gaussian_le_thetaAverage

theorem gaussianAllLabelTargetBound_implies_nonzeroTargetBound
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (coordinateEquiv : ZMod l.value ≃ ZMod l.value)
    (targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_gaussian_le_thetaAverage :
      ∀ j : ZMod l.value,
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited) :
    ∀ j : ZMod l.value,
      coordinateEquiv j ≠ 0 ->
        targetEvaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (coordinateEquiv j)) <=
          part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
            audited :=
  targetEvaluation.forall_coordinateFullLabel_nonzero_le_of_forall_coordinateFullLabel_le
    coordinateEquiv target_gaussian_le_thetaAverage

theorem gaussianNonzeroAverage_le_thetaAverage_of_environment_le
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaHodgeDescentPacketTransportAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (targetEvaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (target_environment_nonpositive :
      targetEvaluation.environmentDegree <= 0)
    (environment_le_thetaAverage :
      targetEvaluation.environmentDegree <=
        part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
          audited) :
    targetEvaluation.nonzeroCarrierAveragedLogVolume.averageLogVolume <=
      part.toThetaCuspClassContainerAudit.theta_source.thetaSourceAverage
        audited :=
  targetEvaluation.nonzeroCarrierAverage_le_of_environment_le_bound
    target_environment_nonpositive environment_le_thetaAverage

theorem zmodNonzeroCarrierCard_eq
    (l : PrimeGeFive) :
    Fintype.card (zmodPointedQuotient l).NonzeroCarrier = l.value - 1 :=
  zmodNonzeroCarrier_card_eq l

theorem zmodNonzeroCarrierCard_eq_two_absLabelTop
    (l : PrimeGeFive) :
    Fintype.card (zmodPointedQuotient l).NonzeroCarrier =
      2 * IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l :=
  IUTStage1ZModSquareWeightProfile.zmodNonzeroCarrier_card_eq_two_absLabelProcessionTop
    (l := l)

theorem gaussianCoordinateAverage_eq_nonzeroMassRescale
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.coordinateAveragedLogVolume.averageLogVolume =
      ((l.value - 1 : Nat) : Real) / (l.value : Real) *
        evaluation.nonzeroCarrierAveragedLogVolume.averageLogVolume :=
  evaluation.coordinateAveragedLogVolume_eq_nonzero_mass_rescale

theorem gaussianNonzeroCarrierAverage_eq_absNonzeroAverage
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.nonzeroCarrierAveragedLogVolume.averageLogVolume =
      (IUTStage1ZModSquareWeightProfile.absNonzeroLabelAveragedLogVolume
        evaluation).averageLogVolume :=
  nonzeroCarrierAveragedLogVolume_eq_absNonzeroLabelAveragedLogVolume
    evaluation

theorem gaussianCoordinateAverage_eq_absNonzeroMassRescale
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.coordinateAveragedLogVolume.averageLogVolume =
      ((l.value - 1 : Nat) : Real) / (l.value : Real) *
        (IUTStage1ZModSquareWeightProfile.absNonzeroLabelAveragedLogVolume
          evaluation).averageLogVolume :=
  IUTStage1ZModSquareWeightProfile.coordinateAveragedLogVolume_eq_absNonzero_mass_rescale
    evaluation

theorem gaussianCoordinateAverage_strictly_above_nonzeroAverage_of_negative
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_neg : evaluation.environmentDegree < 0) :
    evaluation.nonzeroCarrierAveragedLogVolume.averageLogVolume <
      evaluation.coordinateAveragedLogVolume.averageLogVolume :=
  evaluation.coordinateAveragedLogVolume_gt_nonzeroCarrierAverage_of_negative
    henv_neg

theorem gaussianCoordinateAverage_strictly_below_nonzeroAverage_of_positive
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_pos : 0 < evaluation.environmentDegree) :
    evaluation.coordinateAveragedLogVolume.averageLogVolume <
      evaluation.nonzeroCarrierAveragedLogVolume.averageLogVolume :=
  evaluation.coordinateAveragedLogVolume_lt_nonzeroCarrierAverage_of_positive
    henv_pos

theorem gaussianCoordinateAverage_eq_nonzeroAverage_iff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.coordinateAveragedLogVolume.averageLogVolume =
        evaluation.nonzeroCarrierAveragedLogVolume.averageLogVolume ↔
      evaluation.environmentDegree = 0 :=
  evaluation.coordinateAveragedLogVolume_eq_nonzeroCarrierAverage_iff

theorem gaussianCoordinateAverage_lt_zero_of_negative
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_neg : evaluation.environmentDegree < 0) :
    evaluation.coordinateAveragedLogVolume.averageLogVolume < 0 :=
  evaluation.coordinateAveragedLogVolume_lt_zero_of_environment_negative
    henv_neg

theorem gaussianCoordinateAverage_gt_zero_of_positive
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_pos : 0 < evaluation.environmentDegree) :
    0 < evaluation.coordinateAveragedLogVolume.averageLogVolume :=
  evaluation.coordinateAveragedLogVolume_gt_zero_of_environment_positive
    henv_pos

theorem gaussianCoordinateAverage_eq_zero_iff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.coordinateAveragedLogVolume.averageLogVolume = 0 ↔
      evaluation.environmentDegree = 0 :=
  evaluation.coordinateAveragedLogVolume_eq_zero_iff

theorem gaussianCanonicalSignLabel_eq_environment
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.nonzero
          (zmodCanonicalSignLabelQuotient l)) =
      evaluation.environmentDegree :=
  evaluation.gaussianDegree_canonicalSignLabel

theorem gaussianCuspClassCanonicalSignLabel_eq_environment
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.toCuspLabelLogVolumeCompatibility.cuspClassLogVolume
        (zmodCanonicalSignLabelQuotient l) =
      evaluation.environmentDegree :=
  evaluation.cuspClassLogVolume_canonicalSignLabel

theorem fullLabelFromCoordinate_eq_iff_sign
    {l : PrimeGeFive} (j k : ZMod l.value) :
    IUTStage1ZModCuspFullLabel.fromCoordinate l j =
        IUTStage1ZModCuspFullLabel.fromCoordinate l k ↔
      j = k ∨ j = -k :=
  IUTStage1ZModCuspFullLabel.fromCoordinate_eq_iff j k

theorem nonzeroFullLabel_fiber_eq_signPair
    {l : PrimeGeFive}
    (label : (zmodSignAction l).SignLabelQuotient) :
    ∃ (j : ZMod l.value) (_hj : j ≠ 0),
      ∀ k : ZMod l.value,
        IUTStage1ZModCuspFullLabel.fromCoordinate l k =
            IUTStage1ZModCuspFullLabel.nonzero label ↔
          k = j ∨ k = -j :=
  IUTStage1ZModCuspFullLabel.nonzero_fullLabel_fiber_eq_sign_pair label

theorem nonzeroFullLabel_fiber_card
    {l : PrimeGeFive}
    (label : (zmodSignAction l).SignLabelQuotient) :
    (@Finset.filter (ZMod l.value)
      (fun k : ZMod l.value =>
        IUTStage1ZModCuspFullLabel.fromCoordinate l k =
          IUTStage1ZModCuspFullLabel.nonzero label)
      (Classical.decPred _) Finset.univ).card = 2 :=
  IUTStage1ZModCuspFullLabel.nonzero_fullLabel_fiber_card label

theorem zeroFullLabel_fiber_card
    {l : PrimeGeFive} :
    (@Finset.filter (ZMod l.value)
      (fun k : ZMod l.value =>
        IUTStage1ZModCuspFullLabel.fromCoordinate l k =
          IUTStage1ZModCuspFullLabel.zero)
      (Classical.decPred _) Finset.univ).card = 1 :=
  IUTStage1ZModCuspFullLabel.zero_fullLabel_fiber_card

theorem unitActionOnFullLabel_fromCoordinate
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ) (j : ZMod l.value) :
    IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
      IUTStage1ZModCuspFullLabel.fromCoordinate l
        ((zmodUnitActionData l).smul a j) :=
  IUTStage1ZModCuspFullLabel.unitActionOnFullLabel_fromCoordinate l a j

theorem unitActionOnFullLabel_one
    (l : PrimeGeFive) (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l 1 label = label :=
  IUTStage1ZModCuspFullLabel.unitActionOnFullLabel_one l label

theorem unitActionOnFullLabel_mul
    (l : PrimeGeFive) (a b : (ZMod l.value)ˣ)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l (a * b) label =
      IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a
        (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l b label) :=
  IUTStage1ZModCuspFullLabel.unitActionOnFullLabel_mul l a b label

theorem unitActionOnFullLabel_signSubgroup_trivial
    (l : PrimeGeFive) {a : (ZMod l.value)ˣ}
    (ha : a ∈ zmodSignUnitSubgroup l)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label = label :=
  IUTStage1ZModCuspFullLabel.unitActionOnFullLabel_signSubgroup_trivial
    l ha label

theorem unitActionOnFullLabel_inv_mul
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a⁻¹
        (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label) =
      label :=
  IUTStage1ZModCuspFullLabel.unitActionOnFullLabel_inv_mul l a label

theorem unitActionOnFullLabel_mul_inv
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a
        (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a⁻¹ label) =
      label :=
  IUTStage1ZModCuspFullLabel.unitActionOnFullLabel_mul_inv l a label

theorem unitActionOnFullLabelEquiv_apply
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1ZModCuspFullLabel.unitActionOnFullLabelEquiv l a label =
      IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label :=
  IUTStage1ZModCuspFullLabel.unitActionOnFullLabelEquiv_apply l a label

theorem unitActionOnFullLabel_eq_zero_iff
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label =
        IUTStage1ZModCuspFullLabel.zero ↔
      label = IUTStage1ZModCuspFullLabel.zero :=
  IUTStage1ZModCuspFullLabel.unitActionOnFullLabel_eq_zero_iff l a label

theorem singletonOneRestriction_not_translationInvariant
    (l : PrimeGeFive) :
    ¬ ∀ j : ZMod l.value,
        j = 1 -> zmodLabelTranslate l (1 : ZMod l.value) j = 1 :=
  IUTStage1FLLabelTorsorModel.singletonOne_not_closed_under_translation_one l

theorem translationOne_not_descend_to_fullLabel
    (l : PrimeGeFive) :
    ¬ ∃ T : IUTStage1ZModCuspFullLabel l -> IUTStage1ZModCuspFullLabel l,
      ∀ j : ZMod l.value,
        T (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
          IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l (1 : ZMod l.value) j) :=
  IUTStage1ZModCuspFullLabel.no_fullLabel_map_descends_translation_one l

theorem nonzeroTranslation_not_descend_to_fullLabel
    (l : PrimeGeFive) (t : ZMod l.value) (ht : t ≠ 0) :
    ¬ ∃ T : IUTStage1ZModCuspFullLabel l -> IUTStage1ZModCuspFullLabel l,
      ∀ j : ZMod l.value,
        T (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
          IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t j) :=
  IUTStage1ZModCuspFullLabel.no_fullLabel_map_descends_nonzero_translation
    l t ht

theorem translation_descends_to_fullLabel_iff_zero
    (l : PrimeGeFive) (t : ZMod l.value) :
    (∃ T : IUTStage1ZModCuspFullLabel l -> IUTStage1ZModCuspFullLabel l,
      ∀ j : ZMod l.value,
        T (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
          IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t j)) ↔
      t = 0 :=
  IUTStage1ZModCuspFullLabel.fullLabel_map_descends_translation_iff l t

theorem unitAffine_descends_to_fullLabel_iff_zeroTranslation
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    (∃ T : IUTStage1ZModCuspFullLabel l -> IUTStage1ZModCuspFullLabel l,
      ∀ j : ZMod l.value,
        T (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
          IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) ↔
      t = 0 :=
  fullLabel_map_descends_unitAffine_iff_zero_translation l a t

theorem nonzeroTranslation_unitAffine_not_descend_to_fullLabel
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ)
    {t : ZMod l.value} (ht : t ≠ 0) :
    ¬ ∃ T : IUTStage1ZModCuspFullLabel l -> IUTStage1ZModCuspFullLabel l,
      ∀ j : ZMod l.value,
        T (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
          IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j)) :=
  no_fullLabel_map_descends_unitAffine_nonzero_translation l a ht

theorem translationEquiv_fullLabelMapPreserving_iff_zero
    {l : PrimeGeFive} (t : ZMod l.value) :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l)
        (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodTranslationEquiv
          l t) ↔
      t = 0 :=
  IUTStage1ZModCuspLabelLogVolumeCompatibility.fullLabelMapPreserving_translation_iff_zero
    t

theorem unitSmulEquiv_fullLabelMapPreserving_iff_signSubgroup
    {l : PrimeGeFive} (a : (ZMod l.value)ˣ) :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l)
        (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitSmulEquiv
          l a) ↔
      a ∈ zmodSignUnitSubgroup l :=
  IUTStage1ZModCuspLabelLogVolumeCompatibility.fullLabelMapPreserving_unitSmul_iff_signSubgroup
    a

theorem unitAffineEquiv_fullLabelMapPreserving_iff
    {l : PrimeGeFive} (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l)
        (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffineEquiv
          l a t) ↔
      t = 0 ∧ a ∈ zmodSignUnitSubgroup l :=
  IUTStage1ZModCuspLabelLogVolumeCompatibility.fullLabelMapPreserving_unitAffine_iff
    a t

theorem rawCoordinate_sum_translation_eq
    {l : PrimeGeFive} (t : ZMod l.value) (f : ZMod l.value -> Real) :
    (Finset.univ.sum fun j : ZMod l.value => f (zmodLabelTranslate l t j)) =
      Finset.univ.sum f :=
  IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodTranslation_sum_eq
    (l := l) t f

theorem rawCoordinate_sum_unitAffine_eq
    {l : PrimeGeFive} (a : (ZMod l.value)ˣ) (t : ZMod l.value)
    (f : ZMod l.value -> Real) :
    (Finset.univ.sum fun j : ZMod l.value =>
      f (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
      Finset.univ.sum f :=
  IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffine_sum_eq
    (l := l) a t f

theorem properNonemptySubset_not_translationInvariant
    (l : PrimeGeFive) (s : Finset (ZMod l.value))
    (hne : s.Nonempty)
    (hproper : s ≠ Finset.univ) :
    ¬ ∀ (t j : ZMod l.value), j ∈ s -> zmodLabelTranslate l t j ∈ s :=
  IUTStage1FLLabelTorsorModel.zmod_proper_nonempty_subset_not_translation_closed
    l s hne hproper

theorem nonzeroWeightedVolumeSubordinate_zero
    {l : PrimeGeFive}
    (label : (zmodSignAction l).SignLabelQuotient) :
    IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
      (IUTStage1ZModCuspFullLabel.nonzero label)
      IUTStage1ZModCuspFullLabel.zero :=
  IUTStage1ZModCuspFullLabel.nonzero_weightedVolumeSubordinate_zero label

theorem zeroWeightedVolumeSubordinate_zero_absurd
    {l : PrimeGeFive} :
    ¬ IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
      (l := l) IUTStage1ZModCuspFullLabel.zero
      IUTStage1ZModCuspFullLabel.zero :=
  IUTStage1ZModCuspFullLabel.not_zero_weightedVolumeSubordinate_zero

theorem weightedVolumeSubordinate_not_symmetric_at_zero
    {l : PrimeGeFive}
    (label : (zmodSignAction l).SignLabelQuotient) :
    ¬ (IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.nonzero label)
          IUTStage1ZModCuspFullLabel.zero ->
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (l := l) IUTStage1ZModCuspFullLabel.zero
          (IUTStage1ZModCuspFullLabel.nonzero label)) :=
  IUTStage1ZModCuspFullLabel.not_weightedVolumeSubordinate_symmetric_at_nonzero_zero
    label

theorem coordinateNonzeroWeightedVolumeSubordinate_zero
    (l : PrimeGeFive) (j : ZMod l.value) (hj : j ≠ 0) :
    IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
      (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
      IUTStage1ZModCuspFullLabel.zero :=
  IUTStage1ZModCuspFullLabel.fromCoordinate_nonzero_weightedVolumeSubordinate_zero
    l j hj

theorem not_allCoordinatesWeightedVolumeSubordinate_zero
    (l : PrimeGeFive) :
    ¬ ∀ j : ZMod l.value,
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
          IUTStage1ZModCuspFullLabel.zero :=
  IUTStage1ZModCuspFullLabel.not_forall_coordinate_weightedVolumeSubordinate_zero
    l

theorem weightedVolumeSubordinate_zero_iff_nonzeroFullLabel
    {l : PrimeGeFive} (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
        label IUTStage1ZModCuspFullLabel.zero ↔
      label ≠ IUTStage1ZModCuspFullLabel.zero :=
  IUTStage1ZModCuspFullLabel.weightedVolumeSubordinate_zero_iff_ne_zero
    label

theorem coordinateWeightedVolumeSubordinate_zero_iff_nonzero
    (l : PrimeGeFive) (j : ZMod l.value) :
    IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
        IUTStage1ZModCuspFullLabel.zero ↔
      j ≠ 0 :=
  IUTStage1ZModCuspFullLabel.fromCoordinate_weightedVolumeSubordinate_zero_iff
    l j

theorem unitActionOnFullLabel_preserves_subordinate_zero
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
        (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label)
        IUTStage1ZModCuspFullLabel.zero ↔
      IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
        label IUTStage1ZModCuspFullLabel.zero :=
  IUTStage1ZModCuspFullLabel.unitActionOnFullLabel_preserves_subordinate_zero
    l a label

theorem constantCuspLabelLogVolume_toLabelAveraged_eq_constant
    {l : PrimeGeFive} (c : Real) :
    (IUTStage1ZModCuspLabelLogVolumeCompatibility.constant
        (l := l) c).toLabelAveraged =
      IUTStage1LabelAveragedProcessionLogVolume.constant
        (label := ZMod l.value) c :=
  IUTStage1ZModCuspLabelLogVolumeCompatibility.constant_toLabelAveraged_eq_constant
    c

theorem fullLabelFromCoordinate_surjective
    {l : PrimeGeFive} :
    Function.Surjective (IUTStage1ZModCuspFullLabel.fromCoordinate l) :=
  IUTStage1ZModCuspFullLabel.fromCoordinate_surjective

theorem fullLabelFromCoordinate_eq_zero_iff
    {l : PrimeGeFive} (j : ZMod l.value) :
    IUTStage1ZModCuspFullLabel.fromCoordinate l j =
      IUTStage1ZModCuspFullLabel.zero ↔ j = 0 :=
  IUTStage1ZModCuspFullLabel.fromCoordinate_eq_zero_iff j

theorem nonzeroFullLabelFromCoordinate_surjective
    {l : PrimeGeFive}
    (label : (zmodSignAction l).SignLabelQuotient) :
    ∃ (j : ZMod l.value) (_hj : j ≠ 0),
      IUTStage1ZModCuspFullLabel.fromCoordinate l j =
        IUTStage1ZModCuspFullLabel.nonzero label :=
  IUTStage1ZModCuspFullLabel.nonzero_fromCoordinate_surjective label

theorem absLabelProcessionTop_eq_halfMinusOne
    (l : PrimeGeFive) :
    IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l =
      (l.value - 1) / 2 :=
  IUTStage1ZModSquareWeightProfile.absLabelProcessionTop_eq_half_minus_one l

theorem absLabelProcessionCard_eq_halfPlusOne
    (l : PrimeGeFive) :
    Fintype.card
        (IUTStage1ProcessionContainer
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) =
      (l.value + 1) / 2 :=
  IUTStage1ZModSquareWeightProfile.absLabelProcession_card_eq_half_plus_one l

theorem fullLabelFromNatAbsValMinAbs_eq
    {l : PrimeGeFive} (j : ZMod l.value) :
    IUTStage1ZModCuspFullLabel.fromCoordinate l
        (j.valMinAbs.natAbs : ZMod l.value) =
      IUTStage1ZModCuspFullLabel.fromCoordinate l j :=
  IUTStage1ZModCuspFullLabel.fromCoordinate_natAbs_valMinAbs j

theorem absLabelFromProcession_surjective
    {l : PrimeGeFive} :
    Function.Surjective
      (IUTStage1ZModSquareWeightProfile.absLabelFromProcession l) :=
  IUTStage1ZModSquareWeightProfile.absLabelFromProcession_surjective

theorem absLabelFromProcession_injective
    {l : PrimeGeFive} :
    Function.Injective
      (IUTStage1ZModSquareWeightProfile.absLabelFromProcession l) :=
  IUTStage1ZModSquareWeightProfile.absLabelFromProcession_injective

theorem absLabelProcessionEquivFullLabel_apply
    {l : PrimeGeFive}
    (label :
      IUTStage1ProcessionContainer
        (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
    IUTStage1ZModSquareWeightProfile.absLabelProcessionEquivFullLabel label =
      IUTStage1ZModSquareWeightProfile.absLabelFromProcession l label :=
  IUTStage1ZModSquareWeightProfile.absLabelProcessionEquivFullLabel_apply
    label

theorem fullLabelCard_eq_halfPlusOne
    (l : PrimeGeFive) :
    Fintype.card (IUTStage1ZModCuspFullLabel l) =
      (l.value + 1) / 2 :=
  IUTStage1ZModSquareWeightProfile.fullLabel_card_eq_half_plus_one l

theorem subordinateFullLabel_card_eq_absLabelProcessionTop
    {l : PrimeGeFive} :
    (@Finset.filter (IUTStage1ZModCuspFullLabel l)
      (fun label : IUTStage1ZModCuspFullLabel l =>
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          label IUTStage1ZModCuspFullLabel.zero)
      (Classical.decPred _) Finset.univ).card =
        IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l :=
  IUTStage1ZModSquareWeightProfile.subordinateFullLabel_card_eq_absLabelProcessionTop

theorem fullLabelSum_eq_zero_add_subordinateSum
    {l : PrimeGeFive}
    (f : IUTStage1ZModCuspFullLabel l -> Real) :
    Finset.univ.sum f =
      f IUTStage1ZModCuspFullLabel.zero +
        (@Finset.filter (IUTStage1ZModCuspFullLabel l)
          (fun label : IUTStage1ZModCuspFullLabel l =>
            IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
              label IUTStage1ZModCuspFullLabel.zero)
          (Classical.decPred _) Finset.univ).sum f :=
  IUTStage1ZModSquareWeightProfile.fullLabel_sum_eq_zero_add_subordinate_sum
    f

theorem fullLabelAverage_eq_zero_add_subordinateSum_div
    {l : PrimeGeFive}
    (f : IUTStage1ZModCuspFullLabel l -> Real) :
    (Finset.univ.sum f) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) =
      (f IUTStage1ZModCuspFullLabel.zero +
        (@Finset.filter (IUTStage1ZModCuspFullLabel l)
          (fun label : IUTStage1ZModCuspFullLabel l =>
            IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
              label IUTStage1ZModCuspFullLabel.zero)
          (Classical.decPred _) Finset.univ).sum f) /
        ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) + 1) :=
  IUTStage1ZModSquareWeightProfile.fullLabel_average_eq_zero_add_subordinate_sum_div
    f

theorem fullLabelSum_unitAction_eq
    {l : PrimeGeFive} (a : (ZMod l.value)ˣ)
    (f : IUTStage1ZModCuspFullLabel l -> Real) :
    (Finset.univ.sum fun label : IUTStage1ZModCuspFullLabel l =>
      f (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label)) =
      Finset.univ.sum f :=
  IUTStage1ZModSquareWeightProfile.fullLabel_sum_unitAction_eq a f

theorem fullLabelAverage_unitAction_eq
    {l : PrimeGeFive} (a : (ZMod l.value)ˣ)
    (f : IUTStage1ZModCuspFullLabel l -> Real) :
    (Finset.univ.sum fun label : IUTStage1ZModCuspFullLabel l =>
      f (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label)) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) =
      (Finset.univ.sum f) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) :=
  IUTStage1ZModSquareWeightProfile.fullLabel_average_unitAction_eq a f

theorem subordinateFullLabelSum_unitAction_eq
    {l : PrimeGeFive} (a : (ZMod l.value)ˣ)
    (f : IUTStage1ZModCuspFullLabel l -> Real) :
    (@Finset.filter (IUTStage1ZModCuspFullLabel l)
      (fun label : IUTStage1ZModCuspFullLabel l =>
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          label IUTStage1ZModCuspFullLabel.zero)
      (Classical.decPred _) Finset.univ).sum
        (fun label : IUTStage1ZModCuspFullLabel l =>
          f (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label)) =
      (@Finset.filter (IUTStage1ZModCuspFullLabel l)
        (fun label : IUTStage1ZModCuspFullLabel l =>
          IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
            label IUTStage1ZModCuspFullLabel.zero)
        (Classical.decPred _) Finset.univ).sum f :=
  IUTStage1ZModSquareWeightProfile.subordinateFullLabel_sum_unitAction_eq a f

theorem gaussianFullLabelAverage_eq_processionAverage
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    (Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) =
      (Finset.univ.sum fun label :
        IUTStage1ProcessionContainer
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l) =>
          evaluation.gaussianDegree
            (IUTStage1ZModSquareWeightProfile.absLabelFromProcession l label)) /
        (Fintype.card
          (IUTStage1ProcessionContainer
            (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) : Real) :=
  IUTStage1ZModSquareWeightProfile.fullLabel_average_eq_procession_average
    evaluation.gaussianDegree

theorem gaussianCoordinateSum_translation_eq
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (t : ZMod l.value) :
    (Finset.univ.sum fun j : ZMod l.value =>
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l t j))) =
      Finset.univ.sum fun j : ZMod l.value =>
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  evaluation.coordinateGaussian_sum_translation_eq t

theorem gaussianCoordinateAverage_translation_eq
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (t : ZMod l.value) :
    ((Finset.univ.sum fun j : ZMod l.value =>
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l t j))) / (l.value : Real)) =
      evaluation.coordinateAveragedLogVolume.averageLogVolume :=
  evaluation.coordinateAveragedLogVolume_average_translation_eq t

theorem gaussianCoordinateAverage_translationInvariant_but_notFullLabelDescent
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    {t : ZMod l.value} (ht : t ≠ 0) :
    ((Finset.univ.sum fun j : ZMod l.value =>
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l t j))) / (l.value : Real)) =
      evaluation.coordinateAveragedLogVolume.averageLogVolume ∧
    ¬ ∃ T : IUTStage1ZModCuspFullLabel l -> IUTStage1ZModCuspFullLabel l,
      ∀ j : ZMod l.value,
        T (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
          IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t j) :=
  evaluation.coordinateAverage_translationInvariant_but_not_fullLabelDescend ht

theorem gaussianCoordinateSum_unitAffine_eq
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    (Finset.univ.sum fun j : ZMod l.value =>
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j)))) =
      Finset.univ.sum fun j : ZMod l.value =>
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  evaluation.coordinateGaussian_sum_unitAffine_eq a t

theorem gaussianCoordinateAverage_unitAffine_eq
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    ((Finset.univ.sum fun j : ZMod l.value =>
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j)))) /
        (l.value : Real)) =
      evaluation.coordinateAveragedLogVolume.averageLogVolume :=
  evaluation.coordinateAveragedLogVolume_average_unitAffine_eq a t

theorem gaussianCoordinateAverage_unitAffineInvariant_but_notFullLabelDescent
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) {t : ZMod l.value} (ht : t ≠ 0) :
    ((Finset.univ.sum fun j : ZMod l.value =>
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j)))) /
        (l.value : Real)) =
      evaluation.coordinateAveragedLogVolume.averageLogVolume ∧
    ¬ ∃ T : IUTStage1ZModCuspFullLabel l -> IUTStage1ZModCuspFullLabel l,
      ∀ j : ZMod l.value,
        T (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
          IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j)) :=
  evaluation.coordinateAverage_unitAffineInvariant_but_not_fullLabelDescend
    a ht

theorem gaussianDegree_unitSmul_eq_of_signSubgroup
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    {a : (ZMod l.value)ˣ} (ha : a ∈ zmodSignUnitSubgroup l)
    (j : ZMod l.value) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          ((zmodUnitActionData l).smul a j)) =
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  evaluation.gaussianDegree_unitSmul_fromCoordinate_eq_of_signSubgroup ha j

theorem gaussianDegree_unitAffine_zeroTranslation_eq_of_signSubgroup
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    {a : (ZMod l.value)ˣ} (ha : a ∈ zmodSignUnitSubgroup l)
    (j : ZMod l.value) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l (0 : ZMod l.value)
            ((zmodUnitActionData l).smul a j))) =
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  evaluation.gaussianDegree_unitAffine_fromCoordinate_eq_of_signSubgroup
    ha j

theorem zeroTranslation_of_unitAffine_pointwiseGaussianPreserving
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) {t : ZMod l.value}
    (henv : evaluation.environmentDegree ≠ 0)
    (hpres : ∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) :
    t = 0 :=
  evaluation.zero_translation_of_unitAffine_pointwise_gaussian_preserving
    a henv hpres

theorem nonzeroTranslation_not_unitAffine_pointwiseGaussianPreserving
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) {t : ZMod l.value}
    (ht : t ≠ 0) (henv : evaluation.environmentDegree ≠ 0) :
    ¬ ∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  evaluation.no_nonzero_translation_unitAffine_pointwise_gaussian_preserving
    a ht henv

theorem signSubgroup_of_unitAffine_pointwiseGaussianPreserving
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) {t : ZMod l.value}
    (henv : evaluation.environmentDegree ≠ 0)
    (hpres : ∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) :
    a ∈ zmodSignUnitSubgroup l :=
  evaluation.signSubgroup_of_unitAffine_pointwise_gaussian_preserving
    a henv hpres

theorem unitAffine_pointwiseGaussianPreserving_iff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) (t : ZMod l.value)
    (henv : evaluation.environmentDegree ≠ 0) :
    (∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) ↔
      t = 0 ∧ a ∈ zmodSignUnitSubgroup l :=
  evaluation.unitAffine_pointwise_gaussian_preserving_iff a t henv

theorem unitAffine_pointwiseGaussianPreserving_iff_fullLabelMapPreserving
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) (t : ZMod l.value)
    (henv : evaluation.environmentDegree ≠ 0) :
    (∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) ↔
      IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l)
        (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffineEquiv
          l a t) :=
  evaluation.unitAffine_pointwise_gaussian_preserving_iff_fullLabelMapPreserving
    a t henv

theorem unitAffine_pointwiseGaussianPreserving_of_environment_zero
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) (t : ZMod l.value)
    (henv : evaluation.environmentDegree = 0) :
    ∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  evaluation.unitAffine_pointwise_gaussian_preserving_of_environment_zero
    a t henv

theorem unitAffine_pointwiseGaussianPreserving_iff_environmentZero_or_fullLabelMap
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    (∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) ↔
      evaluation.environmentDegree = 0 ∨
        IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
          (l := l)
          (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffineEquiv
            l a t) :=
  evaluation.unitAffine_pointwise_gaussian_preserving_iff_environment_zero_or_fullLabelMapPreserving
    a t

theorem unitAffine_allNonzeroEnvironment_pointwiseGaussianPreserving_iff_fullLabelMap
    {l : PrimeGeFive}
    (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    (∀ evaluation :
        IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l,
      evaluation.environmentDegree ≠ 0 ->
        ∀ j : ZMod l.value,
          evaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l
                (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
            evaluation.gaussianDegree
              (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) ↔
      IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l)
        (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffineEquiv
          l a t) :=
  unitAffine_all_nonzero_environment_pointwise_gaussian_preserving_iff_fullLabelMapPreserving
    a t

theorem unitAffine_pointwiseGaussian_and_coordinateSquarePreserving_iff_identity
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) (t : ZMod l.value)
    (henv : evaluation.environmentDegree ≠ 0) :
    ((∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) ∧
      IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
        (l := l)
        (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffineEquiv
          l a t)) ↔
      t = 0 ∧ a = 1 :=
  evaluation.unitAffine_pointwise_gaussian_and_coordinateSquarePreserving_iff_identity
    a t henv

theorem coordinateSquarePreserving_unitAffine_iff
    {l : PrimeGeFive} (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
        (l := l)
        (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffineEquiv
          l a t) ↔
      t = 0 ∧ a = 1 :=
  IUTStage1ZModSquareWeightProfile.coordinateSquarePreserving_unitAffine_iff
    a t

theorem unitAffine_factoredSquareFullLabelPreserving_iff_identity
    {l : PrimeGeFive} (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    (IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
        (l := l)
        (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffineEquiv
          l a t) ∧
      IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l)
        (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffineEquiv
          l a t)) ↔
      t = 0 ∧ a = 1 :=
  IUTStage1ZModSquareWeightProfile.unitAffine_factoredSquareFullLabelPreserving_iff_identity
    a t

theorem negUnitAffine_pointwiseGaussianPreserving_but_not_coordinateSquarePreserving
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    (∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l (0 : ZMod l.value)
              ((zmodUnitActionData l).smul
                (-1 : (ZMod l.value)ˣ) j))) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) ∧
      ¬ IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
          (l := l)
          (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffineEquiv
            l (-1 : (ZMod l.value)ˣ) (0 : ZMod l.value)) :=
  negUnitAffine_pointwiseGaussianPreserving_and_not_coordinateSquarePreserving
    evaluation

theorem gaussianDegree_nonzero_ne_zero_of_environment_ne_zero
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (label : (zmodSignAction l).SignLabelQuotient)
    (henv : evaluation.environmentDegree ≠ 0) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.nonzero label) ≠ 0 :=
  evaluation.gaussianDegree_nonzero_ne_zero_of_environment_ne_zero label henv

theorem gaussianDegree_fromCoordinate_ne_zero_of_environment_ne_zero
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (j : ZMod l.value) (hj : j ≠ 0)
    (henv : evaluation.environmentDegree ≠ 0) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) ≠ 0 :=
  evaluation.gaussianDegree_fromCoordinate_ne_zero_of_environment_ne_zero
    j hj henv

theorem gaussianDegree_fromCoordinate_eq_zero_iff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (j : ZMod l.value) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j) = 0 ↔
      j = 0 ∨ evaluation.environmentDegree = 0 :=
  evaluation.gaussianDegree_fromCoordinate_eq_zero_iff j

theorem gaussianDegree_eq_zero_of_environment_zero
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv : evaluation.environmentDegree = 0)
    (label : IUTStage1ZModCuspFullLabel l) :
    evaluation.gaussianDegree label = 0 :=
  evaluation.gaussianDegree_eq_zero_of_environment_zero henv label

theorem absThetaPilotDegree_distinguishes_one_two_of_q_ne_zero
    {l : PrimeGeFive}
    (profile : IUTStage1ZModSquareWeightProfile.AbsThetaPilotDegreeProfile l)
    (hq : profile.qPilotDegree ≠ 0) :
    profile.thetaPilotDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) ≠
      profile.thetaPilotDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (2 : ZMod l.value)) :=
  profile.thetaPilotDegree_one_ne_two_of_q_ne_zero hq

theorem gaussianDegree_distinguishes_one_two_of_environment_ne_zero
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv : evaluation.environmentDegree ≠ 0) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) ≠
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (2 : ZMod l.value)) :=
  evaluation.gaussianDegree_one_ne_two_of_environment_ne_zero henv

theorem absThetaPilotDegree_one_two_equal_iff_q_zero
    {l : PrimeGeFive}
    (profile : IUTStage1ZModSquareWeightProfile.AbsThetaPilotDegreeProfile l) :
    profile.thetaPilotDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        profile.thetaPilotDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (2 : ZMod l.value)) ↔
      profile.qPilotDegree = 0 :=
  profile.thetaPilotDegree_one_eq_two_iff_q_zero

theorem gaussianDegree_one_two_equal_iff_environment_zero
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (2 : ZMod l.value)) ↔
      evaluation.environmentDegree = 0 :=
  evaluation.gaussianDegree_one_eq_two_iff_environment_zero

theorem gaussianUnitAffine_zeroComponent_ne_zero_of_environment_ne_zero
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) {t : ZMod l.value}
    (ht : t ≠ 0) (henv : evaluation.environmentDegree ≠ 0) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l t
            ((zmodUnitActionData l).smul a (0 : ZMod l.value)))) ≠
      evaluation.gaussianDegree IUTStage1ZModCuspFullLabel.zero :=
  evaluation.unitAffine_zeroGaussianComponent_ne_zero_of_environment_ne_zero
    a ht henv

theorem gaussianUnitAffine_zeroComponent_eq_zero_iff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l t
            ((zmodUnitActionData l).smul a (0 : ZMod l.value)))) =
      evaluation.gaussianDegree IUTStage1ZModCuspFullLabel.zero ↔
    t = 0 ∨ evaluation.environmentDegree = 0 :=
  evaluation.unitAffine_zeroGaussianComponent_eq_zero_iff a t

theorem gaussianCoordinateAverage_unitAffineInvariant_but_zeroChanged_and_notDescent
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) {t : ZMod l.value}
    (ht : t ≠ 0) (henv : evaluation.environmentDegree ≠ 0) :
    ((Finset.univ.sum fun j : ZMod l.value =>
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j)))) /
        (l.value : Real)) =
      evaluation.coordinateAveragedLogVolume.averageLogVolume ∧
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          (zmodLabelTranslate l t
            ((zmodUnitActionData l).smul a (0 : ZMod l.value)))) ≠
      evaluation.gaussianDegree IUTStage1ZModCuspFullLabel.zero ∧
    ¬ ∃ T : IUTStage1ZModCuspFullLabel l -> IUTStage1ZModCuspFullLabel l,
      ∀ j : ZMod l.value,
        T (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
          IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j)) :=
  evaluation.coordinateAverage_unitAffineInvariant_but_zeroGaussianChanged_and_not_fullLabelDescend
    a ht henv

theorem gaussianFullLabelAverage_eq_subordinateSum_div
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.fullLabelAveragedLogVolume.averageLogVolume =
      ((@Finset.filter (IUTStage1ZModCuspFullLabel l)
        (fun label : IUTStage1ZModCuspFullLabel l =>
          IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
            label IUTStage1ZModCuspFullLabel.zero)
        (Classical.decPred _) Finset.univ).sum evaluation.gaussianDegree) /
        ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) + 1) :=
  evaluation.fullLabelAveragedLogVolume_average_eq_subordinate_sum_div

theorem gaussianDegree_fullLabelSum_unitAction_eq
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) :
    (Finset.univ.sum fun label : IUTStage1ZModCuspFullLabel l =>
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label)) =
      Finset.univ.sum evaluation.gaussianDegree :=
  evaluation.gaussianDegree_fullLabel_sum_unitAction_eq a

theorem gaussianFullLabelAverage_unitAction_eq
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) :
    (Finset.univ.sum fun label : IUTStage1ZModCuspFullLabel l =>
      evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label)) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) =
      evaluation.fullLabelAveragedLogVolume.averageLogVolume :=
  evaluation.fullLabelAveragedLogVolume_average_unitAction_eq a

theorem gaussianDegree_subordinateSum_unitAction_eq
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (a : (ZMod l.value)ˣ) :
    (@Finset.filter (IUTStage1ZModCuspFullLabel l)
      (fun label : IUTStage1ZModCuspFullLabel l =>
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          label IUTStage1ZModCuspFullLabel.zero)
      (Classical.decPred _) Finset.univ).sum
        (fun label : IUTStage1ZModCuspFullLabel l =>
          evaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label)) =
      (@Finset.filter (IUTStage1ZModCuspFullLabel l)
        (fun label : IUTStage1ZModCuspFullLabel l =>
          IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
            label IUTStage1ZModCuspFullLabel.zero)
        (Classical.decPred _) Finset.univ).sum evaluation.gaussianDegree :=
  evaluation.gaussianDegree_subordinate_sum_unitAction_eq a

theorem unitSmul_preserves_coordinateSubordinateZero
    {l : PrimeGeFive} (a : (ZMod l.value)ˣ) (j : ZMod l.value) :
    IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
        (IUTStage1ZModCuspFullLabel.fromCoordinate l
          ((zmodUnitActionData l).smul a j))
        IUTStage1ZModCuspFullLabel.zero ↔
      IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
        (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
        IUTStage1ZModCuspFullLabel.zero :=
  IUTStage1ZModCuspFullLabel.unit_smul_fromCoordinate_weightedVolumeSubordinate_zero_iff
    l a j

theorem translation_preserves_coordinateSubordinateZero_iff_zero
    {l : PrimeGeFive} (t : ZMod l.value) :
    (∀ j : ZMod l.value,
      IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t j))
          IUTStage1ZModCuspFullLabel.zero ↔
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
          IUTStage1ZModCuspFullLabel.zero) ↔
      t = 0 :=
  IUTStage1ZModCuspFullLabel.translation_fromCoordinate_weightedVolumeSubordinate_zero_iff_zero
    l t

theorem nonzeroTranslation_not_preserves_coordinateSubordinateZero
    {l : PrimeGeFive} {t : ZMod l.value} (ht : t ≠ 0) :
    ¬ ∀ j : ZMod l.value,
      IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t j))
          IUTStage1ZModCuspFullLabel.zero ↔
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
          IUTStage1ZModCuspFullLabel.zero :=
  nonzero_translation_not_preserves_fromCoordinate_weightedVolumeSubordinate_zero
    l ht

theorem unitAffine_preserves_coordinateSubordinateZero_iff_zeroTranslation
    {l : PrimeGeFive} (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    (∀ j : ZMod l.value,
      IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j)))
          IUTStage1ZModCuspFullLabel.zero ↔
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
          IUTStage1ZModCuspFullLabel.zero) ↔
      t = 0 :=
  unitAffine_fromCoordinate_weightedVolumeSubordinate_zero_iff_zero_translation
    l a t

theorem gaussianSubordinateSum_mul_six
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    ((@Finset.filter (IUTStage1ZModCuspFullLabel l)
      (fun label : IUTStage1ZModCuspFullLabel l =>
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          label IUTStage1ZModCuspFullLabel.zero)
      (Classical.decPred _) Finset.univ).sum evaluation.gaussianDegree) * 6 =
      ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) + 1) *
          (2 * (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) + 1)) *
        evaluation.environmentDegree :=
  evaluation.gaussianDegree_subordinate_sum_mul_six

theorem gaussianDegree_fromAbsLabelProcession
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (label :
      IUTStage1ProcessionContainer
        (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
    evaluation.gaussianDegree
        (IUTStage1ZModSquareWeightProfile.absLabelFromProcession l label) =
      ((label.val : Real) ^ 2) * evaluation.environmentDegree :=
  IUTStage1ZModSquareWeightProfile.gaussianDegree_fromProcession
    evaluation label

theorem gaussianDegree_fromAbsNonzeroIndex
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (label : Fin (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
    evaluation.gaussianDegree
        (IUTStage1ZModSquareWeightProfile.absNonzeroLabelFromIndex l label) =
      (((label.val + 1 : Nat) : Real) ^ 2) *
        evaluation.environmentDegree :=
  IUTStage1ZModSquareWeightProfile.gaussianDegree_fromAbsNonzeroLabelIndex
    evaluation label

theorem gaussianDegree_absNonzeroIndexAverage_mul_six
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    ((IUTStage1ZModSquareWeightProfile.absNonzeroLabelAveragedLogVolume
        evaluation).averageLogVolume * 6 =
      ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) + 1) *
        (2 *
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
            1) *
          evaluation.environmentDegree) :=
  IUTStage1ZModSquareWeightProfile.gaussianDegree_absNonzeroLabelAverage_mul_six
    evaluation

theorem gaussianDegree_absNonzeroIndexSum_mul_six
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    ((Finset.univ.sum fun label :
      Fin (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l) =>
      evaluation.gaussianDegree
        (IUTStage1ZModSquareWeightProfile.absNonzeroLabelFromIndex l label)) * 6 =
      ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) + 1) *
          (2 * (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) + 1)) *
        evaluation.environmentDegree) :=
  IUTStage1ZModSquareWeightProfile.gaussianDegree_absNonzeroLabel_sum_mul_six
    evaluation

theorem gaussianSubordinateSum_eq_absNonzeroIndexSum
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    (@Finset.filter (IUTStage1ZModCuspFullLabel l)
      (fun label : IUTStage1ZModCuspFullLabel l =>
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          label IUTStage1ZModCuspFullLabel.zero)
      (Classical.decPred _) Finset.univ).sum evaluation.gaussianDegree =
      Finset.univ.sum fun label :
        Fin (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l) =>
          evaluation.gaussianDegree
            (IUTStage1ZModSquareWeightProfile.absNonzeroLabelFromIndex l label) :=
  evaluation.gaussianDegree_subordinate_sum_eq_absNonzeroLabel_sum

theorem gaussianDegree_absNonzeroIndexAverage_eq_coeff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    (IUTStage1ZModSquareWeightProfile.absNonzeroLabelAveragedLogVolume
        evaluation).averageLogVolume =
      (((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) + 1) *
        (2 *
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
            1) / 6) *
          evaluation.environmentDegree :=
  open IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction in
  gaussianDegree_absNonzeroLabel_average_eq_coeff evaluation

theorem gaussianDegree_fullLabelAverage_eq_absNonzeroIndexRescale
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    (Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) =
      (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) /
        ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
          1) *
          (IUTStage1ZModSquareWeightProfile.absNonzeroLabelAveragedLogVolume
            evaluation).averageLogVolume :=
  open IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction in
  gaussianDegree_fullLabel_average_eq_absNonzeroLabel_rescale evaluation

theorem gaussianDegree_absNonzeroIndexAverage_lt_fullLabelAverage_of_negative
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_neg : evaluation.environmentDegree < 0) :
    (IUTStage1ZModSquareWeightProfile.absNonzeroLabelAveragedLogVolume
        evaluation).averageLogVolume <
      (Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) :=
  open IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction in
  gaussianDegree_absNonzeroLabel_average_lt_fullLabel_average_of_negative
    evaluation henv_neg

theorem gaussianDegree_fullLabelAverage_lt_absNonzeroIndexAverage_of_positive
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_pos : 0 < evaluation.environmentDegree) :
    (Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) <
      (IUTStage1ZModSquareWeightProfile.absNonzeroLabelAveragedLogVolume
        evaluation).averageLogVolume :=
  open IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction in
  gaussianDegree_fullLabel_average_lt_absNonzeroLabel_average_of_positive
    evaluation henv_pos

theorem gaussianDegree_absNonzeroIndexAverage_eq_fullLabelAverage_iff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    (IUTStage1ZModSquareWeightProfile.absNonzeroLabelAveragedLogVolume
        evaluation).averageLogVolume =
        (Finset.univ.sum evaluation.gaussianDegree) /
          (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) ↔
      evaluation.environmentDegree = 0 :=
  open IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction in
  gaussianDegree_absNonzeroLabel_average_eq_fullLabel_average_iff
    evaluation

theorem gaussianDegree_absLabelProcessionAverage_mul_six
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    (((Finset.univ.sum fun label :
      IUTStage1ProcessionContainer
        (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l) =>
        evaluation.gaussianDegree
          (IUTStage1ZModSquareWeightProfile.absLabelFromProcession l label)) /
        (Fintype.card
          (IUTStage1ProcessionContainer
            (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
          Real)) * 6 =
      (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        (2 *
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
            1) *
          evaluation.environmentDegree) :=
  gaussianDegree_procession_average_mul_six evaluation

theorem gaussianDegree_fullLabelAverage_mul_six
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    (((Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real)) * 6 =
      (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        (2 *
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
            1) *
          evaluation.environmentDegree) :=
  gaussianDegree_fullLabel_average_mul_six evaluation

theorem gaussianDegree_fullLabelAverage_eq_coeff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    (Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) =
      ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        (2 *
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
            1) / 6) *
          evaluation.environmentDegree :=
  gaussianDegree_fullLabel_average_eq_coeff evaluation

theorem gaussianDegree_fullLabelAverage_ne_singletonIdentity
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv : evaluation.environmentDegree ≠ 0) :
    (Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) ≠
      evaluation.environmentDegree :=
  gaussianDegree_fullLabel_average_ne_environment_of_nonzero evaluation henv

theorem gaussianDegree_fullLabelAverage_le_environment_of_nonpositive
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_nonpos : evaluation.environmentDegree <= 0) :
    (Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) <=
      evaluation.environmentDegree :=
  gaussianDegree_fullLabel_average_le_environment_of_nonpositive
    evaluation henv_nonpos

theorem gaussianDegree_fullLabelAverage_lt_environment_of_negative
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_neg : evaluation.environmentDegree < 0) :
    (Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) <
      evaluation.environmentDegree :=
  gaussianDegree_fullLabel_average_lt_environment_of_negative
    evaluation henv_neg

theorem gaussianDegree_fullLabelAverage_gt_environment_of_positive
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_pos : 0 < evaluation.environmentDegree) :
    evaluation.environmentDegree <
      (Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) :=
  gaussianDegree_fullLabel_average_gt_environment_of_positive
    evaluation henv_pos

theorem gaussianDegree_fullLabelAverage_le_of_environment_le_bound
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    {c : Real}
    (henv_nonpos : evaluation.environmentDegree <= 0)
    (henv_le : evaluation.environmentDegree <= c) :
    (Finset.univ.sum evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) <= c :=
  gaussianDegree_fullLabel_average_le_of_environment_le_bound
    evaluation henv_nonpos henv_le

theorem gaussianFullLabelAveragedLogVolume_eq_coeff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.fullLabelAveragedLogVolume.averageLogVolume =
      ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        (2 *
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
            1) / 6) *
          evaluation.environmentDegree :=
  evaluation.fullLabelAveragedLogVolume_average_eq_coeff

theorem gaussianCoordinateAveragedLogVolume_eq_coeff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.coordinateAveragedLogVolume.averageLogVolume =
      ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
          1) / 3) *
          evaluation.environmentDegree :=
  evaluation.coordinateAveragedLogVolume_average_eq_coeff

theorem gaussianCoordinateAverage_eq_fullLabelMassRescale
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.coordinateAveragedLogVolume.averageLogVolume =
      ((l.value + 1 : Nat) : Real) / (l.value : Real) *
        evaluation.fullLabelAveragedLogVolume.averageLogVolume :=
  evaluation.coordinateAveragedLogVolume_eq_fullLabel_mass_rescale

theorem gaussianCoordinateAverage_lt_fullLabelAverage_of_negative
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_neg : evaluation.environmentDegree < 0) :
    evaluation.coordinateAveragedLogVolume.averageLogVolume <
      evaluation.fullLabelAveragedLogVolume.averageLogVolume :=
  evaluation.coordinateAveragedLogVolume_lt_fullLabelAverage_of_negative
    henv_neg

theorem gaussianFullLabelAverage_lt_coordinateAverage_of_positive
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_pos : 0 < evaluation.environmentDegree) :
    evaluation.fullLabelAveragedLogVolume.averageLogVolume <
      evaluation.coordinateAveragedLogVolume.averageLogVolume :=
  evaluation.fullLabelAverage_lt_coordinateAveragedLogVolume_of_positive
    henv_pos

theorem gaussianCoordinateAverage_eq_fullLabelAverage_iff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.coordinateAveragedLogVolume.averageLogVolume =
        evaluation.fullLabelAveragedLogVolume.averageLogVolume ↔
      evaluation.environmentDegree = 0 :=
  evaluation.coordinateAveragedLogVolume_eq_fullLabelAverage_iff

theorem gaussianFullLabelAveragedLogVolume_canonical_eq_environment
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.fullLabelAveragedLogVolume.normalizedLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
      evaluation.environmentDegree :=
  evaluation.fullLabelAveragedLogVolume_canonicalCoordinate_eq_environment

theorem gaussianFullLabelAveragedLogVolume_average_ne_canonical
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv : evaluation.environmentDegree ≠ 0) :
    evaluation.fullLabelAveragedLogVolume.averageLogVolume ≠
      evaluation.fullLabelAveragedLogVolume.normalizedLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) :=
  evaluation.fullLabelAveragedLogVolume_average_ne_canonicalCoordinate_of_nonzero
    henv

theorem gaussianFullLabelAveragedLogVolume_average_lt_canonical_of_negative
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_neg : evaluation.environmentDegree < 0) :
    evaluation.fullLabelAveragedLogVolume.averageLogVolume <
      evaluation.fullLabelAveragedLogVolume.normalizedLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) :=
  evaluation.fullLabelAveragedLogVolume_average_lt_canonicalCoordinate_of_negative
    henv_neg

theorem gaussianFullLabelAveragedLogVolume_canonical_lt_average_of_positive
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (henv_pos : 0 < evaluation.environmentDegree) :
    evaluation.fullLabelAveragedLogVolume.normalizedLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) <
      evaluation.fullLabelAveragedLogVolume.averageLogVolume :=
  evaluation.fullLabelAveragedLogVolume_canonicalCoordinate_lt_average_of_positive
    henv_pos

theorem gaussianFullLabelAveragedLogVolume_average_eq_canonical_iff
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.fullLabelAveragedLogVolume.averageLogVolume =
      evaluation.fullLabelAveragedLogVolume.normalizedLogVolume
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) ↔
      evaluation.environmentDegree = 0 :=
  evaluation.fullLabelAveragedLogVolume_average_eq_canonicalCoordinate_iff

theorem gaussianFullLabelAveragedLogVolume_le_of_environment_le_bound
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    {c : Real}
    (henv_nonpos : evaluation.environmentDegree <= 0)
    (henv_le : evaluation.environmentDegree <= c) :
    evaluation.fullLabelAveragedLogVolume.averageLogVolume <= c :=
  evaluation.fullLabelAveragedLogVolume_le_of_environment_le_bound
    henv_nonpos henv_le

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
  canonicalSquareWeightProfileAvailable : Bool
  canonicalSquareWeightConstantAverageAvailable : Bool
  canonicalSquareWeightTotalFormulaAvailable : Bool
  canonicalSquareWeightAverageFormulaAvailable : Bool

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
    gaussianDegreeEvaluationIdentityAtOne := true,
    canonicalSquareWeightProfileAvailable := true,
    canonicalSquareWeightConstantAverageAvailable := true,
    canonicalSquareWeightTotalFormulaAvailable := true,
    canonicalSquareWeightAverageFormulaAvailable := true }

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

theorem ind3J2ScaleExperimentReport_canonicalSquareWeightProfile
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport
      l).canonicalSquareWeightProfileAvailable = true :=
  rfl

theorem ind3J2ScaleExperimentReport_canonicalSquareWeightConstantAverage
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport
      l).canonicalSquareWeightConstantAverageAvailable = true :=
  rfl

theorem ind3J2ScaleExperimentReport_canonicalSquareWeightTotalFormula
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport
      l).canonicalSquareWeightTotalFormulaAvailable = true :=
  rfl

theorem ind3J2ScaleExperimentReport_canonicalSquareWeightAverageFormula
    (l : PrimeGeFive) :
    (ind3J2ScaleExperimentReport
      l).canonicalSquareWeightAverageFormulaAvailable = true :=
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

theorem canonicalSquareWeightProfile_total_positive
    (l : PrimeGeFive) :
    0 < (IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l).weightTotal :=
  IUTStage1ZModSquareWeightProfile.canonicalSquareWeights_weightTotal_pos

theorem canonicalSquareWeightProfile_weight_one
    (l : PrimeGeFive) :
    (IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l).weight
        (1 : ZMod l.value) = 1 :=
  IUTStage1ZModSquareWeightProfile.canonicalSquareWeights_weight_one

theorem canonicalSquareWeightProfile_constant_average
    (l : PrimeGeFive) (c : Real) :
    ((IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l).toWeighted
      (IUTStage1LabelAveragedProcessionLogVolume.constant
        (label := ZMod l.value) c)).weightedAverageLogVolume = c :=
  IUTStage1ZModSquareWeightProfile.canonicalSquareWeights_toWeighted_constant_average
    (l := l) c

theorem canonicalSquareWeightProfile_total_formula
    (l : PrimeGeFive) :
    (IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l).weightTotal *
        6 =
      ((l.value - 1 : Nat) : Real) * (l.value : Real) *
        (2 * ((l.value - 1 : Nat) : Real) + 1) :=
  IUTStage1ZModSquareWeightProfile.canonicalSquareWeights_weightTotal_mul_six

theorem canonicalSquareWeightProfile_average_formula
    (l : PrimeGeFive) :
    ((IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l).weightTotal /
        (l.value : Real)) * 6 =
      ((l.value - 1 : Nat) : Real) *
        (2 * ((l.value - 1 : Nat) : Real) + 1) :=
  IUTStage1ZModSquareWeightProfile.canonicalSquareWeights_averageWeight_mul_six

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
  zmodPrimeAverageDenominatorAvailable : Bool
  processionNormalizedIndeterminacyCorridorAvailable : Bool
  processionNormalizedIndBoundsAvailable : Bool
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
  stepXToHullUpperRayHandoffAvailable : Bool
  stepXToQPilotTwoComputationHandoffAvailable : Bool
  stepXSourcedStatementEndpointAvailable : Bool
  stepXSourcedStatementInequalityAvailable : Bool
  thetaExtendedFiniteEndpointAvailable : Bool
  corollary312PilotIndeterminacyBoundaryAvailable : Bool
  corollary312StatementEndpointAvailable : Bool
  qPilotTwoComputationSignedEndpointAvailable : Bool
  corollary312CThetaLowerBoundAlgebraAvailable : Bool
  corollary312SignedCThetaBridgeAvailable : Bool
  qPilotTwoComputationCThetaEndpointAvailable : Bool
  corollary312ThetaSignReductionAvailable : Bool
  thetaPilotTensorPowerWarningAvailable : Bool
  globalFrobenioidCalibrationAvailable : Bool
  positiveRationalUnitRigidityAvailable : Bool
  generalizedThetaLGPLambdaBoundAvailable : Bool
  generalizedQLambdaCThetaAlgebraAvailable : Bool
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
  iutIVBoundedDiscrepancyTransferAvailable : Bool
  iutIVCorollary22C1PrimeScaleWindowAvailable : Bool
  iutIVCorollary22C1Theorem110CoefficientAvailable : Bool
  iutIVCorollary22C1ErrorTermAvailable : Bool
  iutIVCorollary22Theorem110ToC2FirstBoundAvailable : Bool
  iutIVCorollary22QTwoMinusQBoundAvailable : Bool
  iutIVCorollary22HBoundBeforeEpsilonAvailable : Bool
  iutIVCorollary22C2InequalityChainAvailable : Bool
  iutIVCorollary22EpsilonDefinitionAvailable : Bool
  iutIVCorollary22EpsilonErrorConversionAvailable : Bool
  iutIVCorollary22HBoundToMoveLeftAvailable : Bool
  iutIVCorollary22EpsilonMoveLeftAvailable : Bool
  iutIVCorollary22EpsilonAbsorptionAvailable : Bool
  iutIVCorollary22FinalHBoundAvailable : Bool
  iutIVCorollary22LogDiffCondComparisonAvailable : Bool
  iutIVCorollary22FinalHToC2Available : Bool
  iutIVCorollary22ToTheoremABoundAvailable : Bool
  iutIVFiniteExceptionLowerBoundAvailable : Bool
  iutIVCorollary22FiniteExceptionTheoremAAvailable : Bool
  iutIVCorollary23DiophantineInequalityAvailable : Bool
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
    zmodPrimeAverageDenominatorAvailable := true,
    processionNormalizedIndeterminacyCorridorAvailable := true,
    processionNormalizedIndBoundsAvailable := true,
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
    stepXToHullUpperRayHandoffAvailable := true,
    stepXToQPilotTwoComputationHandoffAvailable := true,
    stepXSourcedStatementEndpointAvailable := true,
    stepXSourcedStatementInequalityAvailable := true,
    thetaExtendedFiniteEndpointAvailable := true,
    corollary312PilotIndeterminacyBoundaryAvailable := true,
    corollary312StatementEndpointAvailable := true,
    qPilotTwoComputationSignedEndpointAvailable := true,
    corollary312CThetaLowerBoundAlgebraAvailable := true,
    corollary312SignedCThetaBridgeAvailable := true,
    qPilotTwoComputationCThetaEndpointAvailable := true,
    corollary312ThetaSignReductionAvailable := true,
    thetaPilotTensorPowerWarningAvailable := true,
    globalFrobenioidCalibrationAvailable := true,
    positiveRationalUnitRigidityAvailable := true,
    generalizedThetaLGPLambdaBoundAvailable := true,
    generalizedQLambdaCThetaAlgebraAvailable := true,
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
    iutIVBoundedDiscrepancyTransferAvailable := true,
    iutIVCorollary22C1PrimeScaleWindowAvailable := true,
    iutIVCorollary22C1Theorem110CoefficientAvailable := true,
    iutIVCorollary22C1ErrorTermAvailable := true,
    iutIVCorollary22Theorem110ToC2FirstBoundAvailable := true,
    iutIVCorollary22QTwoMinusQBoundAvailable := true,
    iutIVCorollary22HBoundBeforeEpsilonAvailable := true,
    iutIVCorollary22C2InequalityChainAvailable := true,
    iutIVCorollary22EpsilonDefinitionAvailable := true,
    iutIVCorollary22EpsilonErrorConversionAvailable := true,
    iutIVCorollary22HBoundToMoveLeftAvailable := true,
    iutIVCorollary22EpsilonMoveLeftAvailable := true,
    iutIVCorollary22EpsilonAbsorptionAvailable := true,
    iutIVCorollary22FinalHBoundAvailable := true,
    iutIVCorollary22LogDiffCondComparisonAvailable := true,
    iutIVCorollary22FinalHToC2Available := true,
    iutIVCorollary22ToTheoremABoundAvailable := true,
    iutIVFiniteExceptionLowerBoundAvailable := true,
    iutIVCorollary22FiniteExceptionTheoremAAvailable := true,
    iutIVCorollary23DiophantineInequalityAvailable := true }

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

theorem zmodPrimeAverageDenominator_eq_primeValue
    (l : PrimeGeFive)
    (data : IUTStage1LabelAveragedProcessionLogVolume (ZMod l.value)) :
    data.averageLogVolume =
      (Finset.univ.sum data.normalizedLogVolume) / (l.value : Real) :=
  IUTStage1LabelAveragedProcessionLogVolume.average_eq_zmod_prime_formula
    l data

theorem processionNormalizedIndeterminacyCorridor_before_le_ind3Upper
    {label : Type u} [Fintype label]
    (data : IUTStage1ProcessionNormalizedIndeterminacyCorridor label) :
    data.beforeIndeterminacy.averageLogVolume <= data.ind3UpperBound :=
  data.before_average_le_ind3UpperBound

theorem processionNormalizedIndeterminacyCorridor_afterInd1_le_ind3Upper
    {label : Type u} [Fintype label]
    (data : IUTStage1ProcessionNormalizedIndeterminacyCorridor label) :
    data.afterInd1.averageLogVolume <= data.ind3UpperBound :=
  data.afterInd1_average_le_ind3UpperBound

theorem processionNormalizedIndeterminacyCorridor_afterInd2_le_ind3Upper
    {label : Type u} [Fintype label]
    (data : IUTStage1ProcessionNormalizedIndeterminacyCorridor label) :
    data.afterInd2.averageLogVolume <= data.ind3UpperBound :=
  data.afterInd2_average_le_ind3UpperBound

theorem processionNormalizedIndeterminacyCorridor_afterInd1_eq_before
    {label : Type u} [Fintype label]
    (data : IUTStage1ProcessionNormalizedIndeterminacyCorridor label) :
    data.afterInd1.averageLogVolume =
      data.beforeIndeterminacy.averageLogVolume :=
  data.afterInd1_average_eq_before

theorem processionNormalizedIndeterminacyCorridor_afterInd2_eq_before
    {label : Type u} [Fintype label]
    (data : IUTStage1ProcessionNormalizedIndeterminacyCorridor label) :
    data.afterInd2.averageLogVolume =
      data.beforeIndeterminacy.averageLogVolume :=
  data.afterInd2_average_eq_before

theorem stepXToHullUpperRay_q_le_theta
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label) :
    data.qPilotLogVolume <= data.thetaHullLogVolume :=
  data.qPilotLogVolume_le_thetaHullLogVolume

theorem stepXToHullUpperRay_q_mem
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label) :
    data.qPilotLogVolume ∈
      data.toHullDetPilotUpperRayLogVolume.upperRay :=
  data.toUpperRay_q_mem

theorem stepXToHullUpperRay_q_mem_iff_q_le_theta
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label) :
    data.qPilotLogVolume ∈
        data.toHullDetPilotUpperRayLogVolume.upperRay ↔
      data.qPilotLogVolume <= data.thetaHullLogVolume :=
  data.toHullDetPilotUpperRayLogVolume.qPilot_mem_upperRay_iff

theorem stepXToHullUpperRay_twoComputation_input_le_theta
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label) :
    data.toQPilotTwoComputationLogVolume.inputPrimeStripLogVolume <=
      data.toQPilotTwoComputationLogVolume.upperRayData.thetaHullLogVolume :=
  data.twoComputation_input_le_theta

theorem stepXToHullUpperRay_twoComputation_input_eq_output
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label) :
    data.toQPilotTwoComputationLogVolume.inputPrimeStripLogVolume =
      data.toQPilotTwoComputationLogVolume.outputHullLogVolume :=
  data.twoComputation_input_eq_output

theorem stepXToHullUpperRay_beforeAverage_eq_twoComputation_output
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label) :
    data.corridor.beforeIndeterminacy.averageLogVolume =
      data.toQPilotTwoComputationLogVolume.outputHullLogVolume :=
  data.beforeAverage_eq_twoComputation_output

theorem stepXToHullUpperRay_twoComputation_output_le_theta
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label) :
    data.toQPilotTwoComputationLogVolume.outputHullLogVolume <=
      data.toQPilotTwoComputationLogVolume.upperRayData.thetaHullLogVolume :=
  data.twoComputation_output_le_theta

theorem stepXToHullUpperRay_cTheta_ge_neg_one
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (-1 : Real) <= cTheta :=
  data.cTheta_ge_neg_one
    q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_thetaFinite
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).finiteEndpoint.thetaExtended.IsFinite :=
  data.statementEndpoint_thetaExtendedFinite
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_thetaNotPlusInfinity
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).finiteEndpoint.thetaExtended ≠
      IUTStage1ExtendedSignedLogVolume.plusInfinity :=
  data.statementEndpoint_thetaExtended_ne_plusInfinity
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_thetaFiniteValue_eq_ind3Upper
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
        (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
          thetaHull_le_cTheta_absLogQ).finiteEndpoint.thetaExtended =
      data.corridor.ind3UpperBound :=
  data.statementEndpoint_thetaFiniteValue_eq_ind3Upper
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_qMemUpperRay
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).finiteEndpoint.upperRayData.qPilotLogVolume ∈
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).finiteEndpoint.upperRayData.upperRay :=
  data.statementEndpoint_qPilotLogVolume_mem_upperRay
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_q_le_thetaRealLogVolume
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).finiteEndpoint.upperRayData.qPilotLogVolume <=
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).thetaRealLogVolume :=
  data.statementEndpoint_qPilotLogVolume_le_thetaRealLogVolume
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_q_lt_theta_of_theta_nonneg
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume))
    (hTheta :
      0 <= (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).thetaRealLogVolume) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).finiteEndpoint.upperRayData.qPilotLogVolume <
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).thetaRealLogVolume :=
  data.statementEndpoint_qPilotLogVolume_lt_thetaRealLogVolume_of_theta_nonneg
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hTheta

theorem stepXToHullUpperRay_beforeAverage_lt_theta_of_theta_nonneg
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume))
    (hTheta :
      0 <= (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).thetaRealLogVolume) :
    data.corridor.beforeIndeterminacy.averageLogVolume <
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).thetaRealLogVolume :=
  data.beforeAverage_lt_statementEndpoint_thetaRealLogVolume_of_theta_nonneg
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hTheta

theorem stepXToHullUpperRay_statementEndpoint_cTheta_nonneg_of_theta_nonneg
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume))
    (hTheta :
      0 <= (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).thetaRealLogVolume) :
    0 <=
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).cTheta :=
  data.statementEndpoint_cTheta_nonnegative_of_thetaRealLogVolume_nonnegative
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hTheta

theorem stepXToHullUpperRay_statementEndpoint_qNotSubject
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).pilotBoundary.qStatus =
      IUTStage1Corollary312PilotIndeterminacyStatus.notSubjectToIndeterminacies :=
  data.statementEndpoint_qPilotNotSubject
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_thetaSubject
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).pilotBoundary.thetaStatus =
      IUTStage1Corollary312PilotIndeterminacyStatus.subjectToIndeterminacies :=
  data.statementEndpoint_thetaPilotSubject
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_thetaStatus_ne_qStatus
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).pilotBoundary.thetaStatus ≠
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).pilotBoundary.qStatus :=
  data.statementEndpoint_thetaStatus_ne_qStatus
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_q_eq_beforeAverage
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).finiteEndpoint.upperRayData.qPilotLogVolume =
      data.corridor.beforeIndeterminacy.averageLogVolume :=
  data.statementEndpoint_qPilotLogVolume_eq_beforeAverage
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_absLogQ_eq_neg_beforeAverage
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    -((data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).finiteEndpoint.upperRayData.qPilotLogVolume) =
      -data.corridor.beforeIndeterminacy.averageLogVolume :=
  data.statementEndpoint_absLogQ_eq_neg_beforeAverage
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_absLogQ_pos
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    0 < -((data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).finiteEndpoint.upperRayData.qPilotLogVolume) :=
  data.statementEndpoint_absLogQ_pos
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_beforeAverage_neg_of_qPilotPositive
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume) :
    data.corridor.beforeIndeterminacy.averageLogVolume < 0 :=
  data.beforeAverage_neg_of_qPilotPositive q_pilot_positive

theorem stepXToHullUpperRay_afterInd1Average_neg_of_qPilotPositive
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume) :
    data.corridor.afterInd1.averageLogVolume < 0 :=
  data.afterInd1Average_neg_of_qPilotPositive q_pilot_positive

theorem stepXToHullUpperRay_afterInd2Average_neg_of_qPilotPositive
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume) :
    data.corridor.afterInd2.averageLogVolume < 0 :=
  data.afterInd2Average_neg_of_qPilotPositive q_pilot_positive

theorem stepXToHullUpperRay_statementEndpoint_q_eq_afterInd1Average
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).finiteEndpoint.upperRayData.qPilotLogVolume =
      data.corridor.afterInd1.averageLogVolume :=
  data.statementEndpoint_qPilotLogVolume_eq_afterInd1Average
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_q_eq_afterInd2Average
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).finiteEndpoint.upperRayData.qPilotLogVolume =
      data.corridor.afterInd2.averageLogVolume :=
  data.statementEndpoint_qPilotLogVolume_eq_afterInd2Average
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_q_le_thetaReal
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    data.corridor.beforeIndeterminacy.averageLogVolume <=
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).thetaRealLogVolume :=
  data.beforeAverage_le_statementEndpoint_thetaRealLogVolume
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_afterInd1_le_thetaReal
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    data.corridor.afterInd1.averageLogVolume <=
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).thetaRealLogVolume :=
  data.afterInd1Average_le_statementEndpoint_thetaRealLogVolume
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_afterInd2_le_thetaReal
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    data.corridor.afterInd2.averageLogVolume <=
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).thetaRealLogVolume :=
  data.afterInd2Average_le_statementEndpoint_thetaRealLogVolume
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_theta_eq_ind3Upper
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).thetaRealLogVolume =
      data.corridor.ind3UpperBound :=
  data.statementEndpoint_thetaRealLogVolume_eq_ind3Upper
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_beforeAverage_le_ind3Upper
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label) :
    data.corridor.beforeIndeterminacy.averageLogVolume <=
      data.corridor.ind3UpperBound :=
  data.beforeAverage_le_statementEndpoint_ind3Upper

theorem stepXToHullUpperRay_statementEndpoint_theta_le_cTheta_absLogQ
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ).thetaRealLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume) :=
  data.statementEndpoint_thetaRealLogVolume_le_cTheta_absLogQ
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_beforeAverage_le_cTheta_absLogQ
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    data.corridor.beforeIndeterminacy.averageLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume) :=
  data.beforeAverage_le_cTheta_absLogQ
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_cTheta_ge_neg_one
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    (-1 : Real) <=
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).cTheta :=
  data.statementEndpoint_cTheta_ge_neg_one
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_statementEndpoint_not_cTheta_lt_neg_one
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    ¬ (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).cTheta < (-1 : Real) :=
  data.statementEndpoint_not_cTheta_lt_neg_one
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

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

theorem absLabelProcessionTop_ge_two
    {l : PrimeGeFive} :
    2 ≤ IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l :=
  IUTStage1ZModSquareWeightProfile.absLabelProcessionTop_ge_two l

theorem absLabelProcessionTop_pos
    {l : PrimeGeFive} :
    0 < IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l :=
  IUTStage1ZModSquareWeightProfile.absLabelProcessionTop_pos l

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

theorem lgpSplittingMonoid_generator_sum_eq_procession_square_sum
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    Finset.univ.sum action.generatorLogVolume =
      (Finset.univ.sum fun label :
        IUTStage1ProcessionContainer
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l) =>
          ((label.val : Real) ^ 2)) *
        action.evaluation.environmentDegree :=
  action.generatorLogVolume_sum_eq_procession_square_sum

theorem lgpSplittingMonoid_processionSquareSum_mul_six
    {l : PrimeGeFive} :
    ((Finset.univ.sum fun label :
      IUTStage1ProcessionContainer
        (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l) =>
        ((label.val : Real) ^ 2)) * 6) =
      (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) + 1) *
          (2 *
            (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
              1) :=
  IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction.processionSquareSum_mul_six
    (l := l)

theorem lgpSplittingMonoid_generator_sum_mul_six
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    (Finset.univ.sum action.generatorLogVolume) * 6 =
      ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        ((IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) + 1) *
          (2 *
            (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
              1)) *
        action.evaluation.environmentDegree :=
  action.generatorLogVolume_sum_mul_six

theorem lgpSplittingMonoid_generator_average_mul_six
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    ((Finset.univ.sum action.generatorLogVolume) /
        (Fintype.card
          (IUTStage1ProcessionContainer
            (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
              Real)) *
      6 =
      (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        (2 *
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
            1) *
          action.evaluation.environmentDegree :=
  action.generatorLogVolume_average_mul_six

theorem lgpSplittingMonoid_normalizedActed_eq_packetNormalized_plus_generatorAverage
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    action.normalizedActedLogVolume =
      action.packet.normalizedLogVolume +
        (Finset.univ.sum action.generatorLogVolume) /
          (Fintype.card
            (IUTStage1ProcessionContainer
              (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
                Real) :=
  action.normalizedActedLogVolume_eq_packetNormalized_plus_generatorAverage

theorem lgpSplittingMonoid_normalizedActed_eq_packetNormalized_plus_squareAverage
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    action.normalizedActedLogVolume =
      action.packet.normalizedLogVolume +
        ((Finset.univ.sum fun label :
          IUTStage1ProcessionContainer
            (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l) =>
            ((label.val : Real) ^ 2)) *
          action.evaluation.environmentDegree) /
          (Fintype.card
            (IUTStage1ProcessionContainer
              (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
                Real) :=
  action.normalizedActedLogVolume_eq_packetNormalized_plus_squareAverage

theorem lgpSplittingMonoid_normalizedActed_delta_mul_six
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    (action.normalizedActedLogVolume - action.packet.normalizedLogVolume) * 6 =
      (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) *
        (2 *
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l : Real) +
            1) *
          action.evaluation.environmentDegree :=
  action.normalizedActedLogVolume_delta_mul_six

theorem lgpSplittingMonoid_normalizedActed_delta_nonnegative_of_environment_nonnegative
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l)
    (henv : 0 <= action.evaluation.environmentDegree) :
    0 <= action.normalizedActedLogVolume -
      action.packet.normalizedLogVolume :=
  action.normalizedActedLogVolume_delta_nonnegative_of_environment_nonnegative
    henv

theorem lgpSplittingMonoid_packet_normalized_le_acted_of_environment_nonnegative
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l)
    (henv : 0 <= action.evaluation.environmentDegree) :
    action.packet.normalizedLogVolume <= action.normalizedActedLogVolume :=
  action.packet_normalizedLogVolume_le_normalizedActedLogVolume_of_environment_nonnegative
    henv

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

theorem thetaFiniteEndpoint_isFinite
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.thetaExtended.IsFinite :=
  data.thetaExtendedFinite

theorem thetaFiniteEndpoint_ne_plusInfinity
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.thetaExtended ≠
      IUTStage1ExtendedSignedLogVolume.plusInfinity :=
  data.thetaExtended_ne_plusInfinity

theorem thetaFiniteEndpoint_q_le_finiteTheta
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.upperRayData.qPilotLogVolume <=
      IUTStage1ExtendedSignedLogVolume.finiteValueOrZero
        data.thetaExtended :=
  data.qPilotLogVolume_le_thetaFiniteValue

theorem thetaFiniteEndpoint_realTheta_eq_hull
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.thetaRealLogVolume = data.upperRayData.thetaHullLogVolume :=
  data.thetaRealLogVolume_eq_hull

theorem thetaFiniteEndpoint_q_le_realTheta
    (data : IUTStage1Corollary312ThetaFiniteLogVolumeEndpoint) :
    data.upperRayData.qPilotLogVolume <= data.thetaRealLogVolume :=
  data.qPilotLogVolume_le_thetaRealLogVolume

theorem pilotIndeterminacyBoundary_statuses_distinct
    (data : IUTStage1Corollary312PilotIndeterminacyBoundary) :
    data.thetaStatus ≠ data.qStatus :=
  data.thetaStatus_ne_qStatus

theorem corollary312StatementEndpoint_cTheta_ge_neg_one
    (data : IUTStage1Corollary312StatementEndpoint) :
    (-1 : Real) <= data.cTheta :=
  data.cTheta_ge_neg_one

theorem corollary312StatementEndpoint_rejects_cTheta_lt_neg_one
    (data : IUTStage1Corollary312StatementEndpoint) :
    ¬ data.cTheta < (-1 : Real) :=
  data.not_cTheta_lt_neg_one

theorem corollary312StatementEndpoint_q_not_subject
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.pilotBoundary.qStatus =
      IUTStage1Corollary312PilotIndeterminacyStatus.notSubjectToIndeterminacies :=
  data.qPilotNotSubject

theorem corollary312StatementEndpoint_theta_ne_plusInfinity
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.finiteEndpoint.thetaExtended ≠
      IUTStage1ExtendedSignedLogVolume.plusInfinity :=
  data.thetaExtended_ne_plusInfinity

theorem corollary312StatementEndpoint_q_le_realTheta
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.finiteEndpoint.upperRayData.qPilotLogVolume <=
      data.thetaRealLogVolume :=
  data.qPilotLogVolume_le_thetaRealLogVolume

theorem corollary312StatementEndpoint_q_neg
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.finiteEndpoint.upperRayData.qPilotLogVolume < 0 :=
  data.qPilotLogVolume_neg

theorem corollary312StatementEndpoint_trivial_nonneg_theta_case
    (data : IUTStage1Corollary312StatementEndpoint)
    (hTheta : 0 <= data.thetaRealLogVolume) :
    data.finiteEndpoint.upperRayData.qPilotLogVolume <
      data.thetaRealLogVolume :=
  data.qPilotLogVolume_lt_thetaRealLogVolume_of_theta_nonneg hTheta

theorem corollary312StatementEndpoint_signReduction_corollary312_of_theta_nonneg
    (data : IUTStage1Corollary312StatementEndpoint)
    (hTheta : 0 <= data.thetaRealLogVolume) :
    Corollary312Inequality
      (data.toThetaSignReduction.comparisonDataOfThetaNonnegative
        hTheta).thetaPilot
      (data.toThetaSignReduction.comparisonDataOfThetaNonnegative
        hTheta).qPilot :=
  data.corollary312_of_thetaRealLogVolume_nonnegative hTheta

theorem corollary312StatementEndpoint_realTheta_le_cTheta_absLogQ
    (data : IUTStage1Corollary312StatementEndpoint) :
    data.thetaRealLogVolume <=
      data.cTheta * (-data.finiteEndpoint.upperRayData.qPilotLogVolume) :=
  data.thetaRealLogVolume_le_cTheta_absLogQ

theorem qPilotTwoComputationSignedEndpoint_corollary312
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    Corollary312Inequality
      data.comparisonData.thetaPilot data.comparisonData.qPilot :=
  data.corollary312

theorem qPilotTwoComputationSignedEndpoint_absLogQ_pos
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    0 < data.absLogQ :=
  data.absLogQ_pos

theorem qPilotTwoComputationSignedEndpoint_input_eq_fixed
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    data.twoComputation.inputPrimeStripLogVolume = -data.absLogQ :=
  data.inputPrimeStripLogVolume_eq_neg_absLogQ

theorem qPilotTwoComputationSignedEndpoint_output_eq_fixed
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    data.twoComputation.outputHullLogVolume = -data.absLogQ :=
  data.outputHullLogVolume_eq_neg_absLogQ

theorem qPilotTwoComputationSignedEndpoint_fixed_mem_upperRay
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    -data.absLogQ ∈ data.twoComputation.upperRayData.upperRay :=
  data.fixed_qPilot_mem_upperRay

theorem qPilotTwoComputationSignedEndpoint_fixed_le_theta
    (data : IUTStage1QPilotTwoComputationSignedEndpoint) :
    -data.absLogQ <= data.twoComputation.upperRayData.thetaHullLogVolume :=
  data.fixed_qPilot_le_thetaHullLogVolume

theorem corollary312CTheta_qPilotLogVolume_le_cTheta_absLogQ
    (data : IUTStage1Corollary312CThetaLowerBoundShadow) :
    data.qPilotLogVolume <= data.cTheta * data.absLogQ :=
  data.qPilotLogVolume_le_cTheta_absLogQ

theorem corollary312CTheta_lower_bound
    (data : IUTStage1Corollary312CThetaLowerBoundShadow) :
    (-1 : Real) <= data.cTheta :=
  data.cTheta_ge_neg_one

theorem corollary312SignedCTheta_qSigned_le_cTheta_absLogQ
    (data : IUTStage1Corollary312SignedCThetaBound) :
    data.comparison.qSigned <= data.cTheta * (-data.comparison.qSigned) :=
  data.qSigned_le_cTheta_absLogQ

theorem corollary312SignedCTheta_lower_bound
    (data : IUTStage1Corollary312SignedCThetaBound) :
    (-1 : Real) <= data.cTheta :=
  data.cTheta_ge_neg_one

theorem qPilotTwoComputationCThetaEndpoint_lower_bound
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    (-1 : Real) <= data.cTheta :=
  data.cTheta_ge_neg_one

theorem qPilotTwoComputationCThetaEndpoint_fixed_lower_bound
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    (-1 : Real) <= data.cTheta :=
  data.cTheta_ge_neg_one_from_fixed_qPilot

theorem qPilotTwoComputationCThetaEndpoint_rejects_fixed_cTheta_lt_neg_one
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    ¬ data.cTheta < (-1 : Real) :=
  data.not_cTheta_lt_neg_one_from_fixed_qPilot

theorem qPilotTwoComputationCThetaEndpoint_fixed_le_cTheta_absLogQ
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint) :
    -data.absLogQ <= data.cTheta * data.absLogQ :=
  data.fixed_qPilotLogVolume_le_cTheta_absLogQ

theorem qPilotTwoComputationCThetaEndpoint_statement_lower_bound
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary) :
    (-1 : Real) <= (data.toStatementEndpoint pilotBoundary).cTheta :=
  data.toStatementEndpoint_cTheta_ge_neg_one pilotBoundary

theorem corollary312ThetaSignReduction_trivial_case
    (data : IUTStage1Corollary312ThetaSignReduction)
    (hTheta : 0 <= data.thetaSigned) :
    data.qSigned <= data.thetaSigned :=
  data.qSigned_le_thetaSigned_of_theta_nonneg hTheta

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

theorem thetaPilotTensorPower_originalBoundary_not_mem_tensorPowerUpperRay
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume < 0) :
    data.originalThetaPilotLogVolume ∉ data.tensorPowerUpperRay :=
  data.originalBoundary_not_mem_tensorPowerUpperRay_of_original_neg hTheta

theorem thetaPilotTensorPower_originalUpperRay_not_subset_tensorPowerUpperRay
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume < 0) :
    ¬ data.originalUpperRay ⊆ data.tensorPowerUpperRay :=
  data.originalUpperRay_not_subset_tensorPowerUpperRay_of_original_neg hTheta

theorem localFrobenioidLogVolume_shifted_ne_unshifted
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity)
    (hExponent : data.localExponent ≠ 0)
    (hStep : data.localPrimeStepLogVolume ≠ 0) :
    data.shiftedLogVolume ≠ data.unshiftedLogVolume :=
  data.shiftedLogVolume_ne_unshifted hExponent hStep

theorem localFrobenioidLogVolume_shifted_eq_unshifted_iff_zero_shift
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity) :
    data.shiftedLogVolume = data.unshiftedLogVolume ↔
      (data.localExponent : Real) * data.localPrimeStepLogVolume = 0 :=
  data.shiftedLogVolume_eq_unshifted_iff_shiftTerm_eq_zero

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

theorem globalFrobenioidCalibration_eq_localShifted_iff_zero_shift
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration) :
    data.calibratedLogVolume = data.localData.shiftedLogVolume ↔
      (data.localData.localExponent : Real) *
        data.localData.localPrimeStepLogVolume = 0 :=
  data.calibratedLogVolume_eq_shifted_iff_shiftTerm_eq_zero

theorem positiveRationalUnitRigidity_eq_one
    {q : Rat} (hpos : 0 < q)
    (hunit : IUTStage1PositiveRationalUnitRigidity.IsIntegerUnit q) :
    q = 1 :=
  IUTStage1PositiveRationalUnitRigidity.eq_one_of_pos_of_integerUnit
    hpos hunit

theorem positiveRationalUnitRigidity_positive_iff_eq_one
    {q : Rat} (hunit : IUTStage1PositiveRationalUnitRigidity.IsIntegerUnit q) :
    0 < q ↔ q = 1 :=
  IUTStage1PositiveRationalUnitRigidity.positive_integerUnit_iff_eq_one hunit

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

theorem generalizedQLambdaCTheta_lower_bound
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow) :
    -((data.lambda : Real)) <= data.cTheta :=
  data.cTheta_ge_neg_lambda

theorem generalizedQLambdaCTheta_standard_bound
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hlambda : data.lambda <= 1) :
    (-1 : Real) <= data.cTheta :=
  data.standard_bound_of_lambda_le_one hlambda

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

theorem remark3122Intertwining_forgottenConcreteAssignmentsIncompatible
    (data : IUTStage1Remark3122IntertwiningUpperRayBound) :
    (-data.h : Real) ≠ -2 * data.h :=
  data.forgotten_concrete_assignments_incompatible

theorem remark3122Intertwining_h_le_epsilon
    (data : IUTStage1Remark3122IntertwiningUpperRayBound) :
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

theorem iutIVBoundedDiscrepancy_lowerBound_transfers
    {Point : Type u} {f g : Point -> Real}
    (data : IUTStage1BoundedDiscrepancyEquivalent Point f g)
    {B : Real} (hB : ∀ x : Point, B <= f x) :
    ∀ x : Point, B - data.upper <= g x :=
  data.lowerBound_transfers_to_right hB

theorem iutIVBoundedDiscrepancy_upperBound_transfers
    {Point : Type u} {f g : Point -> Real}
    (data : IUTStage1BoundedDiscrepancyEquivalent Point f g)
    {B : Real} (hB : ∀ x : Point, f x <= B) :
    ∀ x : Point, g x <= B - data.lower :=
  data.upperBound_transfers_to_right hB

theorem iutIVCorollary22C1_logQAll_nonneg
    (data : IUTStage1IUTIVCorollary22C1PrimeScaleWindowShadow) :
    0 <= data.logQAll :=
  data.logQAll_nonneg

theorem iutIVCorollary22C1_scale_window_nonempty
    (data : IUTStage1IUTIVCorollary22C1PrimeScaleWindowShadow) :
    data.sqrtLogQAll <=
      10 * data.delta * data.sqrtLogQAll * data.logTwoDeltaLogQAll :=
  data.sqrtLogQAll_le_upperWindow

theorem iutIVCorollary22C1_one_le_ten_delta_logFactor
    (data : IUTStage1IUTIVCorollary22C1PrimeScaleWindowShadow) :
    (1 : Real) <= 10 * data.delta * data.logTwoDeltaLogQAll :=
  data.one_le_ten_delta_logFactor

theorem iutIVCorollary22C1Theorem110_coefficient_bound
    (data : IUTStage1IUTIVCorollary22C1Theorem110CoefficientShadow) :
    80 * (data.dmod : Real) / (data.l.value : Real) <=
      data.delta / data.sqrtH :=
  data.coefficient_le_delta_inv_sqrtH

theorem iutIVCorollary22C1_errorTerm_bound
    (data : IUTStage1IUTIVCorollary22C1ErrorTermShadow) :
    20 * (data.dStarMod * (data.l.value : Real) + data.etaPrm) <=
      200 * data.delta ^ 2 * data.sqrtH * data.logTwoDeltaH +
        20 * data.etaPrm :=
  data.theorem110_errorTerm_le_corollary22_errorTerm

theorem iutIVCorollary22Theorem110ToC2_first_bound
    (data : IUTStage1IUTIVCorollary22Theorem110ToC2FirstBoundShadow) :
    (1 / 6 : Real) * data.logQ <=
      (1 + data.delta / data.sqrtH) * data.logDegreeSum +
        (200 * data.delta ^ 2 * data.sqrtH * data.logTwoDeltaH +
          20 * data.etaPrm) :=
  data.oneSixthLogQ_le_corollary22FirstRightHandSide

theorem iutIVCorollary22QTwoMinusQ_bound
    (data : IUTStage1IUTIVCorollary22QTwoMinusQBoundShadow) :
    (1 / 6 : Real) * data.logQTwo - (1 / 6 : Real) * data.logQ <=
      (1 / 3 : Real) * data.sqrtH * data.logTwoDeltaH :=
  data.qTwo_minus_q_le_oneThird_sqrtH_logTwoDeltaH

theorem iutIVCorollary22HBound_before_epsilon
    (data : IUTStage1IUTIVCorollary22HBoundBeforeEpsilonShadow) :
    (1 / 6 : Real) * data.h <=
      (1 + data.delta / data.sqrtH) * data.logDegreeSum +
        (15 * data.delta) ^ 2 * data.sqrtH * data.logTwoDeltaH +
          (1 / 2 : Real) * data.cK :=
  data.h_bound_before_epsilon

theorem iutIVCorollary22C2_logQ_bound
    (data : IUTStage1IUTIVCorollary22C2InequalityChainShadow) :
    (1 / 6 : Real) * data.logQ <= data.heightSide :=
  data.logQ_le_heightSide

theorem iutIVCorollary22C2_logQTwo_bound
    (data : IUTStage1IUTIVCorollary22C2InequalityChainShadow) :
    (1 / 6 : Real) * data.logQTwo <= data.heightSide :=
  data.logQTwo_le_heightSide

theorem iutIVCorollary22EpsilonDefinition_pos
    (data : IUTStage1IUTIVCorollary22EpsilonDefinitionShadow) :
    0 < data.epsilonE :=
  data.epsilonE_pos

theorem iutIVCorollary22EpsilonDefinition_lower_bound
    (data : IUTStage1IUTIVCorollary22EpsilonDefinitionShadow) :
    5 * data.delta * data.sqrtH⁻¹ <= data.epsilonE :=
  data.five_delta_inv_sqrtH_le_epsilonE

theorem iutIVCorollary22EpsilonErrorConversion_bound
    (data : IUTStage1IUTIVCorollary22EpsilonErrorConversionShadow) :
    (15 * data.delta) ^ 2 * data.sqrtH * data.logTwoDeltaH <=
      (1 / 6 : Real) * data.h * ((2 / 5 : Real) * data.epsilonE) :=
  data.fifteen_delta_sq_error_le_epsilon_term

theorem iutIVCorollary22HBoundToMoveLeft_preliminary
    (data : IUTStage1IUTIVCorollary22HBoundToMoveLeftShadow) :
    (1 / 6 : Real) * data.h <=
      (1 + (1 / 5 : Real) * data.epsilonE) * data.logDegreeSum +
        (1 / 6 : Real) * data.h * ((2 / 5 : Real) * data.epsilonE) +
          (1 / 2 : Real) * data.cK :=
  data.preliminary_for_move_left

theorem iutIVCorollary22EpsilonMoveLeft_bound
    (data : IUTStage1IUTIVCorollary22EpsilonMoveLeftShadow) :
    (1 / 6 : Real) * data.h <=
      iutIVCorollary22EpsilonMainCoefficient data.epsilonE *
          data.logDegreeSum +
        iutIVCorollary22EpsilonConstantTerm data.epsilonE data.cK :=
  data.moved_left_bound

theorem iutIVCorollary22EpsilonAbsorption_mainCoefficient_bound
    (data : IUTStage1IUTIVCorollary22EpsilonAbsorptionShadow) :
    iutIVCorollary22EpsilonMainCoefficient data.epsilonE <=
      1 + data.epsilonE :=
  data.mainCoefficient_le_one_add_epsilon

theorem iutIVCorollary22EpsilonAbsorption_constantTerm_bound
    (data : IUTStage1IUTIVCorollary22EpsilonAbsorptionShadow) :
    iutIVCorollary22EpsilonConstantTerm data.epsilonE data.cK <= data.cK :=
  data.constantTerm_le_cK

theorem iutIVCorollary22EpsilonAbsorption_final_bound
    (data : IUTStage1IUTIVCorollary22EpsilonAbsorptionShadow) :
    (1 / 6 : Real) * data.h <=
      (1 + data.epsilonE) * data.logDegreeSum + data.cK :=
  data.final_bound

theorem iutIVCorollary22FinalHBound_bound
    (data : IUTStage1IUTIVCorollary22FinalHBoundShadow) :
    (1 / 6 : Real) * data.h <=
      (1 + data.epsilonE) * data.logDegreeSum + data.cK :=
  data.final_h_bound

theorem iutIVCorollary22LogDiffCond_ftpd_le_curve
    (data : IUTStage1IUTIVCorollary22LogDiffCondComparisonShadow) :
    data.ftpdLogSum <= data.curveLogSum :=
  data.ftpdLogSum_le_curveLogSum

theorem iutIVCorollary22LogDiffCond_curve_le_ftpd_add_logTwoL
    (data : IUTStage1IUTIVCorollary22LogDiffCondComparisonShadow) :
    data.curveLogSum <= data.ftpdLogSum + data.logTwoL :=
  data.curveLogSum_le_ftpdLogSum_add_logTwoL

theorem iutIVCorollary22FinalHToC2_logQAll_bound
    (data : IUTStage1IUTIVCorollary22FinalHToC2Shadow) :
    (1 / 6 : Real) * data.logQAll <=
      (1 + data.epsilonE) * (data.logDiffX + data.logCondD) + data.cK :=
  data.logQAll_le_curveSide

def iutIVCorollary22FinalHToC2_chain
    (data : IUTStage1IUTIVCorollary22FinalHToC2Shadow) :
    IUTStage1IUTIVCorollary22C2InequalityChainShadow :=
  data.toC2InequalityChain

theorem iutIVCorollary22ToTheoremA_discrepancy_bounded_below
    {Point : Type u}
    (data : IUTStage1IUTIVCorollary22ToTheoremABoundShadow Point)
    (x : Point) :
    data.lowerBound <= data.discrepancy x :=
  data.discrepancy_bounded_below x

noncomputable def iutIVCorollary22ToTheoremA_shadow
    {Point : Type u}
    (data : IUTStage1IUTIVCorollary22ToTheoremABoundShadow Point)
    (d : Nat) (d_pos : 0 < d)
    (epsilonE_pos : 0 < data.epsilonE)
    (hyperbolicCurve : Prop) (hyperbolic_curve : hyperbolicCurve) :
    IUTStage1IUTIVTheoremABoundedDiscrepancyShadow Point :=
  data.toTheoremABoundedDiscrepancyShadow d d_pos epsilonE_pos
    hyperbolicCurve hyperbolic_curve

theorem iutIVFiniteExceptionLowerBound_global
    {Point : Type u} [DecidableEq Point]
    (data : IUTStage1FiniteExceptionLowerBoundShadow Point)
    (x : Point) :
    data.globalLowerBound <= data.function x :=
  data.global_bound x

theorem iutIVCorollary22FiniteExceptionTheoremA_global
    {Point : Type u} [DecidableEq Point]
    (data : IUTStage1IUTIVCorollary22FiniteExceptionTheoremAShadow Point)
    (x : Point) :
    data.globalLowerBound <= data.discrepancy x :=
  data.discrepancy_bounded_below x

theorem iutIVCorollary23DiophantineInequality_lower_bound
    {Point : Type u}
    (data : IUTStage1IUTIVCorollary23DiophantineInequalityShadow Point)
    (x : Point) :
    data.lowerBound <= data.discrepancy x :=
  data.discrepancy_bounded_below x

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

theorem representativeSquareWeightAudit_sourceAverage_le_of_target_bound
    {l : PrimeGeFive}
    (audit : IUTStage1ZModSquareWeightedFullLabelTransportAudit l)
    {c : Real}
    (hpointwise :
      ∀ j : ZMod l.value,
        audit.targetLogVolume.fullLabelLogVolume
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (audit.coordinateEquiv j)) <= c) :
    audit.sourceAverage <= c :=
  audit.sourceAverage_le_of_forall_targetFullLabel_le hpointwise

theorem structuredSHESquareWeightAudit_sourceAverage_le_of_target_bound
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
    {l : PrimeGeFive}
    (audit :
      IUTStage1StructuredSHESquareWeightTransportAudit package bundle l)
    {c : Real}
    (hpointwise :
      ∀ j : ZMod l.value,
        audit.preservationAudit.targetLogVolume.fullLabelLogVolume
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (audit.preservationAudit.coordinateEquiv j)) <= c) :
    audit.preservationAudit.sourceAverage <= c :=
  audit.sourceAverage_le_of_forall_targetFullLabel_le hpointwise

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

theorem balancedNeg_preservesGaussianAndBalanced_rejectsRepresentative
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (logVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    (∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            ((IUTStage1BalancedSquareFullLabelTransport.negSelf
              logVolume).coordinateEquiv j)) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) ∧
      (∀ j : ZMod l.value,
        IUTStage1ZModSquareWeightProfile.balancedSquareWeight
            (l := l)
            ((IUTStage1BalancedSquareFullLabelTransport.negSelf
              logVolume).coordinateEquiv j) =
          IUTStage1ZModSquareWeightProfile.balancedSquareWeight
            (l := l) j) ∧
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
            j := by
  open IUTStage1BalancedSquareFullLabelTransport in
  exact negSelf_gaussian_balanced_preserved_and_representative_fails
    evaluation logVolume

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
  finalRouteRejectsBalancedNegTransport : Bool
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
    finalRouteRejectsBalancedNegTransport := true,
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

theorem finalWeightedThetaRoute_rejectsBalancedNegTransportLevel
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
        part profile audited)
    (logVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    FLZModCuspLabelThetaCuspClassContainerAudit.weightedThetaComparisonRouteLevel
        route ≠
      (IUTStage1BalancedSquareFullLabelTransport.negSelf
        logVolume).comparisonLevel := by
  intro h
  exact finalWeightedThetaRoute_rejectsBalanced route (by
    simpa [IUTStage1BalancedSquareFullLabelTransport.comparisonLevel] using h)

theorem balancedNegDiagnostic_preservedButNotFinalRoute
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
        part profile audited)
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (logVolume : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    ((∀ j : ZMod l.value,
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            ((IUTStage1BalancedSquareFullLabelTransport.negSelf
              logVolume).coordinateEquiv j)) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) ∧
      (∀ j : ZMod l.value,
        IUTStage1ZModSquareWeightProfile.balancedSquareWeight
            (l := l)
            ((IUTStage1BalancedSquareFullLabelTransport.negSelf
              logVolume).coordinateEquiv j) =
          IUTStage1ZModSquareWeightProfile.balancedSquareWeight
            (l := l) j) ∧
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
            j) ∧
      FLZModCuspLabelThetaCuspClassContainerAudit.weightedThetaComparisonRouteLevel
          route ≠
        (IUTStage1BalancedSquareFullLabelTransport.negSelf
          logVolume).comparisonLevel :=
  ⟨balancedNeg_preservesGaussianAndBalanced_rejectsRepresentative
      evaluation logVolume,
    finalWeightedThetaRoute_rejectsBalancedNegTransportLevel route logVolume⟩

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

theorem ind3FinalRouteLevelExperimentReport_rejectsBalancedNegTransport :
    ind3FinalRouteLevelExperimentReport.finalRouteRejectsBalancedNegTransport =
      true :=
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
  absThetaDegreeDistinguishesOneTwoAvailable : Bool
  gaussianDegreeEvaluationTheoremAvailable : Bool
  canonicalSquareWeightProfileAvailable : Bool
  canonicalSquareWeightConstantAverageAvailable : Bool
  canonicalSquareWeightTotalFormulaAvailable : Bool
  canonicalSquareWeightAverageFormulaAvailable : Bool
  processionContainerSkeletonAvailable : Bool
  processionTensorPacketLogVolumeAvailable : Bool
  processionTensorPacketPermutationInvariant : Bool
  zmodPrimeAverageDenominatorAvailable : Bool
  processionNormalizedIndeterminacyCorridorAvailable : Bool
  processionNormalizedIndBoundsAvailable : Bool
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
  stepXToHullUpperRayHandoffAvailable : Bool
  stepXToQPilotTwoComputationHandoffAvailable : Bool
  stepXSourcedStatementEndpointAvailable : Bool
  stepXSourcedStatementInequalityAvailable : Bool
  thetaExtendedFiniteEndpointAvailable : Bool
  corollary312PilotIndeterminacyBoundaryAvailable : Bool
  corollary312StatementEndpointAvailable : Bool
  qPilotTwoComputationSignedEndpointAvailable : Bool
  corollary312CThetaLowerBoundAlgebraAvailable : Bool
  corollary312SignedCThetaBridgeAvailable : Bool
  qPilotTwoComputationCThetaEndpointAvailable : Bool
  corollary312ThetaSignReductionAvailable : Bool
  thetaPilotTensorPowerWarningAvailable : Bool
  globalFrobenioidCalibrationAvailable : Bool
  positiveRationalUnitRigidityAvailable : Bool
  generalizedThetaLGPLambdaBoundAvailable : Bool
  generalizedQLambdaCThetaAlgebraAvailable : Bool
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
  iutIVBoundedDiscrepancyTransferAvailable : Bool
  iutIVCorollary22C1PrimeScaleWindowAvailable : Bool
  iutIVCorollary22C1Theorem110CoefficientAvailable : Bool
  iutIVCorollary22C1ErrorTermAvailable : Bool
  iutIVCorollary22Theorem110ToC2FirstBoundAvailable : Bool
  iutIVCorollary22QTwoMinusQBoundAvailable : Bool
  iutIVCorollary22HBoundBeforeEpsilonAvailable : Bool
  iutIVCorollary22C2InequalityChainAvailable : Bool
  iutIVCorollary22EpsilonDefinitionAvailable : Bool
  iutIVCorollary22EpsilonErrorConversionAvailable : Bool
  iutIVCorollary22HBoundToMoveLeftAvailable : Bool
  iutIVCorollary22EpsilonMoveLeftAvailable : Bool
  iutIVCorollary22EpsilonAbsorptionAvailable : Bool
  iutIVCorollary22FinalHBoundAvailable : Bool
  iutIVCorollary22LogDiffCondComparisonAvailable : Bool
  iutIVCorollary22FinalHToC2Available : Bool
  iutIVCorollary22ToTheoremABoundAvailable : Bool
  iutIVFiniteExceptionLowerBoundAvailable : Bool
  iutIVCorollary22FiniteExceptionTheoremAAvailable : Bool
  iutIVCorollary23DiophantineInequalityAvailable : Bool
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
    absThetaDegreeDistinguishesOneTwoAvailable := true,
    gaussianDegreeEvaluationTheoremAvailable := true,
    canonicalSquareWeightProfileAvailable := true,
    canonicalSquareWeightConstantAverageAvailable := true,
    canonicalSquareWeightTotalFormulaAvailable := true,
    canonicalSquareWeightAverageFormulaAvailable := true,
    processionContainerSkeletonAvailable := true,
    processionTensorPacketLogVolumeAvailable := true,
    processionTensorPacketPermutationInvariant := true,
    zmodPrimeAverageDenominatorAvailable := true,
    processionNormalizedIndeterminacyCorridorAvailable := true,
    processionNormalizedIndBoundsAvailable := true,
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
    stepXToHullUpperRayHandoffAvailable := true,
    stepXToQPilotTwoComputationHandoffAvailable := true,
    stepXSourcedStatementEndpointAvailable := true,
    stepXSourcedStatementInequalityAvailable := true,
    thetaExtendedFiniteEndpointAvailable := true,
    corollary312PilotIndeterminacyBoundaryAvailable := true,
    corollary312StatementEndpointAvailable := true,
    qPilotTwoComputationSignedEndpointAvailable := true,
    corollary312CThetaLowerBoundAlgebraAvailable := true,
    corollary312SignedCThetaBridgeAvailable := true,
    qPilotTwoComputationCThetaEndpointAvailable := true,
    corollary312ThetaSignReductionAvailable := true,
    thetaPilotTensorPowerWarningAvailable := true,
    globalFrobenioidCalibrationAvailable := true,
    positiveRationalUnitRigidityAvailable := true,
    generalizedThetaLGPLambdaBoundAvailable := true,
    generalizedQLambdaCThetaAlgebraAvailable := true,
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
    iutIVBoundedDiscrepancyTransferAvailable := true,
    iutIVCorollary22C1PrimeScaleWindowAvailable := true,
    iutIVCorollary22C1Theorem110CoefficientAvailable := true,
    iutIVCorollary22C1ErrorTermAvailable := true,
    iutIVCorollary22Theorem110ToC2FirstBoundAvailable := true,
    iutIVCorollary22QTwoMinusQBoundAvailable := true,
    iutIVCorollary22HBoundBeforeEpsilonAvailable := true,
    iutIVCorollary22C2InequalityChainAvailable := true,
    iutIVCorollary22EpsilonDefinitionAvailable := true,
    iutIVCorollary22EpsilonErrorConversionAvailable := true,
    iutIVCorollary22HBoundToMoveLeftAvailable := true,
    iutIVCorollary22EpsilonMoveLeftAvailable := true,
    iutIVCorollary22EpsilonAbsorptionAvailable := true,
    iutIVCorollary22FinalHBoundAvailable := true,
    iutIVCorollary22LogDiffCondComparisonAvailable := true,
    iutIVCorollary22FinalHToC2Available := true,
    iutIVCorollary22ToTheoremABoundAvailable := true,
    iutIVFiniteExceptionLowerBoundAvailable := true,
    iutIVCorollary22FiniteExceptionTheoremAAvailable := true,
    iutIVCorollary23DiophantineInequalityAvailable := true,
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

theorem corollary312Report_absThetaDegreeDistinguishesOneTwoAvailable :
    corollary312DisputeFirstPassReport.absThetaDegreeDistinguishesOneTwoAvailable =
      true :=
  rfl

theorem corollary312Report_gaussianDegreeEvaluationTheoremAvailable :
    corollary312DisputeFirstPassReport.gaussianDegreeEvaluationTheoremAvailable =
      true :=
  rfl

theorem corollary312Report_canonicalSquareWeightProfileAvailable :
    corollary312DisputeFirstPassReport.canonicalSquareWeightProfileAvailable =
      true :=
  rfl

theorem corollary312Report_canonicalSquareWeightConstantAverageAvailable :
    corollary312DisputeFirstPassReport.canonicalSquareWeightConstantAverageAvailable =
      true :=
  rfl

theorem corollary312Report_canonicalSquareWeightTotalFormulaAvailable :
    corollary312DisputeFirstPassReport.canonicalSquareWeightTotalFormulaAvailable =
      true :=
  rfl

theorem corollary312Report_canonicalSquareWeightAverageFormulaAvailable :
    corollary312DisputeFirstPassReport.canonicalSquareWeightAverageFormulaAvailable =
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

theorem corollary312Report_zmodPrimeAverageDenominatorAvailable :
    corollary312DisputeFirstPassReport.zmodPrimeAverageDenominatorAvailable =
      true :=
  rfl

theorem corollary312Report_processionNormalizedIndeterminacyCorridorAvailable :
    corollary312DisputeFirstPassReport.processionNormalizedIndeterminacyCorridorAvailable =
      true :=
  rfl

theorem corollary312Report_processionNormalizedIndBoundsAvailable :
    corollary312DisputeFirstPassReport.processionNormalizedIndBoundsAvailable =
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

theorem corollary312Report_stepXToHullUpperRayHandoffAvailable :
    corollary312DisputeFirstPassReport.stepXToHullUpperRayHandoffAvailable =
      true :=
  rfl

theorem corollary312Report_stepXToQPilotTwoComputationHandoffAvailable :
    corollary312DisputeFirstPassReport.stepXToQPilotTwoComputationHandoffAvailable =
      true :=
  rfl

theorem corollary312Report_stepXSourcedStatementEndpointAvailable :
    corollary312DisputeFirstPassReport.stepXSourcedStatementEndpointAvailable =
      true :=
  rfl

theorem corollary312Report_stepXSourcedStatementInequalityAvailable :
    corollary312DisputeFirstPassReport.stepXSourcedStatementInequalityAvailable =
      true :=
  rfl

theorem corollary312Report_thetaExtendedFiniteEndpointAvailable :
    corollary312DisputeFirstPassReport.thetaExtendedFiniteEndpointAvailable =
      true :=
  rfl

theorem corollary312Report_pilotIndeterminacyBoundaryAvailable :
    corollary312DisputeFirstPassReport.corollary312PilotIndeterminacyBoundaryAvailable =
      true :=
  rfl

theorem corollary312Report_statementEndpointAvailable :
    corollary312DisputeFirstPassReport.corollary312StatementEndpointAvailable =
      true :=
  rfl

theorem corollary312Report_qPilotTwoComputationSignedEndpointAvailable :
    corollary312DisputeFirstPassReport.qPilotTwoComputationSignedEndpointAvailable =
      true :=
  rfl

theorem corollary312Report_cThetaLowerBoundAlgebraAvailable :
    corollary312DisputeFirstPassReport.corollary312CThetaLowerBoundAlgebraAvailable =
      true :=
  rfl

theorem corollary312Report_signedCThetaBridgeAvailable :
    corollary312DisputeFirstPassReport.corollary312SignedCThetaBridgeAvailable =
      true :=
  rfl

theorem corollary312Report_qPilotTwoComputationCThetaEndpointAvailable :
    corollary312DisputeFirstPassReport.qPilotTwoComputationCThetaEndpointAvailable =
      true :=
  rfl

theorem corollary312Report_thetaSignReductionAvailable :
    corollary312DisputeFirstPassReport.corollary312ThetaSignReductionAvailable =
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

theorem corollary312Report_generalizedQLambdaCThetaAlgebraAvailable :
    corollary312DisputeFirstPassReport.generalizedQLambdaCThetaAlgebraAvailable =
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

theorem corollary312Report_iutIVBoundedDiscrepancyTransferAvailable :
    corollary312DisputeFirstPassReport.iutIVBoundedDiscrepancyTransferAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22C1PrimeScaleWindowAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22C1PrimeScaleWindowAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22C1Theorem110CoefficientAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22C1Theorem110CoefficientAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22C1ErrorTermAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22C1ErrorTermAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22Theorem110ToC2FirstBoundAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22Theorem110ToC2FirstBoundAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22QTwoMinusQBoundAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22QTwoMinusQBoundAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22HBoundBeforeEpsilonAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22HBoundBeforeEpsilonAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22C2InequalityChainAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22C2InequalityChainAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22EpsilonDefinitionAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22EpsilonDefinitionAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22EpsilonErrorConversionAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22EpsilonErrorConversionAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22HBoundToMoveLeftAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22HBoundToMoveLeftAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22EpsilonMoveLeftAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22EpsilonMoveLeftAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22EpsilonAbsorptionAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22EpsilonAbsorptionAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22FinalHBoundAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22FinalHBoundAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22LogDiffCondComparisonAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22LogDiffCondComparisonAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22FinalHToC2Available :
    corollary312DisputeFirstPassReport.iutIVCorollary22FinalHToC2Available =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22ToTheoremABoundAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22ToTheoremABoundAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVFiniteExceptionLowerBoundAvailable :
    corollary312DisputeFirstPassReport.iutIVFiniteExceptionLowerBoundAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary22FiniteExceptionTheoremAAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary22FiniteExceptionTheoremAAvailable =
      true :=
  rfl

theorem corollary312Report_iutIVCorollary23DiophantineInequalityAvailable :
    corollary312DisputeFirstPassReport.iutIVCorollary23DiophantineInequalityAvailable =
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
