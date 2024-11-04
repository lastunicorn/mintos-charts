# ------------------------------------------------------------------------------
# Cash drag (uninvested amount) (per year)

mintos |> 
  group_by(date) |> 
  arrange(time) |> 
  summarize(balance = last(balance)) |> 
  mutate(
    date_without_year = as.Date(ISOdate(2000, month(date), day(date))),
    year = year(date)
  ) |>  
  uncount(2) |> 
  mutate(
    balance = lag(balance)
  ) |> 
  slice_tail(n = -1) |> 
  ggplot(aes(x = date_without_year, y = balance)) +
  geom_area(fill = "gray60") +
  geom_line(color = "gray20") +
  #geom_smooth(method = 'loess', formula = 'y ~ x') +
  facet_wrap(~ year, ncol = 1) +
  scale_x_date(date_breaks = "1 month", date_labels = "%b", minor_breaks = NULL) +
  labs(
    title = "Cash drag (uninvested amount) (per year)",
    x = "Date",
    y = "Amount (€)"
  )

# Save
save_plot("uninvested-amount-per-year.png")
