
-- S6.1.
--
-- 1. Maak een view met de naam "deelnemers" waarmee je de volgende gegevens uit de tabellen inschrijvingen en uitvoering combineert:
--    inschrijvingen.cursist, inschrijvingen.cursus, inschrijvingen.begindatum, uitvoeringen.docent, uitvoeringen.locatie

create or replace view deelnemers as select inschrijvingen.cursist, inschrijvingen.cursus, inschrijvingen.begindatum, uitvoeringen.docent, uitvoeringen.locatie from inschrijvingen inner join uitvoeringen on uitvoeringen.cursus = inschrijvingen.cursus and uitvoeringen.begindatum = inschrijvingen.begindatum;

select * from inschrijvingen;
select * from uitvoeringen;


-- 2. Gebruik de view in een query waarbij je de "deelnemers" view combineert met de "personeels" view (behandeld in de les):
--     CREATE OR REPLACE VIEW personeel AS
-- 	     SELECT mnr, voorl, naam as medewerker, afd, functie
--       FROM medewerkers;
select * from deelnemers d inner join personeel p on p.mnr = d.cursist;


-- 3. Is de view "deelnemers" updatable ? Waarom ?
-- Antwoord: Nee, want je kan alleen 'orginele' tabellen updaten. Een view bevat misschien een join en dat hoor je niet te kunnen updaten.

-- S6.2.
--
-- 1. Maak een view met de naam "dagcursussen". Deze view dient de gegevens op te halen:
--      code, omschrijving en type uit de tabel curssussen met als voorwaarde dat de lengte = 1. Toon aan dat de view werkt.
create or replace view dagcursussen as select c.code, c.omschrijving, c.type from cursussen c where lengte = 1;
select * from dagcursussen;
select * from uitvoeringen;


-- 2. Maak een tweede view met de naam "daguitvoeringen".
--    Deze view dient de uitvoeringsgegevens op te halen voor de "dagcurssussen" (gebruik ook de view "dagcursussen"). Toon aan dat de view werkt
create or replace view daguitvoeringen as select * from uitvoeringen u inner join dagcursussen d on d.code = u.cursus;

select * from daguitvoeringen;


-- 3. Verwijder de views en laat zien wat de verschillen zijn bij DROP view <viewnaam> CASCADE en bij DROP view <viewnaam> RESTRICT
-- Cascase dropt alle afhankelijke objecten
-- Restrict maakt het verwijderen van de view niet mogelijk als andere objecten van de view afhankelijk zijn
drop view dagcursussen restrict;
-- ERROR:  cannot drop view dagcursussen because other objects depend on it
-- view daguitvoeringen depends on view dagcursussen
drop view dagcursussen cascade;
-- NOTICE:  drop cascades to view daguitvoeringen
-- DROP VIEW
-- zoals je ziet: Verwijderd ook daguitvoeringen