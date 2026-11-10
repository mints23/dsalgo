# FAANG Mastery Audit — Operating Charter

**Status:** Audit in progress  
**Baseline date:** 2026-11-10  
**Scope:** Existing 43 topics and 919 required placements at audit start.  
**Goal:** Maximise transferable FAANG interview mastery. Question count is a constraint to optimise, not a hard ceiling.

## Objective

Build an authoritative concept inventory for every topic, including advanced variants, and determine whether completing the curriculum prepares a learner to solve unfamiliar FAANG interview problems independently.

The audit must inspect actual explanations, correctness arguments and Java implementations—not infer quality from titles, difficulty labels, path names or one-line insights.

## Curriculum volume policy

1. Add questions when they teach an important concept or distinct learning outcome not adequately covered by existing problems.
2. Do not add questions merely to increase volume or repeat an existing pattern.
3. Before every addition, identify the exact missing concept, why current placements fail to teach it, and what the new problem uniquely contributes.
4. Prefer improving an existing teaching artifact or reclassifying a problem when that is sufficient.
5. Preserve existing problem IDs, topic IDs and learner-progress identity. Reclassification should update ownership/order metadata without deleting/recreating stable problem records.
6. New topics are justified when they represent independent concept families with a coherent progression and assessment—not simply because the title is missing.

## Mastery dimensions

| Dimension | Required evidence |
|---|---|
| Concept inventory | Algorithms, invariants, proof patterns, structures, preconditions, advanced variants and failure boundaries |
| Problem mapping | Every required problem maps to a precise primary concept and any genuinely distinct secondary concept |
| Progression | Prerequisites, first exposure, variants, combinations, optimisations and assessment are ordered deliberately |
| Distinct learning value | Each required question teaches a new reusable insight or meaningful transfer |
| Explanation quality | Reduction, invariant/proof, walkthrough, complexity derivation, edge cases and failure modes |
| Java implementation | Complete, correct, compilable Java code with justified types, collections, complexity and constraints |
| Transfer ability | Learner can solve an unseen formulation and explain why the approach applies |
| Interview readiness | Learner can derive, prove, optimise, implement and discuss trade-offs under time pressure |

## Evidence-based topic verdicts

- **Strong:** All essential concepts have clear placements; progression is sound; explanations and Java code are correct; transfer is demonstrated.
- **Partial:** Core concepts are represented, but advanced variants, proofs, edge cases, implementation artifacts or progression links remain incomplete.
- **Gap:** A foundational or important concept is absent/misplaced, or the required set cannot support the claimed mastery.
- **Not verified:** Evidence is unavailable. This is not equivalent to Strong or Partial.

A topic's final verdict is constrained by its weakest essential dimension. A complete problem list cannot compensate for incorrect or absent teaching artifacts.

## Baseline observations

Production data queried on 2026-11-10:

- 43 topics and 919 required placements at the start of the audit.
- The temporary Topic 44 experiment was reverted; it is not part of production.
- 11 required placements have a problem_playback.solution record; 908 do not.
- The inspected playback snippets use Python-style pseudocode rather than verified Java implementations.
- 113 required placements in Topics 38–43 have an empty key_insight field even though long explanatory text exists in sub_variant.
- GitHub code searches did not surface Java solution source files. A repository tree/source inventory is still required before concluding they are absent.

These are database/repository evidence findings, not proof that no Java solutions exist elsewhere.

## Per-problem solution review

For every required problem, inspect:

1. Problem statement and constraints.
2. Naive baseline and why it fails.
3. Exact concept and recognition signal.
4. Derivation of the algorithm.
5. Correctness proof (invariant, induction, exchange, cut, recurrence, etc.).
6. Complete Java implementation and correct signature.
7. Time/space complexity derived from the implementation.
8. Integer bounds, overflow, indexing, duplicates, empty/singleton cases and recursion depth.
9. Dry run and adversarial test.
10. Alternative solutions and trade-offs.
11. Common wrong approaches and counterexamples.
12. An unseen transfer variant or mastery assessment.

A playback animation or pseudocode trace is supplemental, not a substitute for a compilable Java solution.

## Execution sequence

1. Complete concept inventories and problem mappings for all topics.
2. Resolve primary ownership and remove accidental duplication.
3. Locate the Java solution source of truth and inspect existing playback records.
4. Audit all required explanations and Java implementations in topic batches.
5. Fix incorrect explanations, complexity claims, key insights and code.
6. Add independent missing concept families with coherent progressions.
7. Add questions only where the missing concept requires a distinct learning exercise.
8. Add unseen-style assessment problems to test transfer, not memorisation.
9. Validate IDs, progress persistence, path ordering, roles, navigation and entitlements.
10. Deploy and verify production.

## Programme-level baseline verdict

**Not yet mastery-certified.** The curriculum has substantial structured and advanced concept breadth, but solution-level Java evidence and a fully reconciled concept ownership map are not yet available. The audit must close these gaps before AlgoFrog claims FAANG mastery readiness.
