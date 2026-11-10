# AlgoFrog Java Reference Solutions

Java 17+ reference implementations for interview problems. Each problem is an independent class so its code can be copied into an interview editor without colliding with another Solution class.

## Compile and run the current smoke tests

From the repository root:

    mkdir -p /tmp/algofrog-java-classes
    javac -d /tmp/algofrog-java-classes \
      solutions/java/two-pointers/LC_0167_Two_Sum_II.java \
      solutions/java/two-pointers/LC_0015_Three_Sum.java \
      solutions/java/two-pointers/LC_0011_Container_With_Most_Water.java \
      solutions/java/tests/TwoPointersSmokeTest.java
    java -cp /tmp/algofrog-java-classes TwoPointersSmokeTest

## Authoring contract

Every solution must document constraints/assumptions, the algorithmic invariant, correctness reasoning, time and space complexity, overflow and boundary handling, and representative plus adversarial tests. Use long for intermediate arithmetic when constraints can exceed 32-bit sums/products. Do not label pseudocode as Java.

## Current coverage

- LC 167 — sorted opposite-end pair search.
- LC 15 — sorted three-sum, duplicate suppression and overflow-safe sum.
- LC 11 — opposite-end optimisation with a bottleneck proof.

This is the first verified batch, not a claim that the full 919-problem curriculum has Java implementations.
