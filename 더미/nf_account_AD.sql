-- 더미 트리거
CREATE OR REPLACE TRIGGER nf_account_AD
AFTER DELETE ON nf_account
BEGIN
    IF DELETING THEN
        dbms_output.put_line('님의 계정을 삭제했습니다.');
    END IF;
END;

DROP TRIGGER nf_account_AD;
SELECT * FROM user_triggers;