create database warehouse;
show databases;
drop database testdb;
drop table spj;
CREATE TABLE S
(
SNO VARCHAR(5) PRIMARY KEY,
SNAME VARCHAR(15),
STATUS INTEGER(2),
CITY VARCHAR(10)
);

CREATE TABLE P
(
PNO VARCHAR(5) PRIMARY KEY,
PNAME VARCHAR(10),
COLOR VARCHAR(10),
WEIGHT INTEGER(2),
CITY VARCHAR(10)
);

CREATE TABLE J
(
JNO VARCHAR(5) PRIMARY KEY,
JNAME VARCHAR(10),
CITY VARCHAR(10)
);

CREATE TABLE SPJ
(
SNO VARCHAR(5) REFERENCES S(SNO),
PNO VARCHAR(5) REFERENCES P(PNO),
JNO VARCHAR(5) REFERENCES J(JNO),
QTY INTEGER(5),
PRIMARY KEY(SNO,PNO,JNO)
);

INSERT INTO S (SNO,SNAME,STATUS,CITY) VALUES
           ('S1','KRUNAL',10,'LONDON');    
INSERT INTO S (SNO,SNAME,STATUS,CITY) VALUES
           ('S2','RAMESH',5,'INDIA');    
 
INSERT INTO S (SNO,SNAME,STATUS,CITY) VALUES
           ('S3','VIVEK',4,'LONDON');    
 
INSERT INTO S (SNO,SNAME,STATUS,CITY) VALUES
            ('S4','VIMAL',3,'JAPAN');    
 
INSERT INTO S (SNO,SNAME,STATUS,CITY) VALUES
            ('S5','HEMAL',10,'KORIA');    
 
INSERT INTO S (SNO,SNAME,STATUS,CITY) VALUES
            ('S6','RAJU',2,'CHINA');    
 
INSERT INTO S (SNO,SNAME,STATUS,CITY) VALUES
            ('S7','VINU',3,'CHINA');
  
  
INSERT INTO P (PNO,PNAME,COLOR,WEIGHT,CITY) VALUES
         ('P1','PARTA','RED',45,'NEW YORK');
 
INSERT INTO P (PNO,PNAME,COLOR,WEIGHT,CITY) VALUES
                   ('P2','PARTB','WHITE',4,'LONDON');
 
INSERT INTO P (PNO,PNAME,COLOR,WEIGHT,CITY) VALUES
         ('P3','PARTC','GREY',24,'CHINA');
 
INSERT INTO P (PNO,PNAME,COLOR,WEIGHT,CITY) VALUES
         ('P4','PARTD','CYCAN',16,'CHINA');
 
INSERT INTO P (PNO,PNAME,COLOR,WEIGHT,CITY) VALUES
         ('P5','PARTE','BLACK',58,'NEW YORK');
         
		
INSERT INTO J (JNO,JNAME,CITY) VALUES
    ('J1','PRJ1','LONDON'); 
 
INSERT INTO J (JNO,JNAME,CITY) VALUES
    ('J2','PRJ2','CHINA'); 
 
 INSERT INTO J (JNO,JNAME,CITY) VALUES
    ('J3','PRJ3','CHINA'); 
 
INSERT INTO J (JNO,JNAME,CITY) VALUES
    ('J4','PRJ4','INDIA');
    

 
INSERT INTO SPJ (SNO,PNO,JNO,QTY) VALUES
    ('S1','P2','J1',300);
 
INSERT INTO SPJ (SNO,PNO,JNO,QTY) VALUES
    ('S1','P2','J2',800);
 
INSERT INTO SPJ (SNO,PNO,JNO,QTY) VALUES
    ('S3','P4','J3',115);
 
INSERT INTO SPJ (SNO,PNO,JNO,QTY) VALUES
    ('S4','P2','J4',130);
 
INSERT INTO SPJ (SNO,PNO,JNO,QTY) VALUES
    ('S1','P3','J4',75);


 

