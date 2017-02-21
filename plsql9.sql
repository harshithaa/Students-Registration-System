CREATE OR REPLACE TRIGGER log_trigger_stu AFTER
INSERT on students
FOR EACH ROW
DECLARE
    username varchar2(10);
BEGIN
select user into username from dual;
IF INSERTING THEN
        INSERT INTO logs values(s1.nextval,username,SYSDATE,'students','insert',:NEW.b#);
END IF;
END;
/
show errors;



CREATE OR REPLACE TRIGGER log_trigger_stu_delete AFTER
DELETE on students
FOR EACH ROW
DECLARE
    username varchar2(10);
BEGIN
select user into username from dual;
IF DELETING THEN
        INSERT INTO logs values(s1.nextval,username,SYSDATE,'students','delete',:OLD.b#);
END IF;

END;
/
show errors;






CREATE OR REPLACE TRIGGER log_trigger_enroll AFTER
INSERT on enrollments
FOR EACH ROW
DECLARE
username varchar2(10);
BEGIN
select user into username from dual;
IF INSERTING THEN
        INSERT INTO logs values(s1.nextval,username,SYSDATE,'Enrollments','insert',:NEW.b#||','||:NEW.classid);
END IF;
END;
/
show errors;





CREATE OR REPLACE TRIGGER log_trigger_enroll_delete AFTER
DELETE on enrollments
FOR EACH ROW
DECLARE
username varchar2(10);
BEGIN
select user into username from dual;
IF DELETING THEN
        INSERT INTO logs values(s1.nextval,username,SYSDATE,'Enrollments','delete',:OLD.b#||','||:OLD.classid);
END IF;

END;
/
show errors;



