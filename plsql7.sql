--Ques 7

CREATE OR REPLACE PROCEDURE drop_stu_class(b_# IN VARCHAR2, class_id IN VARCHAR2,output OUT number) 
IS
classid_check number;
check_b# number;
stu_enroll_check number;
prereq  number;
req varchar2(150);
no_enroll number;
last_student number;
yr number;
sem char(150);

BEGIN
select COUNT(b#) into check_b# from students where b# in (b_#);
IF check_b# = 0 THEN
        DBMS_OUTPUT.PUT_LINE('The B# is invalid');
	output := 1;
        return;
END IF;	

select COUNT(classid) into classid_check from classes where classid in (class_id);
IF classid_check = 0 THEN
        DBMS_OUTPUT.PUT_LINE('The class ID is invalid');
        output := 2;
	return;
END IF;

select COUNT(*) into stu_enroll_check from enrollments where b# in (b_#) AND classid in
(class_id);
IF stu_enroll_check = 0 THEN
        DBMS_OUTPUT.PUT_LINE('The Student is not enrolled in the class');
        output := 3;
	return;
END IF;


select year into yr from classes where classid in (class_id);
select semester into sem from classes where classid in (class_id);


select DISTINCT(CONCAT(dept_code,course#)) into req from classes where (dept_code,course#) IN (select dept_code, course# from prerequisites where (pre_dept_code,pre_course#) IN
(select dept_code, course# from classes where classid in (class_id)));

select COUNT(classid) into prereq from enrollments where classid IN (select classid from classes where CONCAT(dept_code,course#) in (req)) and b# IN (b_#);

--EXCEPTION WHEN NO_DATA_FOUND THEN
  --  BEGIN
    --    IF req IS NULL THEN req := 'CCCC';END IF;
      --  IF prereq IS NULL THEN prereq := 0 ;END IF;
    --END;

IF prereq >= 1 THEN
	DBMS_OUTPUT.PUT_LINE('The drop is not permitted beacuse another class uses it as a prerequisite');
       output := 4;
	return;
ELSE
	DELETE from enrollments where b# in (b_#) AND classid in (class_id);
	select count(classid) into no_enroll from enrollments where b# in (b_#);
	select count(b#) into last_student from enrollments where classid in (class_id);
	IF no_enroll = 0 THEN
		DBMS_OUTPUT.PUT_LINE('This student is not enrolled in any classes');
		output := 51;
	END IF;	
	IF last_student = 0 THEN
		DBMS_OUTPUT.PUT_LINE('The class now has no students');
        	output := 52;	
		return;
	END IF;
return;
END IF;

END;
/
show errors

--set serveroutput on
--variable out number;
--exec drop_stu_class('B0111','c0007',:out);
--print out;
