module sphere_foo_common
    implicit none
    private
    integer, parameter, public :: r8 = selected_real_kind(12)
    integer, parameter, public :: fp = r8                        ! Using real*8 as the "flexible precision" here.
    real(r8), public           :: pi
end module sphere_foo_common