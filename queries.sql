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
SELECT animals.name, owners.full_name AS owner 
FROM animals 
INNER JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

--visits
SELECT animals.name FROM visits 
JOIN vets ON visits.vet_id = vets.id JOIN animals 
ON visits.animal_id = animals.id 
WHERE vets.name = 'William Tatcher' ORDER BY visits.date_of_visit 
DESC LIMIT 1;

SELECT COUNT(DISTINCT visits.animal_id) AS animal_count 
FROM visits JOIN vets ON visits.vet_id = vets.id 
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name AS vets_name, species.name AS specialties 
FROM vets LEFT JOIN specializations 
ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

SELECT animals.name AS animal_name, visits.date_of_visit 
FROM visits JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animal_id = animals.id 
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit 
BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name AS animal_name, 
COUNT(visits.animal_id) AS visit_count 
FROM visits JOIN animals ON visits.animal_id = animals.id 
GROUP BY animals.name ORDER BY visit_count 
DESC LIMIT 1;

SELECT animals.name AS animal_name, 
MIN(visits.date_of_visit) AS first_visit_date 
FROM visits JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animal_id = animals.id 
WHERE vets.name = 'Maisy Smith' GROUP BY animals.name 
ORDER BY first_visit_date LIMIT 1;

SELECT animals.name AS animal_name, 
vets.name AS vet_name, visits.date_of_visit 
FROM visits JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animal_id = animals.id 
ORDER BY visits.date_of_visit 
DESC LIMIT 1;

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS mismatched_specialties 
FROM visits JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animal_id = animals.id LEFT JOIN specializations ON specializations.vet_id = vets.id AND specializations.species_id = animals.species_id 
WHERE specializations.species_id IS NULL;

--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name AS potential_specialty, 
COUNT(*) AS visit_count FROM visits 
JOIN vets ON visits.vet_id = vets.id 
JOIN animals ON visits.animal_id = animals.id 
JOIN species ON animals.species_id = species.id 
WHERE vets.name = 'Maisy Smith' GROUP BY species.name 
ORDER BY visit_count DESC LIMIT 1;