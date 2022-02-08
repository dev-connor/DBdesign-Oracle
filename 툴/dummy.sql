-- 로그인 더미
MERGE INTO streaming_dev s
USING dual ON (s.mac_id = p_mac_id)
WHEN MATCHED THEN
    UPDATE SET WHERE
WHEN NOT MATCHED THEN
    INSERT ;