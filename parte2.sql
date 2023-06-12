USE trabalhoBancoDeDados1;

-- 1) Listar o nome e a cidade das escolas onde todos os alunos residam na mesma cidade onde a escola está localizada.
-- Questão 1
SELECT DISTINCT
    Pessoa.NOME AS NOMEALUNO,
    Cidade.NOME AS NOMECIDADE,
    Escola.NOME AS NOMEESCOLA
FROM
    Pessoa, Cidade, Escola
WHERE
    Tipo = 'Aluno' AND
    Escola.CODIGO_CIDADE = Cidade.CODIGO AND
    Pessoa.CODIGO_CIDADE = Escola.CODIGO_CIDADE;

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