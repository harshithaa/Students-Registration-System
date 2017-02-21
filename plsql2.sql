CREATE OR REPLACE PROCEDURE show_students(RC OUT SYS_REFCURSOR) AS
BEGIN
    OPEN rc FOR SELECT   *
                FROM     students;              
END;
/

CREATE OR REPLACE PROCEDURE show_courses(RC OUT SYS_REFCURSOR) AS
BEGIN
    OPEN rc FOR SELECT   *
                FROM     courses;
END;
/

CREATE OR REPLACE PROCEDURE show_course_credit(RC OUT SYS_REFCURSOR) AS
BEGIN
    OPEN rc FOR SELECT   *
                FROM    course_credit;
END;
/

CREATE OR REPLACE PROCEDURE show_classes(RC OUT SYS_REFCURSOR) AS
BEGIN
    OPEN rc FOR SELECT   *
                FROM     classes;
END;
/

CREATE OR REPLACE PROCEDURE show_enrollments(RC OUT SYS_REFCURSOR) AS
BEGIN
    OPEN rc FOR SELECT   *
                FROM    enrollments;
END;
/

CREATE OR REPLACE PROCEDURE show_grades(RC OUT SYS_REFCURSOR) AS
BEGIN
    OPEN rc FOR SELECT   *
                FROM     grades;
END;
/

CREATE OR REPLACE PROCEDURE show_prerequisites(RC OUT SYS_REFCURSOR) AS
BEGIN
    OPEN rc FOR SELECT   *
                FROM     prerequisites;
END;
/

CREATE OR REPLACE PROCEDURE show_logs(RC OUT SYS_REFCURSOR) AS
BEGIN
    OPEN rc FOR SELECT   *
                FROM     logs;
END;
/








