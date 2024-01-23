# logistic regression
logistic_model <- logistic_reg() %>%
  set_engine("glm") %>%
  set_mode("classification")

# logistic regression workflow
workflow_log <- workflow() %>%
  add_recipe(spotify_recipe) %>%
  add_model(logistic_model)

# no grid because no tuning parameters

# no tuning
# boosted tree tuning
tune_log <- tune_grid(
  workflow_log,
  resamples = spotify_folds,
)

