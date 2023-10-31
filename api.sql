-- Crie as tabelas necessárias
CREATE TABLE Emitente (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    CNPJ VARCHAR(14),
    Endereco VARCHAR(255)
);

CREATE TABLE Destinatario (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    CNPJ VARCHAR(14),
    Endereco VARCHAR(255)
);

CREATE TABLE Produto (
    ID INT PRIMARY KEY,
    Nome VARCHAR(255),
    Valor DECIMAL(10, 2),
    Quantidade INT
);

-- Crie a stored procedure para inserir dados do XML nas tabelas
CREATE PROCEDURE InserirDadosXML
    @XMLData XML
AS
BEGIN
    -- Emitente
    INSERT INTO Emitente (Nome, CNPJ, Endereco)
    SELECT
        @XMLData.value('(Emitente/Nome)[1]', 'VARCHAR(255)'),
        @XMLData.value('(Emitente/CNPJ)[1]', 'VARCHAR(14)'),
        @XMLData.value('(Emitente/Endereco)[1]', 'VARCHAR(255)');

    -- Destinatário
    INSERT INTO Destinatario (Nome, CNPJ, Endereco)
    SELECT
        @XMLData.value('(Destinatario/Nome)[1]', 'VARCHAR(255)'),
        @XMLData.value('(Destinatario/CNPJ)[1]', 'VARCHAR(14)'),
        @XMLData.value('(Destinatario/Endereco)[1]', 'VARCHAR(255)');

    -- Produtos
    INSERT INTO Produto (Nome, Valor, Quantidade)
    SELECT
        Produtos.value('(Nome)[1]', 'VARCHAR(255)'),
        Produtos.value('(Valor)[1]', 'DECIMAL(10, 2)'),
        Produtos.value('(Quantidade)[1]', 'INT')
    FROM @XMLData.nodes('Produtos/Produto') AS T(Produtos);

    -- Adicione aqui os outros dados do XML e tabelas relevantes

END;
