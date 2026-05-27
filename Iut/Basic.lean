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
import Iut.Stage1.PilotComparison
import Iut.Stage1.ToyModel

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
