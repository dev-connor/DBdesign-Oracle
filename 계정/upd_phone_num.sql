CREATE OR REPLACE PROCEDURE upd_phone_num (
    p_acc_id          nf_account.acc_id%TYPE
    , confirm_code    NUMBER
    , new_phone_num   nf_account.phone_num%TYPE
)
IS
    v_email           nf_account.email%TYPE;
    v_phone_num           nf_account.phone_num%TYPE;
BEGIN
    SELECT email, phone_num INTO v_email, v_phone_num FROM nf_account WHERE acc_id = p_acc_id;
    
    IF confirm_code = 210818 THEN
        UPDATE nf_account
        SET phone_num = new_phone_num
        WHERE acc_id = p_acc_id;
        
        dbms_output.put_line(v_email || ' ������ �޴�����ȣ�� ' 
            || chr(10) || v_phone_num || ' ���� ' || new_phone_num || ' (��)�� �����߽��ϴ�.');
        COMMIT;
    ELSE    
        dbms_output.put_line('����Ȯ�� �ڵ带 �߸� �Է��ϼ̽��ϴ�.');
    END IF;
END;

------------------------ �׽�Ʈ ---------------------------

-- ����Ȯ�� �ʿ�: ���ڷ� �ڵ� �ޱ�, �̸��Ϸ� �ڵ� �ޱ�, ���� ���� Ȯ�� (ī���ȣ �� ���ڸ�) -> �ڵ�: 210818
EXEC upd_phone_num(3, 210818, '010-9427-2835');
SELECT * FROM nf_account;
ROLLBACK;