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

--5.1
INSERT INTO CRIMINALS (CRIMINAL_ID, LAST, FIRST)
  VALUES (criminal_seq.NEXTVAL, 'Capps', 'Johnny');
INSERT INTO CRIMES (CRIME_ID,CRIMINAL_ID)
  VALUES (crime_seq.NEXTVAL,criminal_seq.CURRVAL);

--5.2
CREATE INDEX lastname_index
  ON Criminals(LAST);
CREATE INDEX address_index
  ON Criminals(STREET);
CREATE INDEX phone_index
  ON Criminals(Phone);

--INSERT INTO CRIMES (CRIME_ID, CRIMINAL_ID, FIRST, STREET, CITY, STATE, ZIP, PHONE)
--  VALUES (crime_seq.NEXTVAL, 'Capps', 'Johnny', '123 Four St', 'Augusta', 'ME','12345','1234567890');