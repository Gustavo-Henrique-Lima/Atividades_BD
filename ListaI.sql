#Criação das tableas
create table partido
(
	sigla varchar(40) NOT NULL,
    nome varchar(80) NOT NULL,
    primary key (sigla)
);

create table candidato(
	cpf bigint (11) NOT NULL,
    nome varchar (80) NOT NULL,
    cidade varchar (60) NOT NULL,
    estado varchar (60) NOT NULL,
    idade bigint NOT NULL,
    sexo varchar (1) NOT NULL,
	sigla_partido varchar(40) NOT NULL,
    primary key (cpf),
    FOREIGN KEY (sigla_partido) REFERENCES partido(sigla)
);

create table cargo
(
	id_cargo bigint NOT NULL,
    nome varchar(80) NOT NULL,
    primary key(id_cargo)
);

create table candidatura
(
	cpf_candidato bigint (11) NOT NULL,
    id_cargo bigint NOT NULL,
    ano bigint NOT NULL,
    PRIMARY KEY (cpf_candidato,id_cargo,ano),
    FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo),
    FOREIGN KEY (cpf_candidato) REFERENCES candidato(cpf)
);

create table candidato_eleito
(
	cpf_candidato bigint (11) NOT NULL,
    ano bigint NOT NULL,
    numero_votos bigint NOT NULL,
    PRIMARY KEY (cpf_candidato,ano),
	FOREIGN KEY (cpf_candidato) REFERENCES candidato(cpf)
);

#Inserção de dados
INSERT INTO partido VALUES ('PV','Partido verde');
INSERT INTO partido VALUES ('PC','Partido Comunista'),('PT','Partido dos trabalhadores'),('PL','Partido Liberal')
,('DEM','Democratas');

INSERT INTO candidato VALUES ('75835574895','Guilherme Rian','Belo Jardim','PE',20,'M','PC'),('0189663598','Gustavo Henrique','Balneario Camboriu','SC',21,'M','PL');
INSERT INTO candidato VALUES ('98746844058','Lula','São Paulo','SP',77,'M','PT'),('44780369874','Bolsonaro','Rio de Janeiro','RJ',66,'M','PL'),
('04784566987','Ciro Gomes','Ceara','CE',65,'M','PV'),('87459842500','Simone Tebet','Recife','PE',52,'F','PC'),
('55479632547','Tiringa','Florianopolis','SC',61,'M','PV'),('98745698741','Tiririca','Ceara','CE',66,'M','DEM'),('59875563214','Thaiga','São Paulo','SP',25,'F','DEM');
INSERT INTO candidato VALUES ('25963578444','Bernardina','Feira de Santana','BA',24,'F','PT');

INSERT INTO cargo VALUES(1,'Presidente'),(2,'Senador'),(3,'Deputado');


INSERT INTO candidatura VALUES ('98746844058',1,2020),('44780369874',1,2020),('04784566987',1,2020),('87459842500',1,2020);
INSERT INTO candidatura VALUES ('75835574895',2,2020),('0189663598',2,2020),('59875563214',2,2020);
INSERT INTO candidatura VALUES ('55479632547',3,2020),('98745698741',3,2020),('25963578444',3,2020);

INSERT INTO candidato_eleito VALUES('44780369874',2020,1500000),('75835574895',2020,5800000),('0189663598',2020,5400000),
('98745698741',2021,65000),('25963578444',2021,66000);

DROP TABLE candidato_eleito;

SELECT * FROM partido;
SELECT * FROM candidato;
SELECT * FROM cargo;
SELECT * FROM candidatura;
SELECT * FROM candidato_eleito;

#1- Listar o número de candidatos por sexo
SELECT sexo,
COUNT(*) as 'total de candidatos por sexo'
FROM candidato
GROUP BY sexo;

#2- NÃO ENTENDI O QUE SE PEDE NA QUESTÃO
#3 - Listar a maior idade dos candidatos por estado
SELECT MAX(idade) as 'maior idade dos candidatos por estado'
FROM candidato
GROUP BY estado;

#4 - Listar a menor idade dos candidatos por estado
SELECT MIN(idade) as 'menor idade dos candidatos por estado'
FROM candidato
GROUP BY estado;

#5 - Listar a menor idade dos candidatos por estado, apenas daqueles cuja idade seja menor que 26
SELECT MIN(idade) as 'menor idade dos candidatos por estado cuja idade é menor que 26'
FROM candidato
WHERE idade<26
GROUP BY estado;

#6 - Listar a menor votação dos candidatos eleitos no ano de 2020
SELECT MIN(numero_votos) as 'menor votação entre os candidatos eleitos'
FROM candidato_eleito
WHERE ano=2020;

#7 - Listar o total de cidades distintas dos candidatos
SELECT COUNT(DISTINCT cidade)
FROM candidato;

#8 - Listar os cargos em ordem alfabética
SELECT nome
FROM cargo
ORDER BY nome ASC;

#9 - Listar os nomes dos candidatos, e dos seus partidos de filiação, por ordem alfabética dos nomes dos candidatos
SELECT candidato.nome as 'nome do candidato',partido.nome as 'nome do partido'
FROM candidato
INNER JOIN partido ON candidato.sigla_partido=partido.sigla
ORDER BY candidato.nome ASC;

#10 - Listar os nomes dos candidatos, o cargo de candidatura, e o ano no qual se candidatou.
SELECT candidato.nome as 'nome do candidato',cargo.nome as 'nome do cargo', candidatura.ano as 'ano de candidatura'
FROM ((candidatura
INNER JOIN candidato ON candidatura.cpf_candidato=candidato.cpf)
INNER JOIN cargo ON candidatura.id_cargo=cargo.id_cargo);

#11 - No código da questão anterior, ordenar o resultado, primeiro em ordem alfabética
#de cargo (primeira ordenação). E em ordem alfabética de nomes de candidatos
#(segunda ordenação). Ou seja, fazer duas ordenações dentro da mesma consulta.
SELECT candidato.nome as 'nome do candidato',cargo.nome as 'nome do cargo', candidatura.ano as 'ano de candidatura'
FROM ((candidatura
INNER JOIN candidato ON candidatura.cpf_candidato=candidato.cpf)
INNER JOIN cargo ON candidatura.id_cargo=cargo.id_cargo)
ORDER BY cargo.nome ASC, candidato.nome ASC;

#12 Listar os nomes dos candidatos que se candidataram em 2020, sua idade, cidade e sigla também, além de seus respectivos cargos
SELECT candidato.nome as 'nome do candidato',candidato.idade as 'idade do candidato', candidato.cidade as 'cidade do candidato',
candidato.sigla_partido, cargo.nome as 'cargo de candidatura'
FROM ((candidatura
INNER JOIN candidato ON candidatura.cpf_candidato=candidato.cpf)
INNER JOIN cargo ON candidatura.id_cargo=cargo.id_cargo)
WHERE candidatura.ano=2020;

#13 Listar os nomes dos candidatos eleitos em 2020, e sua votação
SELECT candidato.nome as 'nome do candidato', candidato_eleito.numero_votos as 'total de votos'
FROM ((candidatura
INNER JOIN candidato ON candidatura.cpf_candidato=candidato.cpf)
INNER JOIN candidato_eleito ON candidatura.cpf_candidato=candidato_eleito.cpf_candidato)
WHERE candidatura.ano=2020;

#14 Listar o nome do candidato eleito com maior número de votos, e qual foi sua votação
SELECT candidato.nome as 'nome do candidato',candidato_eleito.numero_votos as 'total de votos'
FROM candidato_eleito
INNER JOIN candidato ON candidato_eleito.cpf_candidato=candidato.cpf
HAVING candidato_eleito.numero_votos=(SELECT MAX(numero_votos) FROM candidato_eleito);

#15 - Listar os candidatos que não são do Sudeste
SELECT * 
FROM candidato
WHERE estado !='RJ' AND estado!='SP' AND estado!='MG' AND estado !='ES'