# cython: embedsignature=True
from cpython.exc cimport PyErr_CheckSignals
from libcpp.vector cimport vector
from libcpp.map cimport map, pair
from libcpp cimport bool
from libcpp.string cimport string
from math import ceil
import numpy as np
import sys
cimport numpy as np
cimport cython

# Short names for unsigned integer types
ctypedef unsigned char _ann_uint8
ctypedef unsigned short _ann_uint16
ctypedef unsigned int _ann_uint32
ctypedef unsigned long _ann_uint64

import ANNarchy
from ANNarchy.core.cython_ext.Connector cimport LILConnectivity as LIL

cdef extern from "ANNarchy.h":

    # User-defined functions


    # User-defined constants

    void set_tau_MSN(double)
    void set_tau_FSI(double)
    void set_tau_STN(double)
    void set_tau_GPe(double)
    void set_tau_GPiSNr(double)
    void set_sigmap(double)
    void set_Smax_MSN(double)
    void set_Smax_STN(double)
    void set_Smax_GPe(double)
    void set_Smax_GPiSNr(double)
    void set_Smax_FSI(double)
    void set_theta_MSN(double)
    void set_theta_FSI(double)
    void set_theta_STN(double)
    void set_theta_GPe(double)
    void set_theta_GPiSNr(double)

    # Data structures

    # Export Population 0 (pop0)
    cdef struct PopStruct0 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)



        # Targets


        # Custom local parameters of a TimedArray
        void set_schedule(vector[int])
        vector[int] get_schedule()
        void set_buffer(vector[vector[double]])
        vector[vector[double]] get_buffer()
        void set_period(int)
        int get_period()


        # memory management
        long int size_in_bytes()
        void clear()

    # Export Population 1 (pop1)
    cdef struct PopStruct1 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)



        # Targets


        # Custom local parameters of a TimedArray
        void set_schedule(vector[int])
        vector[int] get_schedule()
        void set_buffer(vector[vector[double]])
        vector[vector[double]] get_buffer()
        void set_period(int)
        int get_period()


        # memory management
        long int size_in_bytes()
        void clear()

    # Export Population 2 (pop2)
    cdef struct PopStruct2 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)



        # Targets


        # Custom local parameters of a TimedArray
        void set_schedule(vector[int])
        vector[int] get_schedule()
        void set_buffer(vector[vector[double]])
        vector[vector[double]] get_buffer()
        void set_period(int)
        int get_period()


        # memory management
        long int size_in_bytes()
        void clear()

    # Export Population 3 (pop3)
    cdef struct PopStruct3 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)



        # Targets


        # Custom local parameters of a TimedArray
        void set_schedule(vector[int])
        vector[int] get_schedule()
        void set_buffer(vector[vector[double]])
        vector[vector[double]] get_buffer()
        void set_period(int)
        int get_period()


        # memory management
        long int size_in_bytes()
        void clear()

    # Export Population 4 (pop4)
    cdef struct PopStruct4 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)



        # Targets


        # Custom local parameters of a TimedArray
        void set_schedule(vector[int])
        vector[int] get_schedule()
        void set_buffer(vector[vector[double]])
        vector[vector[double]] get_buffer()
        void set_period(int)
        int get_period()


        # memory management
        long int size_in_bytes()
        void clear()

    # Export Population 5 (FSI)
    cdef struct PopStruct5 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)


        # Local functions
        double f_activateFSI(double)


        # Targets
        vector[double] _sum_exc
        vector[double] _sum_inh



        # memory management
        long int size_in_bytes()
        void clear()

    # Export Population 6 (MSNd1)
    cdef struct PopStruct6 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)


        # Local functions
        double f_activateMSN(double)


        # Targets
        vector[double] _sum_exc
        vector[double] _sum_inh



        # memory management
        long int size_in_bytes()
        void clear()

    # Export Population 7 (MSNd2)
    cdef struct PopStruct7 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)


        # Local functions
        double f_activateMSN(double)


        # Targets
        vector[double] _sum_exc
        vector[double] _sum_inh



        # memory management
        long int size_in_bytes()
        void clear()

    # Export Population 8 (GPe)
    cdef struct PopStruct8 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)


        # Local functions
        double f_activateGPe(double)


        # Targets
        vector[double] _sum_exc
        vector[double] _sum_inh



        # memory management
        long int size_in_bytes()
        void clear()

    # Export Population 9 (GPiSNr)
    cdef struct PopStruct9 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)


        # Local functions
        double f_activateGPiSNr(double)


        # Targets
        vector[double] _sum_exc
        vector[double] _sum_inh



        # memory management
        long int size_in_bytes()
        void clear()

    # Export Population 10 (STN)
    cdef struct PopStruct10 :
        # Number of neurons
        int get_size()
        void set_size(int)
        # Maximum delay in steps
        int get_max_delay()
        void set_max_delay(int)
        void update_max_delay(int)
        # Activate/deactivate the population
        bool is_active()
        void set_active(bool)
        # Reset the population
        void reset()


        # Local attributes
        vector[double] get_local_attribute_all_double(string)
        double get_local_attribute_double(string, int)
        void set_local_attribute_all_double(string, vector[double])
        void set_local_attribute_double(string, int, double)


        # Local functions
        double f_activateSTN(double)


        # Targets
        vector[double] _sum_exc
        vector[double] _sum_inh



        # memory management
        long int size_in_bytes()
        void clear()


    # Export Projection 0
    cdef struct ProjStruct0 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 1
    cdef struct ProjStruct1 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 2
    cdef struct ProjStruct2 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 3
    cdef struct ProjStruct3 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 4
    cdef struct ProjStruct4 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 5
    cdef struct ProjStruct5 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 6
    cdef struct ProjStruct6 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 7
    cdef struct ProjStruct7 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 8
    cdef struct ProjStruct8 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 9
    cdef struct ProjStruct9 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 10
    cdef struct ProjStruct10 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 11
    cdef struct ProjStruct11 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 12
    cdef struct ProjStruct12 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 13
    cdef struct ProjStruct13 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 14
    cdef struct ProjStruct14 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 15
    cdef struct ProjStruct15 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 16
    cdef struct ProjStruct16 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 17
    cdef struct ProjStruct17 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 18
    cdef struct ProjStruct18 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 19
    cdef struct ProjStruct19 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 20
    cdef struct ProjStruct20 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 21
    cdef struct ProjStruct21 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 22
    cdef struct ProjStruct22 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 23
    cdef struct ProjStruct23 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 24
    cdef struct ProjStruct24 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 25
    cdef struct ProjStruct25 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 26
    cdef struct ProjStruct26 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 27
    cdef struct ProjStruct27 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 28
    cdef struct ProjStruct28 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 29
    cdef struct ProjStruct29 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 30
    cdef struct ProjStruct30 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 31
    cdef struct ProjStruct31 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)



        # Uniform delay
        int delay


        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 32
    cdef struct ProjStruct32 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 33
    cdef struct ProjStruct33 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 34
    cdef struct ProjStruct34 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 35
    cdef struct ProjStruct35 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 36
    cdef struct ProjStruct36 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 37
    cdef struct ProjStruct37 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 38
    cdef struct ProjStruct38 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 39
    cdef struct ProjStruct39 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 40
    cdef struct ProjStruct40 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()

    # Export Projection 41
    cdef struct ProjStruct41 :
        # Flags
        bool _transmission
        bool _plasticity
        bool _update
        int _update_period
        long _update_offset

        # Connectivity
        void init_from_lil(vector[int], vector[vector[int]], vector[vector[double]], vector[vector[int]])
        # Access connectivity
        vector[int] get_post_rank()
        vector[ vector[int] ] get_pre_ranks()
        vector[int] get_dendrite_pre_rank(int)
        int nb_synapses()
        int nb_dendrites()
        int dendrite_size(int)





        # Local Attributes
        vector[vector[double]] get_local_attribute_all_double(string)
        vector[double] get_local_attribute_row_double(string, int)
        double get_local_attribute_double(string, int, int)
        void set_local_attribute_all_double(string, vector[vector[double]])
        void set_local_attribute_row_double(string, int, vector[double])
        void set_local_attribute_double(string, int, int, double)

        # Global Attributes
        double get_global_attribute_double(string)
        void set_global_attribute_double(string, double)





        # memory management
        long int size_in_bytes()
        void clear()



    # Monitors
    cdef cppclass Monitor:
        vector[int] ranks
        int period_
        int period_offset_
        long offset_


    # Population 0 (pop0) : Monitor
    cdef cppclass PopRecorder0 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder0* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] r
        bool record_r

        # Targets
    # Population 1 (pop1) : Monitor
    cdef cppclass PopRecorder1 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder1* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] r
        bool record_r

        # Targets
    # Population 2 (pop2) : Monitor
    cdef cppclass PopRecorder2 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder2* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] r
        bool record_r

        # Targets
    # Population 3 (pop3) : Monitor
    cdef cppclass PopRecorder3 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder3* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] r
        bool record_r

        # Targets
    # Population 4 (pop4) : Monitor
    cdef cppclass PopRecorder4 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder4* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] r
        bool record_r

        # Targets
    # Population 5 (FSI) : Monitor
    cdef cppclass PopRecorder5 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder5* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] mp
        bool record_mp

        vector[vector[double]] r
        bool record_r

        # Targets
        vector[vector[double]] _sum_exc
        bool record__sum_exc

        vector[vector[double]] _sum_inh
        bool record__sum_inh

    # Population 6 (MSNd1) : Monitor
    cdef cppclass PopRecorder6 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder6* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] mp
        bool record_mp

        vector[vector[double]] r
        bool record_r

        # Targets
        vector[vector[double]] _sum_exc
        bool record__sum_exc

        vector[vector[double]] _sum_inh
        bool record__sum_inh

    # Population 7 (MSNd2) : Monitor
    cdef cppclass PopRecorder7 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder7* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] mp
        bool record_mp

        vector[vector[double]] r
        bool record_r

        # Targets
        vector[vector[double]] _sum_exc
        bool record__sum_exc

        vector[vector[double]] _sum_inh
        bool record__sum_inh

    # Population 8 (GPe) : Monitor
    cdef cppclass PopRecorder8 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder8* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] mp
        bool record_mp

        vector[vector[double]] r
        bool record_r

        # Targets
        vector[vector[double]] _sum_exc
        bool record__sum_exc

        vector[vector[double]] _sum_inh
        bool record__sum_inh

    # Population 9 (GPiSNr) : Monitor
    cdef cppclass PopRecorder9 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder9* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] mp
        bool record_mp

        vector[vector[double]] r
        bool record_r

        # Targets
        vector[vector[double]] _sum_exc
        bool record__sum_exc

        vector[vector[double]] _sum_inh
        bool record__sum_inh

    # Population 10 (STN) : Monitor
    cdef cppclass PopRecorder10 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        PopRecorder10* get_instance(int)
        long int size_in_bytes()
        void clear()

        vector[vector[double]] mp
        bool record_mp

        vector[vector[double]] r
        bool record_r

        # Targets
        vector[vector[double]] _sum_exc
        bool record__sum_exc

        vector[vector[double]] _sum_inh
        bool record__sum_inh

    # Projection 0 : Monitor
    cdef cppclass ProjRecorder0 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder0* get_instance(int)

    # Projection 1 : Monitor
    cdef cppclass ProjRecorder1 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder1* get_instance(int)

    # Projection 2 : Monitor
    cdef cppclass ProjRecorder2 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder2* get_instance(int)

    # Projection 3 : Monitor
    cdef cppclass ProjRecorder3 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder3* get_instance(int)

    # Projection 4 : Monitor
    cdef cppclass ProjRecorder4 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder4* get_instance(int)

    # Projection 5 : Monitor
    cdef cppclass ProjRecorder5 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder5* get_instance(int)

    # Projection 6 : Monitor
    cdef cppclass ProjRecorder6 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder6* get_instance(int)

    # Projection 7 : Monitor
    cdef cppclass ProjRecorder7 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder7* get_instance(int)

    # Projection 8 : Monitor
    cdef cppclass ProjRecorder8 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder8* get_instance(int)

    # Projection 9 : Monitor
    cdef cppclass ProjRecorder9 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder9* get_instance(int)

    # Projection 10 : Monitor
    cdef cppclass ProjRecorder10 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder10* get_instance(int)

    # Projection 11 : Monitor
    cdef cppclass ProjRecorder11 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder11* get_instance(int)

    # Projection 12 : Monitor
    cdef cppclass ProjRecorder12 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder12* get_instance(int)

    # Projection 13 : Monitor
    cdef cppclass ProjRecorder13 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder13* get_instance(int)

    # Projection 14 : Monitor
    cdef cppclass ProjRecorder14 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder14* get_instance(int)

    # Projection 15 : Monitor
    cdef cppclass ProjRecorder15 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder15* get_instance(int)

    # Projection 16 : Monitor
    cdef cppclass ProjRecorder16 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder16* get_instance(int)

    # Projection 17 : Monitor
    cdef cppclass ProjRecorder17 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder17* get_instance(int)

    # Projection 18 : Monitor
    cdef cppclass ProjRecorder18 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder18* get_instance(int)

    # Projection 19 : Monitor
    cdef cppclass ProjRecorder19 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder19* get_instance(int)

    # Projection 20 : Monitor
    cdef cppclass ProjRecorder20 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder20* get_instance(int)

    # Projection 21 : Monitor
    cdef cppclass ProjRecorder21 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder21* get_instance(int)

    # Projection 22 : Monitor
    cdef cppclass ProjRecorder22 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder22* get_instance(int)

    # Projection 23 : Monitor
    cdef cppclass ProjRecorder23 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder23* get_instance(int)

    # Projection 24 : Monitor
    cdef cppclass ProjRecorder24 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder24* get_instance(int)

    # Projection 25 : Monitor
    cdef cppclass ProjRecorder25 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder25* get_instance(int)

    # Projection 26 : Monitor
    cdef cppclass ProjRecorder26 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder26* get_instance(int)

    # Projection 27 : Monitor
    cdef cppclass ProjRecorder27 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder27* get_instance(int)

    # Projection 28 : Monitor
    cdef cppclass ProjRecorder28 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder28* get_instance(int)

    # Projection 29 : Monitor
    cdef cppclass ProjRecorder29 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder29* get_instance(int)

    # Projection 30 : Monitor
    cdef cppclass ProjRecorder30 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder30* get_instance(int)

    # Projection 31 : Monitor
    cdef cppclass ProjRecorder31 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder31* get_instance(int)

    # Projection 32 : Monitor
    cdef cppclass ProjRecorder32 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder32* get_instance(int)

    # Projection 33 : Monitor
    cdef cppclass ProjRecorder33 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder33* get_instance(int)

    # Projection 34 : Monitor
    cdef cppclass ProjRecorder34 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder34* get_instance(int)

    # Projection 35 : Monitor
    cdef cppclass ProjRecorder35 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder35* get_instance(int)

    # Projection 36 : Monitor
    cdef cppclass ProjRecorder36 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder36* get_instance(int)

    # Projection 37 : Monitor
    cdef cppclass ProjRecorder37 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder37* get_instance(int)

    # Projection 38 : Monitor
    cdef cppclass ProjRecorder38 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder38* get_instance(int)

    # Projection 39 : Monitor
    cdef cppclass ProjRecorder39 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder39* get_instance(int)

    # Projection 40 : Monitor
    cdef cppclass ProjRecorder40 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder40* get_instance(int)

    # Projection 41 : Monitor
    cdef cppclass ProjRecorder41 (Monitor):
        @staticmethod
        int create_instance(vector[int], int, int, long)
        @staticmethod
        ProjRecorder41* get_instance(int)


    # Instances

    PopStruct0 pop0
    PopStruct1 pop1
    PopStruct2 pop2
    PopStruct3 pop3
    PopStruct4 pop4
    PopStruct5 pop5
    PopStruct6 pop6
    PopStruct7 pop7
    PopStruct8 pop8
    PopStruct9 pop9
    PopStruct10 pop10

    ProjStruct0 proj0
    ProjStruct1 proj1
    ProjStruct2 proj2
    ProjStruct3 proj3
    ProjStruct4 proj4
    ProjStruct5 proj5
    ProjStruct6 proj6
    ProjStruct7 proj7
    ProjStruct8 proj8
    ProjStruct9 proj9
    ProjStruct10 proj10
    ProjStruct11 proj11
    ProjStruct12 proj12
    ProjStruct13 proj13
    ProjStruct14 proj14
    ProjStruct15 proj15
    ProjStruct16 proj16
    ProjStruct17 proj17
    ProjStruct18 proj18
    ProjStruct19 proj19
    ProjStruct20 proj20
    ProjStruct21 proj21
    ProjStruct22 proj22
    ProjStruct23 proj23
    ProjStruct24 proj24
    ProjStruct25 proj25
    ProjStruct26 proj26
    ProjStruct27 proj27
    ProjStruct28 proj28
    ProjStruct29 proj29
    ProjStruct30 proj30
    ProjStruct31 proj31
    ProjStruct32 proj32
    ProjStruct33 proj33
    ProjStruct34 proj34
    ProjStruct35 proj35
    ProjStruct36 proj36
    ProjStruct37 proj37
    ProjStruct38 proj38
    ProjStruct39 proj39
    ProjStruct40 proj40
    ProjStruct41 proj41

    # Methods
    void initialize(double)
    void init_rng_dist()
    void setSeed(long, int, bool)
    void run(int nbSteps) nogil
    int run_until(int steps, vector[int] populations, bool or_and)
    void step()

    # Time
    long getTime()
    void setTime(long)

    # dt
    double getDt()
    void setDt(double dt_)


    # Number of threads
    void setNumberThreads(int, vector[int])


# Population wrappers

# Wrapper for population 0 (pop0)
@cython.auto_pickle(True)
cdef class pop0_wrapper :

    def __init__(self, size, max_delay):

        pop0.set_size(size)
        pop0.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop0.get_size()
    # Reset the population
    def reset(self):
        pop0.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop0.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop0.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop0.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop0.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop0.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop0.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop0.set_local_attribute_double(cpp_string, rk, value)



    # Targets




    # Custom local parameters of a TimedArray
    cpdef set_schedule( self, schedule ):
        pop0.set_schedule( schedule )
    cpdef np.ndarray get_schedule( self ):
        return np.array(pop0.get_schedule( ))

    cpdef set_rates( self, buffer ):
        pop0.set_buffer( buffer )
    cpdef np.ndarray get_rates( self ):
        return np.array(pop0.get_buffer( ))

    cpdef set_period( self, period ):
        pop0.set_period(period)
    cpdef int get_period(self):
        return pop0.get_period()


    # memory management
    def size_in_bytes(self):
        return pop0.size_in_bytes()

    def clear(self):
        return pop0.clear()

# Wrapper for population 1 (pop1)
@cython.auto_pickle(True)
cdef class pop1_wrapper :

    def __init__(self, size, max_delay):

        pop1.set_size(size)
        pop1.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop1.get_size()
    # Reset the population
    def reset(self):
        pop1.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop1.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop1.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop1.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop1.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop1.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop1.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop1.set_local_attribute_double(cpp_string, rk, value)



    # Targets




    # Custom local parameters of a TimedArray
    cpdef set_schedule( self, schedule ):
        pop1.set_schedule( schedule )
    cpdef np.ndarray get_schedule( self ):
        return np.array(pop1.get_schedule( ))

    cpdef set_rates( self, buffer ):
        pop1.set_buffer( buffer )
    cpdef np.ndarray get_rates( self ):
        return np.array(pop1.get_buffer( ))

    cpdef set_period( self, period ):
        pop1.set_period(period)
    cpdef int get_period(self):
        return pop1.get_period()


    # memory management
    def size_in_bytes(self):
        return pop1.size_in_bytes()

    def clear(self):
        return pop1.clear()

# Wrapper for population 2 (pop2)
@cython.auto_pickle(True)
cdef class pop2_wrapper :

    def __init__(self, size, max_delay):

        pop2.set_size(size)
        pop2.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop2.get_size()
    # Reset the population
    def reset(self):
        pop2.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop2.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop2.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop2.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop2.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop2.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop2.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop2.set_local_attribute_double(cpp_string, rk, value)



    # Targets




    # Custom local parameters of a TimedArray
    cpdef set_schedule( self, schedule ):
        pop2.set_schedule( schedule )
    cpdef np.ndarray get_schedule( self ):
        return np.array(pop2.get_schedule( ))

    cpdef set_rates( self, buffer ):
        pop2.set_buffer( buffer )
    cpdef np.ndarray get_rates( self ):
        return np.array(pop2.get_buffer( ))

    cpdef set_period( self, period ):
        pop2.set_period(period)
    cpdef int get_period(self):
        return pop2.get_period()


    # memory management
    def size_in_bytes(self):
        return pop2.size_in_bytes()

    def clear(self):
        return pop2.clear()

# Wrapper for population 3 (pop3)
@cython.auto_pickle(True)
cdef class pop3_wrapper :

    def __init__(self, size, max_delay):

        pop3.set_size(size)
        pop3.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop3.get_size()
    # Reset the population
    def reset(self):
        pop3.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop3.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop3.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop3.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop3.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop3.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop3.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop3.set_local_attribute_double(cpp_string, rk, value)



    # Targets




    # Custom local parameters of a TimedArray
    cpdef set_schedule( self, schedule ):
        pop3.set_schedule( schedule )
    cpdef np.ndarray get_schedule( self ):
        return np.array(pop3.get_schedule( ))

    cpdef set_rates( self, buffer ):
        pop3.set_buffer( buffer )
    cpdef np.ndarray get_rates( self ):
        return np.array(pop3.get_buffer( ))

    cpdef set_period( self, period ):
        pop3.set_period(period)
    cpdef int get_period(self):
        return pop3.get_period()


    # memory management
    def size_in_bytes(self):
        return pop3.size_in_bytes()

    def clear(self):
        return pop3.clear()

# Wrapper for population 4 (pop4)
@cython.auto_pickle(True)
cdef class pop4_wrapper :

    def __init__(self, size, max_delay):

        pop4.set_size(size)
        pop4.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop4.get_size()
    # Reset the population
    def reset(self):
        pop4.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop4.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop4.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop4.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop4.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop4.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop4.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop4.set_local_attribute_double(cpp_string, rk, value)



    # Targets




    # Custom local parameters of a TimedArray
    cpdef set_schedule( self, schedule ):
        pop4.set_schedule( schedule )
    cpdef np.ndarray get_schedule( self ):
        return np.array(pop4.get_schedule( ))

    cpdef set_rates( self, buffer ):
        pop4.set_buffer( buffer )
    cpdef np.ndarray get_rates( self ):
        return np.array(pop4.get_buffer( ))

    cpdef set_period( self, period ):
        pop4.set_period(period)
    cpdef int get_period(self):
        return pop4.get_period()


    # memory management
    def size_in_bytes(self):
        return pop4.size_in_bytes()

    def clear(self):
        return pop4.clear()

# Wrapper for population 5 (FSI)
@cython.auto_pickle(True)
cdef class pop5_wrapper :

    def __init__(self, size, max_delay):

        pop5.set_size(size)
        pop5.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop5.get_size()
    # Reset the population
    def reset(self):
        pop5.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop5.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop5.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop5.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop5.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop5.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop5.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop5.set_local_attribute_double(cpp_string, rk, value)



    # Targets
    cpdef np.ndarray get_sum_exc(self):
        return np.array(pop5.get_local_attribute_all_double("_sum_exc".encode('utf-8')))
    cpdef np.ndarray get_sum_inh(self):
        return np.array(pop5.get_local_attribute_all_double("_sum_inh".encode('utf-8')))

    # Local functions
    cpdef np.ndarray f_activateFSI(self, x):
        return np.array([pop5.f_activateFSI(x[i]) for i in range(len(x))])





    # memory management
    def size_in_bytes(self):
        return pop5.size_in_bytes()

    def clear(self):
        return pop5.clear()

# Wrapper for population 6 (MSNd1)
@cython.auto_pickle(True)
cdef class pop6_wrapper :

    def __init__(self, size, max_delay):

        pop6.set_size(size)
        pop6.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop6.get_size()
    # Reset the population
    def reset(self):
        pop6.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop6.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop6.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop6.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop6.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop6.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop6.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop6.set_local_attribute_double(cpp_string, rk, value)



    # Targets
    cpdef np.ndarray get_sum_exc(self):
        return np.array(pop6.get_local_attribute_all_double("_sum_exc".encode('utf-8')))
    cpdef np.ndarray get_sum_inh(self):
        return np.array(pop6.get_local_attribute_all_double("_sum_inh".encode('utf-8')))

    # Local functions
    cpdef np.ndarray f_activateMSN(self, x):
        return np.array([pop6.f_activateMSN(x[i]) for i in range(len(x))])





    # memory management
    def size_in_bytes(self):
        return pop6.size_in_bytes()

    def clear(self):
        return pop6.clear()

# Wrapper for population 7 (MSNd2)
@cython.auto_pickle(True)
cdef class pop7_wrapper :

    def __init__(self, size, max_delay):

        pop7.set_size(size)
        pop7.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop7.get_size()
    # Reset the population
    def reset(self):
        pop7.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop7.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop7.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop7.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop7.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop7.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop7.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop7.set_local_attribute_double(cpp_string, rk, value)



    # Targets
    cpdef np.ndarray get_sum_exc(self):
        return np.array(pop7.get_local_attribute_all_double("_sum_exc".encode('utf-8')))
    cpdef np.ndarray get_sum_inh(self):
        return np.array(pop7.get_local_attribute_all_double("_sum_inh".encode('utf-8')))

    # Local functions
    cpdef np.ndarray f_activateMSN(self, x):
        return np.array([pop7.f_activateMSN(x[i]) for i in range(len(x))])





    # memory management
    def size_in_bytes(self):
        return pop7.size_in_bytes()

    def clear(self):
        return pop7.clear()

# Wrapper for population 8 (GPe)
@cython.auto_pickle(True)
cdef class pop8_wrapper :

    def __init__(self, size, max_delay):

        pop8.set_size(size)
        pop8.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop8.get_size()
    # Reset the population
    def reset(self):
        pop8.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop8.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop8.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop8.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop8.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop8.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop8.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop8.set_local_attribute_double(cpp_string, rk, value)



    # Targets
    cpdef np.ndarray get_sum_exc(self):
        return np.array(pop8.get_local_attribute_all_double("_sum_exc".encode('utf-8')))
    cpdef np.ndarray get_sum_inh(self):
        return np.array(pop8.get_local_attribute_all_double("_sum_inh".encode('utf-8')))

    # Local functions
    cpdef np.ndarray f_activateGPe(self, x):
        return np.array([pop8.f_activateGPe(x[i]) for i in range(len(x))])





    # memory management
    def size_in_bytes(self):
        return pop8.size_in_bytes()

    def clear(self):
        return pop8.clear()

# Wrapper for population 9 (GPiSNr)
@cython.auto_pickle(True)
cdef class pop9_wrapper :

    def __init__(self, size, max_delay):

        pop9.set_size(size)
        pop9.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop9.get_size()
    # Reset the population
    def reset(self):
        pop9.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop9.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop9.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop9.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop9.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop9.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop9.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop9.set_local_attribute_double(cpp_string, rk, value)



    # Targets
    cpdef np.ndarray get_sum_exc(self):
        return np.array(pop9.get_local_attribute_all_double("_sum_exc".encode('utf-8')))
    cpdef np.ndarray get_sum_inh(self):
        return np.array(pop9.get_local_attribute_all_double("_sum_inh".encode('utf-8')))

    # Local functions
    cpdef np.ndarray f_activateGPiSNr(self, x):
        return np.array([pop9.f_activateGPiSNr(x[i]) for i in range(len(x))])





    # memory management
    def size_in_bytes(self):
        return pop9.size_in_bytes()

    def clear(self):
        return pop9.clear()

# Wrapper for population 10 (STN)
@cython.auto_pickle(True)
cdef class pop10_wrapper :

    def __init__(self, size, max_delay):

        pop10.set_size(size)
        pop10.set_max_delay(max_delay)
    # Number of neurons
    property size:
        def __get__(self):
            return pop10.get_size()
    # Reset the population
    def reset(self):
        pop10.reset()
    # Set the maximum delay of outgoing projections
    def set_max_delay(self, val):
        pop10.set_max_delay(val)
    # Updates the maximum delay of outgoing projections and rebuilds the arrays
    def update_max_delay(self, val):
        pop10.update_max_delay(val)
    # Allows the population to compute
    def activate(self, bool val):
        pop10.set_active(val)


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return np.array(pop10.get_local_attribute_all_double(cpp_string))


    def get_local_attribute(self, name, rk, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return pop10.get_local_attribute_double(cpp_string, rk)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop10.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute(self, name, rk, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            pop10.set_local_attribute_double(cpp_string, rk, value)



    # Targets
    cpdef np.ndarray get_sum_exc(self):
        return np.array(pop10.get_local_attribute_all_double("_sum_exc".encode('utf-8')))
    cpdef np.ndarray get_sum_inh(self):
        return np.array(pop10.get_local_attribute_all_double("_sum_inh".encode('utf-8')))

    # Local functions
    cpdef np.ndarray f_activateSTN(self, x):
        return np.array([pop10.f_activateSTN(x[i]) for i in range(len(x))])





    # memory management
    def size_in_bytes(self):
        return pop10.size_in_bytes()

    def clear(self):
        return pop10.clear()


# Projection wrappers

# Wrapper for projection 0
@cython.auto_pickle(True)
cdef class proj0_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj0.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj0.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj0._transmission
    def _set_transmission(self, bool l):
        proj0._transmission = l

    # Update flag
    def _get_update(self):
        return proj0._update
    def _set_update(self, bool l):
        proj0._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj0._plasticity
    def _set_plasticity(self, bool l):
        proj0._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj0._update_period
    def _set_update_period(self, int l):
        proj0._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj0._update_offset
    def _set_update_offset(self, long l):
        proj0._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj0.get_post_rank()
    def pre_rank_all(self):
        return proj0.get_pre_ranks()
    def pre_rank(self, int n):
        return proj0.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj0.nb_dendrites()
    def nb_synapses(self):
        return proj0.nb_synapses()
    def dendrite_size(self, int n):
        return proj0.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj0.delay
    def get_dendrite_delay(self, idx):
        return proj0.delay
    def set_delay(self, value):
        proj0.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj0.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj0.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj0.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj0.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj0.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj0.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj0.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj0.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj0.size_in_bytes()

    def clear(self):
        return proj0.clear()

# Wrapper for projection 1
@cython.auto_pickle(True)
cdef class proj1_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj1.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj1.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj1._transmission
    def _set_transmission(self, bool l):
        proj1._transmission = l

    # Update flag
    def _get_update(self):
        return proj1._update
    def _set_update(self, bool l):
        proj1._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj1._plasticity
    def _set_plasticity(self, bool l):
        proj1._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj1._update_period
    def _set_update_period(self, int l):
        proj1._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj1._update_offset
    def _set_update_offset(self, long l):
        proj1._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj1.get_post_rank()
    def pre_rank_all(self):
        return proj1.get_pre_ranks()
    def pre_rank(self, int n):
        return proj1.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj1.nb_dendrites()
    def nb_synapses(self):
        return proj1.nb_synapses()
    def dendrite_size(self, int n):
        return proj1.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj1.delay
    def get_dendrite_delay(self, idx):
        return proj1.delay
    def set_delay(self, value):
        proj1.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj1.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj1.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj1.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj1.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj1.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj1.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj1.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj1.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj1.size_in_bytes()

    def clear(self):
        return proj1.clear()

# Wrapper for projection 2
@cython.auto_pickle(True)
cdef class proj2_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj2.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj2.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj2._transmission
    def _set_transmission(self, bool l):
        proj2._transmission = l

    # Update flag
    def _get_update(self):
        return proj2._update
    def _set_update(self, bool l):
        proj2._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj2._plasticity
    def _set_plasticity(self, bool l):
        proj2._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj2._update_period
    def _set_update_period(self, int l):
        proj2._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj2._update_offset
    def _set_update_offset(self, long l):
        proj2._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj2.get_post_rank()
    def pre_rank_all(self):
        return proj2.get_pre_ranks()
    def pre_rank(self, int n):
        return proj2.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj2.nb_dendrites()
    def nb_synapses(self):
        return proj2.nb_synapses()
    def dendrite_size(self, int n):
        return proj2.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj2.delay
    def get_dendrite_delay(self, idx):
        return proj2.delay
    def set_delay(self, value):
        proj2.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj2.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj2.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj2.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj2.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj2.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj2.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj2.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj2.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj2.size_in_bytes()

    def clear(self):
        return proj2.clear()

# Wrapper for projection 3
@cython.auto_pickle(True)
cdef class proj3_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj3.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj3.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj3._transmission
    def _set_transmission(self, bool l):
        proj3._transmission = l

    # Update flag
    def _get_update(self):
        return proj3._update
    def _set_update(self, bool l):
        proj3._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj3._plasticity
    def _set_plasticity(self, bool l):
        proj3._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj3._update_period
    def _set_update_period(self, int l):
        proj3._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj3._update_offset
    def _set_update_offset(self, long l):
        proj3._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj3.get_post_rank()
    def pre_rank_all(self):
        return proj3.get_pre_ranks()
    def pre_rank(self, int n):
        return proj3.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj3.nb_dendrites()
    def nb_synapses(self):
        return proj3.nb_synapses()
    def dendrite_size(self, int n):
        return proj3.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj3.delay
    def get_dendrite_delay(self, idx):
        return proj3.delay
    def set_delay(self, value):
        proj3.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj3.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj3.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj3.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj3.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj3.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj3.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj3.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj3.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj3.size_in_bytes()

    def clear(self):
        return proj3.clear()

# Wrapper for projection 4
@cython.auto_pickle(True)
cdef class proj4_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj4.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj4.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj4._transmission
    def _set_transmission(self, bool l):
        proj4._transmission = l

    # Update flag
    def _get_update(self):
        return proj4._update
    def _set_update(self, bool l):
        proj4._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj4._plasticity
    def _set_plasticity(self, bool l):
        proj4._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj4._update_period
    def _set_update_period(self, int l):
        proj4._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj4._update_offset
    def _set_update_offset(self, long l):
        proj4._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj4.get_post_rank()
    def pre_rank_all(self):
        return proj4.get_pre_ranks()
    def pre_rank(self, int n):
        return proj4.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj4.nb_dendrites()
    def nb_synapses(self):
        return proj4.nb_synapses()
    def dendrite_size(self, int n):
        return proj4.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj4.delay
    def get_dendrite_delay(self, idx):
        return proj4.delay
    def set_delay(self, value):
        proj4.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj4.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj4.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj4.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj4.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj4.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj4.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj4.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj4.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj4.size_in_bytes()

    def clear(self):
        return proj4.clear()

# Wrapper for projection 5
@cython.auto_pickle(True)
cdef class proj5_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj5.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj5.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj5._transmission
    def _set_transmission(self, bool l):
        proj5._transmission = l

    # Update flag
    def _get_update(self):
        return proj5._update
    def _set_update(self, bool l):
        proj5._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj5._plasticity
    def _set_plasticity(self, bool l):
        proj5._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj5._update_period
    def _set_update_period(self, int l):
        proj5._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj5._update_offset
    def _set_update_offset(self, long l):
        proj5._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj5.get_post_rank()
    def pre_rank_all(self):
        return proj5.get_pre_ranks()
    def pre_rank(self, int n):
        return proj5.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj5.nb_dendrites()
    def nb_synapses(self):
        return proj5.nb_synapses()
    def dendrite_size(self, int n):
        return proj5.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj5.delay
    def get_dendrite_delay(self, idx):
        return proj5.delay
    def set_delay(self, value):
        proj5.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj5.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj5.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj5.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj5.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj5.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj5.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj5.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj5.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj5.size_in_bytes()

    def clear(self):
        return proj5.clear()

# Wrapper for projection 6
@cython.auto_pickle(True)
cdef class proj6_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj6.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj6.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj6._transmission
    def _set_transmission(self, bool l):
        proj6._transmission = l

    # Update flag
    def _get_update(self):
        return proj6._update
    def _set_update(self, bool l):
        proj6._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj6._plasticity
    def _set_plasticity(self, bool l):
        proj6._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj6._update_period
    def _set_update_period(self, int l):
        proj6._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj6._update_offset
    def _set_update_offset(self, long l):
        proj6._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj6.get_post_rank()
    def pre_rank_all(self):
        return proj6.get_pre_ranks()
    def pre_rank(self, int n):
        return proj6.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj6.nb_dendrites()
    def nb_synapses(self):
        return proj6.nb_synapses()
    def dendrite_size(self, int n):
        return proj6.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj6.delay
    def get_dendrite_delay(self, idx):
        return proj6.delay
    def set_delay(self, value):
        proj6.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj6.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj6.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj6.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj6.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj6.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj6.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj6.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj6.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj6.size_in_bytes()

    def clear(self):
        return proj6.clear()

# Wrapper for projection 7
@cython.auto_pickle(True)
cdef class proj7_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj7.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj7.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj7._transmission
    def _set_transmission(self, bool l):
        proj7._transmission = l

    # Update flag
    def _get_update(self):
        return proj7._update
    def _set_update(self, bool l):
        proj7._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj7._plasticity
    def _set_plasticity(self, bool l):
        proj7._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj7._update_period
    def _set_update_period(self, int l):
        proj7._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj7._update_offset
    def _set_update_offset(self, long l):
        proj7._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj7.get_post_rank()
    def pre_rank_all(self):
        return proj7.get_pre_ranks()
    def pre_rank(self, int n):
        return proj7.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj7.nb_dendrites()
    def nb_synapses(self):
        return proj7.nb_synapses()
    def dendrite_size(self, int n):
        return proj7.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj7.delay
    def get_dendrite_delay(self, idx):
        return proj7.delay
    def set_delay(self, value):
        proj7.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj7.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj7.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj7.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj7.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj7.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj7.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj7.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj7.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj7.size_in_bytes()

    def clear(self):
        return proj7.clear()

# Wrapper for projection 8
@cython.auto_pickle(True)
cdef class proj8_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj8.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj8.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj8._transmission
    def _set_transmission(self, bool l):
        proj8._transmission = l

    # Update flag
    def _get_update(self):
        return proj8._update
    def _set_update(self, bool l):
        proj8._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj8._plasticity
    def _set_plasticity(self, bool l):
        proj8._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj8._update_period
    def _set_update_period(self, int l):
        proj8._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj8._update_offset
    def _set_update_offset(self, long l):
        proj8._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj8.get_post_rank()
    def pre_rank_all(self):
        return proj8.get_pre_ranks()
    def pre_rank(self, int n):
        return proj8.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj8.nb_dendrites()
    def nb_synapses(self):
        return proj8.nb_synapses()
    def dendrite_size(self, int n):
        return proj8.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj8.delay
    def get_dendrite_delay(self, idx):
        return proj8.delay
    def set_delay(self, value):
        proj8.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj8.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj8.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj8.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj8.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj8.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj8.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj8.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj8.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj8.size_in_bytes()

    def clear(self):
        return proj8.clear()

# Wrapper for projection 9
@cython.auto_pickle(True)
cdef class proj9_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj9.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj9.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj9._transmission
    def _set_transmission(self, bool l):
        proj9._transmission = l

    # Update flag
    def _get_update(self):
        return proj9._update
    def _set_update(self, bool l):
        proj9._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj9._plasticity
    def _set_plasticity(self, bool l):
        proj9._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj9._update_period
    def _set_update_period(self, int l):
        proj9._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj9._update_offset
    def _set_update_offset(self, long l):
        proj9._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj9.get_post_rank()
    def pre_rank_all(self):
        return proj9.get_pre_ranks()
    def pre_rank(self, int n):
        return proj9.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj9.nb_dendrites()
    def nb_synapses(self):
        return proj9.nb_synapses()
    def dendrite_size(self, int n):
        return proj9.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj9.delay
    def get_dendrite_delay(self, idx):
        return proj9.delay
    def set_delay(self, value):
        proj9.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj9.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj9.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj9.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj9.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj9.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj9.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj9.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj9.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj9.size_in_bytes()

    def clear(self):
        return proj9.clear()

# Wrapper for projection 10
@cython.auto_pickle(True)
cdef class proj10_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj10.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj10.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj10._transmission
    def _set_transmission(self, bool l):
        proj10._transmission = l

    # Update flag
    def _get_update(self):
        return proj10._update
    def _set_update(self, bool l):
        proj10._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj10._plasticity
    def _set_plasticity(self, bool l):
        proj10._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj10._update_period
    def _set_update_period(self, int l):
        proj10._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj10._update_offset
    def _set_update_offset(self, long l):
        proj10._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj10.get_post_rank()
    def pre_rank_all(self):
        return proj10.get_pre_ranks()
    def pre_rank(self, int n):
        return proj10.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj10.nb_dendrites()
    def nb_synapses(self):
        return proj10.nb_synapses()
    def dendrite_size(self, int n):
        return proj10.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj10.delay
    def get_dendrite_delay(self, idx):
        return proj10.delay
    def set_delay(self, value):
        proj10.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj10.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj10.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj10.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj10.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj10.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj10.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj10.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj10.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj10.size_in_bytes()

    def clear(self):
        return proj10.clear()

# Wrapper for projection 11
@cython.auto_pickle(True)
cdef class proj11_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj11.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj11.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj11._transmission
    def _set_transmission(self, bool l):
        proj11._transmission = l

    # Update flag
    def _get_update(self):
        return proj11._update
    def _set_update(self, bool l):
        proj11._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj11._plasticity
    def _set_plasticity(self, bool l):
        proj11._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj11._update_period
    def _set_update_period(self, int l):
        proj11._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj11._update_offset
    def _set_update_offset(self, long l):
        proj11._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj11.get_post_rank()
    def pre_rank_all(self):
        return proj11.get_pre_ranks()
    def pre_rank(self, int n):
        return proj11.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj11.nb_dendrites()
    def nb_synapses(self):
        return proj11.nb_synapses()
    def dendrite_size(self, int n):
        return proj11.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj11.delay
    def get_dendrite_delay(self, idx):
        return proj11.delay
    def set_delay(self, value):
        proj11.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj11.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj11.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj11.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj11.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj11.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj11.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj11.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj11.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj11.size_in_bytes()

    def clear(self):
        return proj11.clear()

# Wrapper for projection 12
@cython.auto_pickle(True)
cdef class proj12_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj12.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj12.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj12._transmission
    def _set_transmission(self, bool l):
        proj12._transmission = l

    # Update flag
    def _get_update(self):
        return proj12._update
    def _set_update(self, bool l):
        proj12._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj12._plasticity
    def _set_plasticity(self, bool l):
        proj12._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj12._update_period
    def _set_update_period(self, int l):
        proj12._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj12._update_offset
    def _set_update_offset(self, long l):
        proj12._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj12.get_post_rank()
    def pre_rank_all(self):
        return proj12.get_pre_ranks()
    def pre_rank(self, int n):
        return proj12.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj12.nb_dendrites()
    def nb_synapses(self):
        return proj12.nb_synapses()
    def dendrite_size(self, int n):
        return proj12.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj12.delay
    def get_dendrite_delay(self, idx):
        return proj12.delay
    def set_delay(self, value):
        proj12.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj12.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj12.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj12.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj12.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj12.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj12.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj12.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj12.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj12.size_in_bytes()

    def clear(self):
        return proj12.clear()

# Wrapper for projection 13
@cython.auto_pickle(True)
cdef class proj13_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj13.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj13.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj13._transmission
    def _set_transmission(self, bool l):
        proj13._transmission = l

    # Update flag
    def _get_update(self):
        return proj13._update
    def _set_update(self, bool l):
        proj13._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj13._plasticity
    def _set_plasticity(self, bool l):
        proj13._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj13._update_period
    def _set_update_period(self, int l):
        proj13._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj13._update_offset
    def _set_update_offset(self, long l):
        proj13._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj13.get_post_rank()
    def pre_rank_all(self):
        return proj13.get_pre_ranks()
    def pre_rank(self, int n):
        return proj13.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj13.nb_dendrites()
    def nb_synapses(self):
        return proj13.nb_synapses()
    def dendrite_size(self, int n):
        return proj13.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj13.delay
    def get_dendrite_delay(self, idx):
        return proj13.delay
    def set_delay(self, value):
        proj13.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj13.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj13.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj13.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj13.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj13.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj13.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj13.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj13.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj13.size_in_bytes()

    def clear(self):
        return proj13.clear()

# Wrapper for projection 14
@cython.auto_pickle(True)
cdef class proj14_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj14.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj14.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj14._transmission
    def _set_transmission(self, bool l):
        proj14._transmission = l

    # Update flag
    def _get_update(self):
        return proj14._update
    def _set_update(self, bool l):
        proj14._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj14._plasticity
    def _set_plasticity(self, bool l):
        proj14._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj14._update_period
    def _set_update_period(self, int l):
        proj14._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj14._update_offset
    def _set_update_offset(self, long l):
        proj14._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj14.get_post_rank()
    def pre_rank_all(self):
        return proj14.get_pre_ranks()
    def pre_rank(self, int n):
        return proj14.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj14.nb_dendrites()
    def nb_synapses(self):
        return proj14.nb_synapses()
    def dendrite_size(self, int n):
        return proj14.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj14.delay
    def get_dendrite_delay(self, idx):
        return proj14.delay
    def set_delay(self, value):
        proj14.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj14.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj14.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj14.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj14.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj14.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj14.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj14.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj14.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj14.size_in_bytes()

    def clear(self):
        return proj14.clear()

# Wrapper for projection 15
@cython.auto_pickle(True)
cdef class proj15_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj15.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj15.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj15._transmission
    def _set_transmission(self, bool l):
        proj15._transmission = l

    # Update flag
    def _get_update(self):
        return proj15._update
    def _set_update(self, bool l):
        proj15._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj15._plasticity
    def _set_plasticity(self, bool l):
        proj15._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj15._update_period
    def _set_update_period(self, int l):
        proj15._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj15._update_offset
    def _set_update_offset(self, long l):
        proj15._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj15.get_post_rank()
    def pre_rank_all(self):
        return proj15.get_pre_ranks()
    def pre_rank(self, int n):
        return proj15.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj15.nb_dendrites()
    def nb_synapses(self):
        return proj15.nb_synapses()
    def dendrite_size(self, int n):
        return proj15.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj15.delay
    def get_dendrite_delay(self, idx):
        return proj15.delay
    def set_delay(self, value):
        proj15.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj15.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj15.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj15.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj15.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj15.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj15.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj15.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj15.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj15.size_in_bytes()

    def clear(self):
        return proj15.clear()

# Wrapper for projection 16
@cython.auto_pickle(True)
cdef class proj16_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj16.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj16.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj16._transmission
    def _set_transmission(self, bool l):
        proj16._transmission = l

    # Update flag
    def _get_update(self):
        return proj16._update
    def _set_update(self, bool l):
        proj16._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj16._plasticity
    def _set_plasticity(self, bool l):
        proj16._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj16._update_period
    def _set_update_period(self, int l):
        proj16._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj16._update_offset
    def _set_update_offset(self, long l):
        proj16._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj16.get_post_rank()
    def pre_rank_all(self):
        return proj16.get_pre_ranks()
    def pre_rank(self, int n):
        return proj16.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj16.nb_dendrites()
    def nb_synapses(self):
        return proj16.nb_synapses()
    def dendrite_size(self, int n):
        return proj16.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj16.delay
    def get_dendrite_delay(self, idx):
        return proj16.delay
    def set_delay(self, value):
        proj16.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj16.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj16.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj16.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj16.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj16.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj16.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj16.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj16.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj16.size_in_bytes()

    def clear(self):
        return proj16.clear()

# Wrapper for projection 17
@cython.auto_pickle(True)
cdef class proj17_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj17.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj17.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj17._transmission
    def _set_transmission(self, bool l):
        proj17._transmission = l

    # Update flag
    def _get_update(self):
        return proj17._update
    def _set_update(self, bool l):
        proj17._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj17._plasticity
    def _set_plasticity(self, bool l):
        proj17._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj17._update_period
    def _set_update_period(self, int l):
        proj17._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj17._update_offset
    def _set_update_offset(self, long l):
        proj17._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj17.get_post_rank()
    def pre_rank_all(self):
        return proj17.get_pre_ranks()
    def pre_rank(self, int n):
        return proj17.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj17.nb_dendrites()
    def nb_synapses(self):
        return proj17.nb_synapses()
    def dendrite_size(self, int n):
        return proj17.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj17.delay
    def get_dendrite_delay(self, idx):
        return proj17.delay
    def set_delay(self, value):
        proj17.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj17.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj17.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj17.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj17.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj17.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj17.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj17.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj17.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj17.size_in_bytes()

    def clear(self):
        return proj17.clear()

# Wrapper for projection 18
@cython.auto_pickle(True)
cdef class proj18_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj18.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj18.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj18._transmission
    def _set_transmission(self, bool l):
        proj18._transmission = l

    # Update flag
    def _get_update(self):
        return proj18._update
    def _set_update(self, bool l):
        proj18._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj18._plasticity
    def _set_plasticity(self, bool l):
        proj18._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj18._update_period
    def _set_update_period(self, int l):
        proj18._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj18._update_offset
    def _set_update_offset(self, long l):
        proj18._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj18.get_post_rank()
    def pre_rank_all(self):
        return proj18.get_pre_ranks()
    def pre_rank(self, int n):
        return proj18.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj18.nb_dendrites()
    def nb_synapses(self):
        return proj18.nb_synapses()
    def dendrite_size(self, int n):
        return proj18.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj18.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj18.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj18.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj18.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj18.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj18.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj18.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj18.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj18.size_in_bytes()

    def clear(self):
        return proj18.clear()

# Wrapper for projection 19
@cython.auto_pickle(True)
cdef class proj19_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj19.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj19.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj19._transmission
    def _set_transmission(self, bool l):
        proj19._transmission = l

    # Update flag
    def _get_update(self):
        return proj19._update
    def _set_update(self, bool l):
        proj19._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj19._plasticity
    def _set_plasticity(self, bool l):
        proj19._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj19._update_period
    def _set_update_period(self, int l):
        proj19._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj19._update_offset
    def _set_update_offset(self, long l):
        proj19._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj19.get_post_rank()
    def pre_rank_all(self):
        return proj19.get_pre_ranks()
    def pre_rank(self, int n):
        return proj19.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj19.nb_dendrites()
    def nb_synapses(self):
        return proj19.nb_synapses()
    def dendrite_size(self, int n):
        return proj19.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj19.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj19.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj19.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj19.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj19.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj19.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj19.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj19.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj19.size_in_bytes()

    def clear(self):
        return proj19.clear()

# Wrapper for projection 20
@cython.auto_pickle(True)
cdef class proj20_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj20.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj20.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj20._transmission
    def _set_transmission(self, bool l):
        proj20._transmission = l

    # Update flag
    def _get_update(self):
        return proj20._update
    def _set_update(self, bool l):
        proj20._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj20._plasticity
    def _set_plasticity(self, bool l):
        proj20._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj20._update_period
    def _set_update_period(self, int l):
        proj20._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj20._update_offset
    def _set_update_offset(self, long l):
        proj20._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj20.get_post_rank()
    def pre_rank_all(self):
        return proj20.get_pre_ranks()
    def pre_rank(self, int n):
        return proj20.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj20.nb_dendrites()
    def nb_synapses(self):
        return proj20.nb_synapses()
    def dendrite_size(self, int n):
        return proj20.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj20.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj20.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj20.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj20.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj20.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj20.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj20.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj20.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj20.size_in_bytes()

    def clear(self):
        return proj20.clear()

# Wrapper for projection 21
@cython.auto_pickle(True)
cdef class proj21_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj21.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj21.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj21._transmission
    def _set_transmission(self, bool l):
        proj21._transmission = l

    # Update flag
    def _get_update(self):
        return proj21._update
    def _set_update(self, bool l):
        proj21._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj21._plasticity
    def _set_plasticity(self, bool l):
        proj21._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj21._update_period
    def _set_update_period(self, int l):
        proj21._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj21._update_offset
    def _set_update_offset(self, long l):
        proj21._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj21.get_post_rank()
    def pre_rank_all(self):
        return proj21.get_pre_ranks()
    def pre_rank(self, int n):
        return proj21.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj21.nb_dendrites()
    def nb_synapses(self):
        return proj21.nb_synapses()
    def dendrite_size(self, int n):
        return proj21.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj21.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj21.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj21.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj21.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj21.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj21.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj21.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj21.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj21.size_in_bytes()

    def clear(self):
        return proj21.clear()

# Wrapper for projection 22
@cython.auto_pickle(True)
cdef class proj22_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj22.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj22.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj22._transmission
    def _set_transmission(self, bool l):
        proj22._transmission = l

    # Update flag
    def _get_update(self):
        return proj22._update
    def _set_update(self, bool l):
        proj22._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj22._plasticity
    def _set_plasticity(self, bool l):
        proj22._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj22._update_period
    def _set_update_period(self, int l):
        proj22._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj22._update_offset
    def _set_update_offset(self, long l):
        proj22._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj22.get_post_rank()
    def pre_rank_all(self):
        return proj22.get_pre_ranks()
    def pre_rank(self, int n):
        return proj22.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj22.nb_dendrites()
    def nb_synapses(self):
        return proj22.nb_synapses()
    def dendrite_size(self, int n):
        return proj22.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj22.delay
    def get_dendrite_delay(self, idx):
        return proj22.delay
    def set_delay(self, value):
        proj22.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj22.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj22.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj22.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj22.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj22.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj22.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj22.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj22.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj22.size_in_bytes()

    def clear(self):
        return proj22.clear()

# Wrapper for projection 23
@cython.auto_pickle(True)
cdef class proj23_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj23.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj23.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj23._transmission
    def _set_transmission(self, bool l):
        proj23._transmission = l

    # Update flag
    def _get_update(self):
        return proj23._update
    def _set_update(self, bool l):
        proj23._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj23._plasticity
    def _set_plasticity(self, bool l):
        proj23._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj23._update_period
    def _set_update_period(self, int l):
        proj23._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj23._update_offset
    def _set_update_offset(self, long l):
        proj23._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj23.get_post_rank()
    def pre_rank_all(self):
        return proj23.get_pre_ranks()
    def pre_rank(self, int n):
        return proj23.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj23.nb_dendrites()
    def nb_synapses(self):
        return proj23.nb_synapses()
    def dendrite_size(self, int n):
        return proj23.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj23.delay
    def get_dendrite_delay(self, idx):
        return proj23.delay
    def set_delay(self, value):
        proj23.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj23.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj23.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj23.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj23.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj23.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj23.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj23.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj23.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj23.size_in_bytes()

    def clear(self):
        return proj23.clear()

# Wrapper for projection 24
@cython.auto_pickle(True)
cdef class proj24_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj24.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj24.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj24._transmission
    def _set_transmission(self, bool l):
        proj24._transmission = l

    # Update flag
    def _get_update(self):
        return proj24._update
    def _set_update(self, bool l):
        proj24._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj24._plasticity
    def _set_plasticity(self, bool l):
        proj24._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj24._update_period
    def _set_update_period(self, int l):
        proj24._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj24._update_offset
    def _set_update_offset(self, long l):
        proj24._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj24.get_post_rank()
    def pre_rank_all(self):
        return proj24.get_pre_ranks()
    def pre_rank(self, int n):
        return proj24.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj24.nb_dendrites()
    def nb_synapses(self):
        return proj24.nb_synapses()
    def dendrite_size(self, int n):
        return proj24.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj24.delay
    def get_dendrite_delay(self, idx):
        return proj24.delay
    def set_delay(self, value):
        proj24.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj24.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj24.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj24.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj24.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj24.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj24.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj24.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj24.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj24.size_in_bytes()

    def clear(self):
        return proj24.clear()

# Wrapper for projection 25
@cython.auto_pickle(True)
cdef class proj25_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj25.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj25.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj25._transmission
    def _set_transmission(self, bool l):
        proj25._transmission = l

    # Update flag
    def _get_update(self):
        return proj25._update
    def _set_update(self, bool l):
        proj25._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj25._plasticity
    def _set_plasticity(self, bool l):
        proj25._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj25._update_period
    def _set_update_period(self, int l):
        proj25._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj25._update_offset
    def _set_update_offset(self, long l):
        proj25._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj25.get_post_rank()
    def pre_rank_all(self):
        return proj25.get_pre_ranks()
    def pre_rank(self, int n):
        return proj25.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj25.nb_dendrites()
    def nb_synapses(self):
        return proj25.nb_synapses()
    def dendrite_size(self, int n):
        return proj25.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj25.delay
    def get_dendrite_delay(self, idx):
        return proj25.delay
    def set_delay(self, value):
        proj25.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj25.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj25.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj25.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj25.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj25.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj25.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj25.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj25.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj25.size_in_bytes()

    def clear(self):
        return proj25.clear()

# Wrapper for projection 26
@cython.auto_pickle(True)
cdef class proj26_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj26.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj26.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj26._transmission
    def _set_transmission(self, bool l):
        proj26._transmission = l

    # Update flag
    def _get_update(self):
        return proj26._update
    def _set_update(self, bool l):
        proj26._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj26._plasticity
    def _set_plasticity(self, bool l):
        proj26._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj26._update_period
    def _set_update_period(self, int l):
        proj26._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj26._update_offset
    def _set_update_offset(self, long l):
        proj26._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj26.get_post_rank()
    def pre_rank_all(self):
        return proj26.get_pre_ranks()
    def pre_rank(self, int n):
        return proj26.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj26.nb_dendrites()
    def nb_synapses(self):
        return proj26.nb_synapses()
    def dendrite_size(self, int n):
        return proj26.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj26.delay
    def get_dendrite_delay(self, idx):
        return proj26.delay
    def set_delay(self, value):
        proj26.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj26.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj26.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj26.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj26.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj26.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj26.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj26.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj26.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj26.size_in_bytes()

    def clear(self):
        return proj26.clear()

# Wrapper for projection 27
@cython.auto_pickle(True)
cdef class proj27_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj27.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj27.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj27._transmission
    def _set_transmission(self, bool l):
        proj27._transmission = l

    # Update flag
    def _get_update(self):
        return proj27._update
    def _set_update(self, bool l):
        proj27._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj27._plasticity
    def _set_plasticity(self, bool l):
        proj27._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj27._update_period
    def _set_update_period(self, int l):
        proj27._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj27._update_offset
    def _set_update_offset(self, long l):
        proj27._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj27.get_post_rank()
    def pre_rank_all(self):
        return proj27.get_pre_ranks()
    def pre_rank(self, int n):
        return proj27.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj27.nb_dendrites()
    def nb_synapses(self):
        return proj27.nb_synapses()
    def dendrite_size(self, int n):
        return proj27.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj27.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj27.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj27.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj27.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj27.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj27.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj27.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj27.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj27.size_in_bytes()

    def clear(self):
        return proj27.clear()

# Wrapper for projection 28
@cython.auto_pickle(True)
cdef class proj28_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj28.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj28.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj28._transmission
    def _set_transmission(self, bool l):
        proj28._transmission = l

    # Update flag
    def _get_update(self):
        return proj28._update
    def _set_update(self, bool l):
        proj28._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj28._plasticity
    def _set_plasticity(self, bool l):
        proj28._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj28._update_period
    def _set_update_period(self, int l):
        proj28._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj28._update_offset
    def _set_update_offset(self, long l):
        proj28._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj28.get_post_rank()
    def pre_rank_all(self):
        return proj28.get_pre_ranks()
    def pre_rank(self, int n):
        return proj28.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj28.nb_dendrites()
    def nb_synapses(self):
        return proj28.nb_synapses()
    def dendrite_size(self, int n):
        return proj28.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj28.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj28.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj28.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj28.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj28.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj28.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj28.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj28.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj28.size_in_bytes()

    def clear(self):
        return proj28.clear()

# Wrapper for projection 29
@cython.auto_pickle(True)
cdef class proj29_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj29.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj29.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj29._transmission
    def _set_transmission(self, bool l):
        proj29._transmission = l

    # Update flag
    def _get_update(self):
        return proj29._update
    def _set_update(self, bool l):
        proj29._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj29._plasticity
    def _set_plasticity(self, bool l):
        proj29._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj29._update_period
    def _set_update_period(self, int l):
        proj29._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj29._update_offset
    def _set_update_offset(self, long l):
        proj29._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj29.get_post_rank()
    def pre_rank_all(self):
        return proj29.get_pre_ranks()
    def pre_rank(self, int n):
        return proj29.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj29.nb_dendrites()
    def nb_synapses(self):
        return proj29.nb_synapses()
    def dendrite_size(self, int n):
        return proj29.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj29.delay
    def get_dendrite_delay(self, idx):
        return proj29.delay
    def set_delay(self, value):
        proj29.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj29.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj29.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj29.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj29.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj29.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj29.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj29.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj29.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj29.size_in_bytes()

    def clear(self):
        return proj29.clear()

# Wrapper for projection 30
@cython.auto_pickle(True)
cdef class proj30_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj30.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj30.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj30._transmission
    def _set_transmission(self, bool l):
        proj30._transmission = l

    # Update flag
    def _get_update(self):
        return proj30._update
    def _set_update(self, bool l):
        proj30._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj30._plasticity
    def _set_plasticity(self, bool l):
        proj30._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj30._update_period
    def _set_update_period(self, int l):
        proj30._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj30._update_offset
    def _set_update_offset(self, long l):
        proj30._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj30.get_post_rank()
    def pre_rank_all(self):
        return proj30.get_pre_ranks()
    def pre_rank(self, int n):
        return proj30.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj30.nb_dendrites()
    def nb_synapses(self):
        return proj30.nb_synapses()
    def dendrite_size(self, int n):
        return proj30.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj30.delay
    def get_dendrite_delay(self, idx):
        return proj30.delay
    def set_delay(self, value):
        proj30.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj30.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj30.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj30.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj30.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj30.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj30.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj30.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj30.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj30.size_in_bytes()

    def clear(self):
        return proj30.clear()

# Wrapper for projection 31
@cython.auto_pickle(True)
cdef class proj31_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj31.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj31.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj31._transmission
    def _set_transmission(self, bool l):
        proj31._transmission = l

    # Update flag
    def _get_update(self):
        return proj31._update
    def _set_update(self, bool l):
        proj31._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj31._plasticity
    def _set_plasticity(self, bool l):
        proj31._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj31._update_period
    def _set_update_period(self, int l):
        proj31._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj31._update_offset
    def _set_update_offset(self, long l):
        proj31._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj31.get_post_rank()
    def pre_rank_all(self):
        return proj31.get_pre_ranks()
    def pre_rank(self, int n):
        return proj31.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj31.nb_dendrites()
    def nb_synapses(self):
        return proj31.nb_synapses()
    def dendrite_size(self, int n):
        return proj31.dendrite_size(n)



    # Access to non-uniform delay
    def get_delay(self):
        return proj31.delay
    def get_dendrite_delay(self, idx):
        return proj31.delay
    def set_delay(self, value):
        proj31.delay = value


    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj31.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj31.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj31.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj31.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj31.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj31.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj31.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj31.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj31.size_in_bytes()

    def clear(self):
        return proj31.clear()

# Wrapper for projection 32
@cython.auto_pickle(True)
cdef class proj32_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj32.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj32.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj32._transmission
    def _set_transmission(self, bool l):
        proj32._transmission = l

    # Update flag
    def _get_update(self):
        return proj32._update
    def _set_update(self, bool l):
        proj32._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj32._plasticity
    def _set_plasticity(self, bool l):
        proj32._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj32._update_period
    def _set_update_period(self, int l):
        proj32._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj32._update_offset
    def _set_update_offset(self, long l):
        proj32._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj32.get_post_rank()
    def pre_rank_all(self):
        return proj32.get_pre_ranks()
    def pre_rank(self, int n):
        return proj32.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj32.nb_dendrites()
    def nb_synapses(self):
        return proj32.nb_synapses()
    def dendrite_size(self, int n):
        return proj32.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj32.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj32.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj32.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj32.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj32.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj32.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj32.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj32.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj32.size_in_bytes()

    def clear(self):
        return proj32.clear()

# Wrapper for projection 33
@cython.auto_pickle(True)
cdef class proj33_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj33.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj33.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj33._transmission
    def _set_transmission(self, bool l):
        proj33._transmission = l

    # Update flag
    def _get_update(self):
        return proj33._update
    def _set_update(self, bool l):
        proj33._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj33._plasticity
    def _set_plasticity(self, bool l):
        proj33._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj33._update_period
    def _set_update_period(self, int l):
        proj33._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj33._update_offset
    def _set_update_offset(self, long l):
        proj33._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj33.get_post_rank()
    def pre_rank_all(self):
        return proj33.get_pre_ranks()
    def pre_rank(self, int n):
        return proj33.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj33.nb_dendrites()
    def nb_synapses(self):
        return proj33.nb_synapses()
    def dendrite_size(self, int n):
        return proj33.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj33.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj33.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj33.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj33.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj33.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj33.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj33.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj33.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj33.size_in_bytes()

    def clear(self):
        return proj33.clear()

# Wrapper for projection 34
@cython.auto_pickle(True)
cdef class proj34_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj34.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj34.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj34._transmission
    def _set_transmission(self, bool l):
        proj34._transmission = l

    # Update flag
    def _get_update(self):
        return proj34._update
    def _set_update(self, bool l):
        proj34._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj34._plasticity
    def _set_plasticity(self, bool l):
        proj34._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj34._update_period
    def _set_update_period(self, int l):
        proj34._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj34._update_offset
    def _set_update_offset(self, long l):
        proj34._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj34.get_post_rank()
    def pre_rank_all(self):
        return proj34.get_pre_ranks()
    def pre_rank(self, int n):
        return proj34.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj34.nb_dendrites()
    def nb_synapses(self):
        return proj34.nb_synapses()
    def dendrite_size(self, int n):
        return proj34.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj34.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj34.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj34.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj34.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj34.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj34.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj34.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj34.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj34.size_in_bytes()

    def clear(self):
        return proj34.clear()

# Wrapper for projection 35
@cython.auto_pickle(True)
cdef class proj35_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj35.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj35.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj35._transmission
    def _set_transmission(self, bool l):
        proj35._transmission = l

    # Update flag
    def _get_update(self):
        return proj35._update
    def _set_update(self, bool l):
        proj35._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj35._plasticity
    def _set_plasticity(self, bool l):
        proj35._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj35._update_period
    def _set_update_period(self, int l):
        proj35._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj35._update_offset
    def _set_update_offset(self, long l):
        proj35._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj35.get_post_rank()
    def pre_rank_all(self):
        return proj35.get_pre_ranks()
    def pre_rank(self, int n):
        return proj35.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj35.nb_dendrites()
    def nb_synapses(self):
        return proj35.nb_synapses()
    def dendrite_size(self, int n):
        return proj35.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj35.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj35.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj35.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj35.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj35.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj35.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj35.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj35.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj35.size_in_bytes()

    def clear(self):
        return proj35.clear()

# Wrapper for projection 36
@cython.auto_pickle(True)
cdef class proj36_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj36.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj36.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj36._transmission
    def _set_transmission(self, bool l):
        proj36._transmission = l

    # Update flag
    def _get_update(self):
        return proj36._update
    def _set_update(self, bool l):
        proj36._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj36._plasticity
    def _set_plasticity(self, bool l):
        proj36._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj36._update_period
    def _set_update_period(self, int l):
        proj36._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj36._update_offset
    def _set_update_offset(self, long l):
        proj36._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj36.get_post_rank()
    def pre_rank_all(self):
        return proj36.get_pre_ranks()
    def pre_rank(self, int n):
        return proj36.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj36.nb_dendrites()
    def nb_synapses(self):
        return proj36.nb_synapses()
    def dendrite_size(self, int n):
        return proj36.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj36.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj36.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj36.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj36.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj36.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj36.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj36.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj36.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj36.size_in_bytes()

    def clear(self):
        return proj36.clear()

# Wrapper for projection 37
@cython.auto_pickle(True)
cdef class proj37_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj37.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj37.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj37._transmission
    def _set_transmission(self, bool l):
        proj37._transmission = l

    # Update flag
    def _get_update(self):
        return proj37._update
    def _set_update(self, bool l):
        proj37._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj37._plasticity
    def _set_plasticity(self, bool l):
        proj37._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj37._update_period
    def _set_update_period(self, int l):
        proj37._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj37._update_offset
    def _set_update_offset(self, long l):
        proj37._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj37.get_post_rank()
    def pre_rank_all(self):
        return proj37.get_pre_ranks()
    def pre_rank(self, int n):
        return proj37.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj37.nb_dendrites()
    def nb_synapses(self):
        return proj37.nb_synapses()
    def dendrite_size(self, int n):
        return proj37.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj37.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj37.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj37.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj37.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj37.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj37.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj37.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj37.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj37.size_in_bytes()

    def clear(self):
        return proj37.clear()

# Wrapper for projection 38
@cython.auto_pickle(True)
cdef class proj38_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj38.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj38.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj38._transmission
    def _set_transmission(self, bool l):
        proj38._transmission = l

    # Update flag
    def _get_update(self):
        return proj38._update
    def _set_update(self, bool l):
        proj38._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj38._plasticity
    def _set_plasticity(self, bool l):
        proj38._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj38._update_period
    def _set_update_period(self, int l):
        proj38._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj38._update_offset
    def _set_update_offset(self, long l):
        proj38._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj38.get_post_rank()
    def pre_rank_all(self):
        return proj38.get_pre_ranks()
    def pre_rank(self, int n):
        return proj38.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj38.nb_dendrites()
    def nb_synapses(self):
        return proj38.nb_synapses()
    def dendrite_size(self, int n):
        return proj38.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj38.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj38.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj38.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj38.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj38.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj38.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj38.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj38.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj38.size_in_bytes()

    def clear(self):
        return proj38.clear()

# Wrapper for projection 39
@cython.auto_pickle(True)
cdef class proj39_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj39.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj39.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj39._transmission
    def _set_transmission(self, bool l):
        proj39._transmission = l

    # Update flag
    def _get_update(self):
        return proj39._update
    def _set_update(self, bool l):
        proj39._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj39._plasticity
    def _set_plasticity(self, bool l):
        proj39._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj39._update_period
    def _set_update_period(self, int l):
        proj39._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj39._update_offset
    def _set_update_offset(self, long l):
        proj39._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj39.get_post_rank()
    def pre_rank_all(self):
        return proj39.get_pre_ranks()
    def pre_rank(self, int n):
        return proj39.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj39.nb_dendrites()
    def nb_synapses(self):
        return proj39.nb_synapses()
    def dendrite_size(self, int n):
        return proj39.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj39.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj39.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj39.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj39.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj39.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj39.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj39.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj39.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj39.size_in_bytes()

    def clear(self):
        return proj39.clear()

# Wrapper for projection 40
@cython.auto_pickle(True)
cdef class proj40_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj40.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj40.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj40._transmission
    def _set_transmission(self, bool l):
        proj40._transmission = l

    # Update flag
    def _get_update(self):
        return proj40._update
    def _set_update(self, bool l):
        proj40._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj40._plasticity
    def _set_plasticity(self, bool l):
        proj40._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj40._update_period
    def _set_update_period(self, int l):
        proj40._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj40._update_offset
    def _set_update_offset(self, long l):
        proj40._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj40.get_post_rank()
    def pre_rank_all(self):
        return proj40.get_pre_ranks()
    def pre_rank(self, int n):
        return proj40.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj40.nb_dendrites()
    def nb_synapses(self):
        return proj40.nb_synapses()
    def dendrite_size(self, int n):
        return proj40.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj40.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj40.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj40.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj40.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj40.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj40.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj40.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj40.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj40.size_in_bytes()

    def clear(self):
        return proj40.clear()

# Wrapper for projection 41
@cython.auto_pickle(True)
cdef class proj41_wrapper :

    def __init__(self, ):
                    pass


    def init_from_lil(self, synapses):
        proj41.init_from_lil(synapses.post_rank, synapses.pre_rank, synapses.w, synapses.delay)


    property size:
        def __get__(self):
            return proj41.nb_dendrites()

    # Transmission flag
    def _get_transmission(self):
        return proj41._transmission
    def _set_transmission(self, bool l):
        proj41._transmission = l

    # Update flag
    def _get_update(self):
        return proj41._update
    def _set_update(self, bool l):
        proj41._update = l

    # Plasticity flag
    def _get_plasticity(self):
        return proj41._plasticity
    def _set_plasticity(self, bool l):
        proj41._plasticity = l

    # Update period
    def _get_update_period(self):
        return proj41._update_period
    def _set_update_period(self, int l):
        proj41._update_period = l

    # Update offset
    def _get_update_offset(self):
        return proj41._update_offset
    def _set_update_offset(self, long l):
        proj41._update_offset = l

    # Access connectivity

    def post_rank(self):
        return proj41.get_post_rank()
    def pre_rank_all(self):
        return proj41.get_pre_ranks()
    def pre_rank(self, int n):
        return proj41.get_dendrite_pre_rank(n)
    def nb_dendrites(self):
        return proj41.nb_dendrites()
    def nb_synapses(self):
        return proj41.nb_synapses()
    def dendrite_size(self, int n):
        return proj41.dendrite_size(n)




    # Local Attribute
    def get_local_attribute_all(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj41.get_local_attribute_all_double(cpp_string)


    def get_local_attribute_row(self, name, rk_post, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj41.get_local_attribute_row_double(cpp_string, rk_post)


    def get_local_attribute(self, name, rk_post, rk_pre, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            return proj41.get_local_attribute_double(cpp_string, rk_post, rk_pre)


    def set_local_attribute_all(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj41.set_local_attribute_all_double(cpp_string, value)


    def set_local_attribute_row(self, name, rk_post, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj41.set_local_attribute_row_double(cpp_string, rk_post, value)


    def set_local_attribute(self, name, rk_post, rk_pre, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":
            proj41.set_local_attribute_double(cpp_string, rk_post, rk_pre, value)


    # Global Attributes
    def get_global_attribute(self, name, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            return proj41.get_global_attribute_double(cpp_string)


    def set_global_attribute(self, name, value, ctype):
        cpp_string = name.encode('utf-8')

        if ctype == "double":            
            proj41.set_global_attribute_double(cpp_string, value)






    # memory management
    def size_in_bytes(self):
        return proj41.size_in_bytes()

    def clear(self):
        return proj41.clear()


# Monitor wrappers

# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder0_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder0.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder0.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder0.get_instance(self.id)).clear()

    property r:
        def __get__(self): return (PopRecorder0.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder0.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder0.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder0.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder0.get_instance(self.id)).r.clear()

    # Targets
# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder1_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder1.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder1.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder1.get_instance(self.id)).clear()

    property r:
        def __get__(self): return (PopRecorder1.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder1.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder1.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder1.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder1.get_instance(self.id)).r.clear()

    # Targets
# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder2_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder2.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder2.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder2.get_instance(self.id)).clear()

    property r:
        def __get__(self): return (PopRecorder2.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder2.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder2.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder2.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder2.get_instance(self.id)).r.clear()

    # Targets
# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder3_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder3.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder3.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder3.get_instance(self.id)).clear()

    property r:
        def __get__(self): return (PopRecorder3.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder3.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder3.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder3.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder3.get_instance(self.id)).r.clear()

    # Targets
# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder4_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder4.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder4.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder4.get_instance(self.id)).clear()

    property r:
        def __get__(self): return (PopRecorder4.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder4.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder4.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder4.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder4.get_instance(self.id)).r.clear()

    # Targets
# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder5_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder5.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder5.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder5.get_instance(self.id)).clear()

    property mp:
        def __get__(self): return (PopRecorder5.get_instance(self.id)).mp
        def __set__(self, val): (PopRecorder5.get_instance(self.id)).mp = val
    property record_mp:
        def __get__(self): return (PopRecorder5.get_instance(self.id)).record_mp
        def __set__(self, val): (PopRecorder5.get_instance(self.id)).record_mp = val
    def clear_mp(self):
        (PopRecorder5.get_instance(self.id)).mp.clear()

    property r:
        def __get__(self): return (PopRecorder5.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder5.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder5.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder5.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder5.get_instance(self.id)).r.clear()

    # Targets
    property _sum_exc:
        def __get__(self): return (PopRecorder5.get_instance(self.id))._sum_exc
        def __set__(self, val): (PopRecorder5.get_instance(self.id))._sum_exc = val
    property record__sum_exc:
        def __get__(self): return (PopRecorder5.get_instance(self.id)).record__sum_exc
        def __set__(self, val): (PopRecorder5.get_instance(self.id)).record__sum_exc = val
    def clear__sum_exc(self):
        (PopRecorder5.get_instance(self.id))._sum_exc.clear()

    property _sum_inh:
        def __get__(self): return (PopRecorder5.get_instance(self.id))._sum_inh
        def __set__(self, val): (PopRecorder5.get_instance(self.id))._sum_inh = val
    property record__sum_inh:
        def __get__(self): return (PopRecorder5.get_instance(self.id)).record__sum_inh
        def __set__(self, val): (PopRecorder5.get_instance(self.id)).record__sum_inh = val
    def clear__sum_inh(self):
        (PopRecorder5.get_instance(self.id))._sum_inh.clear()

# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder6_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder6.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder6.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder6.get_instance(self.id)).clear()

    property mp:
        def __get__(self): return (PopRecorder6.get_instance(self.id)).mp
        def __set__(self, val): (PopRecorder6.get_instance(self.id)).mp = val
    property record_mp:
        def __get__(self): return (PopRecorder6.get_instance(self.id)).record_mp
        def __set__(self, val): (PopRecorder6.get_instance(self.id)).record_mp = val
    def clear_mp(self):
        (PopRecorder6.get_instance(self.id)).mp.clear()

    property r:
        def __get__(self): return (PopRecorder6.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder6.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder6.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder6.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder6.get_instance(self.id)).r.clear()

    # Targets
    property _sum_exc:
        def __get__(self): return (PopRecorder6.get_instance(self.id))._sum_exc
        def __set__(self, val): (PopRecorder6.get_instance(self.id))._sum_exc = val
    property record__sum_exc:
        def __get__(self): return (PopRecorder6.get_instance(self.id)).record__sum_exc
        def __set__(self, val): (PopRecorder6.get_instance(self.id)).record__sum_exc = val
    def clear__sum_exc(self):
        (PopRecorder6.get_instance(self.id))._sum_exc.clear()

    property _sum_inh:
        def __get__(self): return (PopRecorder6.get_instance(self.id))._sum_inh
        def __set__(self, val): (PopRecorder6.get_instance(self.id))._sum_inh = val
    property record__sum_inh:
        def __get__(self): return (PopRecorder6.get_instance(self.id)).record__sum_inh
        def __set__(self, val): (PopRecorder6.get_instance(self.id)).record__sum_inh = val
    def clear__sum_inh(self):
        (PopRecorder6.get_instance(self.id))._sum_inh.clear()

# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder7_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder7.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder7.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder7.get_instance(self.id)).clear()

    property mp:
        def __get__(self): return (PopRecorder7.get_instance(self.id)).mp
        def __set__(self, val): (PopRecorder7.get_instance(self.id)).mp = val
    property record_mp:
        def __get__(self): return (PopRecorder7.get_instance(self.id)).record_mp
        def __set__(self, val): (PopRecorder7.get_instance(self.id)).record_mp = val
    def clear_mp(self):
        (PopRecorder7.get_instance(self.id)).mp.clear()

    property r:
        def __get__(self): return (PopRecorder7.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder7.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder7.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder7.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder7.get_instance(self.id)).r.clear()

    # Targets
    property _sum_exc:
        def __get__(self): return (PopRecorder7.get_instance(self.id))._sum_exc
        def __set__(self, val): (PopRecorder7.get_instance(self.id))._sum_exc = val
    property record__sum_exc:
        def __get__(self): return (PopRecorder7.get_instance(self.id)).record__sum_exc
        def __set__(self, val): (PopRecorder7.get_instance(self.id)).record__sum_exc = val
    def clear__sum_exc(self):
        (PopRecorder7.get_instance(self.id))._sum_exc.clear()

    property _sum_inh:
        def __get__(self): return (PopRecorder7.get_instance(self.id))._sum_inh
        def __set__(self, val): (PopRecorder7.get_instance(self.id))._sum_inh = val
    property record__sum_inh:
        def __get__(self): return (PopRecorder7.get_instance(self.id)).record__sum_inh
        def __set__(self, val): (PopRecorder7.get_instance(self.id)).record__sum_inh = val
    def clear__sum_inh(self):
        (PopRecorder7.get_instance(self.id))._sum_inh.clear()

# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder8_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder8.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder8.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder8.get_instance(self.id)).clear()

    property mp:
        def __get__(self): return (PopRecorder8.get_instance(self.id)).mp
        def __set__(self, val): (PopRecorder8.get_instance(self.id)).mp = val
    property record_mp:
        def __get__(self): return (PopRecorder8.get_instance(self.id)).record_mp
        def __set__(self, val): (PopRecorder8.get_instance(self.id)).record_mp = val
    def clear_mp(self):
        (PopRecorder8.get_instance(self.id)).mp.clear()

    property r:
        def __get__(self): return (PopRecorder8.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder8.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder8.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder8.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder8.get_instance(self.id)).r.clear()

    # Targets
    property _sum_exc:
        def __get__(self): return (PopRecorder8.get_instance(self.id))._sum_exc
        def __set__(self, val): (PopRecorder8.get_instance(self.id))._sum_exc = val
    property record__sum_exc:
        def __get__(self): return (PopRecorder8.get_instance(self.id)).record__sum_exc
        def __set__(self, val): (PopRecorder8.get_instance(self.id)).record__sum_exc = val
    def clear__sum_exc(self):
        (PopRecorder8.get_instance(self.id))._sum_exc.clear()

    property _sum_inh:
        def __get__(self): return (PopRecorder8.get_instance(self.id))._sum_inh
        def __set__(self, val): (PopRecorder8.get_instance(self.id))._sum_inh = val
    property record__sum_inh:
        def __get__(self): return (PopRecorder8.get_instance(self.id)).record__sum_inh
        def __set__(self, val): (PopRecorder8.get_instance(self.id)).record__sum_inh = val
    def clear__sum_inh(self):
        (PopRecorder8.get_instance(self.id))._sum_inh.clear()

# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder9_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder9.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder9.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder9.get_instance(self.id)).clear()

    property mp:
        def __get__(self): return (PopRecorder9.get_instance(self.id)).mp
        def __set__(self, val): (PopRecorder9.get_instance(self.id)).mp = val
    property record_mp:
        def __get__(self): return (PopRecorder9.get_instance(self.id)).record_mp
        def __set__(self, val): (PopRecorder9.get_instance(self.id)).record_mp = val
    def clear_mp(self):
        (PopRecorder9.get_instance(self.id)).mp.clear()

    property r:
        def __get__(self): return (PopRecorder9.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder9.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder9.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder9.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder9.get_instance(self.id)).r.clear()

    # Targets
    property _sum_exc:
        def __get__(self): return (PopRecorder9.get_instance(self.id))._sum_exc
        def __set__(self, val): (PopRecorder9.get_instance(self.id))._sum_exc = val
    property record__sum_exc:
        def __get__(self): return (PopRecorder9.get_instance(self.id)).record__sum_exc
        def __set__(self, val): (PopRecorder9.get_instance(self.id)).record__sum_exc = val
    def clear__sum_exc(self):
        (PopRecorder9.get_instance(self.id))._sum_exc.clear()

    property _sum_inh:
        def __get__(self): return (PopRecorder9.get_instance(self.id))._sum_inh
        def __set__(self, val): (PopRecorder9.get_instance(self.id))._sum_inh = val
    property record__sum_inh:
        def __get__(self): return (PopRecorder9.get_instance(self.id)).record__sum_inh
        def __set__(self, val): (PopRecorder9.get_instance(self.id)).record__sum_inh = val
    def clear__sum_inh(self):
        (PopRecorder9.get_instance(self.id))._sum_inh.clear()

# Population Monitor wrapper
@cython.auto_pickle(True)
cdef class PopRecorder10_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, period_offset, long offset):
        self.id = PopRecorder10.create_instance(ranks, period, period_offset, offset)

    def size_in_bytes(self):
        return (PopRecorder10.get_instance(self.id)).size_in_bytes()

    def clear(self):
        return (PopRecorder10.get_instance(self.id)).clear()

    property mp:
        def __get__(self): return (PopRecorder10.get_instance(self.id)).mp
        def __set__(self, val): (PopRecorder10.get_instance(self.id)).mp = val
    property record_mp:
        def __get__(self): return (PopRecorder10.get_instance(self.id)).record_mp
        def __set__(self, val): (PopRecorder10.get_instance(self.id)).record_mp = val
    def clear_mp(self):
        (PopRecorder10.get_instance(self.id)).mp.clear()

    property r:
        def __get__(self): return (PopRecorder10.get_instance(self.id)).r
        def __set__(self, val): (PopRecorder10.get_instance(self.id)).r = val
    property record_r:
        def __get__(self): return (PopRecorder10.get_instance(self.id)).record_r
        def __set__(self, val): (PopRecorder10.get_instance(self.id)).record_r = val
    def clear_r(self):
        (PopRecorder10.get_instance(self.id)).r.clear()

    # Targets
    property _sum_exc:
        def __get__(self): return (PopRecorder10.get_instance(self.id))._sum_exc
        def __set__(self, val): (PopRecorder10.get_instance(self.id))._sum_exc = val
    property record__sum_exc:
        def __get__(self): return (PopRecorder10.get_instance(self.id)).record__sum_exc
        def __set__(self, val): (PopRecorder10.get_instance(self.id)).record__sum_exc = val
    def clear__sum_exc(self):
        (PopRecorder10.get_instance(self.id))._sum_exc.clear()

    property _sum_inh:
        def __get__(self): return (PopRecorder10.get_instance(self.id))._sum_inh
        def __set__(self, val): (PopRecorder10.get_instance(self.id))._sum_inh = val
    property record__sum_inh:
        def __get__(self): return (PopRecorder10.get_instance(self.id)).record__sum_inh
        def __set__(self, val): (PopRecorder10.get_instance(self.id)).record__sum_inh = val
    def clear__sum_inh(self):
        (PopRecorder10.get_instance(self.id))._sum_inh.clear()

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder0_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder0.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder1_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder1.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder2_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder2.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder3_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder3.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder4_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder4.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder5_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder5.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder6_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder6.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder7_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder7.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder8_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder8.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder9_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder9.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder10_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder10.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder11_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder11.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder12_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder12.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder13_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder13.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder14_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder14.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder15_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder15.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder16_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder16.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder17_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder17.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder18_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder18.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder19_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder19.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder20_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder20.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder21_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder21.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder22_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder22.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder23_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder23.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder24_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder24.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder25_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder25.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder26_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder26.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder27_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder27.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder28_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder28.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder29_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder29.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder30_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder30.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder31_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder31.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder32_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder32.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder33_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder33.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder34_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder34.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder35_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder35.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder36_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder36.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder37_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder37.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder38_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder38.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder39_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder39.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder40_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder40.create_instance(ranks, period, period_offset, offset)

# Projection Monitor wrapper
@cython.auto_pickle(True)
cdef class ProjRecorder41_wrapper:
    cdef int id
    def __init__(self, list ranks, int period, int period_offset, long offset):
        self.id = ProjRecorder41.create_instance(ranks, period, period_offset, offset)


# User-defined functions


# User-defined constants

def _set_tau_MSN(double value):
    set_tau_MSN(value)
def _set_tau_FSI(double value):
    set_tau_FSI(value)
def _set_tau_STN(double value):
    set_tau_STN(value)
def _set_tau_GPe(double value):
    set_tau_GPe(value)
def _set_tau_GPiSNr(double value):
    set_tau_GPiSNr(value)
def _set_sigmap(double value):
    set_sigmap(value)
def _set_Smax_MSN(double value):
    set_Smax_MSN(value)
def _set_Smax_STN(double value):
    set_Smax_STN(value)
def _set_Smax_GPe(double value):
    set_Smax_GPe(value)
def _set_Smax_GPiSNr(double value):
    set_Smax_GPiSNr(value)
def _set_Smax_FSI(double value):
    set_Smax_FSI(value)
def _set_theta_MSN(double value):
    set_theta_MSN(value)
def _set_theta_FSI(double value):
    set_theta_FSI(value)
def _set_theta_STN(double value):
    set_theta_STN(value)
def _set_theta_GPe(double value):
    set_theta_GPe(value)
def _set_theta_GPiSNr(double value):
    set_theta_GPiSNr(value)

# Initialize the network
def pyx_create(double dt):
    initialize(dt)

def pyx_init_rng_dist():
    init_rng_dist()

# Simple progressbar on the command line
def progress(count, total, status=''):
    """
    Prints a progress bar on the command line.

    adapted from: https://gist.github.com/vladignatyev/06860ec2040cb497f0f3

    Modification: The original code set the '\r' at the end, so the bar disappears when finished.
    I moved it to the front, so the last status remains.
    """
    bar_len = 60
    filled_len = int(round(bar_len * count / float(total)))

    percents = round(100.0 * count / float(total), 1)
    bar = '=' * filled_len + '-' * (bar_len - filled_len)

    sys.stdout.write('\r[%s] %s%s ...%s' % (bar, percents, '%', status))
    sys.stdout.flush()

# Simulation for the given number of steps
def pyx_run(int nb_steps, progress_bar):
    cdef int nb, rest
    cdef int batch = 1000
    if nb_steps < batch:
        with nogil:
            run(nb_steps)
    else:
        nb = int(nb_steps/batch)
        rest = nb_steps % batch
        for i in range(nb):
            with nogil:
                run(batch)
            PyErr_CheckSignals()
            if nb > 1 and progress_bar:
                progress(i+1, nb, 'simulate()')
        if rest > 0:
            run(rest)

        if (progress_bar):
            print('\n')

# Simulation for the given number of steps except if a criterion is reached
def pyx_run_until(int nb_steps, list populations, bool mode):
    cdef int nb
    nb = run_until(nb_steps, populations, mode)
    return nb

# Simulate for one step
def pyx_step():
    step()

# Access time
def set_time(t):
    setTime(t)
def get_time():
    return getTime()

# Access dt
def set_dt(double dt):
    setDt(dt)
def get_dt():
    return getDt()


# Set number of threads
def set_number_threads(int n, core_list):
    setNumberThreads(n, core_list)


# Set seed
def set_seed(long seed, int num_sources, use_seed_seq):
    setSeed(seed, num_sources, use_seed_seq)
