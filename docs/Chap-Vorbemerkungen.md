# Vorbemerkungen {#precons}



## Warum R?

Im folgenden gebe ich einen kurzen Überblick über die Gründe, die uns bewegt
haben den Methodenkurs auf R aufzubauen. Die Liste ist sicherlich nicht 
abschließend (siehe auch @adv-r).

* Die R Community gilt als besonders freundlich und hilfsbereit. Gerade weil
viele Menschen, die R benutzen praktizierende Datenwissenschaftler*innen sind
werden praktische Probleme breit und konstruktiv in den einschlägigen Foren 
diskutiert und es ist in der Regel leicht Lösungen für Probleme zu finde, sobald 
man selbst ein bestimmtes Level an Programmierkenntnissen erlangt hat.
    * Auch gibt es großartige Online Foren und Newsletter, die es einem einfacher
    und unterhaltsamer machen, seine R Kenntnisse stetig zu verbessern und 
    zusätzlich viele neue Dinge zu lernen. Besonders empfehlenswert sind m.E.
    [R-Bloggers](https://www.r-bloggers.com/), eine Sammlung von Blog Artikeln, die R verwenden und neben 
    Inspirationen was man mit R machen kann häufig inhaltlich sehr interessant sind,
    [rweekly](https://rweekly.org/), ein Newsletter, der ebenfalls interessante Infos zu R enthält sowie 
    die [R-Ladies Community](https://rladies.org/), die sich besonders das Empowerment von Minderheiten in
    der Programmierwelt zur Aufgabe gemacht hat.
    * Selbstverständlich werden zahlreiche R Probleme auch auf [StackOverflow](https://stackoverflow.com/tags/r/info) 
    disktuiert, und häufig ist das der Ort, wo man Antworten auf seine Fragen findet.
    Allerdings ist es gerade am Anfang u.U. schwierig die häufig sehr fortgeschrittenen
    Lösungen zu verstehen.

* R ist eine offene und freie Programmiersprache, die auf allen bekannten 
  Betriebssystemen läuft. 
  Im Gegensatz zu Programmen wie SPSS und STATA, für die Universitäten jedes 
  Semester viele Tausend Euro bezahlen müssen und die dann umständlich über 
  Serverlizenzen abgerufen werden müssen.
  Auch für Studierende sind die Preise alles andere als gering. 
  R dagegen ist frei und inklusiv, und auch Menschen mit weniger Geld können 
  sie benutzen. 
  Gerade vor dem Hintergrund der Rolle von Wissenschaft in einer demokratischen
  und freien Gesellschaft und in der Kooperation mit Wissenschaftler*innen aus 
  ärmeren Ländern ist dies extrem wichtig.

* R verfügt über ein hervorragendes Package System. Das bedeutet, dass es recht
einfach ist, neue Pakete zu schreiben und damit die Funktionalitäten von R zu 
erweitern. In der Kombination mit der Open Source Charakter von R bedeutet das,
dass R nie wirklich **out of date** ist, und dass neuere Entwicklungen der 
Statistik und Datenwissenschaften, und immer mehr auch in der VWL, recht zügig
in R implementiert werden. Insbesondere wenn es um statistische Analysen,
**machine learning**, Visualisierungen oder Datenmanagement und -manipulation geht:
für alles gibt es Pakete in R und irgendjemand hat ihr Problem mit hoher 
Wahrscheinlichkeit schon einmal gelöst und Sie können davon profitieren.
    * R ist - zusammen mit Python - mittlerweile die *lingua franca* im 
    Bereich Statistik und Machine Learning.

* Integration mit Git, Markdown, Latex und anderen Tools erlaubt einen integrierten 
Workflow, in dem Sie im Optimalfall euer Paper in der gleichen Umgebung schreiben
wie den Code für eure statistische Analyse. Diesen Vorteil werden Sie bereits
bei der Bearbeitung der Aufgabenzettel genießen können, da diese in teilweise in R Markdown
zu lösen und abzugeben sind. Das bedeutet, dass Coding und Schreiben der Antworten
im gleichen Dokument vorgenommen werden können. Auch dieses Skript wurde 
vollständig in R Markdown geschrieben.

* R erlaubt sowohl objektorientierte als auch funktionale Programmierung.

* Für besondere Aufgaben ist es recht einfach R mit high-performance Sprachen
wie C, Fortran oder C++ zu integrieren.

## Besonderheiten von R

R ist keine typische Programmiersprache in dem Sinne, dass sie vor allem von
Statistiker*innen benutzt und weiterentwickelt wird.
Dies hat den Vorteil, dass die Funktionen oft sehr genau auf praktische 
Herausforderungen ausgerichtet sind und es für alle typischen statistischen
Probleme Lösungen in R gibt.
Gleichzeitig hat dies auch dazu geführt, dass R einige unerwünschte 
Eigenschaften aufweist, da die Menschen, die Module für R programmieren keine
'genuinen' Programmierer*innen sind.

Im folgenden möchte ich einige Besonderheiten von R aufführen, damit Sie im 
Laufe Ihrer R-Karriere nicht negativ von diesen Besonderheiten überrascht 
werden.
Während es sich für Programmier-Neulinge empfiehlt die Liste zu einem späteren
Zeitpunkt zu inspizieren sollten Menschen mit Erfahrungen in anderen Sprachen
gleich einen Blick darauf werfen.

* R wird dezentral über viele benutzergeschriebene Pakete ('libraries' oder
'packages') konstant weiterentwickelt. Das führt wie oben erwähnt dazu, dass
R quasi immer auf dem neuesten Stand der statistischen Forschung ist.
Gleichzeitig kann die schiere Masse von Paketen auch verwirrend sein, 
insbesondere weil es für die gleiche Aufgabe häufig deutlich mehr als ein Paket 
gibt. Das führt zwar auch zu einer positiven Konkurrenz und jede*r kann sich 
ihren Geschmäckern gemäß für das eine oder andere Paket entscheiden, es bringt
aber auch mögliche Inkonsistenzen und schwerer verständlichen Code mit sich.

* Im Gegensatz zu Sprachen wie Python, die trotz einer enormen Anzahl von Paketen
eine interne Konsistenz nicht verloren haben gibt es in R verschiedene 'Dialekte',
die teilweise inkonsistent sind und gerade für Anfägner durchaus verwirrend sein
können. Besonders die Unterscheidungen des `tidyverse`, einer Gruppe von Paketen,
die von der R Studio Company sehr stark gepusht werden und vor allem zur Verarbeitung
von Datensätzen gedacht sind, implementieren viele Routinen des 'klassischen R'
('base R') in einer neuen Art und Weise. Das Ziel ist, die Arbeit mit Datensätzen
einfacher und leichter verständlich zu machen, allerdings wird die recht aggressive
'Vermarktung' und die teilweise inferiore Performance des Ansatzes auch 
[kritisiert](https://github.com/matloff/TidyverseSkeptic).^[
Zum einen bin ich ein großer Fan von vielen tidyverse
Paketen, gleichzeitig ist der Fokus von R Studio auf diese Pakete sehr gefährlich.
Ich bin aber einer anderen Meinung was die Einsteigerfreundlichkeit vom `tidyverse` 
andgeht: meiner Meinung nach machen diese Pakete die Arbeit mit Datensätzen sehr 
einfach, und für kleine Datensätze (<500MB) benutze ich das `tidyverse` auch in
meiner eigenen Forschung. 
Aufgrund der Einsteigerfreundlichkeit werden wir hier für die Arbeit mit Datensätzen
trotz allem mit dem `tidyverse` arbeiten. Ich weise jedoch auf die kritische
Diskussion im entsprechenden Kapitel des Skripts hin.]

* Da viele der Menschen, die R Pakete herstellen keine Programmierer sind, sind
viele Pakete von einem Programmierstandpunkt aus nicht sonderlich effizient oder
elegant geschrieben. Gleichzeitig gibt es aber auch viele Ausnahmen zu dieser Regel 
und viele Pakete werden über die Zeit hinweg signifikant verbessert.

* R an sich ist nicht die schnellste Programmiersprache, insbesondere wenn man 
seinen Code nicht entsprechend geschrieben hat. Auch bedarf eine R Session in
der Regel recht viel Speicher. Hier sind selbst andere High-Level Sprachen wie
Julia oder Python deutlich performanter, auch wenn Pakete wie 
[data.table](https://rdatatable.gitlab.io/data.table/) diesen Nachteil häufig 
abschwächen. Zudem ist er für die meisten Probleme, die Sozioökonom*innen in
ihrer Forschungspraxis bearbeiten, irrelevant.

Alles in allem ist R jedoch eine hervorragende Wahl wenn es um quantitative
sozialwissenschaftliche Forschung geht. Auch in der Industrie ist R extrem 
beliebt und wird im Bereich der **Data Science** nur noch von Python ernsthaft
in den Schatten gestellt. Allerdings verwenden die meisten Menschen - ich inklusive -
beide Sprachen, da sie unterschiedliche Vor- und Nachteile haben.
Entsprechend ist jede Minute, die Sie in das Lernen von R investieren eine 
exzellente Investition, egal wo Sie in Ihrem späteren Berufsleben einmal landen 
werden.

Das wichtigste am Programmieren ist in jedem Fall Spaß und die Bereitschaft zu 
und die Freude an der Zusammenarbeit mit anderen. Denn das hat R mit anderen 
offenen Sprachen wie Python gemeinsam: Programmieren und das Lösen von 
statistischen Fragestellungen sollte immer ein kollaboratives Gemeinschaftsprojekt 
sein!