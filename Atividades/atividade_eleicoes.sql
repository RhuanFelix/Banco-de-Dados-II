CREATE TABLE candidates (
    candidate_id SERIAL PRIMARY KEY,
    candidate_name VARCHAR(100),
    party VARCHAR(50)
);
CREATE TABLE votes (
    vote_id SERIAL PRIMARY KEY,
    candidate_id INT,
    region_id INT,
    vote_count INT
);
CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(100)
);

INSERT INTO candidates(candidate_name, party) VALUES 
('Alice', 'Partido A'),
('Bob', 'Partido B'),
('Charlie', 'Partido C');

INSERT INTO regions(region_name) VALUES 
('Região Norte'),
('Região Sul');

INSERT INTO votes(candidate_id, region_id, vote_count) VALUES
(1, 1, 500),
(2, 1, 300),
(1, 2, 200),
(3, 1, 150),
(2, 2, 250),
(3, 2, 400);

-- questão 1:
SELECT SUM(v.vote_count), c.candidate_name 
FROM candidates c INNER JOIN votes v
ON c.candidate_id = v.candidate_id
GROUP BY c.candidate_name;

-- questão 2:
SELECT AVG(v.vote_count), r.region_name
FROM votes v INNER JOIN regions r
ON v.region_id = r.region_id
GROUP BY r.region_name;

-- questão 3:
SELECT c.candidate_name, MAX(v.vote_count)
FROM candidates c INNER JOIN votes v
ON c.candidate_id = v.candidate_id INNER JOIN regions r
ON r.region_id = v.region_id
WHERE r.region_id = 1 -- região norte
GROUP BY c.candidate_name;

-- questão 4:
SELECT r.region_name, MAX(v.vote_count)
FROM regions r INNER JOIN votes v
ON r.region_id = v.region_id
GROUP BY r.region_name, v.vote_count
ORDER BY v.vote_count DESC
LIMIT 1;

-- questão 5:
SELECT c.candidate_name, SUM(v.vote_count)
FROM candidates c INNER JOIN votes v
ON c.candidate_id = v.candidate_id
GROUP BY c.candidate_name
ORDER BY SUM(v.vote_count) DESC
LIMIT 1;

-- questão 6:
SELECT c.candidate_name, SUM(v.vote_count)
FROM candidates c INNER JOIN votes v
ON c.candidate_id = v.candidate_id
GROUP BY c.candidate_name
HAVING SUM(v.vote_count) > 500;

-- questão 7:
SELECT r.region_name, c.candidate_name, SUM(v.vote_count)
FROM candidates c INNER JOIN votes v
ON c.candidate_id = v.candidate_id INNER JOIN regions r
ON r.region_id = v.region_id
GROUP BY r.region_name, c.candidate_name
ORDER BY r.region_name;

-- questão 8:
SELECT AVG(v.vote_count), r.region_name
FROM votes v INNER JOIN regions r
ON v.region_id = r.region_id
GROUP BY r.region_name
HAVING AVG(v.vote_count) < 300.000;

SELECT c.candidate_name, SUM(v.vote_count), c.party
FROM candidates c INNER JOIN votes v
ON c.candidate_id = v.candidate_id
GROUP BY c.candidate_name, c.party
HAVING SUM(v.vote_count) > 300 AND c.party = 'Partido A';