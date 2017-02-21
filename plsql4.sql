CREATE or REPLACE TYPE prearray AS VARRAY(100) OF VARCHAR2(30);
/
show errors

CREATE OR REPLACE PROCEDURE return_courses(deptcode IN varchar2,course_# IN number, output OUT prearray)
AS
indx number(10) NOT NULL := 0;
c_output prearray; 
BEGIN
indx := 0;
c_output := prearray();
for d in (select *  from prerequisites where  pre_dept_code in (deptcode) and pre_course# IN (course_#))
loop
   	indx := indx + 1;
	c_output.extend;
	c_output(indx) := d.dept_code||d.course#;
	output := c_output;
	for e in (select * from prerequisites where  pre_dept_code = d.dept_code and pre_course# =  d.course#)
	loop
		indx := indx +1;
		c_output.extend;
		c_output(indx) := e.dept_code||e.course#;
	output := c_output;
	END LOOP;
END LOOP;


END;
/
show errors


--set serveroutput on
--variable out varray;
--exec return_courses('Math','314',:out);

