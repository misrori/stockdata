#' Get one stock info
#' @export
#' @importFrom tradingviewdata cashed_stock_df
get_ticker_info  <- function(ticker) {
  tinfo <- cashed_stock_df()
  sec_loc <- paste0('Sector location: ', which(tinfo[sector==tinfo[name==ticker]$sector,]$name==ticker) ,'/', length(tinfo[sector==tinfo[name==ticker]$sector,]$name)  )
  ind_loc <- paste0('Industry location: ', which(tinfo[industry==tinfo[name==ticker]$industry,]$name==ticker), '/', length(tinfo[industry==tinfo[name==ticker]$industry,]$name)    )

  my_title<-  paste0(tinfo[name==ticker]$description, ' (', ticker,  ') ', ' | $', round(tinfo[name==ticker]$close, 2),
                     ' | ',  tinfo[name==ticker]$sector, ' | ', tinfo[name==ticker]$industry )

  nb_imp <- ifelse(is.na(tinfo[name==ticker]$number_of_employees[1]), 'Unknown', format(as.numeric(tinfo[name==ticker]$number_of_employees[1]) , big.mark=',') )

  my_sub_title <-  paste0('Performance: | week: ', round(tinfo[name==ticker]$Perf.W, 2),  '% | ',
                          'month: ', round(tinfo[name==ticker]$Perf.1M, 2),  '% | ',
                          '6 months: ', round(tinfo[name==ticker]$Perf.6M, 2),  '% | ',
                          '1 year: ', round(tinfo[name==ticker]$Perf.Y, 2),  '%' ,'\n',
                          'Market cap: $', format(round(as.numeric(tinfo[name==ticker]$market_cap_basic/1000000), 2),big.mark = ','), ' Million ',
                          ' | Number of employees: ', nb_imp ,'\n',
                          sec_loc, ', ',ind_loc)

  return(list('title'= my_title, 'subtitle'= my_sub_title))
}
