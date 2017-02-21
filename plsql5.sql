 CREATE OR REPLACE PROCEDURE disp_stud(class_id IN VARCHAR2,RC OUT SYS_REFCURSOR,output OUT number) IS
classid_check number;
check_b# number;
BEGIN
select COUNT(classid) into classid_check from classes where classid in (class_id);
IF classid_check = 0 THEN
	output := 1;
        DBMS_OUTPUT.PUT_LINE('The class ID is invalid');
	return;
END IF;
select COUNT(b#) into check_b# from enrollments where classid in (class_id);
IF check_b# = 0 THEN
	output := 2;
        DBMS_OUTPUT.PUT_LINE('No Student has enrolled in the class');
	return;
END IF;

	open rc for select s.b#, s.firstname, co.title, c.classid  from 
	classes c,courses co, enrollments e, students s 
	where c.classid in (class_id) and 
	c.classid in (e.classid) and co.course# in (c.course#) and 
	s.b# in (select e.b# from enrollments where c.classid in (class_id) and 
	c.classid in (e.classid));   
	

END;
/
show errors

--variable out number
--variable rc refcursor;

--exec disp_stud('B111',:out,:rc );
--print out;
--print rc;


