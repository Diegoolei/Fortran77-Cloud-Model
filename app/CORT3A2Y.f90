program cort3a2y
   USE dimen
   USE estbas
   USE advecs
   USE const
   Use permic
   use perdim
   implicit none

   character*11 directorio
   integer ii,i,j,k,l,m,n,ymax
   integer pasoaux(25),lvar,nvar
   parameter (nvar=13)
   real*8 aux,maypre
   character*100 paso
   character*2 nombre
   character*25 arch,archaux
   character*2 var(13)
   integer*4 variable(nx1,nz1,nvar)


!**   datos generales
   nombre='31'
   var(1)='UU'
   var(2)='VV'
   var(3)='WW'
   var(4)='TT'
   var(5)='GO'
   var(6)='LL'
   var(7)='CR'
   var(8)='NI'
   var(9)='GR'
   var(10)='VA'
   var(11)='AE'
   var(12)='V1'
   var(13)='A1'


   paso='01020304050607080910111213141516171819202122232425'&
        //'26272829303132333435363738394041424344454647484950'
   pasoaux(1)=0
   pasoaux(2)=0
   pasoaux(3)=0
   pasoaux(4)=0
   pasoaux(5)=0
   pasoaux(6)=0
   pasoaux(7)=0
   pasoaux(8)=0
   pasoaux(9)=0
   pasoaux(10)=0
   pasoaux(11)=0
   pasoaux(12)=0
   pasoaux(13)=0
   pasoaux(14)=0
   pasoaux(15)=0
   pasoaux(16)=1
   pasoaux(17)=1
   pasoaux(18)=1
   pasoaux(19)=0
   pasoaux(20)=0
   pasoaux(21)=0
   pasoaux(22)=0
   pasoaux(23)=0
   pasoaux(24)=0
   pasoaux(25)=0
   directorio = "outputdata/"
!*    lectura de los datos generales y de base

   open(50, file = directorio//'inis.da')

   open(unit=30,file=directorio//'varconz.da',status='unknown',form='unformatted')

   read(50,*) Den0,Temp0,Tita0,Pres00,Qvap0,cc2,aer0,UU,VV
   read(30)  Tvis,Tlvl,Tlsl,Tlvs,Telvs,Tesvs,Av,Vtnie,Vtgra0,&
                Qvaprel,aerrel,Eautcn,Eacrcn

   close(30)
   close(50)

   open(40,file=directorio//'cortes/possy')

   write(*,*) 'aqui'

   do 10 ii=1,25
      if(pasoaux(ii).eq.1) then

!*        lectura de la nube
         write(*,*) 

         open(unit=60,file=directorio//'nube'//nombre//&
         paso(ii*2-1:ii*2)//'.sal',status='unknown',&
             form='unformatted')
         read(60) U1,V1,W1,Titaa1,Pres1,Qvap1,Qgot1,Qllu1,Qcri1,Qnie1&
                   ,Qgra1,aer1
         close(60)

         write(*,*) W1(nx1/2,nx1/2,15),W1(nx1/2,nx1/2,20)

!*        determinacion del maximo Y de la precipitacion
         ymax=0.
         maypre=0.
         do 300 i=1,nx1
            do 300 j=1,nx1
               do 300 k=1,nz1
                  if (maypre.lt.Qgra1(i,j,k)+Qllu1(i,j,k)+Qgot1(i,j,k)) then
                     maypre=Qgra1(i,j,k)+Qllu1(i,j,k)+Qgot1(i,j,k)
                     ymax=j
                  endif
300      continue

         write(40,*) ii,ymax,maypre

!*        cortes (no incluyen el piso)
         j=ymax
         do 50 i=1,nx1
            do 50 k=1,nz1
!           calculo de la temperatua
               aux=Pres00(k)+Pres1(i,j,k)
               variable(i,k,4)=(Tita0(k)+Titaa1(i,j,k))*aux*1e2

!           velocidades
               variable(i,k,1)=(UU(k)+U1(i,j,k))*1e3
               variable(i,k,2)=(VV(k)+V1(i,j,k))*1e3
               variable(i,k,3)=W1(i,j,k)*1e3

!           filtrado de gotitas
               aux=0.
               do 200 l=i-1,i+1
                  do 200 m=j-1,j+1
                     do 200 n=k-1,k+1
                        aux=aux+Qgot1(l,m,n)*1e6
200            continue
               variable(i,k,5)=aux/27.
!           filtrado de lluvia
               aux=0.
               do 210 l=i-1,i+1
                  do 210 m=j-1,j+1
                     do 210 n=k-1,k+1
                        aux=aux+Qllu1(l,m,n)*1e6
210            continue
               variable(i,k,6)=aux/27.*.5+Qllu1(i,j,k)*1e6*.5
!           filtrado de cristales
               aux=0.
               do 220 l=i-1,i+1
                  do 220 m=j-1,j+1
                     do 220 n=k-1,k+1
                        aux=aux+Qcri1(l,m,n)*1e6
220            continue
               variable(i,k,7)=aux/27.
!           filtrado de nieve
               aux=0.
               do 230 l=i-1,i+1
                  do 230 m=j-1,j+1
                     do 230 n=k-1,k+1
                        aux=aux+Qnie1(l,m,n)*1e6
230            continue
               variable(i,k,8)=aux/27.
!           filtrado de granizos
               aux=0.
               do 240 l=i-1,i+1
                  do 240 m=j-1,j+1
                     do 240 n=k-1,k+1
                        aux=aux+Qgra1(l,m,n)*1e6
240            continue
               variable(i,k,9)=aux/27.*.5+Qgra1(i,j,k)*1e6*.5

               variable(i,k,10)=(Qvap0(k)+Qvap1(i,j,k))*1e6
               variable(i,k,11)=(aer0(k)+aer1(i,j,k))*1e1
               variable(i,k,12)=Qvap1(i,j,k)*1e6
               variable(i,k,13)=aer1(i,j,k)*1e1
50       continue

         do 80 lvar=1,nvar
            archaux=var(lvar)//nombre//&
                          'y'//paso(ii*2-1:ii*2)
            write(*,*) archaux
            open(100+lvar,file=directorio//'cortes/'//archaux)
            do 90 k=1,nz1
               write(100+lvar,1000) (variable(j,k,lvar),j=1,nx1)
90          continue
            close(100+lvar)
80       continue

      endif
10 continue

1000 format(50i7)
end
