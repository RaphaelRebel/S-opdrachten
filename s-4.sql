-- S4.1.
-- Geef nummer, functie en geboortedatum van alle medewerkers die vóór 1980
-- geboren zijn, en trainer of verkoper zijn.
select mnr as nummer, functie, gbdatum as geboortedatum from medewerkers where gbdatum < '1980-01-01' and functie in ('TRAINER', 'VERKOPER');

-- S4.2.
-- Geef de naam van de medewerkers met een tussenvoegsel (b.v. 'van der').
select naam from medewerkers where naam like '% %';

-- S4.3.
-- Geef nu code, begindatum en aantal inschrijvingen (`aantal_inschrijvingen`) van alle
-- cursusuitvoeringen in 2019 met minstens drie inschrijvingen.
select cursus as code, begindatum, count(*) as aantal_inschrijvingen from inschrijvingen where extract(year from begindatum) = 2019 group by cursus, begindatum having count(*) >= 3;


-- S4.4.
-- Welke medewerkers hebben een bepaalde cursus meer dan één keer gevolgd?
-- Geef medewerkernummer en cursuscode.
select cursist as medewerkernummer, cursus from inschrijvingen group by cursist, cursus having count(cursist) > 1;

-- S4.5.
-- Hoeveel uitvoeringen (`aantal`) zijn er gepland per cursus?
-- Een voorbeeld van het mogelijke resultaat staat hieronder.
--
--   cursus | aantal
--  --------+-----------
--   ERM    | 1
--   JAV    | 4
--   OAG    | 2

select cursus, count(*) as aantal from uitvoeringen group by cursus;

-- S4.6.
-- Bepaal hoeveel jaar leeftijdsverschil er zit tussen de oudste en de
-- jongste medewerker (`verschil`) en bepaal de gemiddelde leeftijd van
-- de medewerkers (`gemiddeld`).
-- Je mag hierbij aannemen dat elk jaar 365 dagen heeft.
select ((max(gbdatum) - min(gbdatum)) / 365) as leeftijdsverschil, round(avg(extract(days from (now() - gbdatum)) / 365)) as gemiddelde_leeftijd from medewerkers;


-- S4.7.
-- Geef van het hele bedrijf een overzicht van het aantal medewerkers dat
-- er werkt (`aantal_medewerkers`), de gemiddelde commissie die ze
-- krijgen (`commissie_medewerkers`), en hoeveel dat gemiddeld
-- per verkoper is (`commissie_verkopers`).

select count(*) as aantal_medewerkers, round(avg(comm)) as commissie_medewerkers, round((select avg(comm) from medewerkers where functie = 'VERKOPER')) as commissie_verkopers from medewerkers;
