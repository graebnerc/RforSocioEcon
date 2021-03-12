--- 
title: "R für die sozio-ökonomische Forschung"
subtitle: "Version 0.9.5"
author: "[Dr. Claudius Gräbner](http://claudius-graebner.com/)"
date: "2021-03-12" 
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: graebnerc/RforSocioEcon
description: "Einführung in R für die sozioökonomische Forschung; Version 0.9.5"
lang: de
---

# Willkommen {-}

Das folgende Skript ist als eine erste Einführung in die Programmiersprache
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
Bis auf wenige Ausnahmen sind die beiden Varianten äquivalent. 
Allerdings gibt es einige wenige Tabellen und Querverweise, die sich in HTML
nicht richtig darstellen lassen. Diese werden nur mit '??' im HTML dargestellt,
sind aber in der PDF-Variante problemlos sichtbar.
Sie können die PDF auf der 
Homepage des Skripts 
([https://graebnerc.github.io/RforSocioEcon/](https://graebnerc.github.io/RforSocioEcon/)) 
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

Darüber hinaus möchte ich mich bei allen Studierenden für Ihre Rückmeldungen
bedanken. Dank deren Feedback konnten zahlreiche kleinere und größere 
Ungereimtheiten eliminiert werden. Ohne Anspruch auf Vollständigkeit möchte
ich mich bei 
Jonas Frederik Katemann, Marie Syska und Marleen Twelsiek
ganz herzlich bedanken.

## Lizenz {-}


\begin{center}\includegraphics[width=0.2\linewidth]{/Volumes/develop/packages/RforSocioEcon/figures/index/license} \end{center}

Das gesamte Skript ist unter der 
[Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/)
lizensiert.

## Änderungshistorie {-}

*An dieser Stelle werden alle wichtigen Updates des Skripts gesammelt.*
*Die Versionsnummer hat folgende Struktur: `major`.`minor`.`patch`*.

Datum    | Version | Wichtigste Änderungen         |
:--------+:--------+:------------------------------|
19.10.20 | 0.9.0    | Erste Version für das Wintersemester 2020/21 |
06.11.20 | 0.9.1    | Kapitel zur Regressionsanalyse ergänzt |
06.12.20 | 0.9.2    | Korrektur Typos; Ergänzung Kapital zur fortgeschrittenen Regression; kleine Ergänzungen Datenkapitel, inkl. `one_of()` zu `any_of()` |
05.03.21 | 0.9.3    | Korrektur Typo: Kap 7, OLS in Matrixform ($\beta_0$ vergessen) |
10.03.21 | 0.9.4    | Kleinere Korrekturen; Abbildungen werden zwischengespeichert |

## Colophon {-}

Das Skript wurde mit 
[bookdown](https://bookdown.org/) [@R-bookdown] und 
[RStudio](https://www.rstudio.com/ide/)
unter Vervendung von [renv](https://rstudio.github.io/renv/index.html) [@renv]
verfasst.
Der gesamte Code ist über [GitHub](https://github.com/graebnerc/RforSocioEcon) 
verfügbar.
Die aktuelleste Version des Skripts wurde unter  
R version 4.0.3 (2020-10-10) erstellt und verwendet die folgenden Pakete:


|Package          |Version     |Source     |Repository           |
|:----------------|:-----------|:----------|:--------------------|
|AER              |1.2-9       |Repository |CRAN                 |
|BH               |1.72.0-3    |Repository |CRAN                 |
|DBI              |1.1.0       |Repository |CRAN                 |
|Formula          |1.2-3       |Repository |CRAN                 |
|MASS             |7.3-51.6    |Repository |CRAN                 |
|Matrix           |1.2-18      |Repository |CRAN                 |
|MatrixModels     |0.4-1       |Repository |CRAN                 |
|R.methodsS3      |1.8.1       |Repository |CRAN                 |
|R.oo             |1.24.0      |Repository |CRAN                 |
|R.utils          |2.10.1      |Repository |CRAN                 |
|R6               |2.4.1       |Repository |CRAN                 |
|RColorBrewer     |1.1-2       |Repository |CRAN                 |
|RJSONIO          |1.3-1.4     |Repository |CRAN                 |
|Rcpp             |1.0.5       |Repository |CRAN                 |
|RcppArmadillo    |0.9.900.3.0 |Repository |CRAN                 |
|RcppEigen        |0.3.3.7.0   |Repository |CRAN                 |
|Rdpack           |1.0.0       |Repository |CRAN                 |
|SparseM          |1.78        |Repository |CRAN                 |
|WDI              |2.7.1       |Repository |CRAN                 |
|abind            |1.4-5       |Repository |CRAN                 |
|askpass          |1.1         |Repository |CRAN                 |
|assertthat       |0.2.1       |Repository |CRAN                 |
|backports        |1.1.9       |Repository |CRAN                 |
|base64enc        |0.1-3       |Repository |CRAN                 |
|bdsmatrix        |1.3-4       |Repository |CRAN                 |
|bibtex           |0.4.2.2     |Repository |CRAN                 |
|bit              |4.0.4       |Repository |CRAN                 |
|bit64            |4.0.5       |Repository |CRAN                 |
|blob             |1.2.1       |Repository |CRAN                 |
|bookdown         |0.21        |Repository |CRAN                 |
|boot             |1.3-25      |Repository |CRAN                 |
|broom            |0.7.0       |Repository |CRAN                 |
|callr            |3.4.4       |Repository |CRAN                 |
|car              |3.0-9       |Repository |CRAN                 |
|carData          |3.0-4       |Repository |CRAN                 |
|cellranger       |1.1.0       |Repository |CRAN                 |
|cli              |2.0.2       |Repository |CRAN                 |
|clipr            |0.7.0       |Repository |CRAN                 |
|codetools        |0.2-16      |Repository |CRAN                 |
|colorspace       |1.4-1       |Repository |CRAN                 |
|commonmark       |1.7         |Repository |CRAN                 |
|conquer          |1.0.2       |Repository |CRAN                 |
|corrplot         |0.84        |Repository |CRAN                 |
|countrycode      |1.2.0       |Repository |CRAN                 |
|cowplot          |1.0.0       |Repository |CRAN                 |
|cpp11            |0.2.1       |Repository |CRAN                 |
|crayon           |1.3.4       |Repository |CRAN                 |
|crosstalk        |1.1.0.1     |Repository |CRAN                 |
|curl             |4.3         |Repository |CRAN                 |
|data.table       |1.13.0      |Repository |CRAN                 |
|dbplyr           |1.4.4       |Repository |CRAN                 |
|desc             |1.2.0       |Repository |CRAN                 |
|digest           |0.6.25      |Repository |CRAN                 |
|dplyr            |1.0.2       |Repository |CRAN                 |
|ellipsis         |0.3.1       |Repository |CRAN                 |
|evaluate         |0.14        |Repository |CRAN                 |
|fansi            |0.4.1       |Repository |CRAN                 |
|farver           |2.0.3       |Repository |CRAN                 |
|fastmap          |1.0.1       |Repository |CRAN                 |
|fitdistrplus     |1.1-1       |Repository |CRAN                 |
|forcats          |0.5.0       |Repository |CRAN                 |
|foreign          |0.8-80      |Repository |CRAN                 |
|fs               |1.5.0       |Repository |CRAN                 |
|gapminder        |0.3.0       |Repository |CRAN                 |
|gbRd             |0.4-11      |Repository |CRAN                 |
|generics         |0.0.2       |Repository |CRAN                 |
|ggplot2          |3.3.2       |Repository |CRAN                 |
|ggpubr           |0.4.0       |Repository |CRAN                 |
|ggrepel          |0.8.2       |Repository |CRAN                 |
|ggsci            |2.9         |Repository |CRAN                 |
|ggsignif         |0.6.0       |Repository |CRAN                 |
|glue             |1.4.2       |Repository |CRAN                 |
|gridExtra        |2.3         |Repository |CRAN                 |
|gtable           |0.3.0       |Repository |CRAN                 |
|haven            |2.3.1       |Repository |CRAN                 |
|here             |0.1         |Repository |CRAN                 |
|highr            |0.8         |Repository |CRAN                 |
|hms              |0.5.3       |Repository |CRAN                 |
|htmltools        |0.5.0       |Repository |CRAN                 |
|htmlwidgets      |1.5.1       |Repository |CRAN                 |
|httpuv           |1.5.4       |Repository |CRAN                 |
|httr             |1.4.2       |Repository |CRAN                 |
|icaeDesign       |0.1.3       |GitHub     |graebnerc/icaeDesign |
|ineq             |0.2-13      |Repository |CRAN                 |
|isoband          |0.2.2       |Repository |CRAN                 |
|jsonlite         |1.7.1       |Repository |CRAN                 |
|knitr            |1.31        |Repository |CRAN                 |
|labeling         |0.3         |Repository |CRAN                 |
|later            |1.1.0.1     |Repository |CRAN                 |
|latex2exp        |0.4.0       |Repository |CRAN                 |
|lattice          |0.20-41     |Repository |CRAN                 |
|lazyeval         |0.2.2       |Repository |CRAN                 |
|lifecycle        |0.2.0       |Repository |CRAN                 |
|lme4             |1.1-23      |Repository |CRAN                 |
|lmtest           |0.9-37      |Repository |CRAN                 |
|lubridate        |1.7.9       |Repository |CRAN                 |
|magrittr         |1.5         |Repository |CRAN                 |
|manipulateWidget |0.10.1      |Repository |CRAN                 |
|maptools         |1.0-2       |Repository |CRAN                 |
|markdown         |1.1         |Repository |CRAN                 |
|matlib           |0.9.3       |Repository |CRAN                 |
|matrixStats      |0.56.0      |Repository |CRAN                 |
|maxLik           |1.4-4       |Repository |CRAN                 |
|mgcv             |1.8-31      |Repository |CRAN                 |
|mime             |0.9         |Repository |CRAN                 |
|miniUI           |0.1.1.1     |Repository |CRAN                 |
|minqa            |1.2.4       |Repository |CRAN                 |
|miscTools        |0.6-26      |Repository |CRAN                 |
|modelr           |0.1.8       |Repository |CRAN                 |
|moments          |0.14        |Repository |CRAN                 |
|munsell          |0.5.0       |Repository |CRAN                 |
|nlme             |3.1-148     |Repository |CRAN                 |
|nloptr           |1.2.2.2     |Repository |CRAN                 |
|nnet             |7.3-14      |Repository |CRAN                 |
|numDeriv         |2016.8-1.1  |Repository |CRAN                 |
|openssl          |1.4.2       |Repository |CRAN                 |
|openxlsx         |4.1.5       |Repository |CRAN                 |
|optimx           |2020-4.2    |Repository |CRAN                 |
|pbkrtest         |0.4-8.6     |Repository |CRAN                 |
|pillar           |1.4.6       |Repository |CRAN                 |
|pkgbuild         |1.1.0       |Repository |CRAN                 |
|pkgconfig        |2.0.3       |Repository |CRAN                 |
|pkgload          |1.1.0       |Repository |CRAN                 |
|plm              |2.2-4       |Repository |CRAN                 |
|polynom          |1.4-0       |Repository |CRAN                 |
|praise           |1.0.0       |Repository |CRAN                 |
|prettyunits      |1.1.1       |Repository |CRAN                 |
|processx         |3.4.4       |Repository |CRAN                 |
|progress         |1.2.2       |Repository |CRAN                 |
|promises         |1.1.1       |Repository |CRAN                 |
|ps               |1.3.4       |Repository |CRAN                 |
|purrr            |0.3.4       |Repository |CRAN                 |
|quantreg         |5.61        |Repository |CRAN                 |
|readr            |1.3.1       |Repository |CRAN                 |
|readxl           |1.3.1       |Repository |CRAN                 |
|rematch          |1.0.1       |Repository |CRAN                 |
|renv             |0.12.0      |Repository |CRAN                 |
|reprex           |0.3.0       |Repository |CRAN                 |
|rgl              |0.100.54    |Repository |CRAN                 |
|rio              |0.5.16      |Repository |CRAN                 |
|rjson            |0.2.20      |Repository |CRAN                 |
|rlang            |0.4.7       |Repository |CRAN                 |
|rmarkdown        |2.7         |Repository |CRAN                 |
|rmutil           |1.1.5       |Repository |CRAN                 |
|rprojroot        |1.3-2       |Repository |CRAN                 |
|rstatix          |0.6.0       |Repository |CRAN                 |
|rstudioapi       |0.11        |Repository |CRAN                 |
|rvest            |0.3.6       |Repository |CRAN                 |
|sandwich         |2.5-1       |Repository |CRAN                 |
|scales           |1.1.1       |Repository |CRAN                 |
|selectr          |0.4-2       |Repository |CRAN                 |
|shiny            |1.5.0       |Repository |CRAN                 |
|sourcetools      |0.1.7       |Repository |CRAN                 |
|sp               |1.4-2       |Repository |CRAN                 |
|statmod          |1.4.34      |Repository |CRAN                 |
|stringi          |1.4.6       |Repository |CRAN                 |
|stringr          |1.4.0       |Repository |CRAN                 |
|survival         |3.1-12      |Repository |CRAN                 |
|sys              |3.4         |Repository |CRAN                 |
|testthat         |2.3.2       |Repository |CRAN                 |
|tibble           |3.0.3       |Repository |CRAN                 |
|tidyr            |1.1.2       |Repository |CRAN                 |
|tidyselect       |1.1.0       |Repository |CRAN                 |
|tidyverse        |1.3.0       |Repository |CRAN                 |
|tinytex          |0.25        |Repository |CRAN                 |
|tufte            |0.6         |Repository |CRAN                 |
|utf8             |1.1.4       |Repository |CRAN                 |
|vctrs            |0.3.4       |Repository |CRAN                 |
|viridis          |0.5.1       |Repository |CRAN                 |
|viridisLite      |0.3.0       |Repository |CRAN                 |
|webshot          |0.5.2       |Repository |CRAN                 |
|whisker          |0.4         |Repository |CRAN                 |
|withr            |2.2.0       |Repository |CRAN                 |
|xfun             |0.21        |Repository |CRAN                 |
|xml2             |1.3.2       |Repository |CRAN                 |
|xtable           |1.8-4       |Repository |CRAN                 |
|yaml             |2.2.1       |Repository |CRAN                 |
|zip              |2.1.1       |Repository |CRAN                 |
|zoo              |1.8-8       |Repository |CRAN                 |

## Referenzen {-}
