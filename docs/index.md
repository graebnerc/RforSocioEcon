--- 
title: "R für die sozio-ökonomische Forschung"
subtitle: "Version 1.0.0"
author: "[Dr. Claudius Gräbner](http://claudius-graebner.com/)"
date: "2020-09-08" 
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: graebnerc/RforSocioEcon
description: "Einführung in R für die sozioökonomische Forschung; Version 1.0.0"
---

# Willkommen {-}

Das folgdene Skript ist als eine erste Einführung in die Programmiersprache
R [@R-Team] und ihrer Anwendung im Bereich der quantitativen sozioökonomischen
Forschung gedacht. 
Ursprünglich war es als Begleitung für die Lehrveranstaltung 
"Wissenschaftstheorie und Einführung in die Methoden der Sozioökonomie"
im Master "Sozioökonomie" an der Universität Duisburg-Essen konzipiert, es 
soll jedoch zu einer eigenständigen Einführung in R weiterentwickelt werden.
Dabei richtet es sich zunächst an Menschen mit keinen oder geringen 
Vorkenntnissen in R.
Einzelne Kapitel, insbesondere die zur Datenaufbereitung und -visualisierung
könnten aber auch für fortgeschrittene Studierende interessant sein.

Insgesamt ist das Projekt noch in der Anfangsphase und somit unbedingt auf 
das Feedback von Nutzer\*innen angewiesen. Ich bin Ihnen daher für jegliches
Feedback sehr dankbar. 
Am besten Sie verwenden für Ihr Feedback den 
[Issue-Tracker auf Github](https://github.com/graebnerc/RforSocioEcon/issues).
Dort ist auch der Quellcode des Skripts verfügbar.
Sie können mir das Feedback aber auch gerne per Email zukommen lassen.
Verwenden Sie dafür im Zweifel das 
[Kontaktformular](https://claudius-graebner.com/contact-1.html)
auf meiner Homepage. 
Vielen Dank!

Ein Hinweis zu den unterschiedlichen Versionen: 
das Skript ist aktuell in einer HTML und einer PDF-Variante verfügbar.
Ich empfehle Ihnen die PDF-Variante zu verwenden, das diese Version die final
lektorierte Version ist und bestimmte Formatierungen für die HMTL-Version (noch)
nicht funktionieren. Entsprechend ist diese Variante leicht unvollständig.
Sie können die PDF auf der 
Homepage des Skripts [https://graebnerc.github.io/RforSocioEcon/](https://graebnerc.github.io/RforSocioEcon/) 
herunterladen indem Sie auf das
PDF-Icon oben links (neben dem `i`) klicken. Alternativ können Sie auch 
[diesem Link](https://graebnerc.github.io/RforSocioEcon/R-SocioEcon-dt.pdf)
folgen. 
Aktualisieren Sie vor dem Download aber Ihr Browserfenster um sicherzugehen, 
dass Sie die aktuellste Version herunterladen.

## Danksagung {-}

Ich möchte mich bei Jakob Kapeller und Anika Radkowitsch für das regelmäßige 
Feedback und die guten Hinweise bedanken. 
Bei Birte Strunk möchte ich mich für das hervorragende Lektorat und das 
Beisteuern vieler guter Ideen bedanken. 
Am *work-in-progress*-Charakter des Skripts haben alle natürlich keine Mitschuld.

## Lizenz {-}


\begin{center}\includegraphics[width=0.2\linewidth]{figures/license} \end{center}

Das gesamte Skript ist unter der 
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/)
lizensiert.

## Änderungshistorie {-}

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
06.01.20 | 0.7.0    | Kapitel zur fortgeschrittenen Themen der Regression und nichtlinearen Schätzern hinzugefügt |
12.01.20 | 0.7.1    | Ergänzung Beweise im Kapitel zu fortgeschrittenen Themen der Regression |
29.01.20 | 0.7.2    | Korrektur der Tabelle in "Wahl der funktionalen Form" in Kapitel 8 im Bezug auf log-log Modelle |
