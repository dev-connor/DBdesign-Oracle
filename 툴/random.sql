SELECT 
    regexp_replace(
        regexp_replace(regexp_replace(
            dbms_random.string('X', 12), '(.{2})(.{2})(.{2})(.{2})(.{2})(.{2})', '\1-\2-\3-\4-\5-\6')
            , '[G-P]'
            , round(dbms_random.value(0, 9))
        ), '[Q-Z]', round(dbms_random.value(0, 9)))
        AS mac_id
FROM dual;

SELECT *
FROM (
    SELECT dbms_random.string('X', 1) n
    FROM dual)
WHERE regexp_like(n, '[0-9]')
    AND length(n) = 1;
    
