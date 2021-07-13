#'
get_data <- function(
  T_dim, N_dim, alpha0, beta,
  x_persistence, x_fe_relevance, x_tfe_relevance,
  sd_x_errors,
  y_persistence, # TODO
  sd_y_errors,
  mean_fe,
  mean_tfe,
  sd_fe,
  sd_tfe,
  seed="123",
  verbose=FALSE
  ){

  set.seed(seed = seed)
  # Create fixed effects
  fe_vals <- rnorm(N_dim, mean = mean_fe, sd = sd_fe)
  tfe_vals <- rnorm(T_dim, mean = mean_tfe, sd = sd_tfe)

  # Determine weight of error components and persistence for indep variable
  weighting_sum <- x_persistence + x_fe_relevance +
    x_tfe_relevance
  x_pers_weight <- x_persistence #/ weighting_sum
  x_fe_weight <- x_fe_relevance #/ weighting_sum
  x_tfe_weight <- x_tfe_relevance #/ weighting_sum

  # Determine weight of error components and persistence for dep variable
  # y_weightsum <- y_persistence + y_fe_relevance + y_tfe_relevance
  # ypers_w <- y_persistence#/y_weightsum
  # ytfe_w <- y_tfe_relevance#/y_weightsum

  # Simulate independent variable
  xvals <- list()
  yvals <- list()
  x_errors <- rnorm(T_dim*N_dim, mean = 0, sd = sd_x_errors)
  y_errors <- rnorm(T_dim*N_dim, mean = 0, sd = sd_y_errors)
  index_full <- 1
  for (i in 1:N_dim) {
    if (verbose){
      print(paste0("N: ", i))
    }
    x_i <- c(runif(1, 0.5*alpha0, 1.5*alpha0) + x_fe_weight*fe_vals[i], rep(NA, T_dim-1))

    y_0 <- alpha0 + beta*x_i[1] + #ypers_w*y_i[t-1] +
      fe_vals[i]  + y_errors[index_full] #+ ytfe_w*tfe_vals[t]
    y_i <- c(y_0, rep(NA, T_dim-1))
    index_full <- index_full+1
    for (t in 2:T_dim){
      if (verbose){
        print(paste0("t: ", t))
      } # TODO: scheint weitgehend zu passen, siehe gleichung 46
      x_i[t] <- x_pers_weight*x_i[t-1] +
        x_fe_weight*fe_vals[i] + x_errors[index_full]
      # x_i[t] <- x_pers_weight*x_i[t-1] + x_fe_weight*fe_vals[i] +
      #   x_tfe_weight*tfe_vals[t] + x_error_weight*x_errors[index_full]
      y_i[t] <- alpha0 + beta*x_i[t] + #ypers_w*y_i[t-1] +
        fe_vals[i]  + y_errors[index_full] #+ ytfe_w*tfe_vals[t]
      index_full <- index_full+1
    }
    xvals[[i]] <- x_i
    yvals[[i]] <- y_i
    }

  base_data <- tibble::tibble(
    id=rep(1:N_dim, each=T_dim),
    tstep=rep(1:T_dim, N_dim),
    fe=rep(fe_vals, each=T_dim),
    tfe=rep(tfe_vals, N_dim)
    )

  fulldata <- base_data %>%
    dplyr::mutate(
      x1 = unlist(xvals),
      y = unlist(yvals),
      id = factor(id)
    )
  fulldata
}

conduct_mcs <- function(
  n_simuls, data_parameters, show_pb=TRUE){

  x1_estimates_pooled <- rep(NA, n_simuls)
  x1_estimates_fd <- rep(NA, n_simuls)
  x1_estimates_between_ind <- rep(NA, n_simuls)
  x1_estimates_between_tfe <- rep(NA, n_simuls)
  x1_estimates_within_fe <- rep(NA, n_simuls)
  x1_estimates_within_tfe <- rep(NA, n_simuls)
  x1_estimates_within_twow <- rep(NA, n_simuls)
  x1_estimates_random_fe <- rep(NA, n_simuls)
  x1_estimates_random_tfe <- rep(NA, n_simuls)
  x1_estimates_random_twow <- rep(NA, n_simuls)

  rdm_seeds <- sample(1:999, n_simuls)
  if (show_pb){
    pb <- txtProgressBar(min = 0, max = n_simuls, style = 3)
  }
  for (i in 1:n_simuls){
    data_parameters[["seed"]] <- rdm_seeds[i]
    data_used <- do.call(get_data, data_parameters)

    est_model_pooled <- plm::plm(
      y~x1, data = data_used, index = c("id", "tstep"),
      model = "pooling")

    est_model_fd <- plm(
      y~x1, data = data_used,  index = c("id", "tstep"),
      model = "fd")

    est_model_between_fe <- plm(
      y~x1+id, data = data_used, index = c("id", "tstep"),
      model = "between",
    )

    est_model_between_tfe <- plm(
      y~x1+id, data = data_used, index = c("id", "tstep"),
      model = "between", effect = "time"
    )

    est_model_within_fe <- plm::plm(
      y~x1, data = data_used, index = c("id", "tstep"),
      model = "within", effect = "individual")

    est_model_within_tfe <- plm::plm(
      y~x1, data = data_used, index = c("id", "tstep"),
      model = "within", effect = "time")

    est_model_within_twow <- plm::plm(
      y~x1, data = data_used, index = c("id", "tstep"),
      model = "within", effect = "twoways")

    est_model_random_fe <- plm::plm(
      y~x1, data = data_used, index = c("id", "tstep"),
      model = "random", effect = "individual")

    est_model_random_tfe <- plm::plm(
      y~x1, data = data_used, index = c("id", "tstep"),
      model = "random", effect = "time")

    est_model_random_twow <- plm::plm(
      y~x1, data = data_used, index = c("id", "tstep"),
      model = "random", effect = "twoways")

    x1_estimates_pooled[i] <- coef(est_model_pooled)["x1"]
    x1_estimates_fd[i] <- coef(est_model_fd)["x1"]
    x1_estimates_between_ind[i] <- coef(est_model_between_fe)["x1"]
    x1_estimates_between_tfe[i] <- coef(est_model_between_tfe)["x1"]
    x1_estimates_within_fe[i] <- coef(est_model_within_fe)["x1"]
    x1_estimates_within_tfe[i] <- coef(est_model_within_tfe)["x1"]
    x1_estimates_within_twow[i] <- coef(est_model_within_twow)["x1"]
    x1_estimates_random_fe[i] <- coef(est_model_random_fe)["x1"]
    x1_estimates_random_tfe[i] <- coef(est_model_random_tfe)["x1"]
    x1_estimates_random_twow[i] <- coef(est_model_random_twow)["x1"]
    if (show_pb){
      setTxtProgressBar(pb, i)
    }
  }

  estimate_distribution <- tibble::tibble(
    "POLS" = x1_estimates_pooled,
    "FD" = x1_estimates_fd,
    "Between_fe" = x1_estimates_between_ind,
    "Between_tfe" = x1_estimates_between_tfe,
    "Within_fe" = x1_estimates_within_fe,
    "Within_tfe" = x1_estimates_within_tfe,
    "Within_twow" = x1_estimates_within_twow,
    "GLS_fe" = x1_estimates_random_fe,
    "GLS_tfe" = x1_estimates_random_tfe,
    "GLS_twow" = x1_estimates_random_twow
  )

  estimate_summary <- estimate_distribution %>%
    tidyr::pivot_longer(
      cols = dplyr::everything(),
      names_to = "model",
      values_to = "estimate_beta1") %>%
    dplyr::group_by(model) %>%
    dplyr::mutate(
      deviation = (estimate_beta1 - data_parameters[["beta"]])**2
    ) %>%
    dplyr::summarise(
      mean_estimate = mean(estimate_beta1),
      sd_estimate = sd(estimate_beta1),
      rmse = sqrt(mean(deviation)),
      .groups = "drop") %>%
    dplyr::mutate(
      mean_deviation=mean_estimate-data_parameters[["beta"]]
    )

  list(
    "est_dist"=estimate_distribution,
    "est_summary"=estimate_summary
  )
}
