use bd_vendas;
select Nome, nascimento from Cliente where Month(Nascimento) = 6;

-- 1. Listar todos os clientes que fazem aniversário no mês junho; 
select Nome from Cliente where Month(Nascimento) = 4;

-- 2. Listar quantos dias de vida cada cliente tem no dia de hoje;  
select datediff(NOW(), Nascimento) 'Dias de diferenças' from Cliente;

-- 3. Criar uma consulta SQL que liste todos os clientes, seus pedidos e no pedido indique a descrição do status do pedido; 
select c.Nome, p.idPedido, s.Descricao  from Cliente c
join Pedido p
on c.idCliente = p.Cliente_idCliente
join Status s
on p.Status_idStatus = s.idStatus;

-- 4. Construir uma consulta SQL que liste o pedido, o produto, a quantidade de produtos do pedido, o valor unitário do produto e o valor total (quantidade x valor unitário). 
select p.idPedido, po.Nome, pp.Quantidade,
pp.PrecoUnitario, (pp.Quantidade * pp.PrecoUnitario) as valor_total
from Cliente c
join Pedido p
on c.idCliente = p.Cliente_idCliente
join Status s
on p.Status_idStatus = s.idStatus
join Pedido_has_Produto pp
on p.idPedido = pp.Pedido_idPedido
join Produto po
on pp.Produto_idProduto = po.idProduto
;	

-- 5. Gerar uma relação com as quantidades e valores totais dos pedidos agrupados pela descrição do status; 
SELECT s.Descricao, COUNT(p.idPedido) Quantidade, SUM(p.ValorTotalPedido) "Valor total"
FROM Pedido p
JOIN Status s ON s.idStatus=p.Status_idStatus
GROUP BY s.Descricao;

-- 6. Listar todos os clientes e seus endereços. Para cada endereço, mostrar de forma descritiva qual o tipo do endereço; 
SELECT c.idCliente,
      c.Nome,
      e.UF,
      e.Cidade,
      e.Bairro,
      e.CEP,
      e.Logradouro,
      e.Complemento,
      e.Numero,
      IF(e.EnderecoPadrao, 'É o endereço padrão', 'Não é o endereço padrão') "Endereço Padrão?",
      t.Descricao                                                            "Tipo de endereço"
FROM Cliente c
JOIN Endereco e ON c.idCliente = e.idEndereco
JOIN TipoEndereco t on t.idTipoEndereco = e.TipoEndereco_idTipoEndereco;





-- 7. Criar uma listagem com a contagem de todos os produtos, soma do preço x quatestoque, agrupados pela descrição da categoria; 
select c.Descricao,
      count(p.idProduto) as Quantidade,
      sum(p.Preco * p.QuantEstoque) as Total
from Produto p
join Categoria c on p.Categoria_idCategoria = c.idCategoria
group by c.Descricao;

-- 8. Criar um script SQL para listar todos os clientes que moram na Cidade de São Paulo; 
select c.Nome,
      e.Cidade
from Cliente c
join Endereco e on c.idCliente = e.Cliente_idCliente
where e.Cidade = 'São Paulo';

-- 9. Criar um relatório mostrando o nome do cliente e os produtos que ele comprou em quaisquer pedidos com status fechado; 
select cli.nome as 'Nome do Cliente', prod.nome as 'Produto', st.Descricao as 'Situação do Pedido'
from Cliente cli
join Pedido pe on pe.cliente_idCliente = cli.idCliente
join Status st on st.idStatus = pe.status_idStatus
join Pedido_has_Produto php on php.pedido_idPedido = pe.idPedido
join Produto prod on prod.idProduto = php.Produto_idProduto
where st.Descricao = 'Fechado'
ORDER BY cli.Nome;



-- 10. Mostrar mês a mês quantos (quantidade) pedidos foram feitos.           
select month(DataPedido) as 'Mês', year(DataPedido) as 'Ano', count(*) as 'Quantidade de Pedidos'
from Pedido
group by year(DataPedido), month(DataPedido)
order by Ano, Mês;

