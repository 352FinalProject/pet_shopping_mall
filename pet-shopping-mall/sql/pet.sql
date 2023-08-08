--==============================
-- 관리자계정 - pet계정 생성
--==============================
alter session set "_oracle_script" = true;

create user pet
identified by pet
default tablespace users;

alter user spring quota unlimited on users;

grant connect, resource to pet;

--================================
-- pet 계정
--================================








