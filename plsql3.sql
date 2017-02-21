
CREATE OR REPLACE PROCEDURE disp_class(stud_b# IN VARCHAR2, RC OUT 
SYS_REFCURSOR, output OUT number) IS
classid_check number;
check_b# number;
BEGIN
select COUNT(b#) into check_b# from students where b# in (stud_b#);
IF check_b# = 0 THEN
	output := 1;
	DBMS_OUTPUT.PUT_LINE('The B# is invalid');
	return;
END IF;
select COUNT(classid) into classid_check from enrollments where b# in (stud_b#);
IF classid_check = 0 THEN
	output := 2;
	DBMS_OUTPUT.PUT_LINE('The student has not taken any course');
END IF;

IF output IS NULL THEN
open rc for select c.classid, c.dept_code, c.course#, c.sect#,c.year,c.semester, e.lgrade,g.ngrade
    from classes c, enrollments e, grades g
    where e.b# in (stud_b#) and e.classid in (c.classid)
    and e.lgrade in (g.lgrade) or e.lgrade in (' ');
END IF;
END;
/
show errors

--variable rc refcursor;
--exec disp_class('B006',:rc );
--print rc;


