CREATE OR REPLACE PROCEDURE ins_profile (
    p_acc_id            NUMBER
    , p_pname           VARCHAR2
    , p_kids_profile    VARCHAR2
)
IS
    v_profile_id    VARCHAR2(10);
    v_kids_profile  VARCHAR2(5) := lower(p_kids_profile);
    have_one        NUMBER(1);
BEGIN
    SELECT min(substr(profile_id, 8)) INTO have_one
    FROM nf_profile
    WHERE acc_id = p_acc_id;
    
    -- 1~5 �� ������ ID ���� 
    IF have_one != 1 THEN
        v_profile_id := 1;
    ELSE 
        SELECT nvl(min(substr(profile_id, 8) + 1), 1)
            INTO v_profile_id
        FROM nf_profile
        WHERE substr(profile_id, 8) + 1 NOT IN (SELECT substr(profile_id, 8) FROM nf_profile WHERE acc_id = p_acc_id)
            AND acc_id = p_acc_id;
    END IF;
    
    v_profile_id := lpad(p_acc_id, 6, 0) || '_' || v_profile_id;
    
    -- ������ ����
    IF (lower(p_kids_profile) = 'true') THEN
        INSERT INTO nf_profile (profile_id, pname, kids_profile, acc_id, limit_id)
        VALUES (v_profile_id, p_pname, v_kids_profile, p_acc_id, 3);        
        dbms_output.put_line('Ű�� ������ ' || p_pname || '��(��) �����ƽ��ϴ�.');
    ELSE 
        INSERT INTO nf_profile (profile_id, pname, acc_id, limit_id)
        VALUES (v_profile_id, p_pname, p_acc_id, 5);
        dbms_output.put_line('������ ' || p_pname || '��(��) �����ƽ��ϴ�.');
    END IF;
    
    COMMIT;
EXCEPTION 
    WHEN OTHERS THEN
    dbms_output.put_line('�������� � ������ ������ �� �����ϴ�. (�����ʰ� ��)');
END;


------------------------ �׽�Ʈ ---------------------------
EXEC ins_profile(4, '���̾�', 'false');

SELECT * FROM nf_profile;
ROLLBACK;

DELETE FROM nf_profile WHERE profile_id = '000004_1';
COMMIT;
