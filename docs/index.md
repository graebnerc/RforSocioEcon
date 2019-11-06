--- 
title: "R für die sozio-ökonomische Forschung"
subtitle: "Version 0.4.0"
author: "[Dr. Claudius Gräbner](http://claudius-graebner.com/)"
date: "2019-11-06" 
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: graebnerc/RforSocioEcon
description: "R Skript in der Version 0.4.0"
---

# Willkommen {-}

Dieses Skript ist als Begleitung für die Lehrveranstaltung 
"Wissenschaftstheorie und Einführung in die Methoden der Sozioökonomie"
im Master "Sozioökonomie" an der Universität Duisburg-Essen gedacht.

Es enthält grundlegende Informationen über die Funktion der
Programmiersprache R [@R-Team]. 

## Verhältnis zur Vorlesung {-}

Einige Kapitel beziehen sich unmittelbar auf bestimmte Vorlesungstermine,
andere sind als optionale Zusatzinformation gedacht.
Gerade Menschen ohne Vorkenntnisse in R sollten unbedingt die ersten Kapitel
vor dem vierten Vorlesungsterm lesen und verstehen. Bei Fragen können Sie sich
gerne an Claudius Gräbner wenden.

Die folgende Tabelle gibt einen Überblick über die Kapitel und die dazugehörigen
Vorlesungstermine:

Kapitel              | Zentrale Inhalte            | Verwandter Vorlesungstermin |
|:------------------:|:----------------------------|:---------------------------:|
| 1: Vorbemerkungen | Gründe für R; Besonderheiten von R | Vorbereitung |
| 2: Vorbereitung | Installation und Einrichtung von R und R Studio, Projektstrukturierung | Vorbereitung |
| 3: Erste Schritte in R | Grundlegende Funktionen von R; Objekte in R; Pakete | Vorbereitung |
| 4: Ökonometrie I | Implementierung von uni- und multivariaten linearen Regressionsmodellen | T4 am 06.11.19 |
| 5: Datenaquise und -management | Einlesen und Schreiben sowie Manipulation von Datensätzen; deskriptive Statistik | T8 am 11.12.19 |
| 6: Visualisierung | Erstellen von Grafiken | T8 am 11.12.19 |
| 7: Ökonometrie II | Mehr Konzepte der Ökonometrie | T9-10 am 8.&15.1.20|
| 8: Ausblick | Ausblick zu weiteren Anwendungsmöglichkeiten | Optional |
| A: Einführung in Markdown | Wissenschaftliche Texte in R Markdown schreiben |Optional; relevant für Aufgabenblätter|
| B: Wiederholung: Wahrscheinlichkeitstheorie  | Wiederholung grundlegender Konzepte der Wahrscheinlichkeitstheorie und ihrer Implementierung in R | Optional; wird für die quantitativen VL vorausgesetzt |
| C: Wiederholung: Deskriptive Statistik  | Wiederholung grundlegender Konzepte der deskriptiven Statistik und ihrer Implementierung in R | Optional; wird für die quantitativen VL vorausgesetzt |
| C: Wiederholung: Drei grundlegende Verfahren der schließenden Statistik  | Wiederholung von Parameterschätzung, Hypothesentests und Konfidenzintervalle und deren Implementierung in R| Optional; wird für die quantitativen VL vorausgesetzt |
| E: Einführung in Git und Github | Verwendung von Git und Github | Optional |

Das Skript ist *work in progress* und jegliches Feedback ist sehr willkommen.
Dafür wird im Moodle ein extra Bereich eingerichtet.


## Änderungshistorie während des Semesters {-}

*An dieser Stelle werden alle wichtigen Updates des Skripts gesammelt.*
*Die Versionsnummer hat folgende Struktur: `major`.`minor`.`patch`*
*Neue Kapitel erhöhen die `minor` Stelle, kleinere, aber signifikante*
*Korrekturen werden als Patches gekennzeichnet.*

Datum    | Version | Wichtigste Änderungen         |
:--------+:--------+:------------------------------|
19.10.19 | 0.1.0    | Erste Version veröffentlicht |
03.11.19 | 0.2.0    | Markdown-Anhang hinzugefügt  |
04.11.19 | 0.3.0    | Anhänge zur Wiederholung grundlegender Statistik hinzugefügt  |
06.11.19 | 0.4.0    | Kapitel zu linearen Modellen hinzugefügt  |

## Lizenz {-}


\begin{center}\includegraphics[width=0.2\linewidth]{figures/license} \end{center}

Das gesamte Skript ist unter der 
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/)
lizensiert.
