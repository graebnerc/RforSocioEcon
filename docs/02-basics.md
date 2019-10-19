# Erste Schritte in R {#basics}

Nach diesen (wichtigen) Vorbereitungsschritten wollen wir nun mit dem 
eigentlichen Programmieren anfangen.
Zu diesem Zweck müssen wir uns mit der Syntax von R vertraut machen,
also den Regeln, denen wir folgen müssen, wenn wir Code schreiben, damit der 
Computer versteht, was wir ihm eigentlich in R sagen wollen.

## Befehle in R an den Computer übermitteln

Grundsätzlich können wir über R Studio auf zwei Arten mit dem Computer
"kommunizieren": über die Konsole direkt, oder indem wir im Skriptbereit ein
Skript schreiben und dies dann ausführen.

Als Beispiel für die erste Möglichkeit wollen wir mit Hilfe von R die Zahlen 
`2` und `5` miteinander addieren. 
Zu diesem Zweick können wir einfach `2 + 2` in die Konsole eingeben, und den
Begehl mit 'Enter' an den Computer senden. 
Da es sich beim Ausdruck `2 + 3` um korrekten R Code handelt, 'versteht' der
Computer was wir von uns wollen und gibt uns das entsprechende Ergebnis aus:


```r
2 + 3
```

```
## [1] 5
```

Auf diese Art und Weise könne wir R als einfachen Taschenrechner verwenden,
denn für alle einfachen mathematischen Operationen können wir bestimmte Symbole
als Operatoren verwenden.
An dieser Stelle sei noch darauf hingewiesen, dass das Symbol `#` in R einen
Kommentar einleitet, das heißt alles was in einer Zeile nach `#` steht wird
vom Computer ignoriert und man kann sich einfach Notizen in seinem Code machen.


```r
2 + 2 # Addition
```

```
## [1] 4
```


```r
2/2 # Division
```

```
## [1] 1
```


```r
4*2 # Multiplikation
```

```
## [1] 8
```


```r
3**2 # Potenzierung
```

```
## [1] 9
```

Alternativ können wir die Befehle in einem Skript aufschreiben, und dieses Skript
dann ausführen. Während die Interaktion über die Konsole sinnvoll ist um die 
Effekte bestimmter Befehle auszuprobieren, bietet sich die Verwendung von 
Skripten an, wenn wir mit den Befehlen später weiter arbeiten wollen, oder sie
anderen Menschen zugänglich zu machen.

Die Berechnungen, die wir bisland durchgeführt haben sind zugegebenermaßen nicht 
sonderlich spannend.
Um fortgeschrittene Operationen in R durchführen und verstehen zu können müssen
wir uns zunächst mit den Konzepten von **Objekten**, **Funktionen** und
**Zuweisungen** beschäftigen.

## Objekte, Funktionen und Zuweisungen

> To understand computations in R, two slogans are helpful:
>   Everything that exists is an object.
>   Everything that happens is a function call.
> ---John Chambers

Mit der Aussage 'Alles in R ist ein Objekt' ist gemeint, dass jede Zahl, jede
Funktion, oder jeder Buchstabe in R ein Objekt ist, das irgendwo auf dem 
Speicher Ihres Rechners abgespeichert ist. 

In der Berechnung `2 + 3` ist die Zahl `2` genauso ein Objekt wie die Zahl `3`
und die Additionsfunktion, die durch den Operator `+` aufgerufen wird.

Mit der Aussage 'Alles was in R passiert ist ein Funktionsaufruf' ist gemeint,
dass wenn wir R eine Berechnung durchführen lassen, tun wir dies indem wir eine
Funktion aufrufen.

**Funktionen** sind Algorithmen, die bestimmte Routinen auf einen *Input* 
anwenden und dabei einen *Output* produzieren. 
Die Additionsfunktion, die wir in der Berechnung `2 + 3` aufgerufen haben hat 
als Input die beiden Zahlen `2` und `3` aufgenommen, hat auf sie die Routine 
der Addition angewandt und als Output die Zahl `5` ausgegeben.
Der Output `5` ist dabei in R genauso ein Objekt wie die Inputs `2` und `3`, 
sowie die Funktion `+`.

Ein 'Problem' ist, dass R im vorliegenden Falle den Output der Berechnung 
zwar ausgibt, wir danach aber keinen Zugriff darauf mehr haben:


```r
2 + 3
```

```
## [1] 5
```

Falls wir den Output weiterverwenden wollen, macht es Sinn, dem Output Objekt
einen Namen zu geben, damit wir später wieder darauf zugreifen können.
Der Prozess einem Objekt einen Namen zu Geben wird **Zuweisung** oder 
**Assignment** genannt und durch die Funktion `assign` vorgenommen:


```r
assign("zwischenergebnis", 2 + 3)
```

Wir können nun das Ergebnis der Berechnung `2 + 3` aufrufen, indem wir in R
den Namen des Output Objekts eingeben:


```r
zwischenergebnis
```

```
## [1] 5
```

Da Zuweisungen so eine große Rolle spielen und sehr häufig vorkommen gibt es 
auch für die Funktion `assign` eine Kurzschreibweise, nämlich `<-`. 
Entsprechend sind die folgenden beiden Befehle äquivalent:


```r
assign("zwischenergebnis", 2 + 3)
zwischenergebnis <- 2 + 3
```

Entsprechend werden wir Zuweisungen immer mit dem `<-` Operator durchführen.
^[Theoretisch kann `<-` auch andersherum verwendet werden: 
`2 + 3 -> zwischenergebnis`.
Das mag zwar auf den ersten Blick intuitiver erscheinen, da das aus `2 + 3` 
resultierende Objekt den Namen `zwischenergebnis` bekommt, also immer erst das
Objekt erstellt wird und dann der Name zugewiesen wird, es führt jedoch zu 
deutlich weniger lesbarem Code und sollte daher nie verwendet werden.
Ebensoweinig sollten Zuweisungen durch den `=` Operatur vorgenommen werden, auch
wenn es im Fall `zwischenergebnis = 2 + 3` funktionieren würde.
Namen `zwischenergebnis`.] 

Wir können in R nicht beliebig Namen vergeben. 
Gültige (also: syntaktisch korrekte) Namen ...

* enthalten nur Buchstaben, Zahlen und die Symbole `.` und `_`
* fangen nicht mit `.` oder einer Zahl an!

Zudem gibt es einige Wörter, die schlicht nicht als Name verwendet werden 
dürgen, z.B. `function`, `TRUE`, oder `if`. Die gesamte Liste verbotener Worte
kann mit dem Befehl `?Reserved` ausgegeben werden.

Wenn man einen Namen vergeben möchte, der nicht mit den gerade formulierten 
Regeln kompatibel ist, gibt R eine Fehlermeldung aus:


```r
TRUE <- 5
```

```
## Error in TRUE <- 5: invalid (do_set) left-hand side to assignment
```

Zudem sollte man folgendes beachten:

* Namen sollten kurz und informativ sein; entsprechen ist `sample_mean` ein 
guter Name, `shit15_2` dagegen eher weniger
* Man sollte **nie Umlaute in Namen verwenden**
* Auch wenn möglich, sollte man nie von R bereit gestellte Funktionen 
überschreiben. Eine Zuweisung wie `assign <- 2` ist zwar möglich, führt
in der Regel aber zu großem Unglück, weil man nicht mehr ganz einfach auf die 
zugrundeliegende Funktion zurückgreifen kann.

> **Hinweis**: Alle aktuellen Namenszuweisungen sind im Bereich `Environment`
in R Studio (Nr. 4 in der Abbildung oben) aufgelistet und können durch die 
Funktion `ls()` angezeigt werden.

> **Hinweis**: Ein Objekt kann mehrere Namen haben, aber kein Name kann zu 
mehreren Objekten zeigen, da im Zweifel eine neue Zuweisung die alte 
Zuweisung überschreibt:


```r
x <- 2 
y <- 2 # Das Objekt 2 hat nun zwei Namen
print(x)
```

```
## [1] 2
```

```r
print(y)
```

```
## [1] 2
```

```r
x <- 4 # Der Name 'x' zeigt nun zum Objekt '4', nicht mehr zu '2'
print(x)
```

```
## [1] 4
```


Aus dem bisher gelernten wurde deutlich, dass es sich sowohl bei `assign` als
auch bei `+` um Funktionen handelt. Merkwürdig erscheint zunächst nur wie 
unterschiedlich diese Funktionen verwendet werden:
Im Falle von `assign` schreiben wir zuerst den Funktionsnamen und dann in 
Klammern die unterschiedlichen Argumente der Funktion, im Falle von `+` 
schreiben wir den Funktionsnamen zwischen die Argumente der Funktion.

Dies liegt daran, dass es in R prinzipiell vier verschiedene Arten gibt, 
Funktionen aufzurufen. Nur zwei davon sind allerdings aktuell von uns relevant.

Die bei weitem wichtigste Variante ist die so genannte *Prefix-Form*.
Dies ist die Form, die wir bei der überwältigenden Anzahl von Funktionen 
verwenden werden.
Wir schreiben hier zunächst den Namen der Funktion (im Folgenden Beispiel 
`assign`), dann in Klammern die Argumente der Funktion, welche den Input und 
weitere Spezifikationen beinhalten (hier der Name `test` und die Zahl `2`):


```r
assign("test", 2)
```

Ein hin und wieder auftretende Form ist die so genannte *Infix-Form*. 
Hier wird der Funktionsname zwischen die Argumente geschrieben. 
Dies ist, wie wir oben bereits bemerkt haben, bei vielen mathematischen 
Funktionen wie `+`, `-` oder `/` der Fall. 
Streng genommen ist die die Infix-Form aber nur eine *Abkürzung*, denn jeder
Funktionsaufruf in Infix-Form kann auch in Prefix-Form geschrieben werden, wie
folgendes Beispiel zeigt:


```r
2 + 3
```

```
## [1] 5
```

```r
`+`(2,3)
```

```
## [1] 5
```

## Zwischenbillanz

* Wir können Befehle in R Studio an den Computer übermitteln indem wir (a) den
R Code in die Konsole schreiben und Enter drücken oder (b) den Code in ein 
Skript schreiben und dann ausführen
* Alles in R existiert ist ein Objekt, alles was in R passiert ist ein
Funktionenaufruf
* Wir können einem Objekt mit Hilfe von `<-` einen Namen geben und dann später
wieder aufrufen. Den Prozess der Namensgebung nennen wir **Assignment** und wir
können uns alle aktuell von uns vergebenen Namen mit der Funktion `ls()` 
anzeigen lassen.
* Eine Funktion ist ein Objekt, das auf einen Input eine bestimmte Routine 
anwendet und einen Output produziert
* Die wichtigste Art, Funktionen aufzurufen ist, ihren Namen zu schreiben
und danach die Argumente in Klammern anzugeben (Prefix Form, 
z.B. `assign("x", 2)`)
* Gerade bei mathematischen Funktionen wie `+` und `-` verwenden wir auch die
Infix Form, bei der die Argumente vor und nach dem Funktionsnamen stehen 
(z.B. `2 + 3`)

## Grundlegende Objeke in R

Wir haben bereits gelernt, dass alles was in R existiert ein Objekt ist.
Wir haben aber auch schon gelernt, dass es unterschiedliche Arten von Objekten
gibt: Zahlen, wie `2` oder `3` und Funktionen wie `assign`.
Tatsächlich gibt es noch viel mehr Arten von Objekten.
Ein gutes Verständnis der Objektarten ist Grundvoraussetzung später 
anspruchsvolle Programmierarufgaben zu lösen. Daher wollen wir uns im folgenden
mit den wichtigsten Objektarten in R auseinandersetzen.

### Vektoren

Vektoren sind einer der wichtigsten Objettypen in R. 
Quasi alle Daten mit denen wir in R arbeiten werden als Vektoren behandelt 
werden.

Was Vektoren angeht gibt es wiederum die wichtige 
**Unterscheidung von atomaren Vektoren und Listen**.
Beide bestehen ihrerseits aus Objekten und sie unterscheiden sich dadurch, dass
atomare Vektoren nur aus Objekten des gleichen Typs bestehen können, Listen 
dagegen auch Objekte unterschiedlichen Typs beinhalten können.

Entsprechend kann jeder atomare Vektor einem Typ zugeordnet werden, je nachdem
welchen Typ seine Bestandteile haben. 
Hier sind insbesondere vier Typen relevant: 

* Logische Werte (`logical`): es gibt zwei logische Werte, `TRUE` und `FALSE`, 
welche auch mit `T` oder `F` abgekürzt werden können
* Ganze Zahlen `integer`: das sollte im Prinzip selbsterklärend sein, 
allerding müssen den ganzen Zahln in R immer der Buchstabe `L`folgen, damit
die Zahl tatsächlich als ganze Zahl interpretiert wird.^[Diese auf den ersten 
Blick merkwürdige Syntax hat historische Gründe: 
als der integer Typ in die R Programmiersprache eingeführt wurde war er sehr 
stark an den Typ `long integer` in der Programmiersprache 'C' angelehnt.
In C wurde ein solcher 'long integer' mit dem Suffix 'l' oder 'L' definiert,
diese Regel wurde aus Kompatibilitätsgründen auch für R übernommen, jedoch nur 
mit 'L', da man Angst hatte, dass 'l' mit 'i' verwechselt wird, was in R für die
imaginäre Komponente komplexer Zahlen verwendet wird.] Beispiele sind
`1L`, `400L` oder `10L`.  
* Dezimalzahlen `double`: auch das sollte selbsterklärend sein; Beispiele wären
`1.5`, `0.0`, oder `-500.32`.
* Ganze Zahlen und Dezimalzahlen werden häufig unter der Kategorie `numeric`
zusammengefasst. Dies ist in der Praxis aber quasi nie hilfreich und man sollte
diese Kategorie möglichst nie verwenden.
* Wörter (`character`): sie sind dadurch gekennzeichnet, dass sie auch 
Buchstaben enthalten können und am Anfang und Ende ein `"` haben. Beispiele hier
wären `"Hallo"`, `"500"` oder `"1_2_Drei"`.
* Es gibt noch zwei weitere besondere 'Typen', die strikt gesehen keine 
atomaren Vektoren darstellen, allerdings in diesem Kontext schon häufig 
auftauchen: `NULL`, was strikt genommen ein eigener Datentyp ist und immer
die Länge 0 hat, sowie `NA`, das einen fehlenden Wert darstellt

Hieraus ergibt sich folgende Aufteilung für Vektoren:

<img src="../figures/vector-classification.pdf" alt="drawing" width="300"/>

Wir werden nun die einzelnen Typen genauer betrachten.
Vorher wollen wir jedoch noch die Funktion `typeof` einführen.
Sie hilft uns in der Praxis den Typ eines Objekts herauszufinden.
Dafür rufen wir einfach die Funktion `typeof` mit dem zu untersuchenden Objekt
oder dessen Namen auf:


```r
typeof(2L)
```

```
## [1] "integer"
```

```r
x <- 22.0
typeof(x)
```

```
## [1] "double"
```

Wir können auch explizit testen ob ein Objekt ein Objekt bestimmten Typs ist.
Die generelle Syntax hierfür ist: `is.*()`, also z.B.:


```r
x <- 1.0
print(
  is.integer(x)
  )
```

```
## [1] FALSE
```

```r
print(
  is.double(x)
)
```

```
## [1] TRUE
```

Die Funktion gibt als Output also immer einen logischen Wert aus, je nachdem
ob die Inputs des entsprechenden Typs sind oder nicht.

Bestimmte Objekte können in einen anderen Typ transformiert werden.
Hier spricht man von `coercion` und die generelle Syntax hierfür ist: 
`as.*()`, also z.B.:


```r
x <- "2"
print(
  typeof(x)
)
```

```
## [1] "character"
```

```r
x <- as.double(x)
print(
  typeof(x)
)
```

```
## [1] "double"
```


Allerdings ist eine Transformation nicht immer möglicht:

```r
as.double("Hallo")
```

```
## Warning: NAs introduced by coercion
```

```
## [1] NA
```
Da R nicht weiß wie man aus dem Wort 'Hallo' eine Dezimalzahl machen soll,
transformiert er das Wort in einen 'Fehlenden Wert', der in R als `NA` 
bekannt ist und unten noch genauer diskutiert wird.


Für die Grundtypen ergibt sich folgende logische Hierachie an trivialen 
Transformationen: `logical` &rarr; `integer` &rarr; `double` &rarr; `character`,
d.h. man kann eine Dezimalzahl ohne Probleme in ein Wort transformieren, 
aber nicht umgekehrt:


```r
x <- 2
y <- as.character(x)
print(y)
```

```
## [1] "2"
```

```r
z <- as.double(y) # Das funktioniert
print(z)
```

```
## [1] 2
```

```r
k <- as.double("Hallo") # Das nicht
```

```
## Warning: NAs introduced by coercion
```

```r
print(k)
```

```
## [1] NA
```
Da nicht immer ganz klar ist wann R bei Transformationen entgegen der gerade
eingeführten Hierachie eine Warnung ausgibt und wann nicht sollte man hier immer
besondere Vorsicht walten lassen!

Zudem ist bei jeder Transformation Vorsicht geboten, da sie häufig Eigenschaften 
der Objekte implizit verändert.
So führt eine Transformation von einer Dezimalzahl hin zu einer ganzen Zahl
teils zu unerwartetem Rundungsverhalten:


```r
x <- 1.99
as.integer(x)
```

```
## [1] 1
```

Auch führen Transformationen, die der eben genannten Hierachie zuwiderlaufen
nicht zwangsweise zu Fehlern, sondern 'lediglich' zu unerwarteten Änderungen, 
die in jedem Fall vermieden werden sollten:


```r
z <- as.logical(99)
print(z)
```

```
## [1] TRUE
```


Häufig transformieren Funktionen ihre Argumente automatisch, was meistens 
hilfreich ist, manchmal aber auch gefährlich sein kann:


```r
x <- 1L # Integer
y <- 2.0 # Double
z <- x + y
typeof(z)
```

```
## [1] "double"
```

Interessanterweise werden logische Werte ebenfalls transformiert:


```r
x <- TRUE
y <- FALSE
z <- x + y # TRUE wird zu 1, FALSE zu 0
print(z) 
```

```
## [1] 1
```

Daher sollte man immer den Überblick behalten, mit welchen Objekttypen man 
gerade arbeitet.

Hier noch ein kurzer Überblick zu den Test- und Transformationsbefehlen:

Typ       | Test           | Transformation |
----------+----------------+----------------|
logical   | `is.logical`   | `as.logical`   |
double    | `is.double`    | `as.double`    |
integer   | `is.integer`   | `as.integer`   |
character | `is.character` | `as.character` |
function  | `is.function`  | `as.function`  |
NA        | `is.na`        | NA             |
NULL      | `is.null`      | `as.null`      |

Ein letzter Hinweis zu **Skalaren**. 
Unter Skalaren verstehen wir häufig 'einzelne Zahlen', z.B. `2`.
Dieses Konzept gibt es in R nicht.
`2` ist ein Vektor der Länge 1.
Wir unterscheiden also vom Typ her nicht zwischen einem Vektor, der nur ein oder 
mehrere Elemente hat.

**Hinweis:** Um längere Vektoren zu erstellen, verwenden wir die Funktion `c()`:


```r
x <- c(1, 2, 3)
x
```

```
## [1] 1 2 3
```

Da atomare Vektoren immer nur Objekte des gleichen Typs enthalten können, 
könnte man erwarten, dass es zu einem Fehler kommt, wenn wir Objete 
unterschiedlichen Type kombinieren wollen:


```r
x <- c(1, "Hallo")
```

Tatsächlich transformiert R die Objekte allerdings nach der oben beschriebenen
Hierachie  `logical` &rarr; `integer` &rarr; `double` &rarr; `character`. 
Da hier keine Warnung oder kein Fehler ausgegeben wird, sind 
derlei Transformationen eine gefährliche Fehlerquelle!

**Hinweis:** Die Länge eines Vektors kann mit der Funktion `length` bestimmt 
werden:


```r
x =  c(1, 2, 3)
len_x <- length(x)
len_x
```

```
## [1] 3
```

### Ganze Zahlen und Dezimalzahlen (integer und double)

### Logische Werte (logical)

### Wörter (character)

### Fehlende Werte und NULL

### Matrizen und Arrays

### Listen

### Data Frames

### Funktionen

### Optional: Namespaces

### Optional: Klassen in R

* class vs mode: unclass function

## Libraries

* Was sind libraries?
* Wie installiert man sie? Wie installiert man von GitHub?
* Wie verwendet man sie?
* Immer am Anfang vom Skript verwenden
* Wie findet man libraries?

## Kurzer Exkurs zum Einlesen und Schreiben von Daten

Zum Abschluss wollen wir noch kurz einige Befehle zum Einlesen von Daten 
einführen. Später werden wir uns ein ganzes Kapitel mit dem Einlesen und 
Schreiben von Daten beschäftigen, da dies in der Regel einen nicht 
unbeträchtlichen Teil der quantitativen Forschungsarbeit in Anspruch nimmt.
An dieser Stelle wollen wir aber nur lernen, wie man einen angemessenen 
Datensatz in R einliest.

R kann zahlreiche verschiedene Dateiformate einlesen, z.B. `csv`, `dta` oder `txt`,
auch wenn für manche Formate bestimmte Libraries geladen sein müssen.

Das gerade für kleinere Datensätze mit Abstand beste Format ist in der Regel
`csv`, da ist von zahlreichen Programmen und auf allen Betriebssystemen 
gelesen und geschrieben werden kann.

Für die Beispiele hier nehmen wir folgende Ordnerstruktur an:

```
2019-Methoden
│   2019-Methoden.Rproj
│
+---data
│   │
│   +---raw
│   |    │  Rohdaten.csv
|   |
|   +---tidy
```

Um die Daten einzulesen verwenden wir das Paket `tidyverse`, die wir später
genauer kennen lernen werden. Sie enthält viele nützliche Funktionen zur 
Arbeit mit Datensätzen.
Zudem verwende ich das Paket `here` um relative Pfade immer von meinem
Arbeitsverzeichnis aus angeben zu können.^[Das ist notwendig, da dieses Skript 
in R Markdown geschrieben ist und das Arbeitsverzeichnis automatisch auf den
Ordner ändert, in dem das .Rmd file liegt. Mehr Information zum Schreiben von
R Markdown finden Sie im Anhang. Dieser wird auch in der Vorlesung besprochen.]


```r
library(tidyverse)
library(here)
```




Nehmen wir an, die Datei `Rohdaten.csv` sähe folgendermaßen aus:

```
Auto,Verbrauch,Zylinder,PS
Ford Pantera L,15.8,8,264
Ferrari Dino,19.7,6,175
Maserati Bora,15,8,335
Volvo 142E,21.4,4,109
```

Wie in einer typischen csv Datei sind die Spalten hier mit einem Komma getrennt. 
Um diese Datei einzulesen verwenden wir die Funktion `read_csv` mit dem 
Dateipfad als erstes Argument:


```r
auto_daten <- read_csv(here("data/raw/Rohdaten.csv"))
auto_daten
```

```
## # A tibble: 4 x 4
##   Auto           Verbrauch Zylinder    PS
##   <chr>              <dbl>    <dbl> <dbl>
## 1 Ford Pantera L      15.8        8   264
## 2 Ferrari Dino        19.7        6   175
## 3 Maserati Bora       15          8   335
## 4 Volvo 142E          21.4        4   109
```

Wir haben nun einen Datensatz in R, mit dem wir dann weitere Analysen anstellen
können. 
Nehmen wir einmal an, wir wollen eine weitere Spalte hinzufügen (Verbrauch/PS)
und dann den Datensatz im Ordner `data/tidy` speichern.
Ohne auf die Modifikation des Data Frames einzugehen können wir die Funktion 
`write_csv` verwenden um den Datensatz zu speichern. 
Hierzu geben wir den neuen dataframe als erstes, und den Pfad als zweites 
Argument an:


```r
auto_daten_neu <- auto_daten %>%
  mutate(Verbrauch_pro_PS=Verbrauch/PS)
write_csv(auto_daten_neu, here("data/tidy/NeueDaten.csv"))
```

* Einfache Beispiele zum Einlesen von Daten
* Mehr dazu in der dritten Section
