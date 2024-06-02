# Foo et al. Parameterization

This is a toy software package that calculates the complex Foo et al. parametrization to calculate the volume of a sphere based on its radius.

## Building

To build the standalone Foo et al. library with `gfortran` as an example:

```bash
gfortran -c sphere_foo_common.F90 sphere_foo.F90
```

Example code for running the parameterization is available in the `examples/` folder. To build it and link to the library, use:

```bash
gfortran -c examples/example_program.F90 -o examples/example_program.o
gfortran sphere_foo_common.o sphere_foo.o examples/example_program.o -o examples/example_program.exe
```

Run `./examples/example_program.exe` to see the toy example:

```bash
gfortran -c sphere_foo_common.F90 sphere_foo.F90
gfortran -c examples/example_program.F90 -o examples/example_program.o
gfortran sphere_foo_common.o sphere_foo.o examples/example_program.o -o examples/example_program.exe
./examples/example_program.exe

# Expected output:
# Radius =    1.0000000000000000      , calculated volume =    4.1887901282943290
# Radius =    2.0000000000000000      , calculated volume =    33.510321026354632
```

## Implementing in external model

The `sphere_foo` library uses a initialize, run, finalize pattern and accepts the `pi` physical constant from the external model to avoid duplication and maintain consistency. All subroutine calls include a return code (compatible with ESMF) where `0` is success and `1` is error.

### Subroutine calls
* Init: Initialize the physical constants in `sphere_foo_common.F90` by calling `sphere_foo_init(pi, RC)`.
* Run: Run the parameterization by calling `sphere_foo_run(radius, volume, RC)`.
* Finalize: Cleanup the internal state by calling `sphere_foo_final(RC)`.

### Precision
The real number precision is flexible and is a `fp` parameter defined in `sphere_foo_common.F90`. It defaults to `real*8` as defined in `sphere_foo_common.F90`. If a different precision is desired, `sphere_foo_common.F90` can be modified to import `fp` from the external model.

## Code documentation
Code is documented using ProTeX, a perl script to generate documentation from code headers and readable comments with LaTeX support. Refer to [Automatic Documentation using ProTeX](http://wiki.seas.harvard.edu/geos-chem/index.php/Automatic_documentation_with_protex) from the GEOS-Chem Wiki for more information about this feature.