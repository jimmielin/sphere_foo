!------------------------------------------------------------------------------
!                          Foo et al. Parameterization                        !
!------------------------------------------------------------------------------
!BOP
!
! !MODULE: sphere_foo.F90
!
! !DESCRIPTION: Module sphere\_foo calculates the Foo et al. parameterization
!  for spheres.
!\\
!\\
! !INTERFACE:
!
module sphere_foo
!
! !USES:
!
    use sphere_foo_common, only: fp            ! Real precision to be used (fp = flexible precision)

    implicit none
    private

!
! !PUBLIC MEMBER FUNCTIONS:
!
    public :: sphere_foo_init, sphere_foo_run, sphere_foo_final
!
! !REMARKS:
!
!  Sphere volume is calculated as
!             4
!  volume =  --- * pi * r^3
!             3
!
! !REVISION HISTORY:
!  01 Jun 2024 - H.P. Lin     - Initial version
!  See Git commit for complete history.
!EOP
!------------------------------------------------------------------------------
!BOC
!
! !PRIVATE TYPES:
!
    logical :: is_initialized = .false.
contains
!EOC
!------------------------------------------------------------------------------
!                          Foo et al. Parameterization                        !
!------------------------------------------------------------------------------
!BOP
!
! !IROUTINE: sphere_foo_init
!
! !DESCRIPTION: Initializes physical constants for the parameterization.
!\\
!\\
! !INTERFACE:
!
    subroutine sphere_foo_init(con_pi, RC)
!
! !USES:
!
        use sphere_foo_common, only: pi        ! Common parameter
!
! !INPUT PARAMETERS:
!
        real(fp), intent(in)    :: con_pi      ! Pi constant accepted from host model
!
! !OUTPUT ARGUMENTS:
!
        integer,  intent(inout) :: RC          ! Return code
!
! !REVISION HISTORY:
!  01 Jun 2024 - H.P. Lin     - Initial version
!  See Git commit for complete history.
!EOP
!------------------------------------------------------------------------------
!BOC
        ! Assume success
        RC = 0

        ! Initialize physical constants from host model
        pi = con_pi
        is_initialized = .true.
    end subroutine sphere_foo_init
!EOC
!------------------------------------------------------------------------------
!                          Foo et al. Parameterization                        !
!------------------------------------------------------------------------------
!BOP
!
! !IROUTINE: sphere_foo_run
!
! !DESCRIPTION: Runs Foo et al. based on the passed radius and returns volume.
!\\
!\\
! !INTERFACE:
!
    subroutine sphere_foo_run(radius, volume, RC)
!
! !USES:
!
        use sphere_foo_common, only: pi
!
! !INPUT PARAMETERS:
!
        real(fp), intent(in)    :: radius      ! Radius of sphere [m]
!
! !OUTPUT ARGUMENTS:
!
        real(fp), intent(out)   :: volume      ! Volume of sphere, calculated [m^3]
        integer,  intent(inout) :: RC          ! Return code
!
! !REVISION HISTORY:
!  01 Jun 2024 - H.P. Lin     - Initial version
!  See Git commit for complete history.
!EOP
!------------------------------------------------------------------------------
!BOC
        ! Assume success
        RC = 0

        ! Are we initialized?
        if (.not. is_initialized) then
            RC = 1
            return
        endif

        ! Calculate sphere volume based on Foo et al. parameterization
        volume = 4./3. * pi * radius**3
    end subroutine sphere_foo_run
!EOC
!------------------------------------------------------------------------------
!                          Foo et al. Parameterization                        !
!------------------------------------------------------------------------------
!BOP
!
! !IROUTINE: sphere_foo_final
!
! !DESCRIPTION: Cleans up the module.
!\\
!\\
! !INTERFACE:
!
    subroutine sphere_foo_final(RC)
!
! !USES:
!
        use sphere_foo_common, only: pi
!
! !OUTPUT ARGUMENTS:
!
        integer,  intent(inout) :: RC          ! Return code
!
! !REVISION HISTORY:
!  01 Jun 2024 - H.P. Lin     - Initial version
!  See Git commit for complete history.
!EOP
!------------------------------------------------------------------------------
!BOC
        ! Assume success
        RC = 0

        ! Deinitialize all values
        pi = -999.
        is_initialized = .false.
    end subroutine sphere_foo_final
!EOC
end module sphere_foo
