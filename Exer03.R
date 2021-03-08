library(httr)
library(rvest)
library(xml2)

i = 0
ticker = list()
url = paste0('https://finance.naver.com/sise/',
            'sise_market_sum.nhn?sosok=',i,'&page=1')

down_table = GET(url)
navi.final = read_html(down_table, encoding = 'EUC-KR') %>%
    html_nodes(., '.pgRR') %>%
    html_nodes(., 'a') %>%
    html_attr(., 'href')
print(navi.final)

navi.final = navi.final %>%
    strsplit(., '=') %>%
    unlist() %>%
    tail(., 1) %>%
    as.numeric()

print(navi.final)

i = 0
j = 1

url = paste0('https://finance.naver.com/sise/',
            'sise_market_sum.nhn?sosok=',i,"&page=",j)
down_table = GET(url)            

Sys.setlocale("LC_ALL", "English")

table = read_html(down_table, encoding = "EUC-KR") %>%
    html_table(fill = TRUE)
table = table[[2]]

Sys.setlocale("LC_ALL", "Korean")

print(head(table))

table[, ncol(table)] = NULL
table = na.omit(table)
print(head(table))
