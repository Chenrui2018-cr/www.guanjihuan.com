program hello_open_mp
    use omp_lib   !����Ҳ����д�� include 'omp_lib.h' �����ߵ��÷�ʽ����
    integer mcpu,tid,total,N,i,j,loop
    double precision starttime, endtime, time,result_0
    double precision, allocatable:: T(:)
    N=5   ! ����do����
    loop=1000000000  !���Ҫ���Բ��кʹ�������ʱ�䣬���ԼӴ�loopֵ
    allocate(T(N))
   
    
    !call OMP_SET_NUM_THREADS(2)  !��Ϊ�����̸߳���������ȡ��ע�Ϳ�Ч��
    total=OMP_GET_NUM_PROCS()  ! ��ȡ�����ϵͳ�Ĵ���������
    print '(a,i2)',  '�����������������' , total    !Ҳ������write(*,'(a,i2)')�����
    print '(a)', '-----�ڲ���֮ǰ-----'
    tid=OMP_GET_THREAD_NUM()    !��ȡ��ǰ�̵߳��̺߳�
    mcpu=OMP_GET_NUM_THREADS()  !��ȡ�ܵ��߳���
    print '(a,i2,a,i2)', '��ǰ�̺߳ţ�',tid,'���ܵ��߳�����', mcpu
    print *   !������

    
    print'(a)','-----��һ���ֳ���ʼ����-----'
    !$OMP PARALLEL DEFAULT(PRIVATE)   ! �����õ���DEFAULT(PRIVATE)
    tid=OMP_GET_THREAD_NUM()    !��ȡ��ǰ�̵߳��̺߳�
    mcpu=OMP_GET_NUM_THREADS()  !��ȡ�ܵ��߳���
    print '(a,i2,a,i2)', '��ǰ�̺߳ţ�',tid,'���ܵ��߳�����', mcpu
    !$OMP END PARALLEL
    
    
    print *  !������
    print'(a)','-----�ڶ����ֳ���ʼ����-----'
    starttime=OMP_GET_WTIME()   !��ȡ��ʼʱ��
   !$OMP PARALLEL DO DEFAULT(PRIVATE) SHARED(T,N,loop)   ! Ĭ��˽�б���������Ҫ�Ĳ����Լ����ڵ�������Ĵ������Ϊ���������
    do i=1,N     !�������doѭ���塣�Ƕ����Ʒ��
        result_0=0
        tid=OMP_GET_THREAD_NUM()    !��ȡ��ǰ�̵߳��̺߳�
        mcpu=OMP_GET_NUM_THREADS()  !��ȡ�ܵ��߳���
        do j=1,loop                 !���������Ҫ���ļ���~
            result_0 = result_0+1   !���������Ҫ���ļ���~
        enddo                       !���������Ҫ���ļ���~
        T(i) = result_0-loop+i      !�������̵߳ļ��������浽����������ȥ��
        !����i�������ѭ���Ĳ�����֮���������Ҫ���Ը��ݲ������������ݡ�
        print '(a,i2, a, f10.4,a,i2,a,i2 )', 'T(',i,')=', T(i) , '    ��Դ���̺߳�',tid,'���ܵ��߳�����', mcpu
    enddo
    !$OMP END PARALLEL DO   !���н���
    endtime=OMP_GET_WTIME()  !��ȡ����ʱ��
    time=endtime-starttime   !������ʱ��
    print '(a, f13.5)' , '�ڶ����ֳ��򰴲��м������õ�ʱ�䣺', time
    
   
    print *  !������
    print'(a)','-----�ڶ����ֳ��򰴴��еļ���-----'
    starttime=OMP_GET_WTIME()    !��ȡ��ʼʱ��
    do i=1,N  
        result_0=0
        tid=OMP_GET_THREAD_NUM()    !��ȡ��ǰ�̵߳��̺߳�
        mcpu=OMP_GET_NUM_THREADS()  !��ȡ�ܵ��߳���
        do j=1,loop
            result_0 = result_0+1  
        enddo 
        T(i) = result_0-loop+i
        print '(a,i2, a, f10.4,a,i2,a,i2 )', 'T(' ,i,')=', T(i) , '    ��Դ���̺߳�',tid,'���ܵ��߳�����', mcpu
    enddo
    endtime=OMP_GET_WTIME()  !��ȡ����ʱ��
    time=endtime-starttime   !������ʱ��
    print '(a, f13.5)' , '�ڶ����ֳ��򰴴��м������õ�ʱ�䣺', time
    print *     !������
    
    
    tid=OMP_GET_THREAD_NUM()   !��ȡ��ǰ�̵߳��̺߳�
    mcpu=OMP_GET_NUM_THREADS() !��ȡ�ܵ��߳���
    print '(a,i5,a,i5)', '��ǰ�̺߳ţ�',tid,'���ܵ��߳�����', mcpu
    print *      !������
end program hello_open_mp   ! �������д��end, Ҳ����д��end program�������ԡ�
    