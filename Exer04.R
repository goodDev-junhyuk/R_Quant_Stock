library(httr)
library(rvest)
library(xml2)
install.packages("readr")
library(readr)

gen_otp_url = 'http://data.krx.co.kr/comm/fileDn/GenerateOTP/generate.cmd'
gen_otp_data = list(
    mktId = 'STK',
    trdDd = '20210308',
    money = '1',
    csvxls_isNo = 'false',
    name = 'fileDown',
    url = 'dbms/MDC/STAT/standard/MDCSTAT03901'
)

otp = POST(gen_otp_url, query = gen_otp_data) %>%
    read_html() %>%
    html_text()

down_url = 'http://data.krx.co.kr/comm/fileDn/download_csv/download.cmd'
down_sector_KS = POST(down_url, query = list(code = otp),
                      add_headers(referer = gen_otp_url)) %>%
    read_html(encoding = 'EUC-KR') %>%
    html_text() %>%
    read_csv()

print(down_sector_KS)
