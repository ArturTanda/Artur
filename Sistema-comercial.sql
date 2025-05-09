create database Sistema_Comercial;

use Sistema_Comercial;

create table ComCliente(
 numero_cliente int  not null auto_increment,
 codigo_cliente varchar(10),
 nome_cliente varchar(100) not null,
 data_cliente date,
 fone_cliente varchar(20),
 primary key (numero_cliente)
);
insert into comcliente values(1,'01','Artur Nunes','2025-02-16','930768260','Luena', 'LM');
insert into comcliente values(2,'02','Jose Nunes','2024-11-12','935214985','Huambo','HM');
insert into comcliente values(3,'03','Carlos Joao','2024-10-08','945876932','Luena','LM');

 create table comfornecedor(
 numero_fornecedor int not null auto_increment,
 codigo_fornecedor varchar(10),
 nome_fornecedor varchar(100),
fone_fornecedor varchar(20),
 primary key(numero_fornecedor)
 );
 insert into comfornecedor values(1,'01','FURNITURE LTD','924142562');
 insert into comfornecedor values(2,'02','WORKS LTD','923652148');
 
 create table comvendedor(
 numero_vendedor int not null auto_increment,
 codigo_vendedor varchar(10),
 nome_vendedor varchar(100),
 fone_vendedor varchar(20),
 primary key(numero_vendedor)
 );
 insert into comvendedor values (1,'01','Ana Maria','954215263');
 insert into comvendedor values (2,'02','Maria Jose','929326598');
 
  create table comproduto(
 numero_produto int not null auto_increment,
 codigo_produto varchar(20),
 desc_produto varchar(100),
 valor_produto float(10,2),
 numero_fornecedor int,
 primary key(numero_produto)
 );
 insert into comproduto values(1,'01','Oléo','50.2',1);
 insert into comproduto values(2,'02','Sabão','100.2',1);
 insert into comproduto values(3,'03','Capa','25.2',2);
 
  create table comvenda(
 numero_venda int not null auto_increment,
 codigo_venda varchar(10),
 numero_cliente int not null,
 numero_fornecedor int not null,
 numero_vendedor int not null,
 valor_venda float(10,2),
 desc_venda float(10,2),
 total_venda float(10,2),
 data_venda date,
 primary key(numero_venda)
 );
 insert into comvenda values(2,'001',1,1,1,250, 4, 40 ,'2025-02-11');
  insert into comvenda values(3,'002',2,1,2, 350, 5, 58 ,'2024-02-11');
   insert into comvenda values(4,'003',2,2,2,150, 8, 1000 ,'2025-01-10');
   
  select* from comvenda;
  
  create table comvendas(
 numero_venda int not null auto_increment,
 codigo_venda varchar(10),
 numero_cliente int not null,
 numero_fornecedor int not null,
 numero_vendedor int not null,
 valor_venda float(10,2),
 desc_venda float(10,2),
 total_venda float(10,2),
 data_venda date,
 primary key(numero_venda)
 );
   # ELIMINANDO TABELA
 drop table comvendas;
 
  create table comivenda(
 numero_ivenda int not null auto_increment,
 numero_venda int not null,
 numero_produto int not null,
 valor_ivenda float(10,2),
 qtde_ivenda int,
 desc_ivenda float(10,2),
 primary key(numero_ivenda)
 );
 
 insert into comivenda values(1, 1, 2, 150, 10, 4);
  insert into comivenda values(2, 2, 2, 100, 8, 10);
 
 #ADICIONANDO CHAVES ESTRAGEIRAS 
 alter table comvenda add constraint fk_comproduto_comfornecedor
 foreign key(numero_fornecedor)
 references comfornecedor(numero_fornecedor)
 on delete no action
 on update no action;
 
 alter table comvenda add constraint fk_comproduto_comvendedor
 foreign key(numero_vendedor)
 references comvendedor(numero_vendedor)
 on delete no action
 on update no action;
 
 alter table comvenda add constraint fk_comvenda_ComCliennte
 foreign key(numero_cliente)
 references ComCliente(numero_cliente)
 on delete no action
 on update no action;
 
 alter table comivenda add constraint fk_comivenda_comproduto
 foreign key(numero_produto)
 references comproduto (numero_produto)
 on delete no action
 on update no action;
 
 alter table comivenda add constraint fk_comivenda_comvenda
 foreign key(numero_venda)
 references comvenda (numero_venda)
 on delete no action
 on update no action;
 
 #ADICIONANDO COLUNA EM TABELAS JA CRIADAS
 alter table ComCliente add column cidade_Cliente varchar(50); 
 alter table ComCliente add column estado_Cliente varchar(50);
 
#Atualizar os dados de um cliente
update comcliente set nome_cliente='Artur Tanda', estado_Cliente='L' where numero_cliente= 1;

#Excluir um Cliente
delete from comcliente where numero_cliente =2;

#CONSULTA DE TODOS CLIENTES
select* from comcliente;

#CONSULTA DE DADOS DO CLIENTE APÓS O SELECT
select nome_cliente, fone_cliente from comcliente;

#CONSULTA DE CLIENTES COM O CODIGO DIFERENTE DE 01
select nome_cliente, fone_cliente from comcliente where codigo_cliente <> '02';

#Consulta Filtrando as vendas sem repetição dos dados
select  distinct numero_cliente from comvenda;

#CONSULTA USANDO A CLAUSULA in
select nome_cliente, fone_cliente from comcliente where numero_cliente in (2,3);

 select nome_cliente from comcliente where numero_cliente in (
            select numero_cliente from comvenda where numero_cliente);
            
#CRIAÇÃO DE ALIAS
select nome_cliente NOME_COMPLETO, fone_cliente CONTACTO from comcliente where numero_cliente=1;
select nome_cliente NOME_COMPLETO, fone_cliente CONTACTO from comcliente ;

select codigo_venda CODIGO_VENDA, (select fone_cliente from comcliente
              where numero_cliente = comvenda.numero_cliente) Nome_Cliente from comvenda;
			
select codigo_cliente Cod_CLIENTE, nome_cliente Nome_Cliente, codigo_venda Cod_Venda
 from comvenda, comcliente
 where comvenda.numero_cliente = comcliente.numero_cliente
 order by nome_cliente;
 
 #CONSULTA USANDO O JOIN
 select codigo_cliente codigo_Cliente, 
 codigo_venda codi_venda
 from comvenda
 join comcliente on
 comvenda.numero_cliente = comcliente.numero_cliente
 order by nome_cliente;
 
  create table comcontato(
 numero_contato int not null auto_increment,
 nome_contato varchar(200),
 fone_contato varchar(30),
 cidade_contato varchar(200),
 estado_contato varchar(2),
 numero_cliente int,
 primary key(numero_contato));
 
 #INSERIR OS DADOS DA TABELA CLIENTE NA TABELA CLIENTE
 insert into comcontato(
 select numero_cliente,
 nome_cliente,
 fone_cliente,
 cidade_cliente,
 estado_cliente,
 numero_cliente
 from comcliente);
 
 select * from comcontato;
 
 #DELETAR COM SELECT E CLASULA NOT IN
 delete from comcontato
 where numero_cliente not in (select numero_cliente
 from comvenda );
 
 #CONSULTA COM A FUNÇÃO COUNT
 select codigo_cliente,  count(numero_venda) Qtde
 from comcliente, comvenda
 where comvenda.numero_cliente = comcliente.numero_cliente
 group by codigo_cliente
 order by codigo_cliente;
 
 select count(*) from comcliente;
 
 #CONSULTA USANDO O HAVING COUNT
 select nome_cliente, count(numero_venda)
 from comcliente, comvenda
 where comvenda.numero_cliente = comcliente.numero_cliente
 group by nome_cliente
 having count(numero_venda) > 1;
 
 #CONSULTA USANDO MAX
 select max(total_venda) maior_venda
 from comvenda;
 
 #CONSULTA USANDO O MIN
 select min(total_venda) menor_venda
 from comvenda;
 
 # CONSULTA USANDO AS DUAS SITADAS A CIMA
 select max(total_venda) maior_venda, min(total_venda) menor_venda
 from comvenda;
 
 #CONSULTA USANDO O SUM para somar
 select sum(valor_venda) valor_venda,
 sum(desc_venda) descontos,
 sum(total_venda) total_venda
 from comvenda
 where data_venda between '2020-11-30' and '2025-04-01';
 
 select codigo_produto, desc_produto
 from comproduto
 where substr(codigo_produto,1) = '1'
 and length(codigo_produto) > 1;
 
 select lcase(nome_cliente)
 from comcliente;
 
 select sqrt(4);
 
 
 select (qtde_ivenda * valor_ivenda) multiplicação
 from comivenda
 where numero_ivenda = 2;
 
select curdate();
select now();

 alter table comvendedor add porc_vendedor float(10,2);
 alter table comvenda add comi_venda float(10,2);

select * from comvendedor;

# CRIANDO FUNÇÃO PARA RETORNAR UM VALOR
delimiter $$
 create function rt_nome_cliente(vn_numero_cliente int)
 returns varchar(50)
 begin
 declare nome varchar(50);
 select nome_cliente into nome
 from comcliente
 where numero_cliente = vn_numero_cliente;
 return nome;
 end $$
 
## Consulta e estou passando como parâmetro o id do cliente
 select rt_nome_cliente(2) ;
 
 ##irei retornar o código da venda, nome do cliente e a
 ##data da venda ordenando pelo nome e em seguida pela data
 select codigo_venda,
 rt_nome_cliente(numero_cliente),
 data_venda
 from comvenda
 order by 1,3;
 
 


 
 

