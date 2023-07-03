
# ticker <- 'GE'

# t <- add_change_text(get_one_ticker(ticker = ticker, start_date = Sys.Date()-500), 30)
#
# stockinfo <- cashed_stock_df()
#
#
# sec_loc <- paste0('Sector location: ', which(stockinfo[sector==stockinfo[name==ticker]$sector,]$name==ticker) ,'/', length(stockinfo[sector==stockinfo[name==ticker]$sector,]$name)  )
# ind_loc <- paste0('Industry location: ', which(stockinfo[industry==stockinfo[name==ticker]$industry,]$name==ticker), '/', length(stockinfo[industry==stockinfo[name==ticker]$industry,]$name)    )
# title<-  paste0(stockinfo[name==ticker]$description, ' (', ticker,  ') ', ' | $', round(stockinfo[name==ticker]$close, 2),
#                      ' | ',  stockinfo[name==ticker]$sector, ' | ', stockinfo[name==ticker]$industry )
#
# nb_imp <- ifelse(is.na(stockinfo[name==ticker]$number_of_employees[1]), 'Unknown', format(as.numeric(stockinfo[name==ticker]$number_of_employees[1]) , big.mark=',') )
# my_sub_title <-  paste0('Performance: | week: ', round(stockinfo[name==ticker]$Perf.W, 2),  '% | ',
#                         'month: ', round(stockinfo[name==ticker]$Perf.1M, 2),  '% | ',
#                         '6 months: ', round(stockinfo[name==ticker]$Perf.6M, 2),  '% | ',
#                         '1 year: ', round(stockinfo[name==ticker]$Perf.Y, 2),  '%' ,'\n',
#                         'Market cap: $', format(round(as.numeric(stockinfo[name==ticker]$market_cap_basic/1000000), 2),big.mark = ','), ' Million ',
#                         ' | Number of employees: ', nb_imp ,'\n',
#                         sec_loc, ', ',ind_loc)
#
# # candle stick chart
# p1 <-   ggplot(t, aes(x = date, y = close, label=move_text)) +
#   geom_candlestick(aes(open = open, high = high, low = low, close = close),colour_up = 'green') +theme_minimal()+
#   geom_line(aes(y = ma_200_value), color = "red") +
#   geom_line(aes(y = ma_50_value), color = "orange") +
#   labs(title= my_title , x= '', y="$", subtitle =my_sub_title )+
#   geom_label_repel( box.padding = 0.5, max.overlaps = Inf  )+
#   theme_bw()
#
# # rsi plot
# p2 <- ggplot(t, aes(x=date, y=rsi)) + geom_line()+
#   geom_line(aes(y = 70), color = "black", linetype = "dashed") +
#   geom_line(aes(y = 30), color = "black", linetype = "dashed") +theme_minimal()+
#   labs( x= '', y="RSI")+
#   theme_bw()
#
# grid.newpage()
# grid.draw(rbind(ggplotGrob(p1), ggplotGrob(p2)))
# p <- grid.arrange(p1, p2, ncol = 1, heights = c(3, 1.2))
# plot(p)

