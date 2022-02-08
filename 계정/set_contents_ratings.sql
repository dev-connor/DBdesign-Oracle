CREATE OR REPLACE PROCEDURE set_contents_ratings (
    p_profile_id          VARCHAR2
    , p_contents_id       NUMBER
    , p_con_like          VARCHAR2
)
IS 
    v_con_like          VARCHAR2(5) := lower(p_con_like);
    v_title             VARCHAR2(4000);
    have_rating         VARCHAR2(5);
    like_char           VARCHAR2(3 char);
BEGIN
    like_char := CASE lower(p_con_like)
        WHEN 'true' THEN '좋아요'
        ELSE '싫어요'
    END;
    
    SELECT title INTO v_title FROM nf_contents WHERE contents_id = p_contents_id;

    SELECT con_like INTO have_rating
    FROM ratings
    WHERE profile_id = p_profile_id 
        AND contents_id = p_contents_id;

    UPDATE ratings
    SET rate_date = sysdate
        , con_like = v_con_like
    WHERE profile_id = p_profile_id
        AND contents_id = p_contents_id;
        
    COMMIT;
    dbms_output.put_line(v_title || ' 를(을) ' || like_char || ' 로 변경했습니다.');
EXCEPTION
    WHEN no_data_found THEN
        INSERT INTO ratings
        VALUES(
            p_profile_id || '_' || p_contents_id
            , p_profile_id
            , p_contents_id
            , sysdate
            , v_con_like
        );
        
    COMMIT;
    dbms_output.put_line(v_title || ' 를(을) ' || like_char || ' 했습니다.');
END;

------------------------ 테스트 ---------------------------
EXEC set_contents_ratings('000001_4', 300000033, 'TRUE');
ROLLBACK;
SELECT * FROM ratings;
