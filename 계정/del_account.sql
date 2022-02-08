CREATE OR REPLACE PROCEDURE del_account (p_acc_id NUMBER)
IS 
    v_email     VARCHAR2(40);
BEGIN
    SELECT email INTO v_email
    FROM nf_account
    WHERE acc_id = p_acc_id;

    DELETE FROM nf_account WHERE acc_id = p_acc_id;
    COMMIT;
    dbms_output.put_line(v_email || ' 님의 계정을 삭제했습니다.');
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('없는 계정입니다.');
END;

------------------------ 테스트 ---------------------------
EXEC del_account(41);
SELECT * FROM nf_account;