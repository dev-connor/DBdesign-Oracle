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
    -- 로그인
    SELECT password, acc_id INTO v_password, v_acc_id
    FROM nf_account
    WHERE email = p_email;
    
    IF v_password = p_password THEN
        
        -- 디바이스 저장
        SELECT CASE round(dbms_random.value(1, 5))
                WHEN 1 THEN 'iPhone'
                WHEN 2 THEN 'Android'
                WHEN 3 THEN 'PC'
                WHEN 4 THEN 'MAC'
                WHEN 5 THEN 'Apple iPad'
            END INTO v_device
        FROM dual;
        
        dbms_output.put_line('로그인에 성공했습니다.');
        
        
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
            dbms_output.put_line('디바이스 ' || v_device || ' 를 저장했습니다.');
        ELSE 
            dbms_output.put_line('디바이스 ' || v_device || ' 등록정보가 이미 있습니다.');
        END IF;
    
        COMMIT;           
    ELSE dbms_output.put_line('비밀번호를 잘못 입력하셨습니다.' 
        || chr(10) || '다시 입력하시거나 비밀번호를 재설정하세요.');
    END IF;
EXCEPTION 
    WHEN no_data_found THEN
        dbms_output.put_line('죄송합니다.' 
            || chr(10) || '이 이메일 주소를 사용하는 계정을 찾을 수 없습니다.' 
            || chr(10) || '다시 시도하시거나 새로운 계정을 등록하세요.');
END;

------------------------ 테스트 ---------------------------
EXEC ins_signin('kor.allen@gmail.com', 'tiger7777');
SELECT * FROM streaming_dev;
SELECT * FROM nf_account;
SELECT * FROM icon_info;
DELETE FROM streaming_dev WHERE acc_id > 3;COMMIT;
