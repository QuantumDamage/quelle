#rozpoczecie iteracji po plikach jak tu: http://stackoverflow.com/a/4855916/993324
file.dir <- "~/Dropbox/quelle/"
for(infile in dir(file.dir, pattern="\\.txt$")) {
  outfile_csv <- gsub("\\.txt","\\.csv", infile)
  outfile_eps <- gsub("\\.txt","\\.eps", infile)

przepisane_dane <- vector()
qber_data_frame <- data.frame()

surowe_dane <- scan(paste(file.dir,infile,sep=""), character(0), sep = "\n")
for (i in 1: length(surowe_dane) ) {if (grepl("method",surowe_dane[i])) NULL else if (grepl("error",surowe_dane[i])) NULL else if (grepl("signal",surowe_dane[i])) NULL else if (grepl("OID",surowe_dane[i])) NULL else przepisane_dane=c(przepisane_dane,surowe_dane[i]) }

for (i in 1:length(przepisane_dane)) {if (grepl("qber",przepisane_dane[i]) & grepl("variant",przepisane_dane[i+1])) qber_data_frame<-rbind(qber_data_frame,c(i+1,as.numeric(substring(przepisane_dane[i+1],42,nchar(przepisane_dane[i+1]))),strptime(substr(przepisane_dane[i+1],0,19),"%F_%T",tz="")))}

qber_data_frame
colnames(qber_data_frame) <- c("line", "qber")
qber_data_frame<-qber_data_frame[qber_data_frame$qber!=0, ]
write.csv(qber_data_frame,paste(file.dir,outfile_csv,sep=""))

library(ggplot2)

p <- ggplot(qber_data_frame, aes(x=line, y=qber))
p <- p+geom_line()
p
ggsave(file=paste(file.dir,outfile_eps,sep=""))

#zakonczenie iteracji po plikach:
}