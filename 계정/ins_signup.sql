-- 카드 회원가입 프로시저
CREATE OR REPLACE PROCEDURE ins_signup_with_card (
    p_email          VARCHAR2
    , p_password     VARCHAR2
    , p_bank         VARCHAR2
    , p_cardno       NUMBER
    , p_expired_date NUMBER
    , p_name         VARCHAR2
    , p_birth_year   NUMBER
    , p_birth_month  NUMBER
    , p_birth_date   NUMBER
    , p_membrship_id NUMBER
)
IS 
    v_acc_id          VARCHAR(6);
BEGIN
    SELECT max(acc_id) + 1 INTO v_acc_id 
    FROM nf_account;
    
    -- 계정 테이블
    INSERT INTO nf_account (acc_id, email, password, pay_id)
        VALUES (v_acc_id, p_email, p_password, 1);
        
    -- 신용카드 테이블
    INSERT INTO creditCard 
        VALUES (v_acc_id, p_bank, p_cardno, p_expired_date , p_name                  
        , p_birth_year || p_birth_month || p_birth_date);
    
    -- 계정 멤버십 정보 테이블
    INSERT INTO acc_memb (acc_id, start_date, membrship_id) 
        VALUES (v_acc_id, sysdate, p_membrship_id );
                    
    COMMIT;
    dbms_output.put_line('카드로 회원가입에 성공했습니다.');    
END; 


-- 카카오 회원가입 프로시저
CREATE OR REPLACE PROCEDURE ins_signup_with_kakao (
    p_email           VARCHAR2
    , p_password      VARCHAR2
    , p_phone_num     VARCHAR2
    , p_membrship_id  NUMBER
)
IS 
    v_acc_id          VARCHAR(6);
BEGIN
    SELECT max(acc_id) + 1 INTO v_acc_id 
    FROM nf_account;
    
    -- 계정 테이블
    INSERT INTO nf_account
        VALUES (v_acc_id, p_phone_num, p_email, p_password, 2);
        
    -- 카카오 테이블
    INSERT INTO kakaopay 
        VALUES (v_acc_id);
    
    -- 계정 멤버십 정보 테이블
    INSERT INTO acc_memb (acc_id, start_date, membrship_id) 
        VALUES (v_acc_id, sysdate, p_membrship_id);
                    
    COMMIT;
    dbms_output.put_line('카카오계정으로 회원가입에 성공했습니다.');        
END; 


-- 통신사 회원가입 프로시저
CREATE OR REPLACE PROCEDURE ins_signup_with_mobile (
    p_email           VARCHAR2
    , p_password      VARCHAR2
    , p_phone_num     VARCHAR2
    , p_membrship_id  NUMBER
    , p_mname         VARCHAR2
)
IS 
    v_acc_id          VARCHAR(6);
BEGIN
    SELECT max(acc_id) + 1 INTO v_acc_id 
    FROM nf_account;
    
    -- 계정 테이블
    INSERT INTO nf_account
        VALUES (v_acc_id, p_phone_num, p_email, p_password, 3);
        
    -- 통신사 테이블
    INSERT INTO mobile 
        VALUES (v_acc_id, p_mname);
    
    -- 계정 멤버십 정보 테이블
    INSERT INTO acc_memb (acc_id, start_date, membrship_id) 
        VALUES (v_acc_id, sysdate, p_membrship_id);
                    
    COMMIT;
    dbms_output.put_line('통신사로 회원가입에 성공했습니다.');            
END; 

------------------------ 테스트 ---------------------------

-- 회원가입 (이메일, 비밀번호, 은행, 카드번호, 만료날짜(YYMM), 이름, 생년(YYYY), 생월, 생일, 멤버쉽 ID)
EXEC ins_signup_with_card('gomea_95@naver.com' , '12341234', '국민', 63960204058792 , 1222 , '라이언' , 1995 , 11 , 29, 3);
EXEC ins_signup_with_kakao('kor.turtle@gmail.com', 'abc6789', '010-9427-2830', 1);
EXEC ins_signup_with_mobile('kor.allen@gmail.com', 'tiger7777', '010-1541-2830', 2, 'LGUPLUS');

-- 레코드 조회
SELECT * FROM nf_account;
SELECT * FROM acc_memb;
SELECT * FROM mobile;
--SELECT * FROM kakaoPay;
SELECT * FROM creditCard;

-- 레코드 삭제
EXEC del_account(16);

DELETE FROM nf_account WHERE acc_id > 15;
DELETE FROM acc_memb WHERE acc_id > 15;
DELETE FROM mobile WHERE acc_id > 15;
COMMIT;