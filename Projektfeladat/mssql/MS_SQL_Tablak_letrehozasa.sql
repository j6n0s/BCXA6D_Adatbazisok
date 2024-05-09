CREATE TABLE Versenyzok
(
   versenyzo_id   int NOT NULL,
   nev            varchar(100) NOT NULL,
   eletkor             int NOT NULL,
   nem          varchar(6) NOT NULL,
   email    varchar(255) NULL,
   CONSTRAINT ck_eletkor CHECK (eletkor >= 18),
   CONSTRAINT ck_email CHECK (email LIKE '%@%.%'),
   CONSTRAINT pk_versenyzok PRIMARY KEY (versenyzo_id)
);

CREATE TABLE Kor
(
   kor_id      int NOT NULL,
   kor_nev    varchar(100) NOT NULL,
   datum          date NOT NULL,
   helyszin      varchar(255) NULL,
   CONSTRAINT pk_kor PRIMARY KEY (kor_id)
);

CREATE TABLE Szereples
(
   szereples_id       int NOT NULL,
   versenyzo_id        int NOT NULL,
   kor_id             int NOT NULL,
   kategoria varchar(255) NULL,
   CONSTRAINT pk_szereples PRIMARY KEY (szereples_id),
   CONSTRAINT fk_szereples_versenyzo FOREIGN KEY (versenyzo_id) REFERENCES Versenyzok(versenyzo_id),
   CONSTRAINT fk_szereples_kor FOREIGN KEY (kor_id) REFERENCES Kor(kor_id)
);

CREATE TABLE Zsuri
(
   zsuri_id        int NOT NULL,
   zsuri_nev            varchar(100) NOT NULL,
   CONSTRAINT pk_zsuri PRIMARY KEY (zsuri_id)
);

CREATE TABLE Pont
(
   szereples_id         int NOT NULL,
   zsuri_id         int NOT NULL,
   pont_ertek      decimal(10, 1) NOT NULL,
   CONSTRAINT pk_pont_szereples PRIMARY KEY (szereples_id, zsuri_id),
   CONSTRAINT fk_szereples FOREIGN KEY (szereples_id) REFERENCES Szereples(szereples_id),
   CONSTRAINT fk_zsuri FOREIGN KEY (zsuri_id) REFERENCES Zsuri(zsuri_id),
   CONSTRAINT ck_pont_ertek CHECK (pont_ertek >= 1 AND pont_ertek <= 10)
);