# Produces government expenditure and trade openness data set for chapter on
# visualization
library(WDI)
library(countrycode)
library(data.table)
library(tidyverse)
library(MacroDataR)

macro_data <- MacroDataR::macro_data %>%
  select(one_of("iso3c", "year", "kof_trade_df",
                "kof_trade_dj", "trade_total_GDP"))

gvnmt_expenditure <- WDI(
  country = countrycode(unique(macro_data$iso3c), "iso3c", "iso2c"),
  indicator = c("NE.CON.GOVT.ZS", "gc.xpn.totl.gd.zs"),
  start = min(macro_data$year),
  end = max(macro_data$year)
  ) %>%
  rename(gvnt_cons=NE.CON.GOVT.ZS,
         gvtn_expense=gc.xpn.totl.gd.zs) %>%
  mutate(iso3c=countrycode(iso2c, "iso2c", "iso3c")) %>%
  select(-country, -iso2c)

macro_data_full <- left_join(macro_data, gvnmt_expenditure,
                             by=c("iso3c", "year")
                             ) %>%
  filter(year>=1965)

fwrite(macro_data_full, here("data/tidy/government_openness.csv"))
