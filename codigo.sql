create database faculdade;

use faculdade;

create table departamento(
	id int NOT NULL auto_increment,
    nome varchar(255) NOT NULL,
    local varchar(255),
    
    primary key(id)
);
create table aluno(
	nome varchar(255) NOT NULL,
    data_nascimento date,
    matricula varchar(10) NOT NULL,
    endereco varchar(255),
    
    primary key(matricula)
);

create table disciplina(
	nome varchar(100) NOT NULL,
    carga_horaria int NOT NULL default 30,
    ementa text,
    
    primary key(nome)
);
    
create table professor(
	inicio_contrato date,
    nome varchar(255) NOT NULL,
    cpf varchar(11) NOT NULL,
    departamento_id int,
    
    primary key(cpf),
    FOREIGN KEY(departamento_id) references departamento(id)
);

create TABLE professor_contato(
	prof_cpf varchar(11) NOT NULL,
    contato varchar(14) NOT NULL,
    
    foreign key(prof_cpf) references professor(cpf),
    constraint PK_professor_contato primary key(prof_cpf, contato)
);

create table avaliacao(
	prof_cpf varchar(11) NOT NULL,
    data_hora datetime NOT NULL,
    comentario varchar(500),
    nota int,
    
    foreign key(prof_cpf) references professor(cpf),
    primary key(prof_cpf,data_hora)
);

alter table departamento
	add prof_chefe_cpf varchar(11),
    add foreign key (prof_chefe_cpf) references professor(cpf);
    
alter table disciplina
	add disc_pre_requisito varchar(100),
    add foreign key (disc_pre_requisito) references disciplina(nome);
    
create table aluno_disciplina(
	matricula varchar(10) NOT NULL,
    nome varchar(100) NOT NULL,
    
    primary key (matricula,nome),
    foreign key (matricula) references aluno(matricula),
    foreign key (nome) references disciplina(nome)
);

create table professor_disciplina(
	cpf varchar(11) NOT NULL,
    nome varchar(100) NOT NULL,
    
    primary key(cpf,nome),
    foreign key(cpf) references professor(cpf),
    foreign key(nome) references disciplina(nome)
);

INSERT INTO departamento (nome, local)
VALUES 
('Ciências Exatas', 'Belo Horizonte'),
('Ciências Humanas', 'São Paulo'),
('Engenharia', 'Rio de Janeiro');

INSERT INTO aluno (nome, data_nascimento, matricula, endereco)
VALUES 
('Eleven', '2004-02-19', '20210001', 'Rua Upside Down, 123, Hawkins'),
('Nairobi', '1990-10-12', '20210002', 'Rua Professor, 456, Madri'),
('Geralt de Rivia', '1985-12-24', '20210003', 'Rua Kaer Morhen, 789, Rivia');

INSERT INTO disciplina (nome, carga_horaria, ementa)
VALUES 
('Matemática', 60, 'Cálculo, álgebra e trigonometria.'),
('Filosofia', 30, 'Introdução à filosofia, ética e lógica.'),
('Programação', 90, 'Lógica de programação, estruturas de dados.');

INSERT INTO professor (inicio_contrato, nome, cpf, departamento_id)
VALUES 
('2010-03-12', 'Walter White', '12345678901', 1),
('2015-05-10', 'Jessica Jones', '98765432100', 2),
('2020-08-20', 'Joe Goldberg', '45678912300', 3);

INSERT INTO professor_contato (prof_cpf, contato)
VALUES 
('12345678901', '31999999999'),
('98765432100', '11988888888'),
('45678912300', '21977777777');

INSERT INTO avaliacao (prof_cpf, data_hora, comentario, nota)
VALUES 
('12345678901', '2023-10-12 14:30:00', 'Excelente professor, muito atencioso.', 9),
('98765432100', '2023-10-13 15:45:00', 'Muito clara nas explicações.', 8),
('45678912300', '2023-10-14 09:00:00', 'Aulas um pouco confusas.', 6);

INSERT INTO aluno_disciplina (matricula, nome)
VALUES 
('20210001', 'Matemática'),
('20210002', 'Filosofia'),
('20210003', 'Programação');

INSERT INTO professor_disciplina (cpf, nome)
VALUES 
('12345678901', 'Matemática'),
('98765432100', 'Filosofia'),
('45678912300', 'Programação');

UPDATE departamento
SET prof_chefe_cpf = '12345678901'
WHERE id = 1;

UPDATE disciplina
SET disc_pre_requisito = 'Matemática'
WHERE nome = 'Programação';
