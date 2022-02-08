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
    
    -- 1~5 로 프로필 ID 생성 
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
    
    -- 프로필 생성
    IF (lower(p_kids_profile) = 'true') THEN
        INSERT INTO nf_profile (profile_id, pname, kids_profile, acc_id, limit_id)
        VALUES (v_profile_id, p_pname, v_kids_profile, p_acc_id, 3);        
        dbms_output.put_line('키즈 프로필 ' || p_pname || '이(가) 생성됐습니다.');
    ELSE 
        INSERT INTO nf_profile (profile_id, pname, acc_id, limit_id)
        VALUES (v_profile_id, p_pname, p_acc_id, 5);
        dbms_output.put_line('프로필 ' || p_pname || '이(가) 생성됐습니다.');
    END IF;
    
    COMMIT;
EXCEPTION 
    WHEN OTHERS THEN
    dbms_output.put_line('프로필을 어떤 이유로 생성할 수 없습니다. (갯수초과 등)');
END;


------------------------ 테스트 ---------------------------
EXEC ins_profile(4, '라이언', 'false');

SELECT * FROM nf_profile;
ROLLBACK;

DELETE FROM nf_profile WHERE profile_id = '000004_1';
COMMIT;
