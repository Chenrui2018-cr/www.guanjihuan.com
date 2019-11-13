module global ! module��������װ����ģ��ģ�����ع��ܵı����ͺ�����װ��һ��һ����˵�����Բ�����ȫ�ֱ���������Щ����д��module�����Ҫ�õĵط���use���ü��ɡ�
  implicit none
  double precision sqrt3,Pi 
  parameter(sqrt3=1.7320508075688773d0,Pi=3.14159265358979324d0)  ! parameter�����ܸĵĳ���
 end module global 
    

    
    
program main  !��������program��ʼ,��end program��������Fortran�ﲻ���ִ�Сд���ø�̾�ţ�����ע��
use global
use f95_precision   !�������֪��ʲôʱ�����ϣ�����ע�͵�Ҳ���������С�
use blas95  ! ��������˾�����˵�gemm()��
use lapack95 !��������˾��������GETRF,GETRI������ʸ�ͱ���ʸ��GEEV��
implicit none  ! implicit����������Ĭ�����ͣ������ݱ������Ƶĵ�һ����ĸ���������������͡�implicit none�ǹر�Ĭ�����͹��ܣ����б���Ҫ������


integer i,j,info,index1(2) ! ��������
double precision a(2,2),b(2,2),c(2,2),&  ! �Ƚϳ�����������&���С������еĿ�ʼλ�ÿɼ�&�ţ�Ҳ�ɲ��ӡ�
    x1, x2, result_1, result_2, fun1   !����˫���ȸ�����
complex*16  dd(2,2), eigenvalues(2)  !���帴��
complex*16, allocatable::  eigenvectors(:,:)  ! ���嶯̬����ı���  �����������ð��::�Ǳ���Ҫ�ġ������Ŀɼӿɲ��ӡ�
character(len=15) hello, number  ! �����ַ���,len�ǹ涨���ȣ������д��ֻ���һ���ַ��Ŀռ�
allocate(eigenvectors(2,2))  ! ����ռ�


write(*,*) '----���----'
hello='hello world'
write(*,*) hello  ! ��һ������������豸��*������Ļ���ڶ���������ĸ�ʽ��*����Ĭ�ϡ�
write(number,'(f7.3)') pi  ! ��write���԰���������ת���ַ����͡�'(f7.3)'������������ĸ�ʽ�������*�����棬�ַ����ĳ�����Ҫ�������롣���͸�ʽ������'(i3)'����
write(*,*) '����ת���ַ����������:', number
write(*,"(a,18x)",advance="no") hello   ! advance='no'�������У�����advance��ʱ�򣬱����ʽ����������򱨴�'(a)'�����ַ��ͱ�����ʵ�ʳ��ȶ�ȡ������Ҳ����дa15����������'(10x)'����ո�
write(*,*) number,'���ǲ������������'
write(*,"('һЩ�̶�����Ҳ����д��������', a, a,//)")  hello, number  !�ַ���Ҳ����ֱ��д��"()"���档���������ţ�����Ҫ����˫���Ų��У���Ȼ�ᱨ��
!'(a)'�����ַ��ͱ�����ʵ�ʳ��ȶ�ȡ��Ҳ����дa15��������������'(/)'�����ٻ�һ���С�һ��б�ܻ�һ����


write(*,*) '----д���ļ�----'
open(unit=10,file='learn-fortran-test.txt')   ! ���ļ���open
write(10,*) hello, number
close(10)  ! �ر��ļ���close
write(*,*) ''

write(*,*) '----����˻�----'
a(1,1)=2;a(1,2)=5;a(2,1)=3;a(2,2)=2  ! �������д��ͬһ���ǿ��Եģ�Ҫ�÷ֺŸ���
b(1,1)=3;b(2,2)=3
write(*,*) '����ֱ��Ĭ��������ǰ��е�˳��һ�������'
write(*,*) 'a='
write(*,*) a
write(*,*) '�����ʽ�����'
write(*,*) 'a='
do i=1,2
    do j=1,2
        write(*,'(f10.4)',advance='no') a(i,j)  !ѭ���ڲ��������
    enddo
    write(*,*) ''
enddo
write(*,*) 'b='
do i=1,2
    do j=1,2
        write(*,'(f10.4)',advance='no') b(i,j)  !ѭ���ڲ��������
    enddo
    write(*,*) ''
enddo
call gemm(a,b,c)  ! ����˻���call gemm()
write(*,*) '����˻���c=a*b='
do i=1,2
    do j=1,2
        write(*,'(f10.4)',advance='no') c(i,j)  !ѭ���ڲ��������
    enddo
    write(*,*) ''
enddo
write(*,*)  ''


write(*,*) '----��������----'
call getrf(a,index1,info);  call getri(a,index1,info)  !getrf��getriҪ�������ʹ�����档
! info���趨��Ϊ���͡�If info = 0, the execution is successful.
! ����index1����getrf��������getri�����롣index1Ҳ����Ҫ����Ϊ���ͣ�������һά���飬���鳤��һ��Ϊ�����ά�ȡ�
! ��ʱ��a������ԭ���ľ����ˣ����������ľ���
do i=1,2
    do j=1,2
        write(*,'(f10.4)',advance='no') a(i,j)  !ѭ���ڲ��������
    enddo
    write(*,*) ''
enddo


write(*,*) '----��������----'
dd(1,1)=(1.d0, 0.d0)
dd(1,2)=(7.d0, 0.d0)
dd(2,1)=(3.d0, 0.d0)
dd(2,2)=(2.d0, 0.d0)
do i=1,2
    do j=1,2
        write(*,"(f10.4, '+1i*',f7.4)",advance='no') dd(i,j)  !ѭ���ڲ��������
    enddo
    write(*,*) ''
enddo
write(*,*)  ''


write(*,*) '----������ʸ�ͱ���ֵ----'
call geev(A=dd, W=eigenvalues, VR=eigenvectors, INFO=info)  ! ����A����������ϸ�����W�Ǳ���ֵһά���飬VR�Ǳ���ʸ��ά���飬���Ǹ�����INFO��������
! ע�����걾��ֵ��dd��ֵ�ᷢ���ı䣬������ԭ������!!!!!!!
write(*,*) 'eigenvectors:'
do i=1,2
    do j=1,2
        write(*,"(f10.4, '+1i*',f7.4)",advance='no') eigenvectors(i,j)  !ѭ���ڲ�������С���������Ӧ���Ǳ���ʸ����
    enddo
    write(*,*) ''
enddo
write(*,*) 'eigenvalues:'
do i=1,2
        write(*,"(f10.4, '+1i*',f7.4)",advance='no') eigenvalues(i)  !ѭ���ڲ��������
enddo
write(*,*)  ''
deallocate(eigenvectors)  ! �ͷŶ�̬�����Ŀռ�


write(*,*) ''  ! �����һ��
write(*,*) '----ѭ�����ж�----'
do i=1,5  ! ѭ����do��enddo
    if (mod(i,2)==0) then  ! �ж���if()then 
        write(*,*) '����ż��', i   
    else if (i==3) then
        write(*,*) '���ǵ�3�����֣�Ҳ������'
    else
        write(*,*) '��������', i
    endif
enddo
write(*,*) ''


call sub1(2.d0, 3.d0, result_1, result_2)   ! ����Ҫд��2.d0����2.0d0��ʾ˫���ȣ���Ϊ�ӳ���涨�ò���Ϊ˫���ȡ�д��2����2.0���ᱨ��
write(*,*) '�����ӳ�����ͣ�',result_1
write(*,*) '�����ӳ��򣬳˻���',result_2
write(*,*) 'ʹ�ú��������ؼ��������', fun1(2.d0, 3.d0)
write(*,*) ''


end program


    
subroutine sub1(x1,x2,y1,y2)  !�ӳ���������������������棬��call���á�
double precision,intent(in):: x1, x2   ! ���������ð��::�Ǳ���Ҫ�ġ�
double precision,intent(out):: y1, y2
! intent(in) ��ʾ�������������ģ�intent(out) ��ʾ����������ģ�intent(inout)��ʾ�������ͬʱ����������������ݴ��ݣ�
! intent()���Ǳ���ģ�����ü��ϣ���Ϊ�ɶ��ԱȽ�ǿ��֪����Щ�����룬��Щ�����������intent(in)�ǲ��ܸ�ֵ���ĵģ�����ʾ�����������Է�ֹһЩ����
y1=x1+x2
y2=x1*x2
end subroutine


    
function fun1(x1,x2) ! ����������ֻ�ܷ���һ����ֵ�����ܶ�������ӳ�����Է��ض��������һ�����ӳ���subroutine
double precision x1,x2,fun1  ! Ҫ�Ժ�����(�򷵻ر���������
fun1=x1-x2    ! ���ر���Ҫ�ͺ�����һ��
return        ! �����returnҲ���Բ�д��д��������ֱ�ӷ���ֵ���������к���Ĵ��롣һ����if����á�
end function  ! Ҳ����ֱ��дend�����ᱨ������ðѺ����Ҳ���ϣ��������Ƚ������㡣