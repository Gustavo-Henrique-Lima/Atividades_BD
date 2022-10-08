CREATE TABLE fornecedor
(
    cod INTEGER PRIMARY KEY,
    nome VARCHAR2(60)
);
CREATE SEQUENCE seq_fornecedor
 START WITH 10
 INCREMENT BY 10;
 
 INSERT INTO fornecedor VALUES (seq_fornecedor.NEXTVAL,'Gustavo');
 INSERT INTO fornecedor VALUES (seq_fornecedor.NEXTVAL,'José');
 INSERT INTO fornecedor VALUES (seq_fornecedor.NEXTVAL,'Henrique');
 INSERT INTO fornecedor VALUES (seq_fornecedor.NEXTVAL,'Lima');
 
 SELECT * FROM fornecedor;
 SELECT seq_fornecedor.CURRVAL FROM DUAL;
 
 ALTER SEQUENCE seq_fornecedor
 INCREMENT BY 100;
 
 DROP SEQUENCE seq_fornecedor;