/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT,
    PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(100);

CREATE TABLE owners (id SERIAL PRIMARY KEY, full_name VARCHAR(100), age INT);
CREATE TABLE species (id SERIAL PRIMARY KEY, name VARCHAR(100));

--REMOVE species colomn
ALTER TABLE animals DROP COLUMN species;

--ADD FOREIGN KEY
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_animals_species FOREIGN KEY (species_id) REFERENCES species (id);
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_animals_owner FOREIGN KEY (owner_id) REFERENCES owners (id);

--VETS TABLE
CREATE TABLE vets (id INT GENERATED ALWAYS AS IDENTITY, 
name VARCHAR(100), 
age INT, date_of_graduation DATE, 
PRIMARY KEY(id));

--SPECIALISATION TABLE
CREATE TABLE specializations (vet_id INT REFERENCES vets(id), 
species_id INT REFERENCES species(id), 
PRIMARY KEY (vet_id, species_id));

--visits
CREATE TABLE visits (vet_id INT REFERENCES vets(id), 
animal_id INT REFERENCES animals(id), date_of_visit DATE, 
PRIMARY KEY (vet_id, animal_id));
ALTER TABLE visits DROP CONSTRAINT visits_pkey; --i can't add multiple visits

