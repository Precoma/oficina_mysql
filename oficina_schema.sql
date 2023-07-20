CREATE DATABASE oficina;
USE oficina;

CREATE TABLE cliente(
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(45) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    endereco VARCHAR(45) NOT NULL,
    modelo_veiculo VARCHAR(45) NOT NULL,
    placa_veiculo CHAR(8) NOT NULL UNIQUE
);

CREATE TABLE tabela_servicos(
	idServico INT AUTO_INCREMENT PRIMARY KEY,
    servico VARCHAR(45) NOT NULL,
    valor FLOAT NOT NULL
);

CREATE TABLE tabela_pecas(
	idPeca INT AUTO_INCREMENT PRIMARY KEY,
    peca VARCHAR(45) NOT NULL,
    valor FLOAT NOT NULL
);

CREATE TABLE OS(
	idOS INT AUTO_INCREMENT PRIMARY KEY,
    data_emissao DATE NOT NULL,
    valor FLOAT,
    status_OS ENUM('Aguardando Pagamento', 'Aguardando Serviço', 'Concluido'),
    data_conclusao DATE,
    servicos_necessarios VARCHAR(45),
    pecas_necessarias VARCHAR(45)
);

CREATE TABLE mecanicos(
	idMecanico INT AUTO_INCREMENT PRIMARY KEY,
    cliente_designado INT,
    OS_feita INT,
    nome VARCHAR(45),
    endereco VARCHAR(45),
    especialidade VARCHAR(45),
    CONSTRAINT fk_mecanico_cliente FOREIGN KEY (cliente_designado) REFERENCES cliente(idCliente),
    CONSTRAINT fk_mecanico_OS FOREIGN KEY (OS_feita) REFERENCES OS(idOS)
);

CREATE TABLE pecas_necessarias(
	idOS INT NOT NULL,
    idPeca INT NOT NULL,
    quantidade INT NOT NULL,
    PRIMARY KEY(idOS, idPeca),
    CONSTRAINT fk_pecasNecessarias_OS FOREIGN KEY (idOS) REFERENCES OS(idOS),
    CONSTRAINT fk_pecasNecessarias_pecas FOREIGN KEY (idPeca) REFERENCES tabela_pecas(idPeca)
);

CREATE TABLE servicos_necessarias(
	idOS INT NOT NULL,
    idServico INT NOT NULL,
    PRIMARY KEY(idOS, idServico),
    CONSTRAINT fk_servicosNecessarias_OS FOREIGN KEY (idOS) REFERENCES OS(idOS),
    CONSTRAINT fk_servicosNecessarias_servicos FOREIGN KEY (idServico) REFERENCES tabela_servicos(idServico)
);
    
    

    