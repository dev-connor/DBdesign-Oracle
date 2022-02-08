CREATE OR REPLACE PROCEDURE set_profile_language (
    p_profile_id    VARCHAR2
    , L1            NUMBER := NULL
    , L2            NUMBER := NULL
    , L3            NUMBER := NULL
    , L4            NUMBER := NULL
    , L5            NUMBER := NULL
    , L6            NUMBER := NULL
    , L7            NUMBER := NULL
    , L8            NUMBER := NULL
    , L9            NUMBER := NULL
    , L10           NUMBER := NULL
    , L11           NUMBER := NULL
    , L12           NUMBER := NULL
    , L13           NUMBER := NULL
    , L14           NUMBER := NULL
    , L15           NUMBER := NULL
    , L16           NUMBER := NULL
    , p_lang_id     NUMBER := NULL
)
IS
    L1_char         cont_lang.cont_lang%TYPE;
    L2_char         cont_lang.cont_lang%TYPE;
    L3_char         cont_lang.cont_lang%TYPE;
    L4_char         cont_lang.cont_lang%TYPE;
    L5_char         cont_lang.cont_lang%TYPE;
    L6_char         cont_lang.cont_lang%TYPE;
    L7_char         cont_lang.cont_lang%TYPE;
    L8_char         cont_lang.cont_lang%TYPE;
    L9_char         cont_lang.cont_lang%TYPE;
    L10_char         cont_lang.cont_lang%TYPE;
    L11_char         cont_lang.cont_lang%TYPE;
    L12_char         cont_lang.cont_lang%TYPE;
    L13_char         cont_lang.cont_lang%TYPE;
    L14_char         cont_lang.cont_lang%TYPE;
    L15_char         cont_lang.cont_lang%TYPE;
    L16_char         cont_lang.cont_lang%TYPE;
    lang_char        sitelang_info.lang%TYPE;
BEGIN
    IF p_lang_id IS NOT NULL THEN
        UPDATE nf_profile
        SET lang_id = p_lang_id
        WHERE profile_id = p_profile_id;
        
        SELECT lang INTO lang_char FROM sitelang_info WHERE lang_id = p_lang_id;
    END IF;
    
    -- 모든 언어 체크해제
    DELETE FROM pro_cont_lang WHERE profile_id = p_profile_id;
    
    -- 선택한 언어 체크
    IF L1 IS NOT NULL THEN
        INSERT INTO pro_cont_lang
        VALUES (
            p_profile_id || '_' || L1
            , p_profile_id
            , L1);
        SELECT cont_lang INTO L1_char FROM cont_lang WHERE cont_lang_id = L1;
    END IF;
            
    IF L2 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L2, p_profile_id, L2); SELECT cont_lang INTO L2_char FROM cont_lang WHERE cont_lang_id = L2; END IF;
    IF L3 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L3, p_profile_id, L3); SELECT cont_lang INTO L3_char FROM cont_lang WHERE cont_lang_id = L3; END IF;
    IF L4 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L4, p_profile_id, L4); SELECT cont_lang INTO L4_char FROM cont_lang WHERE cont_lang_id = L4; END IF;
    IF L5 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L5, p_profile_id, L5); SELECT cont_lang INTO L5_char FROM cont_lang WHERE cont_lang_id = L5; END IF;
    IF L6 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L6, p_profile_id, L6); SELECT cont_lang INTO L6_char FROM cont_lang WHERE cont_lang_id = L6; END IF;
    IF L7 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L7, p_profile_id, L7); SELECT cont_lang INTO L7_char FROM cont_lang WHERE cont_lang_id = L7; END IF;
    IF L8 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L8, p_profile_id, L8); SELECT cont_lang INTO L8_char FROM cont_lang WHERE cont_lang_id = L8; END IF;
    IF L9 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L9, p_profile_id, L9); SELECT cont_lang INTO L9_char FROM cont_lang WHERE cont_lang_id = L9; END IF;
    IF L10 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L10, p_profile_id, L10); SELECT cont_lang INTO L10_char FROM cont_lang WHERE cont_lang_id = L10; END IF;
    IF L11 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L11, p_profile_id, L11); SELECT cont_lang INTO L11_char FROM cont_lang WHERE cont_lang_id = L11; END IF;
    IF L12 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L12, p_profile_id, L12); SELECT cont_lang INTO L12_char FROM cont_lang WHERE cont_lang_id = L12; END IF;
    IF L13 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L13, p_profile_id, L13); SELECT cont_lang INTO L13_char FROM cont_lang WHERE cont_lang_id = L13; END IF;
    IF L14 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L14, p_profile_id, L14); SELECT cont_lang INTO L14_char FROM cont_lang WHERE cont_lang_id = L14; END IF;
    IF L15 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L15, p_profile_id, L15); SELECT cont_lang INTO L15_char FROM cont_lang WHERE cont_lang_id = L15; END IF;
    IF L16 IS NOT NULL THEN INSERT INTO pro_cont_lang VALUES (p_profile_id || '_' || L16, p_profile_id, L16); SELECT cont_lang INTO L16_char FROM cont_lang WHERE cont_lang_id = L16; END IF;
    
    IF p_lang_id IS NOT NULL THEN
        dbms_output.put_line('사용자가 ' || lang_char || ' 로 사이트 표시언어를 변경했습니다.');
    END IF;
    
    IF L1 IS NOT NULL THEN dbms_output.put('사용자가 ' || L1_char); END IF;
    IF L2 IS NOT NULL THEN dbms_output.put(', ' || L2_char); END IF;
    IF L3 IS NOT NULL THEN dbms_output.put(', ' || L3_char); END IF;
    IF L4 IS NOT NULL THEN dbms_output.put(', ' || L4_char); END IF;
    IF L5 IS NOT NULL THEN dbms_output.put(', ' || L5_char); END IF;
    IF L6 IS NOT NULL THEN dbms_output.put(', ' || L6_char); END IF;
    IF L7 IS NOT NULL THEN dbms_output.put(', ' || L7_char); END IF;
    IF L8 IS NOT NULL THEN dbms_output.put(', ' || L8_char); END IF;
    IF L9 IS NOT NULL THEN dbms_output.put(', ' || L9_char); END IF;
    IF L10 IS NOT NULL THEN dbms_output.put(', ' || L10_char); END IF;
    IF L11 IS NOT NULL THEN dbms_output.put(', ' || L11_char); END IF;
    IF L12 IS NOT NULL THEN dbms_output.put(', ' || L12_char); END IF;
    IF L13 IS NOT NULL THEN dbms_output.put(', ' || L13_char); END IF;
    IF L14 IS NOT NULL THEN dbms_output.put(', ' || L14_char); END IF;
    IF L15 IS NOT NULL THEN dbms_output.put(', ' || L15_char); END IF;
    IF L16 IS NOT NULL THEN dbms_output.put(', ' || L16_char); END IF;
    
    IF L1 IS NOT NULL THEN
        dbms_output.put_line(' 언어를 컨텐츠 언어로 설정했습니다.');
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN dup_val_on_index THEN
        dbms_output.put_line('컨텐츠 언어를 중복할 수 없습니다.');
END;

------------------------ 테스트 ---------------------------

-- 프로필ID, 컨텐츠언어ID..., 표시언어ID (컨텐츠언어를 0개 ~ 16개 까지 넣을 수 있다.) 사이트 언어(표시언어) 는 생략할 수 있다.
EXEC set_profile_language('000001_1', 3, 5, 12, p_lang_id => 4);
SELECT * FROM pro_cont_lang ORDER BY profile_id, cont_lang_id;
SELECT * FROM nf_profile;
SELECT * FROM cont_lang;
DELETE FROM pro_cont_lang WHERE profile_id = '000001_1' AND cont_lang_id > 1;COMMIT;
ROLLBACK;

