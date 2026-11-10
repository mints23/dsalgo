import java.util.Objects;

/**
 * LeetCode 167 — Two Sum II: Input Array Is Sorted.
 *
 * Preconditions: numbers is sorted in non-decreasing order and exactly one
 * valid pair exists. The returned indices are 1-based, as required by LC.
 */
public final class LC_0167_Two_Sum_II {
    private LC_0167_Two_Sum_II() { }

    public static int[] twoSum(int[] numbers, int target) {
        Objects.requireNonNull(numbers, "numbers");
        int left = 0;
        int right = numbers.length - 1;

        while (left < right) {
            long sum = (long) numbers[left] + numbers[right];
            if (sum == target) {
                return new int[] { left + 1, right + 1 };
            }
            if (sum < target) {
                // The current left value is too small even with the largest
                // remaining right value, so no pair using left can work.
                left++;
            } else {
                // The current right value is too large even with the smallest
                // remaining left value, so no pair using right can work.
                right--;
            }
        }

        // Unreachable when the stated problem guarantee holds.
        throw new IllegalArgumentException("No valid pair exists");
    }
}
