program example_program
    use sphere_foo, only: sphere_foo_init, sphere_foo_run, sphere_foo_final
    use sphere_foo_common, only: r8

    real(r8), parameter :: pi = 3.1415926
    real(r8)            :: radius, volume
    integer             :: RC

    ! Initialize the Foo et al. parameterization code with physics constants
    call sphere_foo_init(pi, RC)

    ! Run the parameterization
    radius = 1.
    call sphere_foo_run(radius, volume, RC)

    if(RC /= 0) then
        write(6,*) "ERROR from sphere_foo_run!"
    else
        write(6,*) "Radius = ", radius, ", calculated volume = ", volume
    endif

    ! Run the parameterization again
    radius = 2.
    call sphere_foo_run(radius, volume, RC)

    if(RC /= 0) then
        write(6,*) "ERROR from sphere_foo_run!"
    else
        write(6,*) "Radius = ", radius, ", calculated volume = ", volume
    endif

    ! Cleanup
    call sphere_foo_final(RC)

end program example_program

