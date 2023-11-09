module velpre01
   integer :: t
   real :: dvx, dvy, dvz, diver
   real :: dprex, dprey, dprez
   real :: vel0, vel1, vel2, vel3
   real :: presi, presix, presiy, presiz
   real :: facx, facy, facz
   integer :: i, j, k
   real :: prom1, prom, kkk, presprom, nnn
contains
   subroutine velpre01_init()
      USE dimen
      implicit none
      facx=.05
      facy=.05
      facz=.05

      prom=.3/6.*(dt3/.2)
      prom1=1.-prom*6.
      kkk=.01
      nnn=(nx1+2)**2.*(nz1+1)

   end subroutine velpre01_init
end module velpre01

module aeroana
!> Variables de aeroana
    USE dimen
    integer tt,t1,t2,n,m,l,i,j,k,lll,s,iT,tte
    integer lvapneg,llluneg,lcrineg,laerneg,lnieneg,lgraneg,yy
    real T,P
    real Dv,Lvl,Lvs,Lsl,Vis,Qvap,Qliq,densi,nu
    real Lsl00
    real Eaucn,Eaccn,Eacng
    real*8 qgotaux,qvapaux,qlluaux,qcriaux,qnieaux,qgraaux,aeraux
    real*8 auxx,auxy,auxz
    real*8 Taux,Qvapneg,aerneg
    real Naer,dqgot,dqcri,daer,daer2
    real Fcal
    real elvs,esvs,e1,rl,rs,dden0z
    real aux,aux1,aux2,aux3,aux4
    real*8 ener,ener1,ener2,ener3,ener4,ener5,qv,qg,daitot
    real*8 vapt1,vapt2,vapt3,vapt4
    real*8 gott1,gott2,gott3,gott4
    real*8 aert1,aert2,aert3,aert4
    real*8 totnuc,totmic
    real cks,turbu,lapla
    real aerdif(-3:nx1+3,-3:nx1+3,-3:nz1+3)
 
 contains
    subroutine aeroana_init()
       ctur=.5
       lt2=nint(dt1/dt2)
       lt3=2*nint(dt1/dt3)
       cteturb=ctur/2.**.5
       cks=cteturb*2.
       dx2=2.*dx1
       dx8=8.*dx1
       dx12=12.*dx1
       AA=1./Eps-1.
       ikapa=1./Kapa
       cteqgot=160./3**6.*pi*rhow*N0got
       cteqllu=8.*pi*rhow*N0llu
       cteqnie=.6*pi*rhonie*N0nie
       cteqgra=8.*pi*rhogra*N0gra
       tte=0
    end subroutine aeroana_init
 
 end module aeroana
 