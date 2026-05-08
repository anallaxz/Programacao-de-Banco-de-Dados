SELECT 
    c.nome, 
    v.modelo
FROM clientes c
LEFT JOIN veiculos v ON c.id_cliente = v.id_cliente;
-- desafio1

SELECT 
    m.nome, 
    COUNT(os.id_os) AS total_os
FROM mecanicos m
LEFT JOIN ordens_servicos os ON m.id_mecanico = os.id_mecanico
GROUP BY m.nome;
-- desafio2

SELECT 
    SUM(os.valor_total) AS faturamento_total
FROM ordens_servicos os
JOIN veiculos v ON os.id_veiculo = v.id_veiculo
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE c.cidade = 'São Paulo';
-- desafio3

SELECT 
    v.modelo, 
    m.nome AS mecanico, 
    s.descricao AS servico
FROM ordens_servicos os
JOIN veiculos v ON os.id_veiculo = v.id_veiculo
JOIN mecanicos m ON os.id_mecanico = m.id_mecanico
JOIN itens_servico its ON os.id_os = its.id_os
JOIN servicos s ON its.id_servico = s.id_servico
WHERE os.status_servico = 'Aberto';
-- desafio4

SELECT 
    c.nome, 
    SUM(os.valor_total) AS total_gasto
FROM clientes c
JOIN veiculos v ON c.id_cliente = v.id_cliente
JOIN ordens_servicos os ON v.id_veiculo = os.id_veiculo
GROUP BY c.nome
HAVING SUM(os.valor_total) > (
    SELECT AVG(valor_total) 
    FROM ordens_servicos
);
-- desafio5
