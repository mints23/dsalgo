import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

/** LeetCode 15 — 3Sum. Returns unique value-triplets whose sum is zero. */
public final class LC_0015_Three_Sum {
    private LC_0015_Three_Sum() { }

    public static List<List<Integer>> threeSum(int[] nums) {
        Objects.requireNonNull(nums, "nums");
        int[] values = nums.clone(); // Do not mutate the caller's input.
        Arrays.sort(values);
        List<List<Integer>> result = new ArrayList<>();

        for (int first = 0; first < values.length - 2; first++) {
            if (first > 0 && values[first] == values[first - 1]) {
                continue; // Same first value would reproduce the same triplets.
            }
            if (values[first] > 0) {
                break; // Sorted suffix is also positive; sum cannot be zero.
            }

            int left = first + 1;
            int right = values.length - 1;
            while (left < right) {
                long sum = (long) values[first] + values[left] + values[right];
                if (sum < 0) {
                    left++;
                } else if (sum > 0) {
                    right--;
                } else {
                    result.add(List.of(values[first], values[left], values[right]));
                    int leftValue = values[left];
                    int rightValue = values[right];
                    while (left < right && values[left] == leftValue) left++;
                    while (left < right && values[right] == rightValue) right--;
                }
            }
        }
        return result;
    }
}
