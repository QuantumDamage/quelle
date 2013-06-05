#rozpoczecie iteracji po plikach jak tu: http://stackoverflow.com/a/4855916/993324
file.dir <- "~/Dropbox/quelle/czas/"
for(infile in dir(file.dir, pattern="\\.txt$")) {
  outfile_csv <- gsub("\\.txt","\\.csv", infile)
  outfile_eps <- gsub("\\.txt","\\.eps", infile)
  
  przepisane_dane <- vector()
  #qber_data_frame <- data.frame()
  
  surowe_dane <- scan(paste(file.dir,infile,sep=""), character(0), sep = "\n")
  for (i in 1: length(surowe_dane) ) {
    if (grepl("method",surowe_dane[i])) NULL 
    else if (grepl("error",surowe_dane[i])) NULL 
    else if (grepl("signal",surowe_dane[i])) NULL 
    else if (grepl("OID",surowe_dane[i])) NULL 
    else przepisane_dane=c(przepisane_dane,surowe_dane[i]) 
  }
  
  #for (i in 1:length(przepisane_dane)) {
  #  if (grepl("qber",przepisane_dane[i]) & grepl("variant",przepisane_dane[i+1])) qber_data_frame<-rbind(qber_data_frame,c(i+1,as.numeric(substring(przepisane_dane[i+1],42,nchar(przepisane_dane[i+1]))),strptime(substr(przepisane_dane[i+1],0,19),"%F_%T",tz="")))
  #}
  
  ### pomysł Michala:
  qber_data_frame <- data.frame(list("id" = numeric(0),"blabla2" = numeric(0),"sec" = numeric(0),"min" = integer(0),"hour"= integer(0),"mday"= integer(0),"mon"= integer(0),"year"= integer(0),"wday"= integer(0),"yday"= integer(0),"isdst"= integer(0)))
  
  for (i in 1:length(przepisane_dane)) {
    if (grepl("qber",przepisane_dane[i]) & grepl("variant",przepisane_dane[i+1])) {
      temp <-  c(i+1,as.numeric(substring(przepisane_dane[i+1],42,nchar(przepisane_dane[i+1]))),strptime(substr(przepisane_dane[i+1],0,19),"%F_%T",tz=""))
      names(temp) <- names(qber_data_frame) 
      qber_data_frame<-rbind(qber_data_frame,temp)
    }
  }
  
  colnames(qber_data_frame) <- c("line", "qber","sec","min","hour")
  qber_data_frame<-qber_data_frame[qber_data_frame$qber!=0, ]
  write.csv(qber_data_frame,paste(file.dir,outfile_csv,sep=""))
  
  qber_data_frame
  library(qcc)
  wykres<-qcc(qber_data_frame$qber,"xbar.one")
  postscript(paste(file.dir,outfile_eps,sep=""))
  plot(wykres)
  dev.off()
  #zakonczenie iteracji po plikach:
}