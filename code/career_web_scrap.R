library(tidyverse)
library(rvest)
library(RCurl)
library(plyr)
# url <- "https://www.glassdoor.com/Job/jobs.htm?suggestCount=0&suggestChosen=false&clickSource=searchBtn&typedKeyword=data+analyst&sc.keyword=data+analyst&locT=C&locId=1132348&jobType="

url <- "https://www.glassdoor.com/Job/new-york-data-analyst-jobs-SRCH_IL.0,8_IC1132348_KO9,21.htm"

links <- read_html(url) %>%
        # html_nodes(".compactStars , .small , .empLoc div , .jobLink") %>%
        html_nodes(".jobLink") %>%
        html_attr("href") %>%
        na.omit %>%
        as.data.frame %>%
        rename("links" = ".") %>%
        mutate(links = paste0("https://www.glassdoor.com", as.character(links))) %>%
        distinct

job <- read_html(links[4, 1]) %>%
        html_nodes(".ratingNum , .salEst , .desc , #HeroHeaderModule .strong") %>%
        html_text %>%
        as.data.frame %>%
        rename("job" = ".") %>%
        t %>%
        as.data.frame



##########
# output #
##########
write.table(job, "clipboard", row.names = F)




















