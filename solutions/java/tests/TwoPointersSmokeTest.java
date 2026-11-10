import java.util.List;

/** Dependency-free smoke tests for the first Java reference implementations. */
public final class TwoPointersSmokeTest {
    private TwoPointersSmokeTest() { }

    public static void main(String[] args) {
        checkArray(new int[] { 1, 2 }, LC_0167_Two_Sum_II.twoSum(new int[] { 2, 7, 11, 15 }, 9));
        checkArray(new int[] { 1, 2 }, LC_0167_Two_Sum_II.twoSum(new int[] { -5, -1, 0, 4, 9 }, -6));

        List<List<Integer>> threeSum = LC_0015_Three_Sum.threeSum(new int[] { -1, 0, 1, 2, -1, -4 });
        if (!threeSum.equals(List.of(List.of(-1, -1, 2), List.of(-1, 0, 1)))) {
            throw new AssertionError("Unexpected 3Sum result: " + threeSum);
        }
        if (!LC_0015_Three_Sum.threeSum(new int[] { 0, 0, 0, 0 }).equals(List.of(List.of(0, 0, 0)))) {
            throw new AssertionError("3Sum duplicate suppression failed");
        }
        if (!LC_0015_Three_Sum.threeSum(new int[] { 1, 2, -2, -1 }).isEmpty()) {
            throw new AssertionError("3Sum should be empty");
        }

        if (LC_0011_Container_With_Most_Water.maxArea(new int[] { 1, 8, 6, 2, 5, 4, 8, 3, 7 }) != 49) {
            throw new AssertionError("Container example failed");
        }
        if (LC_0011_Container_With_Most_Water.maxArea(new int[] { 1, 1 }) != 1) {
            throw new AssertionError("Container minimum-size case failed");
        }
        if (LC_0011_Container_With_Most_Water.maxArea(new int[] { 4 }) != 0) {
            throw new AssertionError("Container singleton case failed");
        }

        System.out.println("TwoPointersSmokeTest: all tests passed");
    }

    private static void checkArray(int[] expected, int[] actual) {
        if (!java.util.Arrays.equals(expected, actual)) {
            throw new AssertionError("Expected " + java.util.Arrays.toString(expected)
                    + " but got " + java.util.Arrays.toString(actual));
        }
    }
}
