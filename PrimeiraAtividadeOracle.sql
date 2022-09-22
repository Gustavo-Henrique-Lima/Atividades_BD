CREATE TABLE departamento
(
    id INT PRIMARY KEY,
    nome VARCHAR(70)
);

INSERT INTO departamento VALUES(1,'Diretoria');
INSERT INTO departamento VALUES(2,'RH');
INSERT INTO departamento VALUES(3,'Financeiro');
INSERT INTO departamento VALUES(4,'Engenharia');

CREATE TABLE funcionario
(
    codigo INT PRIMARY KEY,
    nome VARCHAR(80),
    idade INT,
    sexo VARCHAR(2),
    estado VARCHAR(2),
    cidade VARCHAR(70),
    tempo_de_casa INT,
    salario DECIMAL (7,2),
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

INSERT INTO funcionario VALUES(1,'Gustavo Lima',21,'M','PE','BELO JARDIM',16,15000.0,1);
INSERT INTO funcionario VALUES(2,'Ricardo Silva',18,'M','PB','PATOS',12,14500.30,4);
INSERT INTO funcionario VALUES(3,'Fabio Braz',25,'M','MG','GOVERNADOR VALADARES',6,2000.0,2);
INSERT INTO funcionario VALUES(4,'Everson Silva',23,'M','SP','Osasco',14,6000.00,3);
INSERT INTO funcionario VALUES(5,'Elaine Freitas',28,'F','AL','PENEDO',9,13000.00,3);
INSERT INTO funcionario VALUES(6,'Ana Silva',21,'F','PE','CARUARU',15,15000.00,1);
INSERT INTO funcionario VALUES(7,'Grace Rocha',35,'F','SE','ARACAJU',4,1800.00,4);
INSERT INTO funcionario VALUES(8,'Maria Fita',32,'F','PE','BELO JARDIM',6,1900.00,2);

CREATE TABLE telefones_funcionarios
(
    telefone INT,
    codigo_funcionario INT,
    PRIMARY KEY (telefone,codigo_funcionario),
    FOREIGN KEY (codigo_funcionario) REFERENCES funcionario(codigo)
);

INSERT INTO telefones_funcionarios VALUES (81998,1);
INSERT INTO telefones_funcionarios VALUES (83989,2);
INSERT INTO telefones_funcionarios VALUES (31954,3);
INSERT INTO telefones_funcionarios VALUES (119654,4);

--Criar uma view que liste os funcionários com o salário entre 1000 e 2000 reais
CREATE VIEW vSalariosEntreMilEDoisMil AS
SELECT nome
FROM funcionario
WHERE salario BETWEEN 1000 AND 2000;

SELECT * FROM vsalariosentremiledoismil;

--Criar uma view que liste o nome do funcionário com a maior idade
CREATE VIEW vFuncionarioMaisVelho AS
SELECT nome
FROM funcionario
WHERE idade=(SELECT max(idade) FROM funcionario);

SELECT * FROM vfuncionariomaisvelho;

--Criar uma view que liste o nome do vendedor com menor tempo de casa
CREATE VIEW vFuncionarioMenorTempoDeCasa AS
SELECT nome
FROM funcionario
WHERE tempo_de_casa=(SELECT min(tempo_de_casa) FROM funcionario);

SELECT * FROM vfuncionariomenortempodecasa;

--Criar uma view que liste a média salarial dos vendedores agrupados por estado
CREATE VIEW vMediaSalarioEstado AS
SELECT estado,avg(salario) As media
FROM funcionario
GROUP BY estado
ORDER BY media DESC;

SELECT * FROM vmediasalarioestado;

--Criar uma view que liste os vendedores que sejam do nordeste
CREATE VIEW vFuncionariosDoNordeste AS
SELECT nome,estado
FROM funcionario
WHERE estado IN ('AL','CE','BA','MA','PE','SE','PB','RN','PB')
ORDER BY estado ASC;

SELECT * FROM vfuncionariosdonordeste;

--Criar uma view que liste os vendedores que sejam da família silva
CREATE VIEW vFuncionariosSilva AS
SELECT nome
FROM funcionario
WHERE nome LIKE('%Silva')
ORDER BY nome;

SELECT * FROM vfuncionariossilva;

CREATE VIEW vNomeENumeroFuncionarios AS
SELECT nome,telefone
FROM funcionario,telefones_funcionarios
WHERE funcionario.codigo=telefones_funcionarios.codigo_funcionario
ORDER BY nome ASC;

SELECT * FROM vnomeenumerofuncionarios;

CREATE VIEW vGeral AS
SELECT funcionario.nome,telefones_funcionarios.telefone,departamento.nome as nomedep
FROM funcionario
INNER JOIN telefones_funcionarios 
ON telefones_funcionarios.codigo_funcionario=funcionario.codigo
INNER JOIN departamento
ON departamento.id=funcionario.id_departamento
ORDER BY nomedep;

SELECT * FROM vgeral;

