-- q1
-- 7 = Aluno A e 8 = aluno B
UPDATE 
  Contato
SET 
  Contato.CODIGO_ALUNO = 8
WHERE 
  Contato.CODIGO_ALUNO = 7;

-- q2
-- Professor nao diretor
DELETE FROM 
  MinistraTurma
WHERE 
  MinistraTurma.CODIGO_PROFESSOR = 122;

DELETE FROM 
  MinistraDisciplina
WHERE 
  MinistraDisciplina.CODIGO_PROFESSOR = 122;

DELETE FROM 
  Pessoa
WHERE 
  Pessoa.CODIGO = 122;

-- Professor Diretor
DELETE FROM 
  MinistraTurma
WHERE 
  MinistraTurma.CODIGO_PROFESSOR = 2;

DELETE FROM 
  MinistraDisciplina
WHERE 
  MinistraDisciplina.CODIGO_PROFESSOR = 2;

-- Um professor de codigo 121 da escola do diretor de cdigo 2 removido virara diretor
UPDATE 
  Escola
SET 
  Escola.CODIGO_PROFESSOR = 121
WHERE 
  Escola.CODIGO_PROFESSOR = 2;

DELETE FROM 
  Pessoa
WHERE 
  Pessoa.CODIGO = 2;

UPDATE 
  Pessoa
SET 
  Pessoa.TITULACAO = 'Diretor'
WHERE 
  Pessoa.CODIGO = 121;


-- Q3
-- p2 = 127 e p1 = 126
INSERT INTO
  MinistraDisciplina (CODIGO_PROFESSOR,CODIGO_DISCIPLINA)
SELECT 
  127, CODIGO_DISCIPLINA
FROM 
  MinistraDisciplina
WHERE 
  MinistraDisciplina.CODIGO_PROFESSOR = 126 AND
  MinistraDisciplina.CODIGO_DISCIPLINA NOT IN
  (SELECT 
    CODIGO_DISCIPLINA
  FROM 
    MinistraDisciplina
  WHERE 
    MinistraDisciplina.CODIGO_PROFESSOR = 127);

UPDATE 
  MinistraTurma
SET 
  MinistraTurma.CODIGO_PROFESSOR = 127
WHERE 
  MinistraTurma.CODIGO_PROFESSOR = 126;
