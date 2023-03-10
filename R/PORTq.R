PORT.q = function (x, k, q1, q2, method=c("PMOP", "PRBMOP"))  
{ 
   n = length(x) 
  
  nq = floor(n*q1) + 1
   
  # Checking for plausible inputes
  
  if (isTRUE(nq < 2)) 
  {
    stop("Insufficient data vector, check sample size and q.")
  }
    
   if (is.null(k) || isTRUE(any(is.na(k))))
   {
     stop("k is not specified")
   }
   
   if (isTRUE(any(k < 1)) || isTRUE(any(k > n-nq -1)) || isTRUE(any(k == n-nq -1))  || !is.numeric(k)   || isTRUE(any(k != as.integer(k)))  )
   {
     stop("k must be greater than or equal to 1 and less than exceedance sample size.")
   }
  
  if (!is.numeric(x)) {
    stop("some of the data points are not real.")
  }
  
  
  if ( q1 < 0 || q1 > 1 || !is.numeric(q1)) 
  {
    stop("q1 must lie between 0 and 1.")
  }
  
  
  if ( q2 < 0 || q2 > 1 || !is.numeric(q2)) 
  {
    stop("q2 must lie between 0 and 1.")
  }
  
   
  method = match.arg(method)
  
  osx = sort(x) 
   
    
  PORTEVI = PORT.Hill(x,k,q1,method)
  PORTEVI = PORTEVI$PORT.EVI
  
   dk = length(k)
   PORTVaR = numeric(dk)
   
   PORTVaR =   (osx[n-k]- osx[nq] )  * (k/(n*q2))^PORTEVI + osx[nq]
   
   
   PORTVaR = as.matrix(PORTVaR)
   rownames(PORTVaR)= k 
   return(list(PORT.EVI=PORTEVI,PORT.HQ=PORTVaR))
 
   
}
