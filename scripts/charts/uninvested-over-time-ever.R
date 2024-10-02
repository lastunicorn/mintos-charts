# ------------------------------------------------------------------------------
# Cash drag (uninvested amount) (ever)

mintos |> 
  group_by(date) |> 
  arrange(time) |> 
  summarize(balance = last(balance)) |> 
  ggplot(aes(x = date, y = balance)) +
  geom_step() +
  geom_smooth(method = 'loess', formula = 'y ~ x') +
  scale_x_date(date_breaks = "1 month", date_labels = "%b %Y", minor_breaks = NULL) +
  guides(x = guide_axis(angle = 60)) +
  labs(
    title = "Cash drag (uninvested amount) (ever)",
    x = "Date",
    y = "Uninvested amount (€)"
  )

# Save
ggsave("charts/uninvested-amount-ever.png", width=30, height=20, units="cm", dpi=300)
