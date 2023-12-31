*     Esta subrutina corrige los lugares en donde la dinamica da
*     negativa la cantidad de gotitas
*     revisada 28/01/99
      subroutine corgot
      implicit none

      include 'dimen.i'
      include 'permic.i'
      include 'lmngot.i'
      include 'corgot.i'

      write(*,*) 'dentro de corgot'

      neg1=0.
      pos1=0.
      do 10 n=ngot(1),ngot(2)
      do 10 l=lgot(1),lgot(2)
      do 10 m=mgot(1),mgot(2)
        if (Qgot2(l,m,n).lt.0.) then
          neg1=neg1+Qgot2(l,m,n)
*          write(*,*) l,m,n,neg1,Qgot2(l,m,n)
          Qgot2(l,m,n)=0
        else
          pos1=pos1+Qgot2(l,m,n)
*          write(*,*) l,m,n,pos1,Qgot2(l,m,n)
        endif
   10 continue

      if(pos1.le.-neg1) then
        write(*,*) 'problemas con las gotas',pos1,neg1
        do 20 l=lgot(1),lgot(2)
        do 20 m=mgot(1),mgot(2)
        do 20 n=ngot(1),ngot(2)
          Qgot2(l,m,n)=0.
   20   continue

        if (-neg1.gt.1e-3) then
          write(*,*) 'problemas graves'
          stop
        endif
      else
        aux1=neg1/pos1
        do 25 l=lgot(1),lgot(2)
        do 25 m=mgot(1),mgot(2)
        do 25 n=ngot(1),ngot(2)
          if(Qgot2(l,m,n).gt.0) Qgot2(l,m,n)=Qgot2(l,m,n)*(1.+aux1)
   25   continue

      endif

      return
      end

*********************************************************************

*     Esta subrutina corrige los lugares en donde la dinamica da
*     negativa la cantidad de gotas
*     revisada 8/01/99
      subroutine corllu
      implicit none

      include 'dimen.i'
      include 'permic.i'
      include 'lmnllu.i'
      include 'corgot.i'

*      write(*,*) 'dentro de corllu'

      neg1=0.
      pos1=0.
      do 10 n=nllu(1),nllu(2)
      do 10 l=lllu(1),lllu(2)
      do 10 m=mllu(1),mllu(2)
        if (Qllu2(l,m,n).lt.0.) then
          neg1=neg1+Qllu2(l,m,n)
          Qllu2(l,m,n)=0
        else
          pos1=pos1+Qllu2(l,m,n)
        endif
   10 continue

      if(pos1.le.-neg1) then
        write(*,*) 'problemas con las lluvia',pos1,neg1
        do 20 l=lllu(1),lllu(2)
        do 20 m=mllu(1),mllu(2)
        do 20 n=nllu(1),nllu(2)
          Qllu2(l,m,n)=0.
   20   continue

        if (-neg1.gt.1e-3) then
          write(*,*) 'problemas graves'
          stop
        endif
      else
        aux1=neg1/pos1
        do 25 l=lllu(1),lllu(2)
        do 25 m=mllu(1),mllu(2)
        do 25 n=nllu(1),nllu(2)
          if(Qllu2(l,m,n).gt.0) Qllu2(l,m,n)=Qllu2(l,m,n)*(1.+aux1)
   25   continue

      endif

      return
      end

*********************************************************************
*     Esta subrutina corrige los lugares en donde la dinamica da
*     negativa la cantidad de cristales
*     revisada 8/01/99
      subroutine corcri
      implicit none

      include 'dimen.i'
      include 'permic.i'
      include 'lmncri.i'
      include 'corgot.i'

*      write(*,*) 'dentro de corcri'

      neg1=0.
      pos1=0.
      do 10 n=ncri(1),ncri(2)
      do 10 l=lcri(1),lcri(2)
      do 10 m=mcri(1),mcri(2)
        if (Qcri2(l,m,n).lt.0.) then
          neg1=neg1+Qcri2(l,m,n)
          Qcri2(l,m,n)=0
        else
          pos1=pos1+Qcri2(l,m,n)
        endif
   10 continue

      if(pos1.le.-neg1) then
        write(*,*) 'problemas con las cristales',pos1,neg1
        do 20 l=lcri(1),lcri(2)
        do 20 m=mcri(1),mcri(2)
        do 20 n=ncri(1),ncri(2)
          Qcri2(l,m,n)=0.
   20   continue

        if (-neg1.gt.1e-3) then
          write(*,*) 'problemas graves'
          stop
        endif
      else
        aux1=neg1/pos1
        do 25 l=lcri(1),lcri(2)
        do 25 m=mcri(1),mcri(2)
        do 25 n=ncri(1),ncri(2)
          if(Qcri2(l,m,n).gt.0) Qcri2(l,m,n)=Qcri2(l,m,n)*(1.+aux1)
   25   continue

      endif

      return
      end

*********************************************************************
*$$
*     Esta subrutina corrige los lugares en donde la dinamica da
*     negativa la cantidad de nieve
*     revisada 11/01/99
      subroutine cornie
      implicit none

      include 'dimen.i'
      include 'permic.i'
      include 'lmnnie.i'
      include 'corgot.i'

*      write(*,*) 'dentro de cornie'

      neg1=0.
      pos1=0.
      do 10 n=nnie(1),nnie(2)
      do 10 l=lnie(1),lnie(2)
      do 10 m=mnie(1),mnie(2)
        if (Qnie2(l,m,n).lt.0.) then
          neg1=neg1+Qnie2(l,m,n)

*##
*      write(*,*) 'niev',l,m,n,Qnie2(l,m,n)
*##

          Qnie2(l,m,n)=0
        else
          pos1=pos1+Qnie2(l,m,n)
        endif
   10 continue

      if(pos1.le.-neg1) then
        write(*,*) 'problemas con las nieve',pos1,neg1
        do 20 l=lnie(1),lnie(2)
        do 20 m=mnie(1),mnie(2)
        do 20 n=nnie(1),nnie(2)
          Qnie2(l,m,n)=0.
   20   continue

        if (-neg1.gt.1e-3) then
          write(*,*) 'problemas graves'
          stop
        endif
      else
        aux1=neg1/pos1
        do 25 l=lnie(1),lnie(2)
        do 25 m=mnie(1),mnie(2)
        do 25 n=nnie(1),nnie(2)
          if(Qnie2(l,m,n).gt.0) Qnie2(l,m,n)=Qnie2(l,m,n)*(1.+aux1)
   25   continue

      endif

      return
      end

*********************************************************************
*     Esta subrutina corrige los lugares en donde la dinamica da
*     negativa la cantidad de granizos
*     revisada 2/02/99
      subroutine corgra
      implicit none

      include 'dimen.i'
      include 'permic.i'
      include 'lmngra.i'
      include 'corgot.i'

*      write(*,*) 'dentro de corgra'

      neg1=0.
      pos1=0.
      do 10 n=ngra(1),ngra(2)
      do 10 l=lgra(1),lgra(2)
      do 10 m=mgra(1),mgra(2)
        if (Qgra2(l,m,n).lt.0.) then
          neg1=neg1+Qgra2(l,m,n)
          Qgra2(l,m,n)=0
        else
          pos1=pos1+Qgra2(l,m,n)
        endif
   10 continue

      if(pos1.le.-neg1) then
        write(*,*) 'problemas con las granizos',pos1,neg1
        do 20 l=lgra(1),lgra(2)
        do 20 m=mgra(1),mgra(2)
        do 20 n=ngra(1),ngra(2)
          Qgra2(l,m,n)=0.
   20   continue

        if (-neg1.gt.1e-3) then
          write(*,*) 'problemas graves'
          stop
        endif
      else
        aux1=neg1/pos1
        do 25 l=lgra(1),lgra(2)
        do 25 m=mgra(1),mgra(2)
        do 25 n=ngra(1),ngra(2)
          if(Qgra2(l,m,n).gt.0) Qgra2(l,m,n)=Qgra2(l,m,n)*(1.+aux1)
   25   continue

      endif

      return
      end

*********************************************************************

*     Esta subrutina corrige los lugares en donde la dinamica da
*     negativa la cantidad de vapor
*     revisada 8/01/99
      subroutine corvap(Qvapneg)
      implicit none

      include 'dimen.i'
      include 'permic.i'
      include 'estbas.i'
      include 'corvap.i'

      write(*,*) 'dentro de corvap',Qvap2(15,17,22),Qvap0(22)

      do 10 k=1,nz1
        dq=Qvapneg*Qvaprel(k)/nx1**2.
        do 15 i=1,nx1
        do 15 j=1,nx1
          Qvap2(i,j,k)=Qvap2(i,j,k)+dq
          if (Qvap2(i,j,k)+Qvap0(k).lt.0) Qvap2(i,j,k)=-Qvap0(k)
   15   continue
   10 continue

      write(*,*) Qvap2(15,17,22),Qvap0(22)

      return
      end

*********************************************************************

*     Esta subrutina corrige los lugares en donde la dinamica da
*     negativa la cantidad de aerosoles
*     revisada 14/09/99
      subroutine coraer(aerneg)
      implicit none

      include 'dimen.i'
      include 'permic.i'
      include 'estbas.i'
      include 'coraer.i'

      write(*,*) 'dentro de coraer'

      do 10 k=1,nz1
        dq=aerneg*aerrel(k)/nx1**2.
        do 15 i=1,nx1
        do 15 j=1,nx1
          aer2(i,j,k)=aer2(i,j,k)+dq
          if (aer2(i,j,k)+aer0(k).lt.0) aer2(i,j,k)=-aer0(k)
   15   continue
   10 continue

      return
      end
