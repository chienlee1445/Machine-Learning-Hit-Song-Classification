# elastic net regression
enet_spec_log <- logistic_reg(penalty = tune(), mixture = tune()) %>%
  set_engine("glmnet") %>%
  set_mode("classification")

# elastic net regression workflow
workflow_enet <- workflow() %>%
  add_recipe(spotify_recipe) %>%
  add_model(enet_spec_log)

# enet grid
param_grid_enet <- grid_regular(penalty(range = c(0, 1), trans = identity_trans()), 
                                mixture(range = c(0, 1)), levels = 10)

# elastic net tuning
tune_enet <- tune_grid(
  workflow_enet,
  resamples = spotify_folds,
  grid = param_grid_enet
)

save(tune_enet, file = "tune_enet.rda")