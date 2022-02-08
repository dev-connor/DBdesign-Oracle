CREATE OR REPLACE PROCEDURE upd_video_quality (
    p_profile_id            VARCHAR2
    , p_autoplay_episode    VARCHAR2
    , p_autoplay_previews   VARCHAR2
    , p_screen_info_id      NUMBER
) 
IS 
    v_pname                 VARCHAR2(50);
    v_sname                 VARCHAR2(50);
    v_sname_after           VARCHAR2(50);
BEGIN
    SELECT pname, sname INTO v_pname, v_sname
    FROM nf_profile JOIN screen_info USING(screen_info_id)
    WHERE profile_id = p_profile_id;

    UPDATE nf_profile
    SET 
        autoplay_episode = p_autoplay_episode
        , autoplay_previews = p_autoplay_previews
        , screen_info_id = p_screen_info_id
    WHERE profile_id = p_profile_id;
    
    SELECT sname INTO v_sname_after
    FROM nf_profile JOIN screen_info USING(screen_info_id)
    WHERE profile_id = p_profile_id;    
    
    COMMIT;
    dbms_output.put_line(v_pname || ' �������� ȭ�������� �����߽��ϴ�.');
    dbms_output.put_line(v_sname || ' -> ' || v_sname_after);
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('���� ������ �Դϴ�.');
END;

------------------------ �׽�Ʈ ---------------------------
EXEC upd_video_quality('000004_1', 'true', 'true', 2);
SELECT * FROM nf_profile;
ROLLBACK;
