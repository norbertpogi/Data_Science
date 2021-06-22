CREATE TABLE JOB_RESUMES (
    resume_id number,
    first_name varchar2(100),
    last_name varchar2(100),
    resume clob
);

INSERT INTO JOB_RESUMES VALUES(1, 'Norbert', 'Bautista', 'Softweare Engineer, IBM March 2020 to present

RESPONSIBILITES
Role Description:
Develop a spring boot application to read a bunch of document template and convert into
Spring rest api. Which is consume by salesforce application

2. Migrate old batch job project into spring boot application	

3. Salesforce task migrating those classic application into lwc platform

Project Description and Tools:
USAA: a financial services group of companies, offer insurance, investing and banking solutions
To members of the U.S military and veterans who have honorably served and their families

Technology used:
ALIS teamconnect.
Java 8
Gitlab
Oracle db
Control-M
Salesforce lightning web component
akka
Netty'
);
-- SELECT * FROM JOB_RESUMES;
-- SELECT SUBSTR(RESUME, 1, 30) FROM JOB_RESUMES;
-- SELECT DBMS_LOB.SUBSTR(RESUME, 30,1) FROM JOB_RESUMES; -- USE DBMS_LOB FOR BEST PRACTICES
-- SELECT LENGTH(RESUME), dbms_lob.getlength(RESUME) FROM JOB_RESUMES;