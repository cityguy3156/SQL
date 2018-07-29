DROP TABLE  criminals CASCADE CONSTRAINTS;
DROP TABLE  crimes CASCADE CONSTRAINTS;
CREATE TABLE criminals
  (criminal_id NUMBER(6),
   last VARCHAR2(15),
   first VARCHAR2(10),
   street VARCHAR2(30),
   city VARCHAR2(20),
   state CHAR(2),
   zip CHAR(5),
   phone CHAR(10),
   v_status CHAR(1) DEFAULT 'N',
   p_status CHAR(1) DEFAULT 'N' );
CREATE TABLE crimes
  (crime_id NUMBER(9),
   criminal_id NUMBER(6),
   classification CHAR(1),
   date_charged DATE,
   status CHAR(2),
   hearing_date DATE,
   appeal_cut_date DATE);
ALTER TABLE crimes
  MODIFY (classification DEFAULT 'U');
ALTER TABLE crimes
  ADD (date_recorded DATE DEFAULT SYSDATE);
ALTER TABLE criminals
  ADD CONSTRAINT criminals_id_pk PRIMARY KEY (criminal_id);
ALTER TABLE criminals
  ADD CONSTRAINT criminals_vstatus_ck CHECK (v_status IN('Y','N'));
ALTER TABLE criminals
  ADD CONSTRAINT criminals_pstatus_ck CHECK (p_status IN('Y','N'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_id_pk PRIMARY KEY (crime_id);
ALTER TABLE crimes
  ADD CONSTRAINT crimes_class_ck CHECK (classification IN('F','M','O','U'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_status_ck CHECK (status IN('CL','CA','IA'));
ALTER TABLE crimes
  ADD CONSTRAINT crimes_criminalid_fk FOREIGN KEY (criminal_id)
             REFERENCES criminals(criminal_id);
ALTER TABLE crimes
  MODIFY (criminal_id NOT NULL);

DROP SEQUENCE criminal_seq;
CREATE SEQUENCE criminal_seq
  INCREMENT BY 1
  START WITH 1001;

DROP SEQUENCE crime_seq;
CREATE SEQUENCE crime_seq
  INCREMENT BY 1
  START WITH 1021;
  
--INSERT INTO CRIMINALS (CRIMINAL_ID, LAST, FIRST, STREET, CITY, STATE, ZIP, PHONE)
--  VALUES (crime_seq.NEXTVAL, 'Capps', 'Johnny', '123 Four St', 'Augusta', 'ME','12345','1234567890');

INSERT INTO CRIMINALS (CRIMINAL_ID, LAST, FIRST)
  VALUES (criminal_seq.NEXTVAL, 'Capps', 'Johnny');

INSERT INTO CRIMES (CRIME_ID,CRIMINAL_ID)
  VALUES (crime_seq.NEXTVAL,criminal_seq.CURRVAL);


CREATE INDEX lastname_index
  ON Criminals(LAST);
CREATE INDEX address_index
  ON Criminals(STREET);
CREATE INDEX phone_index
  ON Criminals(Phone);


--6.1
Select Alias
From Aliases
Where Alias Between 'A' AND 'C';

--6.2
SELECT Date_Charged
FROM Crimes
WHERE DATE_RECORDED BETWEEN '01-OCT-08' AND '31-OCT-08';

--6.3
SELECT Status
From Crimes
Where Status = 'IA' or Status = 'CA';

--6.4
SELECT Crime_ID, Criminal_ID, Date_Charged, Classification
From Crimes
WHERE CLASSIFICATION = 'Felony';

--6.5
SELECT Crime_ID, Criminal_ID, Date_Charged, Hearing_Date
From Crimes
WHERE (HEARING_DATE-DATE_CHARGED) > 14;

--6.6
SELECT Criminal_ID, LAST, Zip
From Criminals
WHERE Zip = 23510
ORDER BY CRIMINAL_ID;

--6.7
SELECT Crime_ID, Criminal_ID, Date_Charged, Hearing_Date
From Crimes
WHERE HEARING_DATE = Null;

--6.8
SELECT SENTENCE_ID, CRIMINAL_ID, PROB_ID
FROM SENTENCES
WHERE PROB_ID IS NOT NULL;

--6.9
SELECT Crime_ID, Criminal_ID, Classification, STATUS
From Crimes
WHERE CLASSIFICATION = 'Felony' AND STATUS = 'Appeal';

--6.10
SELECT CHARGE_ID, CRIME_ID, FINE_AMOUNT, COURT_FEE, AMOUNT_PAID
From CRIME_CHARGES
WHERE COURT_FEE IS NOT NULL;

--6.11
SELECT OFFICER_ID, LAST, PRECINCT, STATUS
From OFFICERS
WHERE PRECINCT = 'OCVW' OR PRECINCT = 'GHNT'
ORDER BY PRECINCT, LAST;
--INSERT INTO CRIMES (CRIME_ID, CRIMINAL_ID, FIRST, STREET, CITY, STATE, ZIP, PHONE)
--  VALUES (crime_seq.NEXTVAL, 'Capps', 'Johnny', '123 Four St', 'Augusta', 'ME','12345','1234567890');