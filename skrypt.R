#Wczytywanie przykładowego pliku z danymi:
surowe_dane <- scan("1-2013-03-27_12:20.txt", character(0), sep = "\n") # separate each word, separate each line
dlugosc_surowych <- length(surowe_dane)
przepisane_dane <- c(0)
#Przepisywanie z pominięciem niepotrzebnych linii:
for (i in 1:10000) {if (grepl("method",surowe_dane[i])) NULL else if (grepl("error",surowe_dane[i])) NULL else if (grepl("signal",surowe_dane[i])) NULL else if (grepl("OID",surowe_dane[i])) NULL else przepisane_dane=c(przepisane_dane,surowe_dane[i]) }
przepisane_dane

dca_raw <- c(0)
for (i in 1:length(przepisane_dane)) {if (grepl("alice",przepisane_dane[i])) if (grepl("variant",przepisane_dane[i+1])) dca_raw=c(dca_raw,przepisane_dane[i+1])}
dca_raw