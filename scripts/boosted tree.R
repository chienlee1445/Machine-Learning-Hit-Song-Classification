# boosted tree
bt_class_spec <- boost_tree(mtry = tune(), 
                            trees = tune(), 
                            learn_rate = tune()) %>%
  set_engine("xgboost") %>% 
  set_mode("classification")

# boosted tree workflow
workflow_bt <- workflow() %>% 
  add_recipe(spotify_recipe) %>%
  add_model(bt_class_spec)

# boosted tree grid
bt_grid <- grid_regular(mtry(range = c(1, 6)), 
                        trees(range = c(200, 600)),
                        learn_rate(range = c(-10, -1)),
                        levels = 5)

# boosted tree tuning
tune_bt <- tune_grid(
  workflow_bt,
  resamples = spotify_folds,
  grid = bt_grid
)

save(tune_bt, file = "tune_bt.rda")