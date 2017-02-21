CREATE OR REPLACE TRIGGER trigger_enroll_stu AFTER
INSERT on enrollments 
FOR EACH ROW
DECLARE
    class_id VARCHAR2(150);
BEGIN
class_id := :new.classid;

update classes SET 
class_size = class_size+1 where
classid = :NEW.classid;
END;
/
show errors;
