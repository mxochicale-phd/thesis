***************************************************************************
*      Pratical method for determing the minimum embedding dimension      *
*                     if a scalar time series                             *
*           L. Cao, Physica D, 110 (1 & 2), 43-52, 1997.                  *
*                                                                         *
*   Notices:   This program is ONLY used for your researches.             *
*                                                                         *
*	                                Liangyue Cao       March,1997.    *
***************************************************************************
      dimension x(100000),v(50),a(50),ya(50)
      double precision  v,v0,vij
      integer d, tau

***************************************************************************
*     ndp  is the number of data points used for your calculation;
*     ndp  should be smaller than 100000; 
*     tau  is the time-delay used for phase space reconstructions;
*     maxd is the maximum dimension which you want to test;
*     maxd should be smaller than 50.
***************************************************************************
      Ndp=10000  		! Number of data points
      tau=15 			! Time delay value
      maxd=10			! Maximum embedding dimension 
      open(9,file='measurement.dat')              ! Data file
      open(10,file='E1.dat')
      open(11,file='E2.dat')             ! Result file
      read(9,*) (x(i),i=1,ndp)
      do d=1,maxd
	a(d)=0.
	ya(d)=0.
	ng=ndp-d*tau
	do i=1,ng
	  v0=1.e+30
	  do j=1,ng
	    if(j.eq.i) go to 20
	    do k=1,d
	      v(k)=abs(x(i+(k-1)*tau)-x(j+(k-1)*tau))
            enddo
	    if (d.eq.1) go to 50
	    do k=1,d-1
	      v(k+1)=max(v(k),v(k+1))
            enddo
 50	    vij=v(d)
	    if (vij.lt.v0.and.vij.ne.0.) then
	        n0=j
	        v0=vij
	    endif
 20	    continue
          enddo
	  a(d)=a(d)+max(v0,abs(x(i+d*tau)-x(n0+d*tau)))/v0
	  ya(d)=ya(d)+abs(x(i+d*tau)-x(n0+d*tau))
        enddo
 	a(d)=a(d)/float(ng)
 	ya(d)=ya(d)/float(ng)
	if (d.ge.2) then
	    write(11,*) d-1,ya(d)/ya(d-1)
	    write(10,*) d-1, a(d)/a(d-1)
            write(*,*) d-1,'   E1=', a(d)/a(d-1),
     $             '    E2=', ya(d)/ya(d-1)
	endif
      enddo
      close(10)
      close(11)
      call system("xmgrace E2.dat")
      end
