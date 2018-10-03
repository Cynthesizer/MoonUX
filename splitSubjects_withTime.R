#This script splits up each subject data. If file "movementdata.csv" has three different subjects,
#Data from each subject will be created into a new data frame
#and named: 1movementdata.csv, 2movementdata.csv, 3movementdata.csv (see variable window)

setwd("/Users/cynthiayue/Desktop/School/Moon_UX/output")

#This first part to run thru all the files is taken from Test.R
files <- list.files(pattern = "\\.(csv|CSV)$")  #just chews through all the csv files in a folder
print(files)
allSubj = list()
subjCount=1

# Go through all the files in the folder
for (k in 1:length(files)){ 
  ID=(files[k]) 
  print(ID) #lets you know its progress
  
  data <- read.csv(files[k], stringsAsFactors = FALSE, header=FALSE)  #Getting each data file to R:
  dataTS <- data[,1] #Exract Time Stamp column
  
  # Initiating variables and vectors
  timeSt <- vector()
  count=1
  
  # Go thru each line in TimeStamp column to check for "timestamp"
  for (i in 1:length(dataTS)) {
    
    if (dataTS[i] == " timestamp"){
      timeSt[count]=i #nth bin of timeSt vector takes i, which is the line number for timeStamp title
      count=count+1
      cat("In file", ID, "line",i,"is the start of a new subject", "\n" ) #Print which line the new subject starts
      
    }
  }
  
  subj=1   #allSubj <- list()
  for (m in 1:length(timeSt)) {
    startLine = timeSt[m]
    
    if (timeSt[m]==timeSt[length(timeSt)]) { #Dealing with the end of the data
      #endLine = timeSt[length(timeSt)]
      endLine = length(dataTS)
    } else {endLine = timeSt[m+1]-2}
    
    #Save subject data
    dataSubj <- data[startLine:endLine,] #extract data for the subject
    name <- paste(m,ID, sep="")
    assign(name,dataSubj)
    subj=subj+1
    allSubj[subjCount]<-dataSubj
    subjCount = subjCount + 1
    
  }  
}



##trying to get time difference, testing with one dataset
time <- `11movementdata_M008.csv` 
  


##creating new columns to gather time information -- breaks at last line
time2 <- time %>% 
  mutate(timestart = time[1,1]) %>% 
  mutate(timestart = substr(timestart,9,16)) %>%
  mutate(timefinish = time[nrow(time),1]) %>% 
  mutate(timefinish = substr(timefinish,9,16)) %>%
  mutate(totaltime= (timefinish-timestart))
## 


##Trying code from Andrea's sample -- this seems to work

timeStart <- time[1,1]
timeFinish <- time[nrow(time),1]



newTimeStamp<-gsub(" AM:", ".", timeStart)
newTimeStamp<-gsub(" PM:", ".", timeStart)

newTime <- strptime(newTimeStamp, format="%m/%d/%Y %H:%M:%OS")

newTimeStamp2<-gsub(" AM:", ".", timeFinish)
newTimeStamp2<-gsub(" PM:", ".", timeFinish)

newTime <- strptime(newTimeStamp, format="%m/%d/%Y %H:%M:%OS")
newTime2 <- strptime(newTimeStamp2, format="%m/%d/%Y %H:%M:%OS")

column1 <- c(newTime)
column2 <- c(newTime2)
column3 <- data.frame(column2-column1)




  
  
  

 