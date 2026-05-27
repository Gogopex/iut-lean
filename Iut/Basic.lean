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
import Iut.Foundations.AlgorithmicOutput
import Iut.Foundations.AlgorithmicBridge
import Iut.Stage1.PilotComparison
import Iut.Stage1.ToyModel
import Iut.Stage1.ToyMeasuredComparison
import Iut.Stage1.ToyFamilyBounds
import Iut.Stage1.ToyAPTTransport
import Iut.Stage1.ToyQualitativeOutput
import Iut.Stage1.ToyBridge
import Iut.Stage1.CorollarySchema
import Iut.Stage1.ToyCorollarySchema
import Iut.Stage1.SourceObligations
import Iut.Stage1.IUTSourceScaffold
import Iut.Stage1.IUTStage1Data
import Iut.Stage1.ToySourceObligations
import Iut.Stage1.ToyPublicAuditExample
import Iut.Stage1.IUTSourceScaffoldExample
import Iut.Stage1.IUTStage1DataExample

/-!
Root module for the IUT formalization scaffold.

The current code deliberately records interfaces and bookkeeping objects only.
Mathematical claims from IUT will be added as separate theorem statements once
their hypotheses have been made explicit enough to avoid hiding the disputed
identifications.
-/

namespace Iut

def projectName : String := "IUT Lean formalization"

end Iut
