# random forest
rf_class_spec <- rand_forest(mtry = tune(), 
                             trees = tune(), 
                             min_n = tune()) %>%
  set_engine("ranger", importance = "impurity") %>% 
  set_mode("classification")

# random forest workflow
workflow_rf <- workflow() %>% 
  add_recipe(spotify_recipe) %>%
  add_model(rf_class_spec)

# random forest grid
rf_grid <- grid_regular(mtry(range = c(1, 6)), 
                        trees(range = c(200, 600)),
                        min_n(range = c(10, 20)),
                        levels = 5)

# random forest tuning
tune_rf <- tune_grid(
  workflow_rf,
  resamples = spotify_folds,
  grid = rf_grid
)

save(tune_rf, file = "tune_rf.rda")