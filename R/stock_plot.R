#' Plot one stock
#' @export
#' @param ticker The ticker id of the company
#' @param start_date start date of the plot
#' @param end_date end date of the plot
#' @param local_point_days numbar of days to became a local point
#' @param fullhd if you want to save as a full hd png
#' @import ggplot2
#' @importFrom tidyquant geom_candlestick
#' @importFrom ggrepel geom_label_repel
#' @importFrom grid grid.newpage grid.draw
#' @importFrom gridExtra grid.arrange
stock_show_one_plot <- function(ticker, start_date = (Sys.Date()-500), end_date=Sys.Date(), local_point_days= 20,  fullhd=FALSE) {

  # ticker <- 'RIDE'

  t <- add_change_text(get_one_ticker(ticker = ticker, start_date = Sys.Date()-500), 30)

  stockinfo <- get_ticker_info(ticker)

  # candle stick chart
  p1 <-   ggplot(t, aes(x = date, y = close, label=move_text)) +
    geom_candlestick(aes(open = open, high = high, low = low, close = close),colour_up = 'green') +theme_minimal()+
    geom_line(aes(y = ma_200_value), color = "red") +
    geom_line(aes(y = ma_50_value), color = "orange") +
    labs(title= stockinfo$title , x= '', y="$", subtitle =stockinfo$subtitle )+
    geom_label_repel( box.padding = 0.5, max.overlaps = Inf  )+
    theme_bw()

  # rsi plot
  p2 <- ggplot(t, aes(x=date, y=rsi)) + geom_line()+
    geom_line(aes(y = 70), color = "black", linetype = "dashed") +
    geom_line(aes(y = 30), color = "black", linetype = "dashed") +theme_minimal()+
    labs( x= '', y="RSI")+
    theme_bw()

  grid.newpage()
  grid.draw(rbind(ggplotGrob(p1), ggplotGrob(p2)))
  p <- grid.arrange(p1, p2, ncol = 1, heights = c(3, 1.2))

  return(p)
}









