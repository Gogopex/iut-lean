/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Stage1.IUTStage1Source
import Iut.Stage1.IUTStage1DataExample

/-!
Regression examples for the source-facing Stage 1 package.

These examples route the existing toy pre-ledger data through the non-toy
source-facing API. They do not assert that the toy data is genuine IUT data; the
purpose is only to verify that the source-facing package remains usable once
explicit source obligations are supplied.
-/

namespace Iut
namespace Stage1
namespace ToyModel

open RealLineCopy
open IUTStage1DirectSummandPacketTheorem311Choice

variable {index : Type u}

def unitThetaToyIUTStage1SourceLabels : IUTStage1SourceLabels :=
  { theorem311ToCorollary312Labels with
    input := unitThetaToyStage1Input,
    multiradialOutput := unitThetaToyMultiradialOutput,
    logVolumeComparison := unitThetaToyLogVolumeComparison }

def unitThetaToyIUTStage1SourcePackage
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourcePackage qLine thetaLine index :=
  { labels := unitThetaToyIUTStage1SourceLabels,
    preLedger := unitThetaToyPreLedgerData measure hnormalized hh hbound hholds,
    input_eq := rfl,
    multiradialOutput_eq := rfl,
    logVolumeComparison_eq := rfl }

def unitThetaToyIUTStage1SourceHullDetData
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceHullDetData
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  { sourceData :=
      unitThetaToyPreLedgerHullDetSourceData
        measure hnormalized hh hbound hholds }

def unitThetaToyIUTStage1CoricData
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1CoricData
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  IUTStage1CoricData.ofPackage
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_coricData_commonLanguage_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1CoricData
      measure hnormalized hh hbound hholds).commonLanguage =
      (unitThetaToyIUTStage1CoricData
        measure hnormalized hh hbound hholds).sharedContext.commonLanguage :=
  (unitThetaToyIUTStage1CoricData
    measure hnormalized hh hbound hholds).commonLanguageMatchesSharedContext

theorem unitThetaToy_coricData_hdd_matches_package_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (unitThetaToyIUTStage1CoricData
      measure hnormalized hh hbound hholds).hdd =
      package.preLedger.chartedContainer.commonContainer.hddShe.hdd :=
  (unitThetaToyIUTStage1CoricData
    measure hnormalized hh hbound hholds).hddMatchesPackage

def unitThetaToyThetaPilotPossibleImages
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1ThetaPilotPossibleImages
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  IUTStage1ThetaPilotPossibleImages.ofPackage
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_thetaPilotPossibleImages_union_eq_targetUnion_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyThetaPilotPossibleImages
      measure hnormalized hh hbound hholds).union =
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).preLedger.output.comparisons.targetUnion :=
  (unitThetaToyThetaPilotPossibleImages
    measure hnormalized hh hbound hholds).union_eq_targetUnion

theorem unitThetaToy_thetaPilotPossibleImages_choice_region_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyThetaPilotPossibleImages
      measure hnormalized hh hbound hholds).images.region choice =
      ((unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).preLedger.output.comparison
          choice).targetRegion :=
  (unitThetaToyThetaPilotPossibleImages
    measure hnormalized hh hbound hholds).choice_region_eq_targetRegion choice

theorem unitThetaToy_thetaPilotPossibleImages_union_subset_hull_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    Region.Subset
      (unitThetaToyThetaPilotPossibleImages
        measure hnormalized hh hbound hholds).union
      ((unitThetaToyIUTStage1SourceHullDetData
        measure hnormalized hh hbound hholds).sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  (unitThetaToyThetaPilotPossibleImages
    measure hnormalized hh hbound hholds).union_subset_target
      (unitThetaToyIUTStage1SourceHullDetData
        measure hnormalized hh hbound hholds).targetUnion_subset_hull

def unitThetaToyIndeterminacyQuotient :
    IUTStage1IndeterminacyQuotient index :=
  IUTStage1IndeterminacyQuotient.discrete index

theorem unitThetaToyIndeterminacyQuotient_profile_example :
    unitThetaToyIndeterminacyQuotient (index := index).profile =
      theorem311IndeterminacyProfile :=
  IUTStage1IndeterminacyQuotient.discrete_profile index

def unitThetaToyIndeterminacyGenerators :
    IUTStage1IndeterminacyGenerators index :=
  { ind1_step := fun _ _ => False,
    ind2_step := fun _ _ => False,
    ind3_step := fun _ _ => False }

def unitThetaToyGeneratedIndeterminacyQuotient :
    IUTStage1IndeterminacyQuotient index :=
  IUTStage1IndeterminacyQuotient.generated
    (unitThetaToyIndeterminacyGenerators (index := index))

theorem unitThetaToyGeneratedIndeterminacyQuotient_profile_example :
    unitThetaToyGeneratedIndeterminacyQuotient (index := index).profile =
      theorem311IndeterminacyProfile :=
  IUTStage1IndeterminacyQuotient.generated_profile
    (unitThetaToyIndeterminacyGenerators (index := index))

def unitThetaToyTheorem311IndeterminacySourceData :
    IUTStage1Theorem311IndeterminacySourceData index :=
  { procession_automorphism_step := fun _ _ => False,
    local_tensor_symmetry_step := fun _ _ => False,
    upper_semi_compatibility_step := fun _ _ => False }

theorem unitThetaToyTheorem311IndeterminacySourceData_profile_example :
    (unitThetaToyTheorem311IndeterminacySourceData
      (index := index)).quotient.profile =
      theorem311IndeterminacyProfile :=
  IUTStage1Theorem311IndeterminacySourceData.quotient_profile
    (unitThetaToyTheorem311IndeterminacySourceData (index := index))

theorem theorem311Choice_generated_coric_eq_example
    {coric processionState localTensorState upperSemiState : Type u}
    {choice₁ choice₂ :
      IUTStage1Theorem311Choice
        coric processionState localTensorState upperSemiState}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1Theorem311Choice.indeterminacySourceData
          (coric := coric) (processionState := processionState)
          (localTensorState := localTensorState)
          (upperSemiState := upperSemiState)).generators
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric :=
  IUTStage1Theorem311Choice.generated_coric_eq hrel

theorem theorem311Choice_generated_column_eq_example
    {coric processionState localTensorState upperSemiState : Type u}
    {choice₁ choice₂ :
      IUTStage1Theorem311Choice
        coric processionState localTensorState upperSemiState}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1Theorem311Choice.indeterminacySourceData
          (coric := coric) (processionState := processionState)
          (localTensorState := localTensorState)
          (upperSemiState := upperSemiState)).generators
        choice₁ choice₂) :
    choice₁.column = choice₂.column :=
  IUTStage1Theorem311Choice.generated_column_eq hrel

theorem theorem311Choice_image_invariant_of_coric_example
    {coric processionState localTensorState upperSemiState : Type u}
    (images :
      RegionFamily thetaLine
        (IUTStage1Theorem311Choice
          coric processionState localTensorState upperSemiState))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          images.region choice₁ = images.region choice₂)
    {choice₁ choice₂ :
      IUTStage1Theorem311Choice
        coric processionState localTensorState upperSemiState}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1Theorem311Choice.indeterminacySourceData
          (coric := coric) (processionState := processionState)
          (localTensorState := localTensorState)
          (upperSemiState := upperSemiState)).generators
        choice₁ choice₂) :
    images.region choice₁ = images.region choice₂ :=
  IUTStage1Theorem311Choice.image_invariant_of_coric images hcoric hrel

theorem structuredTheorem311_ind1_preserves_procession_column_example
    {coric : Type u}
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      IUTStage1StructuredTheorem311Choice.ProcessionAutomorphismStep
        choice₁ choice₂) :
    choice₁.procession_state.column = choice₂.procession_state.column :=
  IUTStage1StructuredTheorem311Choice.ind1_preserves_procession_column
    hstep

theorem structuredTheorem311_ind2_preserves_directSummandCount_example
    {coric : Type u}
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      IUTStage1StructuredTheorem311Choice.LocalTensorSymmetryStep
        choice₁ choice₂) :
    choice₁.local_tensor_state.directSummandCount =
      choice₂.local_tensor_state.directSummandCount :=
  IUTStage1StructuredTheorem311Choice.ind2_preserves_directSummandCount
    hstep

theorem structuredTheorem311_ind3_preserves_logThetaColumn_example
    {coric : Type u}
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      IUTStage1StructuredTheorem311Choice.UpperSemiCompatibilityStep
        choice₁ choice₂) :
    choice₁.upper_semi_state.logThetaColumn =
      choice₂.upper_semi_state.logThetaColumn :=
  IUTStage1StructuredTheorem311Choice.ind3_preserves_logThetaColumn
    hstep

theorem upperSemi_nonarchimedeanInclusion_valid_example
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.inclusionValid :=
  data.valid

theorem upperSemi_nonarchimedeanInclusion_source_place_example
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.sourceObject.place = data.place :=
  data.sourcePlaceMatches

theorem upperSemi_nonarchimedeanInclusion_target_place_example
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.targetObject.place = data.place :=
  data.targetPlaceMatches

theorem upperSemi_nonarchimedeanInclusion_source_logVolume_object_example
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.sourceLogVolume.localObject.object = data.sourceObject :=
  data.sourceLogVolumeObjectMatches

theorem upperSemi_nonarchimedeanInclusion_target_logVolume_object_example
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.targetLogVolume.localObject.object = data.targetObject :=
  data.targetLogVolumeObjectMatches

theorem upperSemi_nonarchimedeanInclusion_logVolume_le_example
    (data : IUTStage1NonarchimedeanInclusionData) :
    data.sourceLogVolume.finiteLogVolume <=
      data.targetLogVolume.finiteLogVolume :=
  data.logVolume_le

theorem upperSemi_archimedeanSurjection_valid_example
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.surjectionValid :=
  data.valid

theorem upperSemi_archimedeanSurjection_source_place_example
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.sourceObject.place = data.place :=
  data.sourcePlaceMatches

theorem upperSemi_archimedeanSurjection_target_place_example
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.targetObject.place = data.place :=
  data.targetPlaceMatches

theorem upperSemi_archimedeanSurjection_source_logVolume_object_example
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.sourceLogVolume.localObject.object = data.sourceObject :=
  data.sourceLogVolumeObjectMatches

theorem upperSemi_archimedeanSurjection_target_logVolume_object_example
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.targetLogVolume.localObject.object = data.targetObject :=
  data.targetLogVolumeObjectMatches

theorem upperSemi_archimedeanSurjection_logVolume_le_example
    (data : IUTStage1ArchimedeanSurjectionData) :
    data.targetLogVolume.finiteLogVolume <=
      data.sourceLogVolume.finiteLogVolume :=
  data.logVolume_le

theorem upperSemi_finiteLocalLogVolume_eq_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1FiniteLocalLogVolumeObject kind) :
    data.localObject.logVolume = data.finiteLogVolume :=
  data.logVolume_eq

theorem upperSemi_processionNormalizedLogVolume_eq_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1ProcessionNormalizedLogVolume kind) :
    data.normalizedLogVolume =
      data.totalLogVolume / (data.capsuleCount : Real) :=
  data.normalized_eq

theorem upperSemi_processionNormalizedLogVolume_capsuleCount_pos_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1ProcessionNormalizedLogVolume kind) :
    0 < data.capsuleCount :=
  data.capsuleCount_pos

def upperSemi_processionNormalized_to_finite_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1ProcessionNormalizedLogVolume kind) :
    IUTStage1FiniteLocalLogVolumeObject kind :=
  data.toFiniteLocalLogVolumeObject

theorem localTensorPacketNormalizedCompatibility_finite_eq_normalized_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    (compat : IUTStage1LocalTensorPacketNormalizedCompatibility state) :
    state.localObject.finiteLogVolume =
      state.capsuleFamily.normalizedLogVolume :=
  compat.localObject_finiteLogVolume_eq_normalizedLogVolume

theorem localTensorPacketNormalizedCompatibility_average_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    (compat : IUTStage1LocalTensorPacketNormalizedCompatibility state) :
    state.localObject.finiteLogVolume =
      state.capsuleFamily.totalLogVolume /
        (state.capsuleFamily.capsuleCount : Real) :=
  compat.normalizedLogVolume_eq_capsuleAverage

def classifiedLocalTensorPacketNormalizedCompatibility_direct_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    (compat : IUTStage1LocalTensorPacketNormalizedCompatibility state) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility state :=
  IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility.ofDirectPacketNormalization
    compat

def classifiedLocalTensorPacketNormalizedCompatibility_ind2_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    (compat : IUTStage1LocalTensorPacketNormalizedCompatibility state) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility state :=
  IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility.ofInd2TransportedPacketNormalization
    compat

theorem classifiedLocalTensorPacketNormalizedCompatibility_source_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    (compat : IUTStage1LocalTensorPacketNormalizedCompatibility state) :
    (IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility.ofSeparateRealLineIdentification
      compat).identification_source =
        IUTStage1PacketNormalizedIdentificationSource.separateRealLineIdentification :=
  rfl

def directPacketNormalizationData_to_compatibility_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    (data : IUTStage1DirectPacketNormalizationData state) :
    IUTStage1LocalTensorPacketNormalizedCompatibility state :=
  data.toPacketNormalizedCompatibility

theorem directPacketNormalizationData_capsule_average_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    (data : IUTStage1DirectPacketNormalizationData state) :
    state.localObject.finiteLogVolume =
      state.capsuleFamily.totalLogVolume /
        (state.capsuleFamily.capsuleCount : Real) :=
  data.localObject_finiteLogVolume_eq_capsuleAverage

def directPacketNormalizationData_to_classified_compatibility_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    (data : IUTStage1DirectPacketNormalizationData state) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility state :=
  data.toClassifiedPacketNormalizedCompatibility

theorem directPacketNormalizationData_capsule_estimates_bound_localObject_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    {targetSigned : Real}
    (data : IUTStage1DirectPacketNormalizationData state)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned state.capsuleFamily) :
    targetSigned <= state.localObject.finiteLogVolume :=
  data.targetSigned_le_localObject_of_capsule_estimates estimate

def directPacketNormalizationData_capsule_estimates_to_localObject_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    {targetSigned : Real}
    (data : IUTStage1DirectPacketNormalizationData state)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned state.capsuleFamily) :
    IUTStage1LocalObjectContainerLogVolumeEstimate
      kind targetSigned state.localObject.finiteLogVolume :=
  data.toLocalObjectContainerEstimateOfCapsuleEstimates estimate

def directPacketNormalizationData_capsule_estimates_to_identified_log_example
    {kind : IUTStage1PlaceKind}
    {state : IUTStage1LocalTensorPacketLogVolumeState kind}
    {targetSigned localLogVolume : Real}
    (data : IUTStage1DirectPacketNormalizationData state)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned state.capsuleFamily)
    (hlog : localLogVolume = state.localObject.finiteLogVolume) :
    IUTStage1LocalObjectContainerLogVolumeEstimate
      kind targetSigned localLogVolume :=
  data.toLocalObjectContainerEstimateOfIdentifiedLogVolume estimate hlog

theorem localContainerLogVolumeEstimate_target_le_local_example
    {targetSigned localLogVolume : Real}
    (estimate :
      IUTStage1LocalContainerLogVolumeEstimate targetSigned localLogVolume) :
    targetSigned <= localLogVolume :=
  estimate.targetSigned_le_localLogVolume

theorem localObjectContainerLogVolumeEstimate_target_le_local_example
    {kind : IUTStage1PlaceKind} {targetSigned localLogVolume : Real}
    (estimate :
      IUTStage1LocalObjectContainerLogVolumeEstimate
        kind targetSigned localLogVolume) :
    targetSigned <= localLogVolume :=
  estimate.targetSigned_le_localLogVolume

theorem packetNormalizedContainerEstimate_target_le_local_example
    {kind : IUTStage1PlaceKind}
    {packetState : IUTStage1LocalTensorDirectSummandPacketState kind}
    {targetSigned localLogVolume : Real}
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume) :
    targetSigned <= localLogVolume :=
  estimate.targetSigned_le_localLogVolume

theorem packetNormalizedContainerEstimate_capsule_sum_example
    {kind : IUTStage1PlaceKind}
    {packetState : IUTStage1LocalTensorDirectSummandPacketState kind}
    {targetSigned localLogVolume : Real}
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume) :
    localLogVolume =
      (Finset.univ.sum fun i =>
          (packetState.packetState.capsuleFamily.capsule i).logVolume) /
        (packetState.packetState.capsuleFamily.capsuleCount : Real) :=
  estimate.localLogVolume_eq_capsuleSumAverage

def packetNormalizedContainerEstimate_of_local_compatibility_example
    {kind : IUTStage1PlaceKind}
    {packetState : IUTStage1LocalTensorDirectSummandPacketState kind}
    {targetSigned localLogVolume : Real}
    (objectEstimate :
      IUTStage1LocalObjectContainerLogVolumeEstimate
        kind targetSigned localLogVolume)
    (hobject :
      objectEstimate.localObject =
        packetState.packetState.localObject)
    (compat :
      IUTStage1LocalTensorPacketNormalizedCompatibility
        packetState.packetState) :
    IUTStage1PacketNormalizedContainerEstimate
      packetState targetSigned localLogVolume :=
  IUTStage1PacketNormalizedContainerEstimate.ofLocalObjectCompatibility
    objectEstimate hobject compat

def packetNormalizedContainerEstimate_of_classified_local_compatibility_example
    {kind : IUTStage1PlaceKind}
    {packetState : IUTStage1LocalTensorDirectSummandPacketState kind}
    {targetSigned localLogVolume : Real}
    (objectEstimate :
      IUTStage1LocalObjectContainerLogVolumeEstimate
        kind targetSigned localLogVolume)
    (hobject :
      objectEstimate.localObject =
        packetState.packetState.localObject)
    (classified :
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        packetState.packetState) :
    IUTStage1PacketNormalizedContainerEstimate
      packetState targetSigned localLogVolume :=
  IUTStage1PacketNormalizedContainerEstimate.ofClassifiedLocalObjectCompatibility
    objectEstimate hobject classified

theorem typedCapsuleFamily_const_le_normalized_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind)
    {c : Real}
    (hcapsule :
      ∀ i : Fin data.capsuleCount, c <= (data.capsule i).logVolume) :
    c <= data.normalizedLogVolume :=
  data.const_le_normalizedLogVolume_of_capsule_le hcapsule

theorem capsuleEntryContainerEstimate_target_le_capsule_example
    {kind : IUTStage1PlaceKind} {targetSigned : Real}
    {capsule : IUTStage1CapsuleLogVolumeObject kind}
    (estimate :
      IUTStage1CapsuleEntryContainerEstimate targetSigned capsule) :
    targetSigned <= capsule.logVolume :=
  estimate.targetSigned_le_capsuleLogVolume

theorem typedCapsuleFamilyContainerEstimate_target_le_normalized_example
    {kind : IUTStage1PlaceKind} {targetSigned : Real}
    {data : IUTStage1TypedCapsuleFamilyLogVolume kind}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate targetSigned data) :
    targetSigned <= data.normalizedLogVolume :=
  estimate.targetSigned_le_normalizedLogVolume

theorem packetNormalizedContainerEstimate_capsule_bound_example
    {kind : IUTStage1PlaceKind}
    {packetState : IUTStage1LocalTensorDirectSummandPacketState kind}
    {targetSigned localLogVolume : Real}
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume)
    (hcapsule :
      ∀ i : Fin packetState.packetState.capsuleFamily.capsuleCount,
        targetSigned <=
          (packetState.packetState.capsuleFamily.capsule i).logVolume) :
    targetSigned <= localLogVolume :=
  estimate.targetSigned_le_localLogVolume_of_capsule_le hcapsule

theorem packetNormalizedContainerEstimate_capsule_estimates_example
    {kind : IUTStage1PlaceKind}
    {packetState : IUTStage1LocalTensorDirectSummandPacketState kind}
    {targetSigned localLogVolume : Real}
    (estimate :
      IUTStage1PacketNormalizedContainerEstimate
        packetState targetSigned localLogVolume)
    (capsuleEstimates :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned packetState.packetState.capsuleFamily) :
    targetSigned <= localLogVolume :=
  estimate.targetSigned_le_localLogVolume_of_capsule_estimates capsuleEstimates

def typedCapsuleFamilyAction_transformed_container_estimate_example
    {kind : IUTStage1PlaceKind} {targetSigned : Real}
    {data : IUTStage1TypedCapsuleFamilyLogVolume kind}
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate targetSigned data) :
    IUTStage1TypedCapsuleFamilyContainerEstimate
      targetSigned action.transformedFamily :=
  action.transformedContainerEstimate estimate

theorem typedCapsuleFamilyAction_transformed_container_bound_example
    {kind : IUTStage1PlaceKind} {targetSigned : Real}
    {data : IUTStage1TypedCapsuleFamilyLogVolume kind}
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate targetSigned data) :
    targetSigned <= action.transformedFamily.normalizedLogVolume :=
  action.transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    estimate

def directSummandFamilyAction_transformed_container_estimate_example
    {kind : IUTStage1PlaceKind} {targetSigned : Real}
    {capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (action : IUTStage1TensorDirectSummandFamilyAction family)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned capsuleFamily) :
    IUTStage1TypedCapsuleFamilyContainerEstimate
      targetSigned action.toCapsuleAction.transformedFamily :=
  action.transformedContainerEstimate estimate

theorem directSummandFamilyAction_transformed_container_bound_example
    {kind : IUTStage1PlaceKind} {targetSigned : Real}
    {capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (action : IUTStage1TensorDirectSummandFamilyAction family)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned capsuleFamily) :
    targetSigned <= action.toCapsuleAction.transformedFamily.normalizedLogVolume :=
  action.transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    estimate

theorem nonarchimedeanDirectSummandAction_transformed_container_bound_example
    {targetSigned : Real}
    {capsuleFamily :
      IUTStage1TypedCapsuleFamilyLogVolume
        IUTStage1PlaceKind.nonarchimedean}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (action : IUTStage1NonarchimedeanIsmDirectSummandAction family)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned capsuleFamily) :
    targetSigned <=
      action.toDirectSummandAction.toCapsuleAction.transformedFamily.normalizedLogVolume :=
  action.transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    estimate

theorem archimedeanDirectSummandAction_transformed_container_bound_example
    {targetSigned : Real}
    {capsuleFamily :
      IUTStage1TypedCapsuleFamilyLogVolume IUTStage1PlaceKind.archimedean}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (action : IUTStage1ArchimedeanOrderTwoDirectSummandAction family)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned capsuleFamily) :
    targetSigned <=
      action.toDirectSummandAction.toCapsuleAction.transformedFamily.normalizedLogVolume :=
  action.transformedContainerEstimate_targetSigned_le_normalizedLogVolume
    estimate

theorem directSummandActionStep_transports_capsule_container_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
        choice₁ choice₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned choice₁.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      choice₂.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1DirectSummandPacketTheorem311Choice.ind2_transports_capsuleContainerBound
    hstep estimate

def directSummandActionStep_transports_packet_compatibility_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
        choice₁ choice₂)
    (compat :
      IUTStage1LocalTensorPacketNormalizedCompatibility
        choice₁.local_tensor_state.packetState) :
    IUTStage1LocalTensorPacketNormalizedCompatibility
      choice₂.local_tensor_state.packetState :=
  IUTStage1DirectSummandPacketTheorem311Choice.ind2_transports_packetNormalizedCompatibility
    hstep compat

open IUTStage1DirectSummandPacketTheorem311Choice in
def directSummandActionStep_transports_classified_packet_compatibility_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
        choice₁ choice₂)
    (classified :
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        choice₁.local_tensor_state.packetState) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
      choice₂.local_tensor_state.packetState :=
  ind2_transports_classifiedPacketNormalizedCompatibility hstep classified

theorem nonarchimedeanIsmStep_transports_capsule_container_example
    {coric : Type u}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.NonarchimedeanIsmInd2Step
        choice₁ choice₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned choice₁.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      choice₂.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsm_transports_capsuleContainerBound
    hstep estimate

theorem archimedeanOrderTwoStep_transports_capsule_container_example
    {coric : Type u}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.ArchimedeanOrderTwoInd2Step
        choice₁ choice₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned choice₁.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      choice₂.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwo_transports_capsuleContainerBound
    hstep estimate

theorem placeAuditedInd2Step_transports_capsule_container_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned
        audited₁.choice.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.ind2_transports_capsuleContainerBound
    hstep estimate

theorem placeAuditedNonarchimedeanStep_transports_capsule_container_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmInd2Step
        audited₁ audited₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned
        audited₁.choice.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.nonarchimedeanIsm_transports_capsuleContainerBound
    hstep estimate

open IUTStage1PlaceAuditedDirectSummandPacketChoice in
theorem placeAuditedArchimedeanStep_transports_capsule_container_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoInd2Step
        audited₁ audited₂)
    {targetSigned : Real}
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        targetSigned
        audited₁.choice.local_tensor_state.packetState.capsuleFamily) :
    targetSigned <=
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  archimedeanOrderTwo_transports_capsuleContainerBound hstep estimate

def labelAveragedProcessionLogVolume_average_example
    {label : Type u} [Fintype label]
    (data : IUTStage1LabelAveragedProcessionLogVolume label) :
    Real :=
  data.averageLogVolume

theorem labelAveragedProcessionLogVolume_average_eq_example
    {label : Type u} [Fintype label]
    (data : IUTStage1LabelAveragedProcessionLogVolume label) :
    data.averageLogVolume =
      (Finset.univ.sum data.normalizedLogVolume) /
        (Fintype.card label : Real) :=
  data.average_eq_formula

theorem labelAveragedProcessionLogVolume_average_eq_of_pointwise_example
    {label : Type u} [Fintype label]
    {data₁ data₂ : IUTStage1LabelAveragedProcessionLogVolume label}
    (hpointwise :
      ∀ j : label,
        data₁.normalizedLogVolume j =
          data₂.normalizedLogVolume j) :
    data₁.averageLogVolume = data₂.averageLogVolume :=
  IUTStage1LabelAveragedProcessionLogVolume.average_eq_of_pointwise
    hpointwise

theorem labelAveragedProcessionLogVolume_const_le_average_example
    {label : Type u} [Fintype label] [Nonempty label]
    (data : IUTStage1LabelAveragedProcessionLogVolume label)
    {c : Real}
    (hpointwise : ∀ j : label, c <= data.normalizedLogVolume j) :
    c <= data.averageLogVolume :=
  IUTStage1LabelAveragedProcessionLogVolume.const_le_average_of_forall_le
    data hpointwise

def flLabelModel_zmod_example
    (l : PrimeGeFive) :
    IUTStage1FLLabelModel (ZMod l.value) :=
  IUTStage1FLLabelModel.zmod l

theorem flLabelModel_card_eq_primeValue_example
    {label : Type u} [Fintype label]
    (model : IUTStage1FLLabelModel label) :
    Fintype.card label = model.prime.value :=
  model.card_eq_primeValue

def flLabelTorsorModel_zmod_example
    (l : PrimeGeFive) :
    IUTStage1FLLabelTorsorModel (ZMod l.value) :=
  IUTStage1FLLabelTorsorModel.zmod l

theorem flLabelTorsorModel_zero_vadd_example
    {label : Type}
    (model : IUTStage1FLLabelTorsorModel label) (j : label) :
    model.torsor.vadd 0 j = j :=
  model.zero_vadd j

theorem flLabelTorsorModel_add_vadd_example
    {label : Type}
    (model : IUTStage1FLLabelTorsorModel label)
    (g h : ZMod model.label_model.prime.value) (j : label) :
    model.torsor.vadd (g + h) j =
      model.torsor.vadd g (model.torsor.vadd h j) :=
  model.add_vadd g h j

theorem flLabelTorsorModel_zmod_translate_example
    (l : PrimeGeFive) (t j : ZMod l.value) :
    (IUTStage1FLLabelTorsorModel.zmod l).torsor.vadd t j =
      zmodLabelTranslate l t j :=
  IUTStage1FLLabelTorsorModel.zmod_vadd_eq_translate l t j

def flZModUnitSignLabelModel_zmod_example
    (l : PrimeGeFive) :
    IUTStage1FLZModUnitSignLabelModel l :=
  IUTStage1FLZModUnitSignLabelModel.zmod l

theorem flZModUnitSignLabelModel_signUnit_example
    {l : PrimeGeFive}
    (model : IUTStage1FLZModUnitSignLabelModel l)
    (x : ZMod l.value) :
    (zmodUnitActionData l).smul model.signUnitCompatibility.signUnit x =
      (zmodSignAction l).neg x :=
  model.signUnit_smul_eq_neg x

theorem flZModUnitSignLabelModel_subgroup_self_or_neg_example
    {l : PrimeGeFive}
    (model : IUTStage1FLZModUnitSignLabelModel l)
    {a : (ZMod l.value)ˣ}
    (ha : a ∈ model.signUnitSubgroup)
    (x : ZMod l.value) :
    (zmodUnitActionData l).smul a x = x ∨
      (zmodUnitActionData l).smul a x = (zmodSignAction l).neg x :=
  model.signUnitSubgroup_smul_eq_self_or_neg' ha x

theorem flZModUnitSignLabelModel_orbit_iff_signOrbit_example
    {l : PrimeGeFive}
    (model : IUTStage1FLZModUnitSignLabelModel l)
    (x generator : ZMod l.value) :
    (∃ a : (ZMod l.value)ˣ,
      a ∈ model.signUnitSubgroup ∧
        (zmodUnitActionData l).smul a generator = x) ↔
      (zmodSignAction l).InSignOrbit x generator :=
  model.signUnitSubgroup_orbit_iff_signOrbit' x generator

def flZModCuspLabelClassModel_zmod_example
    (l : PrimeGeFive) :
    IUTStage1FLZModCuspLabelClassModel l :=
  IUTStage1FLZModCuspLabelClassModel.zmod l

theorem flZModCuspLabelClassModel_local_eq_zmod_example
    {l : PrimeGeFive}
    (model : IUTStage1FLZModCuspLabelClassModel l) :
    model.local_lab_cusp_model = zmodLocalLabCuspModel l :=
  model.localLabCuspModel_eq_zmod

theorem flZModCuspLabelClassModel_canonical_translate_example
    {l : PrimeGeFive}
    (model : IUTStage1FLZModCuspLabelClassModel l) :
    model.local_lab_cusp_model.canonicalNonzeroLabel.1 =
      model.local_lab_cusp_model.additiveTorsor.vadd
        model.local_lab_cusp_model.canonicalCoordinate
        model.local_lab_cusp_model.labelQuotient.zero :=
  model.canonicalLabelTranslate

theorem flZModCuspLabelClassModel_canonical_sign_label_example
    {l : PrimeGeFive}
    (model : IUTStage1FLZModCuspLabelClassModel l) :
    model.local_lab_cusp_model.canonicalSignLabel =
      model.local_lab_cusp_model.signAction.toSignLabelQuotient
        model.local_lab_cusp_model.canonicalNonzeroLabel :=
  model.canonicalSignLabelEq

theorem flZModCuspLabelClassModel_label_class_example
    {l : PrimeGeFive}
    (model : IUTStage1FLZModCuspLabelClassModel l) :
    model.cusp_label_class_data.labelClass =
      model.cusp_label_class_data.model.signAction.toSignLabelQuotient
        model.cusp_label_class_data.model.canonicalNonzeroLabel :=
  model.labelClass_eq_model_quotient

theorem flZModCuspLabelClassModel_zmod_label_class_from_one_example
    {l : PrimeGeFive} :
    (IUTStage1FLZModCuspLabelClassModel.zmod l).cusp_label_class_data.labelClass =
      zmodSignLabelFromCoordinate l (1 : ZMod l.value)
        (zmodOneNonzeroLabel l).2 :=
  IUTStage1FLZModCuspLabelClassModel.zmod_cuspLabelClass_eq_fromCoordinate_one l

theorem zmodCuspLabelLogVolumeCompatibility_nonzero_example
    {l : PrimeGeFive}
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (j : ZMod l.value) (hj : j ≠ 0) :
    compat.normalizedLogVolume j =
      compat.cuspClassLogVolume (zmodSignLabelFromCoordinate l j hj) :=
  compat.nonzero_eq j hj

theorem zmodCuspLabelLogVolumeCompatibility_zero_example
    {l : PrimeGeFive}
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l) :
    compat.normalizedLogVolume 0 = compat.zeroLogVolume :=
  compat.zero_eq_zeroLogVolume

theorem zmodCuspLabelLogVolumeCompatibility_neg_nonzero_example
    {l : PrimeGeFive}
    (compat : IUTStage1ZModCuspLabelLogVolumeCompatibility l)
    (j : ZMod l.value) (hj : j ≠ 0) :
    compat.normalizedLogVolume (-j) =
      compat.cuspClassLogVolume (zmodSignLabelFromCoordinate l j hj) :=
  compat.neg_nonzero_eq j hj

theorem upperSemi_capsuleFamilyLogVolume_total_eq_sum_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1CapsuleFamilyLogVolume kind) :
    data.totalLogVolume = Finset.univ.sum data.capsuleLogVolume :=
  data.total_eq

theorem upperSemi_capsuleFamilyLogVolume_normalized_eq_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1CapsuleFamilyLogVolume kind) :
    data.normalizedLogVolume =
      data.totalLogVolume / (data.capsuleCount : Real) :=
  data.normalized_eq

def upperSemi_capsuleFamily_to_processionNormalized_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1CapsuleFamilyLogVolume kind) :
    IUTStage1ProcessionNormalizedLogVolume kind :=
  data.toProcessionNormalizedLogVolume

theorem upperSemi_capsuleFamily_to_procession_total_eq_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1CapsuleFamilyLogVolume kind) :
    data.toProcessionNormalizedLogVolume.totalLogVolume =
      Finset.univ.sum data.capsuleLogVolume :=
  data.toProcession_total_eq

theorem upperSemi_capsuleLogVolumeObject_eq_example
    {kind : IUTStage1PlaceKind}
    (capsule : IUTStage1CapsuleLogVolumeObject kind) :
    capsule.logVolume = capsule.localObject.finiteLogVolume :=
  capsule.logVolume_eq

theorem upperSemi_typedCapsuleFamily_localObject_eq_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind)
    (i : Fin data.capsuleCount) :
    (data.capsule i).localObject = data.localObject :=
  data.capsuleLocalObject_eq i

theorem upperSemi_typedCapsuleFamily_total_eq_sum_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) :
    data.totalLogVolume =
      Finset.univ.sum fun i => (data.capsule i).logVolume :=
  data.total_eq

theorem upperSemi_typedCapsuleFamily_capsuleCount_pos_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) :
    0 < data.capsuleCount :=
  data.capsuleCount_pos

def upperSemi_typedCapsuleFamily_to_capsuleFamily_example
    {kind : IUTStage1PlaceKind}
    (data : IUTStage1TypedCapsuleFamilyLogVolume kind) :
    IUTStage1CapsuleFamilyLogVolume kind :=
  data.toCapsuleFamilyLogVolume

def upperSemi_capsuleFamilyAction_transformed_example
    {kind : IUTStage1PlaceKind}
    {data : IUTStage1TypedCapsuleFamilyLogVolume kind}
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data) :
    IUTStage1TypedCapsuleFamilyLogVolume kind :=
  action.transformedFamily

theorem upperSemi_capsuleFamilyAction_totalLogVolume_example
    {kind : IUTStage1PlaceKind}
    {data : IUTStage1TypedCapsuleFamilyLogVolume kind}
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data) :
    action.transformedFamily.totalLogVolume = data.totalLogVolume :=
  action.transformedFamily_totalLogVolume

theorem upperSemi_capsuleFamilyAction_total_eq_sum_example
    {kind : IUTStage1PlaceKind}
    {data : IUTStage1TypedCapsuleFamilyLogVolume kind}
    (action : IUTStage1TypedCapsuleFamilyLogVolumeAction data) :
    action.transformedFamily.totalLogVolume =
      Finset.univ.sum fun i =>
        (action.transformedFamily.capsule i).logVolume :=
  action.transformedFamily_total_eq_sum

theorem tensorDirectSummandObject_logVolume_eq_capsule_example
    {kind : IUTStage1PlaceKind}
    (summand : IUTStage1TensorDirectSummandObject kind) :
    summand.capsule.logVolume = summand.localObject.finiteLogVolume :=
  summand.logVolume_eq_capsule

theorem tensorDirectSummandFamily_capsule_eq_example
    {kind : IUTStage1PlaceKind}
    {capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind}
    (family : IUTStage1TensorDirectSummandFamily capsuleFamily)
    (i : Fin capsuleFamily.capsuleCount) :
    (family.summand i).capsule = capsuleFamily.capsule i :=
  family.summandCapsule_eq i

theorem tensorDirectSummandFamily_logVolume_eq_example
    {kind : IUTStage1PlaceKind}
    {capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind}
    (family : IUTStage1TensorDirectSummandFamily capsuleFamily)
    (i : Fin capsuleFamily.capsuleCount) :
    (family.summand i).capsule.logVolume =
      (capsuleFamily.capsule i).logVolume :=
  family.summandCapsuleLogVolume_eq i

def tensorDirectSummandAction_to_capsuleAction_example
    {kind : IUTStage1PlaceKind}
    {capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (action : IUTStage1TensorDirectSummandFamilyAction family) :
    IUTStage1TypedCapsuleFamilyLogVolumeAction capsuleFamily :=
  action.toCapsuleAction

theorem tensorDirectSummandAction_totalLogVolume_example
    {kind : IUTStage1PlaceKind}
    {capsuleFamily : IUTStage1TypedCapsuleFamilyLogVolume kind}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (action : IUTStage1TensorDirectSummandFamilyAction family) :
    action.toCapsuleAction.transformedFamily.totalLogVolume =
      capsuleFamily.totalLogVolume :=
  action.toCapsuleAction_totalLogVolume

def nonarchimedeanIsmAction_to_directSummandAction_example
    {capsuleFamily :
      IUTStage1TypedCapsuleFamilyLogVolume
        IUTStage1PlaceKind.nonarchimedean}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (data : IUTStage1NonarchimedeanIsmDirectSummandAction family) :
    IUTStage1TensorDirectSummandFamilyAction family :=
  data.toDirectSummandAction

theorem nonarchimedeanIsmAction_symmetryKind_example
    {capsuleFamily :
      IUTStage1TypedCapsuleFamilyLogVolume
        IUTStage1PlaceKind.nonarchimedean}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (data : IUTStage1NonarchimedeanIsmDirectSummandAction family) :
    family.symmetryKind =
      IUTStage1TensorSummandSymmetryKind.nonarchimedeanIsm :=
  data.symmetryKind_eq

theorem nonarchimedeanIsmAction_totalLogVolume_example
    {capsuleFamily :
      IUTStage1TypedCapsuleFamilyLogVolume
        IUTStage1PlaceKind.nonarchimedean}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (data : IUTStage1NonarchimedeanIsmDirectSummandAction family) :
    data.toDirectSummandAction.toCapsuleAction.transformedFamily.totalLogVolume =
      capsuleFamily.totalLogVolume :=
  data.capsuleTotalLogVolume_eq

def archimedeanOrderTwoAction_to_directSummandAction_example
    {capsuleFamily :
      IUTStage1TypedCapsuleFamilyLogVolume IUTStage1PlaceKind.archimedean}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (data : IUTStage1ArchimedeanOrderTwoDirectSummandAction family) :
    IUTStage1TensorDirectSummandFamilyAction family :=
  data.toDirectSummandAction

theorem archimedeanOrderTwoAction_symmetryKind_example
    {capsuleFamily :
      IUTStage1TypedCapsuleFamilyLogVolume IUTStage1PlaceKind.archimedean}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (data : IUTStage1ArchimedeanOrderTwoDirectSummandAction family) :
    family.symmetryKind =
      IUTStage1TensorSummandSymmetryKind.archimedeanOrderTwo :=
  data.symmetryKind_eq

theorem archimedeanOrderTwoAction_totalLogVolume_example
    {capsuleFamily :
      IUTStage1TypedCapsuleFamilyLogVolume IUTStage1PlaceKind.archimedean}
    {family : IUTStage1TensorDirectSummandFamily capsuleFamily}
    (data : IUTStage1ArchimedeanOrderTwoDirectSummandAction family) :
    data.toDirectSummandAction.toCapsuleAction.transformedFamily.totalLogVolume =
      capsuleFamily.totalLogVolume :=
  data.capsuleTotalLogVolume_eq

def nonarchimedeanIsmActionEntry_place_example
    (entry : IUTStage1NonarchimedeanIsmActionEntry) :
    IUTStage1PlaceId IUTStage1PlaceKind.nonarchimedean :=
  entry.place

theorem nonarchimedeanIsmActionEntry_totalLogVolume_example
    (entry : IUTStage1NonarchimedeanIsmActionEntry) :
    entry.toDirectSummandAction.toCapsuleAction.transformedFamily.totalLogVolume =
      entry.capsuleFamily.totalLogVolume :=
  entry.capsuleTotalLogVolume_eq

def archimedeanOrderTwoActionEntry_place_example
    (entry : IUTStage1ArchimedeanOrderTwoActionEntry) :
    IUTStage1PlaceId IUTStage1PlaceKind.archimedean :=
  entry.place

theorem archimedeanOrderTwoActionEntry_totalLogVolume_example
    (entry : IUTStage1ArchimedeanOrderTwoActionEntry) :
    entry.toDirectSummandAction.toCapsuleAction.transformedFamily.totalLogVolume =
      entry.capsuleFamily.totalLogVolume :=
  entry.capsuleTotalLogVolume_eq

def ind2PlaceFamily_totalActionCount_example
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    Nat :=
  data.totalActionCount

theorem ind2PlaceFamily_totalActionCount_eq_example
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    data.totalActionCount =
      data.nonarchimedeanActions.length + data.archimedeanActions.length :=
  data.totalActionCount_eq

def ind2PlaceFamily_actionCountForKind_example
    (data : IUTStage1Ind2PlaceFamilyActionData)
    (kind : IUTStage1PlaceKind) :
    Nat :=
  data.actionCountForKind kind

theorem ind2PlaceFamily_nonarchimedean_actionCountForKind_example
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    data.actionCountForKind IUTStage1PlaceKind.nonarchimedean =
      data.nonarchimedeanActions.length :=
  data.actionCountForKind_nonarchimedean

theorem ind2PlaceFamily_archimedean_actionCountForKind_example
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    data.actionCountForKind IUTStage1PlaceKind.archimedean =
      data.archimedeanActions.length :=
  data.actionCountForKind_archimedean

def ind2PlaceFamily_nonarchimedeanPlaces_example
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    List (IUTStage1PlaceId IUTStage1PlaceKind.nonarchimedean) :=
  data.nonarchimedeanPlaces

def ind2PlaceFamily_archimedeanPlaces_example
    (data : IUTStage1Ind2PlaceFamilyActionData) :
    List (IUTStage1PlaceId IUTStage1PlaceKind.archimedean) :=
  data.archimedeanPlaces

def placeFiber_cardinality_example
    {kind : IUTStage1PlaceKind}
    (fiber : IUTStage1PlaceFiber kind) :
    Nat :=
  fiber.cardinality

theorem placeFiber_cardinality_eq_length_example
    {kind : IUTStage1PlaceKind}
    (fiber : IUTStage1PlaceFiber kind) :
    fiber.cardinality = fiber.places.length :=
  fiber.cardinality_eq_length

theorem nonarchimedeanPlaceFiberAudit_count_example
    {data : IUTStage1Ind2PlaceFamilyActionData}
    (audit : IUTStage1NonarchimedeanInd2PlaceFiberAudit data) :
    data.nonarchimedeanCount = audit.fiber.cardinality :=
  audit.actionCount_eq_fiberCardinality

theorem archimedeanPlaceFiberAudit_count_example
    {data : IUTStage1Ind2PlaceFamilyActionData}
    (audit : IUTStage1ArchimedeanInd2PlaceFiberAudit data) :
    data.archimedeanCount = audit.fiber.cardinality :=
  audit.actionCount_eq_fiberCardinality

def localTensorPacket_to_localTensorState_example
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    IUTStage1LocalTensorState :=
  state.toLocalTensorState

theorem localTensorPacket_directSummandCount_eq_capsuleCount_example
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    state.tensorState.directSummandCount =
      state.capsuleFamily.capsuleCount :=
  state.directSummandCount_eq_capsuleCount

theorem localTensorPacket_directSummandCount_pos_example
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    0 < state.tensorState.directSummandCount :=
  state.directSummandCount_pos

theorem localTensorPacket_localObject_eq_example
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    state.capsuleFamily.localObject = state.localObject :=
  state.capsuleFamilyLocalObject_eq

theorem localTensorPacket_totalLogVolume_eq_sum_example
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorPacketLogVolumeState kind) :
    state.capsuleFamily.totalLogVolume =
      Finset.univ.sum fun i => (state.capsuleFamily.capsule i).logVolume :=
  state.capsule_totalLogVolume_eq_sum

def localTensorDirectSummandPacket_to_packetState_example
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorDirectSummandPacketState kind) :
    IUTStage1LocalTensorPacketLogVolumeState kind :=
  state.toLocalTensorPacketLogVolumeState

theorem localTensorDirectSummandPacket_directSummandCount_eq_example
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorDirectSummandPacketState kind) :
    state.packetState.tensorState.directSummandCount =
      state.packetState.capsuleFamily.capsuleCount :=
  state.directSummandCount_eq_capsuleCount

theorem localTensorDirectSummandPacket_logVolume_eq_example
    {kind : IUTStage1PlaceKind}
    (state : IUTStage1LocalTensorDirectSummandPacketState kind)
    (i : Fin state.packetState.capsuleFamily.capsuleCount) :
    (state.summandFamily.summand i).capsule.logVolume =
      (state.packetState.capsuleFamily.capsule i).logVolume :=
  state.summandCapsuleLogVolume_eq i

def tensorPacketTheorem311_forgetPacket_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (choice : IUTStage1TensorPacketTheorem311Choice coric kind) :
    IUTStage1StructuredTheorem311Choice coric :=
  choice.forgetPacket

theorem tensorPacketTheorem311_directSummandCount_eq_capsuleCount_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (choice : IUTStage1TensorPacketTheorem311Choice coric kind) :
    choice.local_tensor_state.tensorState.directSummandCount =
      choice.local_tensor_state.capsuleFamily.capsuleCount :=
  choice.localTensor_directSummandCount_eq_capsuleCount

theorem tensorPacketTheorem311_ind2_preserves_directSummandCount_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketSymmetryStep
        choice₁ choice₂) :
    choice₁.local_tensor_state.tensorState.directSummandCount =
      choice₂.local_tensor_state.tensorState.directSummandCount :=
  IUTStage1TensorPacketTheorem311Choice.ind2_preserves_directSummandCount
    hstep

theorem tensorPacketTheorem311_ind2_preserves_totalLogVolume_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketSymmetryStep
        choice₁ choice₂) :
    choice₁.local_tensor_state.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.capsuleFamily.totalLogVolume :=
  IUTStage1TensorPacketTheorem311Choice.ind2_preserves_capsuleTotalLogVolume
    hstep

def tensorPacketTheorem311_ind2_to_structured_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketSymmetryStep
        choice₁ choice₂) :
    IUTStage1StructuredTheorem311Choice.LocalTensorSymmetryStep
      choice₁.forgetPacket choice₂.forgetPacket :=
  IUTStage1TensorPacketTheorem311Choice.toStructuredLocalTensorSymmetryStep
    hstep

theorem tensorPacketTheorem311_actionStep_preserves_totalLogVolume_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketActionStep
        choice₁ choice₂) :
    choice₁.local_tensor_state.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.capsuleFamily.totalLogVolume :=
  IUTStage1TensorPacketTheorem311Choice.actionStep_preserves_capsuleTotalLogVolume
    hstep

def tensorPacketTheorem311_actionStep_to_packetStep_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketActionStep
        choice₁ choice₂) :
    IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketSymmetryStep
      choice₁ choice₂ :=
  IUTStage1TensorPacketTheorem311Choice.actionStep_toPacketSymmetryStep
    hstep

theorem tensorPacketTheorem311_actionStep_preserves_directSummandCount_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ : IUTStage1TensorPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketActionStep
        choice₁ choice₂) :
    choice₁.local_tensor_state.tensorState.directSummandCount =
      choice₂.local_tensor_state.tensorState.directSummandCount :=
  IUTStage1TensorPacketTheorem311Choice.actionStep_preserves_directSummandCount
    hstep

def directSummandPacketTheorem311_forgetDirectSummands_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (choice : IUTStage1DirectSummandPacketTheorem311Choice coric kind) :
    IUTStage1TensorPacketTheorem311Choice coric kind :=
  choice.forgetDirectSummands

theorem directSummandPacketTheorem311_logVolume_eq_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (choice : IUTStage1DirectSummandPacketTheorem311Choice coric kind)
    (i : Fin choice.local_tensor_state.packetState.capsuleFamily.capsuleCount) :
    (choice.local_tensor_state.summandFamily.summand i).capsule.logVolume =
      (choice.local_tensor_state.packetState.capsuleFamily.capsule i).logVolume :=
  choice.localTensor_summandCapsuleLogVolume_eq i

def directSummandPacketTheorem311_ind2_to_packetAction_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
        choice₁ choice₂) :
    IUTStage1TensorPacketTheorem311Choice.LocalTensorPacketActionStep
      choice₁.forgetDirectSummands choice₂.forgetDirectSummands :=
  IUTStage1DirectSummandPacketTheorem311Choice.toTensorPacketActionStep
    hstep

theorem directSummandPacketTheorem311_ind2_preserves_directSummandCount_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
        choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.tensorState.directSummandCount =
      choice₂.local_tensor_state.packetState.tensorState.directSummandCount :=
  IUTStage1DirectSummandPacketTheorem311Choice.ind2_preserves_directSummandCount
    hstep

theorem directSummandPacketTheorem311_ind2_preserves_totalLogVolume_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
        choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1DirectSummandPacketTheorem311Choice.ind2_preserves_capsuleTotalLogVolume
    hstep

def nonarchimedeanIsmInd2_to_directSummandActionStep_example
    {coric : Type u}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.NonarchimedeanIsmInd2Step
        choice₁ choice₂) :
    IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
      choice₁ choice₂ :=
  IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsm_toDirectSummandActionStep
    hstep

theorem nonarchimedeanIsmInd2_preserves_totalLogVolume_example
    {coric : Type u}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.NonarchimedeanIsmInd2Step
        choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsm_preserves_capsuleTotalLogVolume
    hstep

def archimedeanOrderTwoInd2_to_directSummandActionStep_example
    {coric : Type u}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.ArchimedeanOrderTwoInd2Step
        choice₁ choice₂) :
    IUTStage1DirectSummandPacketTheorem311Choice.LocalTensorDirectSummandActionStep
      choice₁ choice₂ :=
  IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwo_toDirectSummandActionStep
    hstep

theorem archimedeanOrderTwoInd2_preserves_totalLogVolume_example
    {coric : Type u}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1DirectSummandPacketTheorem311Choice.ArchimedeanOrderTwoInd2Step
        choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwo_preserves_capsuleTotalLogVolume
    hstep

theorem nonarchimedeanIsm_generated_preserves_coric_example
    {coric : Type u}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsmIndeterminacySourceData
          (coric := coric)).generators
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric :=
  IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsm_generated_preserves_coric
    hrel

theorem nonarchimedeanIsm_generated_preserves_totalLogVolume_example
    {coric : Type u}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.nonarchimedeanIsmIndeterminacySourceData
          (coric := coric)).generators
        choice₁ choice₂) :
      choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  nonarchimedeanIsm_generated_preserves_capsuleTotalLogVolume hrel

theorem archimedeanOrderTwo_generated_preserves_coric_example
    {coric : Type u}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwoIndeterminacySourceData
          (coric := coric)).generators
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric :=
  IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwo_generated_preserves_coric
    hrel

theorem archimedeanOrderTwo_generated_preserves_totalLogVolume_example
    {coric : Type u}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.archimedeanOrderTwoIndeterminacySourceData
          (coric := coric)).generators
        choice₁ choice₂) :
      choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  archimedeanOrderTwo_generated_preserves_capsuleTotalLogVolume hrel

theorem directSummandPacketTheorem311_generated_preserves_coric_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.indeterminacySourceData
          (coric := coric) (kind := kind)).generators
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric :=
  IUTStage1DirectSummandPacketTheorem311Choice.generated_preserves_coric
    hrel

theorem directSummandPacketTheorem311_generated_preserves_column_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.indeterminacySourceData
          (coric := coric) (kind := kind)).generators
        choice₁ choice₂) :
    choice₁.column = choice₂.column :=
  IUTStage1DirectSummandPacketTheorem311Choice.generated_preserves_column
    hrel

theorem directSummandPacketTheorem311_generated_preserves_totalLogVolume_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.indeterminacySourceData
          (coric := coric) (kind := kind)).generators
        choice₁ choice₂) :
    choice₁.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      choice₂.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1DirectSummandPacketTheorem311Choice.generated_preserves_capsuleTotalLogVolume
    hrel

theorem directSummandPacketTheorem311_image_invariant_of_coric_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (images :
      RegionFamily target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          images.region choice₁ = images.region choice₂)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1DirectSummandPacketTheorem311Choice.indeterminacySourceData
          (coric := coric) (kind := kind)).generators
        choice₁ choice₂) :
    images.region choice₁ = images.region choice₂ :=
  IUTStage1DirectSummandPacketTheorem311Choice.image_invariant_of_coric
    images hcoric hrel

def directSummandPacketMultiradialImages_of_coric_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (images :
      RegionFamily target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          images.region choice₁ = images.region choice₂) :
    IUTStage1DirectSummandPacketMultiradialImages
      (target := target) coric kind :=
  IUTStage1DirectSummandPacketMultiradialImages.ofCoricInvariant
    images hcoric

theorem directSummandPacketMultiradialImages_region_eq_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (data :
      IUTStage1DirectSummandPacketMultiradialImages
        (target := target) coric kind)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel : data.quotient.relation choice₁ choice₂) :
    data.possibleImages.region choice₁ = data.possibleImages.region choice₂ :=
  data.region_eq_of_related hrel

theorem directSummandPacketMultiradialImages_profile_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (data :
      IUTStage1DirectSummandPacketMultiradialImages
        (target := target) coric kind) :
    data.quotient.profile = theorem311IndeterminacyProfile :=
  data.quotient_profile

def refinedDirectSummandPacketMultiradialThetaImages_of_package_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            choice₂) :
    IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package :=
  IUTStage1RefinedDirectSummandPacketMultiradialThetaImages.ofPackageWithCoricInvariant
    package hcoric

theorem refinedDirectSummandPacketMultiradialThetaImages_region_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (data :
      IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel : data.refinedImages.quotient.relation choice₁ choice₂) :
    data.possibleImages.images.region choice₁ =
      data.possibleImages.images.region choice₂ :=
  data.region_eq_of_related hrel

theorem refinedDirectSummandPacketMultiradialThetaImages_union_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (data :
      IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package) :
    data.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  data.union_eq_targetUnion

def placeAuditedDirectSummandPacketChoice_forget_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    IUTStage1DirectSummandPacketTheorem311Choice coric kind :=
  audited.toDirectSummandPacketTheorem311Choice

theorem placeAuditedDirectSummandPacketChoice_logVolumeCompatible_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    audited.choice.upper_semi_state.logVolumeCompatible :=
  audited.upperSemi_logVolumeCompatible

theorem placeAuditedDirectSummandPacketChoice_upperBound_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    audited.choice.upper_semi_state.logVolumeCompatibility.sourceLogVolume <=
      audited.choice.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  audited.upperSemi_logVolumeUpperBound

theorem placeAuditedDirectSummandPacketChoice_nonarchPlaces_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    audited.placeFamilyCompatibility.ind2Actions.nonarchimedeanPlaces =
      audited.choice.upper_semi_state.nonarchimedeanInclusions.map fun entry =>
        entry.place :=
  audited.nonarchimedeanPlaces_eq

theorem placeAuditedDirectSummandPacketChoice_archPlaces_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    (audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    audited.placeFamilyCompatibility.ind2Actions.archimedeanPlaces =
      audited.choice.upper_semi_state.archimedeanSurjections.map fun entry =>
        entry.place :=
  audited.archimedeanPlaces_eq

theorem placeAuditedDirectSummandPacketChoice_ind1_preserves_audit_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.ind1_preserves_placeFamilyCompatibility
    hstep

theorem placeAuditedDirectSummandPacketChoice_ind2_preserves_audit_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.ind2_preserves_placeFamilyCompatibility
    hstep

theorem placeAuditedDirectSummandPacketChoice_ind3_preserves_audit_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.UpperSemiCompatibilityStep
        audited₁ audited₂) :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.ind3_preserves_placeFamilyCompatibility
    hstep

theorem placeAuditedDirectSummandPacketChoice_ind2_preserves_totalLogVolume_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.ind2_preserves_capsuleTotalLogVolume
    hstep

theorem placeAuditedDirectSummandPacketChoice_ind1_preserves_normalizedLogVolume_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.ind1_preserves_capsuleNormalizedLogVolume
    hstep

theorem placeAuditedDirectSummandPacketChoice_ind2_preserves_normalizedLogVolume_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.ind2_preserves_capsuleNormalizedLogVolume
    hstep

def placeAuditedDirectSummandPacketChoice_ind2_transports_packet_compatibility_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂)
    (compat :
      IUTStage1LocalTensorPacketNormalizedCompatibility
        audited₁.choice.local_tensor_state.packetState) :
    IUTStage1LocalTensorPacketNormalizedCompatibility
      audited₂.choice.local_tensor_state.packetState :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.ind2_transports_packetNormalizedCompatibility
    hstep compat

open IUTStage1PlaceAuditedDirectSummandPacketChoice in
def placeAuditedDirectSummandPacketChoice_ind2_transports_classified_packet_compatibility_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂)
    (classified :
      IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
        audited₁.choice.local_tensor_state.packetState) :
    IUTStage1ClassifiedLocalTensorPacketNormalizedCompatibility
      audited₂.choice.local_tensor_state.packetState :=
  ind2_transports_classifiedPacketNormalizedCompatibility hstep classified

theorem directSummandPlaceCountAudit_capsuleCount_eq_actionCount_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (audit :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.DirectSummandPlaceCountAudit
        audited) :
    audited.choice.local_tensor_state.packetState.capsuleFamily.capsuleCount =
      audited.placeFamilyCompatibility.ind2Actions.actionCountForKind kind :=
  audit.capsuleCount_eq_actionCount

theorem directSummandPlaceCountAudit_nonarchimedean_count_example
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (audit :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.DirectSummandPlaceCountAudit
        audited) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      audited.placeFamilyCompatibility.ind2Actions.nonarchimedeanActions.length :=
  audit.nonarchimedean_directSummandCount_eq

theorem directSummandPlaceCountAudit_archimedean_count_example
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (audit :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.DirectSummandPlaceCountAudit
        audited) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      audited.placeFamilyCompatibility.ind2Actions.archimedeanActions.length :=
  audit.archimedean_directSummandCount_eq

theorem directSummandPlaceCountAudit_nonarchimedean_fiber_count_example
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (countAudit :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.DirectSummandPlaceCountAudit
        audited)
    (fiberAudit :
      IUTStage1NonarchimedeanInd2PlaceFiberAudit
        audited.placeFamilyCompatibility.ind2Actions) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      fiberAudit.fiber.cardinality :=
  countAudit.nonarchimedean_directSummandCount_eq_fiberCardinality
    fiberAudit

theorem directSummandPlaceCountAudit_archimedean_fiber_count_example
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (countAudit :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.DirectSummandPlaceCountAudit
        audited)
    (fiberAudit :
      IUTStage1ArchimedeanInd2PlaceFiberAudit
        audited.placeFamilyCompatibility.ind2Actions) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      fiberAudit.fiber.cardinality :=
  countAudit.archimedean_directSummandCount_eq_fiberCardinality
    fiberAudit

theorem nonarchimedeanInd2FiberPackage_directSummandCount_example
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (package :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanInd2FiberPackage
        audited) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      package.fiberAudit.fiber.cardinality :=
  package.directSummandCount_eq_fiberCardinality

theorem nonarchimedeanInd2FiberPackage_capsuleCount_example
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (package :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanInd2FiberPackage
        audited) :
    audited.choice.local_tensor_state.packetState.capsuleFamily.capsuleCount =
      package.fiberAudit.fiber.cardinality :=
  package.capsuleCount_eq_fiberCardinality

theorem archimedeanInd2FiberPackage_directSummandCount_example
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (package :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanInd2FiberPackage
        audited) :
    audited.choice.local_tensor_state.packetState.tensorState.directSummandCount =
      package.fiberAudit.fiber.cardinality :=
  package.directSummandCount_eq_fiberCardinality

theorem archimedeanInd2FiberPackage_capsuleCount_example
    {coric : Type u}
    {audited :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (package :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanInd2FiberPackage
        audited) :
    audited.choice.local_tensor_state.packetState.capsuleFamily.capsuleCount =
      package.fiberAudit.fiber.cardinality :=
  package.capsuleCount_eq_fiberCardinality

def placeAuditedNonarchimedeanIsm_to_ind2_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmInd2Step
        audited₁ audited₂) :
    IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
      audited₁ audited₂ :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.nonarchimedeanIsm_toDirectSummandActionStep
    hstep

def placeAuditedArchimedeanOrderTwo_to_ind2_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoInd2Step
        audited₁ audited₂) :
    IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
      audited₁ audited₂ :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.archimedeanOrderTwo_toDirectSummandActionStep
    hstep

theorem placeAuditedNonarchimedeanIsm_preserves_totalLogVolume_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmInd2Step
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.nonarchimedeanIsm_preserves_capsuleTotalLogVolume
    hstep

def placeAuditedNonarchimedeanEntry_to_ism_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmInd2Step
      audited₁ audited₂ :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.nonarchimedeanEntry_toNonarchimedeanIsmStep
    hstep

theorem placeAuditedNonarchimedeanEntry_place_mem_upperSemi_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    hstep.action_entry.place ∈
      audited₁.choice.upper_semi_state.nonarchimedeanInclusions.map
        fun entry => entry.place :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.nonarchimedeanEntry_place_mem_upperSemi
    hstep

theorem placeAuditedNonarchimedeanEntry_place_mem_fiber_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂)
    (fiberAudit :
      IUTStage1NonarchimedeanInd2PlaceFiberAudit
        audited₁.placeFamilyCompatibility.ind2Actions) :
    hstep.action_entry.place ∈ fiberAudit.fiber.places :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.nonarchimedeanEntry_place_mem_fiber
    hstep fiberAudit

theorem nonarchimedeanInd2FiberPackage_entry_place_mem_fiber_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (package :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    hstep.action_entry.place ∈ package.fiberAudit.fiber.places :=
  package.entry_place_mem_fiber hstep

theorem placeAuditedNonarchimedeanEntry_preserves_totalLogVolume_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.nonarchimedeanEntry_preserves_capsuleTotalLogVolume
    hstep

theorem placeAuditedArchimedeanOrderTwo_preserves_totalLogVolume_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoInd2Step
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.archimedeanOrderTwo_preserves_capsuleTotalLogVolume
    hstep

def placeAuditedArchimedeanEntry_to_orderTwo_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoInd2Step
      audited₁ audited₂ :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.archimedeanEntry_toArchimedeanOrderTwoStep
    hstep

theorem placeAuditedArchimedeanEntry_place_mem_upperSemi_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    hstep.action_entry.place ∈
      audited₁.choice.upper_semi_state.archimedeanSurjections.map
        fun entry => entry.place :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.archimedeanEntry_place_mem_upperSemi
    hstep

theorem placeAuditedArchimedeanEntry_place_mem_fiber_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂)
    (fiberAudit :
      IUTStage1ArchimedeanInd2PlaceFiberAudit
        audited₁.placeFamilyCompatibility.ind2Actions) :
    hstep.action_entry.place ∈ fiberAudit.fiber.places :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.archimedeanEntry_place_mem_fiber
    hstep fiberAudit

theorem archimedeanInd2FiberPackage_entry_place_mem_fiber_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (package :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    hstep.action_entry.place ∈ package.fiberAudit.fiber.places :=
  package.entry_place_mem_fiber hstep

theorem placeAuditedArchimedeanEntry_preserves_totalLogVolume_example
    {coric : Type u}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.totalLogVolume :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.archimedeanEntry_preserves_capsuleTotalLogVolume
    hstep

theorem placeAuditedDirectSummandPacketChoice_generated_preserves_audit_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1PlaceAuditedDirectSummandPacketChoice.indeterminacySourceData
          (coric := coric) (kind := kind)).generators
        audited₁ audited₂) :
    audited₁.placeFamilyCompatibility =
      audited₂.placeFamilyCompatibility :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.generated_preserves_placeFamilyCompatibility
    hrel

theorem placeAuditedDirectSummandPacketChoice_generated_preserves_coric_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1PlaceAuditedDirectSummandPacketChoice.indeterminacySourceData
          (coric := coric) (kind := kind)).generators
        audited₁ audited₂) :
    audited₁.choice.coric = audited₂.choice.coric :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.generated_preserves_coric
    hrel

theorem placeAuditedDirectSummandPacketChoice_generated_logVolumeCompatible_example
    {coric : Type u} {kind : IUTStage1PlaceKind}
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1PlaceAuditedDirectSummandPacketChoice.indeterminacySourceData
          (coric := coric) (kind := kind)).generators
        audited₁ audited₂) :
    audited₂.choice.upper_semi_state.logVolumeCompatible :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.generated_preserves_upperSemiLogVolumeCompatible
    hrel

theorem placeAuditedDirectSummandPacketChoice_image_invariant_of_coric_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (images :
      RegionFamily target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          images.region audited₁ = images.region audited₂)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1PlaceAuditedDirectSummandPacketChoice.indeterminacySourceData
          (coric := coric) (kind := kind)).generators
        audited₁ audited₂) :
    images.region audited₁ = images.region audited₂ :=
  IUTStage1PlaceAuditedDirectSummandPacketChoice.image_invariant_of_coric
    images hcoric hrel

def placeAuditedMultiradialImages_of_coric_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (images :
      RegionFamily target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          images.region audited₁ = images.region audited₂) :
    IUTStage1PlaceAuditedMultiradialImages
      (target := target) coric kind :=
  IUTStage1PlaceAuditedMultiradialImages.ofCoricInvariant
    images hcoric

theorem placeAuditedMultiradialImages_region_eq_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric kind)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel : data.quotient.relation audited₁ audited₂) :
    data.possibleImages.region audited₁ =
      data.possibleImages.region audited₂ :=
  data.region_eq_of_related hrel

theorem placeAuditedMultiradialImages_ind1_region_eq_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric kind)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ =
      data.possibleImages.region audited₂ :=
  data.region_eq_of_ind1_step hstep

theorem placeAuditedMultiradialImages_ind2_region_eq_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric kind)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ =
      data.possibleImages.region audited₂ :=
  data.region_eq_of_ind2_step hstep

theorem placeAuditedMultiradialImages_nonarchimedeanIsm_region_eq_example
    {target : Copy} {coric : Type u}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.nonarchimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmInd2Step
        audited₁ audited₂) :
    data.possibleImages.region audited₁ =
      data.possibleImages.region audited₂ :=
  data.region_eq_of_nonarchimedeanIsm_step hstep

theorem placeAuditedMultiradialImages_nonarchimedeanEntry_region_eq_example
    {target : Copy} {coric : Type u}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.nonarchimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ =
      data.possibleImages.region audited₂ :=
  data.region_eq_of_nonarchimedeanEntry_step hstep

theorem placeAuditedMultiradialImages_nonarchimedeanEntry_region_fiber_example
    {target : Copy} {coric : Type u}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.nonarchimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  data.region_eq_and_fiber_mem_of_nonarchimedeanEntry_step
    fiberPackage hstep

theorem placeAuditedMultiradialImages_archimedeanOrderTwo_region_eq_example
    {target : Copy} {coric : Type u}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.archimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoInd2Step
        audited₁ audited₂) :
    data.possibleImages.region audited₁ =
      data.possibleImages.region audited₂ :=
  data.region_eq_of_archimedeanOrderTwo_step hstep

theorem placeAuditedMultiradialImages_archimedeanEntry_region_eq_example
    {target : Copy} {coric : Type u}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.archimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ =
      data.possibleImages.region audited₂ :=
  data.region_eq_of_archimedeanEntry_step hstep

theorem placeAuditedMultiradialImages_archimedeanEntry_region_fiber_example
    {target : Copy} {coric : Type u}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric IUTStage1PlaceKind.archimedean)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ = data.possibleImages.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  data.region_eq_and_fiber_mem_of_archimedeanEntry_step
    fiberPackage hstep

theorem placeAuditedMultiradialImages_ind3_region_eq_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric kind)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.UpperSemiCompatibilityStep
        audited₁ audited₂) :
    data.possibleImages.region audited₁ =
      data.possibleImages.region audited₂ :=
  data.region_eq_of_ind3_step hstep

theorem placeAuditedMultiradialImages_profile_example
    {target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (data :
      IUTStage1PlaceAuditedMultiradialImages
        (target := target) coric kind) :
    data.quotient.profile = theorem311IndeterminacyProfile :=
  data.quotient_profile

def placeAuditedMultiradialThetaImages_of_package_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind))
    (hcoric :
      ∀ audited₁ audited₂,
        audited₁.choice.coric = audited₂.choice.coric ->
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            audited₁ =
          (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
            audited₂) :
    IUTStage1PlaceAuditedMultiradialThetaImages package :=
  IUTStage1PlaceAuditedMultiradialThetaImages.ofPackageWithCoricInvariant
    package hcoric

theorem placeAuditedMultiradialThetaImages_region_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel : data.auditedImages.quotient.relation audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ :=
  data.region_eq_of_related hrel

theorem placeAuditedMultiradialThetaImages_ind2_region_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ :=
  data.region_eq_of_ind2_step hstep

theorem placeAuditedMultiradialThetaImages_nonarchimedeanIsm_region_eq_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmInd2Step
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ :=
  data.region_eq_of_nonarchimedeanIsm_step hstep

theorem placeAuditedMultiradialThetaImages_nonarchimedeanEntry_region_eq_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ :=
  data.region_eq_of_nonarchimedeanEntry_step hstep

theorem placeAuditedMultiradialThetaImages_nonarchimedeanEntry_region_fiber_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
        data.possibleImages.images.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  data.region_eq_and_fiber_mem_of_nonarchimedeanEntry_step
    fiberPackage hstep

theorem placeAuditedMultiradialThetaImages_archimedeanOrderTwo_region_eq_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.archimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoInd2Step
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ :=
  data.region_eq_of_archimedeanOrderTwo_step hstep

theorem placeAuditedMultiradialThetaImages_archimedeanEntry_region_eq_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.archimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
      data.possibleImages.images.region audited₂ :=
  data.region_eq_of_archimedeanEntry_step hstep

theorem placeAuditedMultiradialThetaImages_archimedeanEntry_region_fiber_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.archimedean)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    data.possibleImages.images.region audited₁ =
        data.possibleImages.images.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  data.region_eq_and_fiber_mem_of_archimedeanEntry_step
    fiberPackage hstep

theorem placeAuditedMultiradialThetaImages_union_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    (data : IUTStage1PlaceAuditedMultiradialThetaImages package) :
    data.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  data.union_eq_targetUnion

def refinedThetaImagesDependOnlyOnCoric_to_multiradial_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (dependence : IUTStage1RefinedThetaImagesDependOnlyOnCoric package) :
    IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package :=
  dependence.toRefinedMultiradialThetaImages

theorem refinedThetaImagesDependOnlyOnCoric_profile_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (dependence : IUTStage1RefinedThetaImagesDependOnlyOnCoric package) :
    dependence.toRefinedMultiradialThetaImages.refinedImages.quotient.profile =
      theorem311IndeterminacyProfile :=
  dependence.quotientProfile

theorem refinedThetaImagesDependOnlyOnCoric_union_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (dependence : IUTStage1RefinedThetaImagesDependOnlyOnCoric package) :
    dependence.toRefinedMultiradialThetaImages.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  dependence.union_eq_targetUnion

def theorem311RefinedMultiradialSubclaim_to_dependence_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (subclaim :
      IUTStage1Theorem311RefinedMultiradialSubclaim package) :
    IUTStage1RefinedThetaImagesDependOnlyOnCoric package :=
  subclaim.toRefinedThetaImagesDependOnlyOnCoric

def theorem311RefinedMultiradialSubclaim_to_multiradial_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (subclaim :
      IUTStage1Theorem311RefinedMultiradialSubclaim package) :
    IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package :=
  subclaim.toRefinedMultiradialThetaImages

theorem theorem311RefinedMultiradialSubclaim_profile_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (subclaim :
      IUTStage1Theorem311RefinedMultiradialSubclaim package) :
    subclaim.toRefinedMultiradialThetaImages.refinedImages.quotient.profile =
      theorem311IndeterminacyProfile :=
  subclaim.quotientProfile

def refinedThetaImageGeneratorInvariance_to_multiradial_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (invariance : IUTStage1RefinedThetaImageGeneratorInvariance package) :
    IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package :=
  invariance.toRefinedMultiradialThetaImages

theorem refinedThetaImageGeneratorInvariance_region_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (invariance : IUTStage1RefinedThetaImageGeneratorInvariance package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice coric kind}
    (hrel :
      invariance.toRefinedMultiradialThetaImages.refinedImages.quotient.relation
        choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  invariance.imageInvariant hrel

theorem refinedThetaImageGeneratorInvariance_profile_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (invariance : IUTStage1RefinedThetaImageGeneratorInvariance package) :
    invariance.toRefinedMultiradialThetaImages.refinedImages.quotient.profile =
      theorem311IndeterminacyProfile :=
  invariance.quotientProfile

def theorem311RefinedGeneratorInvarianceSubclaim_to_invariance_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (subclaim :
      IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim package) :
    IUTStage1RefinedThetaImageGeneratorInvariance package :=
  subclaim.toRefinedThetaImageGeneratorInvariance

def theorem311RefinedGeneratorInvarianceSubclaim_to_multiradial_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (subclaim :
      IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim package) :
    IUTStage1RefinedDirectSummandPacketMultiradialThetaImages package :=
  subclaim.toRefinedMultiradialThetaImages

theorem theorem311RefinedGeneratorInvarianceSubclaim_union_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice coric kind)}
    (subclaim :
      IUTStage1Theorem311RefinedGeneratorInvarianceSubclaim package) :
    subclaim.toRefinedMultiradialThetaImages.possibleImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  subclaim.union_eq_targetUnion

theorem nonarchimedeanIsmThetaImageGeneratorInvariance_region_eq_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.nonarchimedean)}
    (invariance :
      IUTStage1NonarchimedeanIsmThetaImageGeneratorInvariance package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (nonarchimedeanIsmIndeterminacySourceData
          (coric := coric)).generators choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  invariance.generatedImageInvariant hrel

theorem archimedeanOrderTwoThetaImageGeneratorInvariance_region_eq_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.archimedean)}
    (invariance :
      IUTStage1ArchimedeanOrderTwoThetaImageGeneratorInvariance package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (archimedeanOrderTwoIndeterminacySourceData
          (coric := coric)).generators choice₁ choice₂) :
    (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₁ =
      (IUTStage1ThetaPilotPossibleImages.ofPackage package).images.region
        choice₂ :=
  invariance.generatedImageInvariant hrel

def nonarchimedeanIsmMultiradialThetaImages_of_invariance_example
    {source target : Copy} {coric : Type u}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.nonarchimedean))
    (invariance :
      IUTStage1NonarchimedeanIsmThetaImageGeneratorInvariance package) :
    IUTStage1NonarchimedeanIsmMultiradialThetaImages package :=
  IUTStage1NonarchimedeanIsmMultiradialThetaImages.ofGeneratorInvariance
    package invariance

theorem nonarchimedeanIsmMultiradialThetaImages_region_eq_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.nonarchimedean)}
    (data : IUTStage1NonarchimedeanIsmMultiradialThetaImages package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.nonarchimedean}
    (hrel : data.quotient.relation choice₁ choice₂) :
    data.possibleImages.images.region choice₁ =
      data.possibleImages.images.region choice₂ :=
  data.region_eq_of_related hrel

theorem nonarchimedeanIsmMultiradialThetaImages_profile_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.nonarchimedean)}
    (data : IUTStage1NonarchimedeanIsmMultiradialThetaImages package) :
    data.quotient.profile = theorem311IndeterminacyProfile :=
  data.quotient_profile

def archimedeanOrderTwoMultiradialThetaImages_of_invariance_example
    {source target : Copy} {coric : Type u}
    (package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.archimedean))
    (invariance :
      IUTStage1ArchimedeanOrderTwoThetaImageGeneratorInvariance package) :
    IUTStage1ArchimedeanOrderTwoMultiradialThetaImages package :=
  IUTStage1ArchimedeanOrderTwoMultiradialThetaImages.ofGeneratorInvariance
    package invariance

theorem archimedeanOrderTwoMultiradialThetaImages_region_eq_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.archimedean)}
    (data : IUTStage1ArchimedeanOrderTwoMultiradialThetaImages package)
    {choice₁ choice₂ :
      IUTStage1DirectSummandPacketTheorem311Choice
        coric IUTStage1PlaceKind.archimedean}
    (hrel : data.quotient.relation choice₁ choice₂) :
    data.possibleImages.images.region choice₁ =
      data.possibleImages.images.region choice₂ :=
  data.region_eq_of_related hrel

theorem archimedeanOrderTwoMultiradialThetaImages_profile_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1DirectSummandPacketTheorem311Choice
          coric IUTStage1PlaceKind.archimedean)}
    (data : IUTStage1ArchimedeanOrderTwoMultiradialThetaImages package) :
    data.quotient.profile = theorem311IndeterminacyProfile :=
  data.quotient_profile

theorem upperSemi_logVolumeCompatibility_upperBound_example
    (data : IUTStage1LogVolumeCompatibilityData) :
    data.sourceLogVolume <= data.targetLogVolume :=
  data.upperBound

theorem ind2UpperSemiPlaceFamily_nonarchimedeanPlaces_example
    (data : IUTStage1Ind2UpperSemiPlaceFamilyCompatibility) :
    data.ind2Actions.nonarchimedeanPlaces =
      data.upperSemiState.nonarchimedeanInclusions.map fun entry =>
        entry.place :=
  data.nonarchimedeanPlaces_eq

theorem ind2UpperSemiPlaceFamily_archimedeanPlaces_example
    (data : IUTStage1Ind2UpperSemiPlaceFamilyCompatibility) :
    data.ind2Actions.archimedeanPlaces =
      data.upperSemiState.archimedeanSurjections.map fun entry =>
        entry.place :=
  data.archimedeanPlaces_eq

theorem ind2UpperSemiPlaceFamily_logVolumeCompatible_example
    (data : IUTStage1Ind2UpperSemiPlaceFamilyCompatibility) :
    data.upperSemiState.logVolumeCompatible :=
  data.logVolumeCompatible

theorem ind2UpperSemiPlaceFamily_logVolumeUpperBound_example
    (data : IUTStage1Ind2UpperSemiPlaceFamilyCompatibility) :
    data.upperSemiState.logVolumeCompatibility.sourceLogVolume <=
      data.upperSemiState.logVolumeCompatibility.targetLogVolume :=
  data.logVolumeUpperBound

theorem structuredTheorem311_ind3_preserves_nonarchimedeanInclusions_example
    {coric : Type u}
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      IUTStage1StructuredTheorem311Choice.UpperSemiCompatibilityStep
        choice₁ choice₂) :
    choice₁.upper_semi_state.nonarchimedeanInclusions =
      choice₂.upper_semi_state.nonarchimedeanInclusions :=
  IUTStage1StructuredTheorem311Choice.ind3_preserves_nonarchimedeanInclusions
    hstep

theorem structuredTheorem311_ind3_preserves_archimedeanSurjections_example
    {coric : Type u}
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      IUTStage1StructuredTheorem311Choice.UpperSemiCompatibilityStep
        choice₁ choice₂) :
    choice₁.upper_semi_state.archimedeanSurjections =
      choice₂.upper_semi_state.archimedeanSurjections :=
  IUTStage1StructuredTheorem311Choice.ind3_preserves_archimedeanSurjections
    hstep

theorem structuredTheorem311_ind3_target_logVolumeUpperBound_example
    {coric : Type u}
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hstep :
      IUTStage1StructuredTheorem311Choice.UpperSemiCompatibilityStep
        choice₁ choice₂) :
    choice₂.upper_semi_state.logVolumeCompatibility.sourceLogVolume <=
      choice₂.upper_semi_state.logVolumeCompatibility.targetLogVolume :=
  IUTStage1StructuredTheorem311Choice.ind3_target_logVolumeUpperBound hstep

theorem structuredTheorem311_generated_preserves_coric_example
    {coric : Type u}
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1StructuredTheorem311Choice.indeterminacySourceData
          (coric := coric)).generators
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric :=
  IUTStage1StructuredTheorem311Choice.generated_preserves_coric hrel

theorem structuredTheorem311_generated_preserves_column_example
    {coric : Type u}
    {choice₁ choice₂ : IUTStage1StructuredTheorem311Choice coric}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1StructuredTheorem311Choice.indeterminacySourceData
          (coric := coric)).generators
        choice₁ choice₂) :
    choice₁.column = choice₂.column :=
  IUTStage1StructuredTheorem311Choice.generated_preserves_column hrel

theorem coordinateIndeterminacy_generated_coric_eq_example
    {coric ind1State ind2State ind3State : Type u}
    {choice₁ choice₂ :
      IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1IndeterminacyChoice.coordinateGenerators
          (coric := coric) (ind1State := ind1State)
          (ind2State := ind2State) (ind3State := ind3State))
        choice₁ choice₂) :
    choice₁.coric = choice₂.coric :=
  IUTStage1IndeterminacyChoice.generated_coric_eq hrel

theorem coordinateIndeterminacy_image_invariant_of_coric_example
    {coric ind1State ind2State ind3State : Type u}
    (images :
      RegionFamily thetaLine
        (IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State))
    (hcoric :
      ∀ choice₁ choice₂,
        choice₁.coric = choice₂.coric ->
          images.region choice₁ = images.region choice₂)
    {choice₁ choice₂ :
      IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (IUTStage1IndeterminacyChoice.coordinateGenerators
          (coric := coric) (ind1State := ind1State)
          (ind2State := ind2State) (ind3State := ind3State))
        choice₁ choice₂) :
    images.region choice₁ = images.region choice₂ :=
  IUTStage1IndeterminacyChoice.image_invariant_of_coric images hcoric hrel

def thetaImagesDependOnlyOnCoric_to_multiradial_example
    {source target : Copy}
    {coric ind1State ind2State ind3State : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State)}
    (dependence : IUTStage1ThetaImagesDependOnlyOnCoric package) :
    IUTStage1MultiradialThetaImages package :=
  dependence.toMultiradialThetaImages

theorem thetaImagesDependOnlyOnCoric_union_eq_targetUnion_example
    {source target : Copy}
    {coric ind1State ind2State ind3State : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1IndeterminacyChoice coric ind1State ind2State ind3State)}
    (dependence : IUTStage1ThetaImagesDependOnlyOnCoric package) :
    dependence.toMultiradialThetaImages.union =
      package.preLedger.output.comparisons.targetUnion :=
  dependence.union_eq_targetUnion

def unitThetaToyMultiradialThetaImages
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1MultiradialThetaImages
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  IUTStage1MultiradialThetaImages.ofPackageWithQuotient
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToyIndeterminacyQuotient (index := index))
    (by
      intro choice₁ choice₂ hrel
      cases hrel
      rfl)

theorem unitThetaToy_multiradialThetaImages_union_eq_targetUnion_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyMultiradialThetaImages
      measure hnormalized hh hbound hholds).union =
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).preLedger.output.comparisons.targetUnion :=
  (unitThetaToyMultiradialThetaImages
    measure hnormalized hh hbound hholds).union_eq_targetUnion

theorem unitThetaToy_multiradialThetaImages_region_eq_of_related_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h))
    {choice₁ choice₂ : index}
    (hrel :
      (unitThetaToyMultiradialThetaImages
        measure hnormalized hh hbound hholds).quotient.relation
          choice₁ choice₂) :
    (unitThetaToyMultiradialThetaImages
      measure hnormalized hh hbound hholds).possibleImages.images.region choice₁ =
      (unitThetaToyMultiradialThetaImages
        measure hnormalized hh hbound hholds).possibleImages.images.region choice₂ :=
  (unitThetaToyMultiradialThetaImages
    measure hnormalized hh hbound hholds).region_eq_of_related hrel

theorem unitThetaToy_multiradialThetaImages_output_matches_package_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyMultiradialThetaImages
      measure hnormalized hh hbound hholds).multiradialOutput =
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).multiradialOutput :=
  (unitThetaToyMultiradialThetaImages
    measure hnormalized hh hbound hholds).multiradialOutputMatchesPackage

def unitThetaToyGeneratedMultiradialThetaImages
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1MultiradialThetaImages
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  IUTStage1MultiradialThetaImages.ofPackageWithGeneratedQuotient
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToyIndeterminacyGenerators (index := index))
    (by
      intro choice₁ choice₂ hstep
      cases hstep)
    (by
      intro choice₁ choice₂ hstep
      cases hstep)
    (by
      intro choice₁ choice₂ hstep
      cases hstep)

theorem unitThetaToy_generatedMultiradialThetaImages_union_eq_targetUnion_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyGeneratedMultiradialThetaImages
      measure hnormalized hh hbound hholds).union =
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).preLedger.output.comparisons.targetUnion :=
  (unitThetaToyGeneratedMultiradialThetaImages
    measure hnormalized hh hbound hholds).union_eq_targetUnion

theorem unitThetaToy_generatedMultiradialThetaImages_region_eq_of_generated_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h))
    {choice₁ choice₂ : index}
    (hrel :
      IUTStage1GeneratedIndeterminacyRelation
        (unitThetaToyIndeterminacyGenerators (index := index))
        choice₁ choice₂) :
    (unitThetaToyGeneratedMultiradialThetaImages
      measure hnormalized hh hbound hholds).possibleImages.images.region choice₁ =
      (unitThetaToyGeneratedMultiradialThetaImages
        measure hnormalized hh hbound hholds).possibleImages.images.region choice₂ :=
  (unitThetaToyGeneratedMultiradialThetaImages
    measure hnormalized hh hbound hholds).region_eq_of_related hrel

def unitThetaToyTheorem311MultiradialThetaImages
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1MultiradialThetaImages
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  IUTStage1MultiradialThetaImages.ofPackageWithTheorem311Indeterminacies
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToyTheorem311IndeterminacySourceData (index := index))
    (by
      intro choice₁ choice₂ hstep
      cases hstep)
    (by
      intro choice₁ choice₂ hstep
      cases hstep)
    (by
      intro choice₁ choice₂ hstep
      cases hstep)

theorem unitThetaToy_theorem311MultiradialThetaImages_union_eq_targetUnion_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyTheorem311MultiradialThetaImages
      measure hnormalized hh hbound hholds).union =
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).preLedger.output.comparisons.targetUnion :=
  (unitThetaToyTheorem311MultiradialThetaImages
    measure hnormalized hh hbound hholds).union_eq_targetUnion

theorem unitThetaToy_source_hullDet_targetUnion_subset_hull_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    Region.Subset package.preLedger.output.comparisons.targetUnion
      ((unitThetaToyIUTStage1SourceHullDetData
        measure hnormalized hh hbound hholds).sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull :=
  (unitThetaToyIUTStage1SourceHullDetData
    measure hnormalized hh hbound hholds).targetUnion_subset_hull

theorem unitThetaToy_source_hullDet_determinantVolumeBound_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      ((unitThetaToyIUTStage1SourceHullDetData
        measure hnormalized hh hbound hholds).sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  (unitThetaToyIUTStage1SourceHullDetData
    measure hnormalized hh hbound hholds).determinantVolumeBound

theorem unitThetaToy_source_thetaPilot_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).thetaPilot =
      theorem311ToCorollary312Labels.thetaPilot :=
  rfl

theorem unitThetaToy_source_qPilot_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilot =
      theorem311ToCorollary312Labels.qPilot :=
  rfl

theorem unitThetaToy_source_logKummer_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).logKummer =
      theorem311ToCorollary312Labels.logKummer :=
  rfl

theorem unitThetaToy_source_indeterminacies_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).indeterminacies =
      theorem311ToCorollary312Labels.indeterminacies :=
  rfl

theorem unitThetaToy_source_qPilotLogVolume_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilotLogVolume =
      theorem311ToCorollary312Labels.qPilotLogVolume :=
  rfl

theorem unitThetaToy_source_sourceNormalization_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).sourceNormalizationLabel =
      theorem311ToCorollary312Labels.sourceNormalization :=
  rfl

def unitThetaToyIUTStage1SourceObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  let obligations :=
    unitThetaToyPromotionObligations measure hnormalized hh hbound hholds
  { algorithm_certified := obligations.certified,
    she_arrow_matches_certificate := obligations.she_matches_certificate,
    q_pilot_positive := obligations.q_positive,
    normalization := obligations.normalization_proof }

def unitThetaToyIUTStage1SourceHullDetObligations
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceHullDetObligations
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  { sourceObligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds,
    hullDetData :=
      unitThetaToyIUTStage1SourceHullDetData
        measure hnormalized hh hbound hholds }

theorem unitThetaToy_source_hullDetObligations_to_sourceObligations_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourceHullDetObligations
      measure hnormalized hh hbound hholds).toSourceObligations =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds :=
  rfl

theorem unitThetaToy_source_hullDetObligations_targetUnion_subset_hull_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    Region.Subset package.preLedger.output.comparisons.targetUnion
      ((unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds).hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull :=
  (unitThetaToyIUTStage1SourceHullDetObligations
    measure hnormalized hh hbound hholds).targetUnion_subset_hull

theorem unitThetaToy_source_hullDetObligations_determinantVolumeBound_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      ((unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds).hullDetData.sourceData.structuredHullDet.applyHull
          package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  (unitThetaToyIUTStage1SourceHullDetObligations
    measure hnormalized hh hbound hholds).determinantVolumeBound

theorem unitThetaToy_source_hullDetObligations_publicAudit_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfHullDetObligations_corollary312
      (unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_hullDetObligations_comparisonData_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).comparisonDataOfHullDetObligations_corollary312
      (unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_hullDetComparisonEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.HullDetComparisonEndpoint
      (unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditedHullDetComparisonEndpoint
      (unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_hullDetComparisonEndpoint_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (unitThetaToy_source_hullDetComparisonEndpoint_example
    measure hnormalized hh hbound hholds).corollary312Endpoint

theorem unitThetaToy_source_hullDetComparisonEndpoint_targetUnion_subset_hull_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds
    Region.Subset package.preLedger.output.comparisons.targetUnion
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  (unitThetaToy_source_hullDetComparisonEndpoint_example
    measure hnormalized hh hbound hholds).targetUnion_subset_hull

theorem unitThetaToy_source_hullDetComparisonEndpoint_determinantVolumeBound_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull
      package.preLedger.thetaSigned :=
  (unitThetaToy_source_hullDetComparisonEndpoint_example
    measure hnormalized hh hbound hholds).determinantVolumeBound

def unitThetaToy_source_thetaPilotHullEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.ThetaPilotHullEndpoint
      (unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditedThetaPilotHullEndpoint
      (unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_thetaPilotHullEndpoint_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (unitThetaToy_source_thetaPilotHullEndpoint_example
    measure hnormalized hh hbound hholds).corollary312Endpoint

theorem unitThetaToy_source_thetaPilotHullEndpoint_possibleImages_union_subset_hull_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let endpoint :=
      unitThetaToy_source_thetaPilotHullEndpoint_example
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds
    Region.Subset endpoint.possible_images.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  (unitThetaToy_source_thetaPilotHullEndpoint_example
    measure hnormalized hh hbound hholds).possibleImagesUnion_subset_hull

theorem unitThetaToy_source_thetaPilotHullEndpoint_union_eq_targetUnion_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let endpoint :=
      unitThetaToy_source_thetaPilotHullEndpoint_example
        measure hnormalized hh hbound hholds
    endpoint.possible_images.union =
      package.preLedger.output.comparisons.targetUnion :=
  (unitThetaToy_source_thetaPilotHullEndpoint_example
    measure hnormalized hh hbound hholds).possibleImagesUnion_eq_targetUnion

def unitThetaToy_source_multiradialThetaHullEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.MultiradialThetaHullEndpoint
      (unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditedMultiradialThetaHullEndpoint
      (unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds)
      (unitThetaToyMultiradialThetaImages
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_multiradialThetaHullEndpoint_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  (unitThetaToy_source_multiradialThetaHullEndpoint_example
    measure hnormalized hh hbound hholds).corollary312Endpoint

theorem unitThetaToy_source_multiradialThetaHullEndpoint_union_subset_hull_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let endpoint :=
      unitThetaToy_source_multiradialThetaHullEndpoint_example
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceHullDetObligations
        measure hnormalized hh hbound hholds
    Region.Subset endpoint.multiradial_images.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  (unitThetaToy_source_multiradialThetaHullEndpoint_example
    measure hnormalized hh hbound hholds).multiradialUnion_subset_hull

theorem unitThetaToy_source_multiradialThetaHullEndpoint_region_eq_related_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h))
    {choice₁ choice₂ : index}
    (hrel :
      (unitThetaToy_source_multiradialThetaHullEndpoint_example
        measure hnormalized hh hbound hholds).multiradial_images.quotient.relation
          choice₁ choice₂) :
    let endpoint :=
      unitThetaToy_source_multiradialThetaHullEndpoint_example
        measure hnormalized hh hbound hholds
    endpoint.multiradial_images.possibleImages.images.region choice₁ =
      endpoint.multiradial_images.possibleImages.images.region choice₂ :=
  (unitThetaToy_source_multiradialThetaHullEndpoint_example
    measure hnormalized hh hbound hholds).region_eq_of_related hrel

def placeAuditedMultiradialThetaHullEndpoint_of_images_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    (obligations : IUTStage1SourceHullDetObligations package)
    (images : IUTStage1PlaceAuditedMultiradialThetaImages package) :
    package.PlaceAuditedMultiradialThetaHullEndpoint obligations :=
  package.auditedPlaceAuditedMultiradialThetaHullEndpoint obligations images

theorem placeAuditedMultiradialThetaHullEndpoint_corollary_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  endpoint.corollary312Endpoint

theorem placeAuditedMultiradialThetaHullEndpoint_union_subset_hull_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations) :
    Region.Subset endpoint.audited_images.possibleImages.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  endpoint.auditedUnion_subset_hull

theorem placeAuditedMultiradialThetaHullEndpoint_region_eq_related_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hrel : endpoint.audited_images.auditedImages.quotient.relation
      audited₁ audited₂) :
    endpoint.audited_images.possibleImages.images.region audited₁ =
      endpoint.audited_images.possibleImages.images.region audited₂ :=
  endpoint.region_eq_of_related hrel

theorem placeAuditedMultiradialThetaHullEndpoint_nonarchimedeanEntry_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.nonarchimedean)}
    {obligations : IUTStage1SourceHullDetObligations package}
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.nonarchimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.NonarchimedeanIsmActionEntryStep
        audited₁ audited₂) :
    endpoint.audited_images.possibleImages.images.region audited₁ =
        endpoint.audited_images.possibleImages.images.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  endpoint.nonarchimedeanEntry_region_eq_and_fiber_mem
    fiberPackage hstep

theorem placeAuditedMultiradialThetaHullEndpoint_archimedeanEntry_example
    {source target : Copy} {coric : Type u}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice
          coric IUTStage1PlaceKind.archimedean)}
    {obligations : IUTStage1SourceHullDetObligations package}
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice
        coric IUTStage1PlaceKind.archimedean}
    (fiberPackage :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanInd2FiberPackage
        audited₁)
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ArchimedeanOrderTwoActionEntryStep
        audited₁ audited₂) :
    endpoint.audited_images.possibleImages.images.region audited₁ =
        endpoint.audited_images.possibleImages.images.region audited₂ ∧
      hstep.action_entry.place ∈ fiberPackage.fiberAudit.fiber.places :=
  endpoint.archimedeanEntry_region_eq_and_fiber_mem
    fiberPackage hstep

def placeAuditedMultiradialThetaHullEndpoint_logVolumeChartAudit_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    (endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations) :
    endpoint.LogVolumeChartAudit :=
  endpoint.logVolumeChartAudit

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_q_charted_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    (audit : endpoint.LogVolumeChartAudit) :
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned :=
  audit.qCharted

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    (audit : endpoint.LogVolumeChartAudit) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  audit.qSigned_le_thetaSigned

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_corollary_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    (audit : endpoint.LogVolumeChartAudit) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  audit.corollary312Endpoint

def placeAuditedMultiradialThetaHullEndpoint_logVolume_ind12_part_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    (audit : endpoint.LogVolumeChartAudit) :
    audit.Ind12EqualityPart :=
  audit.ind12EqualityPart

def placeAuditedMultiradialThetaHullEndpoint_logVolume_ind3_part_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    (audit : endpoint.LogVolumeChartAudit) :
    audit.Ind3UpperInequalityPart :=
  audit.ind3UpperInequalityPart

def placeAuditedMultiradialThetaHullEndpoint_logVolume_ind12_normalized_audit_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    (audit : endpoint.LogVolumeChartAudit) :
    audit.ProcessionNormalizedInd12Audit :=
  audit.processionNormalizedInd12Audit

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_ind12_q_le_target_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    (part : audit.Ind12EqualityPart) :
    package.preLedger.qSigned <= package.preLedger.targetVolume.targetSigned :=
  part.qSigned_le_targetSigned

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_ind12_ind1_normalized_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    (part : audit.ProcessionNormalizedInd12Audit)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.ind1NormalizedLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_ind12_ind2_normalized_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    (part : audit.ProcessionNormalizedInd12Audit)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    audited₁.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume =
      audited₂.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.ind2NormalizedLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_label_ind1_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {label : Type u} [Fintype label]
    (part : audit.LabelAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.averagedLogVolume audited₁).averageLogVolume =
      (part.averagedLogVolume audited₂).averageLogVolume :=
  part.ind1AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_label_ind2_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {label : Type u} [Fintype label]
    (part : audit.LabelAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.averagedLogVolume audited₁).averageLogVolume =
      (part.averagedLogVolume audited₂).averageLogVolume :=
  part.ind2AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_label_card_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {label : Type u} [Fintype label]
    (part : audit.FLLabelAveragedInd12Audit label) :
    Fintype.card label = part.label_model.prime.value :=
  part.labelCard_eq_primeValue

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_label_ind1_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {label : Type u} [Fintype label]
    (part : audit.FLLabelAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.ind1AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_label_ind2_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {label : Type u} [Fintype label]
    (part : audit.FLLabelAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.ind2AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_torsor_label_vadd_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {label : Type} [Fintype label]
    (part : audit.FLLabelTorsorAveragedInd12Audit label)
    (t : ZMod part.torsor_model.label_model.prime.value) (j : label) :
    part.torsor_model.torsor.vadd t j =
      part.torsor_model.label_model.fromZMod
        (t + part.torsor_model.label_model.toZMod j) :=
  part.labelTorsorVadd_eq_zmod t j

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_torsor_label_ind1_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {label : Type} [Fintype label]
    (part : audit.FLLabelTorsorAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.ind1AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_torsor_label_ind2_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {label : Type} [Fintype label]
    (part : audit.FLLabelTorsorAveragedInd12Audit label)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.ind2AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_label_card_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelAveragedInd12Audit l) :
    Fintype.card (ZMod l.value) = l.value :=
  part.labelCard_eq_primeValue

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_label_class_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelAveragedInd12Audit l) :
    part.cusp_label_model.cusp_label_class_data.labelClass =
      part.cusp_label_model.cusp_label_class_data.model.signAction.toSignLabelQuotient
        part.cusp_label_model.cusp_label_class_data.model.canonicalNonzeroLabel :=
  part.labelClass_eq_model_quotient

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_label_ind1_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelAveragedInd12Audit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.ind1AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_label_ind2_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelAveragedInd12Audit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.ind2AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_compatible_nonzero_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited).normalizedLogVolume j =
      (part.cuspLogVolume audited).cuspClassLogVolume
        (zmodSignLabelFromCoordinate l j hj) :=
  part.nonzeroAverageLabel_eq_cuspClass audited j hj

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_compatible_zero_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited).normalizedLogVolume 0 =
      (part.cuspLogVolume audited).zeroLogVolume :=
  part.zeroAverageLabel_eq_zeroLogVolume audited

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_compat_ind1_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.ind1AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_cusp_compat_ind2_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelCompatibleAveragedInd12Audit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂) :
    (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited₁).averageLogVolume =
      (part.zmod_cusp_audit.averaged_audit.averagedLogVolume audited₂).averageLogVolume :=
  part.ind2AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_theta_source_matches_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaSourceAudit l) :
    part.theta_images.thetaPilot = package.thetaPilot :=
  part.thetaPilotMatchesPackage

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_theta_source_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaSourceAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.thetaSourceAverage audited =
      (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).averageLogVolume :=
  part.thetaSourceAverage_eq audited

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_theta_source_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaSourceAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).averageLogVolume <= package.preLedger.thetaSigned :=
  part.averageLogVolume_le_thetaSigned audited

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_theta_source_ind1_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaSourceAudit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.ProcessionAutomorphismStep
        audited₁ audited₂) :
    (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited₁).averageLogVolume =
      (part.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited₂).averageLogVolume :=
  part.ind1AverageLogVolumeEq hstep

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_q_matches_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l) :
    part.qPilotLogVolume = package.qPilotLogVolume :=
  part.qPilotLogVolumeMatchesPackage

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_q_le_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <=
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).averageLogVolume :=
  part.qSigned_le_averageLogVolume audited

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelQThetaComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_average audited

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_final_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelFinalComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_from_average audited

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_final_chart_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelFinalComparisonAudit l) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_from_chart

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_final_cor312_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelFinalComparisonAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    Corollary312Inequality
      (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
      (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) :=
  part.corollary312FromAverage audited

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_final_ind3_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelFinalComparisonAudit l) :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned :=
  part.ind3TargetSigned_le_thetaSigned

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_target_reduction_q_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelTargetAverageReductionAudit l) :
    package.preLedger.qSigned <= package.preLedger.targetVolume.targetSigned :=
  part.qSigned_le_targetSigned

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_target_reduction_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelTargetAverageReductionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= part.theta_source.thetaSourceAverage audited :=
  part.qSigned_le_thetaSourceAverage audited

def placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_target_reduction_to_q_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelTargetAverageReductionAudit l) :
    audit.FLZModCuspLabelQThetaComparisonAudit l :=
  part.toQThetaComparisonAudit

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_container_not_ind3_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaContainerBoundAudit l) :
    part.bound_source ≠
      IUTStage1TargetAverageBoundSource.ind3UpperSemiOnly :=
  part.boundSource_not_ind3Only

def placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_container_to_reduction_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaContainerBoundAudit l) :
    audit.FLZModCuspLabelTargetAverageReductionAudit l :=
  part.toTargetAverageReductionAudit

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_container_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaContainerBoundAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_average audited

def placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_hull_container_to_classified_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l) :
    audit.FLZModCuspLabelThetaContainerBoundAudit l :=
  part.toThetaContainerBoundAudit

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_hull_container_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l) :
    part.toThetaContainerBoundAudit.bound_source =
      IUTStage1TargetAverageBoundSource.thetaPilotHullContainer :=
  part.boundSource_eq_thetaPilotHullContainer

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_hull_container_union_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l) :
    Region.Subset part.theta_source.theta_images.union
      (obligations.hullDetData.sourceData.structuredHullDet.applyHull
        package.preLedger.certificate).hull :=
  part.thetaSourceUnion_subset_hull

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_fl_zmod_hull_container_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPilotHullContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_hull_container audited

theorem placeAudited_logVolume_fl_zmod_labelwise_container_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaLabelwiseContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).averageLogVolume :=
  part.targetSigned_le_averageLogVolume audited

def placeAudited_logVolume_fl_zmod_labelwise_container_to_hull_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaLabelwiseContainerAudit l) :
    audit.FLZModCuspLabelThetaPilotHullContainerAudit l :=
  part.toThetaPilotHullContainerAudit

theorem placeAudited_logVolume_fl_zmod_labelwise_container_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaLabelwiseContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_labelwise_container audited

theorem placeAudited_logVolume_fl_zmod_cusp_container_labelwise_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j :=
  part.targetSigned_le_normalizedLogVolume audited j

def placeAudited_logVolume_fl_zmod_cusp_container_to_labelwise_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l) :
    audit.FLZModCuspLabelThetaLabelwiseContainerAudit l :=
  part.toThetaLabelwiseContainerAudit

theorem placeAudited_logVolume_fl_zmod_cusp_container_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_cusp_container audited

theorem placeAudited_logVolume_fl_zmod_cusp_container_target_average_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaCuspClassContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaAverage audited

theorem placeAudited_logVolume_fl_zmod_local_container_cusp_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaLocalContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label :=
  part.targetSigned_le_cuspClassLogVolume audited label

def placeAudited_logVolume_fl_zmod_local_container_to_cusp_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaLocalContainerAudit l) :
    audit.FLZModCuspLabelThetaCuspClassContainerAudit l :=
  part.toThetaCuspClassContainerAudit

theorem placeAudited_logVolume_fl_zmod_local_container_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaLocalContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_local_container audited

theorem placeAudited_logVolume_fl_zmod_local_object_container_cusp_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label :=
  part.targetSigned_le_cuspClassLogVolume audited label

def placeAudited_logVolume_fl_zmod_local_object_container_to_local_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaLocalContainerAudit l :=
  part.toThetaLocalContainerAudit

theorem placeAudited_logVolume_fl_zmod_local_object_container_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_local_object_container audited

theorem placeAudited_logVolume_fl_zmod_packet_local_object_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.cuspClassObjectEstimate audited label).localObject =
      audited.choice.local_tensor_state.packetState.localObject :=
  part.cuspClassObject_eq_packetLocalObject' audited label

theorem placeAudited_logVolume_fl_zmod_packet_local_object_cusp_model_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    (part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model).local_lab_cusp_model =
      zmodLocalLabCuspModel l :=
  part.localLabCuspModel_eq_zmod

theorem placeAudited_logVolume_fl_zmod_packet_local_object_cusp_data_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    (part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model).cusp_label_class_data =
      zmodCanonicalCuspLabelClassData l :=
  part.cuspLabelClassData_eq_zmod

def placeAudited_logVolume_fl_zmod_packet_local_object_to_local_object_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaLocalObjectContainerAudit l :=
  part.toThetaLocalObjectContainerAudit

theorem placeAudited_logVolume_fl_zmod_packet_local_object_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_packet_local_object_container audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_shared_packet_object_to_packet_local_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l :=
  part.toPacketLocalObjectContainerAudit

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_shared_packet_object_to_classified_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l :=
  part.toClassifiedPacketLocalObjectContainerAudit

theorem placeAudited_logVolume_fl_zmod_shared_packet_object_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l) :
    part.toClassifiedPacketLocalObjectContainerAudit.estimate_source =
      IUTStage1PacketLocalObjectEstimateSource.directLocalCuspConstruction :=
  part.estimateSource_eq_direct

theorem placeAudited_logVolume_fl_zmod_shared_zmod_packet_object_cusp_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  part.cuspClassLogVolume_eq_packetLocalObjectFinite audited label

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_shared_zmod_packet_object_to_shared_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaSharedPacketLocalObjectEstimateAudit l :=
  part.toSharedPacketLocalObjectEstimateAudit

theorem placeAudited_logVolume_fl_zmod_shared_zmod_packet_object_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l) :
    part.toClassifiedPacketLocalObjectContainerAudit.estimate_source =
      IUTStage1PacketLocalObjectEstimateSource.directLocalCuspConstruction :=
  part.estimateSource_eq_direct

theorem placeAudited_logVolume_fl_zmod_shared_zmod_packet_object_average_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.theta_source.thetaSourceAverage audited =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  part.thetaSourceAverage_eq_packetLocalObjectFinite audited

theorem placeAudited_logVolume_fl_zmod_shared_zmod_packet_object_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

theorem placeAudited_logVolume_fl_zmod_constant_packet_object_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  part.zmodNormalizedLogVolume_eq_packetLocalObjectFinite audited j

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_constant_packet_object_to_shared_zmod_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaSharedZModPacketLocalObjectEstimateAudit l :=
  part.toSharedZModPacketLocalObjectEstimateAudit

theorem placeAudited_logVolume_fl_zmod_constant_packet_object_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
  FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit in
def placeAudited_logVolume_fl_zmod_classified_constant_packet_object_direct_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit l :=
  ofDirectLocalLabelObjectConstruction part

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
  FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit in
def placeAudited_logVolume_fl_zmod_classified_constant_packet_object_separate_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l) :
    audit.FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit l :=
  ofSeparateLocalObjectIdentification part

theorem placeAudited_logVolume_fl_zmod_classified_constant_packet_object_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaClassifiedConstantZModPacketLocalObjectEstimateAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.constant_route.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

theorem placeAudited_logVolume_fl_zmod_direct_label_object_zmod_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  part.zmodNormalizedLogVolume_eq_packetLocalObjectFinite audited j

theorem placeAudited_logVolume_fl_zmod_direct_label_object_cusp_model_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l) :
    (part.theta_source.compatible_average.zmod_cusp_audit.cusp_label_model).local_lab_cusp_model =
      zmodLocalLabCuspModel l :=
  part.localLabCuspModel_eq_zmod

theorem placeAudited_logVolume_fl_zmod_direct_label_object_canonical_cusp_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        (zmodCanonicalSignLabelQuotient l) =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  part.canonicalCuspClassLogVolume_eq_packetLocalObjectFinite audited

theorem placeAudited_logVolume_fl_zmod_direct_label_object_zero_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  part.zeroLogVolume_eq_packetLocalObjectFinite audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_direct_label_object_to_constant_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l) :
    audit.FLZModCuspLabelThetaConstantZModPacketLocalObjectEstimateAudit l :=
  part.toConstantZModPacketLocalObjectEstimateAudit

theorem placeAudited_logVolume_fl_zmod_direct_label_object_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l) :
    part.toClassifiedConstantZModPacketLocalObjectEstimateAudit.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  part.bridgeSource_eq_direct

theorem placeAudited_logVolume_fl_zmod_direct_label_object_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

theorem placeAudited_logVolume_fl_zmod_insulated_cusp_zero_zero_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume 0 =
      (part.zeroLocalObject audited).finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume 0 =
        (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume 0 :=
      part.theta_source.compatible_average.normalizedLogVolumeEq audited 0
    _ = (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume :=
      (part.theta_source.compatible_average.cuspLogVolume audited).zero_eq_zeroLogVolume
    _ = (part.zeroLocalObject audited).finiteLogVolume :=
      part.zeroLogVolume_eq_localObjectFinite audited

theorem placeAudited_logVolume_fl_zmod_insulated_cusp_zero_one_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (1 : ZMod l.value) =
      (part.cuspClassLocalObject audited
        (zmodCanonicalSignLabelQuotient l)).finiteLogVolume :=
  part.one_normalizedLogVolume_eq_canonicalCuspClassLocalObjectFinite audited

theorem placeAudited_logVolume_fl_zmod_insulated_cusp_zero_neg_object_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l (-j)
          (zmod_neg_ne_zero_of_ne_zero l hj)) =
      part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l j hj) :=
  part.cuspClassLocalObject_negCoordinate_eq audited j hj

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_insulated_packet_bridge_to_comparison_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l :=
  part.toCuspZeroLocalLabelObjectConstructionAudit

theorem placeAudited_logVolume_fl_zmod_insulated_packet_bridge_zero_to_cusp_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.insulated_route.zeroLocalObject audited =
      part.insulated_route.cuspClassLocalObject audited label :=
  part.zeroLocalObject_eq_cuspClassLocalObject audited label

theorem placeAudited_logVolume_fl_zmod_insulated_packet_bridge_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.insulated_route.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
  FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit in
def placeAudited_logVolume_fl_zmod_classified_insulated_bridge_direct_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l :=
  ofDirectLocalLabelObjectConstruction part

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
  FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit in
theorem placeAudited_logVolume_fl_zmod_classified_insulated_bridge_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l) :
    (ofDirectLocalLabelObjectConstruction part).bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  bridgeSource_eq_direct part

theorem placeAudited_logVolume_fl_zmod_classified_insulated_bridge_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.packet_bridge.insulated_route.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_direct_identified_to_insulated_bridge_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l :=
  part.toInsulatedCuspZeroPacketBridgeAudit

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_direct_identified_to_classified_insulated_bridge_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedInsulatedCuspZeroPacketBridgeAudit l :=
  part.toClassifiedInsulatedCuspZeroPacketBridgeAudit

theorem placeAudited_logVolume_fl_zmod_direct_identified_insulated_bridge_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    part.toClassifiedInsulatedCuspZeroPacketBridgeAudit.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  part.insulatedPacketBridgeSource_eq_direct

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_direct_packet_normalized_to_insulated_bridge_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l :=
  part.toInsulatedCuspZeroPacketBridgeAudit

theorem placeAudited_logVolume_fl_zmod_direct_packet_normalized_insulated_bridge_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    part.toClassifiedInsulatedCuspZeroPacketBridgeAudit.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  part.insulatedPacketBridgeSource_eq_direct

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_zmod_packet_to_insulated_bridge_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaInsulatedCuspZeroPacketBridgeAudit l :=
  part.toInsulatedCuspZeroPacketBridgeAudit

theorem placeAudited_logVolume_fl_zmod_zmod_packet_insulated_bridge_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    part.toClassifiedInsulatedCuspZeroPacketBridgeAudit.bridge_source =
      IUTStage1ZModPacketLocalObjectBridgeSource.directLocalLabelObjectConstruction :=
  part.insulatedPacketBridgeSource_eq_direct

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
noncomputable def placeAudited_logVolume_fl_zmod_cusp_zero_label_object_to_direct_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l) :
    audit.FLZModCuspLabelThetaDirectLocalLabelObjectConstructionAudit l :=
  part.toDirectLocalLabelObjectConstructionAudit

theorem placeAudited_logVolume_fl_zmod_cusp_zero_label_object_zero_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume 0 =
      (part.zeroLocalObject audited).finiteLogVolume := by
  calc
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume 0 =
        (part.theta_source.compatible_average.cuspLogVolume audited).normalizedLogVolume 0 :=
      part.theta_source.compatible_average.normalizedLogVolumeEq audited 0
    _ = (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume :=
      (part.theta_source.compatible_average.cuspLogVolume audited).zero_eq_zeroLogVolume
    _ = (part.zeroLocalObject audited).finiteLogVolume :=
      part.zeroLogVolume_eq_localObjectFinite audited

theorem placeAudited_logVolume_fl_zmod_cusp_zero_label_object_one_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (1 : ZMod l.value) =
      (part.cuspClassLocalObject audited
        (zmodCanonicalSignLabelQuotient l)).finiteLogVolume :=
  part.one_normalizedLogVolume_eq_canonicalCuspClassLocalObjectFinite audited

theorem placeAudited_logVolume_fl_zmod_cusp_zero_label_object_neg_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (-j) =
      (part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l j hj)).finiteLogVolume :=
  part.neg_normalizedLogVolume_eq_cuspClassLocalObjectFinite audited j hj

theorem placeAudited_logVolume_fl_zmod_cusp_zero_label_object_neg_one_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume (-(1 : ZMod l.value)) =
      (part.cuspClassLocalObject audited
        (zmodCanonicalSignLabelQuotient l)).finiteLogVolume :=
  part.neg_one_normalizedLogVolume_eq_canonicalCuspClassLocalObjectFinite audited

theorem placeAudited_logVolume_fl_zmod_cusp_zero_label_object_neg_object_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) (hj : j ≠ 0) :
    part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l (-j)
          (zmod_neg_ne_zero_of_ne_zero l hj)) =
      part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l j hj) :=
  part.cuspClassLocalObject_negCoordinate_eq audited j hj

theorem placeAudited_logVolume_fl_zmod_cusp_zero_label_object_neg_one_object_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.cuspClassLocalObject audited
        (zmodSignLabelFromCoordinate l (-(1 : ZMod l.value))
          (zmod_neg_ne_zero_of_ne_zero l (zmodOneNonzeroLabel l).2)) =
      part.cuspClassLocalObject audited (zmodCanonicalSignLabelQuotient l) :=
  part.cuspClassLocalObject_neg_one_eq_canonical audited

theorem placeAudited_logVolume_fl_zmod_cusp_zero_zero_to_cusp_object_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    part.zeroLocalObject audited =
      part.cuspClassLocalObject audited label :=
  part.zeroLocalObject_eq_cuspClassLocalObject audited label

theorem placeAudited_logVolume_fl_zmod_cusp_zero_zero_to_canonical_log_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    (part.theta_source.compatible_average.cuspLogVolume audited).zeroLogVolume =
      (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        (zmodCanonicalSignLabelQuotient l) :=
  part.zeroLogVolume_eq_canonicalCuspClassLogVolume audited

theorem placeAudited_logVolume_fl_zmod_cusp_zero_label_object_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaCuspZeroLocalLabelObjectConstructionAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_packet_local_object_to_direct_packet_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (directNormalization :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1DirectPacketNormalizationData
          audited.choice.local_tensor_state.packetState) :
    audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l :=
  part.toDirectLocalPacketNormalizedAudit directNormalization

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_packet_local_object_to_direct_route_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (directNormalization :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1DirectPacketNormalizationData
          audited.choice.local_tensor_state.packetState)
    (targetCapsuleEstimates :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1TypedCapsuleFamilyContainerEstimate
          package.preLedger.targetVolume.targetSigned
          audited.choice.local_tensor_state.packetState.capsuleFamily) :
    audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l :=
  part.toDirectLocalPacketDirectCapsuleRouteAudit
    directNormalization targetCapsuleEstimates

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
  FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit in
def placeAudited_logVolume_fl_zmod_classified_packet_local_object_direct_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l :=
  ofDirectLocalCuspConstruction part

theorem placeAudited_logVolume_fl_zmod_packet_local_object_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l)
    (directNormalization :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1DirectPacketNormalizationData
          audited.choice.local_tensor_state.packetState)
    (targetCapsuleEstimates :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1TypedCapsuleFamilyContainerEstimate
          package.preLedger.targetVolume.targetSigned
          audited.choice.local_tensor_state.packetState.capsuleFamily)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage_of_directPacket
    directNormalization targetCapsuleEstimates audited

theorem placeAudited_logVolume_fl_zmod_classified_packet_local_object_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaClassifiedPacketLocalObjectContainerAudit l)
    (directNormalization :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1DirectPacketNormalizationData
          audited.choice.local_tensor_state.packetState)
    (targetCapsuleEstimates :
      ∀ audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind,
        IUTStage1TypedCapsuleFamilyContainerEstimate
          package.preLedger.targetVolume.targetSigned
          audited.choice.local_tensor_state.packetState.capsuleFamily)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.packet_local_object.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage_of_directPacket
    directNormalization targetCapsuleEstimates audited

theorem placeAudited_logVolume_fl_zmod_packet_normalized_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.cuspClassLogVolume_eq_packetNormalized audited label

theorem placeAudited_logVolume_fl_zmod_packet_normalized_capsule_sum_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      (Finset.univ.sum fun i =>
          (audited.choice.local_tensor_state.packetState.capsuleFamily.capsule i).logVolume) /
        (audited.choice.local_tensor_state.packetState.capsuleFamily.capsuleCount : Real) :=
  part.cuspClassLogVolume_eq_capsuleSumAverage audited label

def placeAudited_logVolume_fl_zmod_packet_normalized_to_object_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l) :
    audit.FLZModCuspLabelThetaPacketLocalObjectContainerAudit l :=
  part.toThetaPacketLocalObjectContainerAudit

theorem placeAudited_logVolume_fl_zmod_packet_normalized_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_packet_normalized_container audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_classified_packet_normalized_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l :=
  FLZModCuspLabelThetaClassifiedPacketNormalizedAudit.ofSeparateRealLineIdentification
    part

theorem placeAudited_logVolume_fl_zmod_classified_packet_normalized_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.packet_normalized.theta_source.compatible_average.cuspLogVolume
        audited).cuspClassLogVolume label =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.cuspClassLogVolume_eq_packetNormalized audited label

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_classified_local_packet_to_global_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l :=
  part.toClassifiedPacketNormalizedAudit

theorem placeAudited_logVolume_fl_zmod_classified_local_packet_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaClassifiedLocalPacketNormalizedAudit l) :
    part.toClassifiedPacketNormalizedAudit.identification_source =
      part.identification_source :=
  rfl

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_ind2_local_packet_to_global_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l :=
  part.toClassifiedPacketNormalizedAudit

theorem placeAudited_logVolume_fl_zmod_ind2_local_packet_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInd2TransportedLocalPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.targetCuspClassCompatibility audited label).identification_source =
      IUTStage1PacketNormalizedIdentificationSource.ind2TransportedPacketNormalization :=
  part.targetCuspClassCompatibilitySource_eq audited label

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_direct_local_packet_to_global_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l) :
    audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l :=
  part.toClassifiedPacketNormalizedAudit

theorem placeAudited_logVolume_fl_zmod_direct_local_packet_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.targetCuspClassCompatibility audited label).identification_source =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  part.targetCuspClassCompatibilitySource_eq audited label

theorem placeAudited_logVolume_fl_zmod_packet_normalized_ind2_cusp_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        audited₁.choice.local_tensor_state.packetState.capsuleFamily)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited₂).cuspClassLogVolume
        label :=
  part.targetSigned_le_cuspClassLogVolume_of_ind2_capsuleEstimates
    hstep estimate label

theorem placeAudited_logVolume_fl_zmod_packet_normalized_ind2_zero_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaPacketNormalizedContainerAudit l)
    {audited₁ audited₂ :
      IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind}
    (hstep :
      IUTStage1PlaceAuditedDirectSummandPacketChoice.LocalTensorDirectSummandActionStep
        audited₁ audited₂)
    (estimate :
      IUTStage1TypedCapsuleFamilyContainerEstimate
        package.preLedger.targetVolume.targetSigned
        audited₁.choice.local_tensor_state.packetState.capsuleFamily) :
    package.preLedger.targetVolume.targetSigned <=
      (part.theta_source.compatible_average.cuspLogVolume audited₂).zeroLogVolume :=
  part.targetSigned_le_zeroLogVolume_of_ind2_capsuleEstimates
    hstep estimate

theorem placeAudited_logVolume_fl_zmod_ind2_transport_cusp_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.packet_normalized.theta_source.compatible_average.cuspLogVolume
        audited).cuspClassLogVolume label :=
  part.targetSigned_le_cuspClassLogVolume audited label

def placeAudited_logVolume_fl_zmod_ind2_transport_to_cusp_audit_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l) :
    audit.FLZModCuspLabelThetaCuspClassContainerAudit l :=
  part.toThetaCuspClassContainerAudit

theorem placeAudited_logVolume_fl_zmod_ind2_transport_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_ind2_transport audited

theorem placeAudited_logVolume_fl_zmod_direct_capsule_cusp_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    package.preLedger.targetVolume.targetSigned <=
      (part.packet_normalized.theta_source.compatible_average.cuspLogVolume
        audited).cuspClassLogVolume label :=
  part.targetSigned_le_cuspClassLogVolume audited label

def placeAudited_logVolume_fl_zmod_direct_capsule_to_cusp_audit_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l) :
    audit.FLZModCuspLabelThetaCuspClassContainerAudit l :=
  part.toThetaCuspClassContainerAudit

theorem placeAudited_logVolume_fl_zmod_direct_capsule_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_direct_capsules audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_classified_cusp_direct_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l) :
    audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l :=
  FLZModCuspLabelThetaClassifiedCuspClassAudit.ofDirectCapsule part

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_classified_cusp_ind2_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l) :
    audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l :=
  FLZModCuspLabelThetaClassifiedCuspClassAudit.ofInd2Transport part

theorem placeAudited_logVolume_fl_zmod_classified_cusp_q_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  part.qSigned_le_thetaSigned_via_classified_cusp audited

def placeAudited_logVolume_fl_zmod_classified_cusp_to_hull_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l) :
    audit.FLZModCuspLabelThetaPilotHullContainerAudit l :=
  part.toThetaPilotHullContainerAudit

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
theorem placeAudited_logVolume_fl_zmod_classified_cusp_target_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l) :
    part.toThetaContainerBoundAudit.bound_source =
      IUTStage1TargetAverageBoundSource.thetaPilotHullContainer :=
  part.targetAverageBoundSource_eq_thetaPilotHullContainer

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_classified_route_summary_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaClassifiedCuspClassAudit l) :
    audit.FLZModCuspLabelThetaClassifiedRouteSummary l :=
  FLZModCuspLabelThetaClassifiedRouteSummary.ofClassifiedCusp part

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
theorem placeAudited_logVolume_fl_zmod_classified_route_target_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (summary : audit.FLZModCuspLabelThetaClassifiedRouteSummary l) :
    summary.target_average_source =
      IUTStage1TargetAverageBoundSource.thetaPilotHullContainer :=
  summary.targetAverageSource_eq_thetaPilotHullContainer

def placeAudited_logVolume_fl_zmod_full_classified_summary_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (packetSummary :
      audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l)
    (routeSummary :
      audit.FLZModCuspLabelThetaClassifiedRouteSummary l)
    (hsource :
      packetSummary.packet_normalized.theta_source =
        routeSummary.classified_cusp.cusp_class_audit.theta_source) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  { classified_packet := packetSummary,
    classified_route := routeSummary,
    theta_source_eq := hsource }

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_full_classified_direct_summary_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (packetSummary :
      audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l)
    (direct : audit.FLZModCuspLabelThetaDirectCapsuleCuspClassAudit l)
    (hpacket : direct.packet_normalized = packetSummary.packet_normalized) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  FLZModCuspLabelThetaFullClassifiedRouteSummary.ofDirectCapsule
    packetSummary direct hpacket

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_full_classified_ind2_summary_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (packetSummary :
      audit.FLZModCuspLabelThetaClassifiedPacketNormalizedAudit l)
    (transported : audit.FLZModCuspLabelThetaInd2TransportedCuspClassAudit l)
    (hpacket :
      transported.packet_normalized = packetSummary.packet_normalized) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  FLZModCuspLabelThetaFullClassifiedRouteSummary.ofInd2Transport
    packetSummary transported hpacket

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_direct_local_packet_full_route_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.toFullClassifiedRouteSummary

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_direct_local_packet_to_identified_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l :=
  part.toDirectIdentifiedLocalPacketRouteAudit

theorem placeAudited_logVolume_fl_zmod_direct_local_packet_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.direct_packet.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_ind2_local_packet_full_route_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.toFullClassifiedRouteSummary

theorem placeAudited_logVolume_fl_zmod_ind2_local_packet_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.ind2_packet.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

theorem placeAudited_logVolume_fl_zmod_direct_local_packet_full_route_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectLocalPacketDirectCapsuleRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  part.packetIdentificationSource_eq_direct

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_direct_identified_packet_to_direct_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectLocalPacketNormalizedAudit l :=
  part.toDirectLocalPacketNormalizedAudit

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_direct_identified_packet_full_route_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.toFullClassifiedRouteSummary

theorem placeAudited_logVolume_fl_zmod_direct_identified_packet_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  part.packetIdentificationSource_eq_direct

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
  FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit in
def placeAudited_logVolume_fl_zmod_classified_direct_identified_separate_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l :=
  ofSeparateRealLineIdentification part

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
  FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit in
def placeAudited_logVolume_fl_zmod_classified_direct_identified_packet_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l :=
  ofPacketNormalizationAndLocalObjectCompatibility part

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_identified_to_packet_normalized_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l :=
  part.toDirectPacketNormalizedLocalObjectRouteAudit

theorem placeAudited_logVolume_fl_zmod_identified_packet_cusp_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.cuspClassLogVolume_eq_packetNormalized audited label

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_identified_to_constant_zmod_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l) :
    audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l :=
  part.toConstantZModPacketNormalizedRouteAudit

theorem placeAudited_logVolume_fl_zmod_identified_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

theorem placeAudited_logVolume_fl_zmod_classified_direct_identified_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaClassifiedDirectIdentifiedLocalPacketRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  part.packetIdentificationSource_eq_direct

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_packet_normalized_local_object_to_identified_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectIdentifiedLocalPacketRouteAudit l :=
  part.toDirectIdentifiedLocalPacketRouteAudit

theorem placeAudited_logVolume_fl_zmod_packet_normalized_local_object_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      audited.choice.local_tensor_state.packetState.localObject.finiteLogVolume :=
  part.cuspClassLogVolume_eq_localObjectFinite audited label

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_packet_normalized_local_object_full_route_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.toFullClassifiedRouteSummary

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_cusp_zero_to_zmod_packet_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l) :
    audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l :=
  part.toZModPacketNormalizedRouteAudit

theorem placeAudited_logVolume_fl_zmod_cusp_zero_pointwise_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.zmodNormalizedLogVolume_eq_packetNormalized audited j

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_zmod_packet_normalized_to_local_object_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaDirectPacketNormalizedLocalObjectRouteAudit l :=
  part.toDirectPacketNormalizedLocalObjectRouteAudit

theorem placeAudited_logVolume_fl_zmod_zmod_packet_normalized_cusp_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (label : (zmodSignAction l).SignLabelQuotient) :
    (part.theta_source.compatible_average.cuspLogVolume audited).cuspClassLogVolume
        label =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.cuspClassLogVolume_eq_packetNormalized audited label

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_zmod_packet_normalized_full_route_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.toFullClassifiedRouteSummary

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
  FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit in
def placeAudited_logVolume_fl_zmod_classified_zmod_packet_direct_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l :=
  ofDirectLabelPacketNormalization part

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit
  FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit in
def placeAudited_logVolume_fl_zmod_classified_zmod_packet_separate_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l :=
  ofSeparateAveragingIdentification part

theorem placeAudited_logVolume_fl_zmod_classified_zmod_packet_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaClassifiedZModPacketNormalizedRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.directPacketNormalization :=
  part.packetIdentificationSource_eq_direct

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_pointwise_to_constant_zmod_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l :=
  part.toConstantZModPacketNormalizedRouteAudit

theorem placeAudited_logVolume_fl_zmod_pointwise_to_constant_average_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.toConstantZModPacketNormalizedRouteAudit.targetSigned_le_thetaSourceAverage audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_constant_zmod_packet_to_zmod_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaZModPacketNormalizedRouteAudit l :=
  part.toZModPacketNormalizedRouteAudit

theorem placeAudited_logVolume_fl_zmod_constant_zmod_packet_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)
    (j : ZMod l.value) :
    (part.theta_source.compatible_average.zmod_cusp_audit.averaged_audit.averagedLogVolume
        audited).normalizedLogVolume j =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.zmodNormalizedLogVolume_eq_packetNormalized audited j

theorem placeAudited_logVolume_fl_zmod_constant_zmod_average_eq_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    part.theta_source.thetaSourceAverage audited =
      audited.choice.local_tensor_state.packetState.capsuleFamily.normalizedLogVolume :=
  part.thetaSourceAverage_eq_packetNormalized audited

theorem placeAudited_logVolume_fl_zmod_constant_zmod_target_bound_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l)
    (audited : IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind) :
    package.preLedger.targetVolume.targetSigned <=
      part.theta_source.thetaSourceAverage audited :=
  part.targetSigned_le_thetaSourceAverage audited

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
def placeAudited_logVolume_fl_zmod_constant_zmod_packet_full_route_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part : audit.FLZModCuspLabelThetaConstantZModPacketNormalizedRouteAudit l) :
    audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l :=
  part.toFullClassifiedRouteSummary

theorem placeAudited_logVolume_fl_zmod_ind2_local_packet_full_route_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (part :
      audit.FLZModCuspLabelThetaInd2LocalPacketTransportedCapsuleRouteAudit l) :
    part.toFullClassifiedRouteSummary.packetIdentificationSource =
      IUTStage1PacketNormalizedIdentificationSource.ind2TransportedPacketNormalization :=
  part.packetIdentificationSource_eq_ind2Transported

open IUTStage1SourcePackage.PlaceAuditedMultiradialThetaHullEndpoint.LogVolumeChartAudit in
theorem placeAudited_logVolume_fl_zmod_full_classified_target_source_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    {l : PrimeGeFive}
    (summary : audit.FLZModCuspLabelThetaFullClassifiedRouteSummary l) :
    summary.targetAverageSource =
      IUTStage1TargetAverageBoundSource.thetaPilotHullContainer :=
  summary.targetAverageSource_eq_thetaPilotHullContainer

theorem placeAuditedMultiradialThetaHullEndpoint_logVolume_ind3_target_le_theta_example
    {source target : Copy} {coric : Type u} {kind : IUTStage1PlaceKind}
    {package :
      IUTStage1SourcePackage source target
        (IUTStage1PlaceAuditedDirectSummandPacketChoice coric kind)}
    {obligations : IUTStage1SourceHullDetObligations package}
    {endpoint : package.PlaceAuditedMultiradialThetaHullEndpoint obligations}
    {audit : endpoint.LogVolumeChartAudit}
    (part : audit.Ind3UpperInequalityPart) :
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned :=
  part.targetSigned_le_thetaSigned

def unitThetaToyIUTStage1SourceObligationGap
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligationGap
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  let obligations :=
    unitThetaToyPromotionObligations measure hnormalized hh hbound hholds
  { theorem311_algorithm_certified := obligations.certified,
    she_alignment := obligations.she_matches_certificate,
    q_pilot_positive := obligations.q_positive,
    source_normalization := obligations.normalization_proof }

theorem unitThetaToy_source_gap_to_obligations_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourceObligationGap
      measure hnormalized hh hbound hholds).toSourceObligations =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds :=
  rfl

theorem unitThetaToy_source_gap_algorithm_certified_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.output.Certified :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).theorem311AlgorithmCertified

theorem unitThetaToy_source_gap_she_alignment_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).sheAlignment

theorem unitThetaToy_source_theorem311_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311Subclaims
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).theorem311Subclaims

theorem unitThetaToy_source_theorem311_algorithmic_output_component_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311AlgorithmicOutput
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).algorithmicOutput

theorem unitThetaToy_source_theorem311_algorithmic_output_component_certified_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.output.Certified :=
  (unitThetaToy_source_theorem311_algorithmic_output_component_example
    measure hnormalized hh hbound hholds).algorithmOutputCertified

theorem unitThetaToy_source_theorem311_algorithmic_output_certified_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    subclaims.algorithmicOutput.algorithmOutputCertified =
      subclaims.algorithmOutputCertified :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).algorithmicOutput_certified_eq

theorem unitThetaToy_source_theorem311_subclaims_from_algorithmic_output_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311Subclaims
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  IUTStage1Theorem311Subclaims.ofAlgorithmicOutputAndSHEAlignment
    (unitThetaToy_source_theorem311_algorithmic_output_component_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_subclaims_example
      measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment

theorem unitThetaToy_source_theorem311_subclaims_from_algorithmic_output_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let algorithmicOutput :=
      unitThetaToy_source_theorem311_algorithmic_output_component_example
        measure hnormalized hh hbound hholds
    (IUTStage1Theorem311Subclaims.ofAlgorithmicOutputAndSHEAlignment
      algorithmicOutput
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment).algorithmicOutput =
      algorithmicOutput :=
  IUTStage1Theorem311Subclaims.ofAlgorithmicOutputAndSHEAlignment_algorithmicOutput_eq
    (unitThetaToy_source_theorem311_algorithmic_output_component_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_subclaims_example
      measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment

theorem unitThetaToy_source_theorem311_she_alignment_component_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311SHEAlignment
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).sheAlignment

theorem unitThetaToy_source_theorem311_she_alignment_component_alignment_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  (unitThetaToy_source_theorem311_she_alignment_component_example
    measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment

theorem unitThetaToy_source_theorem311_she_alignment_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    subclaims.sheAlignment.hodgeTheaterSHEAlignment =
      subclaims.hodgeTheaterSHEAlignment :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).sheAlignment_hodgeTheaterSHEAlignment_eq

theorem unitThetaToy_source_theorem311_subclaims_from_components_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311Subclaims
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  IUTStage1Theorem311Subclaims.ofComponents
    (unitThetaToy_source_theorem311_algorithmic_output_component_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_she_alignment_component_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_subclaims_from_components_algorithmic_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let algorithmicOutput :=
      unitThetaToy_source_theorem311_algorithmic_output_component_example
        measure hnormalized hh hbound hholds
    let sheAlignment :=
      unitThetaToy_source_theorem311_she_alignment_component_example
        measure hnormalized hh hbound hholds
    (IUTStage1Theorem311Subclaims.ofComponents
      algorithmicOutput sheAlignment).algorithmicOutput =
      algorithmicOutput :=
  IUTStage1Theorem311Subclaims.ofComponents_algorithmicOutput_eq
    (unitThetaToy_source_theorem311_algorithmic_output_component_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_she_alignment_component_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_subclaims_from_components_she_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let algorithmicOutput :=
      unitThetaToy_source_theorem311_algorithmic_output_component_example
        measure hnormalized hh hbound hholds
    let sheAlignment :=
      unitThetaToy_source_theorem311_she_alignment_component_example
        measure hnormalized hh hbound hholds
    (IUTStage1Theorem311Subclaims.ofComponents
      algorithmicOutput sheAlignment).sheAlignment =
      sheAlignment :=
  IUTStage1Theorem311Subclaims.ofComponents_sheAlignment_eq
    (unitThetaToy_source_theorem311_algorithmic_output_component_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_she_alignment_component_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_algorithm_output_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.output.Certified :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).algorithmOutputCertified

theorem unitThetaToy_source_theorem311_she_alignment_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  (unitThetaToy_source_theorem311_subclaims_example
    measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment

theorem unitThetaToy_source_theorem311_structured_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311StructuredInputs
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).theorem311StructuredInputs

theorem unitThetaToy_source_theorem311_structured_hasIPL_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    QualitativeData.HasStructuredIPL package.preLedger.output.family :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).hasStructuredIPL

theorem unitThetaToy_source_theorem311_structured_hasSHE_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    QualitativeData.HasStructuredSHE package.preLedger.output.family :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).hasStructuredSHE

theorem unitThetaToy_source_theorem311_structured_hasAPT_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    QualitativeData.HasStructuredAPT package.preLedger.output.family :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).hasStructuredAPT

theorem unitThetaToy_source_theorem311_structured_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds).theorem311Subclaims =
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds :=
  IUTStage1SourceObligationGap.theorem311StructuredInputs_subclaims
    (unitThetaToyIUTStage1SourceObligationGap
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_structured_algorithm_eq_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    inputs.algorithmOutputCertified =
      inputs.theorem311Subclaims.algorithmOutputCertified :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).algorithmOutputCertified_eq_subclaims

theorem unitThetaToy_source_theorem311_structured_algorithmic_component_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311AlgorithmicOutput
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).algorithmicOutput

theorem unitThetaToy_source_theorem311_structured_algorithmic_eq_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    inputs.algorithmicOutput =
      inputs.theorem311Subclaims.algorithmicOutput :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).algorithmicOutput_eq_subclaims

theorem unitThetaToy_source_theorem311_structured_she_eq_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    inputs.hodgeTheaterSHEAlignment =
      inputs.theorem311Subclaims.hodgeTheaterSHEAlignment :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment_eq_subclaims

theorem unitThetaToy_source_theorem311_structured_she_component_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311SHEAlignment
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).sheAlignment

def unitThetaToy_source_theorem311_structured_she_input_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311StructuredSHE package :=
  { context := thetaToyStructuredSHEContext unitQToTheta h epsilon,
    she_datum_matches_certificate := rfl,
    she_arrow_matches_context := rfl }

theorem unitThetaToy_source_theorem311_structured_she_input_hasStructuredSHE_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    QualitativeData.HasStructuredSHE package.preLedger.output.family :=
  (unitThetaToy_source_theorem311_structured_she_input_example
    measure hnormalized hh hbound hholds).hasStructuredSHE

theorem unitThetaToy_source_theorem311_structured_she_input_alignment_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  (unitThetaToy_source_theorem311_structured_she_input_example
    measure hnormalized hh hbound hholds).hodgeTheaterSHEAlignment

theorem unitThetaToy_source_theorem311_structured_she_input_history_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let structuredSHE :=
      unitThetaToy_source_theorem311_structured_she_input_example
        measure hnormalized hh hbound hholds
    structuredSHE.context.domainStructure.theater.side ≠
      structuredSHE.context.codomainStructure.theater.side :=
  (unitThetaToy_source_theorem311_structured_she_input_example
    measure hnormalized hh hbound hholds).domainHistory_ne_codomainHistory

theorem unitThetaToy_source_theorem311_structured_she_common_container_compatibility_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let structuredSHE :=
      unitThetaToy_source_theorem311_structured_she_input_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package structuredSHE :=
  IUTStage1Theorem311StructuredSHECommonContainerCompatibility.ofStructuredSHE
    (unitThetaToy_source_theorem311_structured_she_input_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_structured_she_common_context_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let structuredSHE :=
      unitThetaToy_source_theorem311_structured_she_input_example
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.context =
      structuredSHE.context.sharedContext :=
  (unitThetaToy_source_theorem311_structured_she_input_example
    measure hnormalized hh hbound hholds).commonContainerContextMatches

theorem unitThetaToy_source_theorem311_structured_she_q_pilot_context_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let structuredSHE :=
      unitThetaToy_source_theorem311_structured_she_input_example
        measure hnormalized hh hbound hholds
    structuredSHE.context.qPilotStructure.theater =
      structuredSHE.context.codomainStructure.theater :=
  (IUTStage1Theorem311StructuredSHECommonContainerCompatibility.ofStructuredSHE
    (unitThetaToy_source_theorem311_structured_she_input_example
      measure hnormalized hh hbound hholds)).qPilotTheater_eq_codomain

theorem unitThetaToy_source_theorem311_structured_she_theta_pilot_context_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let structuredSHE :=
      unitThetaToy_source_theorem311_structured_she_input_example
        measure hnormalized hh hbound hholds
    structuredSHE.context.thetaPilotStructure.theater =
      structuredSHE.context.domainStructure.theater :=
  (IUTStage1Theorem311StructuredSHECommonContainerCompatibility.ofStructuredSHE
    (unitThetaToy_source_theorem311_structured_she_input_example
      measure hnormalized hh hbound hholds)).thetaPilotTheater_eq_domain

theorem unitThetaToy_source_theorem311_structured_she_simultaneous_valid_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let structuredSHE :=
      unitThetaToy_source_theorem311_structured_she_input_example
        measure hnormalized hh hbound hholds
    structuredSHE.context.simultaneous_valid :=
  (IUTStage1Theorem311StructuredSHECommonContainerCompatibility.ofStructuredSHE
    (unitThetaToy_source_theorem311_structured_she_input_example
      measure hnormalized hh hbound hholds)).simultaneousValid

def unitThetaToy_source_theorem311_structured_inputs_with_she_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311StructuredInputsWithSHE package :=
  { inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds,
    structured_she :=
      unitThetaToy_source_theorem311_structured_she_input_example
        measure hnormalized hh hbound hholds }

theorem unitThetaToy_source_theorem311_structured_inputs_with_she_hasSHE_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    QualitativeData.HasStructuredSHE package.preLedger.output.family :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).hasStructuredSHE_from_context

theorem unitThetaToy_source_theorem311_structured_inputs_with_she_alignment_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    bundle.inputs.sheAlignment =
      bundle.structuredSHE.sheAlignment :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).sheAlignment_eq_context_sheAlignment

theorem unitThetaToy_source_theorem311_structured_inputs_with_she_history_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).domainHistory_ne_codomainHistory

theorem unitThetaToy_source_theorem311_structured_inputs_with_she_common_context_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.context =
      bundle.structuredSHE.context.sharedContext :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).commonContainerContextMatches

theorem unitThetaToy_source_theorem311_audited_hdd_she_bound_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311AuditedHDDSHEBound package bundle :=
  IUTStage1Theorem311AuditedHDDSHEBound.ofStructuredInputsWithSHE
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_audited_hdd_she_choice_bound_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice) <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedHDDSHE_chosenTargetVolume_le_theta

theorem unitThetaToy_source_theorem311_audited_hdd_she_she_validity_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    bundle.structuredSHE.context.simultaneousExpression.AllLocalValid :=
  (unitThetaToy_source_theorem311_audited_hdd_she_bound_example
    measure hnormalized hh hbound hholds).localExpressionValid

theorem unitThetaToy_source_theorem311_audited_hdd_she_all_targets_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    RegionComparisonFamily.AllTargetsAtMost measure
      (thetaToyAlgorithmOutput unitQToTheta h epsilon).comparisons
      (-(2 * h) + epsilonBound) :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedHDDSHE_allTargetsAtMost_theta

theorem unitThetaToy_source_theorem311_audited_target_middle_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311AuditedTargetVolumeMiddle package bundle :=
  IUTStage1Theorem311AuditedTargetVolumeMiddle.ofStructuredInputsWithSHE
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_audited_target_middle_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.targetVolume.targetSigned =
      RegionMeasure.targetVolume measure
        ((thetaToyAlgorithmOutput unitQToTheta h epsilon).comparison choice) :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedTargetSigned_eq_chosenTargetVolume

theorem unitThetaToy_source_theorem311_audited_target_middle_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.targetVolume.targetSigned <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedTargetSigned_le_theta

theorem unitThetaToy_source_theorem311_audited_membership_middle_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311AuditedMembershipMiddle package bundle :=
  IUTStage1Theorem311AuditedMembershipMiddle.ofStructuredInputsWithSHE
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_audited_membership_q_charted_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedQCharted

theorem unitThetaToy_source_theorem311_audited_membership_chosen_holds_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chosenOutput.comparison.Holds
      package.preLedger.qValue.qPoint :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedChosenHolds

theorem unitThetaToy_source_theorem311_audited_membership_q_le_target_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.qSigned <=
      package.preLedger.targetVolume.targetSigned :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedQSigned_le_targetSigned

theorem unitThetaToy_source_theorem311_audited_raw_inequality_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311AuditedRawInequality package bundle :=
  IUTStage1Theorem311AuditedRawInequality.ofStructuredInputsWithSHE
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_audited_raw_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.qSigned <= package.preLedger.thetaSigned :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedRaw_qSigned_le_thetaSigned

theorem unitThetaToy_source_theorem311_audited_raw_explicit_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedRaw_qSigned_le_thetaSigned

theorem unitThetaToy_source_theorem311_structured_she_component_eq_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    inputs.sheAlignment =
      inputs.theorem311Subclaims.sheAlignment :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).sheAlignment_eq_subclaims

theorem unitThetaToy_source_theorem311_structured_components_rebuild_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311Subclaims.ofComponents
      inputs.algorithmicOutput inputs.sheAlignment =
      inputs.theorem311Subclaims :=
  (unitThetaToy_source_theorem311_structured_inputs_example
    measure hnormalized hh hbound hholds).components_rebuild_subclaims

theorem unitThetaToy_source_gap_qPilot_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).qPilotPositive

theorem unitThetaToy_source_gap_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).sourceNormalization

theorem unitThetaToy_source_side_conditions_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditions
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).sideConditions

theorem unitThetaToy_source_side_conditions_qPilot_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_side_conditions_example
    measure hnormalized hh hbound hholds).qPilotPositive

theorem unitThetaToy_source_side_conditions_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToy_source_side_conditions_example
    measure hnormalized hh hbound hholds).sourceNormalization

theorem unitThetaToy_source_theorem311_audited_signed_payload_boundary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311AuditedSignedPayloadBoundary
      package bundle sideConditions :=
  IUTStage1Theorem311AuditedSignedPayloadBoundary.ofStructuredInputsWithSideConditions
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

def unitThetaToy_source_theorem311_audited_comparison_data_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    Corollary312ComparisonData :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedComparisonData
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_audited_comparison_data_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToy_source_theorem311_audited_comparison_data_example
      measure hnormalized hh hbound hholds).qSigned <=
      (unitThetaToy_source_theorem311_audited_comparison_data_example
        measure hnormalized hh hbound hholds).thetaSigned :=
  (unitThetaToy_source_theorem311_structured_inputs_with_she_example
    measure hnormalized hh hbound hholds).auditedComparisonData_qSigned_le_thetaSigned
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_audited_payload_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToy_source_theorem311_audited_signed_payload_boundary_example
    measure hnormalized hh hbound hholds).sourceNormalization

theorem unitThetaToy_source_theorem311_audited_payload_q_charted_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned :=
  (unitThetaToy_source_theorem311_audited_signed_payload_boundary_example
    measure hnormalized hh hbound hholds).qCharted

theorem unitThetaToy_source_theorem311_audited_payload_theta_charted_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned :=
  (unitThetaToy_source_theorem311_audited_signed_payload_boundary_example
    measure hnormalized hh hbound hholds).thetaCharted

theorem unitThetaToy_source_theorem311_audited_comparison_data_eq_payload_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    bundle.auditedComparisonData sideConditions =
      package.comparisonDataFromPayloadInputs
        (package.auditedComparisonSourceObligations
          bundle sideConditions) :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedComparisonData_eq_payloadInputs
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_audited_stage_comparison_eq_payload_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    (bundle.auditedComparisonData sideConditions).stage1Comparison =
      (package.comparisonDataFromPayloadInputs
        (package.auditedComparisonSourceObligations
          bundle sideConditions)).stage1Comparison :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedComparisonData_stage1Comparison_eq_payloadInputs
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_audited_public_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedPublicAudit package bundle sideConditions :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedPublicAudit
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_audited_public_audit_tuple_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    (bundle.auditedComparisonData sideConditions).qSigned <=
        (bundle.auditedComparisonData sideConditions).thetaSigned ∧
      Corollary312Inequality
        (bundle.auditedComparisonData sideConditions).thetaPilot
        (bundle.auditedComparisonData sideConditions).qPilot ∧
      corollary312_from_stage1_comparison
          (bundle.auditedComparisonData sideConditions).stage1Comparison =
        corollary312_of_signed_le
          (bundle.auditedComparisonData
            sideConditions).qSigned_le_thetaSigned :=
  (unitThetaToy_source_theorem311_audited_public_audit_example
    measure hnormalized hh hbound hholds).publicAudit

theorem unitThetaToy_source_theorem311_audited_public_audit_route_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    bundle.auditedComparisonData sideConditions =
      package.comparisonDataFromPayloadInputs
        (package.auditedComparisonSourceObligations
          bundle sideConditions) :=
  (unitThetaToy_source_theorem311_audited_public_audit_example
    measure hnormalized hh hbound hholds).comparisonDataEqPayloadInputs

theorem unitThetaToy_source_theorem311_audited_public_audit_q_charted_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord = package.preLedger.qSigned :=
  (unitThetaToy_source_theorem311_audited_public_audit_example
    measure hnormalized hh hbound hholds).qCharted

theorem unitThetaToy_source_theorem311_audited_public_audit_theta_charted_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
      package.preLedger.thetaBound.thetaPoint).coord =
      package.preLedger.thetaSigned :=
  (unitThetaToy_source_theorem311_audited_public_audit_example
    measure hnormalized hh hbound hholds).thetaCharted

theorem unitThetaToy_source_theorem311_audited_public_audit_history_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  (unitThetaToy_source_theorem311_audited_public_audit_example
    measure hnormalized hh hbound hholds).domainHistory_ne_codomainHistory

theorem unitThetaToy_source_theorem311_chart_history_discipline_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedChartHistoryDiscipline
      package bundle sideConditions :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedChartHistoryDiscipline
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_chart_history_discipline_history_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  (unitThetaToy_source_theorem311_chart_history_discipline_example
    measure hnormalized hh hbound hholds).domainHistory_ne_codomainHistory

theorem unitThetaToy_source_theorem311_allowed_chart_transport_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedAllowedChartTransport
      package bundle sideConditions :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedAllowedChartTransport
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_allowed_chart_transport_forbids_history_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  (unitThetaToy_source_theorem311_allowed_chart_transport_example
    measure hnormalized hh hbound hholds).forbiddenHistoryIdentification

theorem unitThetaToy_source_theorem311_allowed_chart_transport_chart_discipline_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.chart.TransportDiscipline :=
  (unitThetaToy_source_theorem311_allowed_chart_transport_example
    measure hnormalized hh hbound hholds).chartTransportDiscipline

theorem unitThetaToy_source_theorem311_q_pilot_chart_sign_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedQPilotChartSign
      package bundle sideConditions :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedQPilotChartSign
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_q_pilot_charted_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    0 < -
      (Transport.map package.preLedger.chartedContainer.chart.qToTarget
        package.preLedger.qValue.qPoint).coord :=
  (unitThetaToy_source_theorem311_q_pilot_chart_sign_example
    measure hnormalized hh hbound hholds).chartedQPilotPositive

theorem unitThetaToy_source_theorem311_theta_chart_bound_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedThetaChartBound
      package bundle sideConditions :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedThetaChartBound
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_target_volume_le_charted_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
        package.preLedger.thetaBound.thetaPoint).coord :=
  (unitThetaToy_source_theorem311_theta_chart_bound_example
    measure hnormalized hh hbound hholds).chosenTargetVolume_le_chartedTheta

theorem unitThetaToy_source_theorem311_charted_comparison_boundary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedChartedComparisonBoundary
      package bundle sideConditions :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedChartedComparisonBoundary
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_charted_q_le_charted_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord <=
      (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
        package.preLedger.thetaBound.thetaPoint).coord :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).chartedQ_le_chartedTheta

theorem unitThetaToy_source_theorem311_charted_boundary_preledger_chain_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.ChartedComparisonChain :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).preLedgerChartedChain

theorem unitThetaToy_source_theorem311_charted_boundary_transport_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.chart.qToTarget =
      package.preLedger.chosenOutput.comparison.transport :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).qChartTransport_eq_comparisonTransport

theorem unitThetaToy_source_theorem311_charted_boundary_volume_control_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chosenOutput.comparison.MembershipControlsTargetVolume
      package.preLedger.measure :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).membershipVolumeControl

theorem unitThetaToy_source_theorem311_charted_boundary_target_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.targetVolume.targetSigned =
      RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).targetSigned_eq_choiceTargetVolume

theorem unitThetaToy_source_theorem311_charted_boundary_choice_volume_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      package.preLedger.thetaSigned :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).choiceTargetVolume_le_thetaSigned

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_she_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311AuditedHDDSHEBound package bundle :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHEBound

theorem unitThetaToy_source_theorem311_charted_boundary_common_container_bound_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.BoundAudit
      package.preLedger.certificate :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHECommonContainerBoundAudit

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_she_decomposition_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.DecompositionAudit
      package.preLedger.certificate :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHEDecompositionAudit

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_decomposition_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.hdd.DecompositionAudit
      package.preLedger.certificate :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddDecompositionAudit

theorem unitThetaToy_source_theorem311_charted_boundary_hull_det_bound_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge.BoundAudit
      package.preLedger.certificate :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hullDetBoundAudit

theorem unitThetaToy_source_theorem311_charted_boundary_hull_det_common_target_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.output.comparisons.CommonTarget
      (package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge.apply
        package.preLedger.certificate).common :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hullDetBoundAudit.commonTargetContainsEach

theorem unitThetaToy_source_theorem311_charted_boundary_hull_det_common_volume_bound_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge.apply
        package.preLedger.certificate).common package.preLedger.thetaSigned :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hullDetBoundAudit.commonTargetVolumeBound

theorem unitThetaToy_source_theorem311_charted_boundary_hull_det_choice_region_atMost_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    RegionMeasure.HasVolumeAtMost package.preLedger.measure
      (package.preLedger.output.comparison package.preLedger.chosenOutput.choice).targetRegion
      package.preLedger.thetaSigned :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hullDetBoundAudit.choiceRegionAtMost
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).preLedger.chosenOutput.choice

theorem unitThetaToy_source_theorem311_charted_boundary_hull_det_holds_common_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (RegionComparison.enlargeTarget
      (package.preLedger.output.comparison package.preLedger.chosenOutput.choice)
      (package.preLedger.chartedContainer.commonContainer.hddShe.hdd.hullDetBridge.apply
        package.preLedger.certificate).common).Holds package.preLedger.qValue.qPoint :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hullDetBoundAudit.holdsCommonTarget
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).preLedger.chosenComparisonHoldsQ

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_she_local_valid_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    bundle.structuredSHE.context.simultaneousExpression.AllLocalValid :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHELocalExpressionValid

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_she_arrow_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      bundle.structuredSHE.context.sheDatum :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHESHEArrowMatchesContext

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_she_arrow_certificate_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHESHEArrowDatumMatchesCertificate

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_she_common_context_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.context =
      bundle.structuredSHE.context.sharedContext :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHECommonContainerContextMatches

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_she_q_pilot_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    bundle.structuredSHE.context.qPilotStructure.theater =
      bundle.structuredSHE.context.codomainStructure.theater :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHEQPilotTheater_eq_codomain

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_she_target_bound_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    RegionMeasure.targetVolume package.preLedger.measure
        (package.preLedger.output.comparison
          package.preLedger.chosenOutput.choice) <=
      package.preLedger.thetaSigned :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHEChosenTargetVolume_le_theta

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_she_all_targets_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    RegionComparisonFamily.AllTargetsAtMost package.preLedger.measure
      package.preLedger.output.comparisons package.preLedger.thetaSigned :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHEAllTargetsAtMost_theta

theorem unitThetaToy_source_theorem311_charted_boundary_hdd_she_history_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  (unitThetaToy_source_theorem311_charted_comparison_boundary_example
    measure hnormalized hh hbound hholds).hddSHEDomainHistory_ne_codomainHistory

theorem unitThetaToy_source_theorem311_audited_route_summary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedStructuredSHERouteSummary
      package bundle sideConditions :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedStructuredSHERouteSummary
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_audited_route_summary_raw_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311AuditedRawInequality package bundle :=
  (unitThetaToy_source_theorem311_audited_route_summary_example
    measure hnormalized hh hbound hholds).rawInequality

theorem unitThetaToy_source_theorem311_audited_route_summary_public_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedPublicAudit
      package bundle sideConditions :=
  (unitThetaToy_source_theorem311_audited_route_summary_example
    measure hnormalized hh hbound hholds).publicAudit

theorem unitThetaToy_source_theorem311_audited_route_summary_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    (bundle.auditedComparisonData sideConditions).qSigned <=
      (bundle.auditedComparisonData sideConditions).thetaSigned :=
  (unitThetaToy_source_theorem311_audited_route_summary_example
    measure hnormalized hh hbound hholds).qSigned_le_thetaSigned

theorem unitThetaToy_source_theorem311_audited_route_summary_charted_boundary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedChartedComparisonBoundary
      package bundle sideConditions :=
  (unitThetaToy_source_theorem311_audited_route_summary_example
    measure hnormalized hh hbound hholds).chartedComparisonBoundary

theorem unitThetaToy_source_theorem311_audited_route_summary_charted_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord <=
      (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
        package.preLedger.thetaBound.thetaPoint).coord :=
  (unitThetaToy_source_theorem311_audited_route_summary_example
    measure hnormalized hh hbound hholds).chartedQ_le_chartedTheta

theorem unitThetaToy_source_theorem311_transition_checkpoints_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedTheorem311ToCorollary312Checkpoints
      package bundle sideConditions :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedTheorem311ToCorollary312Checkpoints
    (unitThetaToy_source_theorem311_structured_inputs_with_she_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_theorem311_transition_checkpoints_input_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.input = package.labels.input :=
  (unitThetaToy_source_theorem311_transition_checkpoints_example
    measure hnormalized hh hbound hholds).theorem311InputLabel

theorem unitThetaToy_source_theorem311_transition_checkpoints_hdd_she_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311AuditedHDDSHEBound package bundle :=
  (unitThetaToy_source_theorem311_transition_checkpoints_example
    measure hnormalized hh hbound hholds).fourthTriangleHDDSHE

theorem unitThetaToy_source_theorem311_transition_checkpoints_common_container_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    IUTStage1Theorem311StructuredSHECommonContainerCompatibility
      package bundle.structuredSHE :=
  (unitThetaToy_source_theorem311_transition_checkpoints_example
    measure hnormalized hh hbound hholds).simultaneousCommonContainer

theorem unitThetaToy_source_theorem311_transition_checkpoints_charted_boundary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.AuditedChartedComparisonBoundary
      package bundle sideConditions :=
  (unitThetaToy_source_theorem311_transition_checkpoints_example
    measure hnormalized hh hbound hholds).chartedComparisonBoundary

theorem unitThetaToy_source_theorem311_transition_checkpoints_charted_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord <=
      (Transport.map package.preLedger.chartedContainer.chart.thetaToTarget
        package.preLedger.thetaBound.thetaPoint).coord :=
  (unitThetaToy_source_theorem311_transition_checkpoints_example
    measure hnormalized hh hbound hholds).chartedQ_le_chartedTheta

theorem unitThetaToy_source_theorem311_transition_checkpoints_history_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let bundle :=
      unitThetaToy_source_theorem311_structured_inputs_with_she_example
        measure hnormalized hh hbound hholds
    bundle.structuredSHE.context.domainStructure.theater.side ≠
      bundle.structuredSHE.context.codomainStructure.theater.side :=
  (unitThetaToy_source_theorem311_transition_checkpoints_example
    measure hnormalized hh hbound hholds).domainHistory_ne_codomainHistory

theorem unitThetaToy_source_side_condition_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditionHypotheses
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).sideConditionHypotheses

theorem unitThetaToy_source_side_condition_hypotheses_qPilot_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_side_condition_hypotheses_example
    measure hnormalized hh hbound hholds).qPilotLogVolumePositive

theorem unitThetaToy_source_side_condition_hypotheses_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToy_source_side_condition_hypotheses_example
    measure hnormalized hh hbound hholds).sourceNormalized

theorem unitThetaToy_source_side_condition_hypotheses_to_side_conditions_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds).toSideConditions =
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds :=
  IUTStage1SourceSideConditionHypotheses.toSideConditions_ofSideConditions
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_side_condition_hypotheses_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditionHypotheses.Audit
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_side_condition_hypotheses_example
    measure hnormalized hh hbound hholds).audit

theorem unitThetaToy_source_side_condition_hypotheses_audit_q_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilotLogVolume =
      unitThetaToyIUTStage1SourceLabels.qPilotLogVolume :=
  (unitThetaToy_source_side_condition_hypotheses_audit_example
    measure hnormalized hh hbound hholds).qPilotLogVolumeMatchesLabels

theorem unitThetaToy_source_side_condition_hypotheses_audit_normalization_label_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).sourceNormalizationLabel =
      unitThetaToyIUTStage1SourceLabels.sourceNormalization :=
  (unitThetaToy_source_side_condition_hypotheses_audit_example
    measure hnormalized hh hbound hholds).sourceNormalizationMatchesLabels

theorem unitThetaToy_source_side_condition_hypotheses_audit_q_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_side_condition_hypotheses_audit_example
    measure hnormalized hh hbound hholds).qPilotLogVolumePositive

theorem unitThetaToy_source_side_condition_hypotheses_audit_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToy_source_side_condition_hypotheses_audit_example
    measure hnormalized hh hbound hholds).sourceNormalized

theorem unitThetaToy_source_obligations_from_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations.ofSubclaimsAndSideConditions
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds) =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds := by
  calc
    IUTStage1SourceObligations.ofSubclaimsAndSideConditions
        (unitThetaToy_source_theorem311_subclaims_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_conditions_example
          measure hnormalized hh hbound hholds) =
        (unitThetaToyIUTStage1SourceObligationGap
          measure hnormalized hh hbound hholds).toSourceObligations :=
      (IUTStage1SourceObligationGap.toSourceObligations_eq_subclaimsAndSideConditions
          (unitThetaToyIUTStage1SourceObligationGap
            measure hnormalized hh hbound hholds)).symm
    _ = unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds :=
      unitThetaToy_source_gap_to_obligations_example
        measure hnormalized hh hbound hholds

theorem unitThetaToy_source_obligations_from_structured_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations.ofStructuredInputsAndSideConditions
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds) =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds := by
  calc
    IUTStage1SourceObligations.ofStructuredInputsAndSideConditions
        (unitThetaToy_source_theorem311_structured_inputs_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_conditions_example
          measure hnormalized hh hbound hholds) =
        IUTStage1SourceObligations.ofSubclaimsAndSideConditions
          (unitThetaToy_source_theorem311_structured_inputs_example
            measure hnormalized hh hbound hholds).theorem311Subclaims
          (unitThetaToy_source_side_conditions_example
            measure hnormalized hh hbound hholds) :=
      IUTStage1SourceObligations.ofStructuredInputsAndSideConditions_eq_subclaims
        (unitThetaToy_source_theorem311_structured_inputs_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_conditions_example
          measure hnormalized hh hbound hholds)
    _ = IUTStage1SourceObligations.ofSubclaimsAndSideConditions
          (unitThetaToy_source_theorem311_subclaims_example
            measure hnormalized hh hbound hholds)
          (unitThetaToy_source_side_conditions_example
            measure hnormalized hh hbound hholds) := by
      rw [unitThetaToy_source_theorem311_structured_subclaims_example]
    _ = unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds :=
      unitThetaToy_source_obligations_from_parts_example
        measure hnormalized hh hbound hholds

theorem unitThetaToy_source_obligations_from_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds) =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds := by
  calc
    IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses
        (unitThetaToy_source_theorem311_subclaims_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_condition_hypotheses_example
          measure hnormalized hh hbound hholds) =
        IUTStage1SourceObligations.ofSubclaimsAndSideConditions
          (unitThetaToy_source_theorem311_subclaims_example
            measure hnormalized hh hbound hholds)
          ((unitThetaToy_source_side_condition_hypotheses_example
            measure hnormalized hh hbound hholds).toSideConditions) :=
      IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses_eq_sideConditions
          (unitThetaToy_source_theorem311_subclaims_example
            measure hnormalized hh hbound hholds)
          (unitThetaToy_source_side_condition_hypotheses_example
            measure hnormalized hh hbound hholds)
    _ = IUTStage1SourceObligations.ofSubclaimsAndSideConditions
          (unitThetaToy_source_theorem311_subclaims_example
            measure hnormalized hh hbound hholds)
          (unitThetaToy_source_side_conditions_example
            measure hnormalized hh hbound hholds) := by
      rw [unitThetaToy_source_side_condition_hypotheses_to_side_conditions_example]
    _ = unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds :=
      unitThetaToy_source_obligations_from_parts_example
        measure hnormalized hh hbound hholds

theorem unitThetaToy_source_obligations_from_structured_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations.ofStructuredInputsAndSideConditionHypotheses
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds) =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds := by
  calc
    IUTStage1SourceObligations.ofStructuredInputsAndSideConditionHypotheses
        (unitThetaToy_source_theorem311_structured_inputs_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_condition_hypotheses_example
          measure hnormalized hh hbound hholds) =
        IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses
          (unitThetaToy_source_theorem311_structured_inputs_example
            measure hnormalized hh hbound hholds).theorem311Subclaims
          (unitThetaToy_source_side_condition_hypotheses_example
            measure hnormalized hh hbound hholds) :=
      IUTStage1SourceObligations.ofStructuredInputsAndSideConditionHypotheses_eq_subclaims
        (unitThetaToy_source_theorem311_structured_inputs_example
          measure hnormalized hh hbound hholds)
        (unitThetaToy_source_side_condition_hypotheses_example
          measure hnormalized hh hbound hholds)
    _ = IUTStage1SourceObligations.ofSubclaimsAndSideConditionHypotheses
          (unitThetaToy_source_theorem311_subclaims_example
            measure hnormalized hh hbound hholds)
          (unitThetaToy_source_side_condition_hypotheses_example
            measure hnormalized hh hbound hholds) := by
      rw [unitThetaToy_source_theorem311_structured_subclaims_example]
    _ = unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds :=
      unitThetaToy_source_obligations_from_hypotheses_example
        measure hnormalized hh hbound hholds

theorem unitThetaToy_source_obligations_from_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.obligationsFromHypotheses subclaims hypotheses =
      package.obligationsFromParts subclaims hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).obligationsFromHypotheses_eq_parts
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_package_obligations_from_structured_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    package.obligationsFromStructuredInputs inputs sideConditions =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds :=
  unitThetaToy_source_obligations_from_structured_inputs_example
    measure hnormalized hh hbound hholds

theorem unitThetaToy_source_package_obligations_from_structured_inputs_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    package.obligationsFromStructuredInputs inputs sideConditions =
      package.obligationsFromParts
        inputs.theorem311Subclaims sideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).obligationsFromStructuredInputs_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_package_obligations_from_structured_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.obligationsFromStructuredHypotheses inputs hypotheses =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds :=
  unitThetaToy_source_obligations_from_structured_hypotheses_example
    measure hnormalized hh hbound hholds

theorem unitThetaToy_source_package_obligations_from_structured_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.obligationsFromStructuredHypotheses inputs hypotheses =
      package.obligationsFromStructuredInputs
        inputs hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).obligationsFromStructuredHypotheses_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_package_obligations_from_structured_hypotheses_eq_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.obligationsFromStructuredHypotheses inputs hypotheses =
      package.obligationsFromHypotheses
        inputs.theorem311Subclaims hypotheses :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).obligationsFromStructuredHypotheses_eq_hypotheses
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_gap_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligationGap.Audit
      (unitThetaToyIUTStage1SourceObligationGap
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourceObligationGap
    measure hnormalized hh hbound hholds).audit

theorem unitThetaToy_source_gap_audit_algorithm_certified_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.output.Certified :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).theorem311AlgorithmCertified

theorem unitThetaToy_source_gap_audit_she_alignment_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.chartedContainer.commonContainer.hddShe.sheArrow.datum =
      package.preLedger.certificate.she :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).sheAlignment

theorem unitThetaToy_source_gap_audit_theorem311_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311Subclaims
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).theorem311Subclaims

theorem unitThetaToy_source_gap_audit_theorem311_structured_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1Theorem311StructuredInputs
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).theorem311StructuredInputs

theorem unitThetaToy_source_gap_audit_theorem311_structured_subclaims_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToy_source_gap_audit_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds).theorem311Subclaims =
      unitThetaToy_source_gap_audit_theorem311_subclaims_example
        measure hnormalized hh hbound hholds :=
  IUTStage1SourceObligationGap.Audit.theorem311StructuredInputs_subclaims
    (unitThetaToy_source_gap_audit_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_gap_audit_qPilot_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).qPilotPositive

theorem unitThetaToy_source_gap_audit_normalization_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.normalization :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).sourceNormalization

theorem unitThetaToy_source_gap_audit_side_conditions_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditions
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_gap_audit_example
    measure hnormalized hh hbound hholds).sideConditions

theorem unitThetaToy_source_gap_audit_obligations_from_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceObligations.ofSubclaimsAndSideConditions
      (unitThetaToy_source_gap_audit_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_gap_audit_side_conditions_example
        measure hnormalized hh hbound hholds) =
      (unitThetaToy_source_gap_audit_example
        measure hnormalized hh hbound hholds).toSourceObligations :=
  (IUTStage1SourceObligationGap.Audit.toSourceObligations_eq_subclaimsAndSideConditions
      (unitThetaToy_source_gap_audit_example
        measure hnormalized hh hbound hholds)).symm

theorem unitThetaToy_source_gap_audit_to_obligations_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToy_source_gap_audit_example
      measure hnormalized hh hbound hholds).toSourceObligations =
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds := by
  calc
    (unitThetaToy_source_gap_audit_example
        measure hnormalized hh hbound hholds).toSourceObligations =
        (unitThetaToyIUTStage1SourceObligationGap
          measure hnormalized hh hbound hholds).toSourceObligations :=
      IUTStage1SourceObligationGap.Audit.toSourceObligations_eq_gap
        (unitThetaToy_source_gap_audit_example
          measure hnormalized hh hbound hholds)
    _ = unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds :=
      unitThetaToy_source_gap_to_obligations_example
        measure hnormalized hh hbound hholds

theorem unitThetaToy_source_publicAudit_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAudit_qSigned_le_thetaSigned
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_corollary_example
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
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAudit_corollary312
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_parts_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfParts_qSigned_le_thetaSigned
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_parts_corollary_example
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
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfParts_corollary312
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_hypotheses_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfHypotheses_qSigned_le_thetaSigned
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_hypotheses_corollary_example
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
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfHypotheses_corollary312
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.publicAuditOfHypotheses subclaims hypotheses =
      package.publicAuditOfParts subclaims hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfHypotheses_eq_parts
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_inputs_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  IUTStage1SourcePackage.publicAuditOfStructuredInputs_qSigned_le_thetaSigned
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_inputs_corollary_example
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
  IUTStage1SourcePackage.publicAuditOfStructuredInputs_corollary312
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_inputs_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    package.publicAuditOfStructuredInputs inputs sideConditions =
      package.publicAuditOfParts
        inputs.theorem311Subclaims sideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfStructuredInputs_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_hypotheses_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  IUTStage1SourcePackage.publicAuditOfStructuredHypotheses_qSigned_le_thetaSigned
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_hypotheses_corollary_example
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
  IUTStage1SourcePackage.publicAuditOfStructuredHypotheses_corollary312
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.publicAuditOfStructuredHypotheses inputs hypotheses =
      package.publicAuditOfStructuredInputs
        inputs hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfStructuredHypotheses_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_structured_hypotheses_eq_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.publicAuditOfStructuredHypotheses inputs hypotheses =
      package.publicAuditOfHypotheses
        inputs.theorem311Subclaims hypotheses :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).publicAuditOfStructuredHypotheses_eq_hypotheses
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_publicAudit_from_parts_recovery_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    corollary312_from_stage1_comparison
        (package.promotedProvider
          (package.obligationsFromParts
            subclaims sideConditions)).stage1Comparison =
      corollary312_of_signed_le
        (package.promotedProvider
          (package.obligationsFromParts
            subclaims sideConditions)).ledger.qSigned_le_thetaSigned :=
  IUTStage1SourcePackage.publicAuditOfParts_stage1Comparison_recovers_qSigned_le_thetaSigned
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_stage_recovers_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    corollary312_from_stage1_comparison
      ((unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).promotedProvider
          (unitThetaToyIUTStage1SourceObligations
            measure hnormalized hh hbound hholds)).stage1Comparison =
      ((unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).promotedProvider
          (unitThetaToyIUTStage1SourceObligations
            measure hnormalized hh hbound hholds)).ledger.corollary312 :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).stage1Comparison_recovers_corollary312
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourcePackage.Audit
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).audit
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromParts subclaims sideConditions) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfParts
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromHypotheses subclaims hypotheses) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfHypotheses
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_structured_inputs_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromStructuredInputs inputs sideConditions) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfStructuredInputs
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_structured_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfStructuredHypotheses
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_hypothesis_route_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.HypothesisRouteAudit
      package subclaims hypotheses :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).hypothesisRouteAudit
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypothesis_route_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.StructuredHypothesisRouteAudit
      package inputs hypotheses :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).structuredHypothesisRouteAudit
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypothesis_route_side_condition_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditionHypotheses.Audit
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_structured_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).sideConditionAudit

theorem unitThetaToy_source_structured_hypothesis_route_source_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  (unitThetaToy_source_structured_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).sourceAudit

theorem unitThetaToy_source_hypothesis_route_side_condition_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourceSideConditionHypotheses.Audit
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).sideConditionAudit

theorem unitThetaToy_source_hypothesis_route_source_audit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.Audit package
      (package.obligationsFromHypotheses subclaims hypotheses) :=
  (unitThetaToy_source_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).sourceAudit

theorem unitThetaToy_source_hypothesis_route_side_condition_audit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.hypothesisRouteAudit subclaims hypotheses).sideConditionAudit =
      package.sideConditionAuditOfHypotheses hypotheses :=
  IUTStage1SourcePackage.hypothesisRouteAudit_sideConditionAudit_eq
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_subclaims_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_hypothesis_route_source_audit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.hypothesisRouteAudit subclaims hypotheses).sourceAudit =
      package.auditOfHypotheses subclaims hypotheses :=
  IUTStage1SourcePackage.hypothesisRouteAudit_sourceAudit_eq
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_subclaims_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypothesis_route_side_condition_audit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.structuredHypothesisRouteAudit
      inputs hypotheses).sideConditionAudit =
      package.sideConditionAuditOfHypotheses hypotheses :=
  IUTStage1SourcePackage.structuredHypothesisRouteAudit_sideConditionAudit_eq
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypothesis_route_source_audit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.structuredHypothesisRouteAudit inputs hypotheses).sourceAudit =
      package.auditOfStructuredHypotheses inputs hypotheses :=
  IUTStage1SourcePackage.structuredHypothesisRouteAudit_sourceAudit_eq
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypothesis_route_source_audit_eq_hypothesis_route_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.structuredHypothesisRouteAudit inputs hypotheses).sourceAudit =
      (package.hypothesisRouteAudit
        inputs.theorem311Subclaims hypotheses).sourceAudit :=
  IUTStage1SourcePackage.structuredHypothesisRouteAudit_sourceAudit_eq_hypothesisRoute
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds)
    (unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_hypothesis_route_q_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).qPilotLogVolumePositive

theorem unitThetaToy_source_structured_hypothesis_route_q_positive_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    0 < - (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).preLedger.qSigned :=
  (unitThetaToy_source_structured_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).qPilotLogVolumePositive

theorem unitThetaToy_source_hypothesis_route_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_structured_hypothesis_route_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_structured_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_from_hypotheses_q_le_theta_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_audit_from_hypotheses_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_from_structured_inputs_q_le_theta_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_audit_from_structured_inputs_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_from_structured_hypotheses_q_le_theta_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_audit_from_structured_hypotheses_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_from_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditOfHypotheses subclaims hypotheses =
      package.auditOfParts subclaims hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfHypotheses_eq_parts
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_structured_inputs_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    package.auditOfStructuredInputs inputs sideConditions =
      package.auditOfParts
        inputs.theorem311Subclaims sideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfStructuredInputs_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_structured_hypotheses_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditOfStructuredHypotheses inputs hypotheses =
      package.auditOfStructuredInputs inputs hypotheses.toSideConditions :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfStructuredHypotheses_eq_parts
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_structured_hypotheses_eq_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditOfStructuredHypotheses inputs hypotheses =
      package.auditOfHypotheses inputs.theorem311Subclaims hypotheses :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditOfStructuredHypotheses_eq_hypotheses
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_audit_from_hypotheses_corollary_projection_example
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
  (unitThetaToy_source_audit_from_hypotheses_example
    measure hnormalized hh hbound hholds).corollary312Endpoint

theorem unitThetaToy_source_audit_from_hypotheses_recovery_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    corollary312_from_stage1_comparison
        (package.promotedProvider
          (package.obligationsFromHypotheses
            subclaims hypotheses)).stage1Comparison =
      (package.promotedProvider
        (package.obligationsFromHypotheses
          subclaims hypotheses)).ledger.corollary312 :=
  (unitThetaToy_source_audit_from_hypotheses_example
    measure hnormalized hh hbound hholds).stageRecoversCorollary312

theorem unitThetaToy_source_audit_from_hypotheses_thetaPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).thetaPilot =
      unitThetaToyIUTStage1SourceLabels.thetaPilot :=
  (unitThetaToy_source_audit_from_hypotheses_example
    measure hnormalized hh hbound hholds).thetaPilotMatchesLabels

theorem unitThetaToy_source_audit_from_hypotheses_qPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilot =
      unitThetaToyIUTStage1SourceLabels.qPilot :=
  (unitThetaToy_source_audit_from_hypotheses_example
    measure hnormalized hh hbound hholds).qPilotMatchesLabels

theorem unitThetaToy_source_audit_from_parts_q_le_theta_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_audit_from_parts_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_from_parts_corollary_projection_example
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
  (unitThetaToy_source_audit_from_parts_example
    measure hnormalized hh hbound hholds).corollary312Endpoint

theorem unitThetaToy_source_audit_from_parts_recovery_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    corollary312_from_stage1_comparison
        (package.promotedProvider
          (package.obligationsFromParts
            subclaims sideConditions)).stage1Comparison =
      (package.promotedProvider
        (package.obligationsFromParts
          subclaims sideConditions)).ledger.corollary312 :=
  (unitThetaToy_source_audit_from_parts_example
    measure hnormalized hh hbound hholds).stageRecoversCorollary312

theorem unitThetaToy_source_audit_from_parts_thetaPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).thetaPilot =
      unitThetaToyIUTStage1SourceLabels.thetaPilot :=
  (unitThetaToy_source_audit_from_parts_example
    measure hnormalized hh hbound hholds).thetaPilotMatchesLabels

theorem unitThetaToy_source_audit_from_parts_qPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilot =
      unitThetaToyIUTStage1SourceLabels.qPilot :=
  (unitThetaToy_source_audit_from_parts_example
    measure hnormalized hh hbound hholds).qPilotMatchesLabels

theorem unitThetaToy_source_audit_q_le_theta_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).qSignedLeThetaSigned

theorem unitThetaToy_source_audit_comparisonPayloadInputs_eq_package_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (unitThetaToy_source_audit_example
      measure hnormalized hh hbound hholds).comparisonPayloadInputs =
      package.comparisonPayloadInputs :=
  let sourceAudit :=
    unitThetaToy_source_audit_example
      measure hnormalized hh hbound hholds
  sourceAudit.comparisonPayloadInputsEqPackage

theorem unitThetaToy_source_audit_comparisonPayloadInputs_eq_preLedgerAudit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (unitThetaToy_source_audit_example
      measure hnormalized hh hbound hholds).comparisonPayloadInputs =
      package.preLedger.audit.comparisonPayloadInputs :=
  let sourceAudit :=
    unitThetaToy_source_audit_example
      measure hnormalized hh hbound hholds
  sourceAudit.comparisonPayloadInputsEqPreLedgerAudit

theorem unitThetaToy_source_audit_payloadData_eq_comparisonData_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    package.comparisonDataFromPayloadInputs obligations =
      (unitThetaToy_source_audit_example
        measure hnormalized hh hbound hholds).comparisonData :=
  let sourceAudit :=
    unitThetaToy_source_audit_example
      measure hnormalized hh hbound hholds
  sourceAudit.comparisonDataFromPayloadInputsEqComparisonData

theorem unitThetaToy_source_audit_payloadStage_eq_comparisonStage_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    (package.comparisonDataFromPayloadInputs obligations).stage1Comparison =
      (unitThetaToy_source_audit_example
        measure hnormalized hh hbound hholds).comparisonData.stage1Comparison :=
  let sourceAudit :=
    unitThetaToy_source_audit_example
      measure hnormalized hh hbound hholds
  sourceAudit.comparisonDataFromPayloadInputsStage1ComparisonEq

theorem unitThetaToy_source_audit_payloadRouteSummary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    IUTStage1SourcePackage.Audit.PayloadRouteSummary
      (unitThetaToy_source_audit_example
        measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).payloadRouteSummary

theorem unitThetaToy_source_audit_payloadRouteSummary_stage_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    (unitThetaToy_source_audit_example
      measure hnormalized hh hbound hholds).comparisonData.stage1Comparison =
      (package.promotedProvider obligations).stage1Comparison :=
  let summary :=
    (unitThetaToy_source_audit_example
      measure hnormalized hh hbound hholds).payloadRouteSummary
  summary.stage1Comparison_eq_provider

theorem unitThetaToy_source_audit_corollary_projection_example
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
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).corollary312Endpoint

theorem unitThetaToy_source_audit_recovery_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    corollary312_from_stage1_comparison
      ((unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).promotedProvider
          (unitThetaToyIUTStage1SourceObligations
            measure hnormalized hh hbound hholds)).stage1Comparison =
      ((unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).promotedProvider
          (unitThetaToyIUTStage1SourceObligations
            measure hnormalized hh hbound hholds)).ledger.corollary312 :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).stageRecoversCorollary312

theorem unitThetaToy_source_audit_thetaPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).thetaPilot =
      unitThetaToyIUTStage1SourceLabels.thetaPilot :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).thetaPilotMatchesLabels

theorem unitThetaToy_source_audit_qPilot_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilot =
      unitThetaToyIUTStage1SourceLabels.qPilot :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).qPilotMatchesLabels

theorem unitThetaToy_source_audit_logKummer_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).logKummer =
      unitThetaToyIUTStage1SourceLabels.logKummer :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).logKummerMatchesLabels

theorem unitThetaToy_source_audit_indeterminacies_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).indeterminacies =
      unitThetaToyIUTStage1SourceLabels.indeterminacies :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).indeterminaciesMatchesLabels

theorem unitThetaToy_source_audit_qPilotLogVolume_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).qPilotLogVolume =
      unitThetaToyIUTStage1SourceLabels.qPilotLogVolume :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).qPilotLogVolumeMatchesLabels

theorem unitThetaToy_source_audit_sourceNormalization_label_projection_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds).sourceNormalizationLabel =
      unitThetaToyIUTStage1SourceLabels.sourceNormalization :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).sourceNormalizationMatchesLabels

theorem unitThetaToy_source_audit_publicAudit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (⟨(unitThetaToy_source_audit_example
          measure hnormalized hh hbound hholds).qSignedLeThetaSigned,
        (unitThetaToy_source_audit_example
          measure hnormalized hh hbound hholds).corollary312Endpoint,
        (unitThetaToy_source_audit_example
          measure hnormalized hh hbound hholds).stageRecoversQSignedLeThetaSigned⟩ :
      (Transport.map unitQToTheta (qAssignment h)).coord <=
          -(2 * h) + epsilonBound ∧
        Corollary312Inequality
          (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
          (signedPilotLogVolume PilotSide.q
            (Transport.map unitQToTheta (qAssignment h)).coord) ∧
        (corollary312_from_stage1_comparison
            ((unitThetaToyIUTStage1SourcePackage
              measure hnormalized hh hbound hholds).promotedProvider
                (unitThetaToyIUTStage1SourceObligations
                  measure hnormalized hh hbound hholds)).stage1Comparison =
          corollary312_of_signed_le
            ((unitThetaToyIUTStage1SourcePackage
              measure hnormalized hh hbound hholds).promotedProvider
                (unitThetaToyIUTStage1SourceObligations
                  measure hnormalized hh hbound hholds)).ledger.qSigned_le_thetaSigned)) =
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds).publicAudit
        (unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds) :=
  (unitThetaToy_source_audit_example
    measure hnormalized hh hbound hholds).publicAuditEq

theorem unitThetaToy_source_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    ∃ sourceAudit : IUTStage1SourcePackage.Audit
        (unitThetaToyIUTStage1SourcePackage
          measure hnormalized hh hbound hholds)
        (unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds),
      (⟨sourceAudit.qSignedLeThetaSigned,
          sourceAudit.corollary312Endpoint,
          sourceAudit.stageRecoversQSignedLeThetaSigned⟩ :
        (Transport.map unitQToTheta (qAssignment h)).coord <=
            -(2 * h) + epsilonBound ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta (-(2 * h) + epsilonBound))
            (signedPilotLogVolume PilotSide.q
              (Transport.map unitQToTheta (qAssignment h)).coord) ∧
          (corollary312_from_stage1_comparison
              ((unitThetaToyIUTStage1SourcePackage
                measure hnormalized hh hbound hholds).promotedProvider
                  (unitThetaToyIUTStage1SourceObligations
                    measure hnormalized hh hbound hholds)).stage1Comparison =
            corollary312_of_signed_le
              ((unitThetaToyIUTStage1SourcePackage
                measure hnormalized hh hbound hholds).promotedProvider
                  (unitThetaToyIUTStage1SourceObligations
                    measure hnormalized hh hbound hholds)).ledger.qSigned_le_thetaSigned)) =
        (unitThetaToyIUTStage1SourcePackage
          measure hnormalized hh hbound hholds).publicAudit
          (unitThetaToyIUTStage1SourceObligations
            measure hnormalized hh hbound hholds) :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).auditedPublicEndpoint
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_auditedComparisonDataEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.ComparisonDataEndpoint
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds) :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.auditedComparisonDataEndpoint
    (unitThetaToyIUTStage1SourceObligations
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_endpoint_payloadRouteSummary_exists_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    ∃ sourceAudit : IUTStage1SourcePackage.Audit package obligations,
      IUTStage1SourcePackage.Audit.PayloadRouteSummary sourceAudit :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let endpoint :=
    package.auditedComparisonDataEndpoint
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)
  endpoint.payloadRouteSummaryExists

theorem unitThetaToy_source_endpoint_payloadRouteSummary_publicAudit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    let endpoint :=
      package.auditedComparisonDataEndpoint obligations
    ∃ sourceAudit : IUTStage1SourcePackage.Audit package obligations,
      IUTStage1SourcePackage.Audit.PayloadRouteSummary sourceAudit ∧
        endpoint.publicAudit = package.publicAudit obligations :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let obligations :=
    unitThetaToyIUTStage1SourceObligations
      measure hnormalized hh hbound hholds
  let endpoint :=
    package.auditedComparisonDataEndpoint obligations
  endpoint.payloadRouteSummaryAndPublicAudit

theorem unitThetaToy_source_endpoint_payloadData_eq_comparisonData_exists_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    ∃ sourceAudit : IUTStage1SourcePackage.Audit package obligations,
      package.comparisonDataFromPayloadInputs obligations =
        sourceAudit.comparisonData :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let obligations :=
    unitThetaToyIUTStage1SourceObligations
      measure hnormalized hh hbound hholds
  let endpoint :=
    package.auditedComparisonDataEndpoint obligations
  endpoint.payloadDataEqComparisonDataExists

theorem unitThetaToy_source_endpoint_comparisonData_recovers_exists_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    ∃ sourceAudit : IUTStage1SourcePackage.Audit package obligations,
      corollary312_from_stage1_comparison
          sourceAudit.comparisonData.stage1Comparison =
        corollary312_of_signed_le
          sourceAudit.comparisonData.qSigned_le_thetaSigned :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let obligations :=
    unitThetaToyIUTStage1SourceObligations
      measure hnormalized hh hbound hholds
  let endpoint :=
    package.auditedComparisonDataEndpoint obligations
  endpoint.comparisonDataRecoversExists

theorem unitThetaToy_source_comparisonPayloadInputs_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    (Transport.map unitQToTheta (qAssignment h)).coord <=
      -(2 * h) + epsilonBound :=
  (unitThetaToyIUTStage1SourcePackage
    measure hnormalized hh hbound hholds).comparisonPayloadInputs_qSigned_le_thetaSigned

theorem unitThetaToy_source_comparisonPayloadInputs_qCharted_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (Transport.map package.preLedger.chartedContainer.chart.qToTarget
      package.preLedger.qValue.qPoint).coord =
      package.preLedger.qSigned :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.comparisonPayloadInputs_qCharted

theorem unitThetaToy_source_comparisonPayloadInputs_target_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    package.preLedger.targetVolume.targetSigned <=
      package.preLedger.thetaSigned :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.comparisonPayloadInputs_targetSigned_le_thetaSigned

theorem unitThetaToy_source_comparisonDataFromPayloadInputs_corollary_example
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
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.comparisonDataFromPayloadInputs_corollary312
    (unitThetaToyIUTStage1SourceObligations
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_comparisonDataFromPayloadInputs_eq_comparisonData_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    package.comparisonDataFromPayloadInputs obligations =
      package.comparisonData obligations :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.comparisonDataFromPayloadInputs_eq_comparisonData
    (unitThetaToyIUTStage1SourceObligations
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_comparisonDataFromPayloadInputs_stage_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    (package.comparisonDataFromPayloadInputs obligations).stage1Comparison =
      (package.comparisonData obligations).stage1Comparison :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  package.comparisonDataFromPayloadInputs_stage1Comparison_eq
    (unitThetaToyIUTStage1SourceObligations
      measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_comparisonDataEndpoint_q_le_theta_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    (package.comparisonData
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)).qSigned <=
      (package.comparisonData
        (unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds)).thetaSigned :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let endpoint :=
    package.auditedComparisonDataEndpoint
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)
  endpoint.qSignedLeThetaSigned

theorem unitThetaToy_source_comparisonDataEndpoint_corollary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    Corollary312Inequality
      (package.comparisonData
        (unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds)).thetaPilot
      (package.comparisonData
        (unitThetaToyIUTStage1SourceObligations
          measure hnormalized hh hbound hholds)).qPilot :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let endpoint :=
    package.auditedComparisonDataEndpoint
      (unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds)
  endpoint.corollary312Endpoint

theorem unitThetaToy_source_comparisonDataEndpoint_publicAudit_eq_publicAudit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    let endpoint :=
      package.auditedComparisonDataEndpoint obligations
    endpoint.publicAudit = package.publicAudit obligations :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let obligations :=
    unitThetaToyIUTStage1SourceObligations
      measure hnormalized hh hbound hholds
  let endpoint :=
    package.auditedComparisonDataEndpoint obligations
  endpoint.publicAudit_eq_package_publicAudit

theorem unitThetaToy_source_comparisonDataEndpoint_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let obligations :=
      unitThetaToyIUTStage1SourceObligations
        measure hnormalized hh hbound hholds
    ∃ sourceAudit : IUTStage1SourcePackage.Audit package obligations,
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider obligations).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider obligations).ledger.qSigned_le_thetaSigned)) =
        package.publicAudit obligations :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let obligations :=
    unitThetaToyIUTStage1SourceObligations
      measure hnormalized hh hbound hholds
  let endpoint :=
    package.auditedComparisonDataEndpoint obligations
  endpoint.auditedPublicEndpoint

theorem unitThetaToy_source_gap_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let gap :=
      unitThetaToyIUTStage1SourceObligationGap
        measure hnormalized hh hbound hholds
    ∃ sourceAudit : IUTStage1SourcePackage.Audit package gap.toSourceObligations,
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider gap.toSourceObligations).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                gap.toSourceObligations).ledger.qSigned_le_thetaSigned)) =
        package.publicAudit gap.toSourceObligations :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let gap :=
    unitThetaToyIUTStage1SourceObligationGap
      measure hnormalized hh hbound hholds
  package.auditedPublicEndpointOfGap gap

theorem unitThetaToy_source_hypotheses_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
          (package.obligationsFromHypotheses subclaims hypotheses),
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider
                (package.obligationsFromHypotheses
                  subclaims hypotheses)).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                (package.obligationsFromHypotheses
                  subclaims hypotheses)).ledger.qSigned_le_thetaSigned)) =
        package.publicAuditOfHypotheses subclaims hypotheses :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let subclaims :=
    unitThetaToy_source_theorem311_subclaims_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  package.auditedPublicEndpointOfHypotheses subclaims hypotheses

theorem unitThetaToy_source_structured_inputs_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
          (package.obligationsFromStructuredInputs inputs sideConditions),
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider
                (package.obligationsFromStructuredInputs
                  inputs sideConditions)).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                (package.obligationsFromStructuredInputs
                  inputs sideConditions)).ledger.qSigned_le_thetaSigned)) =
        package.publicAuditOfStructuredInputs inputs sideConditions :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let sideConditions :=
    unitThetaToy_source_side_conditions_example
      measure hnormalized hh hbound hholds
  package.auditedPublicEndpointOfStructuredInputs inputs sideConditions

theorem unitThetaToy_source_structured_hypotheses_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider
                (package.obligationsFromStructuredHypotheses
                  inputs hypotheses)).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                (package.obligationsFromStructuredHypotheses
                  inputs hypotheses)).ledger.qSigned_le_thetaSigned)) =
        package.publicAuditOfStructuredHypotheses inputs hypotheses :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  package.auditedPublicEndpointOfStructuredHypotheses inputs hypotheses

theorem unitThetaToy_source_structured_hypotheses_auditedComparisonDataEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.ComparisonDataEndpoint
      (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  package.auditedComparisonDataEndpointOfStructuredHypotheses inputs hypotheses

theorem unitThetaToy_source_structured_hypotheses_comparisonDataEndpoint_publicAudit_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    let obligations :=
      package.obligationsFromStructuredHypotheses inputs hypotheses
    (package.auditedComparisonDataEndpointOfStructuredHypotheses
      inputs hypotheses).publicAudit =
      (package.comparisonData obligations).publicAudit :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  let endpoint :=
    package.auditedComparisonDataEndpointOfStructuredHypotheses
      inputs hypotheses
  endpoint.publicAudit_eq_comparisonData_publicAudit

theorem unitThetaToy_source_structured_route_payloadRouteSummary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    let routeAudit :=
      package.structuredHypothesisRouteAudit inputs hypotheses
    IUTStage1SourcePackage.Audit.PayloadRouteSummary
      routeAudit.sourceAudit :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  let routeAudit :=
    package.structuredHypothesisRouteAudit inputs hypotheses
  routeAudit.payloadRouteSummary

theorem unitThetaToy_source_structured_route_endpoint_payloadRouteSummary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      IUTStage1SourcePackage.Audit.PayloadRouteSummary sourceAudit ∧
        (package.auditedComparisonDataEndpointOfStructuredHypotheses
          inputs hypotheses).publicAudit =
          package.publicAuditOfStructuredHypotheses inputs hypotheses :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  let routeAudit :=
    package.structuredHypothesisRouteAudit inputs hypotheses
  routeAudit.comparisonDataEndpointPayloadRouteSummary

theorem unitThetaToy_source_structured_route_payloadData_eq_comparisonData_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    let routeAudit :=
      package.structuredHypothesisRouteAudit inputs hypotheses
    package.comparisonDataFromPayloadInputs
        (package.obligationsFromStructuredHypotheses inputs hypotheses) =
      routeAudit.sourceAudit.comparisonData :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  let routeAudit :=
    package.structuredHypothesisRouteAudit inputs hypotheses
  routeAudit.payloadDataEqComparisonData

theorem unitThetaToy_source_structured_route_comparisonData_eq_package_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    let routeAudit :=
      package.structuredHypothesisRouteAudit inputs hypotheses
    routeAudit.sourceAudit.comparisonData =
      package.comparisonData
        (package.obligationsFromStructuredHypotheses inputs hypotheses) :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  let routeAudit :=
    package.structuredHypothesisRouteAudit inputs hypotheses
  routeAudit.comparisonDataEqPackage

theorem unitThetaToy_source_structured_route_comparisonData_recovers_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    let routeAudit :=
      package.structuredHypothesisRouteAudit inputs hypotheses
    corollary312_from_stage1_comparison
        routeAudit.sourceAudit.comparisonData.stage1Comparison =
      corollary312_of_signed_le
        routeAudit.sourceAudit.comparisonData.qSigned_le_thetaSigned :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  let routeAudit :=
    package.structuredHypothesisRouteAudit inputs hypotheses
  routeAudit.comparisonDataRecovers

theorem unitThetaToy_source_structured_endpoint_payloadData_eq_comparisonData_exists_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      package.comparisonDataFromPayloadInputs
          (package.obligationsFromStructuredHypotheses inputs hypotheses) =
        sourceAudit.comparisonData :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  package.structuredEndpointPayloadDataEqComparisonDataExists
    inputs hypotheses

theorem unitThetaToy_source_structured_endpoint_comparisonData_recovers_exists_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      corollary312_from_stage1_comparison
          sourceAudit.comparisonData.stage1Comparison =
        corollary312_of_signed_le
          sourceAudit.comparisonData.qSigned_le_thetaSigned :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  package.structuredEndpointComparisonDataRecoversExists
    inputs hypotheses

theorem unitThetaToy_source_structured_endpoint_audit_summary_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    IUTStage1SourcePackage.StructuredEndpointAuditSummary
      package inputs hypotheses :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  package.structuredEndpointAuditSummary inputs hypotheses

theorem unitThetaToy_source_structured_endpoint_summary_sourceAudit_eq_route_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.structuredEndpointAuditSummary inputs hypotheses).sourceAudit =
      (package.structuredHypothesisRouteAudit inputs hypotheses).sourceAudit :=
  IUTStage1SourcePackage.structuredEndpointAuditSummary_sourceAudit_eq_routeAudit
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_endpoint_summary_payloadRoute_eq_route_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.structuredEndpointAuditSummary
      inputs hypotheses).payloadRouteSummary =
      (package.structuredHypothesisRouteAudit
        inputs hypotheses).payloadRouteSummary :=
  IUTStage1SourcePackage.structuredEndpointAuditSummary_payloadRouteSummary_eq_routeAudit
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_endpoint_summary_publicAudit_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    (package.auditedComparisonDataEndpointOfStructuredHypotheses
      inputs hypotheses).publicAudit =
      package.publicAuditOfStructuredHypotheses inputs hypotheses :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  let summary :=
    package.structuredEndpointAuditSummary inputs hypotheses
  summary.endpointPublicAuditEq

theorem unitThetaToy_source_structured_endpoint_summary_payloadData_eq_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    let summary :=
      package.structuredEndpointAuditSummary inputs hypotheses
    package.comparisonDataFromPayloadInputs
        (package.obligationsFromStructuredHypotheses inputs hypotheses) =
      summary.sourceAudit.comparisonData :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  let summary :=
    package.structuredEndpointAuditSummary inputs hypotheses
  summary.payloadDataEqComparisonData

theorem unitThetaToy_source_structured_endpoint_summary_recovers_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    let summary :=
      package.structuredEndpointAuditSummary inputs hypotheses
    corollary312_from_stage1_comparison
        summary.sourceAudit.comparisonData.stage1Comparison =
      corollary312_of_signed_le
        summary.sourceAudit.comparisonData.qSigned_le_thetaSigned :=
  let package :=
    unitThetaToyIUTStage1SourcePackage
      measure hnormalized hh hbound hholds
  let inputs :=
    unitThetaToy_source_theorem311_structured_inputs_example
      measure hnormalized hh hbound hholds
  let hypotheses :=
    unitThetaToy_source_side_condition_hypotheses_example
      measure hnormalized hh hbound hholds
  let summary :=
    package.structuredEndpointAuditSummary inputs hypotheses
  summary.comparisonDataRecovers

theorem unitThetaToy_source_structured_route_auditedPublicEndpoint_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    ∃ sourceAudit :
        IUTStage1SourcePackage.Audit package
          (package.obligationsFromStructuredHypotheses inputs hypotheses),
      (⟨sourceAudit.qSigned_le_thetaSigned,
          sourceAudit.corollary312,
          sourceAudit.stage_recovers_qSigned_le_thetaSigned⟩ :
        package.preLedger.qSigned <= package.preLedger.thetaSigned ∧
          Corollary312Inequality
            (signedPilotLogVolume PilotSide.theta package.preLedger.thetaSigned)
            (signedPilotLogVolume PilotSide.q package.preLedger.qSigned) ∧
          (corollary312_from_stage1_comparison
              (package.promotedProvider
                (package.obligationsFromStructuredHypotheses
                  inputs hypotheses)).stage1Comparison =
            corollary312_of_signed_le
              (package.promotedProvider
                (package.obligationsFromStructuredHypotheses
                  inputs hypotheses)).ledger.qSigned_le_thetaSigned)) =
        package.publicAuditOfStructuredHypotheses inputs hypotheses :=
  (unitThetaToy_source_structured_hypothesis_route_audit_example
    measure hnormalized hh hbound hholds).auditedPublicEndpoint

theorem unitThetaToy_source_hypotheses_auditedPublicEndpoint_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let subclaims :=
      unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditedPublicEndpointOfHypotheses subclaims hypotheses =
      package.auditedPublicEndpointOfParts
        subclaims hypotheses.toSideConditions :=
  IUTStage1SourcePackage.auditedPublicEndpointOfHypotheses_eq_parts
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_subclaims_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_inputs_auditedPublicEndpoint_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let sideConditions :=
      unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds
    package.auditedPublicEndpointOfStructuredInputs
        inputs sideConditions =
      package.auditedPublicEndpointOfParts
        inputs.theorem311Subclaims sideConditions :=
  IUTStage1SourcePackage.auditedPublicEndpointOfStructuredInputs_eq_parts
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_conditions_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypotheses_auditedPublicEndpoint_eq_parts_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditedPublicEndpointOfStructuredHypotheses
        inputs hypotheses =
      package.auditedPublicEndpointOfStructuredInputs
        inputs hypotheses.toSideConditions :=
  IUTStage1SourcePackage.auditedPublicEndpointOfStructuredHypotheses_eq_parts
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

theorem unitThetaToy_source_structured_hypotheses_auditedPublicEndpoint_eq_hypotheses_example
    (measure : RegionMeasure thetaLine)
    (hnormalized : RegionMeasure.NormalizesUpperRays measure)
    {h : Real} (hh : 0 < h)
    {epsilon : index -> Real} {epsilonBound : Real}
    (hbound : ∀ choice : index, epsilon choice <= epsilonBound)
    {choice : index}
    (hholds : (thetaToyAlgorithmOutput unitQToTheta h epsilon).Holds choice
      (qAssignment h)) :
    let package :=
      unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds
    let inputs :=
      unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds
    let hypotheses :=
      unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds
    package.auditedPublicEndpointOfStructuredHypotheses
        inputs hypotheses =
      package.auditedPublicEndpointOfHypotheses
        inputs.theorem311Subclaims hypotheses :=
  IUTStage1SourcePackage.auditedPublicEndpointOfStructuredHypotheses_eq_hypotheses
      (unitThetaToyIUTStage1SourcePackage
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_theorem311_structured_inputs_example
        measure hnormalized hh hbound hholds)
      (unitThetaToy_source_side_condition_hypotheses_example
        measure hnormalized hh hbound hholds)

end ToyModel
end Stage1
end Iut
