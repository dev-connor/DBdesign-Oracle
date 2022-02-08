CREATE OR REPLACE PROCEDURE del_profile (p_profile_id VARCHAR2)
IS 
    v_pname     VARCHAR2(50);
BEGIN
    SELECT pname INTO v_pname
    FROM nf_profile
    WHERE profile_id = p_profile_id;

    DELETE FROM nf_profile WHERE profile_id = p_profile_id;
    COMMIT;
    dbms_output.put_line(v_pname || ' �������� �����߽��ϴ�.');
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('���� ������ �Դϴ�.');
END;

------------------------ �׽�Ʈ ---------------------------
EXEC del_profile('000004_1');
SELECT * FROM nf_profile;