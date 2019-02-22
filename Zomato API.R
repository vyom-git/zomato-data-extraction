#Guardian API
rm(list = ls())

# Libraries Required
detach(name = "package:dplyr")
library(plyr)
library(httr)
library(jsonlite)
library(rjson)
library(RJSONIO)
library(tidyr)
library(keyring)

setwd("C:/Users/vyom/OneDrive/GitHub/zomato-data-extraction")

# API token key
zomatokey <- key_get("zomato","key")

URL <- 'https://developers.zomato.com/api/v2.1/search?'
entity_id <- 'entity_id=61'
entity_type <- 'entity_type=city'

# w=0
# for (q in 1:5) {
#   starts=w
#   w=20*q
#   print(starts)
# }
counts=20

request <- GET(url = paste0(URL,entity_id,"&",entity_type,"&start=0&count=",counts),
               add_headers(User_key=zomatokey))

get_api_data_text <- httr::content(request, as="text")
get_api_json <- jsonlite::fromJSON(txt = get_api_data_text, flatten = TRUE)

zomato_search_final <- NULL
get_api_loop <- NULL

for(j in 1:counts){
  get_api_loop <-data.frame(results_found=c(get_api_json$results_found[j]),
                               results_start=c(get_api_json$results_start[j]),
                               results_shown=c(get_api_json$results_shown[j]),
                               restaurant.apikey=c(get_api_json$restaurants$restaurant.apikey[j]),
                               restaurant.id=c(get_api_json$restaurants$restaurant.id[j]),
                               restaurant.name=c(get_api_json$restaurants$restaurant.name[j]),
                               restaurant.url=c(get_api_json$restaurants$restaurant.url[j]),
                               restaurant.switch_to_order_menu=c(get_api_json$restaurants$restaurant.switch_to_order_menu[j]),
                               restaurant.cuisines=c(get_api_json$restaurants$restaurant.cuisines[j]),
                               restaurant.average_cost_for_two=c(get_api_json$restaurants$restaurant.average_cost_for_two[j]),
                               restaurant.price_range=c(get_api_json$restaurants$restaurant.price_range[j]),
                               restaurant.currency=c(get_api_json$restaurants$restaurant.currency[j]),
                               restaurant.opentable_support=c(get_api_json$restaurants$restaurant.opentable_support[j]),
                               restaurant.is_zomato_book_res=c(get_api_json$restaurants$restaurant.is_zomato_book_res[j]),
                               restaurant.mezzo_provider=c(get_api_json$restaurants$restaurant.mezzo_provider[j]),
                               restaurant.is_book_form_web_view=c(get_api_json$restaurants$restaurant.is_book_form_web_view[j]),
                               restaurant.book_form_web_view_url=c(get_api_json$restaurants$restaurant.book_form_web_view_url[j]),
                               restaurant.book_again_url=c(get_api_json$restaurants$restaurant.book_again_url[j]),
                               restaurant.thumb=c(get_api_json$restaurants$restaurant.thumb[j]),
                               restaurant.photos_url=c(get_api_json$restaurants$restaurant.photos_url[j]),
                               restaurant.menu_url=c(get_api_json$restaurants$restaurant.menu_url[j]),
                               restaurant.featured_image=c(get_api_json$restaurants$restaurant.featured_image[j]),
                               restaurant.has_online_delivery=c(get_api_json$restaurants$restaurant.has_online_delivery[j]),
                               restaurant.is_delivering_now=c(get_api_json$restaurants$restaurant.is_delivering_now[j]),
                               restaurant.include_bogo_offers=c(get_api_json$restaurants$restaurant.include_bogo_offers[j]),
                               restaurant.deeplink=c(get_api_json$restaurants$restaurant.deeplink[j]),
                               restaurant.is_table_reservation_supported=c(get_api_json$restaurants$restaurant.is_table_reservation_supported[j]),
                               restaurant.is_table_reservation_supported=c(get_api_json$restaurants$restaurant.is_table_reservation_supported[j]),
                               restaurant.has_table_booking=c(get_api_json$restaurants$restaurant.has_table_booking[j]),
                               restaurant.events_url=c(get_api_json$restaurants$restaurant.events_url[j]),
                               restaurant.medio_provider=c(get_api_json$restaurants$restaurant.medio_provider[j]),
                               restaurant.book_url=c(get_api_json$restaurants$restaurant.book_url[j]),
                               restaurant.R.res_id=c(get_api_json$restaurants$restaurant.R.res_id[j]),
                               restaurant.location.address=c(get_api_json$restaurants$restaurant.location.address[j]),
                               restaurant.location.locality=c(get_api_json$restaurants$restaurant.location.locality[j]),
                               restaurant.location.city=c(get_api_json$restaurants$restaurant.location.city[j]),
                               restaurant.location.city_id=c(get_api_json$restaurants$restaurant.location.city_id[j]),
                               restaurant.location.latitude=c(get_api_json$restaurants$restaurant.location.latitude[j]),
                               restaurant.location.longitude=c(get_api_json$restaurants$restaurant.location.longitude[j]),
                               restaurant.location.zipcode=c(get_api_json$restaurants$restaurant.location.zipcode[j]),
                               restaurant.location.country_id=c(get_api_json$restaurants$restaurant.location.country_id[j]),
                               restaurant.location.locality_verbose=c(get_api_json$restaurants$restaurant.location.locality_verbose[j]),
                               restaurant.user_rating.aggregate_rating=c(get_api_json$restaurants$restaurant.user_rating.aggregate_rating[j]),
                               restaurant.user_rating.rating_text=c(get_api_json$restaurants$restaurant.user_rating.rating_text[j]),
                               restaurant.user_rating.rating_color=c(get_api_json$restaurants$restaurant.user_rating.rating_color[j]),
                               restaurant.user_rating.votes=c(get_api_json$restaurants$restaurant.user_rating.votes[j]),
                               stringsAsFactors=FALSE)
  zomato_search_final<-rbind(zomato_search_final,get_api_loop)
}

colnames(zomato_search_final)
write.csv(zomato_search_final, file = "sample zomato api.csv")
