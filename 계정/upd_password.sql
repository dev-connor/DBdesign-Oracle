CREATE OR REPLACE PROCEDURE upd_password (
    p_acc_id        nf_account.acc_id%TYPE
    , p_password    nf_account.password%TYPE
    , new_password  nf_account.password%TYPE
)
IS
    v_password      nf_account.password%TYPE;
    v_email         nf_account.email%TYPE;
BEGIN
    SELECT password, email INTO v_password, v_email FROM nf_account WHERE acc_id = p_acc_id;
    
    IF p_password = v_password THEN
        UPDATE nf_account
        SET password = new_password
        WHERE acc_id = p_acc_id;
        
        dbms_output.put_line(v_email || ' ������ ��й�ȣ�� �����߽��ϴ�.');
        COMMIT;
    ELSE    
        dbms_output.put_line('��й�ȣ�� �߸� �Է��ϼ̽��ϴ�.');
    END IF;
END;

------------------------ �׽�Ʈ ---------------------------
EXEC upd_password(5, 'tiger11', 'b12348');
SELECT * FROM nf_account;
ROLLBACK