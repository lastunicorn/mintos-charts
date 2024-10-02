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
  ggplot(aes(x = date_without_year, y = balance)) +
  geom_line() +
  facet_wrap(~ year, ncol = 1) +
  scale_x_date(date_breaks = "1 month", date_labels = "%b", minor_breaks = NULL) +
  labs(
    title = "Cash drag (uninvested amount) (per year)",
    x = "Date",
    y = "Uninvested amount (€)"
  )

# Save
ggsave("charts/uninvested-amount-per-year.png", width=30, height=20, units="cm", dpi=300)
