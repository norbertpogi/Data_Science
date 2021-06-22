CREATE TABLE JOB_RESUMES2 (
    resume_id number,
    first_name varchar2(100),
    last_name varchar2(100),
    profile_picture blob
);

CREATE DIRECTORY MYIMAGES AS 'C:\MYIMAGES';
DECLARE
    src BFILE:= BFILENAME('MYIMAGES', '2015.JPG');
    dest BLOB;
BEGIN
    INSERT INTO JOB_RESUMES2 VALUES(1,'Norbert', 'Bautista', EMPTY_BLOB())
    RETURNING profile_picture INTO dest;
    dbms_lob.open(src, dbms_lob.lob_readonly);
    dbms_lob.LoadFromFile(dest,src,dbms_lob.getlength(src));
    dbms_lob.close(src);
 --   commit;
END;

-- BFILE============================================

CREATE TABLE JOB_RESUMES3 (
    resume_id number,
    first_name varchar2(100),
    last_name varchar2(100),
    profile_picture BFILE -- this will store in the external drive
);

INSERT INTO JOB_RESUMES3 VALUES(2,'NORBERT','BAUTISTA', BFILENAME('C:\MYIMAGES', '2015.JPG'));
SELECT * FROM job_resumes3;