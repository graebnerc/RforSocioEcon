# Data study

# TODO: Die Gewichtung und Relevant der Effekte nochmal überdenken
# TODO: Dazu nochmal genau in die Simulationspaper reinlesen
pars_fixed <- list(
  "T_dim" = 12,
  "N_dim" = 50,
  "alpha0" = 0,
  "beta" = 1,
  "x_persistence" = 1.0,
  "x_fe_relevance" = 0.5,
  "x_tfe_relevance" = 0.0,
  "sd_x_errors" = 0.25,
  "y_persistence" = 0.0,
  "y_fe_relevance" = 1.0,
  "y_tfe_relevance" = 1.0,
  "sd_y_errors" = 1,
  "sd_fe" = 1,
  "sd_tfe" = 1,
  "seed" = "1"
)

test_data <- do.call(get_data, pars_fixed)

ggplot(test_data, aes(x=tstep, y=y, color=factor(id))) +
  geom_point() + geom_line() + theme_icae() + theme(
    legend.position = "none"
  )

ggplot(test_data, aes(x=tstep, y=x1, color=factor(id))) +
  geom_point() + geom_line() + theme_icae() + theme(
    legend.position = "none"
  )

ggplot(test_data, aes(x=x1, y=y, color=factor(id))) +
  geom_smooth(method = "lm", se = F) +
  geom_point(alpha=0.5) + theme_icae() + theme(
    legend.position = "none"
  ) +
  geom_abline(intercept = pars_fixed[["alpha0"]], slope = pars_fixed[["beta"]])

fe_model_check <- plm::plm(y ~x1, model = "within", effect = "individual", data = test_data, index = c("id", "tstep"))

test_data %>%
  dplyr::mutate(resids_fe=fe_model_check$residuals) %>%
  ggplot(., aes(x=x1, y=resids_fe, color=factor(id))) +
  geom_smooth(method = "lm", se = F) +
  geom_point(alpha=0.5) + theme_icae() + theme(
    legend.position = "none"
  ) +
  geom_abline(intercept = pars_fixed[["alpha0"]], slope = pars_fixed[["beta"]])

# 1. Exogenität der Fixed Effects ----------------------------

#TODO: varianzen der fehler
data_pars <- list(
  "T_dim" = 12,
  "N_dim" = 50,
  "alpha0" = 0,
  "beta" = 1,
  "x_persistence" = 0.95,
  "x_fe_relevance" = 1.0,
  "x_tfe_relevance" = 0.0,
  "sd_x_errors" = 0.25,
  "y_persistence" = 0.0,
  #"y_fe_relevance" = 1.0,
  #"y_tfe_relevance" = 1.0,
  "sd_y_errors" = 1,
  "mean_fe"=0,
  "mean_tfe"=0,
  "sd_fe" = 1,
  "sd_tfe" = 1,
  "seed" = "1"
)

# Variable parameters:
x_fe_relevance <- c(0.0, 0.1, 0.2, 0.4)
x_tfe_relevance <- c(0.0, 0.1, 0.2, 0.4)

nb_simuls <- 10
x_fe_relevance <- c(0.0, 0.5, 1.0) # 0.1, 0.2, 0.3, 0.4,
x_tfe_relevance <- c(0.0, 0.1)
res_tables_fe <- list()
res_tables_tfe <- list()
res_tables_twow <- list()
dist_table <- list()
for (i in seq_along(x_fe_relevance)){
  pb <- txtProgressBar(min = 0, max = length(x_fe_relevance), style = 3)
  data_pars[["x_fe_relevance"]] <- x_fe_relevance[i]
  mcs_object <- conduct_mcs(n_simuls = nb_simuls, data_parameters = data_pars, show_pb = F)

  mcs_summary <- mcs_object[["est_summary"]] %>%
    dplyr::mutate(
      x_fe_rel=data_pars[["x_fe_relevance"]],
      x_tfe_rel=data_pars[["x_tfe_relevance"]]
    )

  mcs_dist_table <- mcs_object[["est_dist"]] %>%
    dplyr::mutate(
      x_fe_rel=data_pars[["x_fe_relevance"]],
      x_tfe_rel=data_pars[["x_tfe_relevance"]]
    )

  dist_table[[as.character(i)]] <- mcs_dist_table
  res_tables_fe[[as.character(i)]] <- mcs_summary
  setTxtProgressBar(pb, i)
}

plot_fe_rel <- rbindlist(res_tables_fe) %>%
  dplyr::filter(
    substr(model, nchar(model)-2, nchar(model))!="tfe",
    substr(model, nchar(model)-3, nchar(model))!="twow",
    substr(model, 1, 4)!="Betw",
    ) %>%
  ggplot(., aes(x=x_fe_rel, y=rmse, color=model, fill=model)
) +
  geom_bar(stat = "identity", position = "dodge2") +
  scale_color_viridis_d(aesthetics=c("color", "fill")) +
  theme_icae()
plot_fe_rel

plot_fe_mean_dev <- rbindlist(res_tables_fe) %>%
  dplyr::filter(
    substr(model, nchar(model)-2, nchar(model))!="tfe",
    substr(model, nchar(model)-3, nchar(model))!="twow",
    substr(model, 1, 4)!="Betw",
  ) %>%
  ggplot(., aes(x=x_fe_rel, y=abs(mean_deviation), color=model, fill=model)
  ) +
  geom_bar(stat = "identity", position = "dodge2") +
  scale_color_viridis_d(aesthetics=c("color", "fill")) +
  theme_icae()
plot_fe_mean_dev


## Pre data inspection


final_data <- do.call(get_data, data_pars)

ggplot(final_data, aes(x=tstep, y=y, color=factor(id))) +
  geom_point() + geom_line() + theme_icae() + theme(
    legend.position = "none"
  )

ggplot(final_data, aes(x=tstep, y=x1, color=factor(id))) +
  geom_point() + geom_line() + theme_icae() + theme(
    legend.position = "none"
  )

ggplot(final_data, aes(x=x1, y=y, color=factor(id))) +
  geom_smooth(method = "lm", se = F) +
  geom_point(alpha=0.5) + theme_icae() + theme(
    legend.position = "none"
  ) +
  geom_abline(intercept = pars_fixed[["alpha0"]], slope = pars_fixed[["beta"]])

fe_model_check <- plm::plm(y ~x1, model = "within", effect = "individual", data = test_data, index = c("id", "tstep"))

test_data %>%
  dplyr::mutate(resids_fe=fe_model_check$residuals) %>%
  ggplot(., aes(x=x1, y=resids_fe, color=factor(id))) +
  geom_smooth(method = "lm", se = F) +
  geom_point(alpha=0.5) + theme_icae() + theme(
    legend.position = "none"
  ) +
  geom_abline(intercept = pars_fixed[["alpha0"]], slope = pars_fixed[["beta"]])

