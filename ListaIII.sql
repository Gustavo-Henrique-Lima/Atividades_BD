CREATE TABLE professor
(
   matricula NUMBER(5),
   nome VARCHAR(70) NOT NULL,
   sexo CHAR(1) NOT NULL,
   estado CHAR(2) NOT NULL,
   cidade VARCHAR(40) NOT NULL,
   whatsapp VARCHAR(15) NOT NULL,
   data_admissao DATE,
   idade NUMBER(3),
   salario NUMBER(7,2),
   PRIMARY KEY (matricula)
);

CREATE SEQUENCE seq_professor
    START WITH 1
    INCREMENT BY 1;

INSERT INTO professor VALUES(seq_professor.NEXTVAL,'Gustavo Silva','M','PE','BELO JARDIM','8199587','19/07/2020',25,15000);
INSERT INTO professor VALUES(seq_professor.NEXTVAL,'Guilherme Silva','M','PE','BELO JARDIM','819487452','15/03/2020',25,19000.50);
INSERT INTO professor VALUES(seq_professor.NEXTVAL,'Ana Freitas','F','PB','PATOS','8398745612','20/03/2019',25,2000.50);
INSERT INTO professor VALUES(seq_professor.NEXTVAL,'Louise Alcantara','F','MG','VARGINHA','5699845135','10/02/2015',40,19000.50);
INSERT INTO professor VALUES(seq_professor.NEXTVAL,'Fernanda Melo','F','PE','CARUARU','81995486521','10/02/2022',32,12000.99);
INSERT INTO professor VALUES(seq_professor.NEXTVAL,'Bob Scott','M','BH','SALVADOR','879958456985','18/06/2019',35,8500.60);
INSERT INTO professor VALUES(seq_professor.NEXTVAL,'Cleópatra','F','GO','GOIANA','115874456','18/06/2022',25,6500.15);
INSERT INTO professor VALUES(seq_professor.NEXTVAL,'Alfred','M','PB','JOÃO PESSOA','839915874','08/01/2021',34,5500.85);

/* Criar uma view que exiba em ordem alfabética os professores com salário
acima da média, e cujo whatsapp não seja do DDD 81 */
CREATE VIEW vProfessores AS
SELECT *
FROM professor
WHERE salario>(SELECT AVG(salario)FROM professor) AND whatsapp NOT LIKE '81%'
ORDER BY nome;

/* Código sql para visualizar a view acima */
SELECT * FROM vProfessores;

/* Código SQL para remover a view acima */
DROP VIEW vProfessores;

/* Criar uma view que exiba a maior idade dos professores por estado */
CREATE VIEW vMaiorIdade AS
SELECT estado,MAX(idade)AS "maior idade"
FROM professor
GROUP BY estado;

/* Código sql para visualizar a view acima */
SELECT * FROM vMaiorIdade;
/* Código SQL para remover a view acima */
DROP VIEW vMaioridadeporestado;

/* Exibir os professores com idade entre a menor idade e 35, em ordem
crescente de idade */
SELECT *
FROM professor
WHERE idade BETWEEN (SELECT MIN(IDADE) FROM PROFESSOR) AND 35
ORDER BY idade ASC;

/* Atualizar o salário do professor com a maior idade para que tenha também o
maior salário */
UPDATE professor
SET salario=(SELECT MAX(salario) FROM professor)+1
WHERE idade=(SELECT MAX(idade) FROM professor);

/* Mostrar os professores em ordem alfabética, bem como os seus salários
arredondados com apenas uma casa decimal. Outrossim, na exibição desta
consulta, dever-se-á converter o nome do professor, de forma que o primeiro
caractere de cada palavra esteja em maiúscula, e o restante em minúscula */
SELECT INITCAP(nome),ROUND(salario,1)
FROM PROFESSOR;

/* Mostrar os professores, e suas respectivas datas de admissão, mas apenas
dos docentes cujo ano de admissão é diferente de 2020 */
SELECT nome,data_admissao
FROM professor
WHERE EXTRACT(YEAR FROM data_admissao)<>2020;

/* Criar as tabelas academia (codigo, nome) e instrutor (codigo, nome, salario,
idade, cidade, estado, graduacao, codigo_academia) de modo que as Restrições
de Domínio (envolvendo os campos salario, idade e graduação), de Chave, de
Entidade, e de Integridade Referencial sejam respeitadas. */
CREATE TABLE academia
(
    codigo NUMBER(4),
    nome VARCHAR2(70) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE instrutor
(
    codigo NUMBER(8),
    nome VARCHAR2(70) NOT NULL,
    salario NUMBER(7,1),
    CHECK (salario BETWEEN 1 and 2000),
    idade NUMBER(3) NOT NULL,
    CHECK (idade BETWEEN 16 AND 90),
    cidade VARCHAR2(70) NOT NULL,
    estado VARCHAR2(2) NOT NULL,
    graduacao VARCHAR2(50),
    CHECK (graduacao IN('Educacao Fisica')),
    cod_academia NUMBER(4),
    PRIMARY KEY (codigo),
    FOREIGN KEY (cod_academia) REFERENCES academia(codigo)
);

/* Criar uma function que retorne o valor em euro de forma arredondada em duas
casas decimais, dada a cotação do euro e o valor em reais */
CREATE OR REPLACE function conversaoRealEuro (valor in number)
RETURN number
IS
    BEGIN
            return (valor / 5.16);
    END;
/* Visualizar o resultado da aplicação da função anterior*/
SELECT ROUND(conversaoRealEuro(100),2) as "Conversão de real em euro"
FROM dual;

/* Criar uma procedure para aumentar o salário dos professores, dado um
percentual de aumento */
CREATE OR REPLACE PROCEDURE aumentarSalarioProf (porcetagem NUMBER)
IS
    BEGIN
        UPDATE professor SET salario = salario * ( 1 + (porcetagem / 100) );
    END;
/* Executar a procedure anterior*/
EXEC aumentarSalarioProf(15);

/* Criar uma procedure para atualizar cidade e estado dos professores */
CREATE OR REPLACE PROCEDURE atualizarCidadeEstado
(   vMatProfessor NUMBER,
    vCidade varchar,
    vEstado char,
    vOPR char)
    IS vEXCEPTION EXCEPTION;
    BEGIN
        IF (vOPR = 'A') THEN
            UPDATE professor SET cidade = vCidade, estado = vEstado WHERE matricula = vMatProfessor;
        ELSE
            RAISE vEXCEPTION;
        END IF;
        EXCEPTION
            WHEN vEXCEPTION THEN
                RAISE_APPLICATION_ERROR(-20999,'ATENÇÃO! Operação diferente de A.', FALSE);
END atualizarCidadeEstado;
/* Executar a procedure anterior */
EXEC atualizarCidadeEstado(8,'CAMAÇARI','BA','A');
