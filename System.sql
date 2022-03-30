
-- kh / kh
-- 계정 생성 creat user 계정명 identified by 암호;
create user kh identified by kh;
-- 한 줄씩만 실행 시키는게 가능 (원하는 줄을 누르고 ctrl + Enter)
-- 권한 부여 -> 접속/리소스   grant 부여할 권한/롤 to 계정명;
grant connect, resource to kh;
