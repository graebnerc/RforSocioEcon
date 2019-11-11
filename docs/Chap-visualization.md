# Visualisierung von Daten {#vis}





```r
library(here)
library(tidyverse)
library(icaeDesign)
```


```r
library(devtools)
devtools::install_github("graebnerc/icaeDesign")
```


* Noch die Arbeit mit Arbeitsverzeichnissen



## Grundlagen von `ggplot2`

### `ggplot2` vs. `base plot`

Wie so oft bietet R verschiedene Ansätze zur Datenvisualisierung. 
Die beiden prominentesten sind dabei die in der Basisversion von R integrierten
Visualisierungsfunktionen, häufig als `base` bezeichnet, und die im Paket
[ggplot2]() bereitgestellten Funktionen.

Die Frage 'Welcher Ansatz ist nun besser?' ist nicht leicht zu beantworten, 
insbesondere da beiden Ansätzen eine sehr unterschiedliche Design-Philosophie 
zugrunde liegt: 
`base` funktioniert dabei ein wenig wie ein Stift: 
sie haben ein leeres Blatt, das sie mit dem Aufruf bestimmter `plot`-Funktionen
beschreiben. 
Hierbei wird kein besonderes R-Objekt erstellt, in dem die Grafik als Obkekt 
gespeichert wird - vielmehr speichern Sie am Ende ihr 'vollgemaltes Blatt'
entweder als Bild ab, oder Sie verwerfen es und beschreiben ein neues 'Blatt'.

In `ggplot2` werden die Grafiken dagegen 'scheibchenweise' Stück für Stück 
nach einer geschichteten [Grammar of Graphics](#grammar) in einer Art 
Liste zusammengesetzt.
Dabei findet aber kein 'Malprozess' statt:die finale Grafik erst dann erstellt 
wenn auf die resultierende Liste eine `print`-Funktion angewandt wird.

Am Ende des Tages werden Sie wenige Dinge finden, die sie nur mit `base` oder
nur mit `ggplot2` erreichen können. 
Und wahrscheinlich gilt für die meisten, dass sie einfach bei dem Ansatz hängen
bleiben, der Ihnen am Anfang intuitiv am besten gefallen hat.
Ich habe in der [weiterführenden Literatur](#vis-links) einige Diskussionsbeiträge zum
Theme `base` vs. `ggplot2` gesammelt und fasse mich hier daher kurz:
in dieser Einführung verwenden wir `ggplot2`. 
Ich finde, dass die resultierenden Grafiken einen Tick schöner, die Syntax
ein wenig einfacher und die Dokumentation im Internet ein wenig besser ist.
Vor allem finde ich den Code leichter lesbar und die den von @wickhamggplot
vorgeschlagenen *grammar of graphics* Ansatz einfach extrem intuitiv.

Wenn Sie dagegen lieber mit `base` arbeiten wollen - kein Problem. Es finden
sich im Internet gerade auf Englisch viele exzellente Einführungen. 
Und im Endeffekt ist die einzige relevante Frage:
haben Sie auf eine für Sie möglichst unterhaltsame Art und Weise einen guten 
Graph produziert?
Welches Paket Sie dafür verwendet haben, interessiert am Ende des Tages niemanden...

### *Optional:* Kurze Beschreibung von Wickham's *grammar of graphics* {#grammar}

Die Funktion von `ggplot2` ist leichter nachzuvollziehen wenn man weiß wodurch
das Paket inspiriert wurde.
In diesem Fall war es das Konzept der *Grammar of Graphics* [@GrammarGraphics], 
beziehungsweise die Interpretation des Konzepts von @wickhamggplot.
Da die zugrundeliegende Theorie sehr abstrakt ist können sie diesen Abschnitt
beim ersten Lesen getrost überspringen.

Dieses Konzept startet von dem Wunsch eine 'Grammatik' für Grafiken zu entwickeln.
Eine Grammatik wird hier als eine Sammplung von Konzepten verstanden aus denen
sämtliche Grafiken hergestellt werden können.
Sie wie die Grammatik der deutschen Sprache eine Sammlung von Wörtern und Regeln
darstellt, aus denen jede Menge (mehr oder weniger sinnvolle) Aussagen hergestellt
werden können, verstehen wir unter einer Grammatik für Grafiken eine Sammplung von 
Konzepten und Regeln aus denen wir jede Menge (mehr oder weniger sinnvolle)
Grafiken herstellen können.

Im Gegensatz zu der ursprünglich von @GrammarGraphics vorgestellten Grammatik
folgt die Grammatik von @wickhamggplot einer klaren geordneten Struktur:
jeder Teil der Grammatik ist unabhängig vom Rest, und eine Grafik wird
vollends dadurch spezifiziert, dass die einzelnen Teile Stück für Stück
zusammen geführt werden.

Nach Wickham's Grammatik besteht jede statistische Grafik aus den folgenden 
Komponenten:

1. Einem **Standard-Datensatz** gemeinsam mit den Funktionen (*engl.: mappings*), 
welche Variablen aus den Daten eine so genannten **Ästhetik** (*engl.: aesthetic*) 
zuweisen.
Die so genannten *mappings* (es handelt sich dabei eigentlich um einfache Funktionen)
verlinken eine Variable in den Daten mit einer Ästhetik in der Grafik.
Beispielsweise verlinken wir die Variable 'Jahr' in den Daten mit der Ästhetik
'x-Achse', die Variable 'BIP' mit der Ästhetik 'y-Achse' und die Variable 'Land'
mit der Ästhetik 'Farbe'.

2. Ein oder mehrere **Ebenen**; jede Ebene besteht dabei aus einem geometrischem
Objekt, einer statistischen Transformation^[
Da wir nicht notwendigerweise die exakten Werte der Variable an die Ästhetik 
weitergeben wird die Möglichkeit einer *statistischen Transformation* offen
gelassen: eventuell wird nicht der Variablenwert, sondern z.B. der Logarithmus
dieses Wertes an die entsprechende Ästhetik weitergegeben. 
Natürlich kann die statistische Transformation auch weggelassen werden - in diesem
Fall sprechen wir von der Transformation `identity` - die Daten werden nicht 
verändert, sondern direkt an die Ästhetik weitergegeben.
Andere häufig verwendete Transformationen sind `boxplot` (wenn wir die Daten in
einem Boxplot zusammenfassen wollen), `bin` (wenn wir die Daten in einem diskreten
Histogramm darstellen wollen) pder `density` (wenn wir an der Wahrscheinlichkeitsdichte
der Beobachtungen interessiert sind).
], einer Positionszuweisung und, 
optionalerweise, einem von (1) abweichenden besonderen Datensatz und den 
entsprechenden *aesthetic mappings*.
Von besonderer Relevanz sind dabei die geometrischen Objekte, `geoms`, denn
sie bestimmen um was für einen Plot es sich handelt: verwenden wir als `geoms` 
Punkte bekommen wir ein Streudiagramm, bei Linien als `geoms` wird es ein Linienplot, usw.
Die `geoms` visualisieren also die Ästetiken, aber bestimmte `geoms` können natürlich
nur bestimmte Ästetiken repräsentieren: der `geom` 'Punkt' z.B. hat eine `x` und
eine `y`-Komponente, eine `Größe`, eine `Form` und eine `Farbe`.
Andere Ästhetiken machen für Punkte keinen Sinn.
Die Positionszuweisungen spielen dagegen nur eine Rolle wenn die Positionen der
`geoms` angepasst werden muss, z.B. um Überlappungen zu vermeiden. Ein typisches
Beispiel ist auch das Schachteln von Balkendiagrammen.

3. Einer **Skala** für jedes *aesthetic mapping*. Sie beschreibt die genaue Art
des Mappings zwischen Daten und Ästetiken. Entsprechend handelt es sich bei einer
Skala in diesem Sinne hier um eine **Funktion gemeinsam mit Parametern**.
Am besten kann man sich das bei einer farblichen Skala vorstellen, die bestimmte
Werte in einen Farbenraum abbildet.

4. Einem **Koordinatensystem**, das zu den Daten und Ästetiken und 
geometrischen Objekten passt. Am häufigsten wird hier sicher das
kartesischen Koordinatensystem verwendet, aber für Kuchendiagramme bietet sich
z.B. das polare Koordinatensystem an.

5. Eine optionale **Facettenspezifikation** (*engl.: facet specification*), die 
verwendet werden kann um die Daten in verschiedene Teil-Datensätze aufzusplitten.
So möchten wir wir vielleicht die Dynamik des BIP über die Zeit abbilden, aber
einen separaten Unter-Plot für jedes einzelne Land erstellen. In diesem Fall
verwenden wir eine Facettenspezifikation, die für jedes Land einen Teildatensatz
erstellt.

Wichtig dabei ist, dass alle Komponenten unabhängig von einander sind:
die Daten z.B. sind unabhängig vom Rest, weil die gleiche Grafik für
unterschiedliche Daten produziert werden kann:
"Daten machen aus einer abstrakten Grafik eine konkrete Grafik" [@wickhamggplot, p. 10]

Das besondere an der so formulierten Grammatik ist, dass man mit den Komponenten
1 - 5 so ziemlich jede statistische Grafik beschreiben kann. 
Das Paket `ggplot2` macht sich das zu Nutze: 
es formalisiert diese Regeln in R, sodass Sie mit dem entsprechenden R Code
quasi jede Grafik beschreiben können - und dann durch R erstellen lassen können.

Wie Sie später sehen werden repräsentiert die Syntax von `ggplot2` genau diese
theoretische Beschreibung von Grafiken. 
Hier greifen wir mit einem kleinen Beispiel vor:



```r
example_data <- data.frame(a=1:3, 
                           b=2:4, 
                           c=c("a", "a", "b")
                           )

ggplot(
  data = example_data, 
  mapping = aes(x=a, y=b, color=c)
  ) + 
  layer( 
    geom = "point", 
    stat = "identity", 
    position = "identity") + 
  scale_color_discrete(
    aesthetics = c("color")
    ) + 
  coord_cartesian(
    xlim = c(0, 4), 
    ylim = c(0, 5)
    ) 
```

<img src="Chap-visualization_files/figure-html/unnamed-chunk-4-1.png" width="672" />

`ggplot()` erstellt eine Liste, in der die Grafik-Spezifikationen gespeichert
werden und akzeptiert über die Argumente `data` und `mapping` die Standard-Daten
und Standard-Mappings. Es korrespondiert damit zu Punkt (1) oben.

Als nächstes wird mit `layer()` eine neue Ebene spezifiziert. 
Wie in der Theorie spezifizieren wir die Ebene über das Argument `geom` bezüglich
der auf ihr abzubildenden geometrischen Objekte (hier: Punkte), über `stat`
bezüglich der zu verwendeten statistischen Transformation (hier: keine Transformation, 
sondern die Daten identisch zu ihren Werten im Standard-Datensatz) und über
`position` bezüglich der Positionszuweisungen (auch hier: keine besonderen 
Positionszuweisungen).

Als nächstes spezifizieren wir die Skala. Für die Ästhetik 'Position' der Variablen
`a` und `b` ist keineÜbersetzung notwendig, aber für den Link zwischen den Werten 
von Variable `c` und der Ästhetik 'Farbe' müssen wir eine explizite Funktion verwenden.
Mit der Funktion `scale_color_discrete()` weisen wir also jedem Wert der 
(diskreten) Variable `c` eine Farbe zu.

Schließlich legen wir mit `coord_cartesian()` noch das zu verwendende 
Koordinatensystem fest indem wir mit den Argumenten `xlim` und `ylim` die Länge
der x- und y-Achse spezifizieren. 
Eine besondere Facettenspezifikation verwenden wir hier dagegen nicht.

Wie Sie später sehen werden, verwenden wir in `ggplot2` häufig Abkürzungen für
die in diesem Beispiel verwendeten 'Originalfunktionen'. 
So gibt es für eine Ebene mit dem `geom` 'Punkte' die Abkürzung `geom_point()`.

Wenn Sie sich genauer mit der hierachichen Grammatik, die `ggplot2` zugrundeliegt, 
kann ich Ihnen nur den Originalartikel von @wickhamggplot empfehlen.

### Elemente eines `ggplot`

Analog zu der gerade vorgestellten [Theorie](#grammar) besteht jeder`ggplot` 
aus den folgenden Komponenten:


Das macht es einfach eine Grafik sukzessive zu ändern: 
wenn Sie z.B. von einem Streudiagramm zu einem Liniendiagramm wechseln wollen
müssen Sie nur die `geoms` ändern - die restlichen Komponenten des Plots 
können identisch bleiben.

### Speichern von Plots und Ordnerstruktur

### Beispiel Workflow

## Arten von Datenvisualisierung

* hier dann die verschiedenen Arten von Plots, jeweils mit Frage, die sie
beantworten und ggplot Funktion
* Evtl. Themen

<img src="/Users/claudius/work-claudius/general/paper-projects/packages/SocioEconMethodsR/figures/chap-vis-chart-selection.jpg" width="100%" style="display: block; margin: auto;" />

### Allgemeine best practive Hinweise zu Abbildungen

* Standardspezifikationen für Themen, wie genau ein Thema spezialisiert wird ist
weiter unten erklärt; die Funktion `theme_icae()` ist äquivalent zu folgendem
Aufruf von `theme()` am Ende des ggplot-Workflows

### Zusammenfassung 

Die folgende Tabelle fasst die hier diskutierten Visualisierungsmöglichkeiten
noch einmal kurz zusammen.

| **Art** | **Anwendungsgebiet/Frage** | **Relevante Funktion** |
|---------+----------------------------+------------------------|
| Balkendiagramm | | |
| Gebietschart | | |
| Linienchart | | |
| Histogram | | |
| Streudiagramm | | |
| 3d-Arealplot | | |
| Kuchendiagramm | | |
| Puzzlechart (Complexity) | | |
| Bubble-Chart | | |


## Beispiele aus der Praxis und fortgeschrittene Themen

### Regressionsgerade

### Mehrere Plots in einer Abbildung

### Farbenmanagement

### Style Guidelines

### ggplot Themen

## Typische Fehler in der Datenvisualisierung vermeiden

Hier implementieren wir die Beispiele aus @schwabischVis

### Unglück 1: Liniengraphen

### Unglück 2: Clutter-Graphen

### Unglück 3:Der Barchart

### Unglück 4: Der 3D-Barchart

### Unglück 5: Der unbalancierte Graph

### Unglück 6: Der Spaghetti-Graph

### Unglück 7: Barcharts 

### Unglück 8: Gelabelte Barcharts 

### Unglück 9: Noch mehr Barcharts


## Lügen mit (grafischer) Statistik 

* Hier ein paar Beispiele wie man mit Abbildungen lügen kann




## Links und weiterführende Literatur {#vis-links}

Die Debatte ob nun `base` oder `ggplot2` 'besser' ist kennt natürlich 
unzählbar viele Beiträge - die meisten davon geschrieben von Menschen mit
starker meinung und schwachen Argumenten.
Ein recht häufig zitierter [pro-base Blog](https://simplystatistics.org/2016/02/11/why-i-dont-use-ggplot2/)
von Jeff Leek findet hier eine [pro-ggplot Antwort](http://varianceexplained.org/r/why-I-use-ggplot2/).
Nathan Yau bezieht sich auf beide Beiträge und vollzieht hier einen
[sehr pragmatisch geschriebener Vergleich](https://flowingdata.com/2016/03/22/comparing-ggplot2-and-r-base-graphics/)
Auch wenn er das Potenzial von `ggplot2` nicht auch nur im Ansatz ausnutzt
ist es doch ein netter Vergleich mit in meinen Augen sinnvoller Conclusio:
"There’s also no problem with using everything available to you. 
At the end of the day, it’s all R."

Für alle die sich mit den theoretischen Grundlagen von `ggplot2` genauer 
befassen wollen:
Die `ggplot2` zugrundeliegende Idee einer *grammar of graphics* geht auf 
@GrammarGraphics zurück und wird in @wickhamggplot theoretisch ausgeführt.

@schwabischVis wurde bereits erwähnt und ist eine konstruktive Auseinandersetzung
mit typischen Visualisierungsfehlern, die auch tatsächlich in Top-Journalen
gemacht wurden. Besonders wichtig: konstruktive Verbesserungsvorschläge sind
gleich mit dabei.

Falls Sie einen neuen Typ Grafik erstellen wollen ist es immer sinnvoll, sich
Beispiele aus dem Internet anzuschauen, oder sogar bestehenden Code zu 
kopieren und für die eigenen Bedürfnisse anzupassen. 
Die [R Graph Gallery](https://www.r-graph-gallery.com/) ist dafür ein 
hervorragender Ausgangspunkt.
Ansonsten bietet auch das [R Graphics Cookbook](http://www.cookbook-r.com/Graphs/)
zahlreiche sehr nützliche Ausgangsbeispiele.






