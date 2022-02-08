CREATE OR REPLACE PROCEDURE set_profile (
    p_profile_id            VARCHAR2
    , p_icon_id             NUMBER
    , p_pname               VARCHAR2
    , p_lang_id             NUMBER
    , p_autoplay_episode    VARCHAR2
    , p_autoplay_previews   VARCHAR2
) 
IS 
    v_pname                 VARCHAR2(50);
    lang_before                 sitelang_info.lang%TYPE;
    lang_after                 sitelang_info.lang%TYPE;
    v_autoplay_episode                 nf_profile.autoplay_episode%TYPE;
    v_autoplay_previews                 nf_profile.autoplay_previews%TYPE;
    v_id                    NUMBER(38);
    have_icon_b             VARCHAR2(5);  
    ipath_before                 VARCHAR2(30);
    ipath_after                 VARCHAR2(30);
    v_icon_id               VARCHAR2(30);
BEGIN
    -- ���� �� ������ ���� ��������
    SELECT pname, lang, autoplay_episode, autoplay_previews INTO v_pname, lang_before, v_autoplay_episode , v_autoplay_previews
    FROM nf_profile JOIN sitelang_info USING(lang_id)
    WHERE profile_id = p_profile_id;
    SELECT ipath INTO ipath_after FROM icon_info WHERE icon_id = p_icon_id;
    
    -- ���� �� ������� ��������
    SELECT lang INTO lang_after FROM sitelang_info WHERE lang_id = p_lang_id;

    -- ���� �� ������ ��������
    SELECT icon_id, ipath INTO v_icon_id, ipath_before 
    FROM (
        SELECT *
        FROM icon_history JOIN icon_info USING(icon_id)
        ORDER BY fix_date DESC)
    WHERE profile_id = p_profile_id
        AND rownum = 1;

    -- ������ ������Ʈ
    UPDATE nf_profile
    SET 
        pname = p_pname
        , lang_id = p_lang_id
        , autoplay_episode = lower(p_autoplay_episode)
        , autoplay_previews = lower(p_autoplay_previews)
    WHERE profile_id = p_profile_id;
    
    print_profile(p_icon_id);


    
    SELECT CASE WHEN EXISTS(SELECT * FROM icon_history WHERE profile_id = p_profile_id AND icon_id = p_icon_id) 
        THEN 'true'
        ELSE 'false' END INTO have_icon_b
    FROM dual;
    
    -- �ֱٿ� ����� �����ܿ� ��ϵ����� �������(false) �� �̹� ��ϵ� ���(true)
    IF have_icon_b = 'false' THEN
        SELECT nvl(max(substr(history_id, 10)), 0) + 1 INTO v_id
        FROM icon_history
        WHERE profile_id = p_profile_id;
        
        INSERT INTO icon_history
        VALUES (
            p_profile_id || '_' || v_id
            , p_icon_id
            , p_profile_id
            , sysdate
        );    
        dbms_output.put_line('�ֱٿ� ����� �����ܿ� ' || ipath_after || ' ��(��) �����߽��ϴ�.');
    ELSE
        UPDATE icon_history
        SET fix_date = sysdate
        WHERE profile_id = p_profile_id
            AND icon_id = p_icon_id;
        dbms_output.put_line(ipath_after || ' �������� �ٽ� ����߽��ϴ�.');
    END IF;
    
    COMMIT;

    -- ���
    dbms_output.put_line(v_pname || '���� �������� �����߽��ϴ�.' || chr(10));
    
    IF ipath_before != ipath_after THEN
        dbms_output.put_line('�������̹���:     ' || ipath_before || '    -> ' || ipath_after);
    END IF;
    
    IF v_pname != p_pname THEN
        dbms_output.put_line('�̸�:            ' || v_pname || '   -> ' || p_pname);
    END IF;
    
    IF lang_before != lang_after THEN
        dbms_output.put_line('����Ʈ���:       ' || lang_before || ' -> ' || lang_after);
    END IF;
    
    IF v_autoplay_episode != lower(p_autoplay_episode) THEN
        dbms_output.put_line('����ȭ �ڵ����:   ' || v_autoplay_episode || '  -> ' || lower(p_autoplay_episode));
    END IF;
    
    IF v_autoplay_previews != lower(p_autoplay_previews) THEN
        dbms_output.put_line('�̸����� �ڵ����: ' || v_autoplay_previews || '  -> ' || lower(p_autoplay_previews));
    END IF;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('���� ������ �Դϴ�.');
END;

------------------------ �׽�Ʈ ---------------------------

-- ������ID, ������ID, �̸�, ���ID, ȸ�� �ڵ���� ����, �̸����� �ڵ���� ����
EXEC set_profile('000003_1', 2, '�����', 1, 'TRUE', 'TRUE');
SELECT * FROM icon_info;
SELECT * FROM icon_history ORDER BY profile_id, fix_date;
SELECT * FROM nf_profile;
SELECT * FROM sitelang_info;
ROLLBACK;

/*
    1	squid
    2	tri
    3	cir
    4	squ
    5	monkey
    6	dog
    7	cat
    8	duck
    9	pig
    10	cow
*/