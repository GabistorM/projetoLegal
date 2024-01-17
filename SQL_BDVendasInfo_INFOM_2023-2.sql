
-----------------------------------------------------------------
-- Criar o Banco de Dados
-----------------------------------------------------------------
create database BD_VendasInfoM
go

-----------------------------------------------------------------
-- Acessar o Banco de Dados
-----------------------------------------------------------------
use BD_VendasInfoM
go

-----------------------------------------------------------------
-- Criar a tabela Pessoas
-----------------------------------------------------------------
create table Pessoas
(
	idPessoa		int		not null	primary key		identity,
	nome	varchar(50)		not null,
	cpf		varchar(14)		not null	unique,
	status			int			null,
	-- restrição
	-- status 1 - Ativo | 2 - inativo
	check(status in (1,2))
)
go

-----------------------------------------------------------------
-- Criar a tabela Clientes
-----------------------------------------------------------------
create table Clientes
(
	pessoaId		  int	not null	primary key,
	renda	decimal(10,2)	not null,
	credito	decimal(10,2)	not null,
	-- chave estrangeira
	foreign key	(pessoaId)	references	Pessoas(idPessoa),
	-- restrições
	check(renda >= 700.00),
	check(credito >= 100.0)
)
go

-----------------------------------------------------------------
-- Criar a tabela Vendedores
-----------------------------------------------------------------
create table Vendedores
(
	pessoaId		int		not null	primary key		references	Pessoas(idPessoa),
	salario		  money		not null	check(salario >= 1000.00)
)
go

-----------------------------------------------------------------
-- Criar a tabela Produtos
-----------------------------------------------------------------
create table Produtos
(
	idProduto			int		not null	primary key		identity,
	descricao	varchar(100)	not null,
	qtd					int			null,
	valor	   decimal(10,2)		null,
	status				int			null,
	-- restrições
	check(qtd >= 0),
	check(valor > 0.0),
	-- status 1 - Ativo | 2 - inativo |	3 - Cancelado
	check(status between 1 and 3)
)
go

-----------------------------------------------------------------
-- Criar a tabela Clientes
-----------------------------------------------------------------
create table Pedidos
(
	idPedido		int		not null	primary key		identity,
	data	   datetime		not null,
	valor		  money			null,
	status			int			null,
	vendedorId		int		not null,
	clienteId		int		not null,
	-- chaves estrangeiras
	foreign key (vendedorId)			references		Vendedores(pessoaId),
	foreign key	(clienteId)				references		Clientes(pessoaId),
	-- restrições
	-- status 1 - Em andamento | 2 - finalizado | 3 - Entregue | 4 - Cancelado
	check(status in (1, 2, 3, 4))
)
go

-----------------------------------------------------------------
-- Criar a tabela Itens_Pedidos
-----------------------------------------------------------------
create table Itens_Pedidos
(
	pedidoId		int		not null,
	produtoId		int		not null,
	qtd				int			null	check(qtd > 0)	default 1,
	valor decimal(10,2)			null	check(valor > 0.0),
	-- chave primária composta
	primary key(pedidoId, produtoId),
	-- chaves estrangeiras
	foreign key (pedidoId)	references	Pedidos(idPedido),
	foreign key	(produtoId)	references	Produtos(idProduto)
)
go


-----------------------------------------------------------------
-- Inserir do dados da tabela Pessoas
-----------------------------------------------------------------
insert into Pessoas (nome, cpf, status)
values ('Jose Maria', '111.111.111-11', 1)
go

insert into Pessoas (nome, cpf)
values	('Carlos Roberto', '222.222.222-22')
go

insert into Pessoas
values	('Ana Maria', '333.333.333-33', 2),
		('Pedro Augusto', '444.444.444-44', 2),
		('Valeria Maria', '555.555.555-55', 2),
		('Giorgia Claudia', '666.666.666-66', 2),
		('Miguel Augusto', '777.777.777-77', 1),
		('Talles Augusto', '888.888.888-88', 1),
		('Adriana Antonia', '999.999.999-99', 2),
		('Sergio Ricardo', '101.010.101-01',1)
go

insert into Pessoas (cpf, nome)
values ('254.147.987-25', 'Ana Maria Braga')
go

select * from Pessoas
go

-----------------------------------------------------------------
-- Inserir do dados da tabela Clientes
-----------------------------------------------------------------
insert into Clientes (pessoaId, renda, credito)
values	(1, 5000.00, 1500.00)
go

insert into Clientes
values	(3, 4500.00, 1200.00),
		(5, 2100.00, 700.00),
		(7, 8500, 2000),
		(9, 1206.98, 451.98),
		(11, 1478.63, 127.05)
go

Select * from Pessoas
go

select * from Clientes
go

-----------------------------------------------------------------
-- Consultar os dados de todas as Pessoas que são Clientes
-----------------------------------------------------------------
select Pessoas.idPessoa, Pessoas.nome, Pessoas.cpf, Clientes.renda, Clientes.credito
from Pessoas, Clientes
where Pessoas.idPessoa = Clientes.pessoaId
go


-----------------------------------------------------------------
-- Inserir do dados da tabela Vendedores
-----------------------------------------------------------------
insert into Vendedores (pessoaId, salario)
values	(2, 2500)
go

insert into Vendedores
values	(4, 3500.65),
		(6, 4100.60),
		(8, 4512.32),
		(10, 2541.98)
go

-----------------------------------------------------------------
-- Consultar os dados de todas as Pessoas que são Vendedores
-----------------------------------------------------------------
select P.idPessoa Cod_Vendedor, P.nome Nome_Vendedor, P.cpf CPF, V.salario Salario
from Pessoas as P, Vendedores V
where P.idPessoa = V.pessoaId
go

-----------------------------------------------------------------
-- Inserir do dados da tabela Produtos (10 produtos)
-----------------------------------------------------------------
insert into Produtos (descricao, qtd, valor, status)
values	('Chocolate', 100, 5.50, 1)
go

insert into Produtos (descricao, qtd, valor)
values	('Chocolate', 100, 5.50)
go

insert into Produtos 
values	('Chocolate Branco', 10, 5.70, 1),
		('Bolo de cenoura', 55, 20.50, 1),
		('Coca cola', 200, 8.50, 2),
		('Batata Frita', 30, 17.50, 1),
		('Sorvete de Jabuticaba', 500, 2.50,1),
		('Lanche natural de presunto', 45, 12.90, 1),
		('Coxinha de frango', 250, 9.85, 1),
		('Bolinha de queijo', 150, 8.75, 2)
go

-----------------------------------------------------------------
-- Inserir do dados da tabela Pedidos (5 pedidos)
-----------------------------------------------------------------
insert into Pedidos (data, status, vendedorId, clienteId)
values	(GETDATE(), 1, 2, 1)
go

insert into Pedidos (data, vendedorId, clienteId)
values	(GETDATE(), 4, 1)
go

insert into Pedidos (data, status, vendedorId, clienteId)
values	(GETDATE(), 1, 6, 3),
		(GETDATE(), 2, 8, 11),
		(GETDATE(), 1, 4, 5)
go

select * from Pedidos
go

-----------------------------------------------------------------
-- Inserir do dados da tabela Itens_Pedidos (5 pedidos)
-----------------------------------------------------------------
-- itens do pedido 1
insert into Itens_Pedidos (pedidoId, produtoId, qtd, valor)
values	(1, 2, 5, 5.50),
		(1, 6, 10, 17.50),
		(1, 10, 3, 8.75)
go

-- itens do pedido 2
insert into Itens_Pedidos (pedidoId, produtoId, qtd, valor)
values	(2, 7, 25, 2.50),
		(2, 1, 1, 5.50)
go

-- itens do pedido 3
insert into Itens_Pedidos (pedidoId, produtoId, qtd, valor)
values	(3, 2, 5, 8.00),
		(3, 9, 11, 8.50),
		(3, 4, 2, 20.00),
		(3, 8, 2, 12.90)
go

-- itens do pedido 4
insert into Itens_Pedidos (pedidoId, produtoId, qtd, valor)
values	(4, 2, 5, 8.00),
		(4, 9, 11, 8.50),
		(4, 4, 2, 20.00)
go

-- itens do pedido 5
insert into Itens_Pedidos (pedidoId, produtoId, qtd, valor)
values	(5, 2, 5, 8.00),
		(5, 6, 10, 17.50),
		(5, 4, 2, 20.00),
		(5, 7, 25, 2.50),
		(5, 8, 2, 12.90)
go

select * from Itens_Pedidos
where produtoId = 2
go

-----------------------------------------------------------------
-- CONSULTAS - SELECT
-----------------------------------------------------------------

-- consultar todas as pessoas
select * from Pessoas
go

-- consultar todo os clientes
select * from Clientes
go

-- consultar todas as Pessoas que são Clientes: juntar dados das tabelas Pessoas e Clientes
select Pessoas.idPessoa, Pessoas.nome, Pessoas.cpf, Clientes.renda, Clientes.credito
from Pessoas, Clientes
where Pessoas.idPessoa = Clientes.pessoaId
go

-- consultar todos os Vendedores
select * from Vendedores
go

-- consultar todas as Pessoas que são Vendedores: junção dos dados das tabelas Pessoas e Vendedores
select	P.idPessoa, P.nome, P.cpf, V.salario
from	Pessoas P, Vendedores V
where	P.idPessoa = V.pessoaId
go

-- consultar todos os Pedidos
select * from Pedidos
go

-- consultar os pedidos por clientes: junção de Pessoas, Clientes e Pedidos
-- inner join
select	Pessoas.idPessoa, Pessoas.nome, Pessoas.cpf, Clientes.renda, Clientes.credito,
		Pedidos.idPedido, Pedidos.data, Pedidos.status, Pedidos.vendedorId
from	Pessoas inner join Clientes on Pessoas.idPessoa = Clientes.pessoaId
		inner join Pedidos on Clientes.pessoaId = Pedidos.clienteId
go

-- consultar todos os vendedores que cadastraram Pedidos: junção de Pessoas, Vendedores e Pedidos
-- where
select	P.idPessoa, P.nome, P.cpf, V.salario, Pe.idPedido, Pe.data, Pe.status, Pe.clienteId
from	Pessoas P, Vendedores V, Pedidos Pe
where	P.idPessoa = V.pessoaId and V.pessoaId = Pe.vendedorId
go

-- consultar todos os produtos
select * from Produtos
go

-- consultar os produto de cada pedido: junção entre as tabelas Pedidos, Itens_Pedidos e Produtos
-- where
select	Pe.idPedido, Pe.data, Pe.status, Pe.clienteId, Pe.vendedorId,
		IP.qtd, IP.valor, Pr.idProduto, Pr.descricao
from	Pedidos Pe, Itens_Pedidos IP, Produtos Pr
where	Pe.idPedido = IP.pedidoId and IP.produtoId = Pr.idProduto
go

-- consultar os produto de cada pedido: junção entre as tabelas Pedidos, Itens_Pedidos e Produtos
-- inner join
select	Pe.idPedido, Pe.data, Pe.status, Pe.clienteId, Pe.vendedorId,
		IP.qtd, IP.valor, Pr.idProduto, Pr.descricao
from Pedidos Pe inner join Itens_Pedidos IP		on Pe.idPedido = IP.pedidoId
				inner join Produtos Pr			on IP.produtoId = Pr.idProduto
go

-- consultar o preço médio dos produtos
select AVG(valor) [Preco Medio] from Produtos
go

-- consultar o produto mais caro do estoque
select MAX(valor) [Produto mais caro] from Produtos
go

select * from Produtos
go

-- consultar o produto mais barato em estoque
select MIN(valor) [Produto mais barato] from Produtos
go

-- consultar o custo do estoque
select sum(valor * qtd) [Custo do Estoque] from Produtos
go

-- consultar a quantidade de produtos em estoque
select SUM(qtd) [Qtd de Produtos em Estoque] from Produtos
go

-- consultar a quantidade de itens no estoque
select COUNT(*) [Qtd de itens no Estoque] from Produtos
go

-- consultar os itens de pedidos totalizando cada item
select *, (qtd * valor) [Total item] from Itens_Pedidos
go

-- consultar o total de um pedido
select SUM(qtd * valor) [Total Pedido] from Itens_Pedidos
where pedidoId = 1
go

-- todos os itens acima em uma consulta
select	AVG(valor) [Preco Medio], MAX(valor) [Produto mais caro], 
		MIN(valor) [Produto mais barato], SUM(qtd * valor) [Custo do Estoque],
		SUM(qtd) [Qtd de Produtos em Estoque], COUNT(*) [Qtd Itens em Estoque]
from Produtos
go

-- consultar todos produtos ordenados pela descrição em ordem crescente. 
-- A descrição em caixa alta
select idproduto, UPPER(descricao) Produto, qtd, valor, status
from Produtos
order by descricao ASC
go

-- consultar todos produtos ordenados pela descrição em ordem decrescente. 
-- A descrição em caixa alta
select idproduto, UPPER(descricao) Produto, qtd, valor, status
from Produtos
order by descricao DESC
go

-- consultar produtos com preços entre 2.00 e 10.00
select * from Produtos
where valor >= 2.00 and valor <= 10.0
go

-- ou
select * from Produtos
where valor between 2.00 and 10.00
go

-- consultar todos os produtos que estão em algum pedido
select * from Produtos
where idProduto in (
						select produtoId
						from Itens_Pedidos
					)
go


-- consultar todos os produtos que não estão em  pedidos
select * from Produtos
where idProduto  not in (
							select produtoId
							from Itens_Pedidos
						)
go

-- consultar todas as pessoas com status null
select * from Pessoas
where status is null
go

-- consultar todas as pessoas com status não é null
select * from Pessoas
where status is not null
go

-----------------------------------------------------------------
-- Alteração / atualização - UPDATE
-----------------------------------------------------------------
update Produtos set descricao = 'Chocolate amargo'
where descricao like 'Chocolate' and status is null
go

-- atualizar o estoque do Produto com id = 1
update Produtos set qtd = qtd - 
					(
						select qtd from Itens_Pedidos
						where produtoId = 1
					)
where idProduto = 1
go

-- atualizar o estoque do Produto com id = 2
update Produtos set qtd = qtd - 
					(
						select sum(qtd) from Itens_Pedidos
						where produtoId = 2
					)
where idProduto = 2
go

select * from Itens_Pedidos
go

select * from Produtos
where status = 2
go


-- atualizar a tabela de Produtos dando 10% de desconto para os produtos com status = 2
update Produtos set valor = valor - valor * 0.10  -- valor = valor * 0.90
where status =  2
go

-- alterar o status = 1 de todas as pessoas que são clientes
update Pessoas set status = 1
where idPessoa in	(
						select Pessoas.idPessoa
						from Pessoas inner join Clientes 
						on Pessoas.idPessoa = Clientes.pessoaId
					)
go

-- dar aumento de preço de 5% para os produtos com valor acima da média de preços
update Produtos set valor = valor + valor * 0.05
where valor >	(
					select avg(valor) from Produtos
				)
go

select * from Produtos
go

-- calcular o valor total do pedido 5 e colocar seu status = 2 (finalizado)
update Pedidos set status = 2 , valor = 
				(
					select sum(qtd * valor) from Itens_Pedidos
					where pedidoId = 5
				)
where idPedido = 5
go


select * from Itens_Pedidos
where pedidoId = 5
go

select * from Pedidos
go

-- alterar o status = 1 de todos os pedidos não finalizados
update Pedidos set status = 1
where valor is null
go

-- atualizar o status = 2 de todos os produtos que não estão em pedidos
update Produtos set status = 2
where idProduto in	(
						select idProduto from Produtos
						where idProduto  not in (
							select produtoId
							from Itens_Pedidos
						)
					)
go

select * from Produtos
where idProduto  not in (
	select produtoId
	from Itens_Pedidos
)
go


--------------------------------------------------------------------------
-- Cadastrar 5 produtos
--------------------------------------------------------------------------
insert into Produtos (descricao, qtd, valor, status)
values	('Amendoim salgado', 50, 3.50, 1),
		('Pipoca Rio Preto', 120, 1.50, 1),
		('Vinho Branco', 40, 95.50, 1),
		('Bala de canela', 250, 0.30, 1),
		('Agua com gas', 35, 2.75, 1)
go

select * from Produtos
go

---------------------------------------------------------------------------
-- Exclusão de Dados - DELETE
---------------------------------------------------------------------------
delete from Produtos
where idProduto = 12
go

-- excluir todos os produtos inativos (status = 2)
delete from Produtos
where status = 2
go

