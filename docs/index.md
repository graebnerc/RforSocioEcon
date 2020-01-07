--- 
title: "R für die sozio-ökonomische Forschung"
subtitle: "Version 0.7.0"
author: "[Dr. Claudius Gräbner](http://claudius-graebner.com/)"
date: "2020-01-07" 
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: graebnerc/RforSocioEcon
description: "R Skript in der Version 0.7.0"
---

# Willkommen {-}


\begin{center}\includegraphics[width=0.75\linewidth]{figures/title_page} \end{center}

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
| 2: Einrichtung | Installation und Einrichtung von R und R Studio, Projektstrukturierung | Vorbereitung |
| 3: Erste Schritte in R | Grundlegende Funktionen von R; Objekte in R; Pakete | Vorbereitung |
| 4: Lineare statistische Modelle in R | Implementierung von uni- und multivariaten linearen Regressionsmodellen | T4 am 06.11.19 |
| 5: Datenkunde und -aufbereitung | Einlesen und Schreiben sowie Aufbereitung von Datensätzen | T7 am 27.11.19 |
| 6: Visualisierung | Erstellen von Grafiken | T7 am 27.11.19 |
| 7: Formalia | Grundlegende formale Konzepte der Sozioökonomie. | T8 am 11.12.19 |
| 8: Fortgeschrittene Ökonometrie | Weitere Konzepte der Ökonometrie | T9-10 am 8.&15.1.20|
| 9: Ausblick | Ausblick zu weiteren Anwendungsmöglichkeiten | Optional |
| A: Einführung in Markdown | Wissenschaftliche Texte in R Markdown schreiben |Optional; relevant für Aufgabenblätter|
| B: Wiederholung: Wahrscheinlichkeitstheorie  | Wiederholung grundlegender Konzepte der Wahrscheinlichkeitstheorie und ihrer Implementierung in R | Optional; wird für die quantitativen VL vorausgesetzt |
| C: Wiederholung: Deskriptive Statistik  | Wiederholung grundlegender Konzepte der deskriptiven Statistik und ihrer Implementierung in R | Optional; wird für die quantitativen VL vorausgesetzt |
| D: Wiederholung: Drei grundlegende Verfahren der schließenden Statistik  | Wiederholung von Parameterschätzung, Hypothesentests und Konfidenzintervalle und deren Implementierung in R| Optional; wird für die quantitativen VL vorausgesetzt |
| E: Einführung in Git und Github | Verwendung von Git und Github | Optional |

Das Skript ist *work in progress* und jegliches Feedback ist sehr willkommen.
Dafür wird im Moodle ein extra Bereich eingerichtet.
Selbstverständlich können Sie Feedback auch den 
[Issue-Tracker auf Github](https://github.com/graebnerc/RforSocioEcon/issues) 
verwenden. Dort ist auch der Quellcode des Skripts verfügbar.

## Danksagung {-}

Ich möchte mich bei Jakob Kapeller und Anika Radkowitsch für das regelmäßige 
Feedback und die guten Hinweise bedanken. Am *work-in-progress*-Charakter
des Skripts haben sie natürlich keine Mitschuld.

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
18.11.19 | 0.5.0    | Kapitel zur Datenaufbereitung und Visualisierung hinzugefügt; kleinere Korrekturen im Kapitel zu lin. Modellen  |
20.11.19 | 0.5.1    | Korrektur von kleineren Rechtschreib/Grammatikfehlern; Fix für Problem mit html Version auf HP |
03.12.19 | 0.6.0    | Kapitel zu formalen Konzepten hinzugefügt; kleinere Korrekturen |
10.12.19 | 0.6.1    | Herleitung OLS hinzugefügt; bessere Beispiele bei Formalie; Konsolidierung Notation Kap. 4 und 7 |

## Lizenz {-}


\begin{center}\includegraphics[width=0.2\linewidth]{figures/license} \end{center}

Das gesamte Skript ist unter der 
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/)
lizensiert.
