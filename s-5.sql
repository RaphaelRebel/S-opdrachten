-- S5.1.
-- Welke medewerkers hebben zowel de Java als de XML cursus
-- gevolgd? Geef hun personeelsnummers.
select cursist from inschrijvingen where cursist in (select cursist from inschrijvingen where cursus = 'XML') and cursist in (select cursist from inschrijvingen where cursus = 'JAV');

-- S5.2.
-- Geef de nummers van alle medewerkers die niet aan de afdeling 'OPLEIDINGEN'
-- zijn verbonden.
select mnr from medewerkers where afd not in (select anr from afdelingen where naam = 'OPLEIDINGEN');


-- S5.3.
-- Geef de nummers van alle medewerkers die de Java-cursus niet hebben
-- gevolgd.
select mnr from medewerkers where mnr not in (select cursist from inschrijvingen where cursus = 'JAV');

-- S5.4.
-- a. Welke medewerkers hebben ondergeschikten? Geef hun naam.
select naam from medewerkers where mnr in (select chef from medewerkers);

-- b. En welke medewerkers hebben geen ondergeschikten? Geef wederom de naam.
select naam from medewerkers where mnr not in (select chef from medewerkers where chef is not null);
-- S5.5.
-- Geef cursuscode en begindatum van alle uitvoeringen van programmeercursussen
-- ('BLD') in 2020.
select cursus, begindatum from uitvoeringen where cursus in (select code from cursussen where type = 'BLD') and  extract(year from begindatum) = 2020;

-- S5.6.
-- Geef van alle cursusuitvoeringen: de cursuscode, de begindatum en het
-- aantal inschrijvingen (`aantal_inschrijvingen`). Sorteer op begindatum.
select u.cursus, u.begindatum, (select count(*) from inschrijvingen as i where u.cursus = i.cursus and i.begindatum = u.begindatum) as aantal_inschrijvingen from uitvoeringen as u order by u.begindatum;

-- S5.7.
-- Geef voorletter(s) en achternaam van alle trainers die ooit tijdens een
-- algemene ('ALG') cursus hun eigen chef als cursist hebben gehad.
select m1.naam, m1.voorl from medewerkers as m1 where m1.functie = 'TRAINER' and chef in (select cursist from inschrijvingen where cursus in (select code from cursussen where type = 'ALG') and cursus in (select cursus from uitvoeringen where docent = m1.mnr));

-- S5.8.
-- Geef de naam van de medewerkers die nog nooit een cursus hebben gegeven.
select naam from medewerkers where mnr not in (select docent from uitvoeringen where docent is not null);