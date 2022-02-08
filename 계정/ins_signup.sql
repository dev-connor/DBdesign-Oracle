-- ī�� ȸ������ ���ν���
CREATE OR REPLACE PROCEDURE ins_signup_with_card (
    p_email          VARCHAR2
    , p_password     VARCHAR2
    , p_bank         VARCHAR2
    , p_cardno       NUMBER
    , p_expired_date NUMBER
    , p_name         VARCHAR2
    , p_birth_year   NUMBER
    , p_birth_month  NUMBER
    , p_birth_date   NUMBER
    , p_membrship_id NUMBER
)
IS 
    v_acc_id          VARCHAR(6);
BEGIN
    SELECT max(acc_id) + 1 INTO v_acc_id 
    FROM nf_account;
    
    -- ���� ���̺�
    INSERT INTO nf_account (acc_id, email, password, pay_id)
        VALUES (v_acc_id, p_email, p_password, 1);
        
    -- �ſ�ī�� ���̺�
    INSERT INTO creditCard 
        VALUES (v_acc_id, p_bank, p_cardno, p_expired_date , p_name                  
        , p_birth_year || p_birth_month || p_birth_date);
    
    -- ���� ����� ���� ���̺�
    INSERT INTO acc_memb (acc_id, start_date, membrship_id) 
        VALUES (v_acc_id, sysdate, p_membrship_id );
                    
    COMMIT;
    dbms_output.put_line('ī��� ȸ�����Կ� �����߽��ϴ�.');    
END; 


-- īī�� ȸ������ ���ν���
CREATE OR REPLACE PROCEDURE ins_signup_with_kakao (
    p_email           VARCHAR2
    , p_password      VARCHAR2
    , p_phone_num     VARCHAR2
    , p_membrship_id  NUMBER
)
IS 
    v_acc_id          VARCHAR(6);
BEGIN
    SELECT max(acc_id) + 1 INTO v_acc_id 
    FROM nf_account;
    
    -- ���� ���̺�
    INSERT INTO nf_account
        VALUES (v_acc_id, p_phone_num, p_email, p_password, 2);
        
    -- īī�� ���̺�
    INSERT INTO kakaopay 
        VALUES (v_acc_id);
    
    -- ���� ����� ���� ���̺�
    INSERT INTO acc_memb (acc_id, start_date, membrship_id) 
        VALUES (v_acc_id, sysdate, p_membrship_id);
                    
    COMMIT;
    dbms_output.put_line('īī���������� ȸ�����Կ� �����߽��ϴ�.');        
END; 


-- ��Ż� ȸ������ ���ν���
CREATE OR REPLACE PROCEDURE ins_signup_with_mobile (
    p_email           VARCHAR2
    , p_password      VARCHAR2
    , p_phone_num     VARCHAR2
    , p_membrship_id  NUMBER
    , p_mname         VARCHAR2
)
IS 
    v_acc_id          VARCHAR(6);
BEGIN
    SELECT max(acc_id) + 1 INTO v_acc_id 
    FROM nf_account;
    
    -- ���� ���̺�
    INSERT INTO nf_account
        VALUES (v_acc_id, p_phone_num, p_email, p_password, 3);
        
    -- ��Ż� ���̺�
    INSERT INTO mobile 
        VALUES (v_acc_id, p_mname);
    
    -- ���� ����� ���� ���̺�
    INSERT INTO acc_memb (acc_id, start_date, membrship_id) 
        VALUES (v_acc_id, sysdate, p_membrship_id);
                    
    COMMIT;
    dbms_output.put_line('��Ż�� ȸ�����Կ� �����߽��ϴ�.');            
END; 

------------------------ �׽�Ʈ ---------------------------

-- ȸ������ (�̸���, ��й�ȣ, ����, ī���ȣ, ���ᳯ¥(YYMM), �̸�, ����(YYYY), ����, ����, ����� ID)
EXEC ins_signup_with_card('gomea_95@naver.com' , '12341234', '����', 63960204058792 , 1222 , '���̾�' , 1995 , 11 , 29, 3);
EXEC ins_signup_with_kakao('kor.turtle@gmail.com', 'abc6789', '010-9427-2830', 1);
EXEC ins_signup_with_mobile('kor.allen@gmail.com', 'tiger7777', '010-1541-2830', 2, 'LGUPLUS');

-- ���ڵ� ��ȸ
SELECT * FROM nf_account;
SELECT * FROM acc_memb;
SELECT * FROM mobile;
--SELECT * FROM kakaoPay;
SELECT * FROM creditCard;

-- ���ڵ� ����
EXEC del_account(16);

DELETE FROM nf_account WHERE acc_id > 15;
DELETE FROM acc_memb WHERE acc_id > 15;
DELETE FROM mobile WHERE acc_id > 15;
COMMIT;