-- Excepciones en PL/SQL
-- Excepción de retorno de varias líneas
DECLARE
    v_lname VARCHAR2(30);
BEGIN
    SELECT APECLI INTO v_lname 
    FROM CLIENTE
    WHERE NOMCLI = 'Pedro Carlos'; 
    DBMS_OUTPUT.PUT_LINE ('El Apellido de Pedro es:' ||v_lname);
EXCEPTION
    WHEN TOO_MANY_ROWS THEN
      DBMS_OUTPUT.PUT_LINE ('Tu consulta retorna mas de un registro.');
END;

-- Excepciones en PL/SQL
DECLARE
 v_number NUMBER(4);
BEGIN
 v_number := 1234;
 DECLARE
 v_number NUMBER(4);
 BEGIN
 v_number := 5678;
 v_number := 'A character string';
 END;
EXCEPTION
 WHEN OTHERS THEN
 DBMS_OUTPUT.PUT_LINE('An exception has occurred');
 DBMS_OUTPUT.PUT_LINE('The number is: ' || v_number);
END;

-- Capturando Errores No-Predefinidos de Oracle
CREATE TABLE departments (department_id INTEGER NOT NULL, department_name VARCHAR2(50) NOT NULL);
INSERT INTO departments (department_id, department_name) values (2, 'lima');

DECLARE
    e_insert_excep EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_insert_excep, -01400);
BEGIN
    INSERT INTO departments (department_id, department_name)
    VALUES (280, NULL);
  EXCEPTION
    WHEN e_insert_excep THEN
      DBMS_OUTPUT.PUT_LINE('INSERCIÓN FALLIDA.');
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
      DBMS_OUTPUT.PUT_LINE(SQLCODE);
END;

-- Excepciones Definidas por el Usuario
SET SERVEROUTPUT ON
DECLARE 
    v_deptno NUMBER := 500;
    v_name VARCHAR2(20) := 'Testing';
    e_invalid_department EXCEPTION;
BEGIN
    UPDATE departments
    SET department_name = v_name
    WHERE department_id = v_deptno;
    IF SQL%NOTFOUND THEN
      RAISE e_invalid_department;
    END IF;
    COMMIT;
EXCEPTION
  WHEN e_invalid_department THEN
    DBMS_OUTPUT.PUT_LINE(v_deptno||' No es un número de departamento Valido.');
END;
select * from departments;


-- Excepciones predefinidas por subbloques
DECLARE
	v_last_name CLIENTE.APECLI% TYPE;
BEGIN
	BEGIN
        SELECT APECLI INTO v_last_name
        FROM CLIENTE WHERE NOMCLI = 'Pedro Carlos';
        DBMS_OUTPUT.PUT_LINE('Message 1');
	EXCEPTION
        WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Message 2');
	END;
EXCEPTION
	WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE('Message 3');
END;

-- Crear tabla CLIENTE
CREATE TABLE CLIENTE (
    IDCLI  INTEGER NOT NULL,
    NOMCLI VARCHAR2(30) NOT NULL,
    APECLI VARCHAR2(30) NOT NULL,
    DNICLI CHAR(8) NOT NULL UNIQUE,
    SEXCLI CHAR(1) NOT NULL,
    TELFCLI CHAR(9),
    DIRCLI VARCHAR2(80) NOT NULL,
    IDUBI CHAR(6) NOT NULL,
    ESTCLI CHAR(1)
);
ALTER TABLE CLIENTE ADD CONSTRAINT CLIENTE_PK PRIMARY KEY ( IDCLI );
-- Crear secuencia incrementable CLIENTE
CREATE SEQUENCE incrementarCLI
START WITH 1
INCREMENT BY 1;
-- Crear disparador incrementable en la tabla CLIENTE
CREATE TRIGGER IDCLI
BEFORE INSERT ON CLIENTE
FOR EACH ROW
BEGIN
SELECT incrementarCLI.NEXTVAL INTO :NEW.IDCLI FROM DUAL;
END;
/
-- Insertar registros en la tabla CLIENTE
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Pedro Carlos', 'Vargas Campos', '45367892', 'M', '992134256', 'Los Cedros 209', '151022', 'A');
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Ana Lucia', 'Vegas Rodriguez', '69067892', 'F', '901127658', 'Jr. Ucayali N° 388', '151029', 'A');
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Francisco Eduardo', 'Llosa Gomez', '40923892', 'M', '954673213', 'Jr. Camaná 616', '151006', 'A');
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Pedro Pablo', 'Gonzales Godinez', '45360012', 'M', '900873421', 'AV Mariscal Caceres 871', '151033', 'A');
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Maria Paula', 'Rodriguez Gonzales', '56701292', 'F', '992315674', 'Av Independencia', '150728', 'A');
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Fernando Dante', 'Quispe Avalos', '67677892', 'M', '912888754', 'AV De La Poesia 160', '150712', 'A');
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Renato Maximo', 'Huaman Quispe', '73934789', 'M', '928982706', 'Av. Salaverry 801', '151021', 'A');
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Jesus Arturo', 'Gamez Llanos', '55667892', 'M', '999214565', 'JR Lima 285 Cercado', '150810', 'A');
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Rosa Flor', 'Valencia Manrique', '49909012', 'F', '900123665', 'Jr Jose C. Mariategui 429', '150718', 'A');
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Pepe Alfredo', 'Vargas Campos', '90367892', 'M', '913427654', 'Jr Manco Capac 157', '151004', 'A');
INSERT INTO CLIENTE (NOMCLI, APECLI, DNICLI, SEXCLI, TELFCLI, DIRCLI, IDUBI, ESTCLI) 
VALUES ('Pedro Carlos', 'Aurelio Laos', '90367800', 'M', '913424444', 'A.V Puerto Maldonado', '151004', 'A');
/
-- Haber que pasará
DECLARE
 v_length_of_string INTEGER;
BEGIN
 v_length_of_string := num_characters('Valle Grande');
 DBMS_OUTPUT.PUT_LINE(v_length_of_string);
END;

