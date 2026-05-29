/-
Copyright (c) 2026 IUT Lean formalization contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: IUT Lean formalization contributors
-/
import Iut.Foundations.Species
import Iut.Foundations.RealLineCopy
import Iut.Foundations.TransportDiagram
import Iut.Foundations.IndeterminacyRelation
import Iut.Foundations.RegionMeasure
import Iut.Foundations.CommonTargetBound
import Iut.Foundations.TransportedRegionFamily
import Iut.Foundations.QualitativeData
import Iut.Foundations.InitialThetaData
import Iut.Foundations.AlgorithmicOutput
import Iut.Foundations.AlgorithmicBridge
import Iut.Stage1.PilotComparison
import Iut.Stage1.CorollarySchema
import Iut.Stage1.SourceObligations
import Iut.Stage1.IUTSourceScaffold
import Iut.Stage1.IUTStage1Data
import Iut.Stage1.IUTStage1Source
import Iut.Stage1.IUTStage1Experiments

/-!
Root module for the IUT formalization corridor.

The root import now exposes the current Stage 1 formal corridor rather than the
early toy/example scaffolding. The main project surface tracks the Corollary
3.12 work.
-/

namespace Iut

def projectName : String := "IUT Lean formalization"

end Iut
