CREATE TABLE IF NOT EXISTS cats (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  breed VARCHAR(255),
  description TEXT
);

INSERT INTO cats (name, breed, description) VALUES
('みー', '三毛', '地域猫'),
('クロ', '黒猫', '地域猫'),
('シロ', '白猫', '飼い猫'),
('不思議な猫', NULL, NULL);
