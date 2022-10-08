CREATE TABLE setor
(
    codigo NUMBER(5) PRIMARY KEY,/*Garantindo reti��o de chave e entidade*/
    nome VARCHAR2(50) NOT NULL,
    CHECK(nome IN('financeiro','recursos humanos','comercial','outro')),/*Garantindo restri��o de dominio*/
    andar NUMBER(2),
    CHECK (andar BETWEEN 1 and 30),/*Garantindo restri��o de dominio*/
    orcamento NUMBER(20,2)
);
CREATE SEQUENCE seq_setor
    START WITH 1
    INCREMENT BY 1;
    
INSERT INTO setor VALUES (seq_setor.NEXTVAL,'comercial',10,15000);/*Ir� inserir com sucesso*/
INSERT INTO setor VALUES (seq_setor.NEXTVAL,'P&D',2,10000);/*Erro na restri��o de dominio, n�o permite inserir o departamento P&D*/
INSERT INTO setor VALUES (seq_setor.NEXTVAL,'financeiro',31,2000);/*Erro na restri��o de dominio, n�o permite inserir o andar 31*/
INSERT INTO setor VALUES (null,'outro',15,60000);/*Erro na restri��o de entidade, n�o permite inserir valor nulo para a chave primaria*/

CREATE TABLE empregado
(
    matricula NUMBER(5) NOT NULL UNIQUE,
    codigo_setor NUMBER(5),
    nome VARCHAR2(70) NOT NULL,
    idade NUMBER(3) NOT NULL,
    CHECK (idade BETWEEN 16 AND 90),
    salario NUMBER(8,2),
    CHECK(salario>0),
    FOREIGN KEY(codigo_setor) REFERENCES setor(codigo)
);
INSERT INTO empregado VALUES(1,1,'Pedro Freitas',22,2000);/*Ir� Inserir*/
INSERT INTO empregado VALUES(2,2,'Tom�s Braz',25,1500);/*Erro na restri��o referencial, valor de chave estrangeira inv�lido*/
INSERT INTO empregado VALUES(1,1,'F�bio Braz',23,1800);/*Erro na restri��o de chave passando chave primaria que j� existe*/
INSERT INTO empregado VALUES(3,1,null,19,2500);/*Erro na restri��o de entidade passando valor null para nome*/
INSERT INTO empregado VALUES(4,1,'Gustavo Henrique',15,1800);/*Erro na restri��o de dominio, passando valor n�o permitido*/