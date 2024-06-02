program interactive_sphere_foo
    use sphere_foo, only: sphere_foo_init, sphere_foo_run, sphere_foo_final
    use sphere_foo_common, only: r8

    real(r8), parameter :: pi = 3.1415926
    real(r8)            :: radius, volume
    integer             :: RC
    integer             :: iostat

    ! Initialize the Foo et al. parameterization code with physics constants
    call sphere_foo_init(pi, RC)

    ! Read user input for parameters. For now, only radius is needed.
    radius = 1.
    RC = 0

    do while(radius >= 0.)
        write(6,*) "Input radius for Foo et al. (Ctrl-C or input negative number to quit):"
        read(*, *, IOSTAT=iostat) radius
        if(iostat /= 0) then
            write(6,*) "ERROR: Could not read input. Stopping. Make sure a number was input."
            stop
        endif

        if(radius < 0.) then
            write(6,*) "Exiting."
            stop
        endif

        ! Run the parameterization
        call sphere_foo_run(radius, volume, RC)
        write(6,*) "Radius = ", radius, ", calculated volume = ", volume
    end do

    ! Cleanup
    call sphere_foo_final(RC)

end program interactive_sphere_foo

