-- Keep authored problem tables consistent with the corrected structured metadata.
do $$
begin
  if not exists (select 1 from public.topics where id=9 and body_html like '%Fractional knapsack + binary search on ratio%') then
    raise exception 'Talent Show authored row was not found in Greedy body_html';
  end if;
  if not exists (select 1 from public.topics where id=5 and body_html like '%linear scan with running max%') then
    raise exception 'LC 2770 authored row was not found in Kadane body_html';
  end if;
end $$;

update public.topics
set body_html = replace(
  replace(
    body_html,
    'Fractional knapsack + binary search on ratio',
    'Ratio binary search + 0/1 knapsack feasibility'
  ),
  'Hard: binary search on a CONTINUOUS parameter (ratio threshold); greedy feasibility check is the inner loop. Classic binary-search-on-answer template',
  'Binary-search the talent-to-weight ratio. For each candidate ratio, transform each item to talent − ratio × weight and use 0/1 knapsack DP over total weight (capped at the required threshold) to test feasibility.'
)
where id=9;

update public.topics
set body_html = replace(
  replace(
    body_html,
    'Kadane-style DP with value-range constraint',
    'Value-range dynamic programming'
  ),
  'dp[i] = max(dp[j]+1) for j where |nums[i]−nums[j]| ≤ target; linear scan with running max',
  'dp[i] = max(dp[j]+1) over earlier j satisfying |nums[i]−nums[j]| ≤ target; a running maximum is insufficient because eligibility depends on nums[j].'
)
where id=5;

do $$
begin
  if exists (select 1 from public.topics where id=9 and body_html like '%Fractional knapsack + binary search on ratio%') then
    raise exception 'Talent Show authored row still contains the incorrect fractional-knapsack description';
  end if;
  if exists (select 1 from public.topics where id=5 and body_html like '%linear scan with running max%') then
    raise exception 'LC 2770 authored row still contains the incorrect running-maximum claim';
  end if;
end $$;