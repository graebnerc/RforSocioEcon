# Wiederholung: Statistik und Stochastik {#stat-stoch}

In diesem Kapitel werden zunächst grundlegende Konzepte der deskriptiven 
Statistik wiederholt und dabei deren Implementierung in R beschrieben.
Insbesondere beschäftigen wir uns mit klassischen deskriptiven Kennzahlen zur 
Beschreibung von Datensätzen (Abschnitt X),...


```r
library(here)
library(tidyverse)
library(ggpubr)
library(latex2exp)
library(icaeDesign)
library(AER)
library(MASS)
```

## Einleitung: Statistik und Stochastik

Statistik und Stochastik sind untrennbar miteinander verbunden.
In der Stochastik beschäftigt man sich mit Modellen von 
Zufallsprozessen, also Prozessen, deren Ausgang nicht exakt vorhersehbar ist.
Häufig spricht man auch von *Zufallsexperimenten*.

Die Stochastik entwickelt dabei Modelle, welche diese Zufallsexperimenten und deren 
mögliche Ausgänge beschreiben und dabei den möglichen Ausgängen 
Wahrscheinlichkeiten zuordnern. 
Diese Modelle werden *Wahrscheinlichkeitsmodelle* genannt.
In der Statistik versuchen wir anhand von beobachteten Daten herauszufinden,
welches Wahrscheinlichkeitsmodell gut geeignet ist, den die Daten generierenden
Prozess (*data generating process* - DGP) zu beschreiben. 
Das ist der Grund warum man für Statistik auch immer Kenntnisse der Stochastik
braucht.

## Grundbegriffe der Stochastik

Ein solches stochastisches Modell besteht *immer* aus den folgenden drei 
Komponenten: 

**Ergebnisraum**: diese Menge $\Omega$ enthält alle möglichen Ergebnisse des 
modellierten Zufallsexperiments. Das einzelne Ergebnis bezeichnen wir mit $\omega$.

> **Beispiel:** Handelt es sich bei dem Zufallsexperiment um das Werfen eines
normalen sechseitigen Würfels gilt $\Omega=\{1,2,3,4,5,6\}$. Wenn der Würfen
gefallen ist, bezeichnen wir die oben liegende Zahl als das Ergebnis $\omega$ des 
Würfelwurfs.

**Ereignisse:** unter Ereignissen $A, B, C,...$ verstehen wir die Teilmengen
des Ergebnisraums. Ein Ereignis enthält ein oder mehrere Elemente des Ergebnisraums.
Enthält ein Ereignis genau ein Element, sprechen wir von einem Elementarereignis.

> **Beispiel:** "Es wird eine gerade Zahl gewürfelt" ist ein mögliches Ereignis
im oben beschriebenen Zufallsexperiment. Das Ereignis tritt ein, wenn ein 
Würfelwurf mit dem Ergebnis "2", "4" oder "6" endet. 
Das Ereignis "Es wird eine 2 gewürfelt" tritt nur ein, wenn das Ergebnis des
Würfelwurfs eine 2 ist. Entsprechend nennen wir es ein *Elementarereignis*.

Da es sich bei Ereignissen um Mengen handelt können wir die typischen
mengentheoretischen Konzepte wie 'Vereinigung', 'Differenz' oder 'Komplement' zu
ihrer Beschreibung verwenden:

Konzept | Symbol | Übersetzung |
--------+--------+-------------|
Durchschnitt | $A\cap B$ | $A$ und $B$|
Vereinigung | $A\cup B$ | $A$ und/oder $B$|
Komplement | $A^c$ | Nicht $A$|
Differenz | $A \setminus  B = A\cap B^c$ | $A$ ohne $B$ |

**Wahrscheinlichkeiten**: jedem *Ereignis* $A$ wird eine Wahrscheinlichkeit 
$\mathbb{P}(A)$ zugeordnet. Wahrscheinlichkeiten können aber nicht beliebige
Zahlen sein. Vielmehr müssen sie im Einklang mit den drei
*Axiomen von Kolmogorow* stehen:

1. Für jedes Ereignis $A$ gilt: $0\leq\mathbb{P}(A)\leq1$

2. Das sichere Ereignis $\Omega$ umfasst den ganzen Ergebnisraum und es gilt 
entsprechend $\mathbb{P}(\Omega)=1$.

3. Es gilt: $\mathbb{P}(A\cup B) = \mathbb{P}(A)+\mathbb{P}(B)$ falls 
$A\cap B=\emptyset$, also wenn sich A und B gegenseitig ausschließen.

Aus diesen Axiomen lassen sich eine ganze Menge Sätze heraus ableiten, auf die
wir im folgenden aber nicht besonders eingehen wollen.
Die Grundidee ist aber, bestimmten Ereignissen von Anfang an bestimmte Warhscheinlichkeiten 
zuzuordnen, und die Wahrscheinlichkeiten für andere Ereignisse dann aus den eben 
beschriebenen Regeln abzuleiten.

Je nach Art des Ergebnisraums $\Omega$ unterscheiden wir zwei grundsätzlich
verschiedene Arten von Wahrscheinlichkeitsmodellen:
ist $\Omega$ **abzählbar** handelt es sich um ein 
**diskretes Wahrscheinlichkeitsmodell**. 
Der Würfelwurf oder ein Münzwurf sind hierfür Beispiele: die Menge der 
möglichen Ergebnisse ist hier klar abzählbar.^[Wir nennen eine Menge 
abzählbar wenn sie mit Hilfe der ganzen Zahlen $\mathbb{N}$ indiziert werden 
kann. Das bedeutet, dass auch unendlich große Mengen als abzählbar gelten können.]

Ist $\Omega$ **nicht abzählbar** handelt es sich dagegen um ein 
**kontinuierliches Wahrscheinlichkeitsmodell**.
Ein Beispiel hierfür wäre das Fallenlassen von Steinen und die Messung der 
Falldauer. Die einzelnen Ereignisse wären dann die Falldauer und es würde gelten, 
dass $\Omega=\mathbb{R^+}$ und $\mathbb{R^+}$ ist nicht abzählbar.

Welches Modell für den konkreten Anwendungsfall vorzuziehen ist, muss auf Basis
von theoretischen Überlegungen entschieden werden.

## Diskrete Wahrscheinlichkeitsmodelle

Wenn wir die Wahrscheinlichkeit für das Eintreten eines Ereignisses $A$ 
erfahren möchten können wir im Falle eines diskreten Ergebnisraums einfach
die Eintrittswahrscheinlichkeiten für alle Ergebnisse, die zu $A$ gehören, 
aufsummieren:

$$ \mathbb{P}(A)=\sum_{\omega\in A} \mathbb{P}(\{\omega\})$$

> **Beispiel:** Beim Werfen eines sechseitigen Würfels ist die Wahrscheinlichkeit
für das Ereignst "Es wird eine gerade Zahl gewürfelt": $\mathbb{P}(2)+\mathbb{P}(4)+\mathbb{P}(6)=\frac{1}{6}+\frac{1}{6}+\frac{1}{6}=\frac{1}{2}$.

Von Interesse ist häufig aus den Wahrscheinlichkeiten für zwei Ereignisse, 
$A$ und $B$, die Wahrscheinlichkeit für $A\cap B$, also die Wahrscheinlichkeit,
dass beide Ereignisse auftreten, zu berechnen. 
Leider ist das nur im Spezialfall der **stochastischen Unabhängigkeit** möglich.
Stochastische Unabhängigkeit kann immer dann sinnvollerweise angenommen werden, 
wenn zwischen den beteiligten Ereignissen kein kausaler Zusammenhang besteht.
In diesem Fall gilt dann:

$$\mathbb{P}(A\cap B) = \mathbb{P}(A)\cdot\mathbb{P}(B)$$

> **Beispiel für stochastische Unabhängigkeit**: 
Es ist plausibel anzunehmen, dass es keinen kausalen Zusammenhang zwischen
zwei aufeinanderfolgenden Münzwürfen gibt. Entsprechend sind die Ereignisse
$A$: "Zahl im ersten Wurf" und $B$: "Kopf im zweiten Wurf" stochastisch 
unabhängig und $\mathbb{P}(A\cap B)=\mathbb{P}(A)\cdot \mathbb{P}(B)=\frac{1}{4}$.

> **Beispiel für stochastische Abhängigkeit**: 
Ein anderer Fall liegt vor, wenn wir die Ereignisse $C$: 
"Die Summe beider Würfe ist 6" und $D$: "Der erste Wurf zeigt eine 2." betrachten.
Hier ist offensichtlich, dass ein kausaler Zusammenhang zwischen den beiden 
Würfen und den Ereignissen besteht und entsprechend gilt auch: 
$\mathbb{P}(C\cap D)=\mathbb{P}(\{2, 4\})=\frac{1}{36}$ und 
$\mathbb{P}(C)\cdot \mathbb{P}(D)=\frac{5}{36}\cdot\frac{1}{6}=\frac{5}{216}$. 


Ein weiteres wichtiges Konzept ist das der **bedingten Wahrscheinlichkeit**:
die bedingten Wahrscheinlichkeit von $A$ gegeben $B$, $\mathbb{P}(A|B)$, 
bezeichnet die Wahrscheindlichkeit für $A$, wenn wir wissen, dass $B$ 
bereits eingetreten ist.

Es gilt dabei:

$$\mathbb{P}(A|B)=\frac{\mathbb{P}(A\cap B)}{\mathbb{P}(B)}$$

> **Beispiel:** Sei $A$: "Der Würfel zeigt eine 6" und $B$: 
"Der Würfelwurf zeigt eine gerade Zahl". Wenn wir bereits wissen, dass $B$ 
eingetreten ist, ist $\mathbb{P}(A)$ nicht mehr $\frac{1}{6}$, weil wir ja 
wissen, dass 1, 3 und 5 nicht auftreten können. 
Vielmehr gilt $\mathbb{P}(A|B)=\frac{1/6}{1/2}=\frac{1}{3}$.
Bayes Theorem und Gesetz der total Wahrscheinlichkeiten

Ganz wichtig es gilt *nicht notwendigerweise* $\mathbb{P}(A|B)=\mathbb{P}(B|A)$.
Vielmehr gilt nach dem **Satz von Bayes**:

$$\mathbb{P}(A|B)=\frac{\mathbb{P}(A\cap B)}{\mathbb{P}(B)}=\frac{\mathbb{P}(B|A)\mathbb{P}(A)}{\mathbb{P}(B)}$$

Ein in Beweisen sehr häufig verwendeter Zusammenhang ist das 
**Gesetz der totalen Wahrscheinlichkeit**: seien $A_1,...,A_k$  Ergeignisse, 
die sich nicht überschneiden und gemeinsam den kompletten Ereignisraum $\Omega$
abdecken, dann gilt:

$$\mathbb{P}(B)=\sum_{i=1}^k\mathbb{P}(B|A_k)\mathbb{P}(A_k)$$

Auch wenn das erst einmal sperrig aussieht, ist der Zusammenhang sehr praktisch 
und wird häufig in Beweisen in der Stochastik verwendet. 


### Diskrete Zufallsvariablen

Bei Zufallsvariablen handelt es sich um besondere *Funktionen*. 
Die Definitionsmenge einer Zufallsvariable ist immer der zurgundeliegende
Ergebnisraum $\Omega$, die Zielmenge ist i.d.R. $\mathbb{R}$, sodass gilt:

$$X:\Omega\rightarrow\mathbb{R}, \omega \mapsto X(\omega)$$

In der Regel bezeichnen wir Zufallsvariablen (ZV) mit Großbuchstaben und die
konkrete Realisation einer ZV mit einem Kleinbuchstaben, sodass 
$\mathbb{P}(X=x)$ die Wahrscheinlichkeit angibt, dass die ZV $X$ den konkreten
Wert $x$ annimmt. Bei $x$ sprechen wir von einer *Realisierung* der ZV $X$.
Wichtig zu beachten ist noch, dass nicht die ZV selbst zufällig ist, sondern
ihr Input $\omega$. Das bedeutet, dass wenn ein Zufallsexperiment zweimal das 
gleiche Ergebnis $\omega$ hat, ist auch der Wert $X(\omega)$ der gleiche.

Den unterschiedlichen Realisierungen von einer ZV haben jeweils Wahrscheinlichkeiten, 
die von den Wahrscheinlichkeiten der zugrundeliegenden Ergebnisse des 
modellierten Zufallsexperiments abhängen.

Produkte und Summen von ZV sind selbst wieder Zufallsvariables.
Man addiert bzw. multipliziert ZV indem man ihre Werte addiert bzw. mutlipliziert.

Im Falle von diskreten ZV können wir eine Liste erstellen, die für alle möglichen
Werte $x$ die jeweilige Wahrscheinlichkeit $\mathbb{P}(X=x)$ angibt.^[Aus den 
*Kolmogorow Axiomen* oben ergibt sich, dass die Summe all dieser
Wahrscheinlichkeiten 1 ergeben muss.] Diese Liste nennen wir 
**Wahrscheinlichkeitsverteilung** (*Probability Mass Function*, PMF) von $X$
und sie werden häufig visuell dargestellen.
Um diese Liste zu erstellen verwenden wir die zu $X$ gehörende 
**Wahrscheinlichkeitsfunktion**, die uns für jedes Ergebnis die zugehörige 
Wahrscheinlichkeit gibt.^[Zu jeder Wahrscheinlichkeitsverteilung gibt es eine 
eindeutige Wahrscheinlichkeitsfunktion und jede Wahrscheinlichkeitsfunktion 
definiert umgekehrt eine eindeutig bestimmte diskrete 
Wahrscheinlichkeitsverteilung. ]

Wenn wir eine ZV analysieren tun wir dies in der Regel durch eine Analyse ihrer
Wahrscheinlichkeitsverteilung. 
Zur genaueren Beschreibung einer ZV wird dagegen häufig einfach die 
Wahrscheinlichkeitsfunktion angegeben.
Der eigentliche Ergebnisraum $\Omega$ interessiert uns in der Anwendung hingegen 
eher selten.

Im folgenden wollen wir einige häufig auftretende Wahrscheinlichkeitsverteilungen
kurz besprechen.
Am Ende des Abschnitts findet sich dann ein tabellarischer Überblick.
Doch vorher wollen wir uns noch mit den wichtigsten **Kennzahlen einer Verteilung**
vertraut machen. 
Denn wie Sie sich vorstellen können sind Wahrscheinlichkeitsverteilungen als
Listen, die alle möglichen Realisierungen einer ZV enthalten ziemlich umständlich
zu handhaben. 
Daher beschreiben wir Wahrscheinlichkeitsverteilungen nicht indem wir eine Liste
beschreiben, sondern indem wir bestimmte Kennzahlen zu ihrer Beschreibung 
verwenden.
Die wichtigsten Kennzahlen einer ZV $X$ sind der **Erwartungswert** 
$\mathbb{E}(x)$ und die **Standardabweichung** $\sigma(X)$.

Der Erwartungswert ist definitert als die nach ihrer Wahrscheinlichkeit 
gewichtete Summe aller Elemente im Wertebereich von $X$ und gibt damit die
mittlere Lage der Wahrscheinlichkeitsverteilung an. 
Wenn $W_X$ der Wertebereich von $X$ ist, dann gilt:

$$\mathbb{E}(x)=\sum_{x\in W_X}\mathbb{P}(X=x)x$$

Ein gängiges Maß für die Streuung einer Verteilung $X$ ist die Varianz $Var(X)$
oder ihre Quadratwurzel, die Standardabweichung, $\sigma(X)=\sqrt{Var(X)}$. 
Letztere wird häufiger verwendet, weil sie die gleiche Einheit hat wie $X$:

$$Var(X)=\sum_{x\in W_X}\left[x-\mathbb{E}(X)\right]^2 \mathbb{P}(X=x)x$$

### Beispiel: die Binomial-Verteilung

Die vielleicht bekannteste diskrete Wahrscheinlichkeitsverteilung ist die
Binomialverteilung.
Mit ihr modelliert man Zufallsexperimente, die aus einer Reihe von Aktionen 
bestehen, die entweder zum 'Erfolg' oder 'Misserfolg' führen.

Die Binomialverteilung ist eine Verteilung mit zwei **Parametern**. 
Parameter sind Werte, welche die Struktur der Verteilung bestimmen.
In der Statistik sind wir häufig daran interessiert, die Paramter einer
Verteilung zu bestimmen. 
Im Falle der Binomialverteilung gibt es die folgenden zwei Parameter:
$p$ gibt die Erfolgswahrscheinlichkeit einer einzelnen Aktion an
(und es muss daher gelten $p\in[0,1]$) und $n$ gibt
die Anzahl der Aktionen an.

> **Beispiel:** Wenn wir eine faire Münze zehn Mal werfen, können wir das 
mit einer Binomialverteilung mit $p=0.5$ und $n=10$ modellieren.

Die *Wahrscheinlichkeitsfunktion* der Binomialverteilung ist die folgende,
wobei $x$ die Anzahl der Erfolge darstellt:

$$\mathbb{P}(X=x)=\binom{n}{x}p^x(1-p)^{n-x}$$
Dies ergibt sich aus den grundlegenden Wahrscheinlichkeitsgesetzen:
$\binom{n}{x}$ ist der 
[Binomialkoeffizient](https://de.wikipedia.org/wiki/Binomialkoeffizient)
und gibt uns die Anzahl der Möglichkeiten wie man bei $n$ Versuchen $x$ 
Erfolge erziehlen kann.
Dies multiplizieren wir mit der Wahrscheinlichkeit $x$-mal einen Erfolg zu
erziehlen und $n-x$-mal einen Misserfolg zu erziehlen.

Wenn die ZV $X$ einer Binomialverteilung mit bestimmten Parametern $p$ und $n$
folgt, dann schreiben wir $P \propto \mathcal{B}(n,p)$ und es gilt, dass 
$\mathbb{E}(X)=np$ und $\sigma(X)=\sqrt{np(1-p)}$.^[Die Herleitung finden Sie
im Statistikbuch Ihres Vertrauens oder auf 
[Wikipedia](https://de.wikipedia.org/wiki/Binomialverteilung#Erwartungswert).]

Im folgenden sehen wir eine Darstellung der Wahrscheinlichkeitsverteilung
der Binomialverteilung für verschiedene Parameterwerte:

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-2-1.png" width="672" style="display: block; margin: auto;" />


R stellt uns einige nützliche Funktionen bereit, mit denen wir typische 
Rechenaufgaben einfach lösen können: 

Möchten wir die Wahrscheinlichkeit bereichnen, genau $x$ Erfolge zu
beobachten, also $\mathbb{P}(X=x)$ geht das mit der Funktion `dbinom()`.
Die notwendigen Argumente sind `x` für den interessierenden x-Wert,
`size` für den Parameter $n$ und `prob` für den Parameter $p$:


```r
dbinom(x = 10, size = 50, prob = 0.25)
```

```
## [1] 0.09851841
```

Das bedeutet, wenn $X \propto B(50, 0.25)$, dann: $\mathbb{P}(X=10)=0.09852$.
Die folgende Abbildung illustriert dies:

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-4-1.png" width="672" style="display: block; margin: auto;" />

Natürlich können wir an die Funktion auch einen atomaren Vektor als erstes 
Argument übergeben:

```r
dbinom(x = 5:10, size = 50, prob = 0.25)
```

```
## [1] 0.004937859 0.012344647 0.025864974 0.046341412 0.072086641 0.098518410
```


Häufig sind wir auch an der **kumulierten Wahrscheinlichkeitsfunktion**
interessiert. 
Während uns die Wahrscheinlichkeitsfunktion die Wahrscheinlichkeit für genau
$x$ Erfolge angibt, also $\mathbb{P}(X=x)$, gibt uns die *kumulierte*
Wahrscheinlichkeitsfunktion die Wahrscheinlichkeit für $x$ oder weniger Erfolge,
also $\mathbb{P}(X\leq x)$. 

Die entsprechenden Werte für die kumulierten Wahrscheinlichkeitsfunktion 
erhalten wir mit der Funktion `pbinom()`, welche quasi die gleichen Argumente
benötigt wie `dbinom()`. 
Nur gibt es anstatt des Parameters `x` jetzt einen Parameter `q`:


```r
pbinom(q = 10, size = 50, prob = 0.25)
```

```
## [1] 0.2622023
```

Die Wahrscheinlichkeit 5 oder weniger Erfolge bei 5 Versuchen und einer 
Erfolgswahrscheinlichkeit von 25% zu erzielen beträgt also 25.2%:

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-7-1.png" width="672" style="display: block; margin: auto;" />

Schlussendlich können wir die Funktion `qbinom()`, welche als ersten Input eine
Wahrscheinlichkeit `p` akzeptiert und dann den kleinsten Wert $x$ findet,
für den gilt, dass $\mathbb{P}(X=x)\geq p$.

Wenn wir also wissen möchten wie viele Erfolge mit einer Wahrscheinlichkeit von
50% mindestens zu erwarten sind, dann schreiben wir:


```r
qbinom(p = 0.5, size = 50, prob = 0.25)
```

```
## [1] 12
```

Es gilt also: $\mathbb{P}(X=12)\geq p$.

Wir können dies grafisch verdeutlichen:

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-9-1.png" width="672" style="display: block; margin: auto;" />

Möchten wir schließlich eine bestimmte Menge an **Realisierungen** aus einer
Binomialverteilung ziehen geht das mit `rbinom()`, welches drei Argumente 
verlangt: `n` für die Anzahl der zu ziehenden Realisierungen, sowie `size` und
`prob` als da Paramter $n$ und $p$ der Binomialverteilung:


```r
sample_binom <- rbinom(n = 5, size = 10, prob = 0.4)
sample_binom
```

```
## [1] 5 5 4 3 2
```


### Beispiel: die Poisson-Verteilung

Bei der Poisson-Verteilung handelt es sich um die Standardverteilung für 
unbeschränkte Zähldaten, also diskrete Daten, die kein natürliches Maximum 
haben.

Bei der Poisson-Verteilung handelt es sich um eine **ein-parametrische** 
Funktion, deren einziger Parameter $\lambda>0$ ist.
Er wird häufig als die mittlere Ereignishäufigkeit interpretiert.
$\lambda$ ist **zugleich Erwartungswert als auch Varianz** der
Verteilung: $\mathbb{E}(P_\lambda)=Var(P_\lambda)=\lambda$.

Ihre Definitionsmenge ist $\mathbb{N}$, also alle natürlichen Zahlen - 
daher ist sie im Gegensatz zur Binomialverteilung geeignet, wenn die 
Definitionsmenge der Verteilung keine natürliche Grenze hat.

Die **Wahrscheinlichkeitsfunktion** der Poisson-Verteilung hat die folgende
Form:

$$P_\lambda(x)=\frac{\lambda^x}{x!}e^{-\lambda}$$
Die folgende Abbildung zeigt wie sich die Wahrscheinlichkeitsfunktion für
unterschiedliche Werte von $\lambda$ manifestiert:

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-11-1.png" width="672" style="display: block; margin: auto;" />

Wir können die Verteilung mit sehr ähnlichen Funktionen wie bei der 
Binomialverteilung analysieren. Nur die Parameter müssen entsprechend angepasst
werden, da es bei der Poisson-Verteilung jetzt nur noch einen Paramter (`lambda`)
gibt.

Möchten wir die Wahrscheinlichkeit bereichnen, genau $x$ Erfolge zu
beobachten, also $\mathbb{P}(X=x)$ geht das mit der Funktion `dpois()`.
Das einzige notwendige Argument ist `lambda`:


```r
dpois(5, lambda = 4)
```

```
## [1] 0.1562935
```

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-13-1.png" width="672" style="display: block; margin: auto;" />

Informationen über die CDF erhalten wir über die Funktion `ppois()`, die zwei
Argumente, `q` und `lambda`, annimmt.


<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-14-1.png" width="672" style="display: block; margin: auto;" />

Mit der Funktion `qpois()` finden wir für eine
Wahrscheinlichkeit `p` den kleinsten Wert $x$,
für den gilt, dass $\mathbb{P}(X=x)\geq p$.

Wenn wir also wissen möchten wie viele Erfolge mit einer Wahrscheinlichkeit von
50% mindestens zu erwarten sind, dann schreiben wir:


```r
qpois(p = 0.5, lambda = 4)
```

```
## [1] 4
```

Es gilt also: $\mathbb{P}(X=4)\geq 0.5$.

Wir können dies grafisch verdeutlichen:

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-16-1.png" width="672" style="display: block; margin: auto;" />

Möchten wir schließlich eine bestimmte Menge an **Realisierungen** der ZV aus einer
Poisson-Verteilung ziehen geht das mit `rpois()`, welches zwei notwendige
Argumente annimmt: `n` für die Anzahl der Realisierungen und `lambda` für den
Parameter $\lambda$:


```r
pois_sample <- rpois(n = 5, lambda = 4)
pois_sample
```

```
## [1] 2 3 4 5 3
```


### Hinweise zu diskreten Wahrscheinlichkeitsverteilungen

Wie Sie vielleicht bereits bemerkt haben sind die R Befehle für 
verschiedene Verteilungen alle gleich aufgebaut. 
Wenn `*` für die Abkürzung einer bestimmten Verteilung steht, können wir mit
der Funktion `p*()` die Werte der Wahrscheinlichkeitsverteilung ausgeben,
mit `q*()` die Quantilsfunktion ausgeben.
Mit `r*()` werden Realisierungen von Zufallszahlen realisiert.
Für das Beispiel der Binomialverteilung, welcher die Abkürzung `binom`
zugewiesen wurde, heißen die Funktionen entsprechend `dbinom()`, `pbinom()`, 
`qbinom()` und `rbinom()`.

Die folgende Tabelle gibt einen Überblick über gängige Abkürzungen und die 
Parameter der Verteilungen.

Verteilung | Art | Abkürzung | Parameter |
-----------+-----------+-----------|
Binomialverteilung | Diskret | `binom` | `size`, `prob` |
Poisson-Verteilung | Diskret | `pois` | `lambda` |


4.4.

4.5 später nehmen, genauso wie die danach

`t.test` 

## Stetige Wahrscheinlichkeitsmodelle 

### Stetige ZV

In vorangegangen Abschnitt haben wir uns mit diskreten Wahrscheinlichkeitsmodellen
beschäftigt. 
Die diesen Modellen zugrundeliegenden ZV hatten einen abzählbaren Wertebereich.
Häufig interessieren wir uns aber für ZV mit einem nicht abzählbaren 
Wertebereich, z.B. $\mathbb{R}$ oder $[0,1]$.^[Die Intervallschreibweise $[0,1]$
ist potenziell verwirrent. Es gilt: 
$[a,b]=\{x\in\mathbb{R} | a\leq x \leq b\}$ (geschlossenes Intervall), 
$(a,b)=\{x\in\mathbb{R} | a < x < b\}$ (offenes Intervall), 
$(a,b)=\{x\in\mathbb{R} | a < x \leq b\}$(linksoffenes Intervall) und 
$(a,b)=\{x\in\mathbb{R} | a \leq x < b\}$(rechtsoffenes Intervall).] 

Bei stetigen Wahrscheinlichkeitsmodellen liegen zwischen zwei Punkten 
unendlich viele Punkte. 
Das hat bedeutende Implikationen für die Angabe von Wahrscheinlichkeiten.
Im Gegensatz zu diskreten Wahrscheinlichkeitsmodellen hat danach jeder einzelne
Punkt im Wertebereich der ZV die Wahrscheinlichkeit 0:

$$\mathbb{P}(X=x)=0 \quad \forall x \in W_X$$
wenn $ W_X$ den Wertebereich von ZV $X$ angibt.

Als Lösung werden Wahrscheinlichkeiten bei stetigen ZV nicht als 
Punktwahrscheinlichkeiten, sondern als Intervallwahrscheinlichkeiten angeben.
Aus $\mathbb{P}(X=x)$ im diskreten Fall wird im stetigen Fall also:

$$\mathbb{P}(a<X\leq b), \quad a<b$$
Es folgt, dass wann immer wir im diskreten Fall eine 
Wahrscheinlichkeitsfunktion verwendet haben um eine ZV zu beschreiben, wir
jetzt im stetigen Fall eine *kumulative Verteilungsfunktion* 
$F(x)=\mathbb{P}(X\leq x)$ angeben, wobei immer gilt:

$$\mathbb{P}(a<X\leq b) = F(b)-F(a)$$

Eine verwandte Art und Weise eine stetige ZV zu beschreiben ist über die
jeweilige **Dichtefunktion** (*probability densitity function* - PDF).
Hierbei handelt es sich um eine integrierbare und nicht-negative Funktion 
$f(x)\geq 0 \forall x\in \mathbb{R}$ mit $\int_{-\infty}^{\infty}f(x)dx=1$
für die gilt: 

$$\mathbb{P}([a,b])=\int_a^bf(x)dx$$

Es gilt hierbei, dass die Dichtefunktion einer ZV die Ableitung ihrer 
kumulative Verteilungsfunktion ist. 
Wie oben beschrieben können wir die Werte an einzlnen Punkten nicht als
*absolute* Wahrscheinlichkeiten interpretieren, da die Wahrscheinlichkeit
für einzelne Punkte immer gleich 0 ist. 
Wir können aber die Werte der PDF an zwei oder mehr Punkten vergleichen um die
*relative* Wahrscheinlichkeit der einzelnen Punkte zu bekommen.

Wie bei den diskreten ZV beschreiben wir eine ZV mit Hilfe von bestimmten
Kennzahlen, wie dem **Erwartungswert**, der **Varianz** und den **Quantilen**.
Diese sind quasi äquivalent zum diskreten Fall definiert, nur eben über 
Integrale (wir vergleichen alle folgenden Definitionen mit ihrem diskreten 
Pendant am Ende des Abschnitts). 
Für den Erwartungswert der ZV $X$ gilt somit:

$$\mathbb{E}(X)=\int_{-\infty}^{\infty}xf(x)dx$$
Für die Varianz und die Standardabweichung entsprechend:

$$Var(X)= \mathbb{E}(X-\mathbb{E}\left(X)\right)^2=\int_{-\infty}^{\infty}(x-\mathbb{E}(X))^2f(x)dx$$

$$\sigma_X=\sqrt{Var(X)}$$

Und, schlussendlich, gilt für das $\alpha$-Quantil $q(\alpha)$:

$$\mathbb{P}(X\leq q(\alpha))=\alpha$$

Im folgenden werden das $0.25$ und $0.5$-Quantil visuell dargestellt:

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-18-1.png" width="672" style="display: block; margin: auto;" />


Abschließend wollen wir nun noch einmal die Definitionen der Kennzahlen und
charakteristischer Verteilungen für den stetigen und diskreten Fall vergleichen:

| Bezeichnung | Diskreter Fall | Stetiger Fall |
|-------------+------------------------------+-----------------------------|
Erwartungswert | $\mathbb{E}(x)=\sum_{x\in W_X}\mathbb{P}(X=x)x$ | $\mathbb{E}(X)=\int_{-\infty}^{\infty}xf(x)dx$ |
Varianz | $Var(X)=\sum_{x\in W_X}\left[x-\mathbb{E}(X)\right]^2 \mathbb{P}(X=x)x$ | $Var(X)= \mathbb{E}(X-\mathbb{E}\left(X)\right)^2$ |
Standardabweichung | $\sqrt{Var(X)}$ | $\sqrt{Var(X)}$ |
$\alpha$-Quantil | $\mathbb{P}(X\leq q(\alpha))=\alpha$ | $\mathbb{P}(X\leq q(\alpha))=\alpha$|
Dichtefunktion (PDF) | NA | $\mathbb{P}([a,b])=\int_a^bf(x)dx$ |
Wahrscheinlichkeitsfunktion (PMF) | $\mathbb{P}(A)=\sum_{\omega\in A} \mathbb{P}(\{\omega\})$ | NA |
Kumulierte Verteilungsfunktion (CDF) | $\mathbb{P}(X\leq x)$ | $F(x)=\mathbb{P}(X\leq x)$ |

### Beispiel: die Uniformverteilung

Die Uniformverteilung kann auch einem beliebigen Intervall $[a,b]$ mit $a<b$
definiert werden und ist dadurch gekennzeichnet, dass die Dichte über $[a,b]$
vollkommen konstant ist.
Ihre einzigen Parameter sind die Grenzen des Intervalls, $a$ und $b$.
Entsprechend trivial ist ihr Erwartungswert mit $\mathbb{E}(X)=\frac{a+b}{2}$ 
und ihre Varianz mit $Var(X)=\frac{(b-a)^2}{12}$ gegeben.

Ihre Dichtefunktion für $[a,b]=[0,4]$ ist im folgenden dargestellt:

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-19-1.png" width="672" style="display: block; margin: auto;" />


Die Abkürung in R für die Uniformverteilung ist `unif`. Endsprechend berechnen
wir Werte für die Dichte mit `dunif()`, welches lediglich die Argumente `a` und 
`b` für die Grenzen des Intervalls benötigt:


```r
dunif(seq(2,3, 0.1), min = 0, max = 4)
```

```
##  [1] 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25 0.25
```

Wie wir sehen erhalten wir hier immer den gleichen Wert $\frac{1}{b-a}$, was 
die zentrale Eigenschaft der Uniformverteilung ist.
Hier wird auch deutlich, dass dieser Wert die *relative* Wahrscheinlichkeit
angibt, da die absolute Wahrscheinlichkeit für jeden einzelnen Wert wie oben
beschrieben bei stetigen ZV 0 ist.

Die CDF berechnen wir entsprechend mit `punif()`.
Wenn $X\propto U(0,4)$ erhalten wir $\mathbb{P}(X\leq3)$ entprechend mit:

```r
punif(0.8, min = 0, max = 4)
```

```
## [1] 0.2
```

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-22-1.png" width="672" style="display: block; margin: auto;" />

Auch ansonsten können wir die Syntax der diskreten Verteilungen mehr oder weniger
übernehmen: `qunif()` akzeptiert die gleichen Parameter wie `punif()` und 
gibt uns Werte der inversen CDF, und `runif()` kann verwendet werden um 
Realisierungen einer uniform verteilten ZV zu generieren:


```r
uniform_sample <- runif(5, min = 0, max = 4)
uniform_sample
```

```
## [1] 3.8622589 0.3727306 2.8418428 2.6730040 0.0137953
```


### Beispiel: die Normalverteilung

Die wahrscheinlich bekanntests stetige Verteilung ist die Normalverteilung.
Das liegt nicht nur daran, dass viele natürliche Phänomene als die 
Realisierung einer normalverteilten ZV modelliert werden können, sondern auch
weil es sich mit der Normalverteilung in der Regel sehr einfach rechnen ist.
Sie ist also häufig auch einfach eine bequeme Annahme.

Bei der Normalverteilung handelt es sich um eine **zwei-parametrige** 
Verteilung über den Wertebereich $W_X=\mathbb{R}$.
Die beiden Parameter sind $\mu$ und $\sigma^2$, welche unmittelbar als 
Erwartungswert ($\mathbb{E}(X)=\mu$) und Varianz ($Var(X)=\sigma^2$) gelten.
Wir schreiben $X\propto \mathscr{N}(\mu, \sigma^2)$ wenn für die PDF von $X$
gilt:

$$f(x)=\frac{1}{\sqrt{2\pi\sigma^2}}e^{-\frac{(x-\mu)^2}{2\sigma^2}} $$

Unter der **Standard-Normalverteilung** verstehen wir eine Normalverteilung mit
den Paramtern $\mu=0$ und $\sigma=1$.^[Viele Tabellen mit bestimmten Kennzahlen
der Normalverteilung beziehen sich auf die Standard-Normalverteilung. Wenn man
diese Werte verwenden will, muss man die tatsächlich verwendete Stichprobe ggf.
erst [z-transformieren](https://de.wikipedia.org/wiki/Standardisierung_(Statistik)). 
Unter letzterem versteht man die *Normalisierung* einer ZV sodass sie den
Erwartungswert 0 und die Varianz 1 besitzt. Dies geht i.d.R. für jede ZV $X$ recht
einfach über die Formel $Z=\frac{X-\mu}{\sigma}$, wobei $Z$ die standartisierte ZV,
$\mu$ den Erwartungswert und $\sigma$ die Standardabweichung von $X$ bezeichnet]
Sie verfügt über die deutlich vereinfachte PDF:

$$f(x)=\frac{1}{\sqrt{2\pi}}e^{-\frac{1}{2}x^2}$$

Die CDF der Normalverteilung ist analytisch nicht einfach darzustellen, die
Werte können in R aber leicht über die Funktion `pnorm` (s.u.) abgerufen werden.

Im folgenden sind die PDF und CDF für exemplarische Parameterkombinationen
dargestellt:

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-24-1.png" width="672" style="display: block; margin: auto;" />



Die Abkürzung in R ist `norm`. Alle Funktionen nehmen die Paramter $\mu$ und 
$\sigma$ (nicht $\sigma^2$) über `mean` und `sd` als notwendige Argumente. 
Ansonsten ist die Verwendung äquivalent zu den vorherigen Beispielen:


```r
dnorm(c(0.5, 0.75), mean = 1, sd = 2) # relative Wahrscheinlichkeiten über PDF
```

```
## [1] 0.1933341 0.1979188
```

```r
pnorm(c(0.5, 0.75), mean = 1, sd = 2) # Werte der CDF
```

```
## [1] 0.4012937 0.4502618
```

```r
qnorm(c(0.5, 0.75), mean = 1, sd = 2) # Werte der I-CDF
```

```
## [1] 1.00000 2.34898
```

```r
norm_sample <- rnorm(5, mean = 1, sd = 2) # 5 Realisierungen der ZV
norm_sample
```

```
## [1] -0.9164327 -0.6124527  2.1022381 -4.3706221  0.9370133
```

### Beispiel: die Exponentialverteilung

Sehr häufig wird uns auch die Exponentialverteilung begegnen. Außerhalb der 
Ökonomik wird sie v.a. zur Modellierung von Zerfallsprozessen oder Wartezeiten
verwendet, in der Ökonomik spielt sie in der Wachstumstheorie eine zentrale 
Rolle.
Es handelt sich bei der Exponentialverteilung um eine **ein-paramtrige** 
Verteilung mit Parameter $\lambda \in \mathbb{R}^+$ und mit dem Wertebereich 
$W_X=[0, \infty ]$.

Die PDF der Exponentialverteilung ist:

$$f(x)=\lambda e^{-\lambda x} $$
wobei $e$ die [Eulersche Zahl](https://de.wikipedia.org/wiki/Eulersche_Zahl) ist.
Die CDF ist entsprechend:

$$F(x)=1- e^{-\lambda x} $$

Beide Verteilungen sind im folgenden dargestellt:

<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-26-1.png" width="672" style="display: block; margin: auto;" />

Der Erwartungswert und die Varianz sind für die Exponentialverteilung 
äquivalent und hängen ausschließlich von $\lambda$ ab: 
$\mathbb{E}(X)=\sigma_X=\frac{1}{\lambda}$.

Die Abkürzung in R ist `exp`. Alle Funktionen nehmen den Paramter $\lambda$ über
das Argument `rate` an:


```r
dexp(c(0.5, 0.75), rate = 1) # relative Wahrscheinlichkeiten über PDF
```

```
## [1] 0.6065307 0.4723666
```

```r
pexp(c(0.5, 0.75), rate = 1) # Werte der CDF
```

```
## [1] 0.3934693 0.5276334
```

```r
qexp(c(0.5, 0.75), rate = 1) # Werte der I-CDF
```

```
## [1] 0.6931472 1.3862944
```

```r
exp_sample <- rexp(5, rate = 1) # 5 Realisierungen der ZV
exp_sample
```

```
## [1] 0.6889096 1.3983929 0.1513648 0.4991785 1.0245428
```

Es gibt übrigens einen 
[wichtigen Zusammenhang](https://www.exponentialverteilung.de/vers/beweise/uebergang_poissonverteilung.html) 
zwischen der stetigen Exponential- und der diskreten Poisson-Verteilung.

## Zusammenfassung Wahrscheinlichkeitsmodelle

* Das ist die Theorie und die Population
* Im nächsten Schritt: Beschreibung der Daten
* Dann: wie bekommen wir aus den Daten Infos über zugrundeliegende ZV

Verteilung | Art | Abkürzung | Parameter |
-----------+-----+-----------+-----------|
Binomialverteilung | Diskret | `binom` | `size`, `prob` |
Poisson-Verteilung | Diskret | `pois` | `lambda` |
Uniform-Verteilung | Kontinuierlich | `punif` | `min`, `max` |
Normalverteilung | Kontinuierlich | `norm` | `mean`, `sd` |
Exponential-Verteilung | Kontinuierlich | `exp` | `rate` |

## Deskriptive Statistik

Die Methoden der deskriptiven Statistik helfen uns die Daten, die wir 
erhoben haben möglichst gut zu *beschreiben*.
Die *deskriptive* Statistik grenzt sich von der *induktiven* Statistik davon
ab, dass wir keine Aussagen über unseren Datensatz hinaus treffen wollen:
wenn unser Datensatz also z.B. aus 1000 Schüler*innen besteht treffen wir mit
den Methoden der deskriptiven Statistik nur Aussagen über genau diese 1000
Schüler*innen. 
Mit Methoden der *induktiven* Statistik würden wir versuchen Aussagen über 
Schüler\*innen im Allgemeinen, zumindest über mehr als diese 1000 Schüler\*innen
zu treffen. 
In diesem Abschnitt beschäftigen wir uns zunächst nur mit der deskriptiven 
Statistik.
Das ist konsistent mit dem praktischen Vorgehen: bevor wir irgendwelche Methoden
der induktiven Statistik anwenden müssen wir immer zunächst unsere Daten mit
Hilfe deskriptiver Statistik besser verstehen.

Die am häufigsten verwendeten Kennzahlen der deskriptiven Statistik sind
das **arithmetische Mittel**, die **Standardabweichung** und die **Quantile**.
Für die folgenden Illustrationen nehmen wir an, dass wir es mit einem Datensatz
mit $N$ kontinuiertlichen Beobachtungen $x_1, x_2, ..., x_n$ zu tun haben.
Für die direkte Anwendung in R verwenden wir einen Datensatz zu ökonomischen 
Journalen:


```r
data("Journals", package = "AER")
```


Das **arithmetische Mittel** ist ein klassisches Lagemaß und definiert als:

$$\bar{x}=\frac{1}{N}\sum_{i=1}^Nx_i$$
In R wird das arithmetische Mittel mit der Funktion `mean()` berechnet:


```r
avg_preis <- mean(Journals[["price"]])
avg_preis
```

```
## [1] 417.7222
```
Der durchschnittliche Preis der Journale ist also 417.7222222.

Die **Standardabweichung** ist dagegen ein Maß für die Streuung der Daten
und wird als die Quadratwurzel der *Varianz* definiert:

$$s=\sqrt{Var}=\sqrt{\frac{1}{N-1}\sum_{i=1}^N\left(x-\bar{x}\right)^2}$$

Wir verwenden in R die Funktionen `var()` und `sd()` um Varianz und 
Standardabweichung zu berechnen:


```r
preis_var <- var(Journals[["price"]])
preis_sd <- sd(Journals[["price"]])
cat(paste0(
  "Varianz: ", preis_var, "\n",
  "Standardabweichung: ", preis_sd
))
```

```
## Varianz: 148868.335816263
## Standardabweichung: 385.834596448094
```

Das $\alpha$-**Quantil** eines Datensatzes ist der Wert, bei dem $\alpha\cdot 100\%$
der Datenwerte kleiner und $(1-\alpha)\cdot 100\%$ der Datenwerte kleiner sind.
In R können wir Quantile einfach mit der Funktion `` berechnen.
Diese Funktion akzeptiert als erstes Argument einen Vektor von Daten und als
zweites Argument ein oder mehrere Werte für $\alpha$:


```r
quantile(Journals[["price"]], 0.5)
```

```
## 50% 
## 282
```

```r
quantile(Journals[["price"]], c(0.25, 0.5, 0.75))
```

```
##    25%    50%    75% 
## 134.50 282.00 540.75
```

Diese Werte können folgendermaßen interpretiert werden:
25% der Journale kosten weniger als 134.5 Dollar, 50% der Journale kosten 
weniger als 282 Dollar und 75% kosten weniger als 540.75 Dollar. 
Dabei wird das $0.5$-Quantil auch **Median** genannt.
Wie beim Mittelwert handelt es sich hier um einen Lageparameter, der allerdings
robuster gegenüber Extremwerten ist, da es sich nur auf die Reihung der 
Datenpunkte bezieht, nicht auf ihren numerischen Wert.^[Wenn das teuerste 
Journal sich im Preis verdoppelt erhöht dies den Mittelwert beträchtlich,
ändert den Median aber nicht.]

Wie im Kapitel XXX für `mean()` und `sd()` erklärt, akzeptiert auch die Funktion 
`quantile()` das optionale Argument `na.rm`, mit dem fehlende Werte vor der 
Berechnung eliminiert werden können:


```r
test_daten <- c(1:10, NA)
quantile(test_daten, 0.75)
```

```
## Error in quantile.default(test_daten, 0.75): missing values and NaN's not allowed if 'na.rm' is FALSE
```

```r
quantile(test_daten, 0.75, na.rm = T)
```

```
##  75% 
## 7.75
```

Ein häufig verwendetes Steuungsmaß, das im Gegensatz zu Standardabweichung und
Varianz robust gegen Ausreißer ist, ist die **Quartilsdifferenz**:


```r
quantil_25 <- quantile(Journals[["price"]], 0.25, names = F)
quantil_75 <- quantile(Journals[["price"]], 0.75, names = F)
quant_differenz <- quantil_75 - quantil_25
quant_differenz
```

```
## [1] 406.25
```

Das optionale Argument `names=FALSE` unterdrückt die Benennung der Ergebnisse.
Wenn wir das nicht machen würde, würde `quant_differenz` verwirrenderweise
den Namen `75%` tragen.

Häufig möchten wir wissen wie verschiedene Ausprägungen unserer Daten miteinender
in Beziehung stehen. 

Ko-Varianz


Dazu können wir die **empirische Korrelation** dieser Ausprägunden berechnen.
Wenn wir annahmen, dass die Ausprägungen mit $x_1,..., x_n$ und 
$y_1,...,y_n$ bezeichnet werden gilt für den **Pearson-Korrelationskoeffizienten**:

$$\rho=\frac{s_{xy}}{s_xs_y}$$
wobei $s_{xy}$ die Kovarianz der Ausprägungen $x$ und $y$ und $s_x$ und $s_y$
deren Standardabweichung bezeichnet.

In unserem Datensatz haben wir z.B. Informationen über die Seitenzahl 
(Spalte `pages`) und den Preis von Journalen (Spalte `price`). 
Wir könnten uns nun fragen, ob dickere Journale teurer sind. 
Dazu können wir, wenn wir uns nur für den linearen Zusammenhang interessieren,
den Pearson-Korrelationskoeffizienten mit der Funktion `cor()` berechnen:


```r
cor(Journals[["price"]], Journals[["pages"]], method = "pearson")
```

```
## [1] 0.4937243
```

Über das Argument `method` können auch andere Korrelationsmaße berechnet werden:
der 
[Spearman-Korrelationskoeffizient](https://de.wikipedia.org/wiki/Rangkorrelationskoeffizient#Spearman'scher_Rangkorrelationskoeffizient)
oder der 
[Kendall-Korrelationskoeffizient](https://de.wikipedia.org/wiki/Rangkorrelationskoeffizient#Kendall'sches_Tau)
sind beides Maße, die nur die Ränge der Ausprägungen und nicht deren 
numerische Werte berücksichtigen.
Dies macht sie immun gegen Ausreißer und wir müssen keine Annahme über die
Art der Korrelation machen wie beim Pearson-Korrelationskoeffizient, der nur 
lineare Zusammenhänge quantifiziert.
Gleichzeitig gehen uns natürlich auch viele Informationen verloren.
Das richtige Maß ist wie immer kontextabhängig und muss entsprechend theoretisch
begründet werden.

Darüber hinaus erlaubt die Funktion `cor()` über das Argument `use` noch den
Umgang mit fehlenden Werten genauer zu spezifizieren. 

In jedem Fall ist bei der Interpretation von Korrelationen Vorsicht angebracht:
da der Korrelationskoeffizient nur die Stärke des *linearen* Zusammenhangs misst,
können dem gleichen Korrelationskoeffizienten sehr unterschiedliche nicht-lineare
Zusammenhänge zugrunde liegen:


<img src="ChapA-WdhlStatistik1_files/figure-html/unnamed-chunk-37-1.png" width="672" style="display: block; margin: auto;" />

Daher ist es immer wichtig die Daten auch visuell zu inspizieren. 
Datenvisualisierung ist aber so wichtig, dass sie in einem eigenen Kapitel 
behandelt wird.



Die folgende Tabelle gibt eine Zusammenfassung:

| Maßzahl | Formel | Funktion | 
|---------+--------+----------|
Mittelwert |
Varianz |
Standardabweichung |
$\alpha$-Quantil |
Median |

## Zusammenhang zwischen Statistik und Stochastik

* In der Statistik interpretieren wir Daten als die Realisierung von ZV
* Den tatsächlichen *data generating process* (DGP), also die ZV, welche die 
Daten, die wir beobachten, generiert haben, kennen wir nicht
* Wir versuchen aber durch die Anwendung statistischer Methoden Rückschlüsse
auf diese ZV zu schließen
* Da wir ZV als Zufallsexperimente beschreiben gibt es wichtige Analogien
zwischen den deskriptiven Statistiken, die wir kennen gelernt haben um Daten zu
beschreiben, und den Eigenschaften empirischer Verteilungen
* In der Regel nehmen wir für unsere Daten einen bestimmten Zufallsprozess, also
eine oder mehrere ZV an, und versuchen deren Parameter dann auf Basis unserer 
Daten zu schätzen
* Häufig spricht man davon, dass theoretische stochastische Modelle *Populationen*
und die deskriptive Statistik *Daten*, die aus der Population gezogen wurden, 
beschreiben, und wir über statistische Methoden durch die Betrachtung von
Daten Rückschlüsse auf die Population schließen wollen
* Je mehr Daten wir haben, desto besser funktioniert das
* Pendants Theorie und Stichprobe
