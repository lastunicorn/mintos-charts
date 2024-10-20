t <- mintos |> 
  filter(
    payment_type == "Deposits" |
      payment_type == "Interest received" |
      payment_type == "Interest received from loan repurchase" |
      payment_type == "Bonus" |
      #payment_type == "Secondary market transaction - discount or premium" |
      payment_type == "Tax withholding" |
      payment_type == "Delayed interest income on transit rebuy" |
      payment_type == "Late fees received" |
      payment_type == "Interest received from pending payments") |> 
  summarize(total = sum(turnover))




t <- mintos |> 
  filter(date == "2023-05-24") |> 
  summarize(total = sum(turnover))

t <- mintos |> 
  filter(date == "2023-05-26" & payment_type == "Principal received") |> 
  summarize(total = sum(turnover))

print(t$total, digits = 20)


t <- mintos |> 
  group_by(payment_type) |> 
  summarize(total = sum(turnover))

t <- mintos |> 
  filter(year(date) == 2024) |> 
  group_by(payment_type) |> 
  summarize(total = sum(turnover)) |> 
  summarize(total = sum(total))


t <- mintos |> 
  filter(year(date) == 2023) |>  
  group_by(payment_type) |> 
  summarize(total = sum(turnover)) |> 
  summarize(total = sum(total))


# ------------------------------------------------------------------------------
# Transaction count by type

mintos |> 
  group_by(payment_type) |> 
  summarize(count = n())
