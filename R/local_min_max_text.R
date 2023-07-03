#' Find the local min and max values and calculate the moves beetween the local min and maximum values
#' @export
#' @param df OLHC df, you can get using the get_one_ticker function
#' @param ndays Number of days to check for local min or max
#' @importFrom data.table data.table
add_change_text <- function(df, ndays, min_max_text = T) {

  df$loc_point <- ''
  for (i in (ndays):(nrow(df)-ndays) ) {
    if (all(df$low[i] <= df$low[(i-ndays):(i+ndays)])) {
      df$loc_point[i] <- 'min'
    }
    if (all(df$high[i] >= df$high[(i-ndays):(i+ndays)])) {
      df$loc_point[i] <- 'max'
    }
  }
  loc_ind <- which(df$loc_point!='')
  if (df$loc_point[tail(loc_ind, 1)] =='max') {
    min_index <- tail(loc_ind, 1) +  which.min(df$low[tail(loc_ind, 1): nrow(df)]) - 1
    df$loc_point[min_index] <- 'min'
  }else if (df$loc_point[tail(loc_ind, 1)] =='min') {
    max_index <- tail(loc_ind, 1) +  which.max(df$high[tail(loc_ind, 1): nrow(df)]) - 1
    df$loc_point[max_index] <- 'max'
  }

  temp_list <- NULL
  for (i in 1:(length(loc_ind)-1) ) {
    if (df$loc_point[loc_ind[i]] == df$loc_point[loc_ind[(i+1)]] ) {
      temp_list <- c(temp_list, loc_ind[i])
    }else{
      if (length(temp_list) > 0) {
        temp_list <- c(temp_list, loc_ind[i])
        if (df$loc_point[temp_list[1]]=='max') {
          false_max <- temp_list[-(which.max(df$high[temp_list])[1]) ]
          df$loc_point[false_max] <- ''
        } else if(df$loc_point[temp_list[1]]=='min'){
          false_min <- temp_list[-(which.min(df$low[temp_list])[1]) ]
          df$loc_point[false_min] <- ''
        }
        temp_list <- NULL
      }
    }
  }

  # go through on clean local points and ad text
  df$move_text <- ''
  local_points <- which(df$loc_point!='')
  if (df$loc_point[local_points[1]] =='max') {
    df$move_text[local_points[1]] <-  paste0( '$', round(df$high[local_points[1]],2), '\n', df$date[local_points[1]])
  }else if(df$loc_point[local_points[1]] =='min' ){
    df$move_text[local_points[1]] <-  paste0( '$', round(df$low[local_points[1]],2), '\n', df$date[local_points[1]])
  }

  for (i in 2:length(local_points) ) {
    if ( df$loc_point[local_points[i]] =='max') {
      prev_low <- df$low[local_points[(i-1)]]
      new_high <- df$high[local_points[i]]
      up<- round(((new_high /prev_low)-1)   *100,2)
      up <- ifelse(up >=100, paste0(  round(((up+100)/100),2)  , 'x' ),  paste0(up, '%')  )
      df$move_text[local_points[i]] <-  paste0( '$', round(new_high,2) , ', up: ',up , '\n', df$date[local_points[i]])

    }else if(df$loc_point[local_points[i]] =='min' ){
      prev_high <- df$high[local_points[(i-1)]]
      new_low <- df$low[local_points[(i)]]
      down <- round((1- (new_low / prev_high) )*100,2)
      df$move_text[local_points[i]] <- paste0( '$', round(new_low,2) ,', down: ',down, '%', '\n', df$date[local_points[i]] )
    }
  }
  if (min_max_text==FALSE) {
    df$loc_point <- NULL
  }

  return(data.table(df))
}
