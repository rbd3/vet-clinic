/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Argumon', '2020-02-03', 0, true, 10.23),
('Gabumon', '2018-11-15', 2, true, 8),
('Pikatchu', '2021-01-07', 1, false, 15.04),
('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Charmander', '2020-02-08', 0, false, -11), 
('Plantmon', '2021-11-15', 2, true, -5.7), 
('Squirtle', '1993-04-02', 3, false, -12.13), 
('Angemon', '2005-06-12', 1, true, -45), 
('Boarmon', '2005-06-07', 7, true, 20.4), 
('Blossom', '1998-10-13', 3, true, 17),
('Ditto', '2022-05-14', 4, true, 22);

--add to owners table
INSERT INTO owners (full_name, age) 
VALUES ('Sam Smith', 34), 
('Jennifer', 19), 
('Bob', 45), 
('Melody', 77), 
('Dean Winchester', 14), 
('Jodie Whittaker', 38);

--add to species
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

--add species_id to animals
UPDATE animals SET species_id = CASE  WHEN name LIKE '%_mon' 
THEN (SELECT id FROM species WHERE name = 'Digimon') 
ELSE (SELECT id FROM species WHERE name = 'Pokemon') 
END;

--include owners in animals
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith') 
WHERE name = 'Argumon';
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell') 
WHERE name IN ('Gabumon', 'Pikatchu');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob') 
WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody') 
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester') 
WHERE name IN ('Angemon', 'Boarmon');

--SELECT WITH JOIN
--SELECT name FROM animals 
--INNER JOIN owners ON animals.owner_id = owners.id 
--WHERE owners.full_name = 'Melody Pond';
--SELECT animals.name FROM animals
--INNER JOIN species ON animals.species_id = species.id 
--WHERE species.name = 'Pokemon';

--vets
INSERT INTO vets(name, age, date_of_graduation) 
VALUES ('William Tatcher', 45, '2000-04-23'), 
('Maisy Smith', 26, '2019-01-17'), 
('Stephanie Mendez', 64, '1981-05-04'), 
('Jack Harkness', 38, '2008-06-08');

--specializations
INSERT INTO specializations(vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), 
(SELECT id FROM species WHERE name = 'Pokemon'));

INSERT INTO specializations(vet_id, species_id)
VALUES ((SELECT id 
FROM vets WHERE name = 'Stephanie Mendez'), 
(SELECT id FROM species 
WHERE name = 'Digimon'));

INSERT INTO specializations(vet_id, species_id)
VALUES ((SELECT id 
FROM vets WHERE name = 'Stephanie Mendez'), 
(SELECT id FROM species 
WHERE name = 'Pokemon'));

INSERT INTO specializations(vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), 
(SELECT id FROM species 
WHERE name = 'Digimon'));

INSERT INTO visits(vet_id, animal_id, date_of_visit) 
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), 
(SELECT id FROM animals 
WHERE name = 'Argumon'), '2020-05-24');

INSERT INTO visits(vet_id, animal_id, date_of_visit) 
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), 
(SELECT id FROM animals 
WHERE name = 'Argumon'), '2020-07-22');

INSERT INTO visits(vet_id, animal_id, date_of_visit) 
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), 
(SELECT id FROM animals 
WHERE name = 'Gabumon'), '2020-07-22');

INSERT INTO visits(vet_id, animal_id, date_of_visit) 
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), 
(SELECT id FROM animals 
WHERE name = 'Pikatchu'), '2020-01-05');

INSERT INTO visits(vet_id, animal_id, date_of_visit) 
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), 
(SELECT id FROM animals 
WHERE name = 'Pikatchu'), '2020-03-08');

INSERT INTO visits(vet_id, animal_id, date_of_visit) 
VALUES ((SELECT id FROM vets 
WHERE name = 'Maisy Smith'), 
(SELECT id FROM animals WHERE name = 'Pikatchu'), '2020-03-14');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals 
WHERE name = 'Devimon'), '2021-05-04');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Charmander'), '2021-02-24');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2019-12-21');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2020-08-10');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Squirtle'), '2019-09-29');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-10-03');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-11-04');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-01-24');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2019-05-15');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-02-27');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'), '2020-08-03');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Blossom'), '2020-05-24');

INSERT INTO visits(vet_id, animal_id, date_of_visit) VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Blossom'), '2021-01-11');
