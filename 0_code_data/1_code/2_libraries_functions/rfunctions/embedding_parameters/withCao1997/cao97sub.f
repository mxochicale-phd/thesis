c
c e1 and e2 values in fortran application differ
c slighly from the values in the wrapped function in R,
c since the the later use 16 decimal places
c

      subroutine cao97sub(x,ndp,maxd,tau,e1,e2)

      integer ndp, d, maxd, tau, maxtau
      double precision x(1:ndp),e1(1:maxd),e2(1:maxd),v(50),a(50),ya(50),v0,vij

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
 50         vij=v(d)
              if (vij.lt.v0.and.vij.ne.0.) then
                n0=j
                v0=vij
             endif
 20         continue
          enddo
          a(d)=a(d)+max(v0,abs(x(i+d*tau)-x(n0+d*tau)))/v0
          ya(d)=ya(d)+abs(x(i+d*tau)-x(n0+d*tau))
        enddo
        a(d)=a(d)/float(ng)
        ya(d)=ya(d)/float(ng)
        !write (*,*) a(d), ya(d)
        if (d.ge.2) then
         !write(*,*) d-1,' E1=', a(d)/a(d-1), ' E2=', ya(d)/ya(d-1)
         e1(d-1) = a(d) / a(d-1)
         e2(d-1) = ya(d) / ya(d-1)
      endif
      enddo
      end
