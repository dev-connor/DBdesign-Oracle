CREATE OR REPLACE PROCEDURE upd_email (
    p_acc_id          nf_account.acc_id%TYPE
    , confirm_code    NUMBER
    , new_email       nf_account.email%TYPE
)
IS
    v_email         nf_account.email%TYPE;
BEGIN
    SELECT email INTO v_email FROM nf_account WHERE acc_id = p_acc_id;
    
    IF confirm_code = 210818 THEN
        UPDATE nf_account
        SET email = new_email
        WHERE acc_id = p_acc_id;
        
        dbms_output.put_line(v_email || ' 계정의 이메일을 ' || new_email || ' (으)로 변경했습니다.');
        COMMIT;
    ELSE    
        dbms_output.put_line('본인확인 코드를 잘못 입력하셨습니다.');
    END IF;
END;

------------------------ 테스트 ---------------------------

-- 본인확인 필요: 문자로 코드 받기, 이메일로 코드 받기, 결제 정보 확인 (카드번호 뒷 네자리) -> 코드: 210818
EXEC upd_email(3, 210818, 'gildong@naver.com');
SELECT * FROM nf_account;
ROLLBACK;