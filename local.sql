DROP TABLE KORISNICI; 
DROP TABLE �IFRA_PODUZE�A; 
DROP TABLE UNOS; 

DROP SEQUENCE seq_KORISNICI;
DROP SEQUENCE seq_�IFRA_PODUZE�A;
DROP SEQUENCE seq_UNOS;

create table KORISNICI(
   ID       NUMBER(9) NOT NULL,
   EMAIL   VARCHAR2(40) NOT NULL,
   PASSWORD VARCHAR2(20),
   OVLASTI  NUMBER(1) DEFAULT 0 NOT NULL,
   UPDATED  TIMESTAMP NOT NULL,
   CREATED  TIMESTAMP NOT NULL,
   ID_UPD   NUMBER(9) NOT NULL,
   ID_CRE   NUMBER(9) NOT NULL, 
   CONSTRAINT pk_KORISNICI 
      PRIMARY KEY (ID),
   CONSTRAINT uk_email 
      UNIQUE (EMAIL),
   CONSTRAINT ck_ovlasti
      CHECK (OVLASTI in (0,1,2))	  
);

comment on table KORISNICI IS 
'Ovdje se nalaze svi korisnici sustava, oni koji imaju ovlasti ve�i od 0 moraju imati password';
comment on column KORISNICI.ID IS 
'Unique ID, primary key, veza prema foreign key-evima';
comment on column KORISNICI.EMAIL IS 
'email korisnika, mora biti unique';
comment on column KORISNICI.PASSWORD IS 
'Zaporka korisnika';
comment on column KORISNICI.OVLASTI IS 
'0-obi�an korisnik, 1-admin utrke, 2-sysadmin';
comment on column KORISNICI.UPDATED IS 
'kada je zapis zadnji put mijenjan';
comment on column KORISNICI.CREATED IS 
'kada je zapis kreiran';
comment on column KORISNICI.ID_UPD IS 
'tko je zadnji mijenajo zapis, veza na ID korisnika';
comment on column KORISNICI.ID_CRE IS 
'tko je kreirao zapis, veza na ID korisnika';


create table UNOS(
   ID       NUMBER(9)    NOT NULL,
   �IFRA    NUMBER(10)   NOT NULL,
   NAZIV    VARCHAR2(40) NOT NULL,
   UPDATED  TIMESTAMP    NOT NULL,
   CREATED  TIMESTAMP    NOT NULL,
   ID_UPD   NUMBER(9)    NOT NULL,
   ID_CRE   NUMBER(9)    NOT NULL, 
   CONSTRAINT pk_UNOS
      PRIMARY KEY (ID), 
   CONSTRAINT uk_unos 
      UNIQUE (�IFRA),	  	  
   CONSTRAINT fk_unos2
      FOREIGN KEY (ID_UPD)
      REFERENCES KORISNICI(ID),	  
   CONSTRAINT fk_UNOS
      FOREIGN KEY (ID_CRE)
      REFERENCES KORISNICI(ID)	  	  
);

comment on table UNOS IS 
'Unos podataka'; 
comment on column UNOS.ID IS 
'Unique ID, primary key, veza prema foreign key-evima';
comment on column UNOS.�IFRA IS 
'Unos �ifre poduze�a koja mora biti jedinstvena';
comment on column UNOS.NAZIV IS 
'Naziv poduze�a,npr. banke';
comment on column UNOS.UPDATED IS 
'kada je zapis zadnji put mijenjan';
comment on column UNOS.CREATED IS 
'kada je zapis kreiran';
comment on column UNOS.ID_UPD IS 
'tko je zadnji mijenajo zapis, veza na ID korisnika';
comment on column UNOS.ID_CRE IS 
'tko je kreirao zapis, veza na ID korisnika';

create table �IFRA_PODUZE�A(
   ID       NUMBER(9)    NOT NULL,
   ID_�IFRA_PODUZE�A    NUMBER(10)   NOT NULL,
   NAZIV    VARCHAR2(40) NOT NULL,
   ADRESA   VARCHAR2(40) NOT NULL,
   PO�TANSKI_BROJ    NUMBER(5)    NOT NULL,
   ID_IBAN     NUMBER (21)  NOT NULL,
   BANKA    VARCHAR2(40) NOT NULL,
   OIB      NUMBER(11)   NOT NULL,
   KONTAKT  NUMBER(10)   NOT NULL,
   OPIS     VARCHAR2(40) NOT NULL,
   UPDATED  TIMESTAMP    NOT NULL,
   CREATED  TIMESTAMP    NOT NULL,
   ID_UPD   NUMBER(9)    NOT NULL,
   ID_CRE   NUMBER(9)    NOT NULL, 
   CONSTRAINT pk_�IFRA_PODUZE�A
      PRIMARY KEY (ID), 
   CONSTRAINT uk_�ifra_poduze�a
      UNIQUE (ID_�IFRA_PODUZE�A,ID_IBAN),	  	  
   CONSTRAINT fk_�ifra_poduze�a
     FOREIGN KEY(ID_�IFRA_PODUZE�A)
     REFERENCES KORISNICI(ID),
   CONSTRAINT fk_IBAN�IFRAPODUZE�A
     FOREIGN KEY (ID_IBAN)
     REFERENCES UNOS(ID),
   CONSTRAINT fk_�IFPODUPD
     FOREIGN KEY(ID_UPD)
     REFERENCES KORISNICI(ID),
   CONSTRAINT fk_�IFPODCRE
     FOREIGN KEY (ID_CRE)
     REFERENCES KORISNICI(ID)
);


comment on table �IFRA_PODUZE�A IS 
'Ako se korisnik iz tablice korisnici logira na stranicu on mora imati podatke u ovoj tablici';
comment on column �IFRA_PODUZE�A.ID IS 
'Unique ID, primary key, veza prema foreign key-evima';
comment on column �IFRA_PODUZE�A.ID_�IFRA_PODUZE�A IS 
'Veza na tablicu korisnici, svi korisnici koji se logiraju na stranicu';
comment on column �IFRA_PODUZE�A.ID_IBAN IS 
'Veza na tablicu UNOS,s tim da je IBAN jedinstven';
comment on column �IFRA_PODUZE�A.ADRESA IS 
'Adresa poduze�a, radi sigurnosti ';
comment on column �IFRA_PODUZE�A.BANKA IS 
'Naziv banke ';
comment on column �IFRA_PODUZE�A.OIB IS 
'OIB korisnika, radi sigurnosti korisnika';
comment on column �IFRA_PODUZE�A.KONTAKT IS 
'Kontakt  korisnika, radi stupanja u kontak prilikom neke pogre�ke';
comment on column �IFRA_PODUZE�A.OPIS IS 
'Opis se koristi radi upoznavanja samog poduze�a u ovom slucaju banke';
comment on column �IFRA_PODUZE�A.UPDATED IS 
'kada je zapis zadnji put mijenjan';
comment on column �IFRA_PODUZE�A.CREATED IS 
'kada je zapis kreiran';
comment on column �IFRA_PODUZE�A.ID_UPD IS 
'tko je zadnji mijenajo zapis, veza na ID korisnika';
comment on column �IFRA_PODUZE�A.ID_CRE IS 
'tko je kreirao zapis, veza na ID korisnika';



CREATE SEQUENCE seq_KORISNICI
   MINVALUE 1
   MAXVALUE 999999999
   START WITH 1
   INCREMENT BY 1
   CACHE 20;
   
CREATE SEQUENCE seq_�IFRA_PODUZE�A
   MINVALUE 1
   MAXVALUE 999999999
   START WITH 1
   INCREMENT BY 1
   CACHE 20;
   
CREATE SEQUENCE seq_UNOS
   MINVALUE 1
   MAXVALUE 99999999
   START WITH 1
   INCREMENT BY 1
   CACHE 20;
   
   
CREATE OR REPLACE TRIGGER TRIG_KORISNICI_NI
BEFORE INSERT ON KORISNICI
   FOR EACH ROW
       WHEN (new.ID IS NULL) 
BEGIN
  SELECT 
     seq_KORISNICI.NEXTVAL 
  INTO 
     :new.ID
  FROM dual;
  
  SELECT 
     SYSTIMESTAMP
  INTO 
     :new.UPDATED
  FROM dual;
  
  SELECT 
     SYSTIMESTAMP
  INTO 
     :new.CREATED
  FROM dual;
  
  SELECT 
     NVL(:NEW.ID_CRE, 1)
  INTO
     :NEW.ID_CRE
  FROM DUAL;
  
  SELECT 
     NVL(:NEW.ID_UPD, 1)
  INTO
     :NEW.ID_UPD
  FROM DUAL;
END TRIG_KORISNICI_NI; 

CREATE OR REPLACE TRIGGER TRIG_�IFRA_PODUZE�A_NI 
BEFORE INSERT ON �IFRA_PODUZE�A
   FOR EACH ROW
       WHEN (new.ID IS NULL) 
BEGIN
  SELECT 
     seq_�IFRA_PODUZE�A.NEXTVAL 
  INTO 
     :new.ID
  FROM dual;
  
  SELECT 
     SYSTIMESTAMP
  INTO 
     :new.UPDATED
  FROM dual;
  
  SELECT 
     SYSTIMESTAMP
  INTO 
     :new.CREATED
  FROM dual;
  
  SELECT 
     NVL(:NEW.ID_CRE, 1)
  INTO
     :NEW.ID_CRE
  FROM DUAL;
  
  SELECT 
     NVL(:NEW.ID_UPD, 1)
  INTO
     :NEW.ID_UPD
  FROM DUAL;
END TRIG_�IFRA_PODUZE�A_NI;

CREATE OR REPLACE TRIGGER TRIG_UNOS_NI 
BEFORE INSERT ON UNOS
   FOR EACH ROW
       WHEN (new.ID IS NULL) 
BEGIN
  SELECT 
     seq_UNOS.NEXTVAL 
  INTO 
     :new.ID
  FROM dual;
  
  SELECT 
     SYSTIMESTAMP
  INTO 
     :new.UPDATED
  FROM dual;
  
  SELECT 
     SYSTIMESTAMP
  INTO 
     :new.CREATED
  FROM dual;
  
  SELECT 
     NVL(:NEW.ID_CRE, 1)
  INTO
     :NEW.ID_CRE
  FROM DUAL;
  
  SELECT 
     NVL(:NEW.ID_UPD, 1)
  INTO
     :NEW.ID_UPD
  FROM DUAL;
  
END TRIG_UNOS_NI;

CREATE OR REPLACE TRIGGER TRIG_KORISNICI_NM 
BEFORE UPDATE ON KORISNICI 
FOR EACH ROW
BEGIN
  :NEW.UPDATED := SYSTIMESTAMP;
END;


CREATE OR REPLACE TRIGGER TRIG_�IFRA_PODUZE�A_NM 
BEFORE UPDATE ON �IFRA_PODUZE�A 
FOR EACH ROW
BEGIN
  :NEW.UPDATED := SYSTIMESTAMP;
END;



CREATE OR REPLACE TRIGGER TRIG_UNOS_NM 
BEFORE UPDATE ON UNOS 
FOR EACH ROW
BEGIN
  :NEW.UPDATED := SYSTIMESTAMP;
END;


INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
('DEV@VUB.HR', 'KOLIKO99', '2');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
( 'EHORVAT@VUB.HR', 'LOZINKA123', '1');
INSERT INTO KORISNICI ( EMAIL, PASSWORD,OVLASTI) VALUES 
('DKOVACEVIC@VUB.HR', null, '0');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
('IBABIC@VUB.HR', null, '0');
INSERT INTO KORISNICI ( EMAIL, PASSWORD,OVLASTI) VALUES 
('JMARIC@VUB.HR', 'JAKOV23', '1');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
('LJURIC@VUB.HR', 'PROBA1', '1');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
('DNOVAK@VUB.HR', null, '0');
INSERT INTO KORISNICI ( EMAIL, PASSWORD,OVLASTI) VALUES 
('MKOVACIC@VUB.HR', '123456', '1');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
('HVUKOVIC@VUB.HR', null, '0');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
('LKNEZEVIC@VUB.HR', 'TEST123', '1');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
( 'MMARKOVIC@VUB.HR', null, '0');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
('MPETROVIC@VUB.HR', null, '0');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
('DTOMIC@VUB.HR', null, '0');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
('IKOVAC@VUB.HR', 'IVONA65', '1');
INSERT INTO KORISNICI (EMAIL, PASSWORD,OVLASTI) VALUES 
('LPAVLOVIC@VUB.HR', null, '0');
