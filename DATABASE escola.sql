CREATE DATABASE escola;
USE escola; 

CREATE TABLE alunos (
	id_aluno INT PRIMARY KEY, 
    nome VARCHAR(100),
    data_nascimento DATE,
    email VARCHAR(100)
    );
    
    
CREATE TABLE cursos (
	id_curso INT PRIMARY KEY, 
    nome_curso VARCHAR(100),
    carga_horaria int
    );

CREATE TABLE matriculas (
	id_matricula INT PRIMARY KEY, 
    id_aluno INT,
    id_curso INT,
    data_matricula DATE, 
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
    );
    
ALTER TABLE alunos ADD COLUMN telefone VARCHAR(20);
-- USO DO COLUMN OBRIGATÓRIO. 

ALTER TABLE cursos MODIFY COLUMN carga_horaria SMALLINT;
-- USO DO MODIFY (MYSQL) NO LUGAR DO ALTER(POSTGRESQL).

DROP TABLE matriculas;

CREATE TABLE matriculas (
	id_matricula INT PRIMARY KEY, 
    id_aluno INT,
    id_curso INT,
    data_matricula DATE, 
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
    );
    
    INSERT INTO alunos (id_aluno, nome, data_nascimento, email, telefone)
    VALUES
    (1, 'Ana SOuza', '2005-05-10', 'ana@email.com', '11999990000'),
    (2, 'Carlos Lima', '1999-11-22', 'carlos@email.com', '11988887777');
    
    INSERT INTO cursos (id_curso, nome_curso, carga_horaria)
    VALUES
    (101, 'Lógica de Programação', 60),
    (102, 'Banco de Dados', 80);
    
    INSERT INTO matriculas (id_matricula, id_aluno, id_curso, data_matricula)
    VALUES
    (1001, 1, 101, '2024-03-10'),
    (1002, 2, 102, '2024-03-02');
    
    UPDATE alunos SET telefone = '11911112222' WHERE id_aluno = 1;
    
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM matriculas WHERE id_curso = 101;
    -- PRIMEIRO SE APAGA AS MATRICULAS RELACIONADAS AO CURSO, PARA DEPOIS APAGAR O CURSO EM SI.
    DELETE FROM cursos WHERE id_curso = 101;
    -- NÃO ESTAVA APAGANDO PELO NOME DO CURSO, E SIM PELO ID.
    SET SQL_SAFE_UPDATES = 1;
    -- ME FOI NECESÁRIO DESATIVAR O MODO SEGURO DO SQL.
    
    INSERT INTO cursos (id_curso, nome_curso, carga_horaria)
    VALUES (103, 'Lógica de Programação', 75);
    
    INSERT INTO matriculas (id_matricula, id_aluno, id_curso, data_matricula)
    VALUES
    (1003, 1, 103, '2024-03-10');
    
    SELECT * FROM alunos;
	UPDATE alunos
    SET nome = 'Ana Souza'
	WHERE id_aluno = 1;
    
	SELECT * FROM alunos;
    SELECT * FROM cursos WHERE carga_horaria > 70;
    SELECT * FROM matriculas WHERE data_matricula > '2024-03-01';
    SELECT nome, data_nascimento FROM alunos;
    SELECT * FROM cursos ORDER BY carga_horaria DESC;
    
    SELECT a.nome AS aluno, c.nome_curso AS curso
    FROM alunos a
    JOIN matriculas m ON a.id_aluno = m.id_aluno
    JOIN cursos c ON c.id_curso = m.id_curso;
    
    SELECT a.nome AS 'Nome do aluno',
		   c.nome_curso AS 'Nome do curso',
           TIMESTAMPDIFF (YEAR, a.data_nascimento, CURRENT_DATE) AS 'Idade do aluno',
           m.data_matricula AS 'Data da matrícula'
    FROM alunos a
    JOIN matriculas m ON a.id_aluno = m.id_aluno
    JOIN cursos c ON c.id_curso = m.id_curso;