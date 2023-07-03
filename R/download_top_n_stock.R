#' Downloading and adding technical indicators to the historical data of a ticker
#' @export
#' @param location Place where the data should be downloaded, use full paths
#' @param number_of_stocks The top n number of stocks that will be downloaded
#' @param start_date Start date of the stock data
download_top_stock <- function(location,  number_of_stocks=100, start_date='1900-01-01' ) {
  stocks <- cashed_stock_df()[1:number_of_stocks]
  for (ticker in stocks$name) {
    tryCatch({
      df <- get_one_ticker(ticker, start_date = start_date)
      saveRDS(df, paste0(location, ifelse(endsWith(location, '/'), '', '/'),  ticker, '.rds'))
    }, error=function(e){
      print(e)
    })
  }
}
