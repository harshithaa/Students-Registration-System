CREATE OR REPLACE PROCEDURE drop_all_stu(b_# IN VARCHAR2,output OUT number)
IS
check_b# number;

BEGIN
select COUNT(b#) into check_b# from students where b# in (b_#);
IF check_b# = 0 THEN
        DBMS_OUTPUT.PUT_LINE('The B# is invalid');
	output := 1;
        return;
END IF;

DELETE FROM students where b# in (b_#);

END;
/
show errors

