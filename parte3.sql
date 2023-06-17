-- q1
-- 7 = Aluno A e 8 = aluno B
update contato
set contato.CODIGO_ALUNO = 8
where contato.CODIGO_ALUNO = 7;

-- q2
-- Professor nao diretor
delete from ministraturma
where ministraturma.CODIGO_PROFESSOR = 122;

delete from ministradisciplina
where ministradisciplina.CODIGO_PROFESSOR = 122;

delete from pessoa
where pessoa.CODIGO = 122;

-- Professor Diretor
delete from ministraturma
where ministraturma.CODIGO_PROFESSOR = 2;

delete from ministradisciplina
where ministradisciplina.CODIGO_PROFESSOR = 2;

-- Um professor de codigo 121 da escola do diretor de cdigo 2 removido virara diretor
update escola
set escola.CODIGO_PROFESSOR = 121
where escola.CODIGO_PROFESSOR = 2;

delete from pessoa
where pessoa.CODIGO = 2;

update pessoa
set pessoa.TITULACAO = 'Diretor'
where pessoa.CODIGO = 121;


-- Q3
-- p2 = 127 e p1 = 126
insert into ministradisciplina
(CODIGO_PROFESSOR,CODIGO_DISCIPLINA)
select 127, CODIGO_DISCIPLINA
from ministradisciplina
where ministradisciplina.CODIGO_PROFESSOR = 126 and
ministradisciplina.CODIGO_DISCIPLINA NOT IN
(select CODIGO_DISCIPLINA
from ministradisciplina
where ministradisciplina.CODIGO_PROFESSOR = 127);

update ministraturma
set ministraturma.CODIGO_PROFESSOR = 127
where ministraturma.CODIGO_PROFESSOR = 126;

