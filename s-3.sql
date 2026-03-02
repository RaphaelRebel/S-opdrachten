-- S3.1.
-- Produceer een overzicht van alle cursusuitvoeringen; geef de
-- code, de begindatum, de lengte en de naam van de docent.
select u.cursus, u.begindatum, c.lengte, m.naam from uitvoeringen as u inner join medewerkers as m on u.docent = m.mnr inner join cursussen as c on c.code = u.cursus;


-- S3.2.
-- Geef in twee kolommen naast elkaar de achternaam van elke cursist (`cursist`)
-- van alle S02-cursussen, met de achternaam van zijn cursusdocent (`docent`).

select docent.naam, cursist.naam from inschrijvingen as i inner join uitvoeringen as u on u.cursus = i.cursus inner join medewerkers as cursist on cursist.mnr = i.cursist inner join medewerkers as docent on docent.mnr = u.docent where u.cursus = 'S02';


-- S3.3.
-- Geef elke afdeling (`afdeling`) met de naam van het hoofd van die
-- afdeling (`hoofd`).
select a.naam as afdeling, m.naam as hoofd from afdelingen as a inner join medewerkers as m on a.hoofd = m.mnr;

-- S3.4.
-- Geef de namen van alle medewerkers, de naam van hun afdeling (`afdeling`)
-- en de bijbehorende locatie.

select m.naam, a.naam as afdeling, a.locatie from medewerkers as m left join afdelingen as a on m.afd = a.anr;

-- S3.5.
-- Geef de namen van alle cursisten die staan ingeschreven voor de cursus S02 van 12 april 2019
-- select cursist.naam from inschrijvingen as i right join medewerkers as cursist on cursist.mnr = i
select cursist.naam from inschrijvingen as i left join medewerkers as cursist on i.cursist = cursist.mnr where i.cursus = 'S02' and begindatum = '2019-04-12';

-- S3.6.
-- Geef de namen van alle medewerkers en hun toelage.
select m.naam, s.toelage from medewerkers as m left join schalen as s on m.maandsal >= s.ondergrens and m.maandsal <= s.bovengrens;
