mailSoc <- function(login,
                    pass,
                    serv = "imap.gmail.com", #specify IMAP server
                    ntore = 50, #ignore if addressed to more than
                    todow = -1, #how many to download
                    begin = -1){  #from which to start
  
  #load rJython and Python libraries
  require(rJython)  
  rJython <- rJython(modules = "imaplib")
  rJython$exec("import imaplib")
  
  #connect to server
  rJython$exec(paste("mymail = imaplib.IMAP4_SSL('",
                     serv, "')", sep = ""))
  rJython$exec(paste("mymail.login(\'",
                     login, "\',\'",
                     pass, "\')", sep = ""))
  
  #get number of available messages
  rJython$exec("sel = mymail.select()")
  rJython$exec("number = sel[1]")
  nofmsg <- .jstrVal(rJython$get("number"))
  nofmsg <- as.numeric(unlist(strsplit(nofmsg, "'"))[2])
  
  #if 'begin' not specified begin from the newest
  if(begin == -1)
  {
    begin <- nofmsg
  }
  
  #if 'todow' not specified download all
  if(todow == -1)
  {
    end <- 1
  }
  else
  {
    end <- begin - todow
  }
  
  #give a little bit of information
  todownload <- begin - end
  print(paste("Found", nofmsg, "emails"))
  print(paste("I will download", todownload, "messages."))
  print("It can take a while")
  
  data <- data.frame()
  
  #fetching emails
  for (i in begin:end) {
    nr <- as.character(i)
    
    #get sender
    rJython$exec(paste("typ, fro = mymail.fetch(\'", nr, "\', \'(BODY[HEADER.FIELDS (from)])\')", sep = ""))
    rJython$exec("fro = fro[0][1]")
    from <- .jstrVal(rJython$get("fro"))
    from <- unlist(strsplit(from, "[<>\r\n, \"]"))
    from <- sub("from: ", "", from, ignore.case = TRUE)
    from <- grep("@", from, value = TRUE)
    
    #get addresees
    rJython$exec(paste("typ, to = mymail.fetch(\'", nr, "\', \'(BODY[HEADER.FIELDS (to)])\')", sep = ""))
    rJython$exec("to = to[0][1]")
    to <- .jstrVal(rJython$get("to"))
    to <- unlist(strsplit(to, "[<>\r\n, \"]"))
    to <- sub("to: ", "", to, ignore.case = TRUE)
    from <- sub("\"", "", from, ignore.case = TRUE)
    to  <- grep("@", to, value = TRUE)
    
    #if reasonable number of addressses add to data frame
    if(length(to) <= ntore){
      vec <- rep(from, length(to))
      data <- rbind(data, data.frame(vec, to))
    }
    
    #give some information about progress
    if((i - begin) %% 100 == 0)
    {
      print(paste((i - begin)*(-1), "/", todownload,
                  " Downloading...", sep = ""))
    }
  }
  names(data) <- c("from", "to")
  data$from <- tolower(data$from)
  data$to <- tolower(data$to)
  
  #close connection
  rJython$exec("mymail.shutdown()")
  return(data)
}
Now we can run eg.

#download 200 most recent emails from gmail account
maild <- mailSoc("login", "password", serv = "imap.gmail.com",
                 ntore = 40, todow = 200)
And to make a plot it is necessary to load network library

library(network)
mailnet <- network(maild)
plot(maild)

library(igraph)
h <- graph.data.frame(maild, directed = FALSE)
tkplot(h, vertex.label = V(h)$name,
       layout=layout.fruchterman.reingold)