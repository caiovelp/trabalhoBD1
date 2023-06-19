USE trabalhoBancoDeDados1;

-- 1) Listar o nome e a cidade das escolas onde todos os alunos residam na mesma cidade onde a escola está localizada.
-- Questão 1
SELECT
    Escola.NOME AS NOME_ESCOLA,
    Cidade.NOME AS NOME_CIDADE
FROM
    Escola, Cidade
WHERE Escola.CODIGO_CIDADE = Cidade.CODIGO AND
  NOT EXISTS (
    SELECT *
    FROM
      Pessoa
      LEFT JOIN Turma ON Pessoa.CODIGO_TURMA = Turma.CODIGO
    WHERE
      Turma.CODIGO_ESCOLA = Escola.CODIGO
      AND Pessoa.CODIGO_CIDADE <> Escola.CODIGO_CIDADE
  );

-- 2) Listar o nome e matrícula dos alunos sem nenhum contato cadastrado.
-- Questão 2
SELECT
    Pessoa.NOME,
    Pessoa.MATRICULA_ALUNO
FROM Pessoa
WHERE
    Pessoa.Tipo = 'Aluno' AND
    Pessoa.CODIGO NOT IN
    (SELECT
        Contato.CODIGO_ALUNO
    FROM
        Contato);

-- 3) Listar o código e nome das turmas com mais de 5 alunos.
-- Questão 3
SELECT
    *
FROM
    (SELECT
        Turma.CODIGO,
        Turma.NOME,
        COUNT(Pessoa.CODIGO_TURMA) AS QuantidadeAlunos
    FROM
        Pessoa, Turma
    WHERE
        Pessoa.CODIGO_TURMA IS NOT NULL AND
        Pessoa.CODIGO_TURMA = Turma.CODIGO
    GROUP BY Pessoa.CODIGO_TURMA) AS SUB
WHERE QuantidadeAlunos > 5;

-- 4) Listar o código, nome e titulação dos professores que ministram aulas para pelo menos três turmas diferentes.
-- Questão 4
SELECT
    *
FROM
    (SELECT
         Pessoa.CODIGO,
         Pessoa.NOME,
         Pessoa.TITULACAO,
        COUNT(CODIGO_PROFESSOR) AS QUANTIDADETURMAS
    FROM
        MinistraTurma, Pessoa
    WHERE
        Pessoa.CODIGO = MinistraTurma.CODIGO_PROFESSOR
    GROUP BY CODIGO_PROFESSOR) AS SUB
WHERE QUANTIDADETURMAS >= 3;

-- 5) Listar por disciplina o número de professores que podem ministrá-la e quantos efetivamente ministram a mesma para uma turma.
-- Questão 5
SELECT
    MD.CODIGO_DISCIPLINA,
    COUNT(DISTINCT MD.CODIGO_PROFESSOR) AS PROFESSORES_TOTAIS,
    COUNT(DISTINCT MT.CODIGO_PROFESSOR) AS PROFESSORES_EFETIVOS
FROM MinistraDisciplina MD
LEFT OUTER JOIN MinistraTurma MT on MD.CODIGO_PROFESSOR = MT.CODIGO_PROFESSOR and MD.CODIGO_DISCIPLINA = MT.CODIGO_DISCIPLINA
GROUP BY MD.CODIGO_DISCIPLINA;

-- 6) Listar o nome da escola e o nome dos diretores de escola que residem em cidades diferentes da cidade da escola.
-- Questão 6
SELECT
    SUB.NOME_ESCOLA,
    SUB.NOME_DIRETOR
FROM
    (SELECT
        Escola.NOME AS NOME_ESCOLA,
        Escola.CODIGO_CIDADE AS COD1,
        Pessoa.NOME AS NOME_DIRETOR,
        Pessoa.CODIGO_CIDADE AS COD2
    FROM
        Escola, Pessoa
    WHERE Escola.CODIGO_PROFESSOR = Pessoa.CODIGO) AS SUB
WHERE SUB.COD1 != SUB.COD2;

-- 7) Listar por escola o número de turmas e o número de professores que ministram alguma disciplina para turmas da escola em questão.
-- Questão 7
SELECT
    Escola.NOME as NOMEESCOLA,
    COUNT(DISTINCT Turma.CODIGO) AS TURMAS,
    COUNT(DISTINCT Pessoa.CODIGO) AS PROFESSORES
FROM
    Escola, Turma, Pessoa, MinistraTurma, MinistraDisciplina, Disciplina
WHERE
    Escola.CODIGO = Turma.CODIGO_ESCOLA AND
    Pessoa.TIPO = 'Professor' AND
    MinistraTurma.CODIGO_TURMA = Turma.CODIGO AND
    MinistraTurma.CODIGO_DISCIPLINA = Disciplina.CODIGO AND
    MinistraTurma.CODIGO_PROFESSOR = Pessoa.CODIGO AND
    MinistraDisciplina.CODIGO_DISCIPLINA = Disciplina.CODIGO AND
    MinistraDisciplina.CODIGO_PROFESSOR = Pessoa.CODIGO
GROUP BY Escola.CODIGO;

-- 8) Listar por escola a razão entre o número de alunos da escola e o número de professores que ministram alguma disciplina na escola em questão.
-- Questão 8
SELECT
    Escola.NOME as NOMEESCOLA,
    (COUNT(DISTINCT Aluno.CODIGO)/COUNT(DISTINCT Professor.CODIGO)) AS RAZAO
FROM
    Escola, Pessoa as Aluno, Pessoa as Professor, MinistraDisciplina, MinistraTurma, Turma
WHERE
    Escola.CODIGO = Turma.CODIGO_ESCOLA AND
    Aluno.CODIGO_TURMA = Turma.CODIGO AND
    MinistraDisciplina.CODIGO_PROFESSOR = Professor.CODIGO AND
    MinistraTurma.CODIGO_DISCIPLINA = MinistraDisciplina.CODIGO_DISCIPLINA AND
    MinistraTurma.CODIGO_PROFESSOR = Professor.CODIGO AND
    MinistraTurma.CODIGO_TURMA = Turma.CODIGO
GROUP BY Escola.CODIGO;

-- 9) Listar todos os contatos dos alunos informando a matrícula e nome do aluno, nome e telefone do contato, ordenado por matrícula do aluno e nome do contato.
-- Questão 9
SELECT
    Pessoa.MATRICULA_ALUNO AS MAT_ALUNO,
    Pessoa.NOME AS NOME_ALUNO,
    Contato.NOME AS NOME_CONTATO,
    Contato.TELEFONE AS TELEFONE_CONTATO
FROM
    Contato, Pessoa
WHERE
    Contato.CODIGO_ALUNO = Pessoa.CODIGO
ORDER BY Pessoa.MATRICULA_ALUNO, Contato.NOME;

-- 10) Listar todos os professores que ministram disciplinas para apenas uma turma.
-- Questão 10
SELECT
    NOME_PROFESSOR
    FROM
    (SELECT
        Pessoa.NOME AS NOME_PROFESSOR,
        COUNT(MinistraTurma.CODIGO_TURMA) AS TURMAS_MINISTRADAS
    FROM
        Pessoa, MinistraDisciplina, MinistraTurma
    WHERE
        Pessoa.CODIGO = MinistraDisciplina.CODIGO_PROFESSOR AND
        MinistraTurma.CODIGO_PROFESSOR = Pessoa.CODIGO
    GROUP BY Pessoa.CODIGO) SUB
WHERE TURMAS_MINISTRADAS = 1;
