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
open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint
open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
open FLZModCuspLabelThetaHodgeDescentPacketTransportAudit
open FLZModCuspLabelThetaCuspClassContainerAudit
open IUTStage1ZModCuspFullLabel
open IUTStage1ProcessionNormalizedIndeterminacyCorridor
open IUTStage1ZModSquareWeightProfile
open IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation
open IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction
open IUTStage1StructuredSHEFactoredSquareFullLabelObligations
open IUTStage1HullDetPilotUpperRayLogVolume
open IUTStage1SourcePackage.IUTStage1Theorem311HullDetSourceConstructor

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

/--
First theta-root cusp-label source check.

The bad-local theta-root package of IUT I, Definition 3.1(e),(f), now feeds a
nonzero Stage 1 `|F_l|` full label through its quotient-`Z` canonical
coordinate, while retaining the canonical-generator-up-to-sign witness.
-/
theorem thetaRootCuspLabelSource_feedsFullLabel
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    (package : IUTStage1ThetaRootCuspLabelSourcePackage l X C) :
    package.canonicalGenerator.canonicalGeneratorUpToSign ∧
      package.canonicalFullLabel ≠ IUTStage1ZModCuspFullLabel.zero :=
  ⟨package.canonicalGeneratorUpToSign,
    package.canonicalFullLabel_ne_zero⟩

theorem thetaRootCuspLabelSource_zmodQuotient_feedsCanonicalFullLabel
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    (package : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (hquot : package.quotientZData = zmodBadLocalQuotientZData l) :
    package.canonicalFullLabel =
      IUTStage1ZModCuspFullLabel.nonzero
        (zmodCanonicalSignLabelQuotient l) :=
  package.canonicalFullLabel_eq_zmodCanonical_of_quotientZData_eq_zmod hquot

/--
Step (xii) local Frobenioid check: a non-automorphic `p_v^N` source action
with nonzero local step cannot be identified with the unshifted log-shell
submodule log-volume.
-/
theorem localFrobenioidSource_nonautomorphicShift_changesLogVolume
    (source : IUTStage1LocalFrobenioidPVPowerLogVolumeSource)
    (hnot : ¬ source.pPowerEndomorphismIsAutomorphism)
    (hStep : source.localPrimeStepLogVolume ≠ 0) :
    source.shiftedLogVolume ≠ source.baseSubmodule.logVolume :=
  source.shiftedLogVolume_ne_base_of_not_automorphism hnot hStep

theorem globalRealifiedCalibrationSource_rejectsNonautomorphicLocalShift
    (source : IUTStage1GlobalRealifiedFrobenioidCalibrationSource)
    (hnot : ¬ source.localSource.pPowerEndomorphismIsAutomorphism)
    (hStep : source.localSource.localPrimeStepLogVolume ≠ 0) :
    source.calibratedLogVolume ≠ source.localSource.shiftedLogVolume :=
  source.calibrated_ne_local_shifted_of_not_automorphism hnot hStep

theorem globalToLocalRealifiedFrobenioidRestriction_endpoint
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    restriction.restrictedGlobalPrimeLogVolume =
        (restriction.extensionDegree : Real)⁻¹ *
          restriction.localPrimeLogVolume ∧
      (restriction.extensionDegree : Real) *
          restriction.restrictedGlobalPrimeLogVolume =
        restriction.localPrimeLogVolume :=
  restriction.restriction_endpoint

theorem globalToLocalRealifiedFrobenioidRestrictionNaiveTensorPower_endpoint
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction)
    (tensorDegree : Nat) :
    (restriction.naiveFrobeniusTensorPower tensorDegree).extensionDegree =
        restriction.extensionDegree ∧
      (restriction.naiveFrobeniusTensorPower
          tensorDegree).restrictedGlobalPrimeLogVolume =
        (tensorDegree : Real) * restriction.restrictedGlobalPrimeLogVolume ∧
      (restriction.naiveFrobeniusTensorPower tensorDegree).localPrimeLogVolume =
        (tensorDegree : Real) * restriction.localPrimeLogVolume ∧
      ((restriction.naiveFrobeniusTensorPower tensorDegree).extensionDegree :
          Real) *
          (restriction.naiveFrobeniusTensorPower
            tensorDegree).restrictedGlobalPrimeLogVolume =
        (restriction.naiveFrobeniusTensorPower tensorDegree).localPrimeLogVolume :=
  restriction.naiveFrobeniusTensorPower_endpoint tensorDegree

theorem logLinkProductFormulaCompatibility_endpoint
    {V : Type u} [Fintype V]
    (compat : IUTStage1LogLinkProductFormulaCompatibility V) :
    (∀ v : V,
      compat.targetLocalLogVolume v = compat.sourceLocalLogVolume v ∧
        compat.targetConversionRatio v = compat.sourceConversionRatio v ∧
        compat.targetConversionRatio v * compat.targetLocalLogVolume v =
          compat.sourceConversionRatio v * compat.sourceLocalLogVolume v) ∧
      compat.targetGlobalArithmeticDegree =
        compat.sourceGlobalArithmeticDegree :=
  compat.endpoint

theorem localGlobalRealifiedFrobenioidCollection_endpoint
    {V : Type u} [Fintype V]
    (collection : IUTStage1LocalGlobalRealifiedFrobenioidCollection V) :
    (∀ v : V,
      (collection.localObject v).realifiedLogVolume =
          (collection.localization v).restrictedGlobalPrimeLogVolume ∧
        ((collection.localization v).extensionDegree : Real) *
            (collection.localObject v).realifiedLogVolume =
          collection.globalObject.realifiedLogVolume) ∧
      (∑ v : V, (collection.localObject v).realifiedLogVolume) =
        ∑ v : V, (collection.localization v).restrictedGlobalPrimeLogVolume :=
  collection.localGlobalCollection_endpoint

theorem localGlobalRealifiedFrobenioidCollectionNaiveTensorPower_endpoint
    {V : Type u} [Fintype V]
    (collection : IUTStage1LocalGlobalRealifiedFrobenioidCollection V)
    (tensorDegree : Nat)
    (globalObject :
      IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (localObject :
      V -> IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    let powered :=
      collection.naiveFrobeniusTensorPower
        tensorDegree globalObject localObject
    (∀ v : V,
      (powered.localObject v).realifiedLogVolume =
          (tensorDegree : Real) *
            (collection.localObject v).realifiedLogVolume ∧
        (powered.localization v).restrictedGlobalPrimeLogVolume =
          (tensorDegree : Real) *
            (collection.localization v).restrictedGlobalPrimeLogVolume ∧
        powered.globalObject.realifiedLogVolume =
          (tensorDegree : Real) * collection.globalObject.realifiedLogVolume ∧
        (powered.localization v).localPrimeLogVolume =
          (tensorDegree : Real) *
            (collection.localization v).localPrimeLogVolume ∧
        ((powered.localization v).extensionDegree : Real) *
            (powered.localObject v).realifiedLogVolume =
          powered.globalObject.realifiedLogVolume) ∧
      (∑ v : V, (powered.localObject v).realifiedLogVolume) =
        ∑ v : V, (powered.localization v).restrictedGlobalPrimeLogVolume :=
  collection.naiveFrobeniusTensorPower_endpoint
    tensorDegree globalObject localObject

theorem environmentGaussianLocalEvaluation_endpoint
    {V : Type u} [Fintype V]
    (comparison : IUTStage1EnvironmentGaussianLocalEvaluation V) :
    comparison.gaussianLocal.globalObject.realifiedLogVolume =
        comparison.environmentLocal.globalObject.realifiedLogVolume ∧
      ∀ v : V,
        (comparison.gaussianLocal.localization v).restrictedGlobalPrimeLogVolume =
            (comparison.environmentLocal.localization v).restrictedGlobalPrimeLogVolume ∧
          (comparison.gaussianLocal.localization v).extensionDegree =
            (comparison.environmentLocal.localization v).extensionDegree ∧
          (comparison.gaussianLocal.localObject v).realifiedLogVolume =
            (comparison.environmentLocal.localObject v).realifiedLogVolume :=
  comparison.endpoint

theorem environmentGaussianFPrimeStripEvaluation_endpoint
    {Penv Pgau V : Type u} [Fintype Penv] [Fintype Pgau] [Fintype V]
    (strip :
      IUTStage1EnvironmentGaussianFPrimeStripEvaluation Penv Pgau V) :
    strip.localEvaluation.gaussianLocal.globalObject.realifiedLogVolume =
        strip.localEvaluation.environmentLocal.globalObject.realifiedLogVolume ∧
      ∀ p : Penv,
        strip.gaussianPrimeToPlace (strip.primeEvaluation p) =
            strip.environmentPrimeToPlace p ∧
          (strip.localEvaluation.gaussianLocal.localization
              (strip.gaussianPrimeToPlace
                (strip.primeEvaluation p))).restrictedGlobalPrimeLogVolume =
            (strip.localEvaluation.environmentLocal.localization
              (strip.environmentPrimeToPlace p)).restrictedGlobalPrimeLogVolume ∧
          (strip.localEvaluation.gaussianLocal.localization
              (strip.gaussianPrimeToPlace
                (strip.primeEvaluation p))).extensionDegree =
            (strip.localEvaluation.environmentLocal.localization
              (strip.environmentPrimeToPlace p)).extensionDegree ∧
          (strip.localEvaluation.gaussianLocal.localObject
              (strip.gaussianPrimeToPlace
                (strip.primeEvaluation p))).realifiedLogVolume =
            (strip.localEvaluation.environmentLocal.localObject
              (strip.environmentPrimeToPlace p)).realifiedLogVolume :=
  strip.endpoint

theorem environmentGaussianThetaMuPrimeStripLift_endpoint
    {Penv Pgau V : Type u} {μ : Type v}
    [Fintype Penv] [Fintype Pgau] [Fintype V]
    (lift :
      IUTStage1EnvironmentGaussianThetaMuPrimeStripLift Penv Pgau V μ) :
    lift.base.localEvaluation.gaussianLocal.globalObject.realifiedLogVolume =
        lift.base.localEvaluation.environmentLocal.globalObject.realifiedLogVolume ∧
      ∀ p : Penv,
        lift.base.gaussianPrimeToPlace (lift.base.primeEvaluation p) =
            lift.base.environmentPrimeToPlace p ∧
          (lift.base.localEvaluation.gaussianLocal.localObject
              (lift.base.gaussianPrimeToPlace
                (lift.base.primeEvaluation p))).realifiedLogVolume =
            (lift.base.localEvaluation.environmentLocal.localObject
              (lift.base.environmentPrimeToPlace p)).realifiedLogVolume ∧
          lift.gaussianUnitCharacter (lift.base.primeEvaluation p) =
            lift.environmentUnitCharacter p :=
  lift.endpoint

theorem coricThetaMuPrimeStripInvariant_endpoint
    {Penv Pgau V : Type u} {μ : Type v}
    [Fintype Penv] [Fintype Pgau] [Fintype V]
    (invariant :
      IUTStage1CoricThetaMuPrimeStripInvariant Penv Pgau V μ) :
    ∀ p : Penv,
      invariant.lift.environmentUnitCharacter p =
          invariant.coricUnitCharacter
            (invariant.lift.base.environmentPrimeToPlace p) ∧
        invariant.lift.gaussianUnitCharacter
            (invariant.lift.base.primeEvaluation p) =
          invariant.coricUnitCharacter
            (invariant.lift.base.gaussianPrimeToPlace
              (invariant.lift.base.primeEvaluation p)) ∧
        invariant.lift.environmentUnitCharacter p =
          invariant.lift.gaussianUnitCharacter
            (invariant.lift.base.primeEvaluation p) :=
  invariant.endpoint

theorem coricGlobalRealifiedFrobenioidCompatibility_endpoint
    {V : Type u} [Fintype V]
    (compat : IUTStage1CoricGlobalRealifiedFrobenioidCompatibility V) :
    0 < compat.scale ∧
      compat.target.globalObject.realifiedLogVolume =
        compat.scale * compat.source.globalObject.realifiedLogVolume ∧
      ∀ v : V,
        (compat.target.localization v).restrictedGlobalPrimeLogVolume =
            compat.scale *
              (compat.source.localization v).restrictedGlobalPrimeLogVolume ∧
          (compat.target.localObject v).realifiedLogVolume =
            compat.scale * (compat.source.localObject v).realifiedLogVolume ∧
          (compat.target.localization v).localPrimeLogVolume =
            compat.scale * (compat.source.localization v).localPrimeLogVolume ∧
          ((compat.target.localization v).extensionDegree : Real) *
              (compat.scale * (compat.source.localObject v).realifiedLogVolume) =
            compat.scale * compat.source.globalObject.realifiedLogVolume :=
  compat.endpoint

theorem frobeniusPictureChain_endpoint
    (shift : Int) :
    (∀ source target : Int,
        IUTStage1FrobeniusPictureChain.edge source target ↔
          IUTStage1FrobeniusPictureChain.edge
            (IUTStage1FrobeniusPictureChain.translate shift source)
            (IUTStage1FrobeniusPictureChain.translate shift target)) ∧
      (∀ map : Int -> Int,
        map 0 = 1 ->
          map 1 = 0 ->
            ¬ ∀ source target : Int,
              IUTStage1FrobeniusPictureChain.edge source target ->
                IUTStage1FrobeniusPictureChain.edge
                  (map source) (map target)) :=
  IUTStage1FrobeniusPictureChain.endpoint shift

theorem columnLogKummerCorrespondence_endpoint
    {IQ : Type u}
    (corr : IUTStage1ColumnLogKummerCorrespondence IQ)
    (shift m : Int)
    (g : corr.groupElement m)
    (x : IQ) :
    corr.action (m + shift) (corr.translateElement shift m g) x =
        corr.action m g x ∧
      corr.action (m + 1) (corr.translateElement 1 m g) x =
        corr.action m g x ∧
      corr.action (m + (-1)) (corr.translateElement (-1) m g) x =
        corr.action m g x :=
  corr.endpoint shift m g x

theorem columnFrobenioidLogKummerCompatibility_endpoint
    (compat : IUTStage1ColumnFrobenioidLogKummerCompatibility)
    (shift m : Int) :
    (compat.frobenioidObject (m + shift)).realifiedLogVolume =
        (compat.frobenioidObject m).realifiedLogVolume ∧
      (compat.frobenioidObject (m + 1)).realifiedLogVolume =
        (compat.frobenioidObject m).realifiedLogVolume ∧
      (compat.frobenioidObject (m + (-1))).realifiedLogVolume =
        (compat.frobenioidObject m).realifiedLogVolume :=
  compat.endpoint shift m

theorem etalePictureDCore_endpoint
    {Core Spoke : Type u}
    (picture : IUTStage1EtalePictureDCore Core Spoke) :
    (∀ n : Int, picture.spokeCore (n + 1) = picture.spokeCore n) ∧
      ∀ perm : Int ≃ Int,
        ∀ n : Int,
          picture.spokeCore (perm n) = picture.core ∧
            picture.spokeCore (perm n) = picture.spokeCore n :=
  picture.endpoint

theorem localGlobalFrobenioidStructureMorphismCollection_endpoint
    {V : Type u} [Fintype V]
    (source :
      IUTStage1LocalGlobalFrobenioidStructureMorphismCollection V) :
    ∀ v : V,
      source.collection.globalObject.realifiedLogVolume =
          (source.collection.localObject v).realifiedLogVolume +
            (((source.structureMorphism v).divisorDegreeShift : Int) : Real) +
            (source.structureMorphism v).unitLogVolumeShift ∧
        (((source.structureMorphism v).divisorDegreeShift : Int) : Real) +
            (source.structureMorphism v).unitLogVolumeShift =
          (((source.collection.localization v).extensionDegree : Real) - 1) *
            (source.collection.localObject v).realifiedLogVolume :=
  source.structureMorphism_endpoint

theorem localGlobalFrobenioidStructureMorphismCollectionNaiveTensorPower_endpoint
    {V : Type u} [Fintype V]
    (source :
      IUTStage1LocalGlobalFrobenioidStructureMorphismCollection V)
    (tensorDegree : Nat)
    (globalObject :
      IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (localObject :
      V -> IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    let powered :=
      source.naiveFrobeniusTensorPower
        tensorDegree globalObject localObject
    ∀ v : V,
      (powered.structureMorphism v).divisorDegreeShift =
          (tensorDegree : Int) *
            (source.structureMorphism v).divisorDegreeShift ∧
        (powered.structureMorphism v).unitLogVolumeShift =
          (tensorDegree : Real) *
            (source.structureMorphism v).unitLogVolumeShift ∧
        powered.collection.globalObject.realifiedLogVolume =
          (powered.collection.localObject v).realifiedLogVolume +
            (((powered.structureMorphism v).divisorDegreeShift : Int) : Real) +
            (powered.structureMorphism v).unitLogVolumeShift ∧
        (((powered.structureMorphism v).divisorDegreeShift : Int) : Real) +
            (powered.structureMorphism v).unitLogVolumeShift =
          (((powered.collection.localization v).extensionDegree : Real) - 1) *
            (powered.collection.localObject v).realifiedLogVolume :=
  source.naiveFrobeniusTensorPower_endpoint
    tensorDegree globalObject localObject

theorem localGlobalFrobenioidCompatibleMorphism_endpoint
    {V : Type u} [Fintype V]
    {source target :
      IUTStage1LocalGlobalFrobenioidStructureMorphismCollection V}
    (morphism :
      IUTStage1LocalGlobalFrobenioidCompatibleMorphism source target) :
    ∀ v : V,
      target.collection.globalObject.realifiedLogVolume =
          (source.collection.localObject v).realifiedLogVolume +
            ((((morphism.localMorphism v).comp
              (target.structureMorphism v)).divisorDegreeShift : Int) : Real) +
            ((morphism.localMorphism v).comp
              (target.structureMorphism v)).unitLogVolumeShift ∧
        target.collection.globalObject.realifiedLogVolume =
          (source.collection.localObject v).realifiedLogVolume +
            ((((source.structureMorphism v).comp
              morphism.globalMorphism).divisorDegreeShift : Int) : Real) +
            ((source.structureMorphism v).comp
              morphism.globalMorphism).unitLogVolumeShift ∧
        ((((morphism.localMorphism v).comp
              (target.structureMorphism v)).divisorDegreeShift : Int) : Real) +
            ((morphism.localMorphism v).comp
              (target.structureMorphism v)).unitLogVolumeShift =
          ((((source.structureMorphism v).comp
              morphism.globalMorphism).divisorDegreeShift : Int) : Real) +
            ((source.structureMorphism v).comp
              morphism.globalMorphism).unitLogVolumeShift :=
  morphism.compatibleMorphism_endpoint

theorem localGlobalFrobenioidCompatibleMorphismNaiveTensorPower_endpoint
    {V : Type u} [Fintype V]
    {source target :
      IUTStage1LocalGlobalFrobenioidStructureMorphismCollection V}
    (morphism :
      IUTStage1LocalGlobalFrobenioidCompatibleMorphism source target)
    (tensorDegree : Nat)
    (sourceGlobalObject targetGlobalObject :
      IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (sourceLocalObject targetLocalObject :
      V -> IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    let sourcePowered :=
      source.naiveFrobeniusTensorPower
        tensorDegree sourceGlobalObject sourceLocalObject
    let targetPowered :=
      target.naiveFrobeniusTensorPower
        tensorDegree targetGlobalObject targetLocalObject
    let powered :=
      morphism.naiveFrobeniusTensorPower
        tensorDegree sourceGlobalObject targetGlobalObject
        sourceLocalObject targetLocalObject
    (powered.globalMorphism.divisorDegreeShift =
        (tensorDegree : Int) * morphism.globalMorphism.divisorDegreeShift ∧
      powered.globalMorphism.unitLogVolumeShift =
        (tensorDegree : Real) * morphism.globalMorphism.unitLogVolumeShift) ∧
      ∀ v : V,
        (powered.localMorphism v).divisorDegreeShift =
            (tensorDegree : Int) *
              (morphism.localMorphism v).divisorDegreeShift ∧
          (powered.localMorphism v).unitLogVolumeShift =
            (tensorDegree : Real) *
              (morphism.localMorphism v).unitLogVolumeShift ∧
          ((powered.localMorphism v).comp
              (targetPowered.structureMorphism v)).divisorDegreeShift =
            ((sourcePowered.structureMorphism v).comp
              powered.globalMorphism).divisorDegreeShift ∧
          ((powered.localMorphism v).comp
              (targetPowered.structureMorphism v)).unitLogVolumeShift =
            ((sourcePowered.structureMorphism v).comp
              powered.globalMorphism).unitLogVolumeShift :=
  morphism.naiveFrobeniusTensorPower_endpoint
    tensorDegree sourceGlobalObject targetGlobalObject
    sourceLocalObject targetLocalObject

theorem restrictionNormalizedLocalFrobenioidSource_endpoint
    (source : IUTStage1RestrictionNormalizedLocalFrobenioidSource) :
    source.localSource.shiftedLogVolume =
        source.localSource.baseSubmodule.logVolume +
          (source.localSource.localExponent : Real) *
            source.restriction.restrictedGlobalPrimeLogVolume ∧
      (source.restriction.extensionDegree : Real) *
          source.localSource.localPrimeStepLogVolume =
        source.restriction.localPrimeLogVolume ∧
      (source.localSource.shiftedLogVolume =
          source.localSource.baseSubmodule.logVolume ↔
        source.localSource.pPowerEndomorphismIsAutomorphism ∨
          source.restriction.restrictedGlobalPrimeLogVolume = 0) :=
  source.restrictionNormalizedLocalSource_endpoint

theorem restrictionNormalizedGlobalFrobenioidCalibration_endpoint
    (source : IUTStage1RestrictionNormalizedLocalFrobenioidSource)
    (globalExponent : Int)
    (global_exponent_eq_zero : globalExponent = 0) :
    let global :=
      source.toGlobalRealifiedFrobenioidCalibrationSource
        globalExponent global_exponent_eq_zero
    global.toGlobalFrobenioidLogVolumeCalibration.calibratedLogVolume =
        source.localSource.baseSubmodule.logVolume ∧
      global.calibratedLogVolume =
        source.localSource.baseSubmodule.logVolume ∧
      source.localSource.shiftedLogVolume =
        source.localSource.baseSubmodule.logVolume +
          (source.localSource.localExponent : Real) *
            source.restriction.restrictedGlobalPrimeLogVolume ∧
      (global.calibratedLogVolume = source.localSource.shiftedLogVolume ↔
        source.localSource.pPowerEndomorphismIsAutomorphism ∨
          source.restriction.restrictedGlobalPrimeLogVolume = 0) :=
  source.restrictionNormalizedGlobalCalibration_endpoint
    globalExponent global_exponent_eq_zero

theorem realifiedFrobenioidConstantDistribution_endpoint
    {J : Type u} [Fintype J]
    (restriction : IUTStage1GlobalToLocalRealifiedFrobenioidRestriction) :
    (IUTStage1RealifiedFrobenioidIndexDistribution.fromRestriction
        (J := J) restriction).isConstantWith
        restriction.restrictedGlobalPrimeLogVolume ∧
      (IUTStage1RealifiedFrobenioidIndexDistribution.fromRestriction
        (J := J) restriction).totalLogVolume =
        (Fintype.card J : Real) *
          restriction.restrictedGlobalPrimeLogVolume ∧
      (restriction.extensionDegree : Real) *
          (IUTStage1RealifiedFrobenioidIndexDistribution.fromRestriction
            (J := J) restriction).totalLogVolume =
        (Fintype.card J : Real) * restriction.localPrimeLogVolume :=
  IUTStage1RealifiedFrobenioidIndexDistribution.constant_distribution_endpoint
    restriction

theorem realifiedFrobenioidArbitraryDistribution_notDiagonal
    {J : Type u} [Fintype J]
    (distribution : IUTStage1RealifiedFrobenioidIndexDistribution J)
    {left right : J}
    (hneq : distribution.logVolume left ≠ distribution.logVolume right) :
    ¬ ∃ value : Real, distribution.isConstantWith value :=
  distribution.not_constantWith_of_pair_ne hneq

theorem pivotalRealifiedFrobenioidDistribution_endpoint
    {J : Type u} [Fintype J]
    (source : IUTStage1PivotalRealifiedFrobenioidDistribution J) :
    source.distribution.logVolume source.pivot = source.pivotalLogVolume ∧
      source.totalLogVolume =
        (Fintype.card J : Real) * source.pivotalLogVolume ∧
      source.averagedLogVolume = source.pivotalLogVolume ∧
      source.totalLogVolume =
        (Fintype.card J : Real) * source.averagedLogVolume :=
  source.pivotalDistribution_endpoint

theorem nfBridgeModeComparison_endpoint
    {J : Type u} [Fintype J]
    (summed averaged : IUTStage1NFBridgeRealifiedLogVolume J)
    (hsummed : summed.mode = IUTStage1NFBridgeLogVolumeMode.summed)
    (haveraged : averaged.mode = IUTStage1NFBridgeLogVolumeMode.averaged)
    (hcapsule :
      summed.capsuleDistribution = averaged.capsuleDistribution) :
    summed.targetLogVolume =
        summed.capsuleDistribution.totalLogVolume ∧
      (Fintype.card J : Real) * averaged.targetLogVolume =
        averaged.capsuleDistribution.totalLogVolume ∧
      summed.targetLogVolume =
        (Fintype.card J : Real) * averaged.targetLogVolume :=
  summed.nfBridgeModeComparison_endpoint averaged hsummed haveraged hcapsule

theorem nfBridgePivotalSummedTarget_endpoint
    {J : Type u} [Fintype J]
    (bridge : IUTStage1NFBridgeRealifiedLogVolume J)
    (pivotal : IUTStage1PivotalRealifiedFrobenioidDistribution J)
    (hmode : bridge.mode = IUTStage1NFBridgeLogVolumeMode.summed)
    (hcapsule : bridge.capsuleDistribution = pivotal.distribution) :
    bridge.targetLogVolume =
      (Fintype.card J : Real) * pivotal.pivotalLogVolume :=
  bridge.pivotal_summedTarget_eq_card_mul_pivotal pivotal hmode hcapsule

theorem nfBridgePivotalAveragedTarget_endpoint
    {J : Type u} [Fintype J]
    (bridge : IUTStage1NFBridgeRealifiedLogVolume J)
    (pivotal : IUTStage1PivotalRealifiedFrobenioidDistribution J)
    (hmode : bridge.mode = IUTStage1NFBridgeLogVolumeMode.averaged)
    (hcapsule : bridge.capsuleDistribution = pivotal.distribution) :
    bridge.targetLogVolume = pivotal.pivotalLogVolume :=
  bridge.pivotal_averagedTarget_eq_pivotal pivotal hmode hcapsule

theorem thetaNFBridgeCompatibility_endpoint
    {J : Type u} [Fintype J]
    {nfBridge : IUTStage1NFBridgeRealifiedLogVolume J}
    {thetaBridge : IUTStage1ThetaBridgeRealifiedLogVolume J}
    (compat :
      IUTStage1ThetaNFBridgeRealifiedCompatibility nfBridge thetaBridge) :
    compat.indexCompatibility.nfIndexBijection =
        compat.indexCompatibility.thetaIndexBijection ∧
      nfBridge.capsuleDistribution = thetaBridge.capsuleDistribution :=
  compat.thetaNFBridgeCompatibility_endpoint

theorem thetaNFBridgeSummedTarget_endpoint
    {J : Type u} [Fintype J]
    {nfBridge : IUTStage1NFBridgeRealifiedLogVolume J}
    {thetaBridge : IUTStage1ThetaBridgeRealifiedLogVolume J}
    (compat :
      IUTStage1ThetaNFBridgeRealifiedCompatibility nfBridge thetaBridge)
    (hmode : nfBridge.mode = IUTStage1NFBridgeLogVolumeMode.summed) :
    thetaBridge.thetaTargetLogVolume = nfBridge.targetLogVolume :=
  compat.thetaTarget_eq_nfSummedTarget hmode

theorem thetaNFBridgeAveragedTarget_endpoint
    {J : Type u} [Fintype J]
    {nfBridge : IUTStage1NFBridgeRealifiedLogVolume J}
    {thetaBridge : IUTStage1ThetaBridgeRealifiedLogVolume J}
    (compat :
      IUTStage1ThetaNFBridgeRealifiedCompatibility nfBridge thetaBridge)
    (hmode : nfBridge.mode = IUTStage1NFBridgeLogVolumeMode.averaged) :
    thetaBridge.thetaTargetLogVolume =
      (Fintype.card J : Real) * nfBridge.targetLogVolume :=
  compat.thetaTarget_eq_card_mul_nfAveragedTarget hmode

theorem thetaNFBridgeGluingTorsor_endpoint
    {l : PrimeGeFive}
    (source : IUTStage1ThetaNFBridgeGluingTorsor l)
    (t g h gluing gluing₁ gluing₂ : ZMod l.value) :
    source.gluingTranslate t gluing = zmodLabelTranslate l t gluing ∧
      source.gluingTranslate 0 gluing = gluing ∧
      source.gluingTranslate (g + h) gluing =
        source.gluingTranslate g (source.gluingTranslate h gluing) ∧
      (∃! u : ZMod l.value,
        source.gluingTranslate u gluing₁ = gluing₂) ∧
      source.compatibility.indexCompatibility.nfIndexBijection =
        source.compatibility.indexCompatibility.thetaIndexBijection ∧
      source.nfBridge.capsuleDistribution =
        source.thetaBridge.capsuleDistribution :=
  source.gluingTorsor_endpoint t g h gluing gluing₁ gluing₂

theorem thetaRootKummerForgettingSource_feedsNonarchimedeanEntry
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (source :
      NonarchimedeanThetaRootKummerForgettingSource
        audited thetaAverage logKummer l X C
        holomorphicF holomorphicD monoAnalyticD) :
    source.thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      source.entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ⟨source.thetaRootCanonicalFullLabel_ne_zero,
    source.entrySource_eq_ind3Source,
    source.packetLocalObjectFinite_le_thetaAverage⟩

theorem logKummerPacketCorrespondenceSource_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (correspondence :
      NonarchimedeanLogKummerPacketCorrespondenceSource
        audited thetaAverage logKummer entry
        holomorphicF holomorphicD monoAnalyticD)
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD) :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  correspondence.packetCorrespondence_endpoint kummer forgetting

theorem logKummerPacketCorrespondenceSource_transferChain_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (correspondence :
      NonarchimedeanLogKummerPacketCorrespondenceSource
        audited thetaAverage logKummer entry
        holomorphicF holomorphicD monoAnalyticD)
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD) :
    holomorphicD.product.productLogVolume =
        holomorphicF.product.productLogVolume ∧
      monoAnalyticD.product.productLogVolume =
        holomorphicD.product.productLogVolume ∧
      entry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.product.productLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume =
        holomorphicF.product.productLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  correspondence.packetCorrespondence_transferChain_endpoint kummer forgetting

theorem logKummerVerticalIQTargetSource_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    (source :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer entry) :
    source.frobenioidMode.hasPreciseFrobenioidIsomorphisms = true ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  source.verticalIQTarget_endpoint

theorem ind3ThetaTargetAlignmentFromStepXVerticalIQ_endpoint
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
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean)
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    (stepXAlignment : StepXPacketNormalizedThetaSourceAlignment part)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        logKummer entry) :
    targetSource.frobenioidMode.hasPreciseFrobenioidIsomorphisms = true ∧
      part.insulated_route.theta_source.thetaSourceAverage audited =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      part.insulated_route.theta_source.thetaSourceAverage audited =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  stepXVerticalIQTargetAlignment_endpoint
    stepXAlignment targetSource

theorem logKummerPacketCorrespondenceSource_ofVerticalIQTarget_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (sourceCalibration :
      NonarchimedeanLogKummerPacketSourceCalibration
        audited logKummer entry holomorphicF holomorphicD monoAnalyticD)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer entry)
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD) :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  NonarchimedeanLogKummerPacketCorrespondenceSource.ofVerticalIQTargetSource_endpoint
    sourceCalibration targetSource kummer forgetting

theorem logKummerRootUnityInvisibility_endpoint
    {l : PrimeGeFive}
    (invisibility : NonarchimedeanLogKummerRootUnityInvisibility l)
    (evaluation : GaussianMonoidDegreeEvaluation l)
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (j : ZMod l.value) :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l) invisibility.coordinateEquiv ∧
      compat.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            ((zmodUnitActionData l).smul invisibility.unit j)) =
        compat.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) ∧
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            ((zmodUnitActionData l).smul invisibility.unit j)) =
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) ∧
      ((Finset.univ.sum fun k : ZMod l.value =>
        evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            ((zmodUnitActionData l).smul invisibility.unit k))) /
          (l.value : Real)) =
        evaluation.coordinateAveragedLogVolume.averageLogVolume :=
  invisibility.rootUnityInvisibility_endpoint evaluation compat j

theorem logKummerNoFurtherIndeterminacy_endpoint
    {l : PrimeGeFive}
    (evaluation : GaussianMonoidDegreeEvaluation l)
    (henv : evaluation.environmentDegree ≠ 0)
    (a : (ZMod l.value)ˣ) (t : ZMod l.value) :
    (IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l)
        (IUTStage1ZModCuspLabelLogVolumeCompatibility.zmodUnitAffineEquiv
          l a t) ↔
      t = 0 ∧
        ∃ invisibility : NonarchimedeanLogKummerRootUnityInvisibility l,
          invisibility.unit = a) ∧
      ((∀ j : ZMod l.value,
        evaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (zmodLabelTranslate l t ((zmodUnitActionData l).smul a j))) =
          evaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) ↔
        t = 0 ∧
          ∃ invisibility : NonarchimedeanLogKummerRootUnityInvisibility l,
            invisibility.unit = a) :=
  NonarchimedeanLogKummerRootUnityInvisibility.noFurtherIndeterminacy_endpoint
    evaluation henv a t

theorem logKummerRootUnitySquareBoundary_endpoint
    {l : PrimeGeFive}
    (invisibility : NonarchimedeanLogKummerRootUnityInvisibility l) :
    IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
        (l := l) invisibility.coordinateEquiv ∧
      (IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
          (l := l) invisibility.coordinateEquiv ↔
        invisibility.unit = 1) ∧
      ((IUTStage1ZModSquareWeightProfile.CoordinateSquarePreserving
          (l := l) invisibility.coordinateEquiv ∧
        IUTStage1ZModCuspLabelLogVolumeCompatibility.FullLabelMapPreserving
          (l := l) invisibility.coordinateEquiv) ↔
        invisibility.unit = 1) :=
  invisibility.rootUnitySquareBoundary_endpoint

theorem finiteRealifiedFrobenioidDivisorSource_endpoint
    {π : Type u} [Fintype π]
    (source : IUTStage1FiniteRealifiedFrobenioidDivisorSource π) :
    source.toDegreeObject.divisorDegree =
        ∑ p : π, (source.primeMultiplicity p : Int) * source.primeDegree p ∧
      source.toDegreeObject.unitLogVolume = source.unitLogVolume ∧
      source.toDegreeObject.realifiedLogVolume =
        ((∑ p : π,
            (source.primeMultiplicity p : Int) * source.primeDegree p) : Real) +
          source.unitLogVolume :=
  source.endpoint

theorem finiteRealifiedFrobenioidDivisorTensorProduct_endpoint
    {π : Type u} [Fintype π]
    (left right : IUTStage1FiniteRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (hprime : left.primeDegree = right.primeDegree) :
    (left.tensorProduct right object).divisorDegree =
        left.divisorDegree + right.divisorDegree ∧
      (left.tensorProduct right object).realifiedLogVolume =
        left.realifiedLogVolume + right.realifiedLogVolume :=
  ⟨left.tensorProduct_divisorDegree_eq_add right object hprime,
    left.tensorProduct_realifiedLogVolume_eq_add right object hprime⟩

theorem finiteRealifiedFrobenioidNaiveTensorPower_endpoint
    {π : Type u} [Fintype π]
    (source : IUTStage1FiniteRealifiedFrobenioidDivisorSource π)
    (tensorDegree : Nat)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (source.naiveFrobeniusTensorPower tensorDegree object).divisorDegree =
        (tensorDegree : Int) * source.divisorDegree ∧
      (source.naiveFrobeniusTensorPower tensorDegree object).realifiedLogVolume =
        (tensorDegree : Real) * source.realifiedLogVolume :=
  source.naiveFrobeniusTensorPower_endpoint tensorDegree object

theorem finiteRealifiedFrobenioidDivisorTensorProductProjection_endpoint
    {π : Type u} [Fintype π]
    (left right : IUTStage1FiniteRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (hprime : left.primeDegree = right.primeDegree) :
    (left.tensorProduct right object).toDegreeObject.divisorDegree =
        (left.toDegreeObject.tensorProduct
          right.toDegreeObject object).divisorDegree ∧
      (left.tensorProduct right object).toDegreeObject.unitLogVolume =
      (left.toDegreeObject.tensorProduct
        right.toDegreeObject object).unitLogVolume ∧
      (left.tensorProduct right object).toDegreeObject.realifiedLogVolume =
        (left.toDegreeObject.tensorProduct
          right.toDegreeObject object).realifiedLogVolume :=
  left.toDegreeObject_tensorProduct_endpoint right object hprime

theorem logKummerPacketLocalSourceAlignment_ofFiniteDivisorProduct_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {product :
      IUTStage1BaseValuationTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (divisorPacket : IUTStage1FiniteDivisorTensorPacketProductSource product)
    (realization : IUTStage1TensorPacketRealizationKind)
    (theater : QualitativeData.HodgeTheaterId)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entry.sourceLogVolume)
    (packetLocalObjectFinite_eq_divisorRealified :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        divisorPacket.divisor.realifiedLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume) :
    let realified :=
      divisorPacket.toRealifiedFrobenioidTensorPacketProductSource
        realization theater;
    audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        entry.sourceLogVolume.finiteLogVolume ∧
      entry.sourceLogVolume.finiteLogVolume =
        realified.toRealized.product.productLogVolume ∧
      product.productLogVolume = divisorPacket.divisor.realifiedLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        entry.targetLogVolume.finiteLogVolume :=
  NonarchimedeanLogKummerPacketLocalSourceAlignment.ofFiniteDivisorTensorPacketProduct_endpoint
    divisorPacket realization theater packetLocalObject_eq_entrySource
    packetLocalObjectFinite_eq_divisorRealified
    packetLocalObjectFinite_eq_ind3Source

theorem finiteRealifiedFrobenioidNaiveTensorPowerProjection_endpoint
    {π : Type u} [Fintype π]
    (source : IUTStage1FiniteRealifiedFrobenioidDivisorSource π)
    (tensorDegree : Nat)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (source.naiveFrobeniusTensorPower tensorDegree object).toDegreeObject.divisorDegree =
        (source.toDegreeObject.naiveFrobeniusTensorPower
          tensorDegree object).divisorDegree ∧
      (source.naiveFrobeniusTensorPower tensorDegree object).toDegreeObject.unitLogVolume =
        (source.toDegreeObject.naiveFrobeniusTensorPower
          tensorDegree object).unitLogVolume ∧
      (source.naiveFrobeniusTensorPower tensorDegree object).toDegreeObject.realifiedLogVolume =
        (source.toDegreeObject.naiveFrobeniusTensorPower
          tensorDegree object).realifiedLogVolume :=
  source.toDegreeObject_naiveFrobeniusTensorPower_endpoint tensorDegree object

theorem thetaRealifiedFrobenioidDivisorSource_endpoint
    {π : Type u} [Fintype π]
    (source : IUTStage1ThetaRealifiedFrobenioidDivisorSource π)
    (htheta : source.thetaGeneratorLogVolume = 1) :
    source.thetaDivisorLogVolume =
        (source.base.divisorDegree : Real) * source.thetaGeneratorLogVolume +
          source.base.unitLogVolume ∧
      source.thetaDivisorLogVolume = source.base.realifiedLogVolume :=
  source.endpoint htheta

theorem thetaRealifiedFrobenioidDivisorTensorProduct_endpoint
    {π : Type u} [Fintype π]
    (left right : IUTStage1ThetaRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (hprime : left.base.primeDegree = right.base.primeDegree)
    (htheta :
      left.thetaGeneratorLogVolume = right.thetaGeneratorLogVolume) :
    (left.tensorProduct right object).thetaDivisorLogVolume =
      left.thetaDivisorLogVolume + right.thetaDivisorLogVolume :=
  left.tensorProduct_thetaDivisorLogVolume_eq_add right object hprime htheta

theorem thetaRealifiedFrobenioidNaiveTensorPower_endpoint
    {π : Type u} [Fintype π]
    (source : IUTStage1ThetaRealifiedFrobenioidDivisorSource π)
    (tensorDegree : Nat)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (source.naiveFrobeniusTensorPower tensorDegree object).thetaDivisorLogVolume =
      (tensorDegree : Real) * source.thetaDivisorLogVolume :=
  source.naiveFrobeniusTensorPower_endpoint tensorDegree object

theorem logShellRealifiedFrobenioidDivisorSource_endpoint
    {π : Type u} [Fintype π]
    (source : IUTStage1LogShellRealifiedFrobenioidDivisorSource π)
    (hnorm : source.normalizedFrobeniusLogVolume = 1) :
    source.normalizedFrobeniusLogVolume =
        source.localFrobeniusLogVolume / (source.extensionDegree : Real) ∧
      source.logShellDivisorLogVolume =
        (source.base.divisorDegree : Real) *
          source.normalizedFrobeniusLogVolume +
          source.base.unitLogVolume ∧
      source.logShellDivisorLogVolume = source.base.realifiedLogVolume :=
  source.endpoint hnorm

theorem logShellRealifiedFrobenioidDivisorTensorProduct_endpoint
    {π : Type u} [Fintype π]
    (left right : IUTStage1LogShellRealifiedFrobenioidDivisorSource π)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean)
    (hprime : left.base.primeDegree = right.base.primeDegree)
    (hnorm :
      left.normalizedFrobeniusLogVolume =
        right.normalizedFrobeniusLogVolume) :
    (left.tensorProduct right object).logShellDivisorLogVolume =
      left.logShellDivisorLogVolume + right.logShellDivisorLogVolume :=
  left.tensorProduct_logShellDivisorLogVolume_eq_add right object hprime hnorm

theorem logShellRealifiedFrobenioidNaiveTensorPower_endpoint
    {π : Type u} [Fintype π]
    (source : IUTStage1LogShellRealifiedFrobenioidDivisorSource π)
    (tensorDegree : Nat)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (source.naiveFrobeniusTensorPower tensorDegree object).normalizedFrobeniusLogVolume =
        source.normalizedFrobeniusLogVolume ∧
      (source.naiveFrobeniusTensorPower tensorDegree object).logShellDivisorLogVolume =
        (tensorDegree : Real) * source.logShellDivisorLogVolume :=
  source.naiveFrobeniusTensorPower_endpoint tensorDegree object

theorem compatibleRealifiedFrobenioidDivisorCopies_endpoint
    {π : Type u} [Fintype π]
    (copies : IUTStage1CompatibleRealifiedFrobenioidDivisorCopies π) :
    copies.theta.base = copies.ordinary ∧
      copies.logShell.base = copies.ordinary ∧
      copies.theta.thetaDivisorLogVolume =
        copies.ordinary.realifiedLogVolume ∧
      copies.logShell.logShellDivisorLogVolume =
        copies.ordinary.realifiedLogVolume ∧
      copies.theta.thetaDivisorLogVolume =
        copies.logShell.logShellDivisorLogVolume :=
  copies.endpoint

theorem compatibleRealifiedFrobenioidNaiveTensorPower_endpoint
    {π : Type u} [Fintype π]
    (copies : IUTStage1CompatibleRealifiedFrobenioidDivisorCopies π)
    (tensorDegree : Nat)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (copies.naiveFrobeniusTensorPower tensorDegree object).theta.base =
        (copies.naiveFrobeniusTensorPower tensorDegree object).ordinary ∧
      (copies.naiveFrobeniusTensorPower tensorDegree object).logShell.base =
        (copies.naiveFrobeniusTensorPower tensorDegree object).ordinary ∧
      (copies.naiveFrobeniusTensorPower tensorDegree object).theta.thetaGeneratorLogVolume =
        1 ∧
      (copies.naiveFrobeniusTensorPower tensorDegree object).logShell.normalizedFrobeniusLogVolume =
        1 ∧
      (copies.naiveFrobeniusTensorPower tensorDegree object).ordinary.realifiedLogVolume =
        (tensorDegree : Real) * copies.ordinary.realifiedLogVolume ∧
      (copies.naiveFrobeniusTensorPower tensorDegree object).theta.thetaDivisorLogVolume =
        (tensorDegree : Real) * copies.theta.thetaDivisorLogVolume ∧
      (copies.naiveFrobeniusTensorPower tensorDegree object).logShell.logShellDivisorLogVolume =
        (tensorDegree : Real) * copies.logShell.logShellDivisorLogVolume :=
  copies.naiveFrobeniusTensorPower_endpoint tensorDegree object

theorem environmentGaussianRealifiedFrobenioidEvaluation_endpoint
    {π : Type u} [Fintype π]
    (evaluation :
      IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation π) :
    evaluation.gaussian.ordinary = evaluation.environment.ordinary ∧
      evaluation.gaussian.ordinary.realifiedLogVolume =
        evaluation.environment.ordinary.realifiedLogVolume ∧
      evaluation.gaussian.theta.thetaDivisorLogVolume =
        evaluation.environment.ordinary.realifiedLogVolume ∧
      evaluation.gaussian.logShell.logShellDivisorLogVolume =
        evaluation.environment.ordinary.realifiedLogVolume ∧
      evaluation.environment.theta.thetaDivisorLogVolume =
        evaluation.gaussian.theta.thetaDivisorLogVolume ∧
      evaluation.environment.logShell.logShellDivisorLogVolume =
        evaluation.gaussian.logShell.logShellDivisorLogVolume :=
  evaluation.endpoint

theorem environmentGaussianRealifiedFrobenioidNaiveTensorPower_endpoint
    {π : Type u} [Fintype π]
    (evaluation :
      IUTStage1EnvironmentGaussianRealifiedFrobenioidEvaluation π)
    (tensorDegree : Nat)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    let powered := evaluation.naiveFrobeniusTensorPower tensorDegree object
    powered.gaussian.ordinary = powered.environment.ordinary ∧
      powered.environment.theta.thetaDivisorLogVolume =
        powered.gaussian.theta.thetaDivisorLogVolume ∧
      powered.environment.logShell.logShellDivisorLogVolume =
        powered.gaussian.logShell.logShellDivisorLogVolume ∧
      powered.environment.ordinary.realifiedLogVolume =
        (tensorDegree : Real) * evaluation.environment.ordinary.realifiedLogVolume ∧
      powered.gaussian.ordinary.realifiedLogVolume =
        (tensorDegree : Real) * evaluation.gaussian.ordinary.realifiedLogVolume :=
  evaluation.naiveFrobeniusTensorPower_endpoint tensorDegree object

theorem finiteDivisorTensorPacketProductSource_endpoint
    {kind : IUTStage1PlaceKind} {j : Nat}
    {product : IUTStage1BaseValuationTensorPacketProductLogVolume kind j}
    (source :
      IUTStage1FiniteDivisorTensorPacketProductSource product)
    (realization : IUTStage1TensorPacketRealizationKind)
    (theater : QualitativeData.HodgeTheaterId) :
    let realified :=
      source.toRealifiedFrobenioidTensorPacketProductSource realization theater
    realified.product.productLogVolume =
        source.divisor.realifiedLogVolume ∧
      realified.frobenioidDegree =
        source.divisor.toDegreeObject ∧
      realified.toRealized.product = product :=
  source.toRealifiedFrobenioidTensorPacketProductSource_endpoint
    realization theater

theorem realifiedFrobenioidKummerCompatibility_endpoint
    {kind : IUTStage1PlaceKind} {j : Nat}
    {source target :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource kind j}
    (compat :
      IUTStage1RealifiedFrobenioidKummerCompatibility source target) :
    target.toRealized.product.productLogVolume =
        source.toRealized.product.productLogVolume ∧
      source.toRealized.theater.side ≠ target.toRealized.theater.side :=
  compat.frobenioidKummerCompatibility_endpoint

theorem realifiedFrobenioidTensorProduct_endpoint
    (source target : IUTStage1RealifiedFrobenioidDegreeObject)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (source.tensorProduct target object).divisorDegree =
        source.divisorDegree + target.divisorDegree ∧
      (source.tensorProduct target object).unitLogVolume =
        source.unitLogVolume + target.unitLogVolume ∧
      (source.tensorProduct target object).realifiedLogVolume =
        source.realifiedLogVolume + target.realifiedLogVolume :=
  source.tensorProduct_endpoint target object

theorem realifiedFrobenioidNaiveTensorPower_endpoint
    (source : IUTStage1RealifiedFrobenioidDegreeObject)
    (tensorDegree : Nat)
    (object : IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (source.naiveFrobeniusTensorPower tensorDegree object).divisorDegree =
        (tensorDegree : Int) * source.divisorDegree ∧
      (source.naiveFrobeniusTensorPower tensorDegree object).unitLogVolume =
        (tensorDegree : Real) * source.unitLogVolume ∧
      (source.naiveFrobeniusTensorPower tensorDegree object).realifiedLogVolume =
        (tensorDegree : Real) * source.realifiedLogVolume :=
  source.naiveFrobeniusTensorPower_endpoint tensorDegree object

theorem realifiedFrobenioidDegreeMorphism_identity_endpoint
    (source : IUTStage1RealifiedFrobenioidDegreeObject) :
    (IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism.identity
        source).divisorDegreeShift = 0 ∧
      (IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism.identity
        source).unitLogVolumeShift = 0 ∧
      source.realifiedLogVolume =
        source.realifiedLogVolume +
          (((IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism.identity
            source).divisorDegreeShift : Int) : Real) +
          (IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism.identity
            source).unitLogVolumeShift :=
  IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism.identity_endpoint
    source

theorem realifiedFrobenioidDegreeMorphism_comp_endpoint
    {source middle final : IUTStage1RealifiedFrobenioidDegreeObject}
    (first :
      IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism source middle)
    (second :
      IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism middle final) :
    (first.comp second).divisorDegreeShift =
        first.divisorDegreeShift + second.divisorDegreeShift ∧
      (first.comp second).unitLogVolumeShift =
        first.unitLogVolumeShift + second.unitLogVolumeShift ∧
      final.realifiedLogVolume =
        source.realifiedLogVolume +
          (((first.comp second).divisorDegreeShift : Int) : Real) +
          (first.comp second).unitLogVolumeShift :=
  first.comp_endpoint second

theorem realifiedFrobenioidDegreeMorphismNaiveTensorPower_endpoint
    {source target : IUTStage1RealifiedFrobenioidDegreeObject}
    (morphism :
      IUTStage1RealifiedFrobenioidDegreeObject.DegreeMorphism source target)
    (tensorDegree : Nat)
    (sourceObject targetObject :
      IUTStage1LocalObjectId IUTStage1PlaceKind.nonarchimedean) :
    (morphism.naiveFrobeniusTensorPower
        tensorDegree sourceObject targetObject).divisorDegreeShift =
        (tensorDegree : Int) * morphism.divisorDegreeShift ∧
      (morphism.naiveFrobeniusTensorPower
        tensorDegree sourceObject targetObject).unitLogVolumeShift =
        (tensorDegree : Real) * morphism.unitLogVolumeShift ∧
      (target.naiveFrobeniusTensorPower
          tensorDegree targetObject).realifiedLogVolume =
        (source.naiveFrobeniusTensorPower
            tensorDegree sourceObject).realifiedLogVolume +
          ((((morphism.naiveFrobeniusTensorPower
              tensorDegree sourceObject targetObject).divisorDegreeShift :
              Int) : Real)) +
          (morphism.naiveFrobeniusTensorPower
            tensorDegree sourceObject targetObject).unitLogVolumeShift :=
  morphism.naiveFrobeniusTensorPower_endpoint
    tensorDegree sourceObject targetObject

theorem realifiedFrobenioidTensorProductPacket_endpoint
    {kind : IUTStage1PlaceKind} {j : Nat}
    {left right product :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource kind j}
    (source :
      IUTStage1RealifiedFrobenioidTensorProductPacketSource
        left right product) :
    product.frobenioidDegree.realifiedLogVolume =
        left.frobenioidDegree.realifiedLogVolume +
          right.frobenioidDegree.realifiedLogVolume ∧
      product.toRealized.product.productLogVolume =
        left.toRealized.product.productLogVolume +
        right.toRealized.product.productLogVolume :=
  source.tensorProductPacket_endpoint

theorem hullLogVolumeApproximant_endpoint
    {α : Type u}
    {data : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (approximant :
      IUTStage1HullLogVolumeApproximant data region) :
    approximant.approximant ⊆ data.hullRegion region ∧
      data.logVolume region <= data.logVolume approximant.approximant ∧
      data.logVolume approximant.approximant <=
        data.logVolume (data.hullRegion region) ∧
      data.hullRegion approximant.approximant = approximant.approximant :=
  approximant.endpoint

theorem exactHullLogVolumeApproximant_endpoint
    {α : Type u}
    {data : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (exact : IUTStage1ExactHullLogVolumeApproximant data region) :
    exact.approximant.approximant ⊆ data.hullRegion region ∧
      data.logVolume exact.approximant.approximant =
        data.logVolume region ∧
      data.logVolume region =
        data.logVolume exact.approximant.approximant ∧
      data.logVolume exact.approximant.approximant <=
        data.logVolume (data.hullRegion region) ∧
      data.hullRegion exact.approximant.approximant =
        exact.approximant.approximant :=
  exact.endpoint

theorem exactHullLogVolumeApproximantCanonicalClosed_endpoint
    {α : Type u}
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    (region : Set α)
    (hclosed : data.hull.IsClosed region) :
    let exact :=
      IUTStage1ExactHullLogVolumeApproximant.canonicalOfClosed
        data region hclosed;
    exact.approximant.approximant = data.hullRegion region ∧
      data.hullRegion region = region ∧
      data.logVolume exact.approximant.approximant =
        data.logVolume region :=
  IUTStage1ExactHullLogVolumeApproximant.canonicalOfClosed_endpoint
    data region hclosed

theorem hullLogVolumeApproximantFamily_endpoint
    {α : Type u} {κ : Type v}
    {data : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (family :
      IUTStage1HullLogVolumeApproximantFamily data region κ) :
    family.familyUnion ⊆ data.hullRegion region ∧
      data.hullRegion region ⊆ family.familyUnion ∧
      family.familyUnion = data.hullRegion region ∧
      data.logVolume family.familyUnion =
        data.logVolume (data.hullRegion region) :=
  family.endpoint

theorem exactHullLogVolumeApproximantFamily_endpoint
    {α : Type u} {κ : Type v}
    {data : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (family :
      IUTStage1ExactHullLogVolumeApproximantFamily data region κ)
    (k : κ) :
    family.familyUnion ⊆ data.hullRegion region ∧
      data.hullRegion region ⊆ family.familyUnion ∧
      family.familyUnion = data.hullRegion region ∧
      data.logVolume
          ((family.exactApproximant k).approximant).approximant =
        data.logVolume region ∧
      data.logVolume family.familyUnion =
        data.logVolume (data.hullRegion region) :=
  family.endpoint k

theorem holomorphicHullMapLaws_endpoint
    {α : Type u}
    (data : IUTStage1HolomorphicHullLogVolumeShadow α)
    {closedHull region region₁ region₂ : Set α}
    (hclosed : data.hull.IsClosed closedHull)
    (hsubset : region₁ ⊆ region₂) :
    data.hullRegion closedHull = closedHull ∧
      region ⊆ data.hullRegion region ∧
      data.hullRegion region₁ ⊆ data.hullRegion region₂ ∧
      data.hullRegion (data.hullRegion region) = data.hullRegion region :=
  data.remark395_hullMap_laws hclosed hsubset

theorem holomorphicHullShadowRegionBridge_endpoint
    {line : Copy}
    (data : IUTStage1HolomorphicHullLogVolumeShadow (Point line))
    (region : Region line) :
    ((data.toRegionHullOperator).hull region).toSet =
        data.hullRegion region.toSet ∧
      Region.Subset region ((data.toRegionHullOperator).hull region) ∧
      data.toRegionMeasure.volume region <=
        data.toRegionMeasure.volume ((data.toRegionHullOperator).hull region) :=
  data.toRegionHullOperator_endpoint region

theorem hullApproximantUpperRay_qPilot_le_theta
    {α : Type u}
    {hullData : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (approximant : IUTStage1HullLogVolumeApproximant hullData region)
    (qRegion : Set α)
    (q_subset_approximant : qRegion ⊆ approximant.approximant)
    (determinant : IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (approximant_eq_normalized_determinant :
      hullData.logVolume approximant.approximant =
        determinant.normalizedLogVolume) :
    (IUTStage1HullDetPilotUpperRayLogVolume.ofHullApproximant
      approximant qRegion q_subset_approximant determinant
      approximant_eq_normalized_determinant).qPilotLogVolume <=
      (IUTStage1HullDetPilotUpperRayLogVolume.ofHullApproximant
        approximant qRegion q_subset_approximant determinant
        approximant_eq_normalized_determinant).thetaHullLogVolume :=
  ofHullApproximant_qPilotLogVolume_le_thetaHullLogVolume
    approximant qRegion q_subset_approximant determinant
    approximant_eq_normalized_determinant

theorem hullApproximantUpperRay_endpoint
    {α : Type u}
    {hullData : IUTStage1HolomorphicHullLogVolumeShadow α}
    {region : Set α}
    (approximant : IUTStage1HullLogVolumeApproximant hullData region)
    (qRegion : Set α)
    (q_subset_approximant : qRegion ⊆ approximant.approximant)
    (determinant : IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (approximant_eq_normalized_determinant :
      hullData.logVolume approximant.approximant =
        determinant.normalizedLogVolume) :
    let upperRay :=
      IUTStage1HullDetPilotUpperRayLogVolume.ofHullApproximant
        approximant qRegion q_subset_approximant determinant
        approximant_eq_normalized_determinant;
    upperRay.qPilotLogVolume <= upperRay.thetaHullLogVolume ∧
      upperRay.thetaHullLogVolume <=
        hullData.logVolume (hullData.hullRegion region) ∧
      upperRay.qPilotLogVolume <=
        hullData.logVolume (hullData.hullRegion region) ∧
      upperRay.qPilotLogVolume <= determinant.determinantLogVolume :=
  by
    intro upperRay
    have hq_theta :
        upperRay.qPilotLogVolume <= upperRay.thetaHullLogVolume :=
      ofHullApproximant_qPilotLogVolume_le_thetaHullLogVolume
        approximant qRegion q_subset_approximant determinant
        approximant_eq_normalized_determinant
    have htheta_hull :
        upperRay.thetaHullLogVolume <=
          hullData.logVolume (hullData.hullRegion region) :=
      ofHullApproximant_thetaHullLogVolume_le_canonicalHull
        approximant qRegion q_subset_approximant determinant
        approximant_eq_normalized_determinant
    have hq_hull :
        upperRay.qPilotLogVolume <=
          hullData.logVolume (hullData.hullRegion region) :=
      ofHullApproximant_qPilotLogVolume_le_canonicalHull
        approximant qRegion q_subset_approximant determinant
        approximant_eq_normalized_determinant
    exact
      ⟨hq_theta, htheta_hull, hq_hull,
        upperRay.qPilotLogVolume_le_determinant⟩

theorem thetaPossibleImagesHullApproximant_endpoint
    {α : Type u} {ι : Type v}
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι) :
    data.thetaImageUnionLogVolume <= data.approximantLogVolume ∧
      data.approximantLogVolume <= data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= data.approximantLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaImageUnionLogVolume <=
        data.determinant.determinantLogVolume ∧
      data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume ∈
        data.toHullDetPilotUpperRayLogVolume.upperRay ∧
      data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume <=
        data.determinant.determinantLogVolume :=
  data.endpoint

theorem thetaPossibleImagesHullContainment_endpoint
    {α : Type u} {ι : Type v}
    (data : IUTStage1ThetaPossibleImagesHullLogVolumeShadow α ι)
    (i : ι) :
    data.thetaImageUnion ⊆ data.thetaHull ∧
      data.possibleThetaImage i ⊆ data.thetaHull ∧
      data.qPilotRegion ⊆ data.thetaHull ∧
      data.hullData.hullRegion data.thetaHull = data.thetaHull :=
  data.thetaHullContainment_endpoint i

theorem thetaPossibleImagesHullFromQSubsetUnion_endpoint
    {α : Type u} {ι : Type v}
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (q_subset_thetaImageUnion :
      qPilotRegion ⊆ ⋃ i, possibleThetaImage i)
    (theta_hull_eq_normalized_determinant :
      hullData.logVolume
          (hullData.hullRegion (⋃ i, possibleThetaImage i)) =
        determinant.normalizedLogVolume) :
    let data :=
      IUTStage1ThetaPossibleImagesHullLogVolumeShadow.ofQSubsetThetaImageUnion
        hullData possibleThetaImage qPilotRegion determinant
        q_subset_thetaImageUnion
        theta_hull_eq_normalized_determinant;
    data.qPilotRegion ⊆ data.thetaImageUnion ∧
      data.qPilotRegion ⊆ data.thetaHull ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaHullLogVolume = determinant.normalizedLogVolume :=
  IUTStage1ThetaPossibleImagesHullLogVolumeShadow.ofQSubsetThetaImageUnion_endpoint
    hullData possibleThetaImage qPilotRegion determinant
    q_subset_thetaImageUnion theta_hull_eq_normalized_determinant

theorem thetaPossibleImagesHullApproximantContainment_endpoint
    {α : Type u} {ι : Type v}
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι)
    (i : ι) :
    data.thetaImageUnion ⊆ data.thetaHull ∧
      data.possibleThetaImage i ⊆ data.thetaHull ∧
      data.approximantRegion ⊆ data.thetaHull ∧
      data.qPilotRegion ⊆ data.thetaHull ∧
      data.hullData.hullRegion data.thetaHull = data.thetaHull :=
  data.thetaHullContainment_endpoint i

theorem sourceHullDetDataFromUnionSubset_endpoint
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hull : Region target)
    (hsubset :
      Region.Subset package.preLedger.output.comparisons.targetUnion hull)
    (hvolume :
      RegionMeasure.HasVolumeAtMost package.preLedger.measure hull
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        ((RealLineCopy.AlgorithmicOutput.StructuredHullDetBridgeData.ofUnionSubset
            (output := package.preLedger.output)
            (measure := package.preLedger.measure)
            (bound := package.preLedger.thetaSigned)
            operation hullOperation determinantOperation hull hsubset hvolume)
          |>.toHullDetHullBridgeData).toHullDetBridgeData) :
    let data :=
      IUTStage1SourceHullDetData.ofUnionSubset (package := package)
        operation hullOperation determinantOperation hull hsubset hvolume hbridge;
    Region.Subset package.preLedger.output.comparisons.targetUnion
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull package.preLedger.thetaSigned ∧
      RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
        package.preLedger.output.comparisons package.preLedger.thetaSigned ∧
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        data.sourceData.structuredHullDet.toHullDetHullBridgeData.toHullDetBridgeData :=
  IUTStage1SourceHullDetData.ofUnionSubset_endpoint
    operation hullOperation determinantOperation hull hsubset hvolume hbridge

theorem sourceHullDetDataFromUnionHull_endpoint
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (operator : HullOperator target)
    (hvolume :
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (operator.hull package.preLedger.output.comparisons.targetUnion)
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        ((RealLineCopy.AlgorithmicOutput.StructuredHullDetBridgeData.ofUnionHull
            (output := package.preLedger.output)
            (measure := package.preLedger.measure)
            (bound := package.preLedger.thetaSigned)
            operation hullOperation determinantOperation operator hvolume)
          |>.toHullDetHullBridgeData).toHullDetBridgeData) :
    let data :=
      IUTStage1SourceHullDetData.ofUnionHull (package := package)
        operation hullOperation determinantOperation operator hvolume hbridge;
    (data.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull =
        operator.hull package.preLedger.output.comparisons.targetUnion ∧
      Region.Subset package.preLedger.output.comparisons.targetUnion
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull package.preLedger.thetaSigned ∧
      RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
        package.preLedger.output.comparisons package.preLedger.thetaSigned ∧
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        data.sourceData.structuredHullDet.toHullDetHullBridgeData.toHullDetBridgeData :=
  IUTStage1SourceHullDetData.ofUnionHull_endpoint
    operation hullOperation determinantOperation operator hvolume hbridge

theorem sourceHullDetDataFromHolomorphicHullShadow_endpoint
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (measure_eq_hullLogVolume :
      package.preLedger.measure = hullData.toRegionMeasure)
    (determinant_bound :
      hullData.logVolume
          (hullData.hullRegion
            package.preLedger.output.comparisons.targetUnion.toSet) <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        IUTStage1SourceHullDetData.holomorphicHullShadowHullDetBridgeData
          (package := package)
          operation hullOperation determinantOperation hullData
          measure_eq_hullLogVolume determinant_bound) :
    let data :=
      IUTStage1SourceHullDetData.ofHolomorphicHullShadow (package := package)
        operation hullOperation determinantOperation hullData
        measure_eq_hullLogVolume determinant_bound hbridge;
    (data.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull.toSet =
        hullData.hullRegion
          package.preLedger.output.comparisons.targetUnion.toSet ∧
      Region.Subset package.preLedger.output.comparisons.targetUnion
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull package.preLedger.thetaSigned ∧
      RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
        package.preLedger.output.comparisons package.preLedger.thetaSigned ∧
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        data.sourceData.structuredHullDet.toHullDetHullBridgeData.toHullDetBridgeData :=
  IUTStage1SourceHullDetData.ofHolomorphicHullShadow_endpoint
    operation hullOperation determinantOperation hullData
    measure_eq_hullLogVolume determinant_bound hbridge

theorem sourceHullDetDataFromCanonicalApproximant_endpoint
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (approximantSource :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow
        (Point target) index)
    (theta_union_eq_targetUnion :
      approximantSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet)
    (approximant_eq_canonical_hull :
      approximantSource.approximantRegion =
        approximantSource.thetaHull)
    (measure_eq_hullLogVolume :
      package.preLedger.measure =
        approximantSource.hullData.toRegionMeasure)
    (determinant_bound :
      approximantSource.determinant.normalizedLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        IUTStage1SourceHullDetData.canonicalApproximantHullDetBridgeData
          (package := package)
          operation hullOperation determinantOperation approximantSource
          theta_union_eq_targetUnion approximant_eq_canonical_hull
          measure_eq_hullLogVolume determinant_bound) :
    let data :=
      IUTStage1SourceHullDetData.ofCanonicalApproximant (package := package)
        operation hullOperation determinantOperation approximantSource
        theta_union_eq_targetUnion approximant_eq_canonical_hull
        measure_eq_hullLogVolume determinant_bound hbridge;
    (data.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull.toSet =
        approximantSource.hullData.hullRegion
          package.preLedger.output.comparisons.targetUnion.toSet ∧
      approximantSource.approximantLogVolume =
        approximantSource.determinant.normalizedLogVolume ∧
      Region.Subset package.preLedger.output.comparisons.targetUnion
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull package.preLedger.thetaSigned ∧
      RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
        package.preLedger.output.comparisons package.preLedger.thetaSigned ∧
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        data.sourceData.structuredHullDet.toHullDetHullBridgeData.toHullDetBridgeData :=
  IUTStage1SourceHullDetData.ofCanonicalApproximant_endpoint
    operation hullOperation determinantOperation approximantSource
    theta_union_eq_targetUnion approximant_eq_canonical_hull
    measure_eq_hullLogVolume determinant_bound hbridge

theorem weightedDeterminantSource_endpoint
    {β : Type u} [Fintype β]
    (data : IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    data.determinantLogVolume =
        (Finset.univ.sum fun index =>
          (data.summand index).adjustedLogVolume) ∧
      data.tensorPowerLogVolume =
        (data.positiveTensorPower : Real) * data.determinantLogVolume ∧
      data.normalizedLogVolume = data.determinantLogVolume ∧
      data.toDeterminantLogVolume.determinantLogVolume =
        data.determinantLogVolume ∧
      data.toDeterminantLogVolume.normalizedLogVolume =
        data.determinantLogVolume :=
  data.endpoint

theorem localizationSource_endpoint
    {γ : Type u} [Fintype γ]
    (data : IUTStage1ArithmeticVectorBundleLocalizationSource γ) :
    data.rank = Fintype.card γ ∧
      1 < data.rank ∧
      data.bundleLogVolume =
        Finset.univ.sum data.directSummandLogVolume ∧
      data.adjustedLogVolume =
        (data.weight : Real) *
          (data.bundleLogVolume - data.structureSheafLogVolume) :=
  data.endpoint

theorem structureSheafAdjustedLocalizationSource_endpoint
    {γ : Type u} [Fintype γ]
    (data : IUTStage1StructureSheafAdjustedLocalizationSource γ) :
    data.toLocalizationSource.bundleLogVolume =
        Finset.univ.sum data.directSummandLogVolume ∧
      data.adjustedRawLogVolume =
        data.toLocalizationSource.bundleLogVolume -
          data.structureSheafLogVolume ∧
      data.toLocalizationSource.adjustedLogVolume =
        data.weightedAdjustedLogVolume :=
  data.endpoint

theorem weightedDeterminantFromLocalizationSources_endpoint
    {β : Type u} [Fintype β] {γ : Type v} [Fintype γ]
    (source : β -> IUTStage1ArithmeticVectorBundleLocalizationSource γ)
    (anchor : β)
    (positiveTensorPower : Nat)
    (tensor_power_pos : 0 < positiveTensorPower) :
    let data : IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β :=
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource.ofLocalizationSources
        source anchor positiveTensorPower tensor_power_pos;
    data.determinantLogVolume =
        (Finset.univ.sum fun index =>
          (source index).adjustedLogVolume) ∧
      data.tensorPowerLogVolume =
        (positiveTensorPower : Real) * data.determinantLogVolume ∧
      data.normalizedLogVolume = data.determinantLogVolume :=
  IUTStage1ArithmeticVectorBundleWeightedDeterminantSource.ofLocalizationSources_endpoint
    source anchor positiveTensorPower tensor_power_pos

theorem weightedDeterminantFromAdjustedLocalizationSources_endpoint
    {β : Type u} [Fintype β] {γ : Type v} [Fintype γ]
    (source : β -> IUTStage1StructureSheafAdjustedLocalizationSource γ)
    (anchor : β)
    (positiveTensorPower : Nat)
    (tensor_power_pos : 0 < positiveTensorPower) :
    let data : IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β :=
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource.ofAdjustedLocalizationSources
        source anchor positiveTensorPower tensor_power_pos;
    data.determinantLogVolume =
        (Finset.univ.sum fun index =>
          (source index).weightedAdjustedLogVolume) ∧
      data.tensorPowerLogVolume =
        (positiveTensorPower : Real) * data.determinantLogVolume ∧
      data.normalizedLogVolume = data.determinantLogVolume :=
  IUTStage1ArithmeticVectorBundleWeightedDeterminantSource.ofAdjustedLocalizationSources_endpoint
    source anchor positiveTensorPower tensor_power_pos

theorem naiveFrobeniusTensorPowerLogVolume_endpoint
    (data : IUTStage1NaiveFrobeniusTensorPowerLogVolume) :
    data.tensorPowerLogVolume =
        (data.tensorDegree : Real) * data.baseLogVolume ∧
      data.normalizedLogVolume = data.baseLogVolume :=
  data.endpoint

theorem weightedDeterminant_tensorPower_endpoint
    {β : Type u} [Fintype β]
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β) :
    let tensorPower :=
      IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
        determinantSource;
    tensorPower.tensorPowerLogVolume =
        (tensorPower.tensorDegree : Real) *
          determinantSource.determinantLogVolume ∧
      tensorPower.normalizedLogVolume =
        determinantSource.determinantLogVolume :=
  by
    intro tensorPower
    exact
      ⟨tensorPower.tensor_power_eq,
        tensorPower.normalizedLogVolume_eq_base⟩

theorem tensorPowerPresentationComparison_endpoint
    (data : IUTStage1TensorPowerPresentationComparison) :
    data.source.baseLogVolume = data.target.baseLogVolume ∧
      data.source.normalizedLogVolume =
        data.source.baseLogVolume ∧
      data.target.normalizedLogVolume =
        data.target.baseLogVolume ∧
      data.source.normalizedLogVolume =
        data.target.normalizedLogVolume :=
  data.endpoint

theorem boundedFamilyHullDetLogVolume_endpoint
    {α : Type u} {ι : Type v} {β : Type w} [Fintype β]
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β)
    (i j : ι)
    (hnei : (data.possibleRegion i).Nonempty)
    (hnej : (data.possibleRegion j).Nonempty) :
    data.possibleRegion i ⊆ data.familyHull ∧
      data.possibleRegion j ⊆ data.familyHull ∧
      data.quotientMap '' data.possibleRegion i =
        data.quotientMap '' data.possibleRegion j ∧
      data.familyHullLogVolume =
        data.determinantSource.determinantLogVolume ∧
      data.familyUnionLogVolume <=
        data.determinantSource.determinantLogVolume ∧
      data.tensorPower.normalizedLogVolume =
        data.familyHullLogVolume ∧
      data.tensorPower.tensorPowerLogVolume =
        (data.tensorPower.tensorDegree : Real) * data.familyHullLogVolume :=
  data.endpoint i j hnei hnej

theorem boundedFamilyHullDetLogVolumeOb5_endpoint
    {α : Type u} {ι : Type v} {β : Type w} [Fintype β]
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β)
    {A B : Set α}
    (hneA : A.Nonempty)
    (hneB : B.Nonempty) :
    (data.quotientMap '' A =
          {IUTStage1UpperSemiSetQuotient.collapsed} ∧
        data.quotientMap '' B =
          {IUTStage1UpperSemiSetQuotient.collapsed} ↔
      A ⊆ data.familyHull ∧ B ⊆ data.familyHull) ∧
      data.familyHullLogVolume =
        data.determinantSource.determinantLogVolume ∧
      data.familyUnionLogVolume <=
        data.determinantSource.determinantLogVolume ∧
      data.tensorPower.normalizedLogVolume =
        data.familyHullLogVolume ∧
      data.tensorPower.tensorPowerLogVolume =
        (data.tensorPower.tensorDegree : Real) * data.familyHullLogVolume :=
  data.ob5_endpoint hneA hneB

theorem boundedFamilyHullDetLogVolumeOb9_endpoint
    {α : Type u} {ι : Type v} {β : Type w} {δ : Type x}
    [Fintype β]
    (data : IUTStage1BoundedFamilyHullDetLogVolumeSource α ι β)
    {targetHullData : IUTStage1HolomorphicHullLogVolumeShadow δ}
    (corr :
      IUTStage1RealifiedSemiSimplificationHullLogVolumeCorrespondence
        data.hullData targetHullData) :
    targetHullData.hull.IsClosed (corr.forwardHull data.familyHull) ∧
      corr.inverseHull (corr.forwardHull data.familyHull) = data.familyHull ∧
      targetHullData.logVolume (corr.forwardHull data.familyHull) =
        data.familyHullLogVolume ∧
      targetHullData.logVolume (corr.forwardHull data.familyHull) =
        data.determinantSource.determinantLogVolume :=
  data.ob9_endpoint corr

theorem boundedFamilyHullQuotient_endpoint
    {α : Type u} {ι : Type v}
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    (i j : ι)
    (hnei : (data.possibleRegion i).Nonempty)
    (hnej : (data.possibleRegion j).Nonempty) :
    data.possibleRegion i ⊆ data.familyHull ∧
      data.possibleRegion j ⊆ data.familyHull ∧
      data.quotientMap '' data.possibleRegion i =
        data.quotientMap '' data.possibleRegion j :=
  data.endpoint i j hnei hnej

theorem boundedFamilyHullQuotientMapBetween_endpoint
    {α : Type u} {ι : Type v}
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    (i j : ι)
    (f : α -> α)
    (hnei : (data.possibleRegion i).Nonempty)
    (hf :
      ∀ x, x ∈ data.possibleRegion i -> f x ∈ data.possibleRegion j) :
    (fun x => data.quotientMap (f x)) '' data.possibleRegion i =
      data.quotientMap '' data.possibleRegion i :=
  data.quotientMap_image_under_map_between_possibleRegions
    i j f hnei hf

theorem boundedFamilyHullQuotientExpectedRelation_endpoint
    {α : Type u} {ι : Type v}
    (data : IUTStage1BoundedFamilyHullQuotientSource α ι)
    {A B : Set α}
    (hneA : A.Nonempty)
    (hneB : B.Nonempty) :
    data.quotientMap '' A =
          {IUTStage1UpperSemiSetQuotient.collapsed} ∧
        data.quotientMap '' B =
          {IUTStage1UpperSemiSetQuotient.collapsed} ↔
      A ⊆ data.familyHull ∧ B ⊆ data.familyHull :=
  data.quotientMap_two_regions_collapse_iff hneA hneB

theorem upperSemiFormalIntersection_endpoint
    {E : Type u} {S : Set E} {κ : Type v}
    (system :
      IUTStage1UpperSemiSetQuotient.FormalIntersectionSystem
        (E := E) (S := S) κ)
    (i j : κ) :
    system.component i ⊆ S ∧
      system.quotientImage i =
        {IUTStage1UpperSemiSetQuotient.collapsed} ∧
      system.quotientImage i = system.quotientImage j :=
  system.endpoint i j

theorem upperSemiFormalIntersectionMap_endpoint
    {E : Type u} {S : Set E} {κ : Type v}
    (system :
      IUTStage1UpperSemiSetQuotient.FormalIntersectionSystem
        (E := E) (S := S) κ)
    (i j : κ)
    (f : E -> E)
    (hf :
      ∀ x, x ∈ system.component i -> f x ∈ system.component j) :
    (fun x => IUTStage1UpperSemiSetQuotient.quotientMap S (f x)) ''
        system.component i =
      system.quotientImage i :=
  system.component_map_quotientImage_eq i j f hf

theorem thetaPossibleImagesBoundedFamilyQuotient_endpoint
    {α : Type u} {ι : Type v}
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι)
    (i j : ι)
    (hnei : (data.possibleThetaImage i).Nonempty)
    (hnej : (data.possibleThetaImage j).Nonempty) :
    data.toBoundedFamilyHullQuotientSource.possibleRegion i ⊆
        data.toBoundedFamilyHullQuotientSource.familyHull ∧
      data.toBoundedFamilyHullQuotientSource.possibleRegion j ⊆
        data.toBoundedFamilyHullQuotientSource.familyHull ∧
      data.toBoundedFamilyHullQuotientSource.quotientMap ''
          data.toBoundedFamilyHullQuotientSource.possibleRegion i =
        data.toBoundedFamilyHullQuotientSource.quotientMap ''
          data.toBoundedFamilyHullQuotientSource.possibleRegion j :=
  data.boundedFamilyQuotient_endpoint i j hnei hnej

theorem thetaPossibleImagesQPilotFamilyQuotient_endpoint
    {α : Type u} {ι : Type v}
    (data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι)
    (i : ι)
    (hq : data.qPilotRegion.Nonempty)
    (htheta : (data.possibleThetaImage i).Nonempty) :
    data.qPilotRegion ⊆
        data.toBoundedFamilyHullQuotientSource.familyHull ∧
      data.toBoundedFamilyHullQuotientSource.quotientMap ''
          data.qPilotRegion =
        data.toBoundedFamilyHullQuotientSource.quotientMap ''
          data.possibleThetaImage i :=
  ⟨data.qPilotRegion_subset_familyHull,
    data.qPilot_quotientMap_image_eq_possibleThetaImage i hq htheta⟩

theorem thetaPossibleImagesWeightedDeterminant_endpoint
    {α : Type u} {ι : Type v} {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (approximant :
      IUTStage1HullLogVolumeApproximant
        hullData (⋃ i, possibleThetaImage i))
    (q_subset_approximant : qPilotRegion ⊆ approximant.approximant)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        approximant determinantSource) :
    let data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι :=
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow.ofWeightedDeterminant
          hullData possibleThetaImage qPilotRegion
          approximant q_subset_approximant determinantSource
          compatibility;
    data.thetaImageUnionLogVolume <= data.approximantLogVolume ∧
      data.approximantLogVolume <= data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= data.approximantLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaImageUnionLogVolume <=
        determinantSource.determinantLogVolume ∧
      data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume <=
        determinantSource.determinantLogVolume :=
  IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow.ofWeightedDeterminant_endpoint
    hullData possibleThetaImage qPilotRegion approximant
    q_subset_approximant determinantSource
    compatibility

theorem thetaPossibleImagesExactWeightedDeterminant_endpoint
    {α : Type u} {ι : Type v} {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (exact :
      IUTStage1ExactHullLogVolumeApproximant
        hullData (⋃ i, possibleThetaImage i))
    (q_subset_exact :
      qPilotRegion ⊆ exact.approximant.approximant)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        exact.approximant determinantSource) :
    let data :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι :=
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow.ofExactWeightedDeterminant
          hullData possibleThetaImage qPilotRegion
          exact q_subset_exact determinantSource compatibility;
    data.thetaImageUnionLogVolume = data.approximantLogVolume ∧
      data.approximantLogVolume <= data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= data.approximantLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaImageUnionLogVolume =
        determinantSource.determinantLogVolume ∧
      data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume <=
        determinantSource.determinantLogVolume :=
  IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow.ofExactWeightedDeterminant_endpoint
    hullData possibleThetaImage qPilotRegion exact q_subset_exact
    determinantSource compatibility

open IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow in
theorem thetaPossibleImagesCanonicalHullWeightedDeterminantFromQSubsetUnion_endpoint
    {α : Type u} {ι : Type v} {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (q_subset_thetaImageUnion :
      qPilotRegion ⊆ ⋃ i, possibleThetaImage i)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource) :
    let data :=
      ofCanonicalHullWeightedDeterminantOfQSubsetUnion
        hullData possibleThetaImage qPilotRegion q_subset_thetaImageUnion
        determinantSource compatibility;
    data.qPilotRegion ⊆ data.thetaImageUnion ∧
      data.qPilotRegion ⊆ data.thetaHull ∧
      data.approximantRegion = data.thetaHull ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.approximantLogVolume =
        determinantSource.determinantLogVolume :=
  ofCanonicalHullWeightedDeterminantOfQSubsetUnion_endpoint
    hullData possibleThetaImage qPilotRegion q_subset_thetaImageUnion
    determinantSource compatibility

open IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow in
theorem thetaPossibleImagesCanonicalHullFamilyDetLogVolume_endpoint
    {α : Type u} {ι : Type v} {β : Type w} [Fintype β]
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow α)
    (possibleThetaImage : ι -> Set α)
    (qPilotRegion : Set α)
    (q_subset_hull :
      qPilotRegion ⊆ hullData.hullRegion (⋃ i, possibleThetaImage i))
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource)
    (i j : ι)
    (hnei : (possibleThetaImage i).Nonempty)
    (hnej : (possibleThetaImage j).Nonempty) :
    let data :=
      ofCanonicalHullWeightedDeterminant
        hullData possibleThetaImage qPilotRegion q_subset_hull
        determinantSource compatibility;
    let familySource :=
      canonicalHullWeightedDeterminantFamilyHullDetLogVolumeSource
        hullData possibleThetaImage determinantSource compatibility;
    data.thetaHull = familySource.familyHull ∧
      data.approximantLogVolume = familySource.familyHullLogVolume ∧
      familySource.possibleRegion i ⊆ familySource.familyHull ∧
      familySource.possibleRegion j ⊆ familySource.familyHull ∧
      familySource.quotientMap '' familySource.possibleRegion i =
        familySource.quotientMap '' familySource.possibleRegion j ∧
      familySource.familyHullLogVolume =
        determinantSource.determinantLogVolume ∧
      familySource.familyUnionLogVolume <=
        determinantSource.determinantLogVolume ∧
      familySource.tensorPower.normalizedLogVolume =
        familySource.familyHullLogVolume :=
  canonicalHullWeightedDeterminantFamilyHullDetLogVolume_endpoint
    hullData possibleThetaImage qPilotRegion q_subset_hull
    determinantSource compatibility i j hnei hnej

open IUTStage1ThetaPilotPossibleImages in
theorem thetaPilotPossibleImagesCanonicalHullWeightedDeterminant_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    (images : IUTStage1ThetaPilotPossibleImages package)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (qPilotRegion : Region target)
    (q_subset_hull :
      qPilotRegion.toSet ⊆ hullData.hullRegion images.thetaImageUnionSet)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData images.thetaImageUnionSet)
        determinantSource) :
    let hullSource :=
      images.toCanonicalHullWeightedDeterminant
        hullData qPilotRegion q_subset_hull determinantSource compatibility;
    images.thetaPilot = package.thetaPilot ∧
      images.indeterminacies = package.indeterminacies ∧
      hullSource.thetaImageUnion = images.thetaImageUnionSet ∧
      hullSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet ∧
      hullSource.approximantRegion = hullSource.thetaHull ∧
      hullSource.qPilotLogVolume <= hullSource.thetaHullLogVolume ∧
      hullSource.approximantLogVolume =
        determinantSource.determinantLogVolume :=
  images.canonicalHullWeightedDeterminant_endpoint
    hullData qPilotRegion q_subset_hull determinantSource compatibility

open IUTStage1ThetaPilotPossibleImages in
theorem thetaPilotPossibleImagesCanonicalHullWeightedDeterminantFromQSubsetUnion_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    (images : IUTStage1ThetaPilotPossibleImages package)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (qPilotRegion : Region target)
    (q_subset_thetaImageUnion :
      qPilotRegion.toSet ⊆ images.thetaImageUnionSet)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData images.thetaImageUnionSet)
        determinantSource) :
    let hullSource :=
      images.toCanonicalHullWeightedDeterminantOfQSubsetUnion
        hullData qPilotRegion q_subset_thetaImageUnion
        determinantSource compatibility;
    images.thetaPilot = package.thetaPilot ∧
      hullSource.thetaImageUnion = images.thetaImageUnionSet ∧
      qPilotRegion.toSet ⊆ hullSource.thetaImageUnion ∧
      qPilotRegion.toSet ⊆ hullSource.thetaHull ∧
      hullSource.approximantRegion = hullSource.thetaHull ∧
      hullSource.qPilotLogVolume <= hullSource.thetaHullLogVolume ∧
      hullSource.approximantLogVolume =
        determinantSource.determinantLogVolume :=
  images.canonicalHullWeightedDeterminantOfQSubsetUnion_endpoint
    hullData qPilotRegion q_subset_thetaImageUnion determinantSource
    compatibility

theorem sourceHullDetDataFromTensorPowerWeightedDeterminant_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (possibleThetaImage : index -> Set (Point target))
    (qPilotRegion : Set (Point target))
    (approximant :
      IUTStage1HullLogVolumeApproximant
        hullData (⋃ i, possibleThetaImage i))
    (q_subset_approximant :
      qPilotRegion ⊆ approximant.approximant)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        approximant determinantSource)
    (theta_union_eq_targetUnion :
      (IUTStage1SourceHullDetData.canonicalWeightedDeterminantApproximantSource
          hullData possibleThetaImage qPilotRegion approximant
          q_subset_approximant determinantSource compatibility).thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet)
    (approximant_eq_canonical_hull :
      (IUTStage1SourceHullDetData.canonicalWeightedDeterminantApproximantSource
          hullData possibleThetaImage qPilotRegion approximant
          q_subset_approximant determinantSource compatibility).approximantRegion =
        (IUTStage1SourceHullDetData.canonicalWeightedDeterminantApproximantSource
          hullData possibleThetaImage qPilotRegion approximant
          q_subset_approximant determinantSource compatibility).thetaHull)
    (measure_eq_hullLogVolume :
      package.preLedger.measure = hullData.toRegionMeasure)
    (tensorPower_bound :
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        IUTStage1SourceHullDetData.canonicalTensorPowerWeightedDeterminantHullDetBridgeData
          (package := package)
          operation hullOperation determinantOperation hullData
          possibleThetaImage qPilotRegion approximant q_subset_approximant
          determinantSource compatibility theta_union_eq_targetUnion
          approximant_eq_canonical_hull measure_eq_hullLogVolume
          tensorPower_bound) :
    let data :=
      IUTStage1SourceHullDetData.ofCanonicalTensorPowerWeightedDeterminant
        (package := package)
        operation hullOperation determinantOperation hullData possibleThetaImage
        qPilotRegion approximant q_subset_approximant determinantSource
        compatibility theta_union_eq_targetUnion approximant_eq_canonical_hull
        measure_eq_hullLogVolume tensorPower_bound hbridge;
    (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
        determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned ∧
      Region.Subset package.preLedger.output.comparisons.targetUnion
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull package.preLedger.thetaSigned ∧
      RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
        package.preLedger.output.comparisons package.preLedger.thetaSigned :=
  by
    intro data
    exact
      ⟨tensorPower_bound,
        data.targetUnion_subset_hull,
        data.determinantVolumeBound,
        data.allTargetsAtMost⟩

theorem sourceHullDetDataFromCanonicalHullTensorPowerWeightedDeterminant_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (possibleThetaImage : index -> Set (Point target))
    (qPilotRegion : Set (Point target))
    (q_subset_hull :
      qPilotRegion ⊆ hullData.hullRegion (⋃ i, possibleThetaImage i))
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource)
    (theta_union_eq_targetUnion :
      (IUTStage1SourceHullDetData.canonicalHullWeightedDeterminantApproximantSource
          hullData possibleThetaImage qPilotRegion q_subset_hull
          determinantSource compatibility).thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet)
    (measure_eq_hullLogVolume :
      package.preLedger.measure = hullData.toRegionMeasure)
    (tensorPower_bound :
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        IUTStage1SourceHullDetData.canonicalHullTensorPowerWeightedDeterminantHullDetBridgeData
            (package := package)
            operation hullOperation determinantOperation hullData
            possibleThetaImage qPilotRegion q_subset_hull determinantSource
            compatibility theta_union_eq_targetUnion measure_eq_hullLogVolume
            tensorPower_bound) :
    let approximantSource :=
      IUTStage1SourceHullDetData.canonicalHullWeightedDeterminantApproximantSource
        hullData possibleThetaImage qPilotRegion q_subset_hull
        determinantSource compatibility;
    let data :=
      IUTStage1SourceHullDetData.ofCanonicalHullTensorPowerWeightedDeterminant
        (package := package)
        operation hullOperation determinantOperation hullData possibleThetaImage
        qPilotRegion q_subset_hull determinantSource compatibility
        theta_union_eq_targetUnion measure_eq_hullLogVolume tensorPower_bound
        hbridge;
    approximantSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet ∧
      approximantSource.approximantRegion = approximantSource.thetaHull ∧
      approximantSource.approximantLogVolume =
        determinantSource.determinantLogVolume ∧
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned ∧
      Region.Subset package.preLedger.output.comparisons.targetUnion
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull package.preLedger.thetaSigned ∧
      RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
        package.preLedger.output.comparisons package.preLedger.thetaSigned :=
  by
    intro approximantSource data
    have endpoint :=
      IUTStage1SourceHullDetData.ofCanonicalHullTensorPowerWeightedDeterminant_endpoint
          (package := package)
          operation hullOperation determinantOperation hullData possibleThetaImage
          qPilotRegion q_subset_hull determinantSource compatibility
          theta_union_eq_targetUnion measure_eq_hullLogVolume
          tensorPower_bound hbridge
    exact
      ⟨theta_union_eq_targetUnion,
        endpoint.2.1,
        endpoint.2.2.1,
        endpoint.1,
        endpoint.2.2.2.1,
        endpoint.2.2.2.2.1,
        endpoint.2.2.2.2.2⟩

open IUTStage1SourceHullDetData in
theorem sourceHullDetDataFromCanonicalHullTensorPowerOfQSubsetUnion_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (possibleThetaImage : index -> Set (Point target))
    (qPilotRegion : Set (Point target))
    (q_subset_thetaImageUnion :
      qPilotRegion ⊆ ⋃ i, possibleThetaImage i)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource)
    (theta_union_eq_targetUnion :
      (IUTStage1SourceHullDetData.canonicalHullWeightedDeterminantApproximantSourceOfQSubsetUnion
          hullData possibleThetaImage qPilotRegion q_subset_thetaImageUnion
          determinantSource compatibility).thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet)
    (measure_eq_hullLogVolume :
      package.preLedger.measure = hullData.toRegionMeasure)
    (tensorPower_bound :
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        canonicalHullTensorPowerWeightedDeterminantHullDetBridgeDataOfQSubsetUnion
          (package := package)
          operation hullOperation determinantOperation hullData
          possibleThetaImage qPilotRegion q_subset_thetaImageUnion
          determinantSource compatibility theta_union_eq_targetUnion
          measure_eq_hullLogVolume tensorPower_bound) :
    let approximantSource :=
      IUTStage1SourceHullDetData.canonicalHullWeightedDeterminantApproximantSourceOfQSubsetUnion
        hullData possibleThetaImage qPilotRegion q_subset_thetaImageUnion
        determinantSource compatibility;
    let data :=
      ofCanonicalHullTensorPowerWeightedDeterminantOfQSubsetUnion
        (package := package)
        operation hullOperation determinantOperation hullData possibleThetaImage
        qPilotRegion q_subset_thetaImageUnion determinantSource compatibility
        theta_union_eq_targetUnion measure_eq_hullLogVolume
        tensorPower_bound hbridge;
    approximantSource.qPilotRegion ⊆ approximantSource.thetaImageUnion ∧
      approximantSource.qPilotRegion ⊆ approximantSource.thetaHull ∧
      approximantSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet ∧
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned ∧
      approximantSource.approximantRegion = approximantSource.thetaHull ∧
      approximantSource.approximantLogVolume =
        determinantSource.determinantLogVolume ∧
      Region.Subset package.preLedger.output.comparisons.targetUnion
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (data.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull package.preLedger.thetaSigned :=
  ofCanonicalHullTensorPowerWeightedDeterminantOfQSubsetUnion_endpoint
    (package := package)
    operation hullOperation determinantOperation hullData possibleThetaImage
    qPilotRegion q_subset_thetaImageUnion determinantSource compatibility
    theta_union_eq_targetUnion measure_eq_hullLogVolume tensorPower_bound
    hbridge

theorem packetNormalizedEntryTargetSource_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (source : NonarchimedeanPacketNormalizedEntryTargetSource audited) :
    source.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      source.toEntry.sourceLogVolume.finiteLogVolume <=
        source.toEntry.targetLogVolume.finiteLogVolume ∧
      source.toEntry.targetLogVolume.localObject.object =
        source.toEntry.targetObject :=
  source.packetNormalizedEntryTarget_endpoint

theorem packetTargetCalibrationFromPacketNormalizedEntryTarget_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (thetaAverage_eq_packetNormalized :
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (ind3Target_eq_packetNormalized :
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume) :
    let calibration :
      NonarchimedeanLogKummerPacketTargetCalibration
        audited thetaAverage logKummer entrySource.toEntry :=
      NonarchimedeanLogKummerPacketTargetCalibration.ofPacketNormalizedEntryTargetSource
        entrySource thetaAverage_eq_packetNormalized
        ind3Target_eq_packetNormalized;
    calibration.entryTarget_eq_packetNormalized =
        entrySource.toEntry_targetLogVolume_eq_packetNormalized ∧
      calibration.thetaAverage_eq_entryTarget =
        thetaAverage_eq_packetNormalized.trans
          entrySource.toEntry_targetLogVolume_eq_packetNormalized.symm ∧
      calibration.entryTarget_eq_ind3Target =
        entrySource.toEntry_targetLogVolume_eq_packetNormalized.trans
          ind3Target_eq_packetNormalized.symm :=
  NonarchimedeanLogKummerPacketTargetCalibration.ofPacketNormalizedEntryTargetSource_endpoint
    (logKummer := logKummer)
    entrySource thetaAverage_eq_packetNormalized ind3Target_eq_packetNormalized

open NonarchimedeanLogKummerPacketTargetCalibration in
theorem packetTargetCalibrationFromEntryTargetAndThetaAlignment_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (thetaAverage_eq_packetNormalized :
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (thetaAverage_eq_ind3Target :
      thetaAverage =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume) :
    let calibration :
      NonarchimedeanLogKummerPacketTargetCalibration
        audited thetaAverage logKummer entrySource.toEntry :=
      NonarchimedeanLogKummerPacketTargetCalibration.ofPacketNormalizedEntryTargetAndThetaTarget
        entrySource thetaAverage_eq_packetNormalized
        thetaAverage_eq_ind3Target;
    calibration.ind3Target_eq_packetNormalized =
        thetaAverage_eq_ind3Target.symm.trans
          thetaAverage_eq_packetNormalized ∧
      calibration.entryTarget_eq_packetNormalized =
        entrySource.toEntry_targetLogVolume_eq_packetNormalized ∧
      calibration.entryTarget_eq_ind3Target =
        entrySource.toEntry_targetLogVolume_eq_packetNormalized.trans
          (thetaAverage_eq_ind3Target.symm.trans
            thetaAverage_eq_packetNormalized).symm :=
  by
    exact
      ofPacketNormalizedEntryTargetAndThetaTarget_endpoint
        (logKummer := logKummer)
        entrySource thetaAverage_eq_packetNormalized thetaAverage_eq_ind3Target

theorem packetCorrespondenceFromEntryTargetThetaAlignment_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (sourceCalibration :
      NonarchimedeanLogKummerPacketSourceCalibration
        audited logKummer entrySource.toEntry
        holomorphicF holomorphicD monoAnalyticD)
    (thetaAverage_eq_packetNormalized :
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (thetaAverage_eq_ind3Target :
      thetaAverage =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume)
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD) :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entrySource.toEntry.targetLogVolume.finiteLogVolume ∧
      entrySource.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  NonarchimedeanLogKummerPacketCorrespondenceSource.ofEntryTargetThetaAlignment_endpoint
    entrySource sourceCalibration thetaAverage_eq_packetNormalized
    thetaAverage_eq_ind3Target kummer forgetting

theorem packetSourceCalibrationFromPacketLocalAlignment_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.product.productLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD) :
    audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        entry.sourceLogVolume.finiteLogVolume ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume =
        holomorphicF.product.productLogVolume :=
  NonarchimedeanLogKummerPacketSourceCalibration.ofPacketLocalSourceAlignment_endpoint
    (logKummerId := logKummer)
    packetLocalObject_eq_entrySource entrySource_eq_monoAnalyticProduct
    packetLocalObjectFinite_eq_ind3Source kummer forgetting

theorem packetLocalSourceAlignmentFromSourceCalibration_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (calibration :
      NonarchimedeanLogKummerPacketSourceCalibration
        audited logKummer entry holomorphicF holomorphicD monoAnalyticD)
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD) :
    let alignment :=
      calibration.toPacketLocalSourceAlignment kummer forgetting;
    alignment.packetLocalObject_eq_entrySource =
        calibration.packetLocalObject_eq_entrySource ∧
      alignment.entrySource_eq_monoAnalyticProduct =
        calibration.entrySource_eq_monoAnalyticProduct ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume :=
  calibration.toPacketLocalSourceAlignment_endpoint kummer forgetting

open NonarchimedeanLogKummerPacketCorrespondenceSource in
theorem packetCorrespondenceFromPacketLocalAndEntryTargetThetaAlignment_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entrySource.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.product.productLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (thetaAverage_eq_packetNormalized :
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (thetaAverage_eq_ind3Target :
      thetaAverage =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume)
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD) :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entrySource.toEntry.targetLogVolume.finiteLogVolume ∧
      entrySource.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  ofPacketLocalAndEntryTargetThetaAlignment_endpoint
    (logKummerId := logKummer)
    entrySource packetLocalObject_eq_entrySource
    entrySource_eq_monoAnalyticProduct packetLocalObjectFinite_eq_ind3Source
    thetaAverage_eq_packetNormalized thetaAverage_eq_ind3Target
    kummer forgetting

open NonarchimedeanLogKummerPacketCorrespondenceSource in
theorem packetCorrespondenceFromSourceAlignedEntryTargetThetaAlignment_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited entrySource.toEntry monoAnalyticD)
    (thetaAverage_eq_packetNormalized :
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (thetaAverage_eq_ind3Target :
      thetaAverage =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume)
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD) :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entrySource.toEntry.targetLogVolume.finiteLogVolume ∧
      entrySource.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  ofSourceAlignedEntryTargetThetaAlignment_endpoint
    (logKummerId := logKummer)
    entrySource sourceAlignment thetaAverage_eq_packetNormalized
    thetaAverage_eq_ind3Target kummer forgetting

open NonarchimedeanLogKummerPacketCorrespondenceSource in
theorem packetCorrespondenceFromSourceAlignedVerticalIQTarget_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited entry monoAnalyticD)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer entry)
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD) :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  ofSourceAlignedVerticalIQTargetSource_endpoint
    (logKummerId := logKummer)
    sourceAlignment targetSource kummer forgetting

open NonarchimedeanRealifiedFrobenioidLogKummerPacketSource in
theorem realifiedPacketFromEntryTargetThetaAlignment_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceCalibration :
      NonarchimedeanLogKummerPacketSourceCalibration
        audited logKummer entrySource.toEntry
        holomorphicF.toRealized holomorphicD.toRealized monoAnalyticD.toRealized)
    (thetaAverage_eq_packetNormalized :
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (thetaAverage_eq_ind3Target :
      thetaAverage =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume) :
    holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entrySource.toEntry.targetLogVolume.finiteLogVolume ∧
      entrySource.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  ofEntryTargetThetaAlignment_endpoint
    entrySource kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceCalibration
    thetaAverage_eq_packetNormalized thetaAverage_eq_ind3Target

open NonarchimedeanRealifiedFrobenioidLogKummerPacketSource in
theorem realifiedPacketFromVerticalIQTargetSource_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceCalibration :
      NonarchimedeanLogKummerPacketSourceCalibration
        audited logKummer entry
        holomorphicF.toRealized holomorphicD.toRealized monoAnalyticD.toRealized)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer entry) :
    holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  ofVerticalIQTargetSource_endpoint
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization
    holomorphicStructureForgotten holomorphic_structure_forgotten
    sourceCalibration targetSource

open NonarchimedeanRealifiedFrobenioidLogKummerPacketSource in
theorem realifiedPacketFromSourceAlignedVerticalIQTarget_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited entry monoAnalyticD.toRealized)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer entry) :
    holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  ofSourceAlignedVerticalIQTargetSource_endpoint
    (logKummerId := logKummer)
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceAlignment targetSource

open NonarchimedeanRealifiedFrobenioidLogKummerPacketSource in
theorem packetLocalSourceAlignmentFromRealifiedPacketSource_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (source :
      NonarchimedeanRealifiedFrobenioidLogKummerPacketSource
        audited thetaAverage logKummer entry
        holomorphicF holomorphicD monoAnalyticD) :
    let alignment := source.toPacketLocalSourceAlignment;
    alignment.packetLocalObject_eq_entrySource =
        source.sourceCalibration.packetLocalObject_eq_entrySource ∧
      alignment.entrySource_eq_monoAnalyticProduct =
        source.sourceCalibration.entrySource_eq_monoAnalyticProduct ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume :=
  source.packetLocalSourceAlignment_endpoint

open NonarchimedeanRealifiedFrobenioidLogKummerEntrySource in
theorem packetLocalSourceAlignmentFromRealifiedEntrySource_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (source :
      NonarchimedeanRealifiedFrobenioidLogKummerEntrySource
        audited thetaAverage logKummer entry
        holomorphicF holomorphicD monoAnalyticD) :
    let alignment := source.toPacketLocalSourceAlignment;
    entry ∈ audited.choice.upper_semi_state.nonarchimedeanInclusions ∧
      alignment.packetLocalObject_eq_entrySource =
        source.packetSource.sourceCalibration.packetLocalObject_eq_entrySource ∧
      alignment.entrySource_eq_monoAnalyticProduct =
        source.packetSource.sourceCalibration.entrySource_eq_monoAnalyticProduct ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume :=
  source.packetLocalSourceAlignment_endpoint

open NonarchimedeanRealifiedFrobenioidLogKummerPacketSource in
theorem realifiedPacketFromPacketLocalAndEntryTargetThetaAlignment_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entrySource.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.toRealized.product.productLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (thetaAverage_eq_packetNormalized :
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (thetaAverage_eq_ind3Target :
      thetaAverage =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume) :
    holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entrySource.toEntry.targetLogVolume.finiteLogVolume ∧
      entrySource.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  ofPacketLocalAndEntryTargetThetaAlignment_endpoint
    (logKummerId := logKummer)
    entrySource kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    entrySource_eq_monoAnalyticProduct packetLocalObjectFinite_eq_ind3Source
    thetaAverage_eq_packetNormalized thetaAverage_eq_ind3Target

open NonarchimedeanRealifiedFrobenioidLogKummerEntrySource in
theorem realifiedEntryFromPacketLocalAndEntryTargetThetaAlignment_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (entry_mem :
      entrySource.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entrySource.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.toRealized.product.productLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (thetaAverage_eq_packetNormalized :
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (thetaAverage_eq_ind3Target :
      thetaAverage =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume) :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entrySource.toEntry.targetLogVolume.finiteLogVolume ∧
      entrySource.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ofPacketLocalAndEntryTargetThetaAlignment_endpoint
    (logKummerId := logKummer)
    entrySource entry_mem kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    entrySource_eq_monoAnalyticProduct packetLocalObjectFinite_eq_ind3Source
    thetaAverage_eq_packetNormalized thetaAverage_eq_ind3Target

open NonarchimedeanRealifiedFrobenioidLogKummerEntrySource in
theorem realifiedEntryFromSourceCalibrationAndVerticalIQTarget_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (entry_mem :
      entry ∈ audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceCalibration :
      NonarchimedeanLogKummerPacketSourceCalibration
        audited logKummer entry
        holomorphicF.toRealized holomorphicD.toRealized monoAnalyticD.toRealized)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer entry) :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ofEntryMemSourceCalibrationAndVerticalIQTarget_endpoint
    (logKummerId := logKummer)
    entry_mem kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceCalibration targetSource

open NonarchimedeanRealifiedFrobenioidLogKummerEntrySource in
theorem realifiedEntryFromUpperSemiPacketLocalVerticalIQTarget_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        upperSemiEntry.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      upperSemiEntry.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.toRealized.product.productLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer upperSemiEntry.toEntry) :
    holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      upperSemiEntry.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions ∧
      upperSemiEntry.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume ∧
      upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ofUpperSemiEntryPacketLocalAndVerticalIQTarget_endpoint
    (logKummerId := logKummer)
    upperSemiEntry kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    entrySource_eq_monoAnalyticProduct packetLocalObjectFinite_eq_ind3Source
    targetSource

open NonarchimedeanRealifiedFrobenioidLogKummerEntrySource in
theorem realifiedEntryFromUpperSemiSourceAlignedVerticalIQTarget_precise_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited upperSemiEntry.toEntry monoAnalyticD.toRealized)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer upperSemiEntry.toEntry) :
    targetSource.frobenioidMode.hasPreciseFrobenioidIsomorphisms = true ∧
      holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      upperSemiEntry.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions ∧
      upperSemiEntry.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume ∧
      upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ofUpperSemiEntrySourceAlignedAndVerticalIQTarget_precise_endpoint
    (logKummerId := logKummer)
    upperSemiEntry kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceAlignment targetSource

open NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource in
theorem packetLocalSourceAlignmentFromThetaRootRealifiedEntrySource_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (source :
      NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource
        audited thetaAverage logKummer l X C entry
        holomorphicF holomorphicD monoAnalyticD) :
    let sourceCalibration :=
      source.realifiedEntrySource.packetSource.sourceCalibration;
    let alignment := source.toPacketLocalSourceAlignment;
    source.thetaRootSource.canonicalGenerator.canonicalGeneratorUpToSign ∧
      source.thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      entry ∈ audited.choice.upper_semi_state.nonarchimedeanInclusions ∧
      alignment.packetLocalObject_eq_entrySource =
        sourceCalibration.packetLocalObject_eq_entrySource ∧
      alignment.entrySource_eq_monoAnalyticProduct =
        sourceCalibration.entrySource_eq_monoAnalyticProduct ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume :=
  source.thetaRootPacketLocalSourceAlignment_endpoint

open NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource in
theorem thetaRootRealifiedEntryFromPacketLocalAndEntryTargetThetaAlignment_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (entry_mem :
      entrySource.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entrySource.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.toRealized.product.productLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (thetaAverage_eq_packetNormalized :
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (thetaAverage_eq_ind3Target :
      thetaAverage =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume) :
    thetaRootSource.canonicalGenerator.canonicalGeneratorUpToSign ∧
      thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entrySource.toEntry.targetLogVolume.finiteLogVolume ∧
      entrySource.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ofThetaRootEntryMemPacketLocalAndTargetThetaAlignment_endpoint
    (logKummerId := logKummer)
    thetaRootSource entrySource entry_mem
    kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    entrySource_eq_monoAnalyticProduct packetLocalObjectFinite_eq_ind3Source
    thetaAverage_eq_packetNormalized thetaAverage_eq_ind3Target

open NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource in
theorem thetaRootRealifiedEntryFromSourceCalibrationAndVerticalIQTarget_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (entry_mem :
      entry ∈ audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceCalibration :
      NonarchimedeanLogKummerPacketSourceCalibration
        audited logKummer entry
        holomorphicF.toRealized holomorphicD.toRealized monoAnalyticD.toRealized)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer entry) :
    thetaRootSource.canonicalGenerator.canonicalGeneratorUpToSign ∧
      thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ofThetaRootEntryMemSourceCalibrationAndVerticalIQTarget_endpoint
    (logKummerId := logKummer)
    thetaRootSource entry_mem kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceCalibration targetSource

open NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource in
theorem thetaRootRealifiedEntryFromUpperSemiPacketLocalVerticalIQTarget_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        upperSemiEntry.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      upperSemiEntry.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.toRealized.product.productLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer upperSemiEntry.toEntry) :
    thetaRootSource.canonicalGenerator.canonicalGeneratorUpToSign ∧
      thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      upperSemiEntry.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions ∧
      upperSemiEntry.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume ∧
      upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ofThetaRootUpperSemiEntryPacketLocalAndVerticalIQTarget_endpoint
    (logKummerId := logKummer)
    thetaRootSource upperSemiEntry kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    entrySource_eq_monoAnalyticProduct packetLocalObjectFinite_eq_ind3Source
    targetSource

open NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource in
theorem thetaRootRealifiedEntryFromUpperSemiSourceAlignedVerticalIQTarget_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited upperSemiEntry.toEntry monoAnalyticD.toRealized)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer upperSemiEntry.toEntry) :
    thetaRootSource.canonicalGenerator.canonicalGeneratorUpToSign ∧
      thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      upperSemiEntry.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions ∧
      upperSemiEntry.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume ∧
      upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ofThetaRootUpperSemiEntrySourceAlignedAndVerticalIQTarget_endpoint
    (logKummerId := logKummer)
    thetaRootSource upperSemiEntry kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceAlignment targetSource

open NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource in
theorem thetaRootRealifiedEntryFromUpperSemiFiniteDivisorVerticalIQTarget_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {j : Nat}
    {holomorphicF holomorphicD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    {product :
      IUTStage1BaseValuationTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (divisorPacket : IUTStage1FiniteDivisorTensorPacketProductSource product)
    (monoAnalyticTheater : QualitativeData.HodgeTheaterId)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD
          (divisorPacket.toRealifiedFrobenioidTensorPacketProductSource
            IUTStage1TensorPacketRealizationKind.monoAnalyticD
            monoAnalyticTheater))
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        upperSemiEntry.toEntry.sourceLogVolume)
    (packetLocalObjectFinite_eq_divisorRealified :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        divisorPacket.divisor.realifiedLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer upperSemiEntry.toEntry) :
    let monoAnalyticD :=
      divisorPacket.toRealifiedFrobenioidTensorPacketProductSource
        IUTStage1TensorPacketRealizationKind.monoAnalyticD monoAnalyticTheater;
    thetaRootSource.canonicalGenerator.canonicalGeneratorUpToSign ∧
      thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      product.productLogVolume = divisorPacket.divisor.realifiedLogVolume ∧
      upperSemiEntry.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions ∧
      upperSemiEntry.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume ∧
      upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ofThetaRootUpperSemiEntryFiniteDivisorAndVerticalIQTarget_endpoint
    (logKummerId := logKummer)
    thetaRootSource upperSemiEntry divisorPacket monoAnalyticTheater
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    packetLocalObjectFinite_eq_divisorRealified
    packetLocalObjectFinite_eq_ind3Source targetSource

open NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource in
theorem thetaRootRealifiedEntryFromUpperSemiSourceAlignedVerticalIQTarget_precise_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited upperSemiEntry.toEntry monoAnalyticD.toRealized)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited thetaAverage logKummer upperSemiEntry.toEntry) :
    thetaRootSource.canonicalGenerator.canonicalGeneratorUpToSign ∧
      thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      targetSource.frobenioidMode.hasPreciseFrobenioidIsomorphisms = true ∧
      holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      upperSemiEntry.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions ∧
      upperSemiEntry.toEntry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume ∧
      upperSemiEntry.toEntry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  ofThetaRootUpperSemiEntrySourceAlignedAndVerticalIQTarget_precise_endpoint
    (logKummerId := logKummer)
    thetaRootSource upperSemiEntry kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceAlignment targetSource

theorem realifiedFrobenioidLogKummerPacket_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (source :
      NonarchimedeanRealifiedFrobenioidLogKummerPacketSource
        audited thetaAverage logKummer entry
        holomorphicF holomorphicD monoAnalyticD) :
    holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  source.realifiedFrobenioidPacket_endpoint

theorem realifiedFrobenioidLogKummerPacket_calibration_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (source :
      NonarchimedeanRealifiedFrobenioidLogKummerPacketSource
        audited thetaAverage logKummer entry
        holomorphicF holomorphicD monoAnalyticD) :
    holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        entry.sourceLogVolume.finiteLogVolume ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true :=
  source.realifiedFrobenioidPacket_calibration_endpoint

theorem thetaRootRealifiedFrobenioidLogKummerEntry_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (source :
      NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource
        audited thetaAverage logKummer l X C entry
        holomorphicF holomorphicD monoAnalyticD) :
    source.thetaRootSource.canonicalGenerator.canonicalGeneratorUpToSign ∧
      source.thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  source.thetaRootRealifiedEntry_endpoint

theorem thetaRootRealifiedFrobenioidLogKummerEntry_calibration_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (source :
      NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource
        audited thetaAverage logKummer l X C entry
        holomorphicF holomorphicD monoAnalyticD) :
    source.thetaRootSource.canonicalGenerator.canonicalGeneratorUpToSign ∧
      source.thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        entry.sourceLogVolume.finiteLogVolume ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  source.thetaRootRealifiedEntry_packetCalibration_endpoint

theorem thetaRootRealifiedFrobenioidLogKummerEntry_packetCorrespondence_endpoint
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {entry : IUTStage1NonarchimedeanInclusionData}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (source :
      NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource
        audited thetaAverage logKummer l X C entry
        holomorphicF holomorphicD monoAnalyticD) :
    source.thetaRootSource.canonicalGenerator.canonicalGeneratorUpToSign ∧
      source.thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      holomorphicD.toRealized.product.productLogVolume =
        holomorphicF.toRealized.product.productLogVolume ∧
      monoAnalyticD.toRealized.product.productLogVolume =
        holomorphicD.toRealized.product.productLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        entry.sourceLogVolume.finiteLogVolume ∧
      entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      thetaAverage = entry.targetLogVolume.finiteLogVolume ∧
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  source.thetaRootRealifiedEntry_packetCorrespondence_endpoint

theorem hodgeArakelovThetaValueSource_constructsGaussianEvaluation
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    (source :
      IUTStage1HodgeArakelovThetaValueEvaluationSource l X C) :
    source.thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      source.toGaussianMonoidDegreeEvaluation.gaussianDegree
          IUTStage1ZModCuspFullLabel.zero = 0 ∧
      source.toGaussianMonoidDegreeEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        source.thetaMonoidDegree :=
  ⟨source.canonicalThetaRootLabel_ne_zero,
    source.zeroDegree_eq_zero,
    source.canonicalOneDegree_eq_thetaMonoidDegree⟩

theorem hodgeArakelovThetaValueSources_feedFactoredSHE
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    (sourceHA targetHA :
      IUTStage1HodgeArakelovThetaValueEvaluationSource l X C)
    (canonicalOneDegree_preserved :
      targetHA.toGaussianMonoidDegreeEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceHA.toGaussianMonoidDegreeEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value))) :
    let obligations :=
      fromHodgeArakelovThetaValueEvaluations
        (package := package) (bundle := bundle)
        sourceHA targetHA canonicalOneDegree_preserved;
    sourceHA.thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      targetHA.thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      obligations.comparisonLevel =
        IUTStage1SquareComparisonLevel.pointwiseRepresentative :=
  by
    intro obligations
    exact
      ⟨sourceHA.canonicalThetaRootLabel_ne_zero,
        targetHA.canonicalThetaRootLabel_ne_zero,
        obligations.comparisonLevel_eq_pointwiseRepresentative⟩

theorem thetaRootKummerPacketTargetSource_buildsUpperSemiCompatibility
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    {thetaAverage : Real}
    {logKummer : LogKummerCorrespondenceId}
    {l : PrimeGeFive} {F : Type u} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (source :
      NonarchimedeanThetaRootKummerForgettingPacketTargetSource
        audited thetaAverage logKummer l X C
        holomorphicF holomorphicD monoAnalyticD) :
    source.thetaRootSource.canonicalFullLabel ≠
        IUTStage1ZModCuspFullLabel.zero ∧
      source.entry.sourceLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      thetaAverage = source.entry.targetLogVolume.finiteLogVolume ∧
      source.entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      thetaAverage =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume <=
        thetaAverage :=
  source.packetTargetSource_endpoint

theorem hodgeArakelovPacketTargetSource_cThetaDichotomy
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
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (sourceHA targetHA :
      IUTStage1HodgeArakelovThetaValueEvaluationSource l X C)
    (canonical_one_preserved :
      targetHA.toGaussianMonoidDegreeEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceHA.toGaussianMonoidDegreeEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceHA.toGaussianMonoidDegreeEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_log_volume_eq_theta :
      targetHA.toGaussianMonoidDegreeEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (packetSource :
      NonarchimedeanThetaRootKummerForgettingPacketTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer l X C
        holomorphicF holomorphicD monoAnalyticD)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeArakelovPacketTargetSource
    profile audited sourceHA targetHA canonical_one_preserved source_profile_eq
    source_log_volume_eq target_log_volume_eq_theta packetSource
    q_pilot_positive cTheta thetaSigned_le_cTheta_absLogQ

theorem hodgeArakelovRealifiedFrobenioidEntry_cThetaDichotomy
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
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (sourceHA targetHA :
      IUTStage1HodgeArakelovThetaValueEvaluationSource l X C)
    (canonical_one_preserved :
      targetHA.toGaussianMonoidDegreeEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        sourceHA.toGaussianMonoidDegreeEvaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)))
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    (source_log_volume_eq :
      part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited =
        sourceHA.toGaussianMonoidDegreeEvaluation.toCuspLabelLogVolumeCompatibility)
    (target_log_volume_eq_theta :
      targetHA.toGaussianMonoidDegreeEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    {entry : IUTStage1NonarchimedeanInclusionData}
    (realifiedSource :
      NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer l X C entry
        holomorphicF holomorphicD monoAnalyticD)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeArakelovRealifiedFrobenioidEntry
    profile audited sourceHA targetHA canonical_one_preserved source_profile_eq
    source_log_volume_eq target_log_volume_eq_theta realifiedSource
    q_pilot_positive cTheta thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullPacketTargetSource_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (packetSource :
      NonarchimedeanThetaRootKummerForgettingPacketTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer l X C
        holomorphicF holomorphicD monoAnalyticD)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullPacketTargetSource
    profile audited alignment source_profile_eq packetSource cTheta
    thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullRealifiedFrobenioidEntry_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    {entry : IUTStage1NonarchimedeanInclusionData}
    (realifiedSource :
      NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer l X C entry
        holomorphicF holomorphicD monoAnalyticD)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullRealifiedFrobenioidEntry
    profile audited alignment source_profile_eq realifiedSource cTheta
    thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullRealifiedEntryWithSourceAudit_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    {entry : IUTStage1NonarchimedeanInclusionData}
    (realifiedSource :
      NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer l X C entry
        holomorphicF holomorphicD monoAnalyticD)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    let sourceCalibration :=
      realifiedSource.realifiedEntrySource.packetSource.sourceCalibration;
    let packetAlignment := realifiedSource.toPacketLocalSourceAlignment;
    packetAlignment.packetLocalObject_eq_entrySource =
        sourceCalibration.packetLocalObject_eq_entrySource ∧
      packetAlignment.entrySource_eq_monoAnalyticProduct =
        sourceCalibration.entrySource_eq_monoAnalyticProduct ∧
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume ∧
      ((package.preLedger.qSigned = package.preLedger.thetaSigned ∧
          package.preLedger.thetaSigned < 0) ∨
        (-1 : Real) < cTheta) :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullRealifiedEntryWithSourceAudit
    profile audited alignment source_profile_eq realifiedSource cTheta
    thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullRealifiedEntryStepXVerticalIQ_audit
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    {entry : IUTStage1NonarchimedeanInclusionData}
    (realifiedSource :
      NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer l X C entry
        holomorphicF holomorphicD monoAnalyticD)
    (stepXAlignment : StepXPacketNormalizedThetaSourceAlignment part)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer entry)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    targetSource.frobenioidMode.hasPreciseFrobenioidIsomorphisms = true ∧
      part.insulated_route.theta_source.thetaSourceAverage audited =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      (let sourceCalibration :=
          realifiedSource.realifiedEntrySource.packetSource.sourceCalibration;
       let packetAlignment := realifiedSource.toPacketLocalSourceAlignment;
       packetAlignment.packetLocalObject_eq_entrySource =
            sourceCalibration.packetLocalObject_eq_entrySource ∧
         packetAlignment.entrySource_eq_monoAnalyticProduct =
            sourceCalibration.entrySource_eq_monoAnalyticProduct ∧
         audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
            audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume) ∧
      ((package.preLedger.qSigned = package.preLedger.thetaSigned ∧
          package.preLedger.thetaSigned < 0) ∨
        (-1 : Real) < cTheta) :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullRealifiedEntryStepXVerticalIQ_audit
    profile audited alignment source_profile_eq realifiedSource stepXAlignment
    targetSource cTheta thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullRealifiedEntryVerticalIQ_audit
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    {entry : IUTStage1NonarchimedeanInclusionData}
    (realifiedSource :
      NonarchimedeanThetaRootRealifiedFrobenioidLogKummerEntrySource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer l X C entry
        holomorphicF holomorphicD monoAnalyticD)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer entry)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    targetSource.frobenioidMode.hasPreciseFrobenioidIsomorphisms = true ∧
      part.insulated_route.theta_source.thetaSourceAverage audited =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      (let sourceCalibration :=
          realifiedSource.realifiedEntrySource.packetSource.sourceCalibration;
       let packetAlignment := realifiedSource.toPacketLocalSourceAlignment;
       packetAlignment.packetLocalObject_eq_entrySource =
            sourceCalibration.packetLocalObject_eq_entrySource ∧
         packetAlignment.entrySource_eq_monoAnalyticProduct =
            sourceCalibration.entrySource_eq_monoAnalyticProduct ∧
         audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
            audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume) ∧
      ((package.preLedger.qSigned = package.preLedger.thetaSigned ∧
          package.preLedger.thetaSigned < 0) ∨
        (-1 : Real) < cTheta) :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullRealifiedEntryVerticalIQ_audit
    profile audited alignment source_profile_eq realifiedSource targetSource
    cTheta thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullThetaRootPacketLocalEntry_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (entry_mem :
      entrySource.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entrySource.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.toRealized.product.productLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (thetaSourceAverage_eq_packetNormalized :
      part.insulated_route.theta_source.thetaSourceAverage audited =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (thetaSourceAverage_eq_ind3Target :
      part.insulated_route.theta_source.thetaSourceAverage audited =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullThetaRootPacketLocalEntry
    profile audited alignment source_profile_eq thetaRootSource entrySource
    entry_mem kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    entrySource_eq_monoAnalyticProduct packetLocalObjectFinite_eq_ind3Source
    thetaSourceAverage_eq_packetNormalized thetaSourceAverage_eq_ind3Target
    cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy through the strongest
theta-root packet-local Step (x) route, with the two `(Ind3)` real
identifications supplied by one ordered-real-line alignment.
-/
theorem hodgeSHEIPLHullThetaRootPacketLocalEntryOrderedAlignment_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (entry_mem :
      entrySource.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entrySource.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.toRealized.product.productLogVolume)
    (orderedAlignment : Ind3OrderedRealLineAlignment part audited)
    (thetaSourceAverage_eq_packetNormalized :
      part.insulated_route.theta_source.thetaSourceAverage audited =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullThetaRootPacketLocalOrdered
    profile audited alignment source_profile_eq thetaRootSource entrySource
    entry_mem kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    entrySource_eq_monoAnalyticProduct orderedAlignment
    thetaSourceAverage_eq_packetNormalized cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy through the theta-root
packet-local Step (x) route, with ordered `(Ind3)` alignment and
packet-normalized theta calibration derived from a constant `ZMod l`
packet-normalized route.
-/
theorem hodgeSHEIPLHullThetaRootPacketLocalZMod_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (entrySource : NonarchimedeanPacketNormalizedEntryTargetSource audited)
    (entry_mem :
      entrySource.toEntry ∈
        audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entrySource.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entrySource.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.toRealized.product.productLogVolume)
    (orderedAlignment : Ind3OrderedRealLineAlignment part audited)
    (packetRoute :
      audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l)
    (theta_source_eq :
      part.insulated_route.theta_source = packetRoute.theta_source)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullThetaRootPacketLocalZMod
    profile audited alignment source_profile_eq thetaRootSource entrySource
    entry_mem kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization
    monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    entrySource_eq_monoAnalyticProduct orderedAlignment packetRoute
    theta_source_eq cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy through a packet-normalized
upper-semi Step (x) entry.  The entry source and its upper-semi membership are
kept in one object.
-/
theorem hodgeSHEIPLHullUpperSemiEntryZMod_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        upperSemiEntry.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      upperSemiEntry.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.toRealized.product.productLogVolume)
    (orderedAlignment : Ind3OrderedRealLineAlignment part audited)
    (packetRoute :
      audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l)
    (theta_source_eq :
      part.insulated_route.theta_source = packetRoute.theta_source)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullUpperSemiEntryZMod
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization
    holomorphicStructureForgotten holomorphic_structure_forgotten
    packetLocalObject_eq_entrySource entrySource_eq_monoAnalyticProduct
    orderedAlignment packetRoute theta_source_eq cTheta
    thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy through a packet-normalized
upper-semi Step (x) entry and a named source-side packet/product calibration.
-/
theorem hodgeSHEIPLHullSourceCalibratedZMod_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceCalibration :
      NonarchimedeanLogKummerPacketSourceCalibration
        audited package.logKummer upperSemiEntry.toEntry
        holomorphicF.toRealized holomorphicD.toRealized monoAnalyticD.toRealized)
    (orderedAlignment : Ind3OrderedRealLineAlignment part audited)
    (packetRoute :
      audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l)
    (theta_source_eq :
      part.insulated_route.theta_source = packetRoute.theta_source)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullSourceCalibratedZMod
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization
    holomorphicStructureForgotten holomorphic_structure_forgotten
    sourceCalibration orderedAlignment packetRoute theta_source_eq cTheta
    thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullSourceCalibratedStepXAligned_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceCalibration :
      NonarchimedeanLogKummerPacketSourceCalibration
        audited package.logKummer upperSemiEntry.toEntry
        holomorphicF.toRealized holomorphicD.toRealized monoAnalyticD.toRealized)
    (orderedAlignment : Ind3OrderedRealLineAlignment part audited)
    (stepXAlignment : StepXPacketNormalizedThetaSourceAlignment part)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullSourceCalibratedStepXAligned
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization
    holomorphicStructureForgotten holomorphic_structure_forgotten
    sourceCalibration orderedAlignment stepXAlignment cTheta
    thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullSourceAlignedStepXAligned_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited upperSemiEntry.toEntry monoAnalyticD.toRealized)
    (orderedAlignment : Ind3OrderedRealLineAlignment part audited)
    (stepXAlignment : StepXPacketNormalizedThetaSourceAlignment part)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullSourceAlignedStepXAligned
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceAlignment orderedAlignment
    stepXAlignment cTheta thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullSourceAlignedThetaTarget_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited upperSemiEntry.toEntry monoAnalyticD.toRealized)
    (thetaTargetAlignment : Ind3ThetaTargetAlignment part audited)
    (stepXAlignment : StepXPacketNormalizedThetaSourceAlignment part)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullSourceAlignedThetaTarget
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceAlignment thetaTargetAlignment
    stepXAlignment cTheta thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullSourceAlignedStepXVerticalIQTarget_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited upperSemiEntry.toEntry monoAnalyticD.toRealized)
    (stepXAlignment : StepXPacketNormalizedThetaSourceAlignment part)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer upperSemiEntry.toEntry)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    targetSource.frobenioidMode.hasPreciseFrobenioidIsomorphisms = true ∧
      ((package.preLedger.qSigned = package.preLedger.thetaSigned ∧
          package.preLedger.thetaSigned < 0) ∨
        (-1 : Real) < cTheta) :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullSourceAlignedStepXVerticalIQTarget
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceAlignment stepXAlignment targetSource
    cTheta thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullSourceAlignedStepXVerticalIQ_audit
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited upperSemiEntry.toEntry monoAnalyticD.toRealized)
    (stepXAlignment : StepXPacketNormalizedThetaSourceAlignment part)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer upperSemiEntry.toEntry)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    targetSource.frobenioidMode.hasPreciseFrobenioidIsomorphisms = true ∧
      part.insulated_route.theta_source.thetaSourceAverage audited =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume ∧
      ((package.preLedger.qSigned = package.preLedger.thetaSigned ∧
          package.preLedger.thetaSigned < 0) ∨
        (-1 : Real) < cTheta) :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullSourceAlignedStepXVerticalIQ_audit
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceAlignment stepXAlignment targetSource
    cTheta thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullSourceCalibratedVerticalIQ_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceCalibration :
      NonarchimedeanLogKummerPacketSourceCalibration
        audited package.logKummer upperSemiEntry.toEntry
        holomorphicF.toRealized holomorphicD.toRealized monoAnalyticD.toRealized)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer upperSemiEntry.toEntry)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullSourceCalibratedVerticalIQ
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceCalibration targetSource cTheta
    thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullSourceAlignedVerticalIQ_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (sourceAlignment :
      NonarchimedeanLogKummerPacketLocalSourceAlignment
        audited upperSemiEntry.toEntry monoAnalyticD.toRealized)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer upperSemiEntry.toEntry)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullSourceAlignedVerticalIQ
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten sourceAlignment targetSource cTheta
    thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullFiniteDivisorVerticalIQ_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    {product :
      IUTStage1BaseValuationTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (divisorPacket : IUTStage1FiniteDivisorTensorPacketProductSource product)
    (monoAnalyticTheater : QualitativeData.HodgeTheaterId)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD
          (divisorPacket.toRealifiedFrobenioidTensorPacketProductSource
            IUTStage1TensorPacketRealizationKind.monoAnalyticD
            monoAnalyticTheater))
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        upperSemiEntry.toEntry.sourceLogVolume)
    (packetLocalObjectFinite_eq_divisorRealified :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        divisorPacket.divisor.realifiedLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer upperSemiEntry.toEntry)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullFiniteDivisorVerticalIQ
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    divisorPacket monoAnalyticTheater kummerCompatibility forgettingCompatibility
    holomorphicF_realization holomorphicD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    packetLocalObjectFinite_eq_divisorRealified
    packetLocalObjectFinite_eq_ind3Source targetSource cTheta
    thetaSigned_le_cTheta_absLogQ

theorem hodgeSHEIPLHullPacketLocalVerticalIQ_cThetaDichotomy
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
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {F : Type u} [Field F] {X C : HyperbolicOrbicurveModel F}
    (alignment :
      IUTStage1HodgeSHEIPLHullRouteLogVolumeAlignment
        part audited record X C)
    (source_profile_eq :
      profile = IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    (thetaRootSource : IUTStage1ThetaRootCuspLabelSourcePackage l X C)
    (upperSemiEntry :
      NonarchimedeanPacketNormalizedUpperSemiEntrySource audited)
    (kummerCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicF holomorphicD)
    (forgettingCompatibility :
      IUTStage1RealifiedFrobenioidKummerCompatibility
        holomorphicD monoAnalyticD)
    (holomorphicF_realization :
      holomorphicF.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicF)
    (holomorphicD_realization :
      holomorphicD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.holomorphicD)
    (monoAnalyticD_realization :
      monoAnalyticD.toRealized.realization =
        IUTStage1TensorPacketRealizationKind.monoAnalyticD)
    (holomorphicStructureForgotten : Prop)
    (holomorphic_structure_forgotten : holomorphicStructureForgotten)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        upperSemiEntry.toEntry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      upperSemiEntry.toEntry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.toRealized.product.productLogVolume)
    (packetLocalObjectFinite_eq_ind3Source :
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume)
    (targetSource :
      NonarchimedeanLogKummerVerticalIQTargetSource
        audited (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer upperSemiEntry.toEntry)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_hodgeSHEIPLHullPacketLocalVerticalIQ
    profile audited alignment source_profile_eq thetaRootSource upperSemiEntry
    kummerCompatibility forgettingCompatibility holomorphicF_realization
    holomorphicD_realization monoAnalyticD_realization holomorphicStructureForgotten
    holomorphic_structure_forgotten packetLocalObject_eq_entrySource
    entrySource_eq_monoAnalyticProduct packetLocalObjectFinite_eq_ind3Source
    targetSource cTheta thetaSigned_le_cTheta_absLogQ

theorem theorem311MultiradialSourceRecord_endpoint
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    (record : IUTStage1Theorem311MultiradialSourceRecord package) :
    QualitativeData.HasStructuredIPL package.preLedger.output.family ∧
      QualitativeData.HasStructuredSHE package.preLedger.output.family ∧
      QualitativeData.HasStructuredAPT package.preLedger.output.family ∧
      record.thetaPossibleImages.union =
        package.preLedger.output.comparisons.targetUnion ∧
      record.thetaColumn.hasPilotMultiradiality = true ∧
      record.qColumn.hasPilotMultiradiality = false ∧
      record.thetaColumn.logShellTreatment ≠ record.qColumn.logShellTreatment :=
  let endpoint := record.sourceRecord_endpoint
  ⟨endpoint.1,
    endpoint.2.1,
    endpoint.2.2.1,
    endpoint.2.2.2.2.1,
    endpoint.2.2.2.2.2.1,
    endpoint.2.2.2.2.2.2.1,
    endpoint.2.2.2.2.2.2.2.1⟩

theorem iplLogVolumeTransport_endpoint
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    (transport : IUTStage1IPLLogVolumeTransport record) :
    QualitativeData.HasStructuredIPL package.preLedger.output.family ∧
      transport.iplDatum.link.source =
        transport.iplDatum.inputPrimeStrip ∧
      transport.iplDatum.link.target =
        transport.iplDatum.outputPrimeStrip ∧
      transport.targetLogVolume = transport.sourceLogVolume ∧
      transport.sourceTheater.side ≠ transport.targetTheater.side :=
  let endpoint := transport.transport_endpoint
  ⟨endpoint.1,
    endpoint.2.2.2.1,
    endpoint.2.2.2.2.1,
    endpoint.2.2.2.2.2.1,
    endpoint.2.2.2.2.2.2⟩

theorem sheSynchronizationSource_endpoint
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    {l : PrimeGeFive} {F : Type v} [Field F]
    {X C : HyperbolicOrbicurveModel F}
    (sync : IUTStage1SHESynchronizationSource record l X C) :
    QualitativeData.HasStructuredSHE package.preLedger.output.family ∧
      sync.toFactoredObligations.comparisonLevel =
        IUTStage1SquareComparisonLevel.pointwiseRepresentative ∧
      sync.toFactoredObligations.coordinateEquiv =
        Equiv.refl (ZMod l.value) ∧
      sync.toStructuredSHESquareWeightTransportAudit.preservationAudit.targetTransportedAverage =
        sync.toStructuredSHESquareWeightTransportAudit.preservationAudit.sourceAverage ∧
      record.bundle.structuredSHE.context.domainStructure.theater.side ≠
        record.bundle.structuredSHE.context.codomainStructure.theater.side :=
  let endpoint := sync.synchronization_endpoint
  ⟨endpoint.1,
    endpoint.2.1,
    endpoint.2.2.1,
    endpoint.2.2.2.2.1,
    endpoint.2.2.2.2.2⟩

theorem theorem311HullDetSourceConstructor_endpoint
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    (constructor :
      IUTStage1SourcePackage.IUTStage1Theorem311HullDetSourceConstructor
        record) :
    package.preLedger.output.Certified ∧
      constructor.toThetaPilotHullEndpoint.possible_images.union =
        record.thetaPossibleImages.union ∧
      Region.Subset record.thetaPossibleImages.union
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull
        package.preLedger.thetaSigned ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  let endpoint := constructor.hullDetSource_endpoint
  ⟨endpoint.1,
    endpoint.2.2.1,
    endpoint.2.2.2.1,
    endpoint.2.2.2.2.1,
    endpoint.2.2.2.2.2⟩

theorem theorem311HullDetSourceConstructorFromCanonicalApproximant_endpoint
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (approximantSource :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow
        (Point target) index)
    (theta_union_eq_record :
      approximantSource.thetaImageUnion =
        record.thetaPossibleImages.union.toSet)
    (approximant_eq_canonical_hull :
      approximantSource.approximantRegion =
        approximantSource.thetaHull)
    (measure_eq_hullLogVolume :
      package.preLedger.measure =
        approximantSource.hullData.toRegionMeasure)
    (determinant_bound :
      approximantSource.determinant.normalizedLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        canonicalApproximantHullDetData (record := record)
          operation hullOperation determinantOperation approximantSource
          theta_union_eq_record approximant_eq_canonical_hull
          measure_eq_hullLogVolume determinant_bound)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (normalization : package.preLedger.normalization) :
    let constructor :=
      ofCanonicalApproximant (record := record)
        operation hullOperation determinantOperation approximantSource
        theta_union_eq_record approximant_eq_canonical_hull
        measure_eq_hullLogVolume determinant_bound hbridge
        q_pilot_positive normalization;
    approximantSource.thetaImageUnion =
        record.thetaPossibleImages.union.toSet ∧
      approximantSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet ∧
      approximantSource.approximantLogVolume =
        approximantSource.determinant.normalizedLogVolume ∧
      package.preLedger.output.Certified ∧
      Region.Subset record.thetaPossibleImages.union
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull
        package.preLedger.thetaSigned ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  ofCanonicalApproximant_endpoint
    operation hullOperation determinantOperation approximantSource
    theta_union_eq_record approximant_eq_canonical_hull
    measure_eq_hullLogVolume determinant_bound hbridge
    q_pilot_positive normalization

theorem theorem311HullDetSourceConstructorFromWeightedDeterminant_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (possibleThetaImage : index -> Set (Point target))
    (qPilotRegion : Set (Point target))
    (approximant :
      IUTStage1HullLogVolumeApproximant
        hullData (⋃ i, possibleThetaImage i))
    (q_subset_approximant :
      qPilotRegion ⊆ approximant.approximant)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        approximant determinantSource)
    (theta_union_eq_record :
      (canonicalWeightedDeterminantApproximantSource
          hullData possibleThetaImage qPilotRegion approximant
          q_subset_approximant determinantSource compatibility).thetaImageUnion =
        record.thetaPossibleImages.union.toSet)
    (approximant_eq_canonical_hull :
      (canonicalWeightedDeterminantApproximantSource
          hullData possibleThetaImage qPilotRegion approximant
          q_subset_approximant determinantSource compatibility).approximantRegion =
        (canonicalWeightedDeterminantApproximantSource
          hullData possibleThetaImage qPilotRegion approximant
          q_subset_approximant determinantSource compatibility).thetaHull)
    (measure_eq_hullLogVolume :
      package.preLedger.measure = hullData.toRegionMeasure)
    (determinant_bound :
      determinantSource.determinantLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        IUTStage1SourceHullDetData.canonicalWeightedDeterminantHullDetBridgeData
          (package := package)
          operation hullOperation determinantOperation hullData
          possibleThetaImage qPilotRegion approximant q_subset_approximant
          determinantSource compatibility
          (canonicalApproximantThetaUnion_eq_targetUnion
            (record := record)
            (canonicalWeightedDeterminantApproximantSource
              hullData possibleThetaImage qPilotRegion approximant
              q_subset_approximant determinantSource compatibility)
            theta_union_eq_record)
          approximant_eq_canonical_hull measure_eq_hullLogVolume
          determinant_bound)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (normalization : package.preLedger.normalization) :
    let approximantSource :=
      canonicalWeightedDeterminantApproximantSource
        hullData possibleThetaImage qPilotRegion approximant
        q_subset_approximant determinantSource compatibility;
    let constructor :=
      ofCanonicalWeightedDeterminant (record := record)
        operation hullOperation determinantOperation hullData
        possibleThetaImage qPilotRegion approximant q_subset_approximant
        determinantSource compatibility theta_union_eq_record
        approximant_eq_canonical_hull measure_eq_hullLogVolume
        determinant_bound hbridge q_pilot_positive normalization;
    approximantSource.thetaImageUnion =
        record.thetaPossibleImages.union.toSet ∧
      approximantSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet ∧
      approximantSource.approximantLogVolume =
        determinantSource.determinantLogVolume ∧
      package.preLedger.output.Certified ∧
      Region.Subset record.thetaPossibleImages.union
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull
        package.preLedger.thetaSigned ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  ofCanonicalWeightedDeterminant_endpoint
    operation hullOperation determinantOperation hullData
    possibleThetaImage qPilotRegion approximant q_subset_approximant
    determinantSource compatibility theta_union_eq_record
    approximant_eq_canonical_hull measure_eq_hullLogVolume
    determinant_bound hbridge q_pilot_positive normalization

theorem theorem311HullDetSourceConstructorFromCanonicalHullWeighted_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (possibleThetaImage : index -> Set (Point target))
    (qPilotRegion : Set (Point target))
    (q_subset_hull :
      qPilotRegion ⊆ hullData.hullRegion (⋃ i, possibleThetaImage i))
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource)
    (theta_union_eq_record :
      (canonicalHullWeightedDeterminantApproximantSource
          hullData possibleThetaImage qPilotRegion q_subset_hull
          determinantSource compatibility).thetaImageUnion =
        record.thetaPossibleImages.union.toSet)
    (measure_eq_hullLogVolume :
      package.preLedger.measure = hullData.toRegionMeasure)
    (determinant_bound :
      determinantSource.determinantLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        canonicalHullWeightedDeterminantHullDetData (record := record)
          operation hullOperation determinantOperation hullData
          possibleThetaImage qPilotRegion q_subset_hull determinantSource
          compatibility theta_union_eq_record measure_eq_hullLogVolume
          determinant_bound)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (normalization : package.preLedger.normalization) :
    let approximantSource :=
      canonicalHullWeightedDeterminantApproximantSource
        hullData possibleThetaImage qPilotRegion q_subset_hull
        determinantSource compatibility;
    let constructor :=
      ofCanonicalHullWeightedDeterminant (record := record)
        operation hullOperation determinantOperation hullData
        possibleThetaImage qPilotRegion q_subset_hull determinantSource
        compatibility theta_union_eq_record measure_eq_hullLogVolume
        determinant_bound hbridge q_pilot_positive normalization;
    approximantSource.thetaImageUnion =
        record.thetaPossibleImages.union.toSet ∧
      approximantSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet ∧
      approximantSource.approximantRegion =
        approximantSource.thetaHull ∧
      approximantSource.approximantLogVolume =
        determinantSource.determinantLogVolume ∧
      package.preLedger.output.Certified ∧
      Region.Subset record.thetaPossibleImages.union
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull
        package.preLedger.thetaSigned ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  by
    intro approximantSource constructor
    have htarget :
        approximantSource.thetaImageUnion =
          package.preLedger.output.comparisons.targetUnion.toSet :=
      canonicalApproximantThetaUnion_eq_targetUnion
        (record := record) approximantSource theta_union_eq_record
    have happ_eq_hull :
        approximantSource.approximantRegion = approximantSource.thetaHull :=
      IUTStage1SourceHullDetData.canonicalHullWeightedDeterminantApproximantSource_eq_hull
        hullData possibleThetaImage qPilotRegion q_subset_hull
        determinantSource compatibility
    have happ_volume :
        approximantSource.approximantLogVolume =
          determinantSource.determinantLogVolume := by
      simpa [approximantSource,
        canonicalHullWeightedDeterminantApproximantSource,
        IUTStage1SourceHullDetData.canonicalHullWeightedDeterminantApproximantSource,
        IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow.approximantLogVolume,
        IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow.approximantRegion]
        using compatibility.approximant_eq_determinantLogVolume
    exact
      ⟨theta_union_eq_record,
        htarget,
        happ_eq_hull,
        happ_volume,
        constructor.algorithmCertified,
        constructor.recordPossibleImagesUnion_subset_hull,
        constructor.determinantVolumeBound,
        constructor.qSigned_le_thetaSigned⟩

theorem theorem311HullDetSourceConstructorFromCanonicalHullTensorPower_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (possibleThetaImage : index -> Set (Point target))
    (qPilotRegion : Set (Point target))
    (q_subset_hull :
      qPilotRegion ⊆ hullData.hullRegion (⋃ i, possibleThetaImage i))
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource)
    (theta_union_eq_record :
      (canonicalHullWeightedDeterminantApproximantSource
          hullData possibleThetaImage qPilotRegion q_subset_hull
          determinantSource compatibility).thetaImageUnion =
        record.thetaPossibleImages.union.toSet)
    (measure_eq_hullLogVolume :
      package.preLedger.measure = hullData.toRegionMeasure)
    (tensorPower_bound :
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        canonicalHullTensorPowerWeightedDeterminantHullDetData (record := record)
          operation hullOperation determinantOperation hullData
          possibleThetaImage qPilotRegion q_subset_hull determinantSource
          compatibility theta_union_eq_record measure_eq_hullLogVolume
          tensorPower_bound)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (normalization : package.preLedger.normalization) :
    let approximantSource :=
      canonicalHullWeightedDeterminantApproximantSource
        hullData possibleThetaImage qPilotRegion q_subset_hull
        determinantSource compatibility;
    let constructor :=
      ofCanonicalHullTensorPowerWeightedDeterminant (record := record)
        operation hullOperation determinantOperation hullData
        possibleThetaImage qPilotRegion q_subset_hull determinantSource
        compatibility theta_union_eq_record measure_eq_hullLogVolume
        tensorPower_bound hbridge q_pilot_positive normalization;
    approximantSource.thetaImageUnion =
        record.thetaPossibleImages.union.toSet ∧
      approximantSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet ∧
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned ∧
      approximantSource.approximantRegion =
        approximantSource.thetaHull ∧
      approximantSource.approximantLogVolume =
        determinantSource.determinantLogVolume ∧
      package.preLedger.output.Certified ∧
      Region.Subset record.thetaPossibleImages.union
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull
        package.preLedger.thetaSigned ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  ofCanonicalHullTensorPowerWeightedDeterminant_endpoint
    operation hullOperation determinantOperation hullData possibleThetaImage
    qPilotRegion q_subset_hull determinantSource compatibility
    theta_union_eq_record measure_eq_hullLogVolume tensorPower_bound hbridge
    q_pilot_positive normalization

theorem theorem311HullDetSourceConstructorFromQSubsetUnion_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (possibleThetaImage : index -> Set (Point target))
    (qPilotRegion : Set (Point target))
    (q_subset_thetaImageUnion :
      qPilotRegion ⊆ ⋃ i, possibleThetaImage i)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (⋃ i, possibleThetaImage i))
        determinantSource)
    (theta_union_eq_record :
      (canonicalHullWeightedDeterminantApproximantSourceOfQSubsetUnion
          hullData possibleThetaImage qPilotRegion q_subset_thetaImageUnion
          determinantSource compatibility).thetaImageUnion =
        record.thetaPossibleImages.union.toSet)
    (measure_eq_hullLogVolume :
      package.preLedger.measure = hullData.toRegionMeasure)
    (tensorPower_bound :
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        canonicalHullTensorPowerHullDetDataOfQSubsetUnion (record := record)
          operation hullOperation determinantOperation hullData
          possibleThetaImage qPilotRegion q_subset_thetaImageUnion
          determinantSource compatibility theta_union_eq_record
          measure_eq_hullLogVolume tensorPower_bound)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (normalization : package.preLedger.normalization) :
    let approximantSource :=
      canonicalHullWeightedDeterminantApproximantSourceOfQSubsetUnion
        hullData possibleThetaImage qPilotRegion q_subset_thetaImageUnion
        determinantSource compatibility;
    let constructor :=
      ofCanonicalHullTensorPowerOfQSubsetUnion (record := record)
        operation hullOperation determinantOperation hullData possibleThetaImage
        qPilotRegion q_subset_thetaImageUnion determinantSource compatibility
        theta_union_eq_record measure_eq_hullLogVolume tensorPower_bound hbridge
        q_pilot_positive normalization;
    qPilotRegion ⊆ approximantSource.thetaImageUnion ∧
      qPilotRegion ⊆ approximantSource.thetaHull ∧
      approximantSource.thetaImageUnion =
        record.thetaPossibleImages.union.toSet ∧
      approximantSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet ∧
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned ∧
      approximantSource.approximantRegion =
        approximantSource.thetaHull ∧
      approximantSource.approximantLogVolume =
        determinantSource.determinantLogVolume ∧
      package.preLedger.output.Certified ∧
      Region.Subset record.thetaPossibleImages.union
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull
        package.preLedger.thetaSigned ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  ofCanonicalHullTensorPowerOfQSubsetUnion_endpoint
    operation hullOperation determinantOperation hullData possibleThetaImage
    qPilotRegion q_subset_thetaImageUnion determinantSource compatibility
    theta_union_eq_record measure_eq_hullLogVolume tensorPower_bound hbridge
    q_pilot_positive normalization

theorem theorem311HullDetSourceConstructorFromRecordCanonicalHullTensorPower_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (qPilotRegion : Set (Point target))
    (q_subset_hull :
      qPilotRegion ⊆
        hullData.hullRegion (recordThetaPossibleImageUnion record))
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (recordThetaPossibleImageUnion record))
        determinantSource)
    (measure_eq_hullLogVolume :
      package.preLedger.measure = hullData.toRegionMeasure)
    (tensorPower_bound :
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        recordCanonicalHullTensorPowerWeightedDeterminantHullDetData
          (record := record)
          operation hullOperation determinantOperation hullData qPilotRegion
          q_subset_hull determinantSource compatibility measure_eq_hullLogVolume
          tensorPower_bound)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (normalization : package.preLedger.normalization) :
    let approximantSource :=
      canonicalHullWeightedDeterminantApproximantSource
        hullData (recordThetaPossibleImage record) qPilotRegion q_subset_hull
        determinantSource compatibility;
    let constructor :=
      ofRecordCanonicalHullTensorPowerWeightedDeterminant (record := record)
        operation hullOperation determinantOperation hullData qPilotRegion
        q_subset_hull determinantSource compatibility measure_eq_hullLogVolume
        tensorPower_bound hbridge q_pilot_positive normalization;
    approximantSource.thetaImageUnion =
        record.thetaPossibleImages.union.toSet ∧
      approximantSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet ∧
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned ∧
      approximantSource.approximantRegion =
        approximantSource.thetaHull ∧
      approximantSource.approximantLogVolume =
        determinantSource.determinantLogVolume ∧
      package.preLedger.output.Certified ∧
      Region.Subset record.thetaPossibleImages.union
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull
        package.preLedger.thetaSigned ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  ofRecordCanonicalHullTensorPowerWeightedDeterminant_endpoint
    operation hullOperation determinantOperation hullData qPilotRegion
    q_subset_hull determinantSource compatibility measure_eq_hullLogVolume
    tensorPower_bound hbridge q_pilot_positive normalization

theorem theorem311HullDetSourceConstructorFromRecordQSubsetUnion_endpoint
    {source target : Copy} {index : Type u} {β : Type v} [Fintype β]
    {package : IUTStage1SourcePackage source target index}
    {record : IUTStage1Theorem311MultiradialSourceRecord package}
    (operation : RealLineCopy.AlgorithmicOutput.HullDetOperationId)
    (hullOperation : RealLineCopy.AlgorithmicOutput.HullOperationId)
    (determinantOperation :
      RealLineCopy.AlgorithmicOutput.DeterminantLogVolumeOperationId)
    (hullData : IUTStage1HolomorphicHullLogVolumeShadow (Point target))
    (qPilotRegion : Set (Point target))
    (q_subset_recordUnion :
      qPilotRegion ⊆ recordThetaPossibleImageUnion record)
    (determinantSource :
      IUTStage1ArithmeticVectorBundleWeightedDeterminantSource β)
    (compatibility :
      IUTStage1HullApproximantWeightedDeterminantCompatibility
        (IUTStage1HullLogVolumeApproximant.canonical
          hullData (recordThetaPossibleImageUnion record))
        determinantSource)
    (measure_eq_hullLogVolume :
      package.preLedger.measure = hullData.toRegionMeasure)
    (tensorPower_bound :
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned)
    (hbridge :
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge =
        recordCanonicalHullTensorPowerHullDetDataOfQSubsetUnion
          (record := record)
          operation hullOperation determinantOperation hullData qPilotRegion
          q_subset_recordUnion determinantSource compatibility
          measure_eq_hullLogVolume tensorPower_bound)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (normalization : package.preLedger.normalization) :
    let q_subset_hull :
        qPilotRegion ⊆
          hullData.hullRegion (recordThetaPossibleImageUnion record) :=
      fun _ hx =>
        hullData.region_subset_hull (recordThetaPossibleImageUnion record)
          (q_subset_recordUnion hx);
    let approximantSource :=
      canonicalHullWeightedDeterminantApproximantSource
        hullData (recordThetaPossibleImage record) qPilotRegion q_subset_hull
        determinantSource compatibility;
    let constructor :=
      ofRecordCanonicalHullTensorPowerOfQSubsetUnion (record := record)
        operation hullOperation determinantOperation hullData qPilotRegion
        q_subset_recordUnion determinantSource compatibility
        measure_eq_hullLogVolume tensorPower_bound hbridge q_pilot_positive
        normalization;
    qPilotRegion ⊆ recordThetaPossibleImageUnion record ∧
      qPilotRegion ⊆ approximantSource.thetaHull ∧
      approximantSource.thetaImageUnion =
        record.thetaPossibleImages.union.toSet ∧
      approximantSource.thetaImageUnion =
        package.preLedger.output.comparisons.targetUnion.toSet ∧
      (IUTStage1NaiveFrobeniusTensorPowerLogVolume.ofWeightedDeterminant
          determinantSource).normalizedLogVolume <=
        package.preLedger.thetaSigned ∧
      approximantSource.approximantRegion =
        approximantSource.thetaHull ∧
      approximantSource.approximantLogVolume =
        determinantSource.determinantLogVolume ∧
      package.preLedger.output.Certified ∧
      Region.Subset record.thetaPossibleImages.union
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull ∧
      RegionMeasure.HasVolumeAtMost package.preLedger.measure
        (constructor.hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull
        package.preLedger.thetaSigned ∧
      package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  ofRecordCanonicalHullTensorPowerOfQSubsetUnion_endpoint
    operation hullOperation determinantOperation hullData qPilotRegion
    q_subset_recordUnion determinantSource compatibility measure_eq_hullLogVolume
    tensorPower_bound hbridge q_pilot_positive normalization

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

theorem gaussianDegreeEvaluations_factoredSHEEndpoint
    {source target : Copy} {index : Type u}
    {package : IUTStage1SourcePackage source target index}
    {bundle : IUTStage1Theorem311StructuredInputsWithSHE package}
    {l : PrimeGeFive}
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
        sourceEvaluation.environmentDegree) :
    let obligations :=
      IUTStage1StructuredSHEFactoredSquareFullLabelObligations.fromGaussianDegreeEvaluations
        (package := package) (bundle := bundle)
        coordinateEquiv sourceProfile targetProfile
        sourceEvaluation targetEvaluation coordinate_square_preserved
        fullLabelMap_preserved environmentDegree_preserved;
    let transportAudit := obligations.toStructuredSHESquareWeightTransportAudit;
    obligations.comparisonLevel =
        IUTStage1SquareComparisonLevel.pointwiseRepresentative ∧
      (∀ j : ZMod l.value,
        obligations.targetLogVolume.fullLabelLogVolume
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (obligations.coordinateEquiv j)) =
          obligations.sourceLogVolume.fullLabelLogVolume
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) ∧
      transportAudit.preservationAudit.targetTransportedAverage =
        transportAudit.preservationAudit.sourceAverage ∧
      obligations.coordinateEquiv = Equiv.refl (ZMod l.value) ∧
      bundle.structuredSHE.context.domainStructure.theater.side ≠
        bundle.structuredSHE.context.codomainStructure.theater.side :=
  IUTStage1StructuredSHEFactoredSquareFullLabelObligations.fromGaussianDegreeEvaluations_endpoint
    (package := package) (bundle := bundle)
    coordinateEquiv sourceProfile targetProfile
    sourceEvaluation targetEvaluation coordinate_square_preserved
    fullLabelMap_preserved environmentDegree_preserved

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

theorem finiteSymmetrySplit_endpoint
    (l : PrimeGeFive)
    (t j k x generator : ZMod l.value)
    (a : (ZMod l.value)ˣ) :
    (IUTStage1FLLabelTorsorModel.zmod l).torsor.vadd t j =
        zmodLabelTranslate l t j ∧
      (zmodUnitActionData l).smul
          (IUTStage1FLZModUnitSignLabelModel.zmod l).signUnitCompatibility.signUnit
          x =
        (zmodSignAction l).neg x ∧
      ((∃ b : (ZMod l.value)ˣ,
        b ∈ (IUTStage1FLZModUnitSignLabelModel.zmod l).signUnitSubgroup ∧
          (zmodUnitActionData l).smul b generator = x) ↔
        (zmodSignAction l).InSignOrbit x generator) ∧
      (IUTStage1ZModCuspFullLabel.fromCoordinate l j =
          IUTStage1ZModCuspFullLabel.fromCoordinate l k ↔
        j = k ∨ j = -k) ∧
      IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
        IUTStage1ZModCuspFullLabel.fromCoordinate l
          ((zmodUnitActionData l).smul a j) :=
  IUTStage1ZModCuspFullLabel.finiteSymmetrySplit_endpoint
    l t j k x generator a

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

theorem exists_labelIndependent_thetaPilot_degree_scale_iff_q_zero
    {l : PrimeGeFive}
    (profile :
      IUTStage1ZModSquareWeightProfile.RepresentativeThetaPilotDegreeProfile l) :
    (∃ scale : Real, ∀ j : ZMod l.value,
      profile.thetaPilotDegree j = scale * profile.qPilotDegree) ↔
      profile.qPilotDegree = 0 :=
  profile.exists_labelIndependent_scale_matches_theta_degrees_iff_qPilotDegree_eq_zero

theorem no_labelIndependent_thetaPilot_degree_scale_of_q_positive
    {l : PrimeGeFive}
    (profile :
      IUTStage1ZModSquareWeightProfile.RepresentativeThetaPilotDegreeProfile l)
    (q_pilot_positive : 0 < -profile.qPilotDegree)
    (scale : Real) :
    ¬ ∀ j : ZMod l.value,
      profile.thetaPilotDegree j = scale * profile.qPilotDegree :=
  profile.no_labelIndependent_scale_matches_theta_degrees_of_neg_pos
    q_pilot_positive scale

theorem not_exists_labelIndependent_thetaPilot_degree_scale_of_q_positive
    {l : PrimeGeFive}
    (profile :
      IUTStage1ZModSquareWeightProfile.RepresentativeThetaPilotDegreeProfile l)
    (q_pilot_positive : 0 < -profile.qPilotDegree) :
    ¬ ∃ scale : Real, ∀ j : ZMod l.value,
      profile.thetaPilotDegree j = scale * profile.qPilotDegree :=
  profile.not_exists_labelIndependent_scale_matches_theta_degrees_of_neg_pos
    q_pilot_positive

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

/--
IUT II, Remark 4.10.3, as a finite-label endpoint: the Gaussian value-group
formula restricts at `j = 1` to the identity degree, its square weight is `1`,
and this singleton restriction is not compatible with translation by `1`.
-/
theorem gaussianPivotalRestriction_identity_and_not_translationInvariant
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l) :
    evaluation.gaussianDegree
        (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        evaluation.environmentDegree ∧
      (IUTStage1ZModSquareWeightProfile.canonicalSquareWeights l).weight
          (1 : ZMod l.value) = 1 ∧
      ¬ ∀ j : ZMod l.value,
          j = 1 -> zmodLabelTranslate l (1 : ZMod l.value) j = 1 :=
  ⟨evaluation.gaussianDegree_one,
    IUTStage1ZModSquareWeightProfile.canonicalSquareWeights_weight_one,
    IUTStage1FLLabelTorsorModel.singletonOne_not_closed_under_translation_one l⟩

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

theorem remark3122_logLinkJuggling_ind3_endpoint
    {label : Type u} [Fintype label]
    (data : IUTStage1ProcessionNormalizedIndeterminacyCorridor label) :
    data.beforeIndeterminacy.averageLogVolume =
        data.afterInd1.averageLogVolume ∧
      data.afterInd1.averageLogVolume =
        data.afterInd2.averageLogVolume ∧
      data.afterInd2.averageLogVolume <= data.ind3UpperBound ∧
      data.beforeIndeterminacy.averageLogVolume <= data.ind3UpperBound :=
  IUTStage1ProcessionNormalizedIndeterminacyCorridor.remark3122_logLinkJuggling_ind3_endpoint
    data

theorem remark3122_logLinkJuggling_upperSemi_endpoint
    (data : IUTStage1Ind2UpperSemiPlaceFamilyCompatibility) :
    data.ind2Actions.nonarchimedeanPlaces =
        (data.upperSemiState.nonarchimedeanInclusions.map fun entry =>
          entry.place) ∧
      data.ind2Actions.archimedeanPlaces =
        (data.upperSemiState.archimedeanSurjections.map fun entry =>
          entry.place) ∧
      data.upperSemiState.logVolumeCompatible ∧
      data.upperSemiState.logVolumeCompatibility.sourceLogVolume <=
        data.upperSemiState.logVolumeCompatibility.targetLogVolume :=
  IUTStage1Ind2UpperSemiPlaceFamilyCompatibility.remark3122_logLinkJuggling_upperSemi_endpoint
    data

theorem zmodCuspLabelLogVolumeCompatibility_corridor_endpoint
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound) :
    let corridor :=
      ofZModCuspLabelLogVolumeCompatibilities before afterInd1 afterInd2
        ind3UpperBound hind1 hind2 hzero hcusp
    corridor.beforeIndeterminacy.averageLogVolume <= ind3UpperBound ∧
      corridor.afterInd1.averageLogVolume =
        corridor.beforeIndeterminacy.averageLogVolume ∧
      corridor.afterInd2.averageLogVolume =
        corridor.beforeIndeterminacy.averageLogVolume ∧
      corridor.afterInd2.averageLogVolume <= ind3UpperBound :=
  ofZModCuspLabelLogVolumeCompatibilities_endpoint
    before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp

theorem gaussianDegree_finiteQJSquaredSquareWeight_endpoint
    {l : PrimeGeFive}
    (evaluation :
      IUTStage1ZModSquareWeightProfile.GaussianMonoidDegreeEvaluation l)
    (profile : IUTStage1ZModSquareWeightProfile l) :
    (∀ j : ZMod l.value, j.val ≤ l.value / 2 ->
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
        profile.weight j * evaluation.environmentDegree) ∧
      evaluation.gaussianDegree IUTStage1ZModCuspFullLabel.zero = 0 ∧
      evaluation.gaussianDegree
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value)) =
        evaluation.environmentDegree ∧
      profile.weight (1 : ZMod l.value) = 1 ∧
      (∀ j : ZMod l.value, j ≠ 0 ->
        evaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l (-j)) =
          evaluation.gaussianDegree
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) :=
  evaluation.finiteQJSquaredSquareWeight_endpoint profile

theorem stepXToHullUpperRay_q_le_theta
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label) :
    data.qPilotLogVolume <= data.thetaHullLogVolume :=
  data.qPilotLogVolume_le_thetaHullLogVolume

theorem zmodCuspLabelLogVolumeCompatibility_stepXToHull_endpoint
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume) :
    let data : IUTStage1StepXToHullUpperRayLogVolume (ZMod l.value) :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2
        ind3UpperBound hind1 hind2 hzero hcusp determinant thetaHullLogVolume
        theta_eq_ind3Upper theta_eq_normalized_determinant
    data.qPilotLogVolume = before.toLabelAveraged.averageLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaHullLogVolume = determinant.normalizedLogVolume :=
  IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities_endpoint
    before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
    determinant thetaHullLogVolume theta_eq_ind3Upper
    theta_eq_normalized_determinant

theorem zmodCuspLabelLogVolumeCompatibility_stepXToHullApproximant_endpoint
    {l : PrimeGeFive} {α : Type u} {ι : Type v}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (hullSource :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι)
    (theta_eq_ind3Upper :
      hullSource.approximantLogVolume = ind3UpperBound)
    (q_eq_beforeAverage :
      hullSource.qPilotLogVolume = before.toLabelAveraged.averageLogVolume) :
    let data :=
      open IUTStage1StepXToHullUpperRayLogVolume in
        ofZModCuspLabelLogVolumeCompatibilitiesAndHullApproximant
          before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
          hullSource theta_eq_ind3Upper q_eq_beforeAverage
    data.qPilotLogVolume = hullSource.qPilotLogVolume ∧
      data.thetaHullLogVolume = hullSource.approximantLogVolume ∧
      hullSource.thetaImageUnionLogVolume <= data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaHullLogVolume = hullSource.determinant.normalizedLogVolume :=
  by
    open IUTStage1StepXToHullUpperRayLogVolume in
      exact ofZModCuspLabelLogVolumeCompatibilitiesAndHullApproximant_endpoint
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        hullSource theta_eq_ind3Upper q_eq_beforeAverage

theorem stepXToHullApproximantHandoff_endpoint
    {label : Type u} [Fintype label] {α : Type v} {ι : Type w}
    (corridor : IUTStage1ProcessionNormalizedIndeterminacyCorridor label)
    (hullSource :
      IUTStage1ThetaPossibleImagesHullApproximantLogVolumeShadow α ι)
    (handoff :
      IUTStage1StepXHullApproximantHandoff corridor hullSource) :
    let data : IUTStage1StepXToHullUpperRayLogVolume label :=
      IUTStage1StepXToHullUpperRayLogVolume.ofCorridorAndHullApproximantHandoff
        corridor hullSource handoff
    data.qPilotLogVolume = hullSource.qPilotLogVolume ∧
      data.thetaHullLogVolume = hullSource.approximantLogVolume ∧
      hullSource.thetaImageUnionLogVolume <= data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.toHullDetPilotUpperRayLogVolume.qPilotLogVolume ∈
        data.toHullDetPilotUpperRayLogVolume.upperRay ∧
      data.thetaHullLogVolume = hullSource.determinant.normalizedLogVolume :=
  IUTStage1StepXToHullUpperRayLogVolume.ofCorridorAndHullApproximantHandoff_endpoint
    corridor hullSource handoff

theorem zmodCuspLabelLogVolumeCompatibility_stepXToHull_q_mem
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant
    data.qPilotLogVolume ∈
      data.toHullDetPilotUpperRayLogVolume.upperRay :=
  IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities_q_mem_upperRay
    before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
    determinant thetaHullLogVolume theta_eq_ind3Upper
    theta_eq_normalized_determinant

theorem zmodCuspLabelLogVolumeCompatibility_thetaFiniteEndpoint
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let endpoint := data.toThetaFiniteLogVolumeEndpoint;
    endpoint.thetaExtended.IsFinite ∧
      endpoint.thetaExtended ≠
        IUTStage1ExtendedSignedLogVolume.plusInfinity ∧
      endpoint.thetaRealLogVolume = thetaHullLogVolume ∧
      endpoint.upperRayData.qPilotLogVolume <=
        endpoint.thetaRealLogVolume := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_thetaFiniteEndpoint
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant

theorem zmodCuspLabelLogVolumeCompatibility_thetaFiniteTensorPowerWarning
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (tensorPower : Nat)
    (tensor_power_ge_two : 2 ≤ tensorPower)
    (theta_neg : thetaHullLogVolume < 0) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let finite := data.toThetaFiniteLogVolumeEndpoint;
    let tensor :=
      data.toThetaPilotTensorPowerLogVolume
        tensorPower tensor_power_ge_two;
    tensor.tensorPowerLogVolume < finite.thetaRealLogVolume ∧
      tensor.tensorPowerUpperRay ⊆ finite.upperRayData.upperRay ∧
      finite.thetaRealLogVolume ∉ tensor.tensorPowerUpperRay := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_thetaFinite_tensorPower_warning
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant tensorPower tensor_power_ge_two
      theta_neg

theorem zmodCuspLabelLogVolumeCompatibility_globalFrobenioidCalibration
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (localExponent : Int)
    (localPrimeStepLogVolume : Real) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let finite := data.toThetaFiniteLogVolumeEndpoint;
    let localDatum :=
      data.toLocalFrobenioidLogVolumeAmbiguity
        localExponent localPrimeStepLogVolume;
    let global :=
      data.toGlobalFrobenioidLogVolumeCalibration
        localExponent localPrimeStepLogVolume;
    localDatum.unshiftedLogVolume = finite.thetaRealLogVolume ∧
      localDatum.shiftedLogVolume =
        finite.thetaRealLogVolume +
          (localExponent : Real) * localPrimeStepLogVolume ∧
      global.calibratedLogVolume = finite.thetaRealLogVolume ∧
      global.calibratedLogVolume = localDatum.unshiftedLogVolume ∧
      (global.calibratedLogVolume = localDatum.shiftedLogVolume ↔
        (localDatum.localExponent : Real) *
          localDatum.localPrimeStepLogVolume = 0) ∧
      (localExponent ≠ 0 →
        localPrimeStepLogVolume ≠ 0 →
          global.calibratedLogVolume ≠
            localDatum.shiftedLogVolume) := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact
      (ofZModCuspLabelLogVolumeCompatibilities before afterInd1 afterInd2
        ind3UpperBound hind1 hind2 hzero hcusp determinant thetaHullLogVolume
        theta_eq_ind3Upper theta_eq_normalized_determinant).thetaFinite_globalFrobenioidCalibration
          localExponent localPrimeStepLogVolume

theorem zmodCuspLabelLogVolumeCompatibility_globalFrobenioidCThetaEndpoint
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (localExponent : Int)
    (localPrimeStepLogVolume : Real)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <=
        cTheta * (-before.toLabelAveraged.averageLogVolume)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let finite := data.toThetaFiniteLogVolumeEndpoint;
    let global :=
      data.toGlobalFrobenioidLogVolumeCalibration
        localExponent localPrimeStepLogVolume;
    let endpoint :=
      data.toQPilotTwoComputationCThetaEndpoint
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ;
    global.calibratedLogVolume = finite.thetaRealLogVolume ∧
      global.calibratedLogVolume = thetaHullLogVolume ∧
      (-1 : Real) <= endpoint.cTheta ∧
      (global.calibratedLogVolume = global.localData.shiftedLogVolume ↔
        (global.localData.localExponent : Real) *
          global.localData.localPrimeStepLogVolume = 0) ∧
      (localExponent ≠ 0 →
        localPrimeStepLogVolume ≠ 0 →
          global.calibratedLogVolume ≠
            global.localData.shiftedLogVolume) := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    let data :=
      ofZModCuspLabelLogVolumeCompatibilities before afterInd1 afterInd2
        ind3UpperBound hind1 hind2 hzero hcusp determinant thetaHullLogVolume
        theta_eq_ind3Upper theta_eq_normalized_determinant
    exact
      data.thetaFinite_globalFrobenioidCThetaEndpoint
        localExponent localPrimeStepLogVolume q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ

theorem zmodCuspLabelLogVolumeCompatibility_globalFrobenioidCTheta_zero_branch
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (localExponent : Int)
    (localPrimeStepLogVolume : Real)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <=
        cTheta * (-before.toLabelAveraged.averageLogVolume)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let finite := data.toThetaFiniteLogVolumeEndpoint;
    let global :=
      data.toGlobalFrobenioidLogVolumeCalibration
        localExponent localPrimeStepLogVolume;
    let endpoint :=
      data.toQPilotTwoComputationCThetaEndpoint
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ;
    global.calibratedLogVolume = finite.thetaRealLogVolume ∧
      global.calibratedLogVolume = thetaHullLogVolume ∧
      (-1 : Real) <= endpoint.cTheta ∧
      (global.calibratedLogVolume = global.localData.shiftedLogVolume ↔
        localExponent = 0 ∨ localPrimeStepLogVolume = 0) := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    let data :=
      ofZModCuspLabelLogVolumeCompatibilities before afterInd1 afterInd2
        ind3UpperBound hind1 hind2 hzero hcusp determinant thetaHullLogVolume
        theta_eq_ind3Upper theta_eq_normalized_determinant
    exact
      data.thetaFinite_globalFrobenioidCThetaEndpoint_eq_shifted_iff_exponent_zero_or_step_zero
        localExponent localPrimeStepLogVolume q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ

theorem zmodCuspLabelLogVolumeCompatibility_boundaryCTheta_ordered_fixed_q_shift
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (localExponent : Int)
    (localPrimeStepLogVolume : Real)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <=
        cTheta * (-before.toLabelAveraged.averageLogVolume))
    (hC : cTheta = (-1 : Real)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let twoComputation := data.toQPilotTwoComputationLogVolume;
    let global :=
      data.toGlobalFrobenioidLogVolumeCalibration
        localExponent localPrimeStepLogVolume;
    (twoComputation.inputPrimeStripLogVolume <
        global.localData.shiftedLogVolume ↔
        0 < (localExponent : Real) * localPrimeStepLogVolume) ∧
      (global.localData.shiftedLogVolume <
        twoComputation.inputPrimeStripLogVolume ↔
        (localExponent : Real) * localPrimeStepLogVolume < 0) ∧
      (twoComputation.outputHullLogVolume <
        global.localData.shiftedLogVolume ↔
        0 < (localExponent : Real) * localPrimeStepLogVolume) ∧
      (global.localData.shiftedLogVolume <
        twoComputation.outputHullLogVolume ↔
        (localExponent : Real) * localPrimeStepLogVolume < 0) := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    let data :=
      ofZModCuspLabelLogVolumeCompatibilities before afterInd1 afterInd2
        ind3UpperBound hind1 hind2 hzero hcusp determinant thetaHullLogVolume
        theta_eq_ind3Upper theta_eq_normalized_determinant
    exact
      data.boundaryCTheta_localShift_orderedAround_twoComputation
        localExponent localPrimeStepLogVolume q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ hC

theorem zmodCuspLabelLogVolumeCompatibility_signedEndpointCorollary312
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let endpoint :=
      data.toQPilotTwoComputationSignedEndpoint q_pilot_positive;
    Corollary312Inequality
      endpoint.comparisonData.thetaPilot
      endpoint.comparisonData.qPilot := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_signedEndpointCorollary312
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant q_pilot_positive

theorem zmodCuspLabelLogVolumeCompatibility_signedEndpointCorollary312_magnitudes
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let endpoint :=
      data.toQPilotTwoComputationSignedEndpoint q_pilot_positive;
    endpoint.comparisonData.qPilot.value =
        -before.toLabelAveraged.averageLogVolume ∧
      endpoint.comparisonData.thetaPilot.value =
        -thetaHullLogVolume ∧
      Corollary312Inequality
        endpoint.comparisonData.thetaPilot
        endpoint.comparisonData.qPilot := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_signedEndpointCorollary312_magnitudes
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant q_pilot_positive

theorem zmodCuspLabelLogVolumeCompatibility_thetaFinite_signedEndpoint_agree
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let finite := data.toThetaFiniteLogVolumeEndpoint;
    let signed := data.toQPilotTwoComputationSignedEndpoint q_pilot_positive;
    signed.comparisonData.qSigned = finite.upperRayData.qPilotLogVolume ∧
      signed.comparisonData.thetaSigned = finite.thetaRealLogVolume ∧
      finite.upperRayData.qPilotLogVolume <= finite.thetaRealLogVolume ∧
      Corollary312Inequality
        signed.comparisonData.thetaPilot
        signed.comparisonData.qPilot := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_thetaFinite_signedEndpoint_agree
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant q_pilot_positive

theorem zmodCuspLabelLogVolumeCompatibility_signedEndpointDistinctIntertwining
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (transport : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : transport.qIntertwining) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let finite := data.toThetaFiniteLogVolumeEndpoint;
    let signed := data.toQPilotTwoComputationSignedEndpoint q_pilot_positive;
    signed.comparisonData.qSigned = finite.upperRayData.qPilotLogVolume ∧
      signed.comparisonData.thetaSigned = finite.thetaRealLogVolume ∧
      Corollary312Inequality
        signed.comparisonData.thetaPilot
        signed.comparisonData.qPilot ∧
      transport.qLabel ≠ transport.thetaLabel ∧
      transport.weakenedPrimeStripCannotDistinguishPilots ∧
      transport.qIntertwining ∧
      transport.thetaIntertwiningUpToIndeterminacy := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact
      (ofZModCuspLabelLogVolumeCompatibilities before afterInd1 afterInd2
        ind3UpperBound hind1 hind2 hzero hcusp determinant thetaHullLogVolume
        theta_eq_ind3Upper theta_eq_normalized_determinant)
        |>.thetaFinite_signedEndpoint_agree_with_distinctIntertwining
          q_pilot_positive transport hq

theorem zmodCuspLabelLogVolumeCompatibility_remark3122UpperRayBound
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (h epsilon : Real)
    (h_pos : 0 < h)
    (epsilon_pos : 0 < epsilon)
    (q_eq_neg_h :
      before.toLabelAveraged.averageLogVolume = -h)
    (theta_eq_neg_two_h_add_epsilon :
      thetaHullLogVolume = -2 * h + epsilon) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let toy :=
      data.toRemark3122IntertwiningUpperRayBound h epsilon h_pos
        epsilon_pos q_eq_neg_h theta_eq_neg_two_h_add_epsilon;
    toy.qAssignment ∈ toy.thetaUpperRay ∧
      (-h : Real) <= -2 * h + epsilon ∧
      h <= epsilon := by
  intro data toy
  exact data.remark3122UpperRayBound_fromThetaFinite
    h epsilon h_pos epsilon_pos q_eq_neg_h theta_eq_neg_two_h_add_epsilon

theorem zmodCuspLabelLogVolumeCompatibility_statementEndpoint
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <= cTheta * (-before.toLabelAveraged.averageLogVolume)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant
    let endpoint :=
      data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ
    endpoint.finiteEndpoint.upperRayData.qPilotLogVolume =
        before.toLabelAveraged.averageLogVolume ∧
      endpoint.finiteEndpoint.upperRayData.qPilotLogVolume ∈
        endpoint.finiteEndpoint.upperRayData.upperRay ∧
      endpoint.thetaRealLogVolume = ind3UpperBound ∧
      endpoint.pilotBoundary.qStatus =
        IUTStage1Corollary312PilotIndeterminacyStatus.notSubjectToIndeterminacies ∧
      endpoint.pilotBoundary.thetaStatus =
        IUTStage1Corollary312PilotIndeterminacyStatus.subjectToIndeterminacies ∧
      endpoint.pilotBoundary.thetaStatus ≠ endpoint.pilotBoundary.qStatus :=
  IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities_statementEndpoint
    before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
    determinant thetaHullLogVolume theta_eq_ind3Upper
    theta_eq_normalized_determinant pilotBoundary q_pilot_positive cTheta
    thetaHull_le_cTheta_absLogQ

theorem zmodCuspLabelLogVolumeCompatibility_thetaNonnegativeBranch
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <= cTheta * (-before.toLabelAveraged.averageLogVolume))
    (theta_nonnegative : 0 <= ind3UpperBound) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant
    let endpoint :=
      data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ
    before.toLabelAveraged.averageLogVolume < ind3UpperBound ∧
      0 <= endpoint.cTheta := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_thetaNonnegativeBranch
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ theta_nonnegative

theorem zmodCuspLabelLogVolumeCompatibility_corollary312_of_thetaNonnegative
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <= cTheta * (-before.toLabelAveraged.averageLogVolume))
    (theta_nonnegative : 0 <= ind3UpperBound) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant
    let endpoint :=
      data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ
    ∃ hTheta : 0 <= endpoint.thetaRealLogVolume,
      Corollary312Inequality
        (endpoint.toThetaSignReduction.comparisonDataOfThetaNonnegative
          hTheta).thetaPilot
        (endpoint.toThetaSignReduction.comparisonDataOfThetaNonnegative
          hTheta).qPilot := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_corollary312_of_thetaNonnegative
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ theta_nonnegative

theorem zmodCuspLabelLogVolumeCompatibility_cThetaLowerBound
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <= cTheta * (-before.toLabelAveraged.averageLogVolume)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant
    let endpoint :=
      data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ
    before.toLabelAveraged.averageLogVolume <=
        cTheta * (-before.toLabelAveraged.averageLogVolume) ∧
      (-1 : Real) <= endpoint.cTheta ∧
      ¬ endpoint.cTheta < (-1 : Real) := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_cThetaLowerBound
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant pilotBoundary q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ

theorem zmodCuspLabelLogVolumeCompatibility_fixedQPilotCThetaEndpoint
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <= cTheta * (-before.toLabelAveraged.averageLogVolume)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let endpoint :=
      data.toQPilotTwoComputationCThetaEndpoint
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ;
    -endpoint.absLogQ <= endpoint.cTheta * endpoint.absLogQ ∧
      (-1 : Real) <= endpoint.cTheta ∧
      ¬ (cTheta < (-1 : Real)) := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_fixedQPilotCThetaEndpoint
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ

theorem zmodCuspLabelLogVolumeCompatibility_signedCThetaComparison
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <= cTheta * (-before.toLabelAveraged.averageLogVolume)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let endpoint :=
      data.toQPilotTwoComputationCThetaEndpoint
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ;
    endpoint.toSignedCThetaBound.comparison.qSigned =
        before.toLabelAveraged.averageLogVolume ∧
      endpoint.toSignedCThetaBound.comparison.thetaSigned =
        thetaHullLogVolume ∧
      endpoint.toSignedCThetaBound.comparison.qSigned <=
        endpoint.toSignedCThetaBound.comparison.thetaSigned ∧
      endpoint.toSignedCThetaBound.comparison.qSigned <=
        endpoint.toSignedCThetaBound.cTheta *
          (-endpoint.toSignedCThetaBound.comparison.qSigned) ∧
      (-1 : Real) <= endpoint.toSignedCThetaBound.cTheta := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_signedCThetaComparison
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ

theorem zmodCuspLabelLogVolumeCompatibility_qLambdaCThetaEndpoint
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (lambda : Rat)
    (lambda_pos : 0 < lambda)
    (cTheta : Real)
    (qLambda_le_thetaHull :
      -((lambda : Real) *
        (-before.toLabelAveraged.averageLogVolume)) <= thetaHullLogVolume)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <= cTheta * (-before.toLabelAveraged.averageLogVolume)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let endpoint :=
      data.toQLambdaCThetaBound q_pilot_positive lambda lambda_pos cTheta
        qLambda_le_thetaHull thetaHull_le_cTheta_absLogQ;
    endpoint.qLambdaSigned =
        -((lambda : Real) *
          (-before.toLabelAveraged.averageLogVolume)) ∧
      endpoint.thetaSigned = thetaHullLogVolume ∧
      -((lambda : Real)) <= endpoint.cTheta ∧
      (lambda <= 1 → (-1 : Real) <= endpoint.cTheta) ∧
      (lambda < 1 → (-1 : Real) < endpoint.cTheta) := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact
      (ofZModCuspLabelLogVolumeCompatibilities before afterInd1 afterInd2
        ind3UpperBound hind1 hind2 hzero hcusp determinant thetaHullLogVolume
        theta_eq_ind3Upper theta_eq_normalized_determinant).qLambdaCTheta_endpoint
          q_pilot_positive lambda lambda_pos cTheta qLambda_le_thetaHull
          thetaHull_le_cTheta_absLogQ

theorem zmodCuspLabelLogVolumeCompatibility_standardQLambdaCThetaEndpoint
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <= cTheta * (-before.toLabelAveraged.averageLogVolume)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    (data.toStandardQLambdaCThetaBound
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ).qLambdaSigned =
        before.toLabelAveraged.averageLogVolume ∧
      (data.toStandardQLambdaCThetaBound
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ).thetaSigned =
        thetaHullLogVolume ∧
      (-1 : Real) <=
        (data.toStandardQLambdaCThetaBound
          q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ).cTheta := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    let data :=
      ofZModCuspLabelLogVolumeCompatibilities before afterInd1 afterInd2
        ind3UpperBound hind1 hind2 hzero hcusp determinant thetaHullLogVolume
        theta_eq_ind3Upper theta_eq_normalized_determinant
    exact
      data.standardQLambdaCTheta_endpoint
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_qLambdaCTheta_boundary_or_strict
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (lambda : Rat)
    (lambda_pos : 0 < lambda)
    (cTheta : Real)
    (qLambda_le_thetaHull :
      -((lambda : Real) *
        (-data.corridor.beforeIndeterminacy.averageLogVolume)) <=
        data.thetaHullLogVolume)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    cTheta = -((lambda : Real)) ∨ -((lambda : Real)) < cTheta :=
  data.qLambdaCTheta_boundary_or_strict q_pilot_positive lambda lambda_pos
    cTheta qLambda_le_thetaHull thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_standardQLambdaCTheta_strict_of_qPilot_lt_theta
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume))
    (hstrict : data.qPilotLogVolume < data.thetaHullLogVolume) :
    (-1 : Real) < cTheta :=
  data.standardQLambdaCTheta_strict_of_qPilot_lt_thetaHullLogVolume
    q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hstrict

theorem stepXToHullUpperRay_standardQLambdaCTheta_qPilot_eq_theta_of_boundary
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume))
    (hC : cTheta = (-1 : Real)) :
    data.qPilotLogVolume = data.thetaHullLogVolume :=
  data.standardQLambdaCTheta_qPilot_eq_thetaHullLogVolume_of_cTheta_eq_neg_one
    q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hC

theorem zmodCuspLabelLogVolumeCompatibility_signedCorollary312
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <= cTheta * (-before.toLabelAveraged.averageLogVolume)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let endpoint :=
      data.toQPilotTwoComputationCThetaEndpoint
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ;
    Corollary312Inequality
      endpoint.toSignedCThetaBound.comparison.thetaPilot
      endpoint.toSignedCThetaBound.comparison.qPilot := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_signedCorollary312
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ

theorem zmodCuspLabelLogVolumeCompatibility_signedCorollary312_magnitudes
    {l : PrimeGeFive}
    (before afterInd1 afterInd2 :
      IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (ind3UpperBound : Real)
    (hind1 :
      ∀ j : ZMod l.value,
        before.normalizedLogVolume j =
          afterInd1.normalizedLogVolume j)
    (hind2 :
      ∀ j : ZMod l.value,
        afterInd1.normalizedLogVolume j =
          afterInd2.normalizedLogVolume j)
    (hzero : afterInd2.zeroLogVolume <= ind3UpperBound)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      afterInd2.cuspClassLogVolume label <= ind3UpperBound)
    (determinant :
      IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (thetaHullLogVolume : Real)
    (theta_eq_ind3Upper :
      thetaHullLogVolume = ind3UpperBound)
    (theta_eq_normalized_determinant :
      thetaHullLogVolume = determinant.normalizedLogVolume)
    (q_pilot_positive :
      0 < -before.toLabelAveraged.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      thetaHullLogVolume <= cTheta * (-before.toLabelAveraged.averageLogVolume)) :
    let data :=
      IUTStage1StepXToHullUpperRayLogVolume.ofZModCuspLabelLogVolumeCompatibilities
        before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
        determinant thetaHullLogVolume theta_eq_ind3Upper
        theta_eq_normalized_determinant;
    let endpoint :=
      data.toQPilotTwoComputationCThetaEndpoint
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ;
    endpoint.toSignedCThetaBound.comparison.qPilot.value =
        -before.toLabelAveraged.averageLogVolume ∧
      endpoint.toSignedCThetaBound.comparison.thetaPilot.value =
        -thetaHullLogVolume ∧
      Corollary312Inequality
        endpoint.toSignedCThetaBound.comparison.thetaPilot
        endpoint.toSignedCThetaBound.comparison.qPilot := by
  open IUTStage1StepXToHullUpperRayLogVolume in
    exact ofZModCuspLabelLogVolumeCompatibilities_signedCorollary312_magnitudes
      before afterInd1 afterInd2 ind3UpperBound hind1 hind2 hzero hcusp
      determinant thetaHullLogVolume theta_eq_ind3Upper
      theta_eq_normalized_determinant q_pilot_positive cTheta
      thetaHull_le_cTheta_absLogQ

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

theorem stepXToHullUpperRay_logKummerVerticalShiftCalibration_endpoint
    {label : Type u} [Fintype label]
    {data : IUTStage1StepXToHullUpperRayLogVolume label}
    (calibration :
      IUTStage1StepXToHullUpperRayLogVolume.LogKummerVerticalShiftCalibration
        data) :
    calibration.globalData.calibratedLogVolume =
        data.thetaHullLogVolume ∧
      data.qPilotLogVolume <= calibration.globalData.calibratedLogVolume ∧
      data.toQPilotTwoComputationLogVolume.inputPrimeStripLogVolume <=
        calibration.globalData.calibratedLogVolume ∧
      data.toQPilotTwoComputationLogVolume.outputHullLogVolume <=
        calibration.globalData.calibratedLogVolume ∧
      (calibration.globalData.calibratedLogVolume =
          calibration.localData.shiftedLogVolume ↔
        calibration.localExponent = 0 ∨
          calibration.localPrimeStepLogVolume = 0) :=
  calibration.endpoint

theorem stepXToHullUpperRay_cq3Cq4ClosedLoopGuard_endpoint
    {label : Type u} [Fintype label]
    {data : IUTStage1StepXToHullUpperRayLogVolume label}
    (guard :
      IUTStage1StepXToHullUpperRayLogVolume.CQ3CQ4ClosedLoopGuard data) :
    guard.cq3HullDetLogVolume = guard.cq4CalibratedLogVolume ∧
      data.qPilotLogVolume <= guard.cq3HullDetLogVolume ∧
      data.toQPilotTwoComputationLogVolume.inputPrimeStripLogVolume <=
        guard.cq4CalibratedLogVolume ∧
      data.toQPilotTwoComputationLogVolume.outputHullLogVolume <=
        guard.cq4CalibratedLogVolume ∧
      (guard.calibration.localData.shiftedLogVolume =
          guard.cq4CalibratedLogVolume ↔
        guard.calibration.localExponent = 0 ∨
          guard.calibration.localPrimeStepLogVolume = 0) :=
  guard.endpoint

theorem stepXToHullUpperRay_cq3Cq4LocalGlobalClosedLoopGuard_endpoint
    {label : Type u} [Fintype label]
    {data : IUTStage1StepXToHullUpperRayLogVolume label}
    {V : Type u} [Fintype V]
    (backed :
      IUTStage1StepXToHullUpperRayLogVolume.CQ3CQ4LocalGlobalClosedLoopGuard
        data V) :
    (∀ v : V,
      ((backed.collection.localization v).extensionDegree : Real) *
          (backed.collection.localObject v).realifiedLogVolume =
        backed.guard.cq3HullDetLogVolume ∧
      ((backed.collection.localization v).extensionDegree : Real) *
          (backed.collection.localObject v).realifiedLogVolume =
        backed.guard.cq4CalibratedLogVolume) ∧
      backed.guard.cq3HullDetLogVolume =
        backed.guard.cq4CalibratedLogVolume ∧
      data.qPilotLogVolume <=
        backed.collection.globalObject.realifiedLogVolume :=
  backed.localGlobalClosedLoop_endpoint

theorem stepXToHullUpperRay_twoComputation_fig38_endpoint
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label) :
    let twoComputation := data.toQPilotTwoComputationLogVolume;
    twoComputation.inputPrimeStripLogVolume =
        data.corridor.beforeIndeterminacy.averageLogVolume ∧
      twoComputation.outputHullLogVolume = data.qPilotLogVolume ∧
      twoComputation.inputPrimeStripLogVolume =
        twoComputation.outputHullLogVolume ∧
      twoComputation.inputPrimeStripLogVolume <= data.thetaHullLogVolume ∧
      twoComputation.outputHullLogVolume <= data.thetaHullLogVolume ∧
      twoComputation.outputHullLogVolume ∈
        data.toHullDetPilotUpperRayLogVolume.upperRay :=
  data.twoComputation_fig38_endpoint

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

theorem stepXToHullUpperRay_xiF_upperRayCThetaEndpoint
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    data.qPilotLogVolume ∈
        data.toHullDetPilotUpperRayLogVolume.upperRay ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaHullLogVolume <= cTheta * (-data.qPilotLogVolume) ∧
      data.qPilotLogVolume <= cTheta * (-data.qPilotLogVolume) ∧
      (-1 : Real) <= cTheta ∧
      ¬ cTheta < (-1 : Real) :=
  data.xiF_upperRayCTheta_endpoint
    q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

theorem stepXToHullUpperRay_xiF_distinctIntertwiningEndpoint
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume))
    (transport : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : transport.qIntertwining) :
    let endpoint :=
      data.toQPilotTwoComputationCThetaEndpoint
        q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ;
    data.qPilotLogVolume ∈
        data.toHullDetPilotUpperRayLogVolume.upperRay ∧
      data.qPilotLogVolume <= data.thetaHullLogVolume ∧
      data.thetaHullLogVolume <= endpoint.cTheta * (-data.qPilotLogVolume) ∧
      data.qPilotLogVolume <= endpoint.cTheta * (-data.qPilotLogVolume) ∧
      (-1 : Real) <= endpoint.cTheta ∧
      Corollary312Inequality
        endpoint.toSignedCThetaBound.comparison.thetaPilot
        endpoint.toSignedCThetaBound.comparison.qPilot ∧
      transport.qLabel ≠ transport.thetaLabel ∧
      transport.weakenedPrimeStripCannotDistinguishPilots ∧
      transport.qIntertwining ∧
      transport.thetaIntertwiningUpToIndeterminacy :=
  data.xiF_upperRayCTheta_distinctIntertwining_endpoint
    q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ transport hq

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

theorem stepXToHullUpperRay_statementEndpoint_cTheta_gt_neg_one_of_beforeAverage_lt_theta
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume))
    (hstrict :
      data.corridor.beforeIndeterminacy.averageLogVolume <
        (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
          thetaHull_le_cTheta_absLogQ).thetaRealLogVolume) :
    (-1 : Real) <
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).cTheta :=
  data.statementEndpoint_cTheta_gt_neg_one_of_beforeAverage_lt_thetaRealLogVolume
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hstrict

theorem stepXToHullUpperRay_statementEndpoint_cTheta_gt_neg_one_of_theta_nonneg
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
    (-1 : Real) <
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).cTheta :=
  data.statementEndpoint_cTheta_gt_neg_one_of_thetaRealLogVolume_nonnegative
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hTheta

theorem stepXToHullUpperRay_beforeAverage_eq_thetaHull_of_cTheta_eq_neg_one
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume))
    (hC : cTheta = (-1 : Real)) :
    data.corridor.beforeIndeterminacy.averageLogVolume =
      data.thetaHullLogVolume :=
  data.beforeAverage_eq_thetaHullLogVolume_of_cTheta_eq_neg_one
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hC

theorem stepXToHullUpperRay_not_beforeAverage_lt_theta_of_cTheta_eq_neg_one
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume))
    (hC : cTheta = (-1 : Real)) :
    ¬ data.corridor.beforeIndeterminacy.averageLogVolume <
      (data.toStatementEndpoint pilotBoundary q_pilot_positive cTheta
        thetaHull_le_cTheta_absLogQ).thetaRealLogVolume :=
  data.not_beforeAverage_lt_statementEndpoint_thetaRealLogVolume_of_cTheta_eq_neg_one
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hC

theorem stepXToHullUpperRay_thetaHull_neg_of_cTheta_eq_neg_one
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume))
    (hC : cTheta = (-1 : Real)) :
    data.thetaHullLogVolume < 0 :=
  data.thetaHullLogVolume_neg_of_cTheta_eq_neg_one
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ hC

theorem stepXToHullUpperRay_cTheta_boundary_or_strict
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (pilotBoundary : IUTStage1Corollary312PilotIndeterminacyBoundary)
    (q_pilot_positive :
      0 < -data.corridor.beforeIndeterminacy.averageLogVolume)
    (cTheta : Real)
    (thetaHull_le_cTheta_absLogQ :
      data.thetaHullLogVolume <=
        cTheta * (-data.corridor.beforeIndeterminacy.averageLogVolume)) :
    cTheta = (-1 : Real) ∨ (-1 : Real) < cTheta :=
  data.statementEndpoint_cTheta_eq_neg_one_or_gt_neg_one
    pilotBoundary q_pilot_positive cTheta thetaHull_le_cTheta_absLogQ

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

theorem lgpSplittingMonoid_generatorAverage_eq_gaussianFullLabelAverage
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    (Finset.univ.sum action.generatorLogVolume) /
        (Fintype.card
          (IUTStage1ProcessionContainer
            (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
              Real) =
      (Finset.univ.sum action.evaluation.gaussianDegree) /
        (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) :=
  action.generatorLogVolume_average_eq_gaussianFullLabel_average

theorem lgpSplittingMonoid_normalizedActed_eq_packetNormalized_plus_gaussianFullLabelAverage
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    action.normalizedActedLogVolume =
      action.packet.normalizedLogVolume +
        (Finset.univ.sum action.evaluation.gaussianDegree) /
          (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) :=
  action.normalizedActedLogVolume_eq_packetNormalized_plus_gaussianFullLabelAverage

theorem lgpSplittingMonoid_environmentDegree_eq_zero_of_normalizedFixed
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l)
    (hfixed :
      action.normalizedActedLogVolume =
        action.packet.normalizedLogVolume) :
    action.evaluation.environmentDegree = 0 :=
  action.environmentDegree_eq_zero_of_normalizedActedLogVolume_eq_packetNormalized
    hfixed

theorem lgpSplittingMonoid_normalizedFixed_iff_environmentDegree_zero
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    action.normalizedActedLogVolume =
        action.packet.normalizedLogVolume ↔
      action.evaluation.environmentDegree = 0 :=
  action.normalizedActedLogVolume_eq_packetNormalized_iff_environmentDegree_eq_zero

theorem lgpSplittingMonoid_packetNormalized_lt_acted_of_environmentDegree_pos
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l)
    (henv : 0 < action.evaluation.environmentDegree) :
    action.packet.normalizedLogVolume <
      action.normalizedActedLogVolume :=
  action.packetNormalized_lt_normalizedActedLogVolume_of_environmentDegree_pos
    henv

theorem lgpSplittingMonoid_acted_lt_packetNormalized_of_environmentDegree_neg
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l)
    (henv : action.evaluation.environmentDegree < 0) :
    action.normalizedActedLogVolume <
      action.packet.normalizedLogVolume :=
  action.normalizedActedLogVolume_lt_packetNormalized_of_environmentDegree_neg
    henv

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

theorem lgpSplittingMonoid_qSquaredGeneratorTensorPacketAction_endpoint
    {l : PrimeGeFive}
    (action :
      IUTStage1ZModSquareWeightProfile.LGPSplittingMonoidTensorPacketAction l) :
    action.generatorLogVolume
        (IUTStage1ProcessionContainer.core
          (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) = 0 ∧
      (∀ label :
          IUTStage1ProcessionContainer
            (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l),
        action.generatorLogVolume label =
          ((label.val : Real) ^ 2) * action.evaluation.environmentDegree) ∧
      action.actedTensorPacketLogVolume =
        action.packet.tensorPacketLogVolume +
          Finset.univ.sum action.generatorLogVolume ∧
      action.normalizedActedLogVolume =
        action.packet.normalizedLogVolume +
          (Finset.univ.sum action.generatorLogVolume) /
            (Fintype.card
              (IUTStage1ProcessionContainer
                (IUTStage1ZModSquareWeightProfile.absLabelProcessionTop l)) :
                  Real) ∧
      action.normalizedActedLogVolume =
        action.packet.normalizedLogVolume +
          (Finset.univ.sum action.evaluation.gaussianDegree) /
            (Fintype.card (IUTStage1ZModCuspFullLabel l) : Real) ∧
      (action.normalizedActedLogVolume =
          action.packet.normalizedLogVolume ↔
        action.evaluation.environmentDegree = 0) ∧
      (0 < action.evaluation.environmentDegree ->
        action.packet.normalizedLogVolume <
          action.normalizedActedLogVolume) ∧
      (action.evaluation.environmentDegree < 0 ->
        action.normalizedActedLogVolume <
          action.packet.normalizedLogVolume) ∧
      (0 <= action.evaluation.environmentDegree ->
        action.packet.normalizedLogVolume <= action.normalizedActedLogVolume) :=
  action.qSquaredGeneratorTensorPacketAction_endpoint

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

theorem arithmeticVectorBundleDeterminant_normalized_eq_of_determinant_eq
    (source target : IUTStage1ArithmeticVectorBundleDeterminantLogVolume)
    (hdet :
      source.determinantLogVolume = target.determinantLogVolume) :
    source.normalizedLogVolume = target.normalizedLogVolume :=
  source.normalizedLogVolume_eq_of_determinantLogVolume_eq target hdet

theorem arithmeticVectorBundleDeterminant_normalization_endpoint
    (data : IUTStage1ArithmeticVectorBundleDeterminantLogVolume) :
    1 < data.rank ∧
      0 < data.positiveTensorPower ∧
      data.tensorPowerLogVolume =
        (data.positiveTensorPower : Real) * data.determinantLogVolume ∧
      data.normalizedLogVolume = data.determinantLogVolume :=
  data.determinantNormalization_endpoint

theorem hullDetUpperRay_qPilot_mem
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume ∈ data.upperRay :=
  data.qPilot_mem_upperRay

theorem hullDetUpperRay_qPilot_le_theta
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume <= data.thetaHullLogVolume :=
  data.qPilotLogVolume_le_thetaHullLogVolume

theorem hullDetUpperRay_qPilot_eq_theta_iff_reverse_bound
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume = data.thetaHullLogVolume ↔
      data.thetaHullLogVolume <= data.qPilotLogVolume :=
  data.qPilotLogVolume_eq_thetaHullLogVolume_iff_reverse_bound

theorem hullDetUpperRay_qPilot_le_determinant
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume <= data.determinant.determinantLogVolume :=
  data.qPilotLogVolume_le_determinant

theorem hullDetUpperRay_qPilot_eq_determinant_iff_reverse_bound
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    data.qPilotLogVolume = data.determinant.determinantLogVolume ↔
      data.determinant.determinantLogVolume <= data.qPilotLogVolume :=
  data.qPilotLogVolume_eq_determinant_iff_reverse_bound

theorem hullDetUpperRay_equality_requires_reverse_bounds
    (data : IUTStage1HullDetPilotUpperRayLogVolume) :
    (data.qPilotLogVolume = data.thetaHullLogVolume ↔
        data.thetaHullLogVolume <= data.qPilotLogVolume) ∧
      (data.qPilotLogVolume = data.determinant.determinantLogVolume ↔
        data.determinant.determinantLogVolume <= data.qPilotLogVolume) :=
  data.upperRayEqualityRequiresReverseBounds

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

theorem qPilotTwoComputationCThetaEndpoint_output_strict_lower_bound
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hstrict :
      data.signedEndpoint.twoComputation.outputHullLogVolume <
        data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume) :
    (-1 : Real) < data.cTheta :=
  data.cTheta_gt_neg_one_of_qOutput_lt_thetaHullLogVolume hstrict

theorem qPilotTwoComputationCThetaEndpoint_output_eq_theta_of_boundary
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hC : data.cTheta = (-1 : Real)) :
    data.signedEndpoint.twoComputation.outputHullLogVolume =
      data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume :=
  data.qOutputLogVolume_eq_thetaHullLogVolume_of_cTheta_eq_neg_one hC

theorem qPilotTwoComputationCThetaEndpoint_not_output_strict_of_boundary
    (data : IUTStage1QPilotTwoComputationCThetaEndpoint)
    (hC : data.cTheta = (-1 : Real)) :
    ¬ data.signedEndpoint.twoComputation.outputHullLogVolume <
      data.signedEndpoint.twoComputation.upperRayData.thetaHullLogVolume :=
  data.not_qOutputLogVolume_lt_thetaHullLogVolume_of_cTheta_eq_neg_one hC

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

theorem thetaPilotTensorPower_mem_lt_original
    (data : IUTStage1ThetaPilotTensorPowerLogVolume)
    (hTheta : data.originalThetaPilotLogVolume < 0)
    {value : Real}
    (hvalue : value ∈ data.tensorPowerUpperRay) :
    value < data.originalThetaPilotLogVolume :=
  data.mem_tensorPowerUpperRay_lt_original_of_original_neg hTheta hvalue

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

theorem localFrobenioidLogVolume_shifted_eq_unshifted_iff_zero_exponent_or_step
    (data : IUTStage1LocalFrobenioidLogVolumeAmbiguity) :
    data.shiftedLogVolume = data.unshiftedLogVolume ↔
      data.localExponent = 0 ∨ data.localPrimeStepLogVolume = 0 :=
  data.shiftedLogVolume_eq_unshifted_iff_exponent_zero_or_step_zero

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

theorem globalFrobenioidCalibration_eq_localShifted_iff_zero_exponent_or_step
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration) :
    data.calibratedLogVolume = data.localData.shiftedLogVolume ↔
      data.localData.localExponent = 0 ∨
        data.localData.localPrimeStepLogVolume = 0 :=
  data.calibratedLogVolume_eq_shifted_iff_exponent_zero_or_step_zero

theorem globalFrobenioidCalibration_ordered_shift
    (data : IUTStage1GlobalFrobenioidLogVolumeCalibration) :
    (data.calibratedLogVolume < data.localData.shiftedLogVolume ↔
      0 < (data.localData.localExponent : Real) *
        data.localData.localPrimeStepLogVolume) ∧
      (data.localData.shiftedLogVolume < data.calibratedLogVolume ↔
        (data.localData.localExponent : Real) *
          data.localData.localPrimeStepLogVolume < 0) :=
  ⟨data.calibratedLogVolume_lt_shifted_iff_shiftTerm_pos,
    data.shiftedLogVolume_lt_calibrated_iff_shiftTerm_lt_zero⟩

theorem remark3122_ringStructureDimensionSplit_endpoint
    {kind : IUTStage1PlaceKind} {j : Nat}
    {source target :
      IUTStage1RealizedTensorPacketProductLogVolume kind j}
    (logShellData : IUTStage1ValuationFiberLogShellDirectSum kind)
    (global :
      IUTStage1GlobalFrobenioidLogVolumeCalibration)
    (transfer : IUTStage1TensorPacketCoricTransfer source target) :
    logShellData.directSumLogVolume =
        Finset.univ.sum logShellData.logShellLogVolume ∧
      global.calibratedLogVolume = global.localData.unshiftedLogVolume ∧
      (global.calibratedLogVolume = global.localData.shiftedLogVolume ↔
        (global.localData.localExponent : Real) *
          global.localData.localPrimeStepLogVolume = 0) ∧
      target.product.productLogVolume = source.product.productLogVolume ∧
      source.theater.side ≠ target.theater.side :=
  Stage1.remark3122_ringStructureDimensionSplit_endpoint
    logShellData global transfer

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

theorem generalizedThetaLGPLambda_strict_standard_bound
    (data : IUTStage1GeneralizedThetaLGPLambdaBound)
    (hlambda : data.lambda < 1) :
    (-1 : Real) < data.cTheta :=
  data.strict_standard_bound_of_lambda_lt_one hlambda

theorem generalizedQLambdaCTheta_lower_bound
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow) :
    -((data.lambda : Real)) <= data.cTheta :=
  data.cTheta_ge_neg_lambda

theorem generalizedQLambdaCTheta_boundary_or_strict
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow) :
    data.cTheta = -((data.lambda : Real)) ∨
      -((data.lambda : Real)) < data.cTheta :=
  data.cTheta_eq_neg_lambda_or_gt_neg_lambda

theorem generalizedQLambdaCTheta_strict_of_qLambda_strict
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hstrict : data.qLambdaSigned < data.thetaSigned) :
    -((data.lambda : Real)) < data.cTheta :=
  data.cTheta_gt_neg_lambda_of_qLambda_lt_theta hstrict

theorem generalizedQLambdaCTheta_qLambda_eq_theta_of_boundary
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hC : data.cTheta = -((data.lambda : Real))) :
    data.qLambdaSigned = data.thetaSigned :=
  data.qLambdaSigned_eq_thetaSigned_of_cTheta_eq_neg_lambda hC

theorem generalizedQLambdaCTheta_standard_bound
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hlambda : data.lambda <= 1) :
    (-1 : Real) <= data.cTheta :=
  data.standard_bound_of_lambda_le_one hlambda

theorem generalizedQLambdaCTheta_strict_standard_bound
    (data : IUTStage1Corollary312QLambdaCThetaBoundShadow)
    (hlambda : data.lambda < 1) :
    (-1 : Real) < data.cTheta :=
  data.strict_standard_bound_of_lambda_lt_one hlambda

theorem distinctLabelIntertwining_labels_distinct
    (data : IUTStage1DistinctLabelIntertwiningTransport) :
    data.qLabel ≠ data.thetaLabel :=
  data.labels_distinct

theorem distinctLabelIntertwining_simultaneous_of_q
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : data.qIntertwining) :
    data.qIntertwining ∧ data.thetaIntertwiningUpToIndeterminacy :=
  data.simultaneous_intertwining_of_q hq

theorem distinctLabelIntertwining_formal_second_implication
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (h :
      data.qIntertwining ∧ data.thetaIntertwiningUpToIndeterminacy) :
    data.thetaIntertwiningUpToIndeterminacy :=
  data.formal_second_implication h

theorem distinctLabelIntertwining_fixed_prime_strip_simultaneous_of_q
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : data.qIntertwining) :
    data.weakenedPrimeStripCannotDistinguishPilots ∧
      data.qIntertwining ∧ data.thetaIntertwiningUpToIndeterminacy :=
  data.fixed_prime_strip_simultaneous_of_q hq

theorem distinctLabelIntertwining_distinct_labels_fixed_prime_strip_simultaneous_of_q
    (data : IUTStage1DistinctLabelIntertwiningTransport)
    (hq : data.qIntertwining) :
    data.qLabel ≠ data.thetaLabel ∧
      data.weakenedPrimeStripCannotDistinguishPilots ∧
        data.qIntertwining ∧ data.thetaIntertwiningUpToIndeterminacy :=
  data.distinct_labels_fixed_prime_strip_simultaneous_of_q hq

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

theorem remark3122Intertwining_ftoy_upper_ray_endpoint
    (data : IUTStage1Remark3122IntertwiningUpperRayBound) :
    data.qAssignment ∈ data.thetaUpperRay ∧
      (-data.h : Real) <= -2 * data.h + data.epsilon ∧
        data.h <= data.epsilon :=
  data.ftoy_upper_ray_endpoint

theorem logThetaColumn_both_roles_essential
    (column : IUTStage1LogThetaVerticalColumn) :
    column.requiresFrobeniusLikeRole = true ∧
      column.requiresEtaleLikeRole = true :=
  column.both_roles_essential

theorem logThetaColumn_upperTableSimilarities
    (column : IUTStage1LogThetaVerticalColumn) :
    column.requiresFrobeniusLikeRole = true ∧
      column.requiresEtaleLikeRole = true ∧
        column.hasLogVolumeCompatibility = true ∧
          column.hasLogKummerNonInterference = true :=
  column.upper_table_similarities

theorem remark3122iv_zero_one_column_similarities_endpoint :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.requiresFrobeniusLikeRole =
        true ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.requiresEtaleLikeRole =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.requiresFrobeniusLikeRole =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.requiresEtaleLikeRole =
        true ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasLogVolumeCompatibility =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogVolumeCompatibility =
        true ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasLogKummerNonInterference =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true :=
  IUTStage1LogThetaVerticalColumn.remark3122iv_zero_one_column_similarities_endpoint

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

theorem logThetaColumn_lowerTableDifferences :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasPilotMultiradiality =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasPilotMultiradiality =
        false ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logShellTreatment =
        IUTStage1LogShellColumnTreatment.monoAnalyticContainers ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment =
        IUTStage1LogShellColumnTreatment.tautologicalLogDocumentation ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.hasPilotMultiradiality ≠
        IUTStage1LogThetaVerticalColumn.oneQPilot.hasPilotMultiradiality ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logShellTreatment ≠
        IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment :=
  IUTStage1LogThetaVerticalColumn.lower_table_differences

theorem remark3122v_qPilot_nonInterference_without_multiradiality_endpoint :
    IUTStage1LogThetaVerticalColumn.oneQPilot.hasLogKummerNonInterference =
        true ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.hasPilotMultiradiality =
        false ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment =
        IUTStage1LogShellColumnTreatment.tautologicalLogDocumentation :=
  IUTStage1LogThetaVerticalColumn.remark3122v_qPilot_nonInterference_without_multiradiality_endpoint

theorem zeroColumnHullAbsorption_bothRegions
    (data : IUTStage1ZeroColumnHullAbsorbsUnitIndeterminacy) :
    data.originalRegionLogVolume ∈ data.hullUpperRay ∧
      data.unitShiftedRegionLogVolume ∈ data.hullUpperRay :=
  data.both_regions_absorbed_by_hull

theorem zeroColumnHullAbsorption_equalityRequiresReverseBounds
    (data : IUTStage1ZeroColumnHullAbsorbsUnitIndeterminacy) :
    (data.originalRegionLogVolume = data.hullLogVolume ↔
        data.hullLogVolume <= data.originalRegionLogVolume) ∧
      (data.unitShiftedRegionLogVolume = data.hullLogVolume ↔
        data.hullLogVolume <= data.unitShiftedRegionLogVolume) :=
  data.hullEqualityRequiresReverseBounds

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

theorem zeroOneColumn_absorptionProfile
    (zeroData : IUTStage1ZeroColumnHullAbsorbsUnitIndeterminacy)
    (oneData :
      IUTStage1OneColumnLogVolumeCompatibilityAbsorbsConjugateChoice) :
    IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logShellTreatment =
        IUTStage1LogShellColumnTreatment.monoAnalyticContainers ∧
      zeroData.originalRegionLogVolume ∈ zeroData.hullUpperRay ∧
      zeroData.unitShiftedRegionLogVolume ∈ zeroData.hullUpperRay ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment =
        IUTStage1LogShellColumnTreatment.tautologicalLogDocumentation ∧
      oneData.sourceRingStructureLogVolume =
        oneData.conjugateRingStructureLogVolume :=
  zero_one_column_absorption_profile zeroData oneData

theorem zeroOneColumn_inequalityVsEquality_endpoint
    (zeroData : IUTStage1ZeroColumnHullAbsorbsUnitIndeterminacy)
    (oneData :
      IUTStage1OneColumnLogVolumeCompatibilityAbsorbsConjugateChoice) :
    zeroData.originalRegionLogVolume <= zeroData.hullLogVolume ∧
      zeroData.unitShiftedRegionLogVolume <= zeroData.hullLogVolume ∧
      oneData.sourceRingStructureLogVolume =
        oneData.conjugateRingStructureLogVolume ∧
      oneData.sourceRingStructureLogVolume <=
        oneData.conjugateRingStructureLogVolume ∧
      oneData.conjugateRingStructureLogVolume <=
        oneData.sourceRingStructureLogVolume :=
  zero_one_column_inequality_vs_equality_endpoint zeroData oneData

theorem thetaFinite_zeroOneColumnAbsorptionProfile
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (originalRegionLogVolume unitShiftedRegionLogVolume : Real)
    (original_le_thetaHull :
      originalRegionLogVolume <= data.thetaHullLogVolume)
    (unit_shifted_le_thetaHull :
      unitShiftedRegionLogVolume <= data.thetaHullLogVolume)
    (sourceRingStructureLogVolume conjugateRingStructureLogVolume : Real)
    (log_volume_compatible :
      sourceRingStructureLogVolume = conjugateRingStructureLogVolume) :
    let finite := data.toThetaFiniteLogVolumeEndpoint;
    let zeroData :=
      data.toZeroColumnHullAbsorption
        originalRegionLogVolume unitShiftedRegionLogVolume
        original_le_thetaHull unit_shifted_le_thetaHull;
    let oneData :=
      data.toOneColumnLogVolumeCompatibility
        sourceRingStructureLogVolume conjugateRingStructureLogVolume
        log_volume_compatible;
    zeroData.hullLogVolume = finite.thetaRealLogVolume ∧
      zeroData.originalRegionLogVolume ∈ finite.upperRayData.upperRay ∧
      zeroData.unitShiftedRegionLogVolume ∈ finite.upperRayData.upperRay ∧
      oneData.sourceRingStructureLogVolume =
        oneData.conjugateRingStructureLogVolume ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logShellTreatment =
        IUTStage1LogShellColumnTreatment.monoAnalyticContainers ∧
      IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment =
        IUTStage1LogShellColumnTreatment.tautologicalLogDocumentation ∧
      IUTStage1LogThetaVerticalColumn.zeroThetaPilot.logShellTreatment ≠
        IUTStage1LogThetaVerticalColumn.oneQPilot.logShellTreatment :=
  data.thetaFinite_zeroOneColumnAbsorptionProfile
    originalRegionLogVolume unitShiftedRegionLogVolume
    original_le_thetaHull unit_shifted_le_thetaHull
    sourceRingStructureLogVolume conjugateRingStructureLogVolume
    log_volume_compatible

theorem thetaFinite_zeroColumnHullEqualityRequiresReverseBounds
    {label : Type u} [Fintype label]
    (data : IUTStage1StepXToHullUpperRayLogVolume label)
    (originalRegionLogVolume unitShiftedRegionLogVolume : Real)
    (original_le_thetaHull :
      originalRegionLogVolume <= data.thetaHullLogVolume)
    (unit_shifted_le_thetaHull :
      unitShiftedRegionLogVolume <= data.thetaHullLogVolume) :
    let finite := data.toThetaFiniteLogVolumeEndpoint;
    let zeroData :=
      data.toZeroColumnHullAbsorption
        originalRegionLogVolume unitShiftedRegionLogVolume
        original_le_thetaHull unit_shifted_le_thetaHull;
    zeroData.hullLogVolume = finite.thetaRealLogVolume ∧
      (zeroData.originalRegionLogVolume = finite.thetaRealLogVolume ↔
        finite.thetaRealLogVolume <= zeroData.originalRegionLogVolume) ∧
      (zeroData.unitShiftedRegionLogVolume = finite.thetaRealLogVolume ↔
        finite.thetaRealLogVolume <= zeroData.unitShiftedRegionLogVolume) :=
  data.thetaFinite_zeroColumnHullEqualityRequiresReverseBounds
    originalRegionLogVolume unitShiftedRegionLogVolume
    original_le_thetaHull unit_shifted_le_thetaHull

theorem gaussBonnetMetricSign_euler_neg
    (data : IUTStage1GaussBonnetMetricSignShadow) :
    data.eulerCharacteristic < 0 :=
  data.eulerCharacteristic_neg

theorem gaussBonnetMetricSign_euler_nonpos
    (data : IUTStage1GaussBonnetMetricSignShadow) :
    data.eulerCharacteristic <= 0 :=
  data.eulerCharacteristic_nonpos

theorem gaussBonnetMetricSign_upperSemiAnalogue
    (data : IUTStage1GaussBonnetMetricSignShadow) :
    data.upperSemiInd3Analogue :=
  data.upperSemiInd3Analogue_holds

theorem gaussBonnetMetricSign_endpoint
    (data : IUTStage1GaussBonnetMetricSignShadow) :
    data.eulerCharacteristic < 0 ∧
      data.eulerCharacteristic <= 0 ∧ data.upperSemiInd3Analogue :=
  data.gauss_bonnet_metric_endpoint

theorem thetaLabelFactorPNormalization_mul_labelFactor
    (data : IUTStage1ThetaLabelFactorPNormalizationShadow) :
    data.normalizedModPLogVolume * (data.l.value : Real) =
      data.modPOverP2GapLogVolume :=
  data.normalized_mul_labelFactor

theorem thetaLabelFactorPNormalization_nonpos_iff
    (data : IUTStage1ThetaLabelFactorPNormalizationShadow) :
    data.normalizedModPLogVolume <= 0 ↔
      data.modPOverP2GapLogVolume <= 0 :=
  data.normalized_nonpos_iff_gap_nonpos

theorem thetaLabelFactorPNormalization_orderEndpoint
    (data : IUTStage1ThetaLabelFactorPNormalizationShadow) :
    data.normalizedModPLogVolume * (data.l.value : Real) =
        data.modPOverP2GapLogVolume ∧
      (data.normalizedModPLogVolume <= 0 ↔
        data.modPOverP2GapLogVolume <= 0) :=
  data.factor_normalization_order_endpoint

theorem frobeniusDerivativeDegreeInequality_nonpos
    (data : IUTStage1FrobeniusDerivativeDegreeInequalityShadow) :
    data.degreeDefect <= 0 :=
  data.degreeDefect_nonpos

theorem frobeniusDerivativeDegreeInequality_neg
    (data : IUTStage1FrobeniusDerivativeDegreeInequalityShadow) :
    data.degreeDefect < 0 :=
  data.degreeDefect_neg

theorem frobeniusDerivativeDegreeInequality_inclusion
    (data : IUTStage1FrobeniusDerivativeDegreeInequalityShadow) :
    data.derivativeGivesInclusion :=
  data.derivativeGivesInclusion_holds

theorem frobeniusDerivativeDegreeInequality_endpoint
    (data : IUTStage1FrobeniusDerivativeDegreeInequalityShadow) :
    data.derivativeGivesInclusion ∧
      data.derivativeIsomorphismNotAssumed ∧
        data.degreeDefect <= 0 ∧ data.degreeDefect < 0 :=
  data.derivative_degree_endpoint

theorem iutIVThetaPilotLogVolumeEstimate_mainTerm_le_upper
    (data : IUTStage1IUTIVThetaPilotLogVolumeEstimateShadow) :
    data.mainLogTerm <= data.arithmeticUpperTerm :=
  data.mainLogTerm_le_arithmeticUpperTerm

theorem iutIVThetaPilotLogVolumeEstimate_arithmetic_minus_main_nonneg
    (data : IUTStage1IUTIVThetaPilotLogVolumeEstimateShadow) :
    0 <= data.arithmeticUpperTerm - data.mainLogTerm :=
  data.arithmetic_minus_main_nonneg

theorem iutIVThetaPilotLogVolumeEstimate_oneSixthLogQ_bound
    (data : IUTStage1IUTIVThetaPilotLogVolumeEstimateShadow) :
    data.oneSixthLogQ <= data.theorem110RightHandSide :=
  data.oneSixthLogQ_le_theorem110RightHandSide

theorem iutIVThetaPilotLogVolumeEstimate_corollary312_handoff_endpoint
    (data : IUTStage1IUTIVThetaPilotLogVolumeEstimateShadow) :
    0 < data.absoluteLogQ ∧
      data.cTheta + 1 = data.arithmeticUpperTerm - data.mainLogTerm ∧
        0 <= data.arithmeticUpperTerm - data.mainLogTerm ∧
          data.mainLogTerm <= data.arithmeticUpperTerm ∧
            data.oneSixthLogQ <= data.theorem110RightHandSide :=
  data.corollary312_handoff_endpoint

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

theorem iutIVTheorem110FinalDisplay_chain
    (data : IUTStage1IUTIVTheorem110FinalDisplayShadow) :
    data.estimate.oneSixthLogQ <= data.baseChange.ftpdTheorem110RightHandSide ∧
      data.baseChange.ftpdTheorem110RightHandSide <= data.finalRightHandSide ∧
        data.estimate.oneSixthLogQ <= data.finalRightHandSide :=
  data.final_display_chain

theorem iutIVTheoremABoundedDiscrepancy_height_bound
    {Point : Type u}
    (data : IUTStage1IUTIVTheoremABoundedDiscrepancyShadow Point)
    (x : Point) :
    data.height x <=
      (1 + data.epsilon) * (data.logDiff x + data.logCond x) -
        data.lowerBound :=
  data.height_le_weighted_logDiff_logCond_minus_lowerBound x

theorem iutIVTheoremABoundedDiscrepancy_endpoint
    {Point : Type u}
    (data : IUTStage1IUTIVTheoremABoundedDiscrepancyShadow Point)
    (x : Point) :
    data.hyperbolicCurve ∧
      0 < 1 + data.epsilon ∧
      data.lowerBound <= data.discrepancy x ∧
      data.height x + data.lowerBound <=
        (1 + data.epsilon) * (data.logDiff x + data.logCond x) ∧
      data.height x <=
        (1 + data.epsilon) * (data.logDiff x + data.logCond x) -
          data.lowerBound :=
  data.theoremA_bounded_discrepancy_endpoint x

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

theorem iutIVCorollary22BoundedDiscrepancyChain_endpoint
    {Point : Type u}
    (data : IUTStage1IUTIVCorollary22BoundedDiscrepancyChainShadow Point) :
    Nonempty
        (IUTStage1BoundedDiscrepancyEquivalent Point
          (fun x => (1 / 6 : Real) * data.logQTwo x)
          (fun x => (1 / 6 : Real) * data.logQAll x)) ∧
      Nonempty
        (IUTStage1BoundedDiscrepancyEquivalent Point
          (fun x => (1 / 6 : Real) * data.logQAll x)
          (fun x => (1 / 6 : Real) * data.heightInfinity x)) ∧
      Nonempty
        (IUTStage1BoundedDiscrepancyEquivalent Point
          (fun x => (1 / 6 : Real) * data.heightInfinity x)
          data.canonicalHeight) ∧
      Nonempty
        (IUTStage1BoundedDiscrepancyEquivalent Point
          (fun x => (1 / 6 : Real) * data.logQTwo x)
          data.canonicalHeight) :=
  data.bounded_discrepancy_chain_endpoint

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

theorem iutIVBoundedDiscrepancy_twoSidedBound_transfers
    {Point : Type u} {f g : Point -> Real}
    (data : IUTStage1BoundedDiscrepancyEquivalent Point f g)
    {L U : Real} (hB : ∀ x : Point, L <= f x ∧ f x <= U) :
    ∀ x : Point, (L - data.upper <= g x) ∧
      (g x <= U - data.lower) :=
  data.twoSidedBound_transfers_to_right hB

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

theorem iutIVCorollary22C1_primeScaleWindowEndpoint
    (data : IUTStage1IUTIVCorollary22C1PrimeScaleWindowShadow) :
    data.sqrtLogQAll <= (data.l.value : Real) ∧
      (data.l.value : Real) <=
        10 * data.delta * data.sqrtLogQAll * data.logTwoDeltaLogQAll ∧
      0 < data.sqrtLogQAll ∧
      0 <= data.logQAll ∧
      (1 : Real) <= 10 * data.delta * data.logTwoDeltaLogQAll :=
  data.c1_prime_scale_window_endpoint

theorem iutIVCorollary22C1Theorem110_coefficient_bound
    (data : IUTStage1IUTIVCorollary22C1Theorem110CoefficientShadow) :
    80 * (data.dmod : Real) / (data.l.value : Real) <=
      data.delta / data.sqrtH :=
  data.coefficient_le_delta_inv_sqrtH

theorem iutIVCorollary22C1Theorem110_coefficientEndpoint
    (data : IUTStage1IUTIVCorollary22C1Theorem110CoefficientShadow) :
    0 < (data.l.value : Real) ∧
      0 < data.sqrtH ∧
      0 <= data.delta ∧
      80 * (data.dmod : Real) / (data.l.value : Real) <=
        data.delta / data.sqrtH ∧
      1 + 80 * (data.dmod : Real) / (data.l.value : Real) <=
        1 + data.delta / data.sqrtH :=
  data.coefficient_replacement_endpoint

theorem iutIVCorollary22C1_errorTerm_bound
    (data : IUTStage1IUTIVCorollary22C1ErrorTermShadow) :
    20 * (data.dStarMod * (data.l.value : Real) + data.etaPrm) <=
      200 * data.delta ^ 2 * data.sqrtH * data.logTwoDeltaH +
        20 * data.etaPrm :=
  data.theorem110_errorTerm_le_corollary22_errorTerm

theorem iutIVCorollary22C1_errorTermEndpoint
    (data : IUTStage1IUTIVCorollary22C1ErrorTermShadow) :
    0 <= (data.l.value : Real) ∧
      0 <= data.dStarMod ∧
      0 <= data.delta ∧
      0 <= data.sqrtH ∧
      0 <= data.logTwoDeltaH ∧
      data.dStarMod <= data.delta ∧
      (data.l.value : Real) <=
        10 * data.delta * data.sqrtH * data.logTwoDeltaH ∧
      data.dStarMod * (data.l.value : Real) <=
        data.delta * (10 * data.delta * data.sqrtH * data.logTwoDeltaH) ∧
      20 * (data.dStarMod * (data.l.value : Real) + data.etaPrm) <=
        200 * data.delta ^ 2 * data.sqrtH * data.logTwoDeltaH +
          20 * data.etaPrm :=
  data.errorTerm_replacement_endpoint

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

theorem iutIVCorollary22QTwoMinusQ_endpoint
    (data : IUTStage1IUTIVCorollary22QTwoMinusQBoundShadow) :
    0 <= data.sqrtH ∧
      (1 / 6 : Real) * data.logQTwo - (1 / 6 : Real) * data.logQ <=
        (1 / 6 : Real) * data.sqrtH ∧
      1 <= 6 * data.logL ∧
      3 * data.logL <= data.logTwoDeltaH ∧
      (1 / 6 : Real) * data.sqrtH <= data.sqrtH * data.logL ∧
      data.sqrtH * data.logL <=
        (1 / 3 : Real) * data.sqrtH * data.logTwoDeltaH ∧
      (1 / 6 : Real) * data.logQTwo - (1 / 6 : Real) * data.logQ <=
        (1 / 3 : Real) * data.sqrtH * data.logTwoDeltaH :=
  data.qTwo_minus_q_endpoint

theorem iutIVCorollary22HBound_before_epsilon
    (data : IUTStage1IUTIVCorollary22HBoundBeforeEpsilonShadow) :
    (1 / 6 : Real) * data.h <=
      (1 + data.delta / data.sqrtH) * data.logDegreeSum +
        (15 * data.delta) ^ 2 * data.sqrtH * data.logTwoDeltaH +
          (1 / 2 : Real) * data.cK :=
  data.h_bound_before_epsilon

theorem iutIVCorollary22HBound_beforeEpsilonEndpoint
    (data : IUTStage1IUTIVCorollary22HBoundBeforeEpsilonShadow) :
    data.h = data.logQAll ∧
      1 <= data.delta ∧
      0 <= data.sqrtH * data.logTwoDeltaH ∧
      data.cK = 40 * data.etaPrm + 2 * data.bK ∧
      (1 / 6 : Real) * data.logQ <=
        (1 + data.delta / data.sqrtH) * data.logDegreeSum +
          (200 * data.delta ^ 2 * data.sqrtH * data.logTwoDeltaH +
            20 * data.etaPrm) ∧
      (1 / 6 : Real) * data.logQTwo <=
        (1 / 6 : Real) * data.logQ +
          (1 / 3 : Real) * data.sqrtH * data.logTwoDeltaH ∧
      (1 / 6 : Real) * data.logQAll <=
        (1 / 6 : Real) * data.logQTwo + data.bK ∧
      200 * data.delta ^ 2 * data.sqrtH * data.logTwoDeltaH +
          (1 / 3 : Real) * data.sqrtH * data.logTwoDeltaH <=
        (15 * data.delta) ^ 2 * data.sqrtH * data.logTwoDeltaH ∧
      (1 / 2 : Real) * data.cK = 20 * data.etaPrm + data.bK ∧
      (1 / 6 : Real) * data.h <=
        (1 + data.delta / data.sqrtH) * data.logDegreeSum +
          (15 * data.delta) ^ 2 * data.sqrtH * data.logTwoDeltaH +
            (1 / 2 : Real) * data.cK :=
  data.h_bound_before_epsilon_endpoint

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

theorem iutIVCorollary22EpsilonDefinition_endpoint
    (data : IUTStage1IUTIVCorollary22EpsilonDefinitionShadow) :
    2 <= data.delta ∧
      0 < data.delta ∧
      0 < data.sqrtH ∧
      1 <= data.logTwoDeltaH ∧
      data.epsilonE =
        iutIVCorollary22EpsilonDefinitionRHS
          data.delta data.sqrtH data.logTwoDeltaH ∧
      0 < data.epsilonE ∧
      5 * data.delta * data.sqrtH⁻¹ <= data.epsilonE :=
  data.epsilon_definition_endpoint

theorem iutIVCorollary22EpsilonErrorConversion_bound
    (data : IUTStage1IUTIVCorollary22EpsilonErrorConversionShadow) :
    (15 * data.delta) ^ 2 * data.sqrtH * data.logTwoDeltaH <=
      (1 / 6 : Real) * data.h * ((2 / 5 : Real) * data.epsilonE) :=
  data.fifteen_delta_sq_error_le_epsilon_term

theorem iutIVCorollary22EpsilonErrorConversion_endpoint
    (data : IUTStage1IUTIVCorollary22EpsilonErrorConversionShadow) :
    0 < data.sqrtH ∧
      0 <= data.delta ^ 2 * data.logTwoDeltaH ∧
      data.h = data.sqrtH ^ 2 ∧
      data.epsilonE =
        iutIVCorollary22EpsilonDefinitionRHS
          data.delta data.sqrtH data.logTwoDeltaH ∧
      (15 * data.delta) ^ 2 * data.sqrtH * data.logTwoDeltaH <=
        (1 / 6 : Real) * data.h * ((2 / 5 : Real) * data.epsilonE) :=
  data.epsilon_error_conversion_endpoint

theorem iutIVCorollary22HBoundToMoveLeft_preliminary
    (data : IUTStage1IUTIVCorollary22HBoundToMoveLeftShadow) :
    (1 / 6 : Real) * data.h <=
      (1 + (1 / 5 : Real) * data.epsilonE) * data.logDegreeSum +
        (1 / 6 : Real) * data.h * ((2 / 5 : Real) * data.epsilonE) +
          (1 / 2 : Real) * data.cK :=
  data.preliminary_for_move_left

theorem iutIVCorollary22HBoundToMoveLeft_endpoint
    (data : IUTStage1IUTIVCorollary22HBoundToMoveLeftShadow) :
    0 <= data.logDegreeSum ∧
      data.delta / data.sqrtH <= (1 / 5 : Real) * data.epsilonE ∧
      (15 * data.delta) ^ 2 * data.sqrtH * data.logTwoDeltaH <=
        (1 / 6 : Real) * data.h * ((2 / 5 : Real) * data.epsilonE) ∧
      (1 / 6 : Real) * data.h <=
        (1 + data.delta / data.sqrtH) * data.logDegreeSum +
          (15 * data.delta) ^ 2 * data.sqrtH * data.logTwoDeltaH +
            (1 / 2 : Real) * data.cK ∧
      1 + data.delta / data.sqrtH <=
        1 + (1 / 5 : Real) * data.epsilonE ∧
      (1 / 6 : Real) * data.h <=
        (1 + (1 / 5 : Real) * data.epsilonE) * data.logDegreeSum +
          (1 / 6 : Real) * data.h * ((2 / 5 : Real) * data.epsilonE) +
            (1 / 2 : Real) * data.cK :=
  data.h_bound_to_move_left_endpoint

theorem iutIVCorollary22EpsilonMoveLeft_bound
    (data : IUTStage1IUTIVCorollary22EpsilonMoveLeftShadow) :
    (1 / 6 : Real) * data.h <=
      iutIVCorollary22EpsilonMainCoefficient data.epsilonE *
          data.logDegreeSum +
        iutIVCorollary22EpsilonConstantTerm data.epsilonE data.cK :=
  data.moved_left_bound

theorem iutIVCorollary22EpsilonMoveLeft_endpoint
    (data : IUTStage1IUTIVCorollary22EpsilonMoveLeftShadow) :
    0 < iutIVCorollary22EpsilonDenominator data.epsilonE ∧
      (1 / 6 : Real) * data.h <=
        (1 + (1 / 5 : Real) * data.epsilonE) * data.logDegreeSum +
          (1 / 6 : Real) * data.h * ((2 / 5 : Real) * data.epsilonE) +
            (1 / 2 : Real) * data.cK ∧
      (1 / 6 : Real) * data.h <=
        iutIVCorollary22EpsilonMainCoefficient data.epsilonE *
            data.logDegreeSum +
          iutIVCorollary22EpsilonConstantTerm data.epsilonE data.cK :=
  data.move_left_endpoint

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

theorem iutIVCorollary22EpsilonAbsorption_endpoint
    (data : IUTStage1IUTIVCorollary22EpsilonAbsorptionShadow) :
    0 < data.epsilonE ∧
      data.epsilonE <= 1 ∧
      0 <= data.logDegreeSum ∧
      0 <= data.cK ∧
      0 < iutIVCorollary22EpsilonDenominator data.epsilonE ∧
      (1 / 2 : Real) <=
        iutIVCorollary22EpsilonDenominator data.epsilonE ∧
      iutIVCorollary22EpsilonMainCoefficient data.epsilonE <=
        1 + data.epsilonE ∧
      iutIVCorollary22EpsilonConstantTerm data.epsilonE data.cK <=
        data.cK ∧
      (1 / 6 : Real) * data.h <=
        iutIVCorollary22EpsilonMainCoefficient data.epsilonE *
            data.logDegreeSum +
          iutIVCorollary22EpsilonConstantTerm data.epsilonE data.cK ∧
      (1 / 6 : Real) * data.h <=
        (1 + data.epsilonE) * data.logDegreeSum + data.cK :=
  data.epsilon_absorption_endpoint

theorem iutIVCorollary22FinalHBound_bound
    (data : IUTStage1IUTIVCorollary22FinalHBoundShadow) :
    (1 / 6 : Real) * data.h <=
      (1 + data.epsilonE) * data.logDegreeSum + data.cK :=
  data.final_h_bound

theorem iutIVCorollary22FinalHBound_endpoint
    (data : IUTStage1IUTIVCorollary22FinalHBoundShadow) :
    0 < data.sqrtH ∧
      0 <= data.delta ^ 2 * data.logTwoDeltaH ∧
      data.h = data.sqrtH ^ 2 ∧
      data.epsilonE =
        iutIVCorollary22EpsilonDefinitionRHS
          data.delta data.sqrtH data.logTwoDeltaH ∧
      0 <= data.logDegreeSum ∧
      data.delta / data.sqrtH <= (1 / 5 : Real) * data.epsilonE ∧
      0 < data.epsilonE ∧
      data.epsilonE <= 1 ∧
      0 <= data.cK ∧
      (1 / 6 : Real) * data.h <=
        (1 + data.delta / data.sqrtH) * data.logDegreeSum +
          (15 * data.delta) ^ 2 * data.sqrtH * data.logTwoDeltaH +
            (1 / 2 : Real) * data.cK ∧
      (1 / 6 : Real) * data.h <=
        (1 + data.epsilonE) * data.logDegreeSum + data.cK :=
  data.final_h_bound_endpoint

theorem iutIVCorollary22LogDiffCond_ftpd_le_curve
    (data : IUTStage1IUTIVCorollary22LogDiffCondComparisonShadow) :
    data.ftpdLogSum <= data.curveLogSum :=
  data.ftpdLogSum_le_curveLogSum

theorem iutIVCorollary22LogDiffCond_curve_le_ftpd_add_logTwoL
    (data : IUTStage1IUTIVCorollary22LogDiffCondComparisonShadow) :
    data.curveLogSum <= data.ftpdLogSum + data.logTwoL :=
  data.curveLogSum_le_ftpdLogSum_add_logTwoL

theorem iutIVCorollary22LogDiffCondComparison_endpoint
    (data : IUTStage1IUTIVCorollary22LogDiffCondComparisonShadow) :
    data.logDiffX = data.logDifferentFtpd ∧
      data.logConductorFtpd <= data.logCondD ∧
      data.logCondD <= data.logConductorFtpd + data.logTwoL ∧
      data.ftpdLogSum <= data.curveLogSum ∧
      data.curveLogSum <= data.ftpdLogSum + data.logTwoL :=
  data.logDiffCondComparison_endpoint

theorem iutIVCorollary22FinalHToC2_logQAll_bound
    (data : IUTStage1IUTIVCorollary22FinalHToC2Shadow) :
    (1 / 6 : Real) * data.logQAll <=
      (1 + data.epsilonE) * (data.logDiffX + data.logCondD) + data.cK :=
  data.logQAll_le_curveSide

def iutIVCorollary22FinalHToC2_chain
    (data : IUTStage1IUTIVCorollary22FinalHToC2Shadow) :
    IUTStage1IUTIVCorollary22C2InequalityChainShadow :=
  data.toC2InequalityChain

theorem iutIVCorollary22FinalHToC2_endpoint
    (data : IUTStage1IUTIVCorollary22FinalHToC2Shadow) :
    data.h = data.logQAll ∧
      0 < data.epsilonE ∧
      0 <= 1 + data.epsilonE ∧
      data.logDegreeSum <= data.logDiffX + data.logCondD ∧
      (1 / 6 : Real) * data.h <=
        (1 + data.epsilonE) * data.logDegreeSum + data.cK ∧
      (1 / 6 : Real) * data.logQ <=
        (1 / 6 : Real) * data.logQTwo ∧
      (1 / 6 : Real) * data.logQTwo <=
        (1 / 6 : Real) * data.logQAll ∧
      (1 / 6 : Real) * data.logQAll <=
        (1 + data.epsilonE) * (data.logDiffX + data.logCondD) + data.cK ∧
      (1 / 6 : Real) * data.logQ <= data.toC2InequalityChain.heightSide ∧
      (1 / 6 : Real) * data.logQTwo <= data.toC2InequalityChain.heightSide :=
  data.final_h_to_c2_endpoint

theorem iutIVCorollary22ToTheoremA_discrepancy_bounded_below
    {Point : Type u}
    (data : IUTStage1IUTIVCorollary22ToTheoremABoundShadow Point)
    (x : Point) :
    data.lowerBound <= data.discrepancy x :=
  data.discrepancy_bounded_below x

theorem iutIVCorollary22ToTheoremA_handoffEndpoint
    {Point : Type u}
    (data : IUTStage1IUTIVCorollary22ToTheoremABoundShadow Point)
    (x : Point) :
    data.logQTwo_to_canonicalHeight.lower <=
        (1 / 6 : Real) * data.logQTwo x - data.canonicalHeight x ∧
      (1 / 6 : Real) * data.logQTwo x <=
        (1 + data.epsilonE) * (data.logDiff x + data.logCond x) +
          data.cK ∧
      data.canonicalHeight x <=
        (1 + data.epsilonE) * (data.logDiff x + data.logCond x) +
          data.cK - data.logQTwo_to_canonicalHeight.lower ∧
      data.lowerBound <= data.discrepancy x :=
  data.theoremA_handoff_endpoint x

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

theorem iutIVFiniteExceptionLowerBound_endpoint
    {Point : Type u} [DecidableEq Point]
    (data : IUTStage1FiniteExceptionLowerBoundShadow Point)
    (x : Point) :
    data.globalLowerBound <= data.genericLowerBound ∧
      data.globalLowerBound <= data.exceptionalLowerBound ∧
      data.globalLowerBound <= data.function x :=
  data.finite_exception_endpoint x

theorem iutIVCorollary22FiniteExceptionTheoremA_global
    {Point : Type u} [DecidableEq Point]
    (data : IUTStage1IUTIVCorollary22FiniteExceptionTheoremAShadow Point)
    (x : Point) :
    data.globalLowerBound <= data.discrepancy x :=
  data.discrepancy_bounded_below x

theorem iutIVCorollary22FiniteExceptionTheoremA_endpoint
    {Point : Type u} [DecidableEq Point]
    (data : IUTStage1IUTIVCorollary22FiniteExceptionTheoremAShadow Point)
    (x : Point) :
    data.globalLowerBound <= data.genericLowerBound ∧
      data.globalLowerBound <= data.exceptionalLowerBound ∧
      data.globalLowerBound <= data.discrepancy x :=
  data.finite_exception_theoremA_endpoint x

theorem iutIVCorollary23DiophantineInequality_lower_bound
    {Point : Type u}
    (data : IUTStage1IUTIVCorollary23DiophantineInequalityShadow Point)
    (x : Point) :
    data.lowerBound <= data.discrepancy x :=
  data.discrepancy_bounded_below x

theorem iutIVCorollary23DiophantineInequality_endpoint
    {Point : Type u}
    (data : IUTStage1IUTIVCorollary23DiophantineInequalityShadow Point)
    (x : Point) :
    0 < data.d ∧
      0 < data.epsilon ∧
      data.hyperbolicCurve ∧
      data.compactSubsetTheoremA ∧
      (∃ lowerBound : Real, ∀ y : Point, lowerBound <= data.discrepancy y) ∧
      data.lowerBound <= data.discrepancy x :=
  data.diophantine_inequality_endpoint x

theorem finiteLocalLogVolume_endpoint
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1FiniteLocalLogVolumeObject kind) :
    data.localObject.logVolume = data.finiteLogVolume ∧
      data.place = data.localObject.object.place :=
  data.finiteLocalLogVolume_endpoint

theorem processionNormalizedLogVolume_endpoint
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1ProcessionNormalizedLogVolume kind) :
    0 < data.capsuleCount ∧
      data.normalizedLogVolume =
        data.totalLogVolume / (data.capsuleCount : Real) ∧
      data.toFiniteLocalLogVolumeObject = data.localObject :=
  data.processionNormalized_endpoint

theorem localContainerLogVolume_endpoint
    {targetSigned localLogVolume : Real}
    (estimate :
      IUTStage1LocalContainerLogVolumeEstimate targetSigned localLogVolume) :
    localLogVolume = estimate.containerLogVolume ∧
      targetSigned <= estimate.containerLogVolume ∧
      targetSigned <= localLogVolume :=
  estimate.localContainerLogVolume_endpoint

theorem localObjectContainerLogVolume_endpoint
    {kind : IUTStage1PlaceKind}
    {targetSigned localLogVolume : Real}
    (estimate :
      IUTStage1LocalObjectContainerLogVolumeEstimate
        kind targetSigned localLogVolume) :
    localLogVolume = estimate.localObject.finiteLogVolume ∧
      targetSigned <= estimate.object_container_estimate.containerLogVolume ∧
      targetSigned <= estimate.localObject.finiteLogVolume ∧
      targetSigned <= localLogVolume :=
  estimate.localObjectContainerLogVolume_endpoint

theorem flLabelModel_endpoint
    {label : Type u} [Fintype label]
    (model : IUTStage1FLLabelModel label)
    (j : label) (z : ZMod model.prime.value) :
    Fintype.card label = model.prime.value ∧
      model.fromZMod (model.toZMod j) = j ∧
      model.toZMod (model.fromZMod z) = z :=
  model.labelModel_endpoint j z

theorem flLabelTorsorModel_endpoint
    {label : Type}
    (model : IUTStage1FLLabelTorsorModel label)
    (t g h : ZMod model.label_model.prime.value) (j j₁ j₂ : label) :
    model.torsor.vadd t j =
        model.label_model.fromZMod (t + model.label_model.toZMod j) ∧
      model.torsor.vadd 0 j = j ∧
      model.torsor.vadd (g + h) j =
        model.torsor.vadd g (model.torsor.vadd h j) ∧
      (∃! u : ZMod model.label_model.prime.value,
        model.torsor.vadd u j₁ = j₂) :=
  model.torsorModel_endpoint t g h j j₁ j₂

theorem flZModTranslationClosure_endpoint
    (l : PrimeGeFive) (s : Finset (ZMod l.value))
    (hne : s.Nonempty) :
    (¬ ∀ j : ZMod l.value,
        j = 1 -> zmodLabelTranslate l (1 : ZMod l.value) j = 1) ∧
      ((∀ (t j : ZMod l.value), j ∈ s ->
          zmodLabelTranslate l t j ∈ s) -> s = Finset.univ) :=
  IUTStage1FLLabelTorsorModel.zmodTranslationClosure_endpoint l s hne

theorem flZModUnitSignLabelModel_endpoint
    {l : PrimeGeFive}
    (model : IUTStage1FLZModUnitSignLabelModel l)
    (x generator : ZMod l.value) :
    (zmodUnitActionData l).smul model.signUnitCompatibility.signUnit x =
        (zmodSignAction l).neg x ∧
      ((∃ a : (ZMod l.value)ˣ,
        a ∈ model.signUnitSubgroup ∧
          (zmodUnitActionData l).smul a generator = x) ↔
        (zmodSignAction l).InSignOrbit x generator) :=
  model.unitSignLabelModel_endpoint x generator

theorem flZModCuspLabelClassModel_endpoint
    {l : PrimeGeFive}
    (model : IUTStage1FLZModCuspLabelClassModel l) :
    model.local_lab_cusp_model = zmodLocalLabCuspModel l ∧
      model.cusp_label_class_data = zmodCanonicalCuspLabelClassData l ∧
      model.local_lab_cusp_model.canonicalNonzeroLabel.1 =
        model.local_lab_cusp_model.additiveTorsor.vadd
          model.local_lab_cusp_model.canonicalCoordinate
          model.local_lab_cusp_model.labelQuotient.zero ∧
      model.local_lab_cusp_model.canonicalSignLabel =
        model.local_lab_cusp_model.signAction.toSignLabelQuotient
          model.local_lab_cusp_model.canonicalNonzeroLabel ∧
      model.cusp_label_class_data.labelClass =
        model.cusp_label_class_data.model.signAction.toSignLabelQuotient
          model.cusp_label_class_data.model.canonicalNonzeroLabel :=
  model.cuspLabelClassModel_endpoint

theorem zmodCuspFullLabel_fromCoordinate_endpoint
    {l : PrimeGeFive}
    (j k : ZMod l.value) :
    IUTStage1ZModCuspFullLabel.fromCoordinate l (0 : ZMod l.value) =
        IUTStage1ZModCuspFullLabel.zero ∧
      IUTStage1ZModCuspFullLabel.fromCoordinate l (1 : ZMod l.value) =
        IUTStage1ZModCuspFullLabel.nonzero
          (zmodCanonicalSignLabelQuotient l) ∧
      (IUTStage1ZModCuspFullLabel.fromCoordinate l j =
          IUTStage1ZModCuspFullLabel.zero ↔ j = 0) ∧
      (IUTStage1ZModCuspFullLabel.fromCoordinate l j =
          IUTStage1ZModCuspFullLabel.fromCoordinate l k ↔
        j = k ∨ j = -k) ∧
      Function.Surjective (IUTStage1ZModCuspFullLabel.fromCoordinate l) :=
  IUTStage1ZModCuspFullLabel.fromCoordinate_fullLabel_endpoint j k

theorem zmodCuspFullLabel_unitActionAffineDescent_endpoint
    (l : PrimeGeFive) (a b : (ZMod l.value)ˣ) (t j : ZMod l.value)
    (label : IUTStage1ZModCuspFullLabel l) :
    IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l 1 label = label ∧
      IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l (a * b) label =
        IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a
          (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l b label) ∧
      IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
        IUTStage1ZModCuspFullLabel.fromCoordinate l
          ((zmodUnitActionData l).smul a j) ∧
      (IUTStage1ZModCuspFullLabel.unitActionOnFullLabel l a label =
          IUTStage1ZModCuspFullLabel.zero ↔
        label = IUTStage1ZModCuspFullLabel.zero) ∧
      ((∃ T : IUTStage1ZModCuspFullLabel l ->
          IUTStage1ZModCuspFullLabel l,
        ∀ k : ZMod l.value,
          T (IUTStage1ZModCuspFullLabel.fromCoordinate l k) =
            IUTStage1ZModCuspFullLabel.fromCoordinate l
              (zmodLabelTranslate l t ((zmodUnitActionData l).smul a k))) ↔
        t = 0) :=
  IUTStage1ZModCuspFullLabel.unitActionAndAffineDescent_endpoint
    l a b t j label

theorem zmodCuspFullLabel_weightedVolumeSubordinate_endpoint
    (l : PrimeGeFive) (a : (ZMod l.value)ˣ) (t j : ZMod l.value)
    (label : IUTStage1ZModCuspFullLabel l) :
    (IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate label
        IUTStage1ZModCuspFullLabel.zero ↔
      label ≠ IUTStage1ZModCuspFullLabel.zero) ∧
      (IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
          IUTStage1ZModCuspFullLabel.zero ↔
        j ≠ 0) ∧
      (IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            ((zmodUnitActionData l).smul a j))
          IUTStage1ZModCuspFullLabel.zero ↔
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j)
          IUTStage1ZModCuspFullLabel.zero) ∧
      ((∀ k : ZMod l.value,
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
            (IUTStage1ZModCuspFullLabel.fromCoordinate l
              (zmodLabelTranslate l t ((zmodUnitActionData l).smul a k)))
            IUTStage1ZModCuspFullLabel.zero ↔
          IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
            (IUTStage1ZModCuspFullLabel.fromCoordinate l k)
            IUTStage1ZModCuspFullLabel.zero) ↔
        t = 0) ∧
      ¬ ∀ k : ZMod l.value,
        IUTStage1ZModCuspFullLabel.WeightedVolumeSubordinate
          (IUTStage1ZModCuspFullLabel.fromCoordinate l k)
          IUTStage1ZModCuspFullLabel.zero :=
  IUTStage1ZModCuspFullLabel.weightedVolumeSubordinate_endpoint
    l a t j label

theorem zmodCuspFullLabel_localObject_endpoint
    {l : PrimeGeFive} {kind : IUTStage1PlaceKind}
    (zeroObject : IUTStage1FiniteLocalLogVolumeObject kind)
    (cuspClassObject :
      (zmodSignAction l).SignLabelQuotient ->
        IUTStage1FiniteLocalLogVolumeObject kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    IUTStage1ZModCuspFullLabel.localObject zeroObject cuspClassObject
        IUTStage1ZModCuspFullLabel.zero = zeroObject ∧
      IUTStage1ZModCuspFullLabel.localObject zeroObject cuspClassObject
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (0 : ZMod l.value)) = zeroObject ∧
      IUTStage1ZModCuspFullLabel.localObject zeroObject cuspClassObject
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
        cuspClassObject (zmodSignLabelFromCoordinate l j hj) ∧
      IUTStage1ZModCuspFullLabel.localObject zeroObject cuspClassObject
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (-j)) =
        IUTStage1ZModCuspFullLabel.localObject zeroObject cuspClassObject
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) :=
  IUTStage1ZModCuspFullLabel.localObject_endpoint
    zeroObject cuspClassObject j hj

theorem zmodCuspLabelLogVolumeCompatibility_endpoint
    {l : PrimeGeFive}
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (j : ZMod l.value) (hj : j ≠ 0) :
    compat.normalizedLogVolume j =
        compat.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) ∧
      compat.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l
            (0 : ZMod l.value)) =
        compat.zeroLogVolume ∧
      compat.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) =
        compat.cuspClassLogVolume (zmodSignLabelFromCoordinate l j hj) ∧
      compat.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l (-j)) =
        compat.fullLabelLogVolume
          (IUTStage1ZModCuspFullLabel.fromCoordinate l j) ∧
      compat.normalizedLogVolume (-j) =
        compat.cuspClassLogVolume (zmodSignLabelFromCoordinate l j hj) :=
  compat.fullLabelLogVolumeCompatibility_endpoint j hj

theorem zmodCuspLabelLogVolumeCompatibility_fullLabelAverage_endpoint
    {l : PrimeGeFive}
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    {c : Real}
    (hzero : compat.zeroLogVolume <= c)
    (hcusp : ∀ label : (zmodSignAction l).SignLabelQuotient,
      compat.cuspClassLogVolume label <= c) :
    compat.toLabelAveraged.averageLogVolume =
        (Finset.univ.sum fun j : ZMod l.value =>
          compat.fullLabelLogVolume
            (IUTStage1ZModCuspFullLabel.fromCoordinate l j)) /
          (l.value : Real) ∧
      compat.toLabelAveraged.averageLogVolume <= c :=
  compat.toLabelAveraged_fullLabel_average_endpoint hzero hcusp

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
  gaussianFactoredNonarchimedeanCThetaDichotomyAvailable : Bool
  gaussianCanonicalOneNonarchimedeanCThetaDichotomyAvailable : Bool
  logKummerUpperSemiGaussianCThetaDichotomyAvailable : Bool
  kummerForgettingGaussianCThetaDichotomyAvailable : Bool
  targetAlignedKummerForgettingCThetaDichotomyAvailable : Bool
  packetTargetKummerForgettingCThetaDichotomyAvailable : Bool
  packetCalibratedKummerForgettingCThetaDichotomyAvailable : Bool
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
    gaussianFactoredNonarchimedeanCThetaDichotomyAvailable := true,
    gaussianCanonicalOneNonarchimedeanCThetaDichotomyAvailable := true,
    logKummerUpperSemiGaussianCThetaDichotomyAvailable := true,
    kummerForgettingGaussianCThetaDichotomyAvailable := true,
    targetAlignedKummerForgettingCThetaDichotomyAvailable := true,
    packetTargetKummerForgettingCThetaDichotomyAvailable := true,
    packetCalibratedKummerForgettingCThetaDichotomyAvailable := true,
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

theorem corollary312Report_gaussianFactoredNonarchimedeanCThetaDichotomyAvailable :
    corollary312DisputeFirstPassReport.gaussianFactoredNonarchimedeanCThetaDichotomyAvailable =
      true :=
  rfl

theorem corollary312Report_gaussianCanonicalOneNonarchimedeanCThetaDichotomyAvailable :
    corollary312DisputeFirstPassReport.gaussianCanonicalOneNonarchimedeanCThetaDichotomyAvailable =
      true :=
  rfl

theorem corollary312Report_logKummerUpperSemiGaussianCThetaDichotomyAvailable :
    corollary312DisputeFirstPassReport.logKummerUpperSemiGaussianCThetaDichotomyAvailable =
      true :=
  rfl

theorem corollary312Report_kummerForgettingGaussianCThetaDichotomyAvailable :
    corollary312DisputeFirstPassReport.kummerForgettingGaussianCThetaDichotomyAvailable =
      true :=
  rfl

theorem corollary312Report_targetAlignedKummerForgettingCThetaDichotomyAvailable :
    corollary312DisputeFirstPassReport.targetAlignedKummerForgettingCThetaDichotomyAvailable =
      true :=
  rfl

theorem corollary312Report_packetTargetKummerForgettingCThetaDichotomyAvailable :
    corollary312DisputeFirstPassReport.packetTargetKummerForgettingCThetaDichotomyAvailable =
      true :=
  rfl

theorem corollary312Report_packetCalibratedKummerForgettingCThetaDichotomyAvailable :
    corollary312DisputeFirstPassReport.packetCalibratedKummerForgettingCThetaDichotomyAvailable =
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
Corollary 3.12 first-pass `C_Theta` dichotomy from Gaussian-derived factored
SHE data and a nonarchimedean `(Ind3)` entry.

This is the current strongest experiment-surface form of the route: the
factored square/full-label preservation package is constructed from Gaussian
degree evaluations before the nonarchimedean endpoint is applied.
-/
theorem corollary312_firstPass_cThetaDichotomy_from_gaussianFactoredSHEAndNonarchimedeanEntry
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
    (target_log_volume_eq_theta :
      targetEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {entry : IUTStage1NonarchimedeanInclusionData}
    (entryAlignment :
      NonarchimedeanInd3EntryAlignment audited entry
        (part.insulated_route.theta_source.thetaSourceAverage audited))
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_gaussianFactoredNonarchimedeanEntry
    profile audited coordinateEquiv sourceProfile targetProfile
    sourceEvaluation targetEvaluation coordinate_square_preserved
    fullLabelMap_preserved environmentDegree_preserved source_profile_eq
    source_log_volume_eq target_log_volume_eq_theta entryAlignment
    q_pilot_positive cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy from the identity-coordinate
Gaussian route and canonical-one preservation.

Compared with the general Gaussian-derived route, this endpoint no longer
takes an explicit coordinate automorphism, full-label map preservation proof,
or environment-degree preservation proof.  In the identity case, equality at
the canonical full label supplies the environment-degree preservation.
-/
theorem corollary312_firstPass_cThetaDichotomy_from_gaussianCanonicalOneSHEAndNonarchimedeanEntry
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
    (target_log_volume_eq_theta :
      targetEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {entry : IUTStage1NonarchimedeanInclusionData}
    (entryAlignment :
      NonarchimedeanInd3EntryAlignment audited entry
        (part.insulated_route.theta_source.thetaSourceAverage audited))
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_gaussianIdentityCanonicalOneNonarchimedeanEntry
    profile audited sourceProfile targetProfile sourceEvaluation
    targetEvaluation canonical_one_preserved source_profile_eq
    source_log_volume_eq target_log_volume_eq_theta entryAlignment
    q_pilot_positive cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy from the identity-coordinate
Gaussian route and a nonarchimedean upper-semi entry equipped with 1-column
q-pilot log-Kummer data.

This is the strongest current experiment-surface form of the nonarchimedean
route: the raw `(Ind3)` entry alignment is supplied by a source-facing
log-Kummer upper-semi compatibility object.
-/
theorem corollary312_firstPass_cThetaDichotomy_from_gaussianCanonicalOneLogKummerUpperSemiEntry
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
    (target_log_volume_eq_theta :
      targetEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    (logKummerUpperSemi :
      NonarchimedeanLogKummerUpperSemiCompatibility audited
        (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_gaussianIdentityCanonicalOneLogKummerUpperSemiEntry
    profile audited sourceProfile targetProfile sourceEvaluation
    targetEvaluation canonical_one_preserved source_profile_eq
    source_log_volume_eq target_log_volume_eq_theta logKummerUpperSemi
    q_pilot_positive cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy from the identity-coordinate
Gaussian route and a Kummer-plus-forgetting source-side upper-semi chain.

The source-side real equality in the log-Kummer upper-semi object is derived
from product-log-volume preservation along
`holomorphicF -> holomorphicD -> monoAnalyticD`.
-/
theorem corollary312_firstPass_cThetaDichotomy_from_gaussianCanonicalOneKummerForgettingEntry
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
    (target_log_volume_eq_theta :
      targetEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD)
    (entry : IUTStage1NonarchimedeanInclusionData)
    (entry_mem :
      entry ∈ audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.product.productLogVolume)
    (ind3Source_eq_holomorphicFProduct :
      audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume =
        holomorphicF.product.productLogVolume)
    (thetaAverage_eq_entryTarget :
      part.insulated_route.theta_source.thetaSourceAverage audited =
        entry.targetLogVolume.finiteLogVolume)
    (entryTarget_eq_ind3Target :
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_gaussianIdentityCanonicalOneKummerForgettingEntry
    profile audited sourceProfile targetProfile sourceEvaluation targetEvaluation
    canonical_one_preserved source_profile_eq source_log_volume_eq
    target_log_volume_eq_theta kummer forgetting entry entry_mem
    packetLocalObject_eq_entrySource entrySource_eq_monoAnalyticProduct
    ind3Source_eq_holomorphicFProduct thetaAverage_eq_entryTarget
    entryTarget_eq_ind3Target q_pilot_positive cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy from the identity-coordinate
Gaussian route, Kummer-plus-forgetting source preservation, and a target-side
Step (x) theta alignment. The theta-to-entry-target equality is derived from
the upper-semi target alignment and the entry's target calibration.
-/
theorem corollary312_firstPass_cThetaDichotomy_from_targetAlignedKummerForgetting
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
    (target_log_volume_eq_theta :
      targetEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD)
    (entry : IUTStage1NonarchimedeanInclusionData)
    (entry_mem :
      entry ∈ audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.product.productLogVolume)
    (ind3Source_eq_holomorphicFProduct :
      audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume =
        holomorphicF.product.productLogVolume)
    (thetaTargetAlignment : Ind3ThetaTargetAlignment part audited)
    (entryTarget_eq_ind3Target :
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_gaussianKummerForgettingTargetAlignedEntry
    profile audited sourceProfile targetProfile sourceEvaluation targetEvaluation
    canonical_one_preserved source_profile_eq source_log_volume_eq
    target_log_volume_eq_theta kummer forgetting entry entry_mem
    packetLocalObject_eq_entrySource entrySource_eq_monoAnalyticProduct
    ind3Source_eq_holomorphicFProduct thetaTargetAlignment
    entryTarget_eq_ind3Target q_pilot_positive cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy where the target-side Step (x)
alignment is itself derived from packet-normalized theta-source equality.
-/
theorem corollary312_firstPass_cThetaDichotomy_from_packetTargetKummerForgetting
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
    (target_log_volume_eq_theta :
      targetEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD)
    (entry : IUTStage1NonarchimedeanInclusionData)
    (entry_mem :
      entry ∈ audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.product.productLogVolume)
    (ind3Source_eq_holomorphicFProduct :
      audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume =
        holomorphicF.product.productLogVolume)
    (thetaSourceAverage_eq_packetNormalized :
      part.insulated_route.theta_source.thetaSourceAverage audited =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (ind3Target_eq_packetNormalized :
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (entryTarget_eq_ind3Target :
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_gaussianKummerForgettingPacketTargetEntry
    profile audited sourceProfile targetProfile sourceEvaluation targetEvaluation
    canonical_one_preserved source_profile_eq source_log_volume_eq
    target_log_volume_eq_theta kummer forgetting entry entry_mem
    packetLocalObject_eq_entrySource entrySource_eq_monoAnalyticProduct
    ind3Source_eq_holomorphicFProduct thetaSourceAverage_eq_packetNormalized
    ind3Target_eq_packetNormalized entryTarget_eq_ind3Target q_pilot_positive
    cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy where the target-side Step (x)
and entry-target calibrations are both made against packet-normalized
log-volume.
-/
theorem corollary312_firstPass_cThetaDichotomy_from_packetCalibratedKummerForgetting
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
    (target_log_volume_eq_theta :
      targetEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD)
    (entry : IUTStage1NonarchimedeanInclusionData)
    (entry_mem :
      entry ∈ audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.product.productLogVolume)
    (ind3Source_eq_holomorphicFProduct :
      audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume =
        holomorphicF.product.productLogVolume)
    (thetaSourceAverage_eq_packetNormalized :
      part.insulated_route.theta_source.thetaSourceAverage audited =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (ind3Target_eq_packetNormalized :
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (entryTarget_eq_packetNormalized :
      entry.targetLogVolume.finiteLogVolume =
        audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_gaussianKummerForgettingPacketCalibratedEntry
    profile audited sourceProfile targetProfile sourceEvaluation targetEvaluation
    canonical_one_preserved source_profile_eq source_log_volume_eq
    target_log_volume_eq_theta kummer forgetting entry entry_mem
    packetLocalObject_eq_entrySource entrySource_eq_monoAnalyticProduct
    ind3Source_eq_holomorphicFProduct thetaSourceAverage_eq_packetNormalized
    ind3Target_eq_packetNormalized entryTarget_eq_packetNormalized
    q_pilot_positive cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy where the target-side Step (x)
packet-normalized equalities are supplied by one log-Kummer packet-target
calibration object.
-/
theorem corollary312_firstPass_cThetaDichotomy_from_packetTargetCalibrationKummerForgetting
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
    (target_log_volume_eq_theta :
      targetEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD)
    (entry : IUTStage1NonarchimedeanInclusionData)
    (entry_mem :
      entry ∈ audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (packetLocalObject_eq_entrySource :
      audited.choice.local_tensor_state.packetState.localObject =
        entry.sourceLogVolume)
    (entrySource_eq_monoAnalyticProduct :
      entry.sourceLogVolume.finiteLogVolume =
        monoAnalyticD.product.productLogVolume)
    (ind3Source_eq_holomorphicFProduct :
      audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume =
        holomorphicF.product.productLogVolume)
    (targetCalibration :
      NonarchimedeanLogKummerPacketTargetCalibration
        audited
        (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer entry)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_gaussianKummerForgettingPacketTargetCalibrationEntry
    profile audited sourceProfile targetProfile sourceEvaluation targetEvaluation
    canonical_one_preserved source_profile_eq source_log_volume_eq
    target_log_volume_eq_theta kummer forgetting entry entry_mem
    packetLocalObject_eq_entrySource entrySource_eq_monoAnalyticProduct
    ind3Source_eq_holomorphicFProduct targetCalibration
    q_pilot_positive cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy where the source-side and
target-side Step (x) calibrations are supplied by one finite log-Kummer packet
correspondence object.
-/
theorem corollary312_firstPass_cThetaDichotomy_from_packetCorrespondenceKummerForgetting
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
    (target_log_volume_eq_theta :
      targetEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealizedTensorPacketProductLogVolume
        IUTStage1PlaceKind.nonarchimedean j}
    (kummer :
      IUTStage1KummerFTensorPacketToDTensorPacketTransfer
        holomorphicF holomorphicD)
    (forgetting :
      IUTStage1MonoAnalyticTensorPacketForgettingTransfer
        holomorphicD monoAnalyticD)
    (entry : IUTStage1NonarchimedeanInclusionData)
    (entry_mem :
      entry ∈ audited.choice.upper_semi_state.nonarchimedeanInclusions)
    (packetCorrespondence :
      NonarchimedeanLogKummerPacketCorrespondenceSource
        audited
        (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer entry
        holomorphicF holomorphicD monoAnalyticD)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_gaussianKummerForgettingPacketCorrespondenceEntry
    profile audited sourceProfile targetProfile sourceEvaluation targetEvaluation
    canonical_one_preserved source_profile_eq source_log_volume_eq
    target_log_volume_eq_theta kummer forgetting entry entry_mem
    packetCorrespondence q_pilot_positive cTheta thetaSigned_le_cTheta_absLogQ

/--
Corollary 3.12 first-pass `C_Theta` dichotomy from one realified-Frobenioid
log-Kummer Step (x) entry source.

This is the strongest current Step (x) experiment endpoint: product-log-volume
preservation is obtained from realified Frobenioid compatibility, while the
source and target packet calibrations remain attached to the same log-Kummer
entry source.
-/
theorem corollary312_firstPass_cThetaDichotomy_from_realifiedFrobenioidLogKummerEntry
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
    (target_log_volume_eq_theta :
      targetEvaluation.toCuspLabelLogVolumeCompatibility =
        part.toThetaCuspClassContainerAudit.theta_source.compatible_average.cuspLogVolume
          audited)
    {j : Nat}
    {holomorphicF holomorphicD monoAnalyticD :
      IUTStage1RealifiedFrobenioidTensorPacketProductSource
        IUTStage1PlaceKind.nonarchimedean j}
    {entry : IUTStage1NonarchimedeanInclusionData}
    (realifiedSource :
      NonarchimedeanRealifiedFrobenioidLogKummerEntrySource
        audited
        (part.insulated_route.theta_source.thetaSourceAverage audited)
        package.logKummer entry
        holomorphicF holomorphicD monoAnalyticD)
    (q_pilot_positive : 0 < -package.preLedger.qSigned)
    (cTheta : Real)
    (thetaSigned_le_cTheta_absLogQ :
      package.preLedger.thetaSigned <=
        cTheta * (-package.preLedger.qSigned)) :
    (package.preLedger.qSigned = package.preLedger.thetaSigned ∧
        package.preLedger.thetaSigned < 0) ∨
      (-1 : Real) < cTheta :=
  part.boundarySignedEqualityOrStrictCTheta_of_gaussianRealifiedFrobenioidLogKummerEntry
    profile audited sourceProfile targetProfile sourceEvaluation targetEvaluation
    canonical_one_preserved source_profile_eq source_log_volume_eq
    target_log_volume_eq_theta realifiedSource q_pilot_positive cTheta
    thetaSigned_le_cTheta_absLogQ

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
