CREATE OR REPLACE TRIGGER trigger_drop_stu AFTER
DELETE on enrollments
FOR EACH ROW
DECLARE
    class_id VARCHAR2(150);
BEGIN
class_id := :new.classid;

update classes SET
class_size = class_size-1 where
classid = :OLD.classid;
END;
/
show errors;
