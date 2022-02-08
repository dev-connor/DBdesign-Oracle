CREATE OR REPLACE PROCEDURE upd_limit_age (
    p_profile_id        VARCHAR2
    , p_password        VARCHAR2
    , p_limit_id        NUMBER
    , p_kids_profile    VARCHAR2
) 
IS 
    v_pname             VARCHAR2(50);
    v_password          VARCHAR2(60 char);
    v_kids_profile      VARCHAR2(5) := lower(p_kids_profile);
BEGIN
    SELECT pname, password INTO v_pname, v_password 
    FROM nf_profile JOIN nf_account USING(acc_id)
    WHERE profile_id = p_profile_id;
    
    IF p_password = v_password THEN
        UPDATE nf_profile
        SET 
            limit_id = p_limit_id
            , kids_profile = v_kids_profile
        WHERE profile_id = p_profile_id;   
        
        dbms_output.put_line(v_pname || ' 프로필을 변경했습니다.');    
    ELSE dbms_output.put_line('비밀번호를 틀렸습니다.');    
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('없는 프로필 입니다.');
END;

------------------------ 테스트 ---------------------------
EXEC upd_limit_age('000004_1', 'b12347', 3, 'true');
SELECT * FROM nf_profile;
ROLLBACK;
