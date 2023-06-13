-- SCRIPT SQL PARA CRIAR SCHEMA, CRIAR AS TABELAS E POPULÁ-LAS

CREATE SCHEMA trabalhoBancoDeDados1;

USE trabalhoBancoDeDados1;

-- Create Cidade table
CREATE TABLE Cidade (
  CODIGO INT NOT NULL PRIMARY KEY,
  NOME VARCHAR(100) NOT NULL
);

-- Create Turma table - Sem a FK de Escola, pois a tabela Escola não existe ainda
CREATE TABLE Turma (
  CODIGO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  NOME VARCHAR(100) NOT NULL,
  CODIGO_ESCOLA INT NOT NULL
);

-- Create Pessoa table - A garantia de NOT NULL para CODIGO_TURMA será feito via programação
CREATE TABLE Pessoa (
  CODIGO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  NOME VARCHAR(100) NOT NULL,
  TELEFONE VARCHAR(20) NOT NULL,
  TIPO VARCHAR(20) NOT NULL,
  RG VARCHAR(20),
  CPF VARCHAR(20),
  TITULACAO VARCHAR(100),
  MATRICULA_ALUNO VARCHAR(20),
  DATA_NASCIMENTO DATE,
  CODIGO_CIDADE INT NOT NULL,
  CODIGO_TURMA INT,
  FOREIGN KEY (CODIGO_TURMA) REFERENCES Turma(CODIGO),
  FOREIGN KEY (CODIGO_CIDADE) REFERENCES Cidade(CODIGO)
);

-- Create Escola table
CREATE TABLE Escola (
  CODIGO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  NOME VARCHAR(100) NOT NULL,
  CODIGO_PROFESSOR INT NOT NULL,
  CODIGO_CIDADE INT NOT NULL,
  FOREIGN KEY (CODIGO_PROFESSOR) REFERENCES Pessoa(CODIGO),
  FOREIGN KEY (CODIGO_CIDADE) REFERENCES Cidade(CODIGO)
);

-- Adiciona FK de Escola para a tabela turma já que a tabela Escola foi criada
ALTER TABLE Turma
ADD CONSTRAINT FKESCOLA FOREIGN KEY (CODIGO_ESCOLA) REFERENCES Escola(CODIGO);

-- Create Contato table
CREATE TABLE Contato (
  NOME VARCHAR(100) NOT NULL,
  TELEFONE VARCHAR(20) NOT NULL,
  CODIGO_ALUNO INT NOT NULL,
  PRIMARY KEY (NOME, CODIGO_ALUNO),
  FOREIGN KEY (CODIGO_ALUNO) REFERENCES Pessoa(CODIGO)
);

-- Create Disciplina table
CREATE TABLE Disciplina (
  CODIGO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  NOME VARCHAR(100) NOT NULL
);

-- Create MinistraDisciplina table
CREATE TABLE MinistraDisciplina (
  CODIGO_PROFESSOR INT NOT NULL,
  CODIGO_DISCIPLINA INT NOT NULL,
  PRIMARY KEY (CODIGO_PROFESSOR, CODIGO_DISCIPLINA),
  FOREIGN KEY (CODIGO_PROFESSOR) REFERENCES Pessoa(CODIGO),
  FOREIGN KEY (CODIGO_DISCIPLINA) REFERENCES Disciplina(CODIGO)
);

-- Create MinistraTurma table
CREATE TABLE MinistraTurma (
  CODIGO_TURMA INT NOT NULL,
  CODIGO_PROFESSOR INT NOT NULL,
  CODIGO_DISCIPLINA INT NOT NULL,
  PRIMARY KEY (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA),
  FOREIGN KEY (CODIGO_TURMA) REFERENCES Turma(CODIGO),
  FOREIGN KEY (CODIGO_PROFESSOR, CODIGO_DISCIPLINA) REFERENCES MinistraDisciplina(CODIGO_PROFESSOR, CODIGO_DISCIPLINA)
);

-- Insert Cidades on table Cidades
INSERT INTO Cidade(CODIGO, NOME)
VALUES
    (1, 'Niterói'),
    (2, 'Rio de Janeiro'),
    (3, 'São Gonçalo'),
    (4, 'Maricá'),
    (5, 'Itaboraí'),
    (6, 'Cabo Frio'),
    (7, 'Duque de Caxias'),
    (8, 'Nova Iguaçu'),
    (9, 'Belford Roxo'),
    (10, 'Rio Bonito'),
    (11, 'Tanguá'),
    (12, 'Arraial do Cabo'),
    (13, 'São Pedro d`Aldeia');

-- Insert Professores Diretores on table Pessoa
INSERT INTO Pessoa (NOME, TELEFONE, TIPO, RG, CPF, TITULACAO, DATA_NASCIMENTO, CODIGO_CIDADE)
VALUES
    ('Fernando Roberto Ramos', '21984427823', 'Professor', '279125136', '09897272704', 'Diretor', '1990-01-01', 1),
    ('Patrícia Luiza Farias', '21998416434', 'Professor', '437451057', '76804760719', 'Diretor', '1984-04-27', 1),
    ('Joana Jéssica da Mata', '21993788477', 'Professor', '189162934', '78736728756', 'Diretor', '1977-01-21', 1),
    ('Manuel Otávio Isaac Bernardes', '21986135405', 'Professor', '125473266', '07619009779', 'Diretor', '1982-02-08', 4),
    ('Isabella Benedita Mirella Viana', '21981732454', 'Professor', '177511679', '69418167751', 'Diretor', '1972-01-13', 5),
    ('Tereza Lorena Campos', '22985670421', 'Professor', '486587939', '65943000755', 'Diretor', '1981-05-09', 6);

-- Insert Escolas on table Escola
INSERT INTO Escola (NOME, CODIGO_PROFESSOR, CODIGO_CIDADE)
VALUES
    ('Panorama Educação Niterói', 1, 1),
    ('Panorama Educação Rio', 2, 2),
    ('Panorama Educação São Gonçalo', 3, 3),
    ('Panorama Educação Maricá', 4, 4),
    ('Panorama Educação Itaboraí', 5, 5),
    ('Panorama Educação Cabo Frio', 6, 6);

-- Insert Disciplinas on table Disciplina
INSERT INTO Disciplina (NOME)
VALUES
    ('Língua Portuguesa'),
    ('Matemática'),
    ('Biologia'),
    ('Física'),
    ('Química'),
    ('Artes'),
    ('Educação Física'),
    ('Língua Inglesa'),
    ('Filosofia'),
    ('Geografia'),
    ('História'),
    ('Sociologia');

-- Insert data on Turma Table
INSERT INTO Turma (NOME, CODIGO_ESCOLA)
VALUES
    (20230101, 1),
    (20230201, 1),
    (20230102, 2),
    (20230202, 2),
    (20230103, 3),
    (20230203, 3),
    (20230104, 4),
    (20230204, 4),
    (20230105, 5),
    (20230205, 5),
    (20230106, 6),
    (20230206, 6);

-- Insert Alunos on Pessoa table
INSERT INTO Pessoa (NOME, TELEFONE, TIPO, RG, CPF, MATRICULA_ALUNO, DATA_NASCIMENTO, CODIGO_CIDADE, CODIGO_TURMA)
VALUES
  
  -- Insert alunos da turma 20230101 - Niterói
  ('Thaís de Paranhos', '21980304715', 'Aluno', '272683749', '39776888721', '002889', '2007-08-03', 1, 1),
  ('Henrique Cléber da Paixão', '21969307167', 'Aluno', '413899914', '18704549764', '002890', '2007-09-19', 1, 1),
  ('Marcielle Pryra da Encarnação', '21932167739', 'Aluno', '523313991', '73285282792', '002891', '2007-06-05', 3, 1),
  ('Walter Ademar de Alencar', '21934421454', 'Aluno', '297681049', '15647807755', '002892', '2007-09-08', 1, 1),
  ('Hilda Laila Dlolgrotason', '21933350594', 'Aluno', '223080789', '75304572769', '002893', '2007-02-27', 3, 1),
  ('Amália Zuleide Boli da Silva', '21915126529', 'Aluno', '778212428', '50972226787', '002894', '2007-08-04', 1, 1),
  ('Kauê Nathan Enainge', '21911259112', 'Aluno', '107834396', '75581320715', '002895', '2007-10-05', 1, 1),
  ('Ana Tatiane de Novais Sene', '21921587336', 'Aluno', '314978576', '93187100744', '002896', '2007-04-21', 1, 1),
  ('Jânio Emílio de Carvalho da Nóbrega', '21972983616', 'Aluno', '574144563', '99237028753', '002897', '2007-06-04', 1, 1),
  ('Kelly de Alvim', '21990650708', 'Aluno', '155661232', '69925111795', '002898', '2007-02-01', 3, 1),


  -- Insert alunos da turma 20230201 - Niterói
  ('Nicole Genir Ecieyman', '21947217032', 'Aluno', '573585445', '73477568701', '002902', '2007-10-18', 1, 2),
  ('Augusto Plínio Eunman de Barbosa', '21935671686', 'Aluno', '044147640', '52854569796', '002903', '2007-01-30', 1, 2),
  ('Eduardo Emanoel de Pinheiro Sanches', '21995355950', 'Aluno', '710726494', '05952495763', '002904', '2007-02-09', 1, 2),
  ('Moacyr Arntuião Pinhão Júnior', '21952162937', 'Aluno', '297070217', '47117807758', '002905', '2007-07-21', 1, 2),
  ('Eva Seoson', '21943844735', 'Aluno', '785240517', '09686431729', '002906', '2007-12-23', 3, 2),
  ('Tatiana Edyer de Malta', '21931606674', 'Aluno', '757049825', '29659626777', '002907', '2007-03-16', 3, 2),
  ('Bruna Ugemi', '21996221225', 'Aluno', '876050657', '58158338799', '002908', '2007-02-04', 1, 2),
  ('Valéria Cássia da Silva de Teixeira Gewo', '21945373078', 'Aluno', '646226144', '20977248754', '002909', '2007-03-23', 1, 2),
  ('Sara Eodloa', '21997786034', 'Aluno', '017435299', '60580936747', '002910', '2007-07-16', 1, 2),
  ('Kelly da Silva', '21978917056', 'Aluno', '460885586', '05620846742', '002911', '2007-11-20', 1, 2),

  -- Insert alunos da turma 20230102 - Rio de Janeiro
  ('Jenny Quésia Dosom', '21942248257', 'Aluno', '599857190', '57209910722', '002919', '2007-02-05', 9, 3),
  ('Janete Eiyer', '21911600354', 'Aluno', '960501374', '12521353731', '002920', '2007-07-13', 2, 3),
  ('Sheila Suely Espada Iaian', '21942690470', 'Aluno', '422850500', '08288614774', '002921', '2007-10-29', 2, 3),
  ('Otávio Aboe de Alves Neto', '21947801481', 'Aluno', '960929098', '03740310708', '002922', '2007-01-09', 2, 3),
  ('Emanoel Giuseppe dos Santos Seixas', '21981940903', 'Aluno', '248370999', '02545743770', '002923', '2007-09-26', 7, 3),
  ('Cibele Paula Rukekinu', '21976501366', 'Aluno', '904513281', '75709549711', '002924', '2005-10-30', 2, 3),
  ('Ângelo Táles Sonpima de Ramos', '21926776766', 'Aluno', '588311311', '99549447753', '002925', '2007-01-13', 2, 3),
  ('Rebeca Jandira Ancal Valente', '21992595912', 'Aluno', '540961939', '19701783739', '002926', '2005-08-09', 7, 3),
  ('Maurício Nicolau Batahoze de Braga', '21940503664', 'Aluno', '061861248', '93393486759', '002927', '2007-09-24', 2, 3),
  ('Murilo de Pacheco dos Santos', '21989286961', 'Aluno', '010139559', '20586496735', '002928', '2007-05-26', 8, 3),

  -- Insert alunos da turma 20230202 - Rio de Janeiro
  ('Sheila Amélia da Costa', '21994498991', 'Aluno', '778921159', '60030754784', '002933', '2007-06-24', 2, 4),
  ('Emanoel da Silva de Barboza Hekugu', '21955456796', 'Aluno', '443761111', '21098093779', '002934', '2007-10-20', 2, 4),
  ('Benedito da Graça', '21941761764', 'Aluno', '111304912', '29683664713', '002935', '2005-12-30', 2, 4),
  ('Jonathan Anderson de Souza', '21955867586', 'Aluno', '230355458', '33399147745', '002936', '2007-05-08', 2, 4),
  ('Jardel Júlio de Toledo', '21966023605', 'Aluno', '461447953', '63470066779', '002937', '2007-11-17', 2, 4),
  ('Manuela Suellen de Braga', '21922727042', 'Aluno', '372487824', '07114321752', '002938', '2007-07-08', 2, 4),
  ('Janete Xeldicluvic da Silva', '21939011193', 'Aluno', '219036407', '28413884764', '002939', '2007-09-05', 2, 4),
  ('Thaís Jaqueline Ewa', '21928552830', 'Aluno', '456844297', '57886614703', '002940', '2007-03-29', 2, 4),
  ('Carolina Ísis Fragoso', '21929473044', 'Aluno', '426118043', '59821856731', '002941', '2007-09-08', 8, 3),
  ('Wendy Maria Gutierrez Brasil', '21973952339', 'Aluno', '659686501', '30197416751', '002942', '2007-05-25', 7, 4),

  -- Insert alunos da turma 20230103 - São Gonçalo
  ('Gilmar Luciano da Costa de Álvares Vaz', '21912883593', 'Aluno', '400308351', '35809749712', '002950', '2007-06-19', 3, 5),
  ('Tina de Ferraz', '21987729007', 'Aluno', '593067346', '45308896788', '002951', '2007-08-19', 3, 5),
  ('Yuri Itamar de Araújo Banhos', '21981154602', 'Aluno', '713568946', '62468464744', '002952', '2007-02-13', 3, 5),
  ('Wilma Rosimeire da Silva', '21992007965', 'Aluno', '134773731', '29171563759', '002953', '2007-08-26', 5, 5),
  ('Eva Cristina de Aguiar Irnarnadiov Tirimiã', '21988489885', 'Aluno', '644369087', '50909930720', '002954', '2007-10-01', 3, 5),
  ('Márcia Ivete Barroso Apeosern de Assunção', '21962238296', 'Aluno', '234971654', '52469440786', '002955', '2007-04-05', 3, 5),
  ('Ademar de Paiva', '21923765887', 'Aluno', '719994950', '21088224773', '002956', '2007-04-30', 1, 5),
  ('Sandro Ivan Branco', '21976269474', 'Aluno', '035747284', '11912850764', '002957', '2007-02-13', 3, 5),
  ('Violeta Cícera Mourão', '21918351001', 'Aluno', '902865377', '86970447712', '002958', '2007-09-01', 3, 5),
  ('Marlene de Antunes do Maranhão Tazre', '21983312551', 'Aluno', '868268006', '82170746794', '002959', '2007-01-26', 5, 5),

  -- Insert alunos da turma 20230203 - São Gonçalo
  ('Cícero de Alencar da Silva do Piauí Terceiro', '21910065139', 'Aluno', '309047188', '31276925702', '002968', '2007-10-18', 3, 6),
  ('Xilena Schneider', '21939439471', 'Aluno', '666717930', '60506496739', '002969', '2007-03-09', 3, 6),
  ('Rafael Carlos Eugimman de Simões', '21941213428', 'Aluno', '851444994', '02341108770', '002970', '2007-04-21', 3, 6),
  ('Pablo Danilo Wostason de Cardozo', '21953608258', 'Aluno', '132611115', '73081634732', '002971', '2007-04-22', 3, 6),
  ('Paulo Jonathas de Maia Ehiszern', '21976928427', 'Aluno', '613521776', '61401862709', '002972', '2007-10-11', 3, 6),
  ('Itamar Eliel Couto', '21923947067', 'Aluno', '773051174', '03894528718', '002973', '2007-09-29', 3, 6),
  ('Álvaro Aloísio de Holanda Gublesys', '21957274193', 'Aluno', '004037483', '92980326736', '002974', '2007-08-05', 1, 6),
  ('Eloá Ivone Trevisan da Silva', '21953387322', 'Aluno', '981066266', '75087931753', '002975', '2007-06-13', 3, 6),
  ('Alexandre Jorge Schneider do Espírito Santo', '21954271895', 'Aluno', '781298059', '62107764731', '002976', '2007-05-15', 3, 6),
  ('Guiomar Jandira de Muniz do Nascimento', '21921015524', 'Aluno', '503063436', '56011640795', '002977', '2007-03-15', 4, 6),

  -- Insert alunos da turma 20230104 - Maricá
  ('Charlene da Silva Puoer', '21923810049', 'Aluno', '139054991', '20970354707', '002985', '2007-07-13', 4, 7),
  ('Sebastião de Lins Enppi Neto', '21956068151', 'Aluno', '836455998', '89306907724', '002986', '2005-06-03', 4, 7),
  ('Davi Adônis de Uchôa', '21978775226', 'Aluno', '931706578', '95051424716', '002987', '2007-01-18', 4, 7),
  ('Jesus de Santana', '21965155199', 'Aluno', '635161035', '39012815708', '002988', '2007-04-05', 4, 7),
  ('Vinícius da Paz', '21972864022', 'Aluno', '051459424', '18716770729', '002989', '2007-10-01', 4, 7),
  ('Mariana Chike Emli Penedo', '21954523625', 'Aluno', '638718814', '46380343798', '002990', '2007-02-26', 4, 7),
  ('Valter da Silva Yohanimo', '21996125285', 'Aluno', '149268992', '79424345773', '002991', '2007-11-22', 3, 7),
  ('Lidiane Ana Bahia Góis', '21919931321', 'Aluno', '709943013', '33228327799', '002992', '2007-09-08', 4, 7),
  ('Júlia Elaine do Maranhão de Menezes', '21926059506', 'Aluno', '455060053', '17968562787', '002993', '2005-02-09', 4, 7),
  ('Ângela Genir dos Santos da Luz Livai', '21926896927', 'Aluno', '764213601', '44717194756', '002994', '2007-04-23', 4, 7),

  -- Insert alunos da turma 20230204 - Maricá
  ('Ângela de Alvim Rangel Dutra', '21914534675', 'Aluno', '852817108', '21584795725', '002995', '2007-02-27', 4, 8),
  ('Zenaide de Souza', '21911088672', 'Aluno', '476868697', '94741309774', '002996', '2007-02-05', 4, 8),
  ('Frederico Jorge de Pereira da Serra', '21944340398', 'Aluno', '712295784', '70329167794', '002997', '2007-01-31', 4, 8),
  ('Ayrton dos Pinhais', '21977068002', 'Aluno', '046423286', '45979884788', '002998', '2005-01-27', 4, 8),
  ('Maria Mariana Gashisore Ofosa', '21997386947', 'Aluno', '001187987', '06624537704', '002999', '2007-11-25', 4, 8),
  ('José Izki de Pereira Júnior', '21999649778', 'Aluno', '388293858', '95113063754', '003000', '2007-09-17', 4, 8),
  ('Laís Camila de Pereira', '21933052850', 'Aluno', '621446350', '81089597775', '002899', '2007-04-29', 4, 8),
  ('Anakin Lucas Pemfissoer', '21944052796', 'Aluno', '816261374', '80734514797', '002900', '2007-05-16', 4, 8),
  ('Clarice Amanda de Campos Gomes', '21996891730', 'Aluno', '453633201', '15518767717', '002901', '2007-05-29', 4, 8),
  ('Paulo Zebe Terceiro', '21912796461', 'Aluno', '539906350', '41652429740', '002912', '2007-01-18', 4, 8),

  -- Insert alunos da turma 20230105 - Itaboraí
  ('Barnabé Gomes Muore dos Santos', '21924585158', 'Aluno', '816505690', '92780916742', '002913', '2007-09-12', 5, 9),
  ('Selma Krabrevic Sahe Franco', '21964229490', 'Aluno', '448356857', '12454627742', '002914', '2007-05-11', 10, 9),
  ('Joaquim Itamar de Gonçalves da Silva', '21943370931', 'Aluno', '775355225', '90240539723', '002915', '2007-09-09', 5, 9),
  ('Cecília Dara Ulgomman de Lima', '21954494407', 'Aluno', '069369037', '32475831778', '002916', '2007-01-30', 5, 9),
  ('Ivete Amália Unezi', '21986182088', 'Aluno', '029709064', '49075215796', '002917', '2007-09-18', 5, 9),
  ('Toninho Jaziel Fukebifu Ofeã Osha', '21989167553', 'Aluno', '490003082', '25963625791', '002918', '2007-11-06', 10, 9),
  ('Amarildo Hilton Jangada Tafez', '21996572854', 'Aluno', '320529888', '63854539797', '002929', '2007-09-11', 11, 9),
  ('Ali de Simões da Silva', '21955829623', 'Aluno', '229812224', '11094617780', '002930', '2007-11-07', 5, 9),
  ('Cláudia Ceuoan', '21953537153', 'Aluno', '212743570', '87464901736', '002931', '2007-02-23', 11, 9),

  -- Insert alunos da turma 20230205 - Itaboraí
  ('Isac Marcos Peulneov de Chaves', '21926275206', 'Aluno', '090172476', '57041037719', '002945', '2007-08-10', 5, 10),
  ('Rute de Oliveira Gomes', '21953359834', 'Aluno', '361923054', '92442830714', '002946', '2007-11-09', 5, 10),
  ('Mayra Melanie da Mata', '21936140834', 'Aluno', '576666050', '42224240715', '002947', '2007-11-09', 10, 10),
  ('Mayra Carolina Chimanta', '21926163225', 'Aluno', '328478322', '17171572724', '002948', '2007-02-19', 10, 10),
  ('Dário Denis Penedo Zorisaro', '21967966273', 'Aluno', '473919700', '96244035787', '002949', '2007-09-11', 11, 10),
  ('Alex Ivan de Britto', '21996214082', 'Aluno', '599760898', '93302090792', '002943', '2007-12-19', 5, 10),
  ('Gilson Otávio Besei de Macedo', '21971298007', 'Aluno', '816029427', '42957384789', '002944', '2007-09-30', 10, 10),
  ('Camilo Cléber Fragoso Júnior', '21911601637', 'Aluno', '408665841', '76111553735', '002932', '2007-08-24', 5, 10),

  -- Insert alunos da turma 20230106 - Cabo Frio
  ('Lana Kun de Tozetto', '21976499010', 'Aluno', '602409039', '33745712723', '002960', '2007-11-04', 6, 11),
  ('Humberto Micael de Britto', '21971627167', 'Aluno', '028866030', '75825087751', '002961', '2007-07-28', 6, 11),
  ('Célia de Linhares', '21986767907', 'Aluno', '049322762', '60807550733', '002962', '2007-09-23', 12, 11),
  ('Júlio Fria de Barbosa', '21974796509', 'Aluno', '949602158', '82804029731', '002963', '2007-09-09', 13, 11),
  ('Valter Puhe', '21990412122', 'Aluno', '661225443', '79178219713', '002964', '2007-06-19', 12, 11),

  -- Insert alunos da turma 20230206 - Cabo Frio
  ('Nayara Resmosirnov Daravic Fragoso', '21947364493', 'Aluno', '840631419', '65095736716', '002965', '2007-09-05', 12, 11),
  ('Paulínia Poelan de Munhoz', '21965814489', 'Aluno', '633772091', '67695335731', '002966', '2005-08-05', 6, 11),
  ('Cássia de Cerqueira Câmara Herrera', '21977552631', 'Aluno', '358349119', '27584782741', '002967', '2007-06-26', 12, 11),
  ('Lara Wendy Wamepida', '21969305427', 'Aluno', '837535613', '74204661743', '002978', '2007-12-09', 13, 11),
  ('Romildo Washington Nyamson Trevisan da Silva Júnior', '21995282091', 'Aluno', '592232049', '41895428707', '002979', '2007-03-20', 6, 11);

-- Insert Professores on Pessoa table
INSERT INTO Pessoa (NOME, TELEFONE, TIPO, RG, CPF, TITULACAO, DATA_NASCIMENTO, CODIGO_CIDADE)
VALUES
  -- Insert professores de Niterói
  ('Selma Evelyn Doagrugamson dos Santos', '21976854476', 'Professor', '890452788', '14108626772', 'Associado', '1961-09-02', 1),
  ('Carlos Vopoã', '21949590636', 'Professor', '900954919', '35941303781', 'Associado', '1971-03-07', 1),
  ('Bernadete do Paraná de Paranhos', '21975981678', 'Professor', '667165246', '49796289741', 'Temporário', '1970-05-19', 1),
  ('Taís de Figueira da Silva', '21952885934', 'Professor', '320413987', '66972743787', 'Temporário', '1984-12-19', 1),
  ('Mel de Freitas', '21999637018', 'Professor', '927170284', '13726964755', 'Associado', '1996-07-23', 1),
  ('César Gomes de Cerqueira', '21959299303', 'Professor', '944782911', '32460385789', 'Associado', '1962-12-20', 1),
  ('Kevin Jackson Fenauo Júnior', '21997873116', 'Professor', '620142858', '37030366709', 'Associado', '1974-01-29', 1),

  -- Insert professores do Rio de Janeiro
  ('Inácio Buarque de Cardoso Neto', '21921437313', 'Professor', '290540917', '38582482717', 'Associado', '1987-06-10', 2),
  ('Diogo da Serra Kara', '21936917957', 'Professor', '946221724', '69533902700', 'Associado', '1994-10-20', 2),
  ('Francielle Sei', '21998755514', 'Professor', '009687256', '97554571797', 'Associado', '1981-09-10', 2),
  ('Bernadete Cássia de Souza da Luz', '21913857836', 'Professor', '485381570', '82793087740', 'Associado', '1987-05-10', 2),
  ('Monique de Torquato do Amaral', '21947078742', 'Professor', '430571693', '27087114799', 'Associado', '1964-05-28', 2),
  ('Josiel Mercado de Maia', '21936868226', 'Professor', '496187106', '67405312790', 'Associado', '1981-04-21', 2),
  ('Mariano Usguoã', '21941589312', 'Professor', '154884327', '32806017728', 'Temporário', '1986-02-13', 2),

  -- Insert professores de São Gonçalo
  ('Maísa de Paiva dos Santos', '21996241866', 'Professor', '982681753', '29726373781', 'Associado', '1976-05-14', 3),
  ('Alessandre Paulo de Paula', '21935571700', 'Professor', '783464230', '29680211780', 'Temporário', '1985-04-20', 3),
  ('Fabiana Diana Duque dos Santos', '21946798662', 'Professor', '423528496', '38140520703', 'Associado', '1967-03-12', 3),
  ('Adônis Caio Itinã', '21974263695', 'Professor', '553902632', '88311661768', 'Associado', '1977-09-30', 3),
  ('Carolina Raíssa Dasboatuzov', '21927933497', 'Professor', '006815811', '90623747737', 'Temporário', '1963-01-05', 3),
  ('Elói Abílio de Vieira', '21984220938', 'Professor', '920583540', '43509266720', 'Associado', '1983-06-06',3),
  ('Celeste dos Santos de Paranhos Yvritansa', '21988308776', 'Professor', '462700349', '55331308772', 'Associado', '1980-02-04', 3),
  ('Hellen Clarice de Rezende', '21995383453', 'Professor', '032242726', '73094457772', 'Associado', '1983-06-09', 3),
  ('Poliana Úrsula de Drummond Sadabi Mercado', '21962055272', 'Professor', '718712956', '50832949717', 'Associado', '1966-10-27', 3),
  ('Aécio Rawaho', '21962754594', 'Professor', '177274730', '22955656753', 'Associado', '1986-08-09', 3),

  -- Insert professores de Maricá
  ('Aurélio de Melo Igreja', '21969037753', 'Professor', '154845932', '62186943745', 'Associado', '1964-05-04', 4),
  ('Diana do Piauí', '21951414664', 'Professor', '127192855', '23206051725', 'Temporário', '1990-02-11', 4),
  ('Dionísio de Araújo Yason do Rio Júnior', '21997523058', 'Professor', '453173224', '40333528754', 'Temporário', '1997-04-18', 4),
  ('Lidiane Paze de Macedo Hazomu', '21918662240', 'Professor', '163154185', '24324016778', 'Associado', '1982-11-30', 4),
  ('Fernando de Souza Prates', '21947629898', 'Professor', '623347074', '06580357768', 'Temporário', '1998-05-18', 4),

  -- Insert professores de Itaboraí
  ('Karin de Braga', '21947306156', 'Professor', '583782170', '12513050772', 'Associado', '1989-07-10', 5),
  ('Augusto Gutierrez', '21977033978', 'Professor', '395609794', '39414052763', 'Temporário', '1976-07-09', 5),
  ('Maria Ariana dos Santos', '21911929745', 'Professor', '061338782', '44350798771', 'Associado', '1998-06-19', 5),

  -- Insert professores de Cabo Frio
  ('Luiza Gomes', '21969575192', 'Professor', '006822930', '06432001773', 'Associado', '1962-09-24', 6),
  ('Sara Eva Naves', '21917647999', 'Professor', '528775566', '08487144793', 'Associado', '1982-11-24', 6),
  ('Beto de Souza', '21947589529', 'Professor', '066161871', '77328859773', 'Temporário', '1975-02-07', 6),

  -- Insert professores de Duque de Caxias
  ('Abílio de Souza', '21933437143', 'Professor', '192125009', '65785288728', 'Associado', '1992-03-14', 7),
  ('Artur Alan Uzemeson Coutinho', '21982333306', 'Professor', '170927186', '92750557717', 'Associado', '1961-06-24', 7),

  -- Insert professores de Nova Iguaçu
  ('Vinícius de Gusmão', '21936924746', 'Professor', '622037742', '79135576741', 'Temporário', '1997-07-06', 8),
  ('Flaviana Maria da Silva Grozbison Fobi', '21933779329', 'Professor', '792401199', '18996138703', 'Associado', '1974-06-02', 8),

  -- Insert professores de Belford Roxo
  ('Jussara Gutierrez', '21911208379', 'Professor', '137076431', '59024101778', 'Associado', '1980-08-17', 9),
  ('Arlete Mariana Oloa', '21963403601', 'Professor', '872644661', '45573684760', 'Temporário', '1977-09-21', 9),

  -- Insert professores de Rio Bonito
  ('Isabela Trevisan', '21978107850', 'Professor', '885023249', '41365791739', 'Associado', '1984-03-11', 10),
  ('Cecília Fátima de Pereira Weber', '21980044759', 'Professor', '979798629', '02701405761', 'Associado', '1961-03-11', 10),

  -- Insert professores de Tanguá
  ('Cleberson de Albuquerque', '21985749256', 'Professor', '237169549', '09407052764', 'Associado', '1985-04-01', 11),
  ('Isabel Sezedigru dos Santos da Silva', '21920556405', 'Professor', '562441011', '26071675730', 'Associado', '1982-04-26', 11),

  -- Insert professores de Arraial do Cabo
  ('Catarina de Oliveira Lopes', '21921443523', 'Professor', '046424939', '64519265737', 'Associado', '1994-01-14', 12),
  ('Manuel de Vasconcelos Pinhão', '21944525332', 'Professor', '694475981', '26913956761', 'Temporário', '1963-08-03', 12),
  ('David de Brito Barroso', '21958309055', 'Professor', '748721979', '00766136726', 'Associado', '1996-01-10', 12),
  ('Mara Galeman', '21928833645', 'Professor', '445552136', '21210024786', 'Temporário', '1982-09-21', 12),

  -- Insert professores de São Pedro
  ('Mirela Lívia Branco', '21936300129', 'Professor', '644927226', '34226176724', 'Associado', '1966-06-21', 13),
  ('Cristina de Pereira Rosatto', '21910145851', 'Professor', '225000180', '09491129776', 'Associado', '1975-08-23', 13),
  ('Suzanne de Iglesias dos Santos', '21969867012', 'Professor', '435528794', '28678484701', 'Associado', '1979-10-05', 13);

-- Insert data on Contato Table
INSERT INTO Contato (NOME, TELEFONE, CODIGO_ALUNO)
VALUES
  ('Geraldo Gusmão de Paranhos', '21941823125', '7'),
  ('Luiz Henrique da Paixão', '21914596800', '8'),
  ('Jonathas Pryra da Encarnação', '21952093732', '9'),
  ('Wilma Ademar de Alencar', '21938390493', '10'),
  ('Fábio de Muniz Dlolgrotason', '21954879668', '11'),
  ('Eliomar Boli da Silva', '21967675849', '12'),
  ('Mateus Enainge de Souza', '21999883676', '13'),
  ('Armando de Novais Sene', '21954376424', '14'),
  ('Leandro de Carvalho da Nóbrega', '21997467099', '15'),
  ('Brenda de Alvim', '21937176481', '16'),
  ('Wally Ecieyman', '21964219435', '17'),
  ('Amanda Eunman de Barbosa', '21945069805', '18'),
  ('Gabrielle de Pinheiro Sanches', '21931273287', '19'),
  ('Chico Arntuião Pinhão', '21924577636', '20'),
  ('Gilberto Kim Seoson', '21931959633', '21'),
  ('Abílio Edyer de Malta', '21927172473', '22'),
  ('Isaías de Fraga Ugemi', '21948197882', '23'),
  ('Ariana da Silva de Teixeira Gewo', '21971561060', '24'),
  ('Sâmia Eiyer', '21912413597', '28'),
  ('Evelyn de Alves Neto', '21925072994', '30'),
  ('Wanda Nádia Rukekinu', '21977294874', '32'),
  ('Sâmia Ancal Valente', '21962816011', '34'),
  ('Leila Batahoze de Braga', '21920231658', '35'),
  ('Celina de Pacheco dos Santos', '21922719605', '36'),
  ('Damares de Barboza Hekugu', '21957034278', '38'),
  ('Marlene da Graça', '21920209120', '39'),
  ('Camila Cármen de Souza', '21923595490', '40'),
  ('Beto de Toledo', '21959096147', '41'),
  ('Cícera Tsuwoto', '21963859906', '42'),
  ('Raul Hugo de Padilha', '21966824815', '43'),
  ('Matilde de Muniz', '21991015516', '44'),
  ('Selma Irnri Odizre', '21974573652', '47'),
  ('João Luís de Araújo Banhos', '21969992441', '49'),
  ('Maria Clara da Silva', '21929690013', '50'),
  ('Yolanda Zara Valente da Silva', '21943668739', '51'),
  ('Mayra de Pinheiro do Amazonas', '21981839919', '52'),
  ('José de Paiva', '21944774676', '53'),
  ('Jenny Branco', '21914264396', '54'),
  ('Antônio Chico Mourão', '21967236053', '55'),
  ('Osório de Antunes do Maranhão', '21951522162', '56'),
  ('Beto Félix Schneider', '21993499037', '58'),
  ('Eustáquio da Graça Eugimman', '21915270551', '59'),
  ('Benjamin Nilo Wostason', '21938729923', '60'),
  ('Emílio Marques Couto', '21984571504', '62'),
  ('Saulo Roberval Gublesys', '21911609328', '63'),
  ('Altair Marcelo Trevisan', '21918924932', '64'),
  ('Angélica Mernuman Jigeni', '21980394090', '65'),
  ('Itamara de Salvador Sacimi', '21948311230', '67'),
  ('Camila Elyser Ludummal', '21965775655', '68'),
  ('Ana Liane de Uchôa', '21994631523', '69'),
  ('Marielle Frias de Santana', '21928538320', '70'),
  ('Núbia Gabriela Emli Penedo', '21910476893', '72'),
  ('Rodolfo Yohanimo de Barbosa', '21948809053', '73'),
  ('Flávio Góis Júnior', '21985799897', '74'),
  ('Samuel de Meireles da Paixão', '21945086811', '75'),
  ('José da Luz Livai Uoman', '21950902613', '76'),
  ('Nilton de Pereira da Serra', '21980016371', '79'),
  ('Roger Lucas dos Pinhais', '21978442413', '80'),
  ('Thaíssa de Bezerra Gashisore', '21965982021', '81'),
  ('Quitéria da Silva Izki', '21959275279', '82'),
  ('Maria Jandira do Prado Bazabupa', '21941384318', '83'),
  ('Maria de Campos Gomes', '21967047876', '85'),
  ('Lívia Zebe Terceiro', '21994410904', '86'),
  ('Nathan Muore dos Santos', '21947546884', '87'),
  ('Oséas Krabrevic', '21935390339', '88'),
  ('Paulo Ulgomman de Lima', '21990622937', '90'),
  ('Antônio Misbyse', '21912083062', '92'),
  ('Emanoel Hilton Jangada Tafez', '21940626292', '93'),
  ('Heloísa de Simões da Silva', '21910942136', '94'),
  ('Alisson Tristão Ceuoan', '21945458054', '95'),
  ('Marcielle de Oliveira Gomes', '21970858457', '97'),
  ('Ciro da Mata', '21976622880', '98'),
  ('Soraya Chimanta', '21968655291', '99'),
  ('Anne Simone Euson de Barbosa', '21918012850', '101'),
  ('Osório Moacyr Fragoso', '21978220687', '103'),
  ('Lúcio Kun de Tozetto', '21928905545', '104'),
  ('Sheila Suely de Britto', '21997605744', '105'),
  ('Mayara de Linhares', '21985236462', '106'),
  ('Jardel de Barbosa', '21987614155', '107'),
  ('Xavier Lúcio Puhe', '21927626944', '108'),
  ('Fernando Resmosirnov Daravic Fragoso', '21964685695', '109'),
  ('Mayara Poelan de Munhoz', '21942314458', '110'),
  ('Dário da Serra', '21971639977', '111'),
  ('Jonathan Wamepida', '21953496959', '112');

-- Insert Data on MinistraDisciplina Table
INSERT INTO MinistraDisciplina (CODIGO_PROFESSOR, CODIGO_DISCIPLINA)
VALUES
  (1, 2),
  (2, 3),
  (3, 12),
  (4, 12),
  (5, 1),
  (6, 2),
  (114, 1),
  (115, 2),
  (116, 3),
  (117, 4),
  (118, 5),
  (119, 6),
  (120, 7),
  (121, 1),
  (122, 2),
  (123, 3),
  (124, 4),
  (125, 5),
  (126, 6),
  (127, 7),
  (128, 1),
  (129, 3),
  (130, 5),
  (131, 6),
  (132, 7),
  (133, 8),
  (134, 9),
  (135, 10),
  (136, 11),
  (137, 12),
  (138, 1),
  (138, 8),
  (139, 2),
  (140, 3),
  (141, 4),
  (142, 5),
  (143, 1),
  (143, 8),
  (144, 2),
  (145, 3),
  (146, 1),
  (146, 8),
  (147, 2),
  (148, 3),
  (149, 1),
  (150, 8),
  (151, 9),
  (152, 10),
  (153, 11),
  (154, 12),
  (155, 4),
  (156, 5),
  (157, 6),
  (158, 9),
  (159, 4),
  (160, 5),
  (161, 6),
  (162, 7),
  (163, 9),
  (163, 12),
  (164, 10),
  (165, 11);

-- Insert Data on MinistraTurma table
-- Turma 20230101
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 114, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 115, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 116, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 117, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 118, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 119, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 120, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 133, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 134, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 135, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 136, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (1, 137, 12);
  
  -- Turma 20230201
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 114, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 115, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 116, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 117, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 118, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 119, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 120, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 133, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 134, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 135, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 136, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (2, 137, 12);
  
  -- Turma 20230201
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 121, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 122, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 123, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 124, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 125, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 126, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 127, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 150, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 151, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 152, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 153, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (3, 154, 12);
  
  -- Turma 20230202
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 121, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 122, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 123, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 124, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 125, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 126, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 127, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 150, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 151, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 152, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 153, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (4, 154, 12);
  
  -- Turma 20230103
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 128, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 115, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 129, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 124, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 130, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 131, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 132, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 133, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 134, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 135, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 136, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (5, 137, 12);
  
  -- Turma 20230303
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 128, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 115, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 129, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 124, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 130, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 131, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 132, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 133, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 134, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 135, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 136, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (6, 137, 12);
  
  -- Turma 20230104
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 138, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 139, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 140, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 141, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 142, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 119, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 120, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 138, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 134, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 135, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 136, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (7, 137, 12);
  
  -- Turma 20230204
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 138, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 139, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 140, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 141, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 142, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 119, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 120, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 138, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 134, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 135, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 136, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (8, 137, 12);
  
  -- Turma 20230105
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 143, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 144, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 145, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 155, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 156, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 157, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 132, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 143, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 134, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 135, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 136, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (9, 154, 12);
  
  -- Turma 20230205
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 143, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 144, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 145, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 155, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 156, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 157, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 132, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 143, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 134, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 135, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 136, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (10, 154, 12);
  
  -- Turma 20230106
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 146, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 147, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 148, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 159, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 160, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 161, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 162, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 146, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 163, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 164, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 165, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (11, 163, 12);
  
  -- Turma 20230206
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 146, 1);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 147, 2);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 148, 3);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 159, 4);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 160, 5);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 161, 6);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 162, 7);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 146, 8);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 163, 9);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 164, 10);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 165, 11);
INSERT INTO MinistraTurma (CODIGO_TURMA, CODIGO_PROFESSOR, CODIGO_DISCIPLINA) VALUES (12, 163, 12);