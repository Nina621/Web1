DROP TABLE KORISNICI; 
DROP TABLE ŠIFRA_PODUZEÆA; 
DROP TABLE UNOS; 

DROP SEQUENCE seq_KORISNICI;
DROP SEQUENCE seq_ŠIFRA_PODUZEÆA;
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
'Ovdje se nalaze svi korisnici sustava, oni koji imaju ovlasti veæi od 0 moraju imati password';
comment on column KORISNICI.ID IS 
'Unique ID, primary key, veza prema foreign key-evima';
comment on column KORISNICI.EMAIL IS 
'email korisnika, mora biti unique';
comment on column KORISNICI.PASSWORD IS 
'Zaporka korisnika';
comment on column KORISNICI.OVLASTI IS 
'0-obièan korisnik, 1-admin utrke, 2-sysadmin';
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
   ŠIFRA    NUMBER(10)   NOT NULL,
   NAZIV    VARCHAR2(40) NOT NULL,
   UPDATED  TIMESTAMP    NOT NULL,
   CREATED  TIMESTAMP    NOT NULL,
   ID_UPD   NUMBER(9)    NOT NULL,
   ID_CRE   NUMBER(9)    NOT NULL, 
   CONSTRAINT pk_UNOS
      PRIMARY KEY (ID), 
   CONSTRAINT uk_unos 
      UNIQUE (ŠIFRA),	  	  
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
comment on column UNOS.ŠIFRA IS 
'Unos šifre poduzeæa koja mora biti jedinstvena';
comment on column UNOS.NAZIV IS 
'Naziv poduzeæa,npr. banke';
comment on column UNOS.UPDATED IS 
'kada je zapis zadnji put mijenjan';
comment on column UNOS.CREATED IS 
'kada je zapis kreiran';
comment on column UNOS.ID_UPD IS 
'tko je zadnji mijenajo zapis, veza na ID korisnika';
comment on column UNOS.ID_CRE IS 
'tko je kreirao zapis, veza na ID korisnika';

create table ŠIFRA_PODUZEÆA(
   ID       NUMBER(9)    NOT NULL,
   ID_ŠIFRA_PODUZEÆA    NUMBER(10)   NOT NULL,
   NAZIV    VARCHAR2(40) NOT NULL,
   ADRESA   VARCHAR2(40) NOT NULL,
   POŠTANSKI_BROJ    NUMBER(5)    NOT NULL,
   ID_IBAN     NUMBER (21)  NOT NULL,
   BANKA    VARCHAR2(40) NOT NULL,
   OIB      NUMBER(11)   NOT NULL,
   KONTAKT  NUMBER(10)   NOT NULL,
   OPIS     VARCHAR2(40) NOT NULL,
   UPDATED  TIMESTAMP    NOT NULL,
   CREATED  TIMESTAMP    NOT NULL,
   ID_UPD   NUMBER(9)    NOT NULL,
   ID_CRE   NUMBER(9)    NOT NULL, 
   CONSTRAINT pk_ŠIFRA_PODUZEÆA
      PRIMARY KEY (ID), 
   CONSTRAINT uk_šifra_poduzeæa
      UNIQUE (ID_ŠIFRA_PODUZEÆA,ID_IBAN),	  	  
   CONSTRAINT fk_šifra_poduzeæa
     FOREIGN KEY(ID_ŠIFRA_PODUZEÆA)
     REFERENCES KORISNICI(ID),
   CONSTRAINT fk_IBANŠIFRAPODUZEÆA
     FOREIGN KEY (ID_IBAN)
     REFERENCES UNOS(ID),
   CONSTRAINT fk_ŠIFPODUPD
     FOREIGN KEY(ID_UPD)
     REFERENCES KORISNICI(ID),
   CONSTRAINT fk_ŠIFPODCRE
     FOREIGN KEY (ID_CRE)
     REFERENCES KORISNICI(ID)
);


comment on table ŠIFRA_PODUZEÆA IS 
'Ako se korisnik iz tablice korisnici logira na stranicu on mora imati podatke u ovoj tablici';
comment on column ŠIFRA_PODUZEÆA.ID IS 
'Unique ID, primary key, veza prema foreign key-evima';
comment on column ŠIFRA_PODUZEÆA.ID_ŠIFRA_PODUZEÆA IS 
'Veza na tablicu korisnici, svi korisnici koji se logiraju na stranicu';
comment on column ŠIFRA_PODUZEÆA.ID_IBAN IS 
'Veza na tablicu UNOS,s tim da je IBAN jedinstven';
comment on column ŠIFRA_PODUZEÆA.ADRESA IS 
'Adresa poduzeæa, radi sigurnosti ';
comment on column ŠIFRA_PODUZEÆA.BANKA IS 
'Naziv banke ';
comment on column ŠIFRA_PODUZEÆA.OIB IS 
'OIB korisnika, radi sigurnosti korisnika';
comment on column ŠIFRA_PODUZEÆA.KONTAKT IS 
'Kontakt  korisnika, radi stupanja u kontak prilikom neke pogreške';
comment on column ŠIFRA_PODUZEÆA.OPIS IS 
'Opis se koristi radi upoznavanja samog poduzeæa u ovom slucaju banke';
comment on column ŠIFRA_PODUZEÆA.UPDATED IS 
'kada je zapis zadnji put mijenjan';
comment on column ŠIFRA_PODUZEÆA.CREATED IS 
'kada je zapis kreiran';
comment on column ŠIFRA_PODUZEÆA.ID_UPD IS 
'tko je zadnji mijenajo zapis, veza na ID korisnika';
comment on column ŠIFRA_PODUZEÆA.ID_CRE IS 
'tko je kreirao zapis, veza na ID korisnika';



CREATE SEQUENCE seq_KORISNICI
   MINVALUE 1
   MAXVALUE 999999999
   START WITH 1
   INCREMENT BY 1
   CACHE 20;
   
CREATE SEQUENCE seq_ŠIFRA_PODUZEÆA
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

CREATE OR REPLACE TRIGGER TRIG_ŠIFRA_PODUZEÆA_NI 
BEFORE INSERT ON ŠIFRA_PODUZEÆA
   FOR EACH ROW
       WHEN (new.ID IS NULL) 
BEGIN
  SELECT 
     seq_ŠIFRA_PODUZEÆA.NEXTVAL 
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
END TRIG_ŠIFRA_PODUZEÆA_NI;

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


CREATE OR REPLACE TRIGGER TRIG_ŠIFRA_PODUZEÆA_NM 
BEFORE UPDATE ON ŠIFRA_PODUZEÆA 
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
