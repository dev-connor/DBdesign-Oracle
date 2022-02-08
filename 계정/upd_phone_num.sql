CREATE OR REPLACE PROCEDURE upd_phone_num (
    p_acc_id          nf_account.acc_id%TYPE
    , confirm_code    NUMBER
    , new_phone_num   nf_account.phone_num%TYPE
)
IS
    v_email           nf_account.email%TYPE;
    v_phone_num           nf_account.phone_num%TYPE;
BEGIN
    SELECT email, phone_num INTO v_email, v_phone_num FROM nf_account WHERE acc_id = p_acc_id;
    
    IF confirm_code = 210818 THEN
        UPDATE nf_account
        SET phone_num = new_phone_num
        WHERE acc_id = p_acc_id;
        
        dbms_output.put_line(v_email || ' 계정의 휴대폰번호를 ' 
            || chr(10) || v_phone_num || ' 에서 ' || new_phone_num || ' (으)로 변경했습니다.');
        COMMIT;
    ELSE    
        dbms_output.put_line('본인확인 코드를 잘못 입력하셨습니다.');
    END IF;
END;

------------------------ 테스트 ---------------------------

-- 본인확인 필요: 문자로 코드 받기, 이메일로 코드 받기, 결제 정보 확인 (카드번호 뒷 네자리) -> 코드: 210818
EXEC upd_phone_num(3, 210818, '010-9427-2835');
SELECT * FROM nf_account;
ROLLBACK;