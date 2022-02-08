CREATE OR REPLACE PROCEDURE upd_email (
    p_acc_id          nf_account.acc_id%TYPE
    , confirm_code    NUMBER
    , new_email       nf_account.email%TYPE
)
IS
    v_email         nf_account.email%TYPE;
BEGIN
    SELECT email INTO v_email FROM nf_account WHERE acc_id = p_acc_id;
    
    IF confirm_code = 210818 THEN
        UPDATE nf_account
        SET email = new_email
        WHERE acc_id = p_acc_id;
        
        dbms_output.put_line(v_email || ' ������ �̸����� ' || new_email || ' (��)�� �����߽��ϴ�.');
        COMMIT;
    ELSE    
        dbms_output.put_line('����Ȯ�� �ڵ带 �߸� �Է��ϼ̽��ϴ�.');
    END IF;
END;

------------------------ �׽�Ʈ ---------------------------

-- ����Ȯ�� �ʿ�: ���ڷ� �ڵ� �ޱ�, �̸��Ϸ� �ڵ� �ޱ�, ���� ���� Ȯ�� (ī���ȣ �� ���ڸ�) -> �ڵ�: 210818
EXEC upd_email(3, 210818, 'gildong@naver.com');
SELECT * FROM nf_account;
ROLLBACK;