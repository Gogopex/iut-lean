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

end Experiments
end Stage1
end Iut
