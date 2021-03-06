library(xml2)
library(rvest)
library(httr)

url = 'https://dev-kind.krx.co.kr/disclosure/todaydisclosure.do'
data = POST(url, body = 
                list(
                    method = 'searchTodayDisclosureSub',
                    currentPageSize = '15',
                    pageIndex = '1',
                    orderMode = '0',
                    orderStat = 'D',
                    forward = 'todaydisclosure_sub',
                    chose = 'S',
                    todayFlag = 'Y',
                    selDate = '2021-03-03'
                ))
data = read_html(data) %>%
    html_table(fill = TRUE) %>%
    .[[1]]
Sys.setlocale("LC_ALL", "Korean")
print(head(data))
