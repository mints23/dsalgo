# Volume-Neutral Mastery Audit — Charter and Baseline

**Status:** Audit in progress  
**Baseline date:** 2026-11-10  
**Scope:** Existing 43 topics and their 919 required problem placements  
**Policy:** No net increase in required-problem volume. No question is added merely to make a topic look comprehensive.

## Objective

Produce an authoritative concept inventory for every topic, including advanced variants, and determine whether completing its required set demonstrates transferable mastery.

The audit must inspect the actual teaching artifact (solution explanation, proof/invariant, implementation and edge cases), not infer quality from a title, difficulty label, path name or one-line key insight.

## Non-negotiable volume policy

1. Keep the required problem count at or below the baseline of 919.
2. For every proposed addition, first identify a redundant, misclassified, weakly explained or lower-value required placement that can be replaced.
3. Prefer reclassification or cross-reference over duplicate required placements when the learning objective is not distinct.
4. Preserve existing problem IDs, topic IDs, order identities and learner progress wherever possible. If ownership changes, update only the necessary topic/order metadata and preserve the stable problem ID.
5. New independent concept families are first recorded in the concept inventory. They do not automatically become new topics or problem rows.
6. A new topic can be considered only as a volume-neutral restructuring: it must replace/split an existing topic boundary and reuse existing problem placements. No net new required questions.

The eight proposed families from MASTER_CURRICULUM_EXPANSION_PLAN.md remain candidates for the inventory: bit manipulation/bitmask, number theory/modular arithmetic, advanced strings, advanced trees, offline queries/sqrt decomposition, meet-in-the-middle/subset optimisation, network flow/matching, and computational geometry. Each must be mapped to current placements before any structural decision.

## Audit dimensions

| Dimension | What must be established |
|---|---|
| Concept inventory | Exact algorithms, invariants, proof patterns, data structures, preconditions and advanced variants taught |
| Placement mapping | Every required problem maps to one primary concept and an explicit secondary concept only when it adds a distinct learning objective |
| Progression | Prerequisites, first exposure, variants, combinations, optimisations and mastery assessment are ordered deliberately |
| Distinct learning value | No required question is retained solely as volume; repeated problems must teach a genuinely different approach or transfer |
| Explanation quality | Problem reduction, insight, invariant/proof, walkthrough, complexity derivation, edge cases and failure modes are correct and sufficiently explained |
| Java implementation | Compiles, matches the stated approach, handles constraints/overflow/null/duplicates, uses appropriate Java collections and has justified complexity |
| Transfer/readiness | Learner can recognise the pattern in an unseen formulation, choose among alternatives, prove correctness and explain trade-offs |

## Evidence-based ratings

- **Strong:** All essential concepts have a clear placement; progression is sound; required artifacts are correct and sufficient; the set supports independent transfer.
- **Partial:** Core concepts are represented, but at least one meaningful advanced variant, proof, edge case, implementation artifact or progression link is missing.
- **Gap:** A foundational or important concept is absent/misplaced, the teaching artifact is materially deficient, or the required set cannot support the claimed mastery.
- **Not verified:** Evidence is unavailable. This is not equivalent to Strong or Partial.

A topic's final mastery verdict is constrained by its weakest essential dimension. Strong titles/key insights cannot compensate for absent or incorrect implementations.

## Verified production baseline

The production database was queried on 2026-11-10:

- 43 topics.
- 919 required problem placements before the temporary Topic 44 experiment.
- The temporary Topic 44 insertion was reverted to honour the volume-neutral policy; no Topic 44 or additional required placements remain.
- problem_playback contains 11 solution records associated with required placements.
- Therefore, 908 required placements have no problem_playback.solution artifact (919 total minus 11 present).
- The inspected playback records use Python-style pseudocode/snippets (e.g. Python def, range, tuple assignment and None), not verified Java implementations.
- This finding applies specifically to the problem_playback table. It does not prove that Java solutions do not exist elsewhere in the repository or in external learning material; those sources must be searched and linked before concluding they are absent.
- Existing topic metadata and key_insight text are not a substitute for solution-level evidence.

## Required per-topic deliverable

For every topic, publish:

1. **Concept inventory:** foundational, intermediate, advanced and apex concepts; prerequisites; invariants; proofs; complexity; limitations.
2. **Problem-to-concept map:** each required row, primary concept, secondary concept (if any), curriculum role, and evidence that the question actually teaches it.
3. **Gap analysis:** missing concepts, weak progression, missing proof/edge-case coverage, and absent/incorrect Java artifacts.
4. **Redundancy analysis:** retain / replace / reclassify / optional-reference recommendations, with a reason for each affected problem.
5. **Readiness verdict:** Strong / Partial / Gap / Not verified, with the blocking evidence and what would change the verdict.
6. **Volume delta:** required rows before and after. The target net change is zero.

## Solution and Java review checklist

For every required problem, inspect the actual artifact for:

- Correct interpretation of constraints and input guarantees.
- Reduction from problem statement to the chosen model.
- State definition / invariant / greedy exchange / graph property / data-structure invariant.
- Correctness argument, including why discarded states or transitions are safe.
- Complete Java implementation (not Python pseudocode): imports, method/class signature, types, mutation semantics and return value.
- Integer bounds, overflow, index boundaries, duplicate handling, empty/singleton cases and recursion depth.
- Complexity derived from the implementation, including sorting, heap, map and preprocessing costs.
- At least one representative trace and adversarial edge case.
- Alternative approaches and why the selected approach is preferable under the constraints.
- Tests that exercise the stated boundary conditions.

## Rollout sequence

1. Audit artifact inventory and data coverage; locate all Java solution sources.
2. Audit each existing topic in small batches, beginning with foundational topics.
3. Build the full concept inventory before proposing any additions.
4. Reclassify misplaced questions and identify true redundancy.
5. Propose one-for-one replacements only where the replacement teaches a missing concept more effectively.
6. Validate all changes against the zero-net-volume rule and stable learner-progress identity.
7. Publish the topic-by-topic verdict matrix and a final programme-level readiness verdict.

## Programme-level verdict at baseline

**Not verified / not mastery-ready on available evidence.** The curriculum has substantial structured concept metadata, but the database contains solution playback for only 11 of 919 required placements, and the inspected examples are not Java implementations. A final verdict requires locating and reviewing the actual Java artifacts or authoring the missing ones. This is an evidence limitation, not a claim that the topic list itself is poor.
