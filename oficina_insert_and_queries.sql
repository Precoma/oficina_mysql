USE oficina;

DESC cliente;
INSERT INTO cliente (nome_completo, CPF, endereco, modelo_veiculo, placa_veiculo) VALUES
					('João Felipe de almeida', '27645308796', 'Rua das amoras nº45 - jardim fruteiras', 'Vectra - 2004', 'ABC-1234'),
                    ('Maria Clara das Rosas', '12345678912', 'Rua das larangeiras nº28 - jardim fruteiras', 'UNO - 2015', 'FEP-4321'),
                    ('Matheus João Silva', '32112345689', 'Rua das pitangueiras nº10 - jardim fruteiras', 'Palio - 2019', 'LDB-8349'),
                    ('Marcos Tavares Flores', '74185296365', 'Rua das macieiras nº438 - jardim fruteiras', 'FORD KA - 2020', 'BRS-4799');


DESC tabela_servicos;
INSERT INTO tabela_servicos (servico, valor) VALUES
							('Limpeza', 150.00),
                            ('Revisão', 80.00),
                            ('Troca de óleo', 50.00),
                            ('Troca de motor', 1590.90),
                            ('Balanceamento', 150.00),
                            ('Pintura', 200.00);

DESC tabela_pecas;
INSERT INTO tabela_pecas (peca, valor) VALUES
							('Pasta polimento', 50.00),
                            ('Motor', 1000.90),
                            ('óleo', 99.00),
                            ('Pneu', 159.90),
                            ('Tinta', 247.00);

DESC OS;
INSERT INTO OS (data_emissao, valor, status_OS, data_conclusao, servicos_necessarios, pecas_necessarias) VALUES
				("2023-10-25",1595.90+150, default, "2023-11-01", 'Balancemanto', 'Pneu'),
                ("2023-10-25",80, default, "2023-10-26", 'Revisão', null),
                ("2023-10-25",99+50, default, "2023-10-27", 'Troca de óleo', 'Óleo'),
                ("2023-10-25",200+247, default, "2023-10-29", 'Pintura', 'Tinta');
                
DESC mecanicos; 
INSERT INTO mecanicos (cliente_designado, OS_feita, nome, endereco, especialidade) VALUES
						(5, 1, 'Carlos Andrada', 'Rua pica-pau - Jardim animais', 'Motores e pintura'),
                        (6, 2, 'Felipe Marcelo', 'Rua andorinhas - Jardim animais', null),
                        (7, 3, 'Fabiano da Silva', 'Rua papagaio - Jardim animais', null),
                        (8, 4, 'João Carlos', 'Rua gato - Jardim animais', null);
                        
					
DESC servicos_necessarias;
INSERT INTO servicos_necessarias (idOS, idServico) VALUES
                                (2, 5),
                                (3, 2),
                                (4, 3),
                                (5, 6);

DESC pecas_necessarias;
INSERT INTO pecas_necessarias (idOS, idPeca, quantidade) VALUES
                                (2, 4, 1),
                                (4, 3, 1),
                                (5, 5, 1);




-- QUERIES

-- Valor que cada cliete pagou no total e data para retirar veiculo;

SELECT cliente.nome_completo, OS.valor, OS.data_conclusao FROM cliente INNER JOIN mecanicos ON idCliente = cliente_designado
					INNER JOIN OS on OS_feita = idOS	
                    ORDER BY data_conclusao;
                    
-- Mecanico e sua especialidade

SELECT nome, especialidade FROM mecanicos;
                            
-- Quantidade de mecanicos gerais
SELECT count(*) FROM mecanicos GROUP BY especialidade = null;


-- Valor Total somando valor da peca e serviço da maria clara das rosas
SELECT nome_completo, valor_servico, valor_peca, round(valor_peca + valor_servico) as valor_total FROM cliente INNER JOIN mecanicos ON idCliente = cliente_designado
					INNER JOIN OS on OS_feita = idOS
                    JOIN (SELECT tabela_servicos.valor as valor_servico FROM servicos_necessarias INNER JOIN tabela_servicos USING(idServico)
										JOIN OS USING(idOS)
										JOIN mecanicos ON OS_feita=idOS
                                        JOIN cliente ON idCliente = cliente_designado
										WHERE nome_completo = 'Maria Clara das Rosas') as valor_servico
                    JOIN(SELECT tabela_pecas.valor as valor_peca FROM pecas_necessarias INNER JOIN tabela_pecas USING(idPeca)
										JOIN OS USING(idOS)
										JOIN mecanicos ON OS_feita=idOS
                                        JOIN cliente ON idCliente = cliente_designado
										WHERE nome_completo = 'Maria Clara das Rosas') as valor_peca
					WHERE nome_completo = 'Maria Clara das Rosas';