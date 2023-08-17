/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%_mon';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Argumon' OR name = 'Pikatchu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

BEGIN;

UPDATE animals SET species = 'unspecified';

-- verfying that change was made
SELECT * FROM animals;

--Roll back the change 
ROLLBACK;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%_mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;
SAVEPOINT SP1;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

--Number of animals 
SELECT COUNT(*) FROM animals;

--Number of animals never escape
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

--Average weight of animals
SELECT AVG(weight_kg) FROM animals;

--Animals who escape the most
SELECT name FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);

--Min and max
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals WHERE species = 'digimon';
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals WHERE species = 'pokemon';

--AVG BY TYPE
SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'GROUP BY species;

--JOIN
SELECT animals.name 
FROM animals INNER JOIN species 
ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';
SELECT o.full_name, a.name AS animal_name 
FROM owners o LEFT JOIN animals a 
ON a.owner_id = o.id; --The LEFT JOIN ensures that all owners are included, even if they don't own any animals.
SELECT species.name, COUNT(animals.species_id) AS animal_count 
FROM animals INNER JOIN species 
ON animals.species_id = species.id 
GROUP BY species.name;
SELECT animals.name, owners.full_name AS owner 
FROM animals INNER JOIN species 
ON animals.species_id = species.id 
INNER JOIN owners ON animals.owner_id = owners.id 
WHERE species.name = 'Digimon' 
AND owners.full_name = 'Jennifer Orwell';
SELECT animals.name AS animals_name, animals.escape_attempts 
FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id 
WHERE animals.escape_attempts = 0 
AND owners.full_name = 'Dean Winchester';
SELECT owners.full_name, COUNT(animals.id) AS animal_count 
FROM owners 
INNER JOIN animals 
ON owners.id = animals.owner_id 
GROUP BY owners.full_name 
ORDER BY animal_count 
DESC LIMIT 1;
