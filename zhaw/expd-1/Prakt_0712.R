# ---- Datum ----
Sys.Date()

Sys.time()

as.Date("12.12.2023", format="%d.%m.%Y")
?strptime

Sys.getlocale()
Sys.setlocale("LC_TIME", locale = "en_US")

as.Date("2014-04-22")

Sys.time()

as.POSIXct("12.12.2023 12:12:12", format = "%d.%m.%Y %H:%M:%S")

# ---- Eigene Funktionen ----

funname <- function(test){
  ergebnis <- test * 3
  return(ergebnis)
}

funname(10)

# Falls mehrer Werte Zurückgegeben werden
ftest <- function(test){
  ergebnis1 <- test * 2
  ergebnis2 <- test * 3
  ret <- list(erg1 = ergebnis1, erg2 = ergebnis2)
  return(ret) # Braucht es nicht umbedingt -> list(erg1 = ergebnis1, erg2 = ergebnis2) reicht aus
}

foo <- ftest(10)

foo$erg1

# Defaults für parameter
ftest <- function(test, test_names = c("test1", "test2")){
  ergebnis1 <- test * 2
  ergebnis2 <- test * 3
  ret <- list(erg1 = ergebnis1, erg2 = ergebnis2)
  names(ret) <- test_names
  return(ret)
}

foo <- ftest(10)

foo$test1

foo <- ftest(20, c("test0", "test1"))
foo$test0


# Mit ... können args mitgegeben werden.

