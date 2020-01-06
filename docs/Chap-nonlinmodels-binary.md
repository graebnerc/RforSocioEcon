# Ausgewählte nichtlineare Schätzverfahren {#nonlin}

Eine der zentralsten und gleichzeitig restriktivsten Annahmen des
OLS Modells ist die Annahme eines linearen Zusammenhangs zwischen der 
abhängigen und den unabhängigen Variablen.
Auch wenn wir im letzten Kapitel gesehen haben wie wir manche nicht-lineare
Zusammenhänge durch angemessene Datentransformationen und der Verwendung 
cleverer funktionaler Formen mit OLS konsistent schätzen können bleiben
zahlreiche interessante Zusammenhänge außen vor.

In diesem Kapitel werden wir uns beispielhaft mit dem Fall beschäftigen, in 
dem unsere abhängige Variable binär ist.
Ein typisches Beispiel ist die Analyse von Arbeitslosigkeit.
Stellen wir uns vor wir möchten untersuchen unter welchen Umständen Menschen
arbeitslos werden. 
Unsere abhängige Variable $\boldsymbol{y}$ ist dabei eine binäre Varianble, die
entweder den Wert $0$ annimmt wenn eine Person nicht arbeitslos ist oder den
Wert $1$ annimmt wenn eine Person arbeitslos ist.
Unsere Matrix $\boldsymbol{X}$ enthält dann Informationen über Variablen, die
die Arbeitslosigkeit beeinfluss könnten, z.B. Ausbildungsniveau oder Alter.
Wir möchten untersuchen wie Variation in den erklärenden Variablen die 
Wahrscheinlichkeit bestimmt, dass jemand arbeitslos ist, also 
$\mathbb{P}(\boldsymbol{y}=\boldsymbol{1} | \boldsymbol{X})$.

Dieser Zusammenhang kann unmöglich als linear aufgefasst werden:
es ist unmöglich, dass $y<0$ oder $y>1$ und der Zusammenhang im Intervall 
$[0,1]$ ist quasi nie linear.
Daher ist der herkömmliche OLS Schätzer für solche Fälle ungeeignet, denn A1 ist
klar verletzt. 
In diesem Kapitel lernen wir dabei logit- und probit-Modelle als alternative
Schätzverfahren kennen.

Dabei werden die folgenden Pakete verwendet:


```r
library(tidyverse)
library(data.table)
library(here)
library(icaeDesign)
```


## Binäre abhängige Variablen: Logit- und Probit-Modelle {#logit}

Das folgende Beispiel verwendet angepasste Daten aus @AER zur 
Beschäftigunssituation von Frauen aus der Schweiz:




```r
schweiz_al <- fread(here("data/tidy/nonlinmodels_schweizer-arbeit.csv"), 
                    colClasses = c("double", rep("double", 5), "factor"))
head(schweiz_al)
```

```
##    Arbeitslos Einkommen_log Alter Ausbildung_Jahre Kinder_jung Kinder_alt
## 1:          1      10.78750    30                8           1          1
## 2:          0      10.52425    45                8           0          1
## 3:          1      10.96858    46                9           0          0
## 4:          1      11.10500    31               11           2          0
## 5:          1      11.10847    44               12           0          2
## 6:          0      11.02825    42               12           0          1
##    Auslaender
## 1:          0
## 2:          0
## 3:          0
## 4:          0
## 5:          0
## 6:          0
```

Wir sind interessiert welchen Einfluss die erklärenden Variablen auf die
Wahrscheinlichkeit haben, dass eine Frau Arbeitslos ist, also die Variable
`Arbeitslos` den Wert `1` annimmt.

### Warum nicht OLS?

Wir könnten natürlich zunächst einmal unser bekanntes und geliebtes OLS Modell
verwenden um den Zusammenhang zu schätzen.
Um die Probleme zu illustrieren schätzen wir einmal nur den bivariaten
Zusammenhang zwischen `Arbeitslos` und `Einkommen_log`:


```r
ggplot(
  data = schweiz_al,
  mapping = aes(x=Einkommen_log, y=Arbeitslos, group=1)) +
  scale_x_continuous(limits = c(7, 14)) +
  ylab("Arbeitslosigkeit") + xlab("Arbeitsunabh. Einkommen (log)") +
  geom_point() + geom_smooth(method = "lm", fullrange=TRUE) + theme_icae()
```

![](Chap-nonlinmodels-binary_files/figure-latex/unnamed-chunk-4-1.pdf)<!-- --> 

Unser Modell würde für bestimmte Levels an arbeitsunabhängigem Einkommen
Werte außerhalb des Intervalls $0, 1$ vorhersagen - also Werte, die $y$ gar nicht
annehmen kann und die, da wir die Werte für $y$ später als Wahrscheinlichkeiten
interpretieren wollen, auch gar keinen Sinn ergeben wollen. 

Unser Ziel ist da eher ein funktionaler Zusammenhang wie in folgender 
Abbildung zu sehen:


```r
ggplot(
  data = schweiz_al,
  mapping = aes(x=Einkommen_log, y=Arbeitslos, group=1)) +
  scale_x_continuous(limits = c(7, 14)) +
  ylab("Arbeitslosigkeit") + xlab("Arbeitsunabh. Einkommen (log)") +
  geom_point() + geom_smooth(aes(y=Arbeitslos), method = "glm",
                             method.args = list(family = "binomial"), 
                             fullrange=TRUE, se = TRUE) + theme_icae()
```

![](Chap-nonlinmodels-binary_files/figure-latex/unnamed-chunk-5-1.pdf)<!-- --> 

Dieser Zusammenhang ist jedoch nicht linear und damit inkonsisten mit A1 des
OLS Modells. 

### Logit und Probit: theoretische Grundidee

Wir sind interessiert an $\mathbb{P}(y=1|\boldsymbol{x})$, also der 
Wahrscheinlichkeit, dass $y$ den Wert $1$ annimmt, gegeben die unabhängigen 
Variablen $\boldsymbol{x}$.

Eine Möglichkeit $\mathbb{P}(y=1|\boldsymbol{x})$ auf das Intervall $[0,1]$ zu 
beschränken ist folgende Transformation:

$$\mathbb{P}(y=1|\boldsymbol{x})=\frac{\exp(\boldsymbol{X\beta})}{1+\exp(\boldsymbol{X\beta})}$$
Diesen Ausdruck können wir dann folgendermaßen umformen:

$$\frac{\mathbb{P}(y=1|\boldsymbol{x})}{1-\mathbb{P}(y=1|\boldsymbol{x})}=\frac{\frac{\exp(\boldsymbol{X\beta})}{1+\exp(\boldsymbol{X\beta})}}{1-\frac{\exp(\boldsymbol{X\beta})}{1+\exp(\boldsymbol{X\beta})}}$$
Hier haben wir nun die so genannten *odds*: 
das Verhältnist dass $\mathbb{P}(y=1|\boldsymbol{x})$ und 
$\mathbb{P}(y\neq0|\boldsymbol{x})$.
Wir multiplizieren nun den linken Teil der Gleichung mit 
$1=\frac{\exp(\boldsymbol{X\beta})}{\exp(\boldsymbol{X\beta})}$ um den 
Zähler durch Kürzen zu vereinfachen:

\begin{align}
\frac{\mathbb{P}(y=1|\boldsymbol{x})}{1-\mathbb{P}(y=1|\boldsymbol{x})} &=
\frac{\exp(\boldsymbol{X\beta})}{\exp(\boldsymbol{X\beta})\cdot
\left(\frac{1+\exp(\boldsymbol{X\beta}}{1+\exp(\boldsymbol{X\beta}}-
\frac{\exp(\boldsymbol{X\beta})}{1+\exp(\boldsymbol{X\beta})}\right)}\nonumber\\
&=
\frac{\exp(\boldsymbol{X\beta})}{\left(1+\exp(\boldsymbol{X\beta})\right)\cdot
\frac{1}{1+\exp(\boldsymbol{X\beta})}}\nonumber\\
&=\exp(\boldsymbol{X\beta})
\end{align}

Nun können wir durch logarithmieren eine brauchbare Schätzgleichung herleiten:

\begin{align}
\ln\left(\frac{\mathbb{P}(y=1|\boldsymbol{x})}{1-\mathbb{P}(y=1|\boldsymbol{x})}\right) 
&= \ln\left(\exp(\boldsymbol{X\beta})\right)\nonumber\\ 
\ln\left(\frac{\mathbb{P}(y=1|\boldsymbol{x})}{1-\mathbb{P}(y=1|\boldsymbol{x})}\right)  
&= \boldsymbol{X\beta}
\end{align}

Wir sprechen hier von dem so genannten *logit* Modell, da wir hier auf der 
linken Seite den *Logarithmus* der *Odds* haben.
Diesen Zusammenhang können wir nun auch ohne Probleme mit unserem OLS-Schätzer
schätzen, denn hier haben wir einen klaren linearen Zusammenhang.
Nur die anhängige Variable ist auf den ersten Blick ein wenig merkwürdig:
der logarithmus der *Odds* des interessierenden Events.
Aber das ist kein unlösbares Problem wie wir später sehen werden.

*probit* Modelle funktionieren auf eine sehr ähnliche Art und Weise, verwenden
aber eine andere Transformation über die kumulierte Wahrscheinlichkeitsverteilung
der Normalverteilung.
Hier wird im Endeffekt folgende Regressionsgleichung geschätzt:

$$\mathbb{P}(y=1|\boldsymbol{x})=\phi(\boldsymbol{X\beta})$$

wobei $\Phi(\cdot)$ die CDF der Normalverteilung ist. 
Wie sie in folgender Abbildung sehen, die sich wieder auf das 
Einführungsbeispiel bezieht, sind die funktionalen Formen bei der 
beiden Modelle sehr ähnlich:

![](Chap-nonlinmodels-binary_files/figure-latex/unnamed-chunk-6-1.pdf)<!-- --> 


Wir werden der Einfachheit halber im folgenden in der Regel das 
*logit* Modell verwenden, aber die Implementierung in R ist wirklich sehr ähnlich.

### Logit und Probit: Implementierung in R

Da *logit* und *probit* Modell zu den so genannten *generalisierten Modellen* 
gehören verwenden wir die Funktion `glm` um die Modelle zu schätzen. 
Die Spezifikation ist dabei sehr ähnlich zu den linearen Modellen, die wir 
mit `lm()` geschätzt haben.

Nehmen wir einmal an wir wollen mit unserem Datensatz von Schweizerinnen
die Effekt von Alter und arbeitsunabhänigem Einkommen auf die Wahrscheinlichkeit
der Arbeitslosigkeit schätzen.

Als erstes Argument `formula` übergeben wir wieder die Schätzgleichung.
In unserem Falle wäre das also `Arbeitslos ~ Alter + Einkommen_log`.

Als zweites Argument (`family`) müssen wir die Schätzart spezifizieren.
Für *logit* Modelle schreiben wir `family = binomial(link = "logit")`, für
*probit* Modelle entsprechend `family = binomial(link = "probit")`.

Das letzte Argument ist dann `data`.
Insgesamt erhalten wir also für das *logit*-Modell:


```r
arbeitslogit_test <- glm(
  Arbeitslos ~ Einkommen_log + Alter, 
  family = binomial(link = "logit"), 
  data = schweiz_al)
```

Und das *probit*-Modell:


```r
arbeitsprobit_test <- glm(
  Arbeitslos ~ Einkommen_log + Alter, 
  family = binomial(link = "probit"), 
  data = schweiz_al)
```

Für die Schätzergebnisse können wir wie bilang die Funktion `summary()` 
verwenden:


```r
summary(arbeitslogit_test)
```

```
## 
## Call:
## glm(formula = Arbeitslos ~ Einkommen_log + Alter, family = binomial(link = "logit"), 
##     data = schweiz_al)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -1.7448  -1.1855   0.8128   1.1017   1.8279  
## 
## Coefficients:
##                 Estimate Std. Error z value Pr(>|z|)    
## (Intercept)   -10.381739   2.003223  -5.183 2.19e-07 ***
## Einkommen_log   0.920045   0.185414   4.962 6.97e-07 ***
## Alter           0.018013   0.006612   2.724  0.00645 ** 
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 1203.2  on 871  degrees of freedom
## Residual deviance: 1168.5  on 869  degrees of freedom
## AIC: 1174.5
## 
## Number of Fisher Scoring iterations: 4
```

Aber wie sollen wir das interpretieren?
Da das ein wenig schwieriger ist beschäftigen wir uns damit im nächsten 
Abschnitt.

### Logit und Probit: Interpretation der Ergebnisse

Wie wir oben gesehen haben ist die abhängige Variable in der Logit-Regression
der Logarithmus der *Odds Ratio*.
Das ist nicht ganz einfach zu interpretieren.
So bedeutet der Koeffizient für `Auslaender1` in folgender Ergebnistabelle,
dass sich die logarithmierte *Odds Ratio* *ceteris paribus* um 1.3 Prozent 
reduziert, wenn die betroffene Person Ausländerin ist:


```r
arbeitslogit <- glm(
  Arbeitslos ~ Einkommen_log + Alter + Ausbildung_Jahre + Kinder_jung + 
    Kinder_alt + Auslaender, 
  family = binomial(link = "logit"), 
  data = schweiz_al)
summary(arbeitslogit)
```

```
## 
## Call:
## glm(formula = Arbeitslos ~ Einkommen_log + Alter + Ausbildung_Jahre + 
##     Kinder_jung + Kinder_alt + Auslaender, family = binomial(link = "logit"), 
##     data = schweiz_al)
## 
## Deviance Residuals: 
##     Min       1Q   Median       3Q      Max  
## -2.2681  -1.0675   0.5383   0.9727   1.9384  
## 
## Coefficients:
##                    Estimate Std. Error z value Pr(>|z|)    
## (Intercept)      -10.374346   2.166852  -4.788 1.69e-06 ***
## Einkommen_log      0.815041   0.205501   3.966 7.31e-05 ***
## Alter              0.051033   0.009052   5.638 1.72e-08 ***
## Ausbildung_Jahre  -0.031728   0.029036  -1.093    0.275    
## Kinder_jung        1.330724   0.180170   7.386 1.51e-13 ***
## Kinder_alt         0.021986   0.073766   0.298    0.766    
## Auslaender1       -1.310405   0.199758  -6.560 5.38e-11 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## (Dispersion parameter for binomial family taken to be 1)
## 
##     Null deviance: 1203.2  on 871  degrees of freedom
## Residual deviance: 1052.8  on 865  degrees of freedom
## AIC: 1066.8
## 
## Number of Fisher Scoring iterations: 4
```

Es wäre ja deutlich schöner wenn wir Änderungen in den unabhängigen Variablen
als Änderungen in $\mathbb{P}(y=1|\boldsymbol{x})$ interpretieren könnten.
In unserem Beispiel also: um wie viel Prozent würde die Wahrscheinlichkeit für
Arbeitslosigkeit steigen wenn es sich bei der betroffenen Person um eine
Ausländerin handelt?
Um dieses Ergebnis zu bekommen bedarf es aber einiger weniger Umformungen.

Da der Zusammenhang zwischen $\mathbb{P}(y=1|\boldsymbol{x})$ und den 
unabhängigen Variablen nicht-linear ist müssen wir für die Vergleiche der
Wahrscheinlichkeiten konkrete Werte angeben.

In einem ersten Schritt verwenden wir die Funktion `predict`, der wir als
erstes Argument `object` unser geschätztes Modell übergeben.
Als zweites Argument übergeben wir einen `data.frame`, in dem wir die 
relevanten Änderungen und den zu betrachtenden Bereich angeben. 
Je nach Anzahl der abhängigen Variablen kann diese Tabelle recht groß werden,
sie ist aber notwendig, da der Zusammenhang zwischen abhängigen und unabhängiger 
Variable ja nicht-linear ist.

Als drittes Argument müssen wir noch `type = "response"` übergeben damit
wir die Vorhersagen auf der Skala der zugrundeliegenden abhänigigen Variable 
bekommen, also direkt als Wahrscheinlichkeiten:



```r
predicted_probs <- predict(object = arbeitslogit, 
        newdata = data.frame(
          "Einkommen_log" = c(10, 10), 
          "Alter"=c(30, 30), 
          "Ausbildung_Jahre" = c(5, 5),
          "Kinder_alt" = c(0, 0), 
          "Kinder_jung"= c(1, 2),
          "Auslaender" = factor(c(0, 0))
          ),
        type = "response")
predicted_probs
```

```
##         1         2 
## 0.6175431 0.8593445
```

Das erste Element ist die Wahrscheinlichkeit arbeitslos zu sein für eine 
dreißigjährige Frau mit einem
arbeitsunabhänigen Einkommen von $\exp(10)=22025$, fünfjähiger Ausbildung, keinen
alten Kindern, einem jungen Kind und mit schweizerischer Staatsangehörigkeit.
Die zweite Wahrscheinlichkeit gilt für eine Frau mit den gleichen Eigenschaften
aber zwei jungen Kindern.
Mit `diff()` bekommen wir gleich den entsprechenden Effekt eines weiteren jungen 
Kindes auf die Wahrscheinlichkeit arbeitslos zu sein:


```r
diff(predicted_probs)
```

```
##         2 
## 0.2418014
```

Die Wahrscheinlichkeit ist also nach dem Modell ca. $25\%$ größer!
Wenn wir wissen wollen ob der Effekt für Ausländerinnen ähnlich ist rechnen wir:


```r
diff(
  predict(object = arbeitslogit, 
        newdata = data.frame(
          "Einkommen_log" = c(10, 10), 
          "Alter"=c(30, 30), 
          "Ausbildung_Jahre" = c(5, 5),
          "Kinder_alt" = c(0, 0), 
          "Kinder_jung"= c(1, 2),
          "Auslaender" = factor(c(1, 1))
          ),
        type = "response")
)
```

```
##         2 
## 0.3189543
```

Hier ist der Effekt mit ca. $32\%$ also noch größer!
