-- ���� Ʈ����
CREATE OR REPLACE TRIGGER nf_account_AD
AFTER DELETE ON nf_account
BEGIN
    IF DELETING THEN
        dbms_output.put_line('���� ������ �����߽��ϴ�.');
    END IF;
END;

DROP TRIGGER nf_account_AD;
SELECT * FROM user_triggers;