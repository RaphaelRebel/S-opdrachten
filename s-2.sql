-- S2.1. Vier-daagse cursussen
--
-- Geef code en omschrijving van alle cursussen die precies vier dagen duren.
select code, omschrijving from cursussen where lengte = 4;

-- S2.2. Medewerkersoverzicht
--
-- Geef alle informatie van alle medewerkers, gesorteerd op functie,
-- en per functie op leeftijd (van jong naar oud).
select * from medewerkers order by functie asc, gbdatum desc;

-- S2.3. Door het land
--
-- Welke cursussen zijn in Utrecht en/of in Maastricht uitgevoerd? Geef
-- code en begindatum.
select c.code, u.begindatum from cursussen as c inner join uitvoeringen as u on u.locatie = 'UTRECHT' or u.locatie = 'MAASTRICHT';

-- S2.4. Namen
--
-- Geef de naam en voorletters van alle medewerkers, behalve van R. Jansen.
select naam, voorl from medewerkers where not (voorl = 'R' and naam = 'JANSEN');

-- S2.5. Nieuwe SQL-cursus
--
-- Er wordt een nieuwe uitvoering gepland voor cursus S02, en wel op de
-- komende 2 maart. De cursus wordt gegeven in Leerdam door Nick Smit.
insert into uitvoeringen (cursus, begindatum, docent, locatie) values ('S02', '2026-03-02', (select mnr from medewerkers where naam = 'SMIT' and voorl = 'N'), 'LEERDAM');

-- S2.6. Stagiairs
--
-- Neem één van je collega-studenten aan als stagiair ('STAGIAIR') en
-- voer zijn of haar gegevens in. Kies een personeelnummer boven de 8000.
insert into medewerkers (mnr,naam, voorl, functie, chef, gbdatum, maandsal, afd) values (8001, 'WILLEMS', 'A', 'STAGIAIR', 7369, '2003-06-18', 200, 20);

-- S2.7. Nieuwe schaal
--
-- We breiden het salarissysteem uit naar zes schalen. Voer een extra schaal in voor mensen die
-- tussen de 3001 en 4000 euro verdienen. Zij krijgen een toelage van 500 euro.
insert into schalen (snr, ondergrens, bovengrens, toelage) values (6, 3001.00, 4000.00, 500.00);

-- S2.8. Nieuwe cursus
--
-- Er wordt een nieuwe 6-daagse cursus 'Data & Persistency' in het programma opgenomen.
-- Voeg deze cursus met code 'D&P' toe, maak twee uitvoeringen in Leerdam en schrijf drie
-- mensen in.
insert into cursussen (code, omschrijving, type, lengte) values ('D&P', 'Data & Persistency', 'DSG', 6);
insert into uitvoeringen (cursus, begindatum, docent, locatie) values ('D&P', '2026-02-02', 7902, 'LEERDAM');
insert into uitvoeringen (cursus, begindatum, docent, locatie) values ('D&P', '2026-03-03', 7902, 'LEERDAM');
insert into inschrijvingen (cursist, cursus, begindatum, evaluatie) values (7499, 'D&P', '2026-02-02', 5);
insert into inschrijvingen (cursist, cursus, begindatum, evaluatie) values (7844, 'D&P', '2026-03-03', 5);
insert into inschrijvingen (cursist, cursus, begindatum, evaluatie) values (7782, 'D&P', '2026-03-03', 5);

-- S2.9. Salarisverhoging
--
-- De medewerkers van de afdeling VERKOOP krijgen een salarisverhoging
-- van 5.5%, behalve de manager van de afdeling, deze krijgt namelijk meer: 7%.
-- Voer deze verhogingen door.
update medewerkers set maandsal = maandsal * 1.055 from afdelingen where medewerkers.afd = afdelingen.anr AND afdelingen.naam = 'VERKOOP' and medewerkers.functie <> 'MANAGER';
update medewerkers set maandsal = maandsal * 1.07 from afdelingen where medewerkers.afd = afdelingen.anr AND afdelingen.naam = 'VERKOOP' and medewerkers.functie = 'MANAGER';

-- S2.10. Concurrent
--
-- Martens heeft als verkoper succes en wordt door de concurrent
-- weggekocht. Verwijder zijn gegevens.

-- Zijn collega Alders heeft ook plannen om te vertrekken. Verwijder ook zijn gegevens.
-- Waarom lukt dit (niet)?
delete from medewerkers where naam = 'MARTENS' and functie = 'VERKOPER';
delete from medewerkers where naam = 'ALDERS';
-- Dit werkt niet, omdat de foreign key constraint "i_cursust_fk" in inschrijvingen nog verwijst naar de mnr van ALDERS

-- S2.11. Nieuwe afdeling
--
-- Je wordt hoofd van de nieuwe afdeling 'FINANCIEN' te Leerdam,
-- onder de hoede van De Koning. Kies een personeelnummer boven de 8000.
-- Zorg voor de juiste invoer van deze gegevens.
insert into afdelingen (anr, naam, locatie) values (50, 'FINANCIEN', 'LEERDAM');
insert into medewerkers (mnr,naam, voorl, functie, chef, gbdatum, maandsal, afd) values (8002, 'REBEL', 'R', 'MANAGER', 7839, '2003-06-18', 4000, 50);
update afdelingen set hoofd = 8002 where anr = 50;
