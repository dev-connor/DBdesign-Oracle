CREATE OR REPLACE PROCEDURE del_account (p_acc_id NUMBER)
IS 
    v_email     VARCHAR2(40);
BEGIN
    SELECT email INTO v_email
    FROM nf_account
    WHERE acc_id = p_acc_id;

    DELETE FROM nf_account WHERE acc_id = p_acc_id;
    COMMIT;
    dbms_output.put_line(v_email || ' ���� ������ �����߽��ϴ�.');
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('���� �����Դϴ�.');
END;

------------------------ �׽�Ʈ ---------------------------
EXEC del_account(41);
SELECT * FROM nf_account;