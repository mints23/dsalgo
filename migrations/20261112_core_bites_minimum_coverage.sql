-- Curated minimum-question sets for the Core Bites study filter.
-- Each entry is an exact public.problems.id for a required question in that topic.
-- This only updates topic_content.coverage_problems; problem rows, classifications,
-- authored order, curriculum paths, and user progress remain unchanged.
WITH core_bites(display_number, problem_ids) AS (
  VALUES
    ('01', ARRAY[9639, 9640, 9644, 9647, 9652, 11193]::bigint[]),
    ('02', ARRAY[9699, 9705, 9700, 9717, 9737, 9732]::bigint[]),
    ('03', ARRAY[9746, 9747, 9774, 9756, 9772, 9762, 9765]::bigint[]),
    ('04', ARRAY[9789, 9795, 9790, 9799, 9792, 9803, 9835, 11194]::bigint[]),
    ('05', ARRAY[9844, 9845, 9863, 9855, 9857]::bigint[]),
    ('06', ARRAY[10944, 10949, 10950, 10973, 10959, 10961]::bigint[]),
    ('07', ARRAY[9909, 9913, 9910, 9911, 9917, 9919, 9922, 9931]::bigint[]),
    ('08', ARRAY[9939, 9944, 9941, 9947, 9949, 9951, 9953, 9963]::bigint[]),
    ('09', ARRAY[9977, 9980, 9984, 9991, 9999, 10005, 10020]::bigint[]),
    ('10', ARRAY[10117, 10131, 10136, 10127, 10141, 10144, 10150]::bigint[]),
    ('11', ARRAY[10170, 10175, 10179, 10181, 10191]::bigint[]),
    ('12', ARRAY[10211, 10235, 10226, 10230, 10234, 10218, 10257, 11124]::bigint[]),
    ('13', ARRAY[10259, 10267, 10271, 10275]::bigint[]),
    ('14', ARRAY[10541, 10588, 10553, 10558, 10584, 10577]::bigint[]),
    ('15', ARRAY[10593, 10599, 10601, 10603]::bigint[]),
    ('16', ARRAY[10624, 10625, 10633, 10639]::bigint[]),
    ('17', ARRAY[10656, 10666, 10659, 10676]::bigint[]),
    ('18', ARRAY[10689, 10695, 10703]::bigint[]),
    ('19', ARRAY[10717, 10720, 10722, 10723]::bigint[]),
    ('20', ARRAY[10745, 10748, 10751, 10757]::bigint[]),
    ('21', ARRAY[10771, 10774, 10779]::bigint[]),
    ('22', ARRAY[10799, 10807, 10813, 10816]::bigint[]),
    ('23', ARRAY[10834, 10836, 10841, 10847, 10856]::bigint[]),
    ('24', ARRAY[10893, 10898, 10900, 10905, 11251]::bigint[]),
    ('25', ARRAY[10919, 10926, 10925, 10934, 10927]::bigint[]),
    ('26', ARRAY[10292, 10300, 10290, 10304, 10301]::bigint[]),
    ('27', ARRAY[10319, 10343, 10329, 10340]::bigint[]),
    ('28', ARRAY[10363, 10365, 10373]::bigint[]),
    ('29', ARRAY[10397, 10402, 10404]::bigint[]),
    ('30', ARRAY[10417, 10420, 10423, 11029]::bigint[]),
    ('31', ARRAY[10432, 10436, 10438, 10445, 11222]::bigint[]),
    ('32', ARRAY[10458, 10464, 10461, 10468]::bigint[]),
    ('33', ARRAY[10475, 10482, 10483, 10481]::bigint[]),
    ('34', ARRAY[10491, 10489, 10493]::bigint[]),
    ('35', ARRAY[10501, 10502, 10505, 10513, 11223]::bigint[]),
    ('36', ARRAY[10521, 10526, 10530, 10535, 11005, 11182]::bigint[])
),
updated AS (
  UPDATE public.topic_content tc
  SET coverage_problems = (
    SELECT jsonb_agg(to_jsonb('ID:' || selected.problem_id) ORDER BY selected.ordinality)
    FROM unnest(core_bites.problem_ids) WITH ORDINALITY
      AS selected(problem_id, ordinality)
  )
  FROM public.topics t
  JOIN core_bites ON core_bites.display_number = t.display_number
  WHERE tc.topic_id = t.id
  RETURNING tc.topic_id
)
SELECT count(*) AS topics_updated FROM updated;
