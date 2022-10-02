CREATE TABLE produto(
    codigo int PRIMARY KEY,
    nome varchar(70),
    marca varchar(60),
    preco DECIMAL(10,2),
    quantidade INT
);
INSERT INTO produto values(1,'Caixa de som','CCE',100,2);
INSERT INTO produto values(2,'Smart TV','Samsung',3500.50,7);
INSERT INTO produto values(3,'Geladeira Frost Free','Philco',7000,15);
INSERT INTO produto values(4,'Smart Watch','Xiaomi',700,5);
INSERT INTO produto values(5,'Cooler','Oliver',150,30);

CREATE TABLE curso
(
    codigo int PRIMARY KEY,
    nome VARCHAR(70),
    valor DECIMAL(10,2)
);

INSERT INTO curso VALUES (1,'Programação Orientada a Objetos com Java',150.99);
INSERT INTO curso VALUES (2,'MySQL do básico ao avançado',75);
INSERT INTO curso VALUES (3,'Flutter',120.50);
INSERT INTO curso VALUES (4,'Python avançado com Django FrameWork',100);
INSERT INTO curso VALUES (5,'Desenvolvimento com springboot',50);

CREATE TABLE instrutor
(
    codigo INT PRIMARY KEY,
    nome VARCHAR(70),
    telefone VARCHAR(70),
    email VARCHAR(70)
);

INSERT INTO instrutor VALUES (1,'Gustavo','8199','gustavo@gmail.com');
INSERT INTO instrutor VALUES (2,'Guilherme','8398','guilherme@gmail.com');
INSERT INTO instrutor VALUES (3,'Henrique','8294','henrique@gmail.com');
INSERT INTO instrutor VALUES (4,'Lima','8159','lima@gmail.com');
INSERT INTO instrutor VALUES (5,'Nascimento','21690','nascimento@gmail.com');
INSERT INTO instrutor VALUES (6,'Maria','8895','');
--Inicio das funçoes de texto
SELECT nome, LENGTH(nome) as tamanhoDoNome
FROM instrutor
WHERE length(nome)>=9
ORDER BY nome ASC;

SELECT CONCAT(nome,CONCAT(' está custando ',valor)) "PREÇO DOS CURSOS"
FROM curso
ORDER BY nome ASC;

SELECT UPPER(nome)"nome em caixa alta",LOWER(nome)"nome em caixa baixa",INITCAP(nome)"primeira letra em caixa alta"
FROM produto
ORDER BY nome DESC;
--Fim das funções de texto

--Inicío das funçoes númericas
SELECT SQRT(quantidade) "Raiz quadrada"
FROM produto;

SELECT nome,quantidade,POWER(quantidade,3)"Quantidade elevado ao cubo"
FROM produto
WHERE quantidade>15;

SELECT nome,ROUND(valor,2) "Valor arrendodado"
FROM curso
WHERE nome LIKE '%Java';

SELECT nome,FLOOR(valor)"Valor arredondado pra baixo"
FROM CURSO;

SELECT nome,CEIL(valor) "Valor arredondado pra cima"
FROM curso;
--Fim das funçoes númericas

--Início das funções de data
SELECT SYSDATE "Data atual"
FROM dual;

SELECT EXTRACT(YEAR FROM DATE '2022-09-28')"Ano atual"
FROM dual;

SELECT NEXT_DAY('28/09/2022','domingo') "Data do próximo domingo"
FROM dual;

SELECT LAST_DAY('28/09/2022')"Data do último dia"
FROM dual;
--Fim das funções de data

--Início das funções de conversão
SELECT SYSDATE
FROM DUAL
WHERE SYSDATE>TO_DATE('27/09/2022','dd-mm-yyyy');

SELECT nome,NVL(email,'Sem email') email
FROM instrutor;

SELECT nome,TO_CHAR(preco,'9,99,99') preco
FROM produto
WHERE preco>1000
ORDER BY nome DESC;

