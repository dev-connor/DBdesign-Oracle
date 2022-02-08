-- 계정 이메일 변경
-- 비밀번호 변경
-- 휴대폰 번호 변경 
-- 카드 결제일 변경 
-- 페이 방식 변경 



   
-- 멤버십 변경
CREATE OR REPLACE PROCEDURE up_up_acc_memb
(
    pacc_id IN acc_memb.acc_id%TYPE
    , pmembership_id acc_memb.membrship_id%TYPE
) 
IS
BEGIN  
    UPDATE acc_memb
    SET membrship_id = pmembership_id
    WHERE acc_id = pacc_id;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'OTHER EXCEPTION');
END; 
EXEC UP_UP_ACC_MEMB(1, 3);
ROLLBACK;

-- 내 멤버십 정보 알아보기 
CREATE OR REPLACE PROCEDURE up_acc_memb_info
(
    pacc_id IN acc_memb.acc_id%TYPE
)
IS
    vacc_id acc_memb.acc_id%TYPE;
    vstart_date acc_memb.start_date%TYPE;
    vmembership memb_info.membership%TYPE;
BEGIN
    vacc_id := pacc_id;
    
    SELECT m.membership, a.start_date
        INTO vmembership, vstart_date
    FROM memb_info m JOIN acc_memb a ON m.membrship_id = a.membrship_id
    WHERE a.acc_id = vacc_id;
    
    DBMS_OUTPUT.PUT_LINE( vmembership || ' > 멤버십 시작일 : ' || vstart_date );  
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'OTHER EXCEPTION');
END; 

EXEC up_acc_memb_info(2); 

-- 멤버십 정보 조회
DECLARE
    --vmembrow memb_info%ROWTYPE;
    CURSOR memb_cursor IS (SELECT * FROM memb_info);
BEGIN
    DBMS_OUTPUT.PUT_LINE( '멤버십명  ' || '  가격  ' || ' 동시시청가능수  ' || '최대기기저장수  ' || '화질' );
    FOR vmembrow IN memb_cursor
    LOOP
         DBMS_OUTPUT.PUT_LINE( RPAD(vmembrow.membership,8) || ' -  ' || RPAD(vmembrow.total,5) || '  -     ' || vmembrow.can_watch_sametime
                                || '       -       ' || vmembrow.max_storage_device || '     -    ' || vmembrow.screen_quality );
    END LOOP;
END;


-- 해당 계정의 모든 디바이스에서 로그아웃 
CREATE OR REPLACE PROCEDURE up_device_logout
(
    pacc_id IN streaming_dev.acc_id%TYPE
)
IS
BEGIN
    
    DELETE FROM streaming_dev
    WHERE acc_id = pacc_id;
    --COMMIT;
EXCEPTION
   -- WHEN NO_DATA_FOUND THEN
       -- RAISE_APPLICATION_ERROR( -20001, '해당 아이디로 로그인된 기기가 없습니다.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20000, 'OTHER EXCEPTION');
END; 

exec up_DEVICE_LOGOUT( 1 );


-- 커뮤니케이션 설정 변경
CREATE OR REPLACE PROCEDURE up_upmarketing
(
    pacc_id comm_settings.acc_id%TYPE
    , pupdates comm_settings.updates%TYPE
    , pnow_on comm_settings.now_on%TYPE
    , poffers comm_settings.offers%TYPE
    , psurveys comm_settings.surveys%TYPE
    , pkids_family comm_settings.kids_family%TYPE
    , pmessages comm_settings.messages%TYPE
    , pinformation comm_settings.information%TYPE
    , psend_agree comm_settings.send_agree%TYPE
)
IS
BEGIN
    UPDATE comm_settings
    SET updates = pupdates, now_on = pnow_on, offers = poffers, surveys = psurveys
        , kids_family = pkids_family, messages = pmessages, information = pinformation
        , send_agree = psend_agree
    WHERE acc_id = pacc_id;
    COMMIT;
END;
EXEC up_upmarketing(1, 'true', 'false', 'true', 'false','true', 'false','true', 'false');

-- 마케팅 커뮤니케이션 변경
CREATE OR REPLACE PROCEDURE up_upmarketing
(
    pacc_id comm_settings.acc_id%TYPE
)
IS
    vmarketing comm_settings.marketing%TYPE;
BEGIN
    SELECT marketing INTO vmarketing
    FROM comm_settings
    WHERE acc_id = pacc_id;
    
    IF vmarketing = 'true' THEN
        UPDATE comm_settings SET marketing = 'false' WHERE acc_id = pacc_id;
    ELSE
        UPDATE comm_settings SET marketing = 'true' WHERE acc_id = pacc_id;
    END IF;
    COMMIT;
END;
EXEC up_upmarketing(1);
SELECT * FROM comm_settings;

-- 테스터 참여 여부 변경
CREATE OR REPLACE PROCEDURE up_upnftester
(
    pacc_id comm_settings.acc_id%TYPE
)
IS
    vtester comm_settings.test_parti%TYPE;
BEGIN
    SELECT test_parti INTO vtester
    FROM comm_settings
    WHERE acc_id = pacc_id;
    
    IF vtester = 'true' THEN
        UPDATE comm_settings SET test_parti = 'false' WHERE acc_id = pacc_id;
    ELSE
        UPDATE comm_settings SET test_parti = 'true' WHERE acc_id = pacc_id;
    END IF;
    COMMIT;
END;
EXEC up_upnftester(1);


