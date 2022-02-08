CREATE OR REPLACE PROCEDURE ins_signin (
    p_email         VARCHAR2
    , p_password    VARCHAR2
    , p_acc_id OUT nf_account.acc_id%TYPE
)
IS
    v_password      VARCHAR2(60 char);
    v_mac_id        CHAR(17);
    exists_bool     VARCHAR2(5);
    v_device        VARCHAR2(50);
    v_acc_id        NUMBER(6);
BEGIN
    -- �α���
    SELECT password, acc_id INTO v_password, v_acc_id
    FROM nf_account
    WHERE email = p_email;
    
    IF v_password = p_password THEN
        
        -- ����̽� ����
        SELECT CASE round(dbms_random.value(1, 5))
                WHEN 1 THEN 'iPhone'
                WHEN 2 THEN 'Android'
                WHEN 3 THEN 'PC'
                WHEN 4 THEN 'MAC'
                WHEN 5 THEN 'Apple iPad'
            END INTO v_device
        FROM dual;
        
        dbms_output.put_line('�α��ο� �����߽��ϴ�.');
        
        
        SELECT CASE WHEN EXISTS (SELECT * FROM streaming_dev WHERE device = v_device AND acc_id = v_acc_id) 
                THEN 'true'
                ELSE 'false'
                END
            INTO exists_bool
        FROM dual;    
        
        IF (exists_bool = 'false') THEN
            v_mac_id := 
                regexp_replace(
                    regexp_replace(regexp_replace(
                        dbms_random.string('X', 12), '(.{2})(.{2})(.{2})(.{2})(.{2})(.{2})', '\1-\2-\3-\4-\5-\6')
                        , '[G-P]'
                        , round(dbms_random.value(0, 9))
                    ), '[Q-Z]', round(dbms_random.value(0, 9)));           
        
            INSERT INTO streaming_dev
            VALUES (v_mac_id, v_device, v_acc_id);
            dbms_output.put_line('����̽� ' || v_device || ' �� �����߽��ϴ�.');
        ELSE 
            dbms_output.put_line('����̽� ' || v_device || ' ��������� �̹� �ֽ��ϴ�.');
        END IF;
    
        COMMIT;           
    ELSE dbms_output.put_line('��й�ȣ�� �߸� �Է��ϼ̽��ϴ�.' 
        || chr(10) || '�ٽ� �Է��Ͻðų� ��й�ȣ�� �缳���ϼ���.');
    END IF;
EXCEPTION 
    WHEN no_data_found THEN
        dbms_output.put_line('�˼��մϴ�.' 
            || chr(10) || '�� �̸��� �ּҸ� ����ϴ� ������ ã�� �� �����ϴ�.' 
            || chr(10) || '�ٽ� �õ��Ͻðų� ���ο� ������ ����ϼ���.');
END;

------------------------ �׽�Ʈ ---------------------------
EXEC ins_signin('kor.allen@gmail.com', 'tiger7777');
SELECT * FROM streaming_dev;
SELECT * FROM nf_account;
SELECT * FROM icon_info;
DELETE FROM streaming_dev WHERE acc_id > 3;COMMIT;
