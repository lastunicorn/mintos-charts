# ------------------------------------------------------------------------------
# Interest by year (ever)

mintos |> 
  filter(payment_type %in% c(
    "Interest received",
    "Interest received from loan repurchase",
    "Delayed interest income on transit rebuy",
    "Late fees received",
    "Interest received from pending payments")
  ) |>
  mutate(
    year = as.factor(year(date))
  ) |> 
  group_by(year) |> 
  summarize(
    profit = sum(turnover)
  ) |> 
  arrange(year) |> 
  ggplot(aes(x = year, y = profit)) +
  geom_col(width = .5) +
  geom_text(aes(label = round(profit, 2)), size = 3, vjust = -0.5) +
  labs(
    title = "Interest amount by year (ever)",
    x = "Date",
    y = "Amount (€)"
  )

save_plot("interest-amount-05-by-year-ever.png")
