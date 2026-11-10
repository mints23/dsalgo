# AlgoFrog Advanced DSA Curriculum Policy

## Positioning
AlgoFrog is an intermediate-to-advanced DSA mastery course for engineers who already know programming fundamentals and common data structures. It is not a beginner course.

## Difficulty policy
- Easy: excluded from the required curriculum. Existing records remain optional reference material; do not delete them.
- Medium: include selectively when a problem teaches a distinct non-obvious pattern, a necessary bridge, or a high-value variation.
- Hard: core curriculum, subject to quality and relevance review.
- Unclassified/custom: review manually; never infer difficulty from a title or source platform.
- Do not add questions to hit arbitrary topic quotas. Prefer fewer distinct, high-value problems over repetition.

## Problem roles
1. Core pattern — establishes or tests a fundamental non-trivial technique.
2. Variant — changes constraints, representation, objective, or invariant.
3. Combination — requires two or more patterns.
4. Optimization — requires a non-obvious complexity improvement.
5. Trap / contrast — teaches when a tempting technique is invalid or inferior.
6. Mastery assessment — unseen or withheld problem used to verify transfer.

Repeated problem IDs across topics are allowed only when the placement has a documented learning purpose. Identify primary topic and cross-topic role.

## Mastery contract
- Recognize the pattern in an unfamiliar statement.
- Explain why it applies and state its invariant.
- Derive the algorithm independently.
- Prove correctness and justify greedy choices where relevant.
- Derive time and space complexity.
- Handle adversarial constraints and edge cases.
- Recognize when optimization or combination is required.
- Transfer the technique to an unseen problem without topic labels or hints.

## Topic audit rubric
Audit both the teaching content and problem catalogue:
1. Concepts and prerequisites.
2. Patterns and sub-variants.
3. Constraint changes and edge cases.
4. Progression from non-trivial baseline to advanced variants.
5. Proof, complexity, and optimization reasoning.
6. Cross-pattern transfer and counterexamples.
7. Problem quality, metadata, duplication, and solution/playback quality.

Statuses: Complete (all mastery dimensions taught and assessed); Partial (core exists but gaps remain); Incomplete (major concept/prerequisite missing); Redundant (substantial duplication without distinct learning purpose). Do not assign status from row counts alone.

## Proposed new-topic candidates
Check these against all existing topic bodies before adding separate topics:
- Linked Lists — Advanced Patterns
- Stack, Queue & Deque
- Sorting & Selection
- Bit Manipulation & Bitmask Techniques
- Advanced String Algorithms
- Mathematics & Number Theory

Also evaluate Matrix / Multidimensional Algorithms, Divide & Conquer, and Offline Algorithms as standalone topics versus subtopics.

## Safe rollout
- Preserve existing topic and problem records.
- Keep Easy problems in the database but exclude them from the required learning path.
- Normalize labels only after mapping every legacy value.
- Add new topic content only after outline, problem set, and acceptance tests are reviewed.
- Use additive migrations and transactional seed operations.
- Do not alter authentication, subscriptions, Razorpay, or payment flows as part of curriculum work.
- Validate in a branch and staging/test environment before production rollout.
