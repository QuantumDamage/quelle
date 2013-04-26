przepisane_dane <- vector()
qber_data_frame <- data.frame()

surowe_dane <- scan("1-2013-03-27_12:20.txt", character(0), sep = "\n")
for (i in 1: length(surowe_dane) ) {if (grepl("method",surowe_dane[i])) NULL else if (grepl("error",surowe_dane[i])) NULL else if (grepl("signal",surowe_dane[i])) NULL else if (grepl("OID",surowe_dane[i])) NULL else przepisane_dane=c(przepisane_dane,surowe_dane[i]) }

for (i in 1:length(przepisane_dane)) {if (grepl("qber",przepisane_dane[i]) & grepl("variant",przepisane_dane[i+1])) qber_data_frame<-rbind(qber_data_frame,c(i+1,as.numeric(substring(przepisane_dane[i+1],25,nchar(przepisane_dane[i+1])))))}

qber_data_frame