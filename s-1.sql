-- S1.1. Geslacht
--
-- Voeg een kolom `geslacht` toe aan de medewerkerstabel.
-- Voeg ook een beperkingsregel `m_geslacht_chk` toe aan deze kolom,
-- die ervoor zorgt dat alleen 'M' of 'V' als geldige waarde wordt
-- geaccepteerd. Test deze regel en neem de gegooide foutmelding op als
-- commentaar in de uitwerking.
alter table medewerkers add column geslacht char(1);
alter table medewerkers add constraint m_geslacht_chk check (geslacht in ('M', 'V'));


-- S1.2. Nieuwe afdeling
--
-- Het bedrijf krijgt een nieuwe onderzoeksafdeling 'ONDERZOEK' in Zwolle.
-- Om de onderzoeksafdeling op te zetten en daarna te leiden wordt de
-- nieuwe medewerker A DONK aangenomen. Hij krijgt medewerkersnummer 8000
-- en valt direct onder de directeur.
-- Voeg de nieuwe afdeling en de nieuwe medewerker toe aan de database.
insert into afdelingen (anr, naam, locatie) values (70, 'ONDERZOEK', 'ZWOLLE');
insert into medewerkers (mnr, naam, voorletter, functie, chef, anr) values (8000, 'DONK', 'A', 'ONDERZOEK', 7839, 70);

-- S1.3. Verbetering op afdelingentabel
--
-- We gaan een aantal verbeteringen doorvoeren aan de tabel `afdelingen`:
--   a) Maak een sequence die afdelingsnummers genereert. Denk aan de beperking
--      dat afdelingsnummers veelvouden van 10 zijn.
--   b) Voeg een aantal afdelingen toe aan de tabel, maak daarbij gebruik van
--      de nieuwe sequence.
--   c) Op enig moment gaat het mis. De betreffende kolommen zijn te klein voor
--      nummers van 3 cijfers. Los dit probleem op.
create sequence afdelingen_anr_seq start 10 increment 10;
insert into afdelingen (anr, naam, locatie) values (nextval('afdelingen_anr_seq'), 'IT', 'UTRECHT'), (nextval('afdelingen_anr_seq'), 'HR', 'AMESFOORT');
alter table afdelingen alter column anr type NUMERIC;

-- S1.4. Adressen
--
-- Maak een tabel `adressen`, waarin de adressen van de medewerkers worden
-- opgeslagen (inclusief adreshistorie). De tabel bestaat uit onderstaande
-- kolommen. Voeg minimaal één rij met adresgegevens van A DONK toe.
--
--    postcode      PK, bestaande uit 6 karakters (4 cijfers en 2 letters)
--    huisnummer    PK
--    ingangsdatum  PK
--    einddatum     moet na de ingangsdatum liggen
--    telefoon      10 cijfers, uniek
--    med_mnr       FK, verplicht

create table adressen (
                          postcode CHAR(6) NOT NULL,
                          huisnummer INTEGER NOT NULL,
                          ingangsdatum DATE NOT NULL,
                          einddatum DATE NOT NULL,
                          telefoon CHAR(10) NOT NULL UNIQUE,
                          med_mnr INTEGER NOT NULL,

                          constraint pk_adressen primary key (postcode, huisnummer, ingangsdatum),
                          constraint fk_adressen_medewerker foreign key (med_mnr) references medewerkers (mnr),
                          constraint ch_postcode check (postcode ~ '^\d{4}[A-Z]{2}$'),
constraint ch_telefoon check (telefoon ~ '^\d{10}$'),
constraint ch_date check (einddatum > ingangsdatum)
)

-- S1.5. Commissie
--
-- De commissie van een medewerker (kolom `comm`) moet een bedrag bevatten als de medewerker een functie als
-- 'VERKOPER' heeft, anders moet de commissie NULL zijn. Schrijf hiervoor een beperkingsregel. Gebruik onderstaande
-- 'illegale' INSERTs om je beperkingsregel te controleren.

alter table medewerkers add constraint ch_comm_verkoper check ((functie = 'VERKOPER' and comm is null) OR (functie <> 'verkoper' and comm is not null));


