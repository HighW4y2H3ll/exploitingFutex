source ~/peda/peda.py

define conn
    target remote :1234
    b futex_wait_requeue_pi
    c
    b futex_wait_queue_me
    c
    set $WAITER=*($r1+0x2c)
    delete 1
    delete 2
    b sys_sendmmsg
    c
    finish
    x/40x $WAITER
    delete 3
    b futex_lock_pi
    #c
    b task_blocks_on_rt_mutex
    b rt_mutex_adjust_prio_chain
    c
