--ques 6

CREATE OR REPLACE PROCEDURE enroll_stu(b_# IN VARCHAR2,class_id IN VARCHAR2,output OUT number) IS
classid_check number;
check_b# number;
classsize number;
lim number;
stu_enroll_check number;
yr classes.year%TYPE;
sem classes.semester%TYPE;
overload_check number(10);
prereq_check number;
s_count number;
flag number;

BEGIN
flag := 0;

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



select class_size into classsize from classes where classid in (class_id);
select  limit into lim from classes where classid in (class_id);
IF classsize = lim  THEN
        DBMS_OUTPUT.PUT_LINE('The class is full');
	flag := 1;
	output := 3;
	return;
END IF;

select COUNT(*) into stu_enroll_check from enrollments where b# in (b_#) AND classid in 
(class_id);
IF stu_enroll_check = 1 THEN
        DBMS_OUTPUT.PUT_LINE('The student is already in the class');
	flag := 1;
	output := 4;
	return;
END IF;




select year into yr from classes where classid = class_id;
select semester into sem from classes where classid = class_id;
SELECT COUNT(classid) INTO overload_check from enrollments  where b# IN (b_#) and classid in (select classid from classes where year IN (yr) and semester IN (sem));

IF overload_check = 3 THEN
	flag := 1;
        insert into enrollments(b#,classid) values(b_#,class_id);
	DBMS_OUTPUT.PUT_LINE('You are overloaded');
	output := 5;
	return;
END IF;

IF overload_check = 4 THEN
	flag := 1;
	output := 6;
	DBMS_OUTPUT.PUT_LINE('Students cannot be enrolled in more than four classes in the same semester');
	return;
END IF;



SELECT ngrade into prereq_check from grades where lgrade in(select lgrade from enrollments where b# in (b_#) and classid in(select classid from classes where year in (yr) and 
semester in (sem) and (dept_code,course#) IN (select pre_dept_code,pre_course# from prerequisites where
    (dept_code,course#) in (select dept_code,course# from classes where classid in (class_id)))));


IF prereq_check <2  THEN
	flag := 1;
	output := 7;	
        DBMS_OUTPUT.PUT_LINE('Prerequisite not satisfied');
	return;
ELSE
	flag := 1;
	output := 8;
        insert into enrollments(b#,classid) values(b_#,class_id);
	return;
END IF;



IF flag = 0 THEN
	output := 8;
	insert into enrollments(b#,classid) values(b_#,class_id);
END IF;
END;
/
show errors

--set serveroutput on
--variable output number;
--exec enroll_stu('B002','c0007',:output);
--print output;



