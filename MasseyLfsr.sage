def myLFSR(initialstates, coef, num):
  coefficients = list(coef) # for polynomial
  ints = []
  # short list of initial states
  for h in range(0,len(coefficients)-1):
    ints.insert(h,initialstates[h])
  for j in range(0,num): 
     t = 0
     for k in range(0,len(coefficients)-1):
       t -= coefficients[k]*ints[k+j]
     ints.append(t)
  return ints


def mirror(p):
  l=list(p)
  l.reverse()
  return p.parent()(l)
  
def myBerlekampMassey(S):
  L = 0
  cx.<x> = PolynomialRing(RationalField())
  px.<x> = PolynomialRing(RationalField()) 
  cx = 1
  px = 1 
  tx.<x> = PolynomialRing(RationalField()) 
  l = 1
  d = dm = 1
  a = 0
  for k in range(1,len(S)): 
    a = 0
    j = 1
    while j <= L:
      a = a + cx[j]*S[k-j]
      j = j + 1
    d = S[k] + a 
    if d == 0: 
      l = l + 1    
    else:
      if (2*L >= k):
         cx = cx - d/dm * px * x^l
         l = l + 1 
      else:
         tx = cx 
         cx = cx - d/dm * px * x^l
         px = tx
         L = k - L
         dm = d
         l = 1
  mcx=mirror(cx)
  #mcx = cx
  return mcx
  #LFSR(S, list(mcx), 10)

print "***********************************************"
print "myBerlekampMassey([Initial Sequence])"
print "myLFSR([Initial States], [coefficients], number)"
print "***********************************************"
coefficients.<x> = PolynomialRing(RationalField()) #it works with this
