CREATE TABLE hospedes(
	hospede_id SERIAL PRIMARY KEY,
	nome VARCHAR(100),
	email VARCHAR(100)
);

CREATE TABLE quartos(
	quarto_id SERIAL PRIMARY KEY,
	tipo_quarto VARCHAR(8), -- Standard, Luxo, Suíte
	preco_night DECIMAL
);

CREATE TABLE reservas(
	reserva_id SERIAL PRIMARY KEY,
	hospede_id INT,
	quarto_id INT,
	data_checkin DATE,
	data_checkout DATE,
	preco DECIMAL,
	FOREIGN KEY (hospede_id) REFERENCES hospedes(hospede_id),
	FOREIGN KEY (quarto_id) REFERENCES quartos(quarto_id)
);

INSERT INTO hospedes(nome, email) VALUES 
('thiago', 'thiago@email.com'),
('Miguel', 'miguel@email.com');

INSERT INTO quartos(tipo_quarto, preco_night) VALUES
('Standart', 400),
('Luxo', 1000),
('Suíte', 600);

INSERT INTO reservas(hospede_id, quarto_id, data_checkin, data_checkout, preco) VALUES
(1, 1, '2025-10-02', '2025-10-03', 400),
(1, 2, '2025-11-14', '2025-11-16', 2000),
(2, 3, '2025-12-04', '2025-12-10', 3600),
(2, 2, '2025-12-24', '2025-12-25', 1000),
(2, 2, '2025-03-29', '2025-03-30', 1000),
(2, 2, '2025-07-24', '2025-07-28', 4000),
(2, 2, '2025-08-18', '2025-08-19', 1000),
(1, 2, '2025-11-18', '2025-11-19', 1000);

-- questão 1:
SELECT h.nome, SUM(r.preco) preco_reserva
FROM hospedes h INNER JOIN reservas r
ON r.hospede_id = h.hospede_id
GROUP BY h.nome;

-- questão 2:
SELECT h.hospede_id
FROM hospedes h INNER JOIN reservas r
ON h.hospede_id = r.hospede_id
GROUP BY h.hospede_id
HAVING SUM(r.preco) > 2000;

-- questão 3:
SELECT quarto_id, AVG(preco_night) media_preco
FROM quartos
GROUP BY quarto_id;

-- questão 4:
SELECT q.quarto_id, SUM(r.preco) soma_preco_reservas
FROM quartos q INNER JOIN reservas r
ON q.quarto_id = r.quarto_id
GROUP BY q.quarto_id;

-- questão 5:
SELECT h.nome nome_hospede, COUNT(r.*) quantidade_reservas
FROM hospedes h INNER JOIN reservas r
ON h.hospede_id = r.hospede_id
GROUP BY h.nome
ORDER BY COUNT(r.*) DESC;

-- questão 6:
SELECT q.*, COUNT(r.*) qtd_total_reservas, SUM(r.preco) preco_total_reservas_do_quarto
FROM quartos q INNER JOIN reservas r
ON r.quarto_id = q.quarto_id
GROUP BY q.quarto_id
HAVING COUNT(r.*) > 5;

-- questão 7:
SELECT MIN(r.preco) menor_preco_reserva, MAX(r.preco)
maior_preco_reserva, AVG(r.preco) media_preco_reserva, h.nome nome_hospede
FROM reservas r INNER JOIN hospedes h
ON r.hospede_id = h.hospede_id
GROUP BY h.nome
HAVING h.nome LIKE '%ago';

SELECT q.quarto_id, SUM(r.preco) soma_preco_reservas
FROM quartos q INNER JOIN reservas r
ON q.quarto_id = r.quarto_id
GROUP BY q.quarto_id
HAVING SUM(r.preco) >= 3000;