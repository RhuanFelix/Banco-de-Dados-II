-- drop table Ambulatorios, Medicos, Pacientes, Consultas;

CREATE TABLE Ambulatorios(
	nroa SERIAL PRIMARY KEY,
	andar INT,
	capacidade INT
);

CREATE TABLE Medicos(
	codm SERIAL PRIMARY KEY,
	cpf VARCHAR(11),
	nome VARCHAR(100),
	idade INT,
	cidade VARCHAR(100),
	nroa INT,
	FOREIGN KEY (nroa) REFERENCES Ambulatorios(nroa)
);

CREATE TABLE Pacientes(
	codp SERIAL PRIMARY KEY,
	cpf VARCHAR(11),
	nome VARCHAR(100),
	idade INT,
	cidade VARCHAR(100),
	doenca VARCHAR(100)
);

CREATE TABLE Consultas(
	codm INT,
	codp INT,
	data DATE,
	hora TIME,
	PRIMARY KEY (codm, codp),
	FOREIGN KEY (codm) REFERENCES Medicos(codm),
	FOREIGN KEY (codp) REFERENCES Pacientes(codp)
);

INSERT INTO Ambulatorios(andar, capacidade) VALUES
(1, 10),
(2, 5),
(3, 7);

select * from Ambulatorios

INSERT INTO Medicos(cpf, nome, idade, cidade, nroa) VALUES
('12345678910', 'Thiago', 37, 'João Pessoa', 2),
('54638292015', 'Eve', 28, 'João Pessoa', 1),
('19283646292', 'Sandra', 45, 'João Pessoa', 3),
('65849302926', 'João', 52, 'Belo Horizonte', 3);

INSERT INTO Pacientes(cpf, nome, idade, cidade, doenca) VALUES
('0987654321', 'José', 52, 'Guarabira', 'tuberculose'),
('5372910384', 'Maria', 32, 'Guarabira', 'hipertensão'),
('3243759835', 'João', 42, 'Guarabira', 'dengue');

INSERT INTO Consultas(codm, codp, data, hora) VALUES
(3, 1, '2025-04-13', '12:56:00'),
(1, 2, '2025-07-27', '18:06:25'),
(1, 3, '2025-07-30', '18:15:25');

CREATE VIEW Ficha as SELECT m.nome nome_medico, p.nome nome_paciente, c.hora
FROM Medicos m  INNER JOIN Consultas c
ON m.codm = c.codm INNER JOIN Pacientes p
ON c.codp = p.codp;

CREATE VIEW Medico_consulta_ambulatorio as SELECT c.hora, a.andar, m.codm
FROM Ambulatorios a INNER JOIN Medicos m
ON a.nroa = m.nroa INNER JOIN Consultas c
ON c.codm = m.codm;

CREATE VIEW Info_Medicos as SELECT m.nome nome_medico, c.data, c.hora
FROM Medicos m LEFT JOIN Consultas c
ON m.codm = c.codm;

CREATE VIEW Informacoes as SELECT p.idade idade_paciente, p.doenca, m.nome nome_medico,
a.nroa codigo_ambulatorio
FROM Ambulatorios a INNER JOIN Medicos m
ON a.nroa = m.nroa INNER JOIN Consultas c
ON c.codm = m.codm INNER JOIN Pacientes p
ON c.codp = p.codp;

SELECT * FROM Ficha;
SELECT * FROM Medico_consulta_ambulatorio;
SELECT * FROM Info_Medicos;
SELECT * FROM Informacoes;