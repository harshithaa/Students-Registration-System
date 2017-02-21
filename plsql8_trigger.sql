CREATE OR REPLACE TRIGGER trigger_drop_all BEFORE
DELETE on students
FOR EACH ROW
BEGIN


DELETE FROM enrollments where b# = :OLD.b#;
 



END;
/
show errors;
