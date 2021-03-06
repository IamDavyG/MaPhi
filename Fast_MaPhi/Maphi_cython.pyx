#!python
#cython: language_level=3, infer_types=True, boundscheck=False, wraparound=False, nonecheck=False
from libc.stdlib cimport atoi, atof
import ray

cdef extern from "<stdlib.h>" nogil:
    int atoi (const char *string)

cpdef inline get_val(fileout,param,num,ini,fin,from_stt):
    with open(fileout) as fp:
        for cnt, line in enumerate(fp):
            if cnt == check_line(fileout,param,num,from_stt):
                return line[ini:fin]

#Parsing output file
cpdef inline check_line(fileout,pattern,num,from_st):
    with open(fileout) as fp:
        for cnt, line in enumerate(fp):
            if cnt > from_st and pattern in line:
                return cnt+int(num)


cpdef calc_cube_values(int electrons):
    cdef int cube
    cdef int hcube
    cdef int h1cube
    cdef int h2cube
    cdef int lcube
    cdef int l1cube
    cdef int l2cube
    cube = <int>((electrons/2))
    hcube = <int>(cube-1) 
    h1cube = <int>(cube-2)
    h2cube = <int>(cube-3)
    lcube = <int>(cube)
    l1cube = <int>(cube+1)
    l2cube = <int>(cube+2)
    return cube, hcube, h1cube, h2cube, lcube, l1cube, l2cube


cpdef calc_homo_lumo_values(molecule_file, int electrons, int converg):
    cdef int homo
    cdef int homo1
    cdef int homo2
    cdef int lumo
    cdef int lumo1
    cdef int lumo2
    homo=<int>((electrons/2))
    homo1=<int>(homo-1)
    homo2=<int>(homo-2)
    lumo=<int>(homo+1)
    lumo1=<int>(homo+2)
    lumo2=<int>(homo+3)
    return homo, homo1, homo2, lumo, lumo1, lumo2
    
    
 
cpdef calc_electronegativity(double HOMO,double LUMO):
    cdef double electronegativity
    electronegativity = ((LUMO + HOMO)/2)
    return electronegativity

cpdef calc_electrophilicity(double HOMO,double LUMO):
    cdef double electrophilicity
    electrophilicity = (((LUMO + HOMO)**2)/(4*(LUMO-HOMO)))
    return electrophilicity

cpdef calc_ElectronDonatingPower(double HOMO, double LUMO, double hardness):
    cdef double ElectronDonatingPower
    ElectronDonatingPower = (3*(HOMO)+(LUMO))**2/(16*hardness)
    return ElectronDonatingPower

cpdef calc_ElectronAcceptingPower(double HOMO, double LUMO, double hardness):
    cdef double ElectronAcceptingPower
    ElectronAcceptingPower = ((HOMO)+(3*(LUMO)))**2/(16*hardness)
    return ElectronAcceptingPower

