-- q1
select e.nome, cidade.NOME
from escola as e, cidade
where cidade.CODIGO = e.CODIGO and not exists(
select *
from pessoa
where pessoa.TIPO = "Aluno"
and pessoa.CODIGO_CIDADE != e.CODIGO);

-- questao 2
select a.NOME, a.MATRICULA_ALUNO
from pessoa a
where a.TIPO = 'aluno' and (a.CODIGO not in 
										(select CODIGO_ALUNO 
										from contato));

-- questao 3
select turma.CODIGO, turma.NOME, count(*) as alunos
from turma, pessoa
where pessoa.CODIGO_TURMA = turma.CODIGO
group by(turma.CODIGO)
-- qtd de elementos em cada grupo
having count(*) > 5; 


-- q4
select p.CODIGO, p.NOME, p.TITULACAO
from pessoa as p, ministraturma as mt
where mt.CODIGO_PROFESSOR = p.CODIGO
group by p.CODIGO
having count(*) >= 3;



-- q6
select e.NOME, p.NOME
from escola as e, pessoa as p
where e.CODIGO_PROFESSOR = P.CODIGO AND
E.CODIGO_CIDADE != P.CODIGO_CIDADE;

-- q7
select e.NOME, count(distinct t.CODIGO) as turmas, count(distinct p.CODIGO) as professores
from escola e, turma t, pessoa p, ministraturma mt, ministradisciplina md, disciplina d
where e.CODIGO = t.CODIGO_ESCOLA and p.TIPO = "Professor"
and mt.CODIGO_TURMA = t.CODIGO
and mt.CODIGO_DISCIPLINA = d.CODIGO
and mt.CODIGO_PROFESSOR = p.CODIGO
and md.CODIGO_DISCIPLINA = d.CODIGO
and md.CODIGO_PROFESSOR = p.CODIGO
group by e.CODIGO;

-- q8
select escola.nome, escola.CODIGO_CIDADE, pessoa.NOME,pessoa.CODIGO_CIDADE
from escola, pessoa, turma
where escola.CODIGO = turma.CODIGO_ESCOLA and
pessoa.CODIGO_TURMA = turma.CODIGO;


-- q9
select pessoa.MATRICULA_ALUNO, pessoa.NOME,contato.CODIGO_ALUNO, contato.NOME, contato.TELEFONE
from pessoa, contato
where pessoa.TIPO = "aluno" and
pessoa.CODIGO = contato.CODIGO_ALUNO
order by pessoa.MATRICULA_ALUNO,contato.NOME;

-- q10
select pessoa.*
from pessoa,ministradisciplina,ministraturma,turma
where pessoa.CODIGO = ministradisciplina.CODIGO_PROFESSOR and
ministraturma.CODIGO_DISCIPLINA = ministradisciplina.CODIGO_DISCIPLINA and
ministraturma.CODIGO_PROFESSOR = pessoa.CODIGO and
ministraturma.CODIGO_TURMA = turma.CODIGO
group by pessoa.CODIGO
having count(*) = 1
order by pessoa.CODIGO;