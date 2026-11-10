import java.util.Objects;

/** LeetCode 11 — Container With Most Water. */
public final class LC_0011_Container_With_Most_Water {
    private LC_0011_Container_With_Most_Water() { }

    public static int maxArea(int[] height) {
        Objects.requireNonNull(height, "height");
        int left = 0;
        int right = height.length - 1;
        long best = 0L;

        while (left < right) {
            long area = (long) Math.min(height[left], height[right]) * (right - left);
            best = Math.max(best, area);

            // The shorter wall is the bottleneck. Moving the taller wall can
            // only reduce width while leaving the limiting height unchanged.
            if (height[left] <= height[right]) {
                left++;
            } else {
                right--;
            }
        }

        return Math.toIntExact(best); // Fits LC constraints; fail loudly otherwise.
    }
}
