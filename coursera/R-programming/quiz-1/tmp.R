#Your Data
dt <- data.frame(
    ID = c('A1','A2','A4','A2','A1','A4','A3','A2','A1','A3'),
    Value = c(4,3,1,3,4,6,6,1,8,4)
)
dt$Order <- rank(dt$Value,ties.method= "first")

#My approach
dt$id <- 1:nrow(dt) #needed for ordering and putting things back together
dt <- dt[order(dt$ID),]
dt$Order.by.group <- unlist(with(dt, tapply(Value, ID, function(x) rank(x, ties.method = "first"))))
# dt[order(dt$id),-4]
# dt
