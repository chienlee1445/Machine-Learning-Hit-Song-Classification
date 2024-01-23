# k-nearest neighbor
knn_spec <- nearest_neighbor(neighbors = tune()) %>%
  set_engine("kknn") %>%
  set_mode("classification")

# k-nearest neighbor workflow
workflow_knn <- workflow() %>%
  add_recipe(spotify_recipe) %>%
  add_model(knn_spec)

# knn grid
param_grid_knn <- grid_regular(neighbors(range = c(1, 10)), levels = 10)

# knn tuning
tune_knn <- tune_grid(
  workflow_knn,
  resamples = spotify_folds,
  grid = param_grid_knn
)

save(tune_knn, file = "tune_knn.rda")