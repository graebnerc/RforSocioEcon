# Wiederholung: Wahrscheinlichkeitstheorie {#stat-stoch}

In diesem Kapitel werden Grundlagen der Wahrscheinlichkeitstheorie wiederholt. 
Die zentralen Themen sind dabei:

* Der Zusammenhang zwischen Wahrscheinlichkeitstheorie und Statistik
* Grundbegriffe der Wahrscheinlichkeitstheorie und Statistik
* Zufallsvariablen
* Diskrete und stetige Verteilungen

Grundkonzepte der deskriptiven und schließenden Statistik (insb. Parameterschätzung, Hypothesentests
und die Berechnung von Konfidenzintervallen) werden in den beiden 
Anhängen [zur deskriptiven](#desk-stat) und 
[schließenden Statistik](#stat-rep) wiederholt.

## Verwendete Pakete {-}


```r
library(here)
library(tidyverse)
library(ggpubr)
library(latex2exp)
library(icaeDesign)
library(data.table)
```

## Einleitung: Wahrscheinlichkeitstheorie und Statistik

Statistik und Wahrscheinlichkeitstheorie sind untrennbar miteinander verbunden.
In der Wahrscheinlichkeitstheorie beschäftigt man sich mit Modellen von 
Zufallsprozessen, also Prozessen, deren Ausgang nicht exakt vorhersehbar ist.
Häufig spricht man von *Zufallsexperimenten*.

Die Wahrscheinlichkeitstheorie entwickelt dabei Modelle, welche diese 
Zufallsexperimenten und deren mögliche Ausgänge beschreiben und dabei den 
möglichen Ausgängen Wahrscheinlichkeiten zuordnern. 
Diese Modelle werden *Wahrscheinlichkeitsmodelle* genannt.

In der Statistik versuchen wir anhand von beobachteten Daten herauszufinden,
welches Wahrscheinlichkeitsmodell gut geeignet ist, den die Daten generierenden
Prozess (*data generating process* - DGP) zu beschreiben. 
Das ist der Grund warum man für Statistik auch immer Kenntnisse der 
Wahrscheinlichkeitstheorie braucht.

> Kurz gesagt: in der Wahrscheinlichkeitstheorie wollen wir mit Hilfe von 
Wahrscheinlichkeitsmodellen Daten vorhersagen, in der Statistik mit Hilfe 
bekannter Daten Rückschlüsse auf die zugrundeliegenden Wahrscheinlichkeitsmodelle
ziehen.

## Grundbegriffe der Wahrscheinlichkeitstheorie

Ein wahrscheinlichkeitstheoretisches Modell besteht *immer* aus den folgenden drei 
Komponenten: 

**Ergebnisraum**: diese Menge $\Omega$ enthält alle möglichen Ergebnisse des 
modellierten Zufallsexperiments. 
Das einzelne Ergebnis bezeichnen wir mit $\omega$.

> **Beispiel:** Handelt es sich bei dem Zufallsexperiment um das Werfen eines
normalen sechseitigen Würfels gilt $\Omega=\{1,2,3,4,5,6\}$. Wenn der Würfen
gefallen ist, bezeichnen wir die oben liegende Zahl als das Ergebnis $\omega$ des 
Würfelwurfs, wobei hier gilt $\omega_1=$ "Der Würfel zeigt 1", u.s.w.

**Ereignisse:** unter Ereignissen $A, B, C,...$ verstehen wir die Teilmengen
des Ergebnisraums. Ein Ereignis enthält ein oder mehrere Elemente des Ergebnisraums.
Enthält ein Ereignis genau ein Element, sprechen wir von einem *Elementarereignis*.

> **Beispiel:** "Es wird eine gerade Zahl gewürfelt" ist ein mögliches Ereignis
im oben beschriebenen Zufallsexperiment. Das Ereignis - nennen wir es hier $A$ - 
tritt ein, wenn ein Würfelwurf mit dem Ergebnis "2", "4" oder "6" endet. Also: 
$A=\{\omega_2, \omega_4, \omega_6\}$
Das Ereignis $B$ "Es wird eine 2 gewürfelt" tritt nur ein, wenn das Ergebnis des
Würfelwurfs eine 2 ist: $B=\{\omega_2\}$. 
Entsprechend nennen wir es ein *Elementarereignis*.

Da es sich bei Ereignissen um Mengen handelt können wir die typischen
mengentheoretischen Konzepte wie 'Vereinigung', 'Differenz' oder 'Komplement' zu
ihrer Beschreibung verwenden:

Konzept | Symbol | Übersetzung |
--------+--------+-------------|
Schnittmenge | $A\cap B$ | $A$ und $B$|
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
Die Grundidee ist aber, bestimmten Ereignissen von Anfang an bestimmte Wahrscheinlichkeiten 
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
**stetiges Wahrscheinlichkeitsmodell**.
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
Würfen und den Ereignissen besteht.
Es gilt: 
$\mathbb{P}(C\cap D)=\mathbb{P}(\{2, 4\})=\frac{1}{36}$.
Würden wir die Wahrscheinlichkeiten einfach multiplizieren erhielten wir
allerdings $\mathbb{P}(C)\cdot \mathbb{P}(D)=\frac{5}{36}\cdot\frac{1}{6}=\frac{5}{216}$,
wobei $\mathbb{P}(C)=\frac{5}{36}$.

Ein weiteres wichtiges Konzept ist das der **bedingten Wahrscheinlichkeit**:
die bedingten Wahrscheinlichkeit von $A$ gegeben $B$, $\mathbb{P}(A|B)$, 
bezeichnet die Wahrscheindlichkeit für $A$, wenn wir wissen, dass $B$ 
bereits eingetreten ist.

Es gilt dabei:^[An der Formel wird noch einmal deutlich, dass wenn $A$ und $B$
stochastisch unabhängig sind wir nichts von $B$ über $A$ und umgekehrt lernen
können, also gilt: $\mathbb{P}(A|B)=\mathbb{P}(A)$ und 
$\mathbb{P}(B|A)=\mathbb{P}(B)$.]

$$\mathbb{P}(A|B)=\frac{\mathbb{P}(A\cap B)}{\mathbb{P}(B)}$$

> **Beispiel:** Sei $A$: "Der Würfel zeigt eine 6" und $B$: 
"Der Würfelwurf zeigt eine gerade Zahl". Wenn wir bereits wissen, dass $B$ 
eingetreten ist, ist $\mathbb{P}(A)$ nicht mehr $\frac{1}{6}$, weil wir ja 
wissen, dass 1, 3 und 5 nicht auftreten können. 
Vielmehr gilt $\mathbb{P}(A|B)=\frac{1/6}{1/2}=\frac{1}{3}$.

### Bayes Theorem und Gesetz der total Wahrscheinlichkeiten

Ganz wichtig: es gilt *nicht notwendigerweise* $\mathbb{P}(A|B)=\mathbb{P}(B|A)$.
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

Bei Zufallsvariablen (ZV) handelt es sich um besondere *Funktionen*. 
Die Definitionsmenge einer Zufallsvariable ist immer der zurgundeliegende
Ergebnisraum $\Omega$, die Zielmenge ist i.d.R. $\mathbb{R}$, sodass gilt:

$$X:\Omega\rightarrow\mathbb{R}, \omega \mapsto X(\omega)$$

Im Kontext von ZV sprechen wir häufig nicht von dem zugrundeliegenden 
Ergebnisraum $\Omega$, sondern - inhaltlich äquivalent - vom *Wertebereich von X*,
bezeichnet als $W_X$.

In der Regel bezeichnen wir Zufallsvariablen (ZV) mit Großbuchstaben und die
konkrete Realisation einer ZV mit einem Kleinbuchstaben, sodass 
$\mathbb{P}(X=x)$ die Wahrscheinlichkeit angibt, dass die ZV $X$ den konkreten
Wert $x$ annimmt. Bei $x$ sprechen wir von einer *Realisierung* der ZV $X$.
Wir nehmen für die weitere Notation an, dass $W_X=\{x_1, x_2,...,x_K\}$ und 
bezeichnen das einzelne Element mit $x_k$ mit $1\leq k\leq K$.

Dies bedeutet streng genommen, dass die ZV selbst nicht als zufällig definiert wird. 
Zufällig ist nur der Input $\omega$ der entsprechenden Funktion 
$X: \Omega\rightarrow X(\omega)$, also z.B. ein Würfelwurf. 
Der funktionale Zusammenhang zwischen Funktionswert $X(\omega)$ 
und dem Input $\omega$ ist hingegen eindeutig.

Das bedeutet streng genommen, dass die ZV nicht *selbst* zufällig ist, sondern
ihr Input $\omega$. 
Das impliziert, dass wenn ein Zufallsexperiment zweimal das 
gleiche Ergebnis $\omega$ hat, ist auch der Wert $X(\omega)$ der gleiche.

Das mag im Moment ein wenig nach 'Pfennigfuchserei' aussehen, die Unterscheidung
zwischen dem nicht-zufälligem funtionalen Zusammenhangs, aber einem zufälligen
Input bei ZV ist wichtig, um den Sinn in vielen fortgeschrittenen Beiträgen im 
Bereich der Ökonometrie zu sehen.

Den unterschiedlichen Realisierungen von einer ZV haben jeweils Wahrscheinlichkeiten, 
die von den Wahrscheinlichkeiten der zugrundeliegenden Ergebnisse des 
modellierten Zufallsexperiments abhängen.

Produkte und Summen von ZV sind selbst wieder Zufallsvariables.
Man addiert bzw. multipliziert ZV indem man ihre Werte addiert bzw. mutlipliziert.

Im Falle von diskreten ZV können wir eine Liste erstellen, die für alle möglichen
Werte $x_k\in W_X$ die jeweilige Wahrscheinlichkeit $\mathbb{P}(X=x_k)$ angibt.^[Aus den 
*Kolmogorow Axiomen* oben ergibt sich, dass die Summe all dieser
Wahrscheinlichkeiten 1 ergeben muss: $\sum_{k\geq 1}\mathbb{P}(X=x_k)=1$.] 
Diese Liste nennen wir 
**Wahrscheinlichkeitsverteilung** (*Probability Mass Function*, PMF) von $X$
und sie werden häufig visuell dargestellen.
Um diese Liste zu erstellen verwenden wir die zu $X$ gehörende 
**Wahrscheinlichkeitsfunktion**, ($p(x_k)$),die uns für jedes Ergebnis die zugehörige 
Wahrscheinlichkeit gibt:^[Zu jeder Wahrscheinlichkeitsverteilung gibt es eine 
eindeutige Wahrscheinlichkeitsfunktion und jede Wahrscheinlichkeitsfunktion 
definiert umgekehrt eine eindeutig bestimmte diskrete 
Wahrscheinlichkeitsverteilung. ]

$$p(x_k)=\mathbb{P}(X=x_k)$$

Wenn wir eine ZV analysieren tun wir dies in der Regel durch eine Analyse ihrer
Wahrscheinlichkeitsverteilung. 
Zur genaueren Beschreibung einer ZV wird entsprechend häufig einfach die 
Wahrscheinlichkeitsfunktion angegeben.

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
$\mathbb{E}(x)$ als *Lageparameter* und die **Standardabweichung** 
$\sigma(X)$ als *Streuungsmaß*.

Der Erwartungswert ist definitert als die nach ihrer Wahrscheinlichkeit 
gewichtete Summe aller Elemente im Wertebereich von $X$ und gibt damit die
mittlere Lage der Wahrscheinlichkeitsverteilung an. 
Wenn $W_X$ der Wertebereich von $X$ ist, dann gilt:

$$\mathbb{E}(x)=\mu_X=\sum_{x_k\in W_X}p(x_k)x_k$$

> Beispiel: Der Erwartungswert einer ZV $X$, die das Werfen eines fairen 
Würfels beschreibt ist: $\mathbb{E}(X)=\sum_{k=1}^6k\cdot\frac{1}{6}=3.5$.

Wie wir [später](#stat-re) sehen werden, wird der Erwartungswert in der empirischen
Praxis häufig über den Mittelwert einer Stichprobe identifiziert.

Ein gängiges Maß für die Streuung einer Verteilung $X$ ist die Varianz $Var(X)$
oder ihre Quadratwurzel, die Standardabweichung, $\sigma(X)=\sqrt{Var(X)}$. 
Letztere wird häufiger verwendet, weil sie die gleiche Einheit hat wie $X$:

$$Var(X)=\sum_{x_k\in W_X}\left[x_k-\mathbb{E}(X)\right]^2 p(x_k)$$

> Beispiel: Die Standardabweichung einer ZV $X$, die das Werfen eines fairen 
Würfels beschreibt ist: $\sigma_X=\sqrt{\sum_{k}^6\left[x_k-\mathbb{E}(X)\right]^2 p(x_k)}=\sqrt{5.83}\approx 2.414$.

Im folgenden wollen wir uns einige der am häufigsten verwendeten ZV und ihre
Verteilungen genauer ansehen. 
Am Ende der Beschreibung jeder Funktion folgt ein Beispiel für eine 
Anwendung.
Wenn Ihnen die theoretischen Ausführungen am Anfang etwas kryptisch erscheinen,
empfiehlt es sich vielleicht erst einmal das Anwendungsbeispiel anzusehen.

### Beispiel: die Binomial-Verteilung

Die vielleicht bekannteste diskrete Wahrscheinlichkeitsverteilung ist die
Binomialverteilung $\mathcal{B}(n,p)$.
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
Daher auch die Kurzschreibweise $\mathcal{B}(n,p)$.

> **Beispiel:** Wenn wir eine faire Münze zehn Mal werfen, können wir das 
mit einer Binomialverteilung mit $p=0.5$ und $n=10$ modellieren.

Die *Wahrscheinlichkeitsfunktion* $p(x)$ der Binomialverteilung ist die folgende,
wobei $x$ die Anzahl der Erfolge darstellt:

$$\mathbb{P}(X=x)=p(x)=\binom{n}{x}p^x(1-p)^{n-x}$$
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


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-2-1} \end{center}


R stellt uns einige nützliche Funktionen bereit, mit denen wir typische 
Rechenaufgaben einfach lösen können: 

Möchten wir die Wahrscheinlichkeit berechnen, genau $x$ Erfolge zu
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


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-4-1} \end{center}

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


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-7-1} \end{center}

Schlussendlich haben wir die Funktion `qbinom()`, welche als ersten Input eine
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


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-9-1} \end{center}

Möchten wir schließlich eine bestimmte Menge an **Realisierungen** aus einer
Binomialverteilung ziehen geht das mit `rbinom()`, welches drei Argumente 
verlangt: `n` für die Anzahl der zu ziehenden Realisierungen, sowie `size` und
`prob` als da Paramter $n$ und $p$ der Binomialverteilung:


```r
sample_binom <- rbinom(n = 5, size = 10, prob = 0.4)
sample_binom
```

```
## [1] 2 2 3 5 3
```

> **Anwendungsbeispiel Binomialverteilung:** Unser Zufallsexperiment besteht
aus dem zehnmaligen Werfen einer fairen Münze. Unter 'Erfolg' verstehen wir
das Werfen von 'Zahl'. Nehmen wir an, wir führen das Zufallsexperiment 100 Mal durch,
werfen also insgesamt 10 Mal die Münze und schreiben jeweils auf, wie häufig wir
dabei einen Erfolg verbuchen konnten. Wenn wir unsere Ergebnisse aufmalen, indem
wir auf der x-Achse die Anzahl der Erfolge, und auf der y-Achse die Anzahl der
Experimente mit genau dieser Anzahl an Erfolgen aufmalen erhalten wir ein 
Histogram, das ungefähr so aussieht:

![](ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-11-1.pdf)<!-- --> 
> Aus der Logik der Konstruktion des Zufallsexperiments und der Inspektion 
unserer Daten können wir schließen, dass die Binomialverteilung eine sinnvolle
Beschreibung des Zufallsexperiments und der daraus entstandenen Stichprobe von
100 Münzwurfergebnissen ist. Da wir eine faire M+nze geworfen haben macht es 
Sinn für die Binomialverteilung $p=0.5$ anzunehmen, und da wir in jedem einzelnen
Experiment die Münze 10 Mal geworfen haben für $n=10$. Wenn wir die mit $=10$ und
$p=0.5$ parametrisierte theoretische Binomialverteilung nehmen und ihre theoretische
Verteilungsfunktion über die Aufzeichnungen unserer Ergebnisse legen, können wir 
uns in dieser Vermutung bestärkt führen:


```r
ggplot(data.frame(x=munzwurfe), aes(x=x)) +
  #geom_histogram(bins = wurzanzahl) +
  geom_point(data=data.frame(table(munzwurfe)), 
             aes(x=munzwurfe, y=Freq)) +
  geom_point(data = data.frame(x=seq(0, max(munzwurfe), 1), 
                               y=dbinom(seq(0, max(munzwurfe), 1), prob = p_zahl, 
                                        size = wurfe_pro_experiment)*wurzanzahl), 
             aes(x=x, y=y)
             ) +
    geom_line(data = data.frame(x=seq(0, max(munzwurfe), 1), 
                               y=dbinom(seq(0, max(munzwurfe), 1), prob = p_zahl, 
                                        size = wurfe_pro_experiment)*wurzanzahl), 
             aes(x=x, y=y, color="Theoretische Verteilung"), alpha=0.5, lwd=1
             ) +
  scale_y_continuous(expand = expand_scale(c(0,0), c(0,1))) +
  #scale_color_manual(values=c("blue", "red"), name=c("Theoretische Verteilung", "Empirische Verteilung")) +
  theme_icae() + theme(legend.position = "bottom")
```

![](ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-12-1.pdf)<!-- --> 


### Beispiel: die Poisson-Verteilung

Bei der Poisson-Verteilung handelt es sich um die Standardverteilung für 
unbeschränkte Zähldaten, also diskrete Daten, die kein natürliches Maximum 
haben.

Bei der Poisson-Verteilung handelt es sich um eine **ein-parametrische** 
Funktion, deren einziger Parameter $\lambda>0$ ist.
$\lambda$ wird häufig als die mittlere Ereignishäufigkeit interpretiert und
ist **zugleich Erwartungswert als auch Varianz** der
Verteilung: $\mathbb{E}(P_\lambda)=Var(P_\lambda)=\lambda$.

Ihre Definitionsmenge ist $\mathbb{N}$, also alle natürlichen Zahlen - 
daher ist sie im Gegensatz zur Binomialverteilung geeignet, wenn die 
Definitionsmenge der Verteilung keine natürliche Grenze hat.

Die **Wahrscheinlichkeitsfunktion** der Poisson-Verteilung hat die folgende
Form:

$$P_\lambda(x)=\frac{\lambda^x}{x!}e^{-\lambda}$$
Die folgende Abbildung zeigt wie sich die Wahrscheinlichkeitsfunktion für
unterschiedliche Werte von $\lambda$ manifestiert:


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-13-1} \end{center}

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


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-15-1} \end{center}

Informationen über die CDF erhalten wir über die Funktion `ppois()`, die zwei
Argumente, `q` und `lambda`, annimmt.



\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-16-1} \end{center}

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


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-18-1} \end{center}

Möchten wir schließlich eine bestimmte Menge an **Realisierungen** der ZV aus einer
Poisson-Verteilung ziehen geht das mit `rpois()`, welches zwei notwendige
Argumente annimmt: `n` für die Anzahl der Realisierungen und `lambda` für den
Parameter $\lambda$:


```r
pois_sample <- rpois(n = 5, lambda = 4)
pois_sample
```

```
## [1] 3 8 4 4 3
```


### Hinweise zu diskreten Wahrscheinlichkeitsverteilungen

Wie Sie vielleicht bereits bemerkt haben sind die R Befehle für 
verschiedene Verteilungen alle gleich aufgebaut. 
Wenn `*` für die Abkürzung einer bestimmten Verteilung steht, können wir mit
der Funktion `d*()` die Werte der Wahrscheinlichkeitsverteilung, mit 
`p*()` die Werte der kumulierten Wahrscheinlichkeitsverteilung und
mit `q*()` die der Quantilsfunktion berechnen
Mit `r*()` werden Realisierungen von Zufallszahlen realisiert.
Für das Beispiel der Binomialverteilung, welcher die Abkürzung `binom`
zugewiesen wurde, heißen die Funktionen entsprechend `dbinom()`, `pbinom()`, 
`qbinom()` und `rbinom()`.

Die folgende Tabelle gibt einen Überblick über gängige Abkürzungen und die 
Parameter der oben besprochenen diskreten Verteilungen.

Verteilung | Abkürzung | Parameter            |
-----------+-----------+----------------------|
Binomialverteilung | `binom` | `size`, `prob` |
Poisson-Verteilung | `pois` | `lambda` |

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
Im Gegensatz zu diskreten Wahrscheinlichkeitsmodellen hat demnach jeder einzelne
Punkt im Wertebereich der ZV die Wahrscheinlichkeit 0:

$$\mathbb{P}(X=x_k)=0 \quad \forall x_k \in W_X$$
wobei $W_X$ für den Wertebereich von ZV $X$ steht

Als Lösung werden Wahrscheinlichkeiten bei stetigen ZV nicht als 
Punktwahrscheinlichkeiten, sondern als Intervallwahrscheinlichkeiten angeben.
Aus $\mathbb{P}(X=x)$ im diskreten Fall wird im stetigen Fall also:

$$\mathbb{P}(a<X\leq b), \quad a<b$$

Bei dieser Funktion sprechen wir von einer  *kumulative Verteilungsfunktion* 
$F(x)=\mathbb{P}(X\leq x)$, wobei immer gilt:

$$\mathbb{P}(a<X\leq b) = F(b)-F(a)$$

Wann immer wir im diskreten Fall eine 
Wahrscheinlichkeitsfunktion verwendet haben um eine ZV zu beschreiben, verwenden
wir im stetigen Fall die  **Dichtefunktion** 
(*probability densitity function* - PDF) einer ZV.
Hierbei handelt es sich um eine integrierbare und nicht-negative Funktion 
$f(x)\geq 0 \forall x\in \mathbb{R}$ mit $\int_{-\infty}^{\infty}f(x)dx=1$
für die gilt: 

$$\mathbb{P}([a,b])=\int_a^bf(x)dx$$

Dementsprechend können wir den Ausdruck für die kumulative Verteilungsfunktion
von oben ergänzen:

$$\mathbb{P}(a<X\leq b) = F(b)-F(a)=\int_a^bf(x)dx$$

Man sieht hier, dass die Dichtefunktion einer ZV die Ableitung ihrer 
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


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-20-1} \end{center}


Abschließend wollen wir nun noch einmal die Definitionen der Kennzahlen und
charakteristischer Verteilungen für den stetigen und diskreten Fall vergleichen:

| Bezeichnung | Diskreter Fall | Stetiger Fall |
|-------------+------------------------------+-----------------------------|
Erwartungswert | $\mathbb{E}(x)=\sum_{x\in W_X}\mathbb{P}(X=x)x$ | $\mathbb{E}(X)=\int_{-\infty}^{\infty}xf(x)dx$ |
Varianz | $Var(X)=\sum_{x\in W_X}\left[x-\mathbb{E}(X)\right]^2 \mathbb{P}(X=x)x$ | $Var(X)= \mathbb{E}(X-\mathbb{E}\left(X)\right)^2$ |
Standard-abweichung | $\sqrt{Var(X)}$ | $\sqrt{Var(X)}$ |
$\alpha$-Quantil | $\mathbb{P}(X\leq q(\alpha))=\alpha$ | $\mathbb{P}(X\leq q(\alpha))=\alpha$|
Dichtefunktion (PDF) | NA | $\mathbb{P}([a,b])=\int_a^bf(x)dx$ |
Wahrsch's-funktion (PMF) | $p(x_k)=\mathbb{P}(X=x_k)$ | NA |
Kumulierte Verteilungsfunktion (CDF) | $\mathbb{P}(X\leq x)$ | $F(x)=\mathbb{P}(X\leq x)$ |

Analog zum diskreten Fall wollen wir uns nun die am häufigsten vorkommenden
stetigen Verteilungen noch einmal genauer anschauen.

### Beispiel: die Uniformverteilung

Die Uniformverteilung kann auch einem beliebigen Intervall $[a,b]$ mit $a<b$
definiert werden und ist dadurch gekennzeichnet, dass die Dichte über $[a,b]$
vollkommen konstant ist.
Ihre einzigen Parameter sind die Grenzen des Intervalls, $a$ und $b$.

Da bei stetigen Verteilungen die Dichte für aller Werte außerhalb des 
Wertebereichs per definitionem gleich Null ist, haben wir folgenden Ausdruck
für die Dichte der Uniformverteilung:

$$f(x)=
\begin{cases} 
      \frac{1}{b-a} & a\leq x \leq b \\
      0 & \text{sonst} \left(x\notin W_X\right)
   \end{cases}
   $$
Auch der Erwartungswert ist dann intuitiv definiert, er liegt nämlich genau in 
der Mitte des Intervalls $[a,b]$.
Er ist definiert als $\mathbb{E}(X)=\frac{a+b}{2}$ 
und ihre Varianz mit $Var(X)=\frac{(b-a)^2}{12}$ gegeben.

Ihre Dichtefunktion für $[a,b]=[2,4]$ ist im folgenden dargestellt:


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-21-1} \end{center}

Die Abkürung in R für die Uniformverteilung ist `unif`. Endsprechend berechnen
wir Werte für die Dichte mit `dunif()`, welches lediglich die Argumente `a` und 
`b` für die Grenzen des Intervalls benötigt:


```r
dunif(seq(2, 3, 0.1), min = 0, max = 4)
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


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-24-1} \end{center}

Auch ansonsten können wir die Syntax der diskreten Verteilungen mehr oder weniger
übernehmen: `qunif()` akzeptiert die gleichen Parameter wie `punif()` und 
gibt uns Werte der inversen CDF. 
`runif()` kann verwendet werden um Realisierungen einer uniform verteilten ZV 
zu generieren:


```r
uniform_sample <- runif(5, min = 0, max = 4)
uniform_sample
```

```
## [1] 3.5209862 1.4563675 1.1529571 0.6825809 0.6886870
```


### Beispiel: die Normalverteilung

Die wahrscheinlich bekannteste stetige Verteilung ist die Normalverteilung.
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

$$f(x)=\frac{1}{\sqrt{2\pi\sigma^2}}e^{-\frac{(x-\mu)^2}{2\sigma^2}}$$

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


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-26-1} \end{center}


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
## [1]  0.9099446 -0.5698089 -2.3358839  0.2395470  2.8379932
```

> **Beispiel zum Zusammenhang** `dnorm()` und `qnorm()` 

### Beispiel: die Exponentialverteilung

Sehr häufig wird uns auch die Exponentialverteilung begegnen. Außerhalb der 
Ökonomik wird sie v.a. zur Modellierung von Zerfallsprozessen oder Wartezeiten
verwendet, in der Ökonomik spielt sie in der Wachstumstheorie eine zentrale 
Rolle.
Es handelt sich bei der Exponentialverteilung um eine **ein-parametrige** 
Verteilung mit Parameter $\lambda \in \mathbb{R}^+$ und mit dem Wertebereich 
$W_X=[0, \infty ]$.

Die PDF der Exponentialverteilung ist:

$$f(x)=\begin{cases}
0 & x < 0\\
\lambda e^{-\lambda x} & x \geq 0
\end{cases}$$

wobei $e$ die [Eulersche Zahl](https://de.wikipedia.org/wiki/Eulersche_Zahl) ist.
Die CDF ist entsprechend:

$$F(x)=\begin{cases}
0 & x < 0\\
1-e^{-\lambda x} & x \geq 0
\end{cases}$$

Beide Verteilungen sind im folgenden dargestellt:


\begin{center}\includegraphics{ChapA-Wahrscheinlichkeitstheorie_files/figure-latex/unnamed-chunk-28-1} \end{center}

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
## [1] 0.8232605 0.4757590 3.4635949 1.2740277 1.0814852
```

Es gibt übrigens einen 
[wichtigen Zusammenhang](https://www.exponentialverteilung.de/vers/beweise/uebergang_poissonverteilung.html) 
zwischen der stetigen Exponential- und der diskreten Poisson-Verteilung.

## Zusammenfassung Wahrscheinlichkeitsmodelle

Die folgende Tabelle fasst noch einmal alle Wahscheinlichkeitsmodelle zusammen, 
die wir bislang betrachtet haben:

Verteilung | Art | Abkürzung | Parameter |
-----------+-----+-----------+-----------|
Binomialverteilung | Diskret | `binom` | `size`, `prob` |
Poisson-Verteilung | Diskret | `pois` | `lambda` |
Uniform-Verteilung | Kontinuierlich | `punif` | `min`, `max` |
Normalverteilung | Kontinuierlich | `norm` | `mean`, `sd` |
Exponential-Verteilung | Kontinuierlich | `exp` | `rate` |

In der statistischen Praxis sind das die Modelle, die wir verwenden, die DGP 
(*data generating processes*) zu beschreiben - also die Prozesse, welche die Daten, 
die wir in unserer Forschung verwenden, generiert haben.

Deswegen sprechen Statistiker\*innen auch häufig von *Populationsmodellen*.
Am besten stellt man es sich mit Hilfe der `r*()` Funktionen vor:
man nimmt an, dass es einen DGP gibt, und unsere Daten der Output der 
`r*()`-Funktion zum Ziehen von Realisierungen sind.
Mit dem Begriff des Populationsmodells macht man dabei deutlich, dass unsere 
Stichprobe nur eine Stichprobe darstellt - und nicht die gesamte Population aller 
möglichen Realisierungen des DGP.

Nun wird auch deutlich, warum Kenntnisse in der Wahrscheinlichkeitsrechnung so 
wichtig sind:
wenn wir statistisch mit Daten arbeiten, dann versuchen wir in der Regel über 
die Daten Rückschlüsse auf den DGP zu schließen.
Dafür müssen wir zunächst einmal eine grobe Struktur für den DGP annehmen, und 
dafür brauchen wir Kenntnisse in der Wahrscheinlichkeitsrechnung und für 
den entsprechenden Anwendungsfall konkrete Vorannahmen.
Dann können wir, gegeben unsere Daten, unsere Beschreibung des DGP verfeinern.

Im Großteil dieses Kurses bedeutet das, dass wir für den DGP ein bestimmtes 
Wahrscheinlichkeitsmodell annehmen und dann auf Basis unserer Daten die Parameter 
für dieses Modell schätzen wollen.
Dieses Vorgehen nennen wir *parametrisch*, weil wir hier vor allem Parameter 
schätzen wollen.^[Die Alternative, *nicht-parametrische* Verfahren, nehmen kein 
konkretes Wahrscheinlichkeitsmodell an, sondern wählen das Modell auch auf Basis 
der Daten.]
