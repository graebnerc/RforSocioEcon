library(AER)
library(tidyverse)
library(data.table)

data("Journals")

journals_new <- as_tibble(Journals, rownames = "Kuerzel") %>%
  rename(
    Titel = title,
    Verlag = publisher,
    Society = society,
    Preis = price,
    Seitenanzahl = pages,
    Buchstaben_pS = charpp,
    Zitationen = citations,
    Gruendung = foundingyear,
    Abonnenten = subs,
    Bereich = field
  )
head(journals_new)

fwrite(journals_new, here("data/tidy/journaldaten.csv"))
