/*
 *  ANNarchy-version: 4.7.0
 */
#pragma once
#include "ANNarchy.h"
#include <random>


extern double dt;
extern long int t;
extern std::vector<std::mt19937> rng;


///////////////////////////////////////////////////////////////
// Main Structure for the population of id 16 (pop16)
///////////////////////////////////////////////////////////////
struct PopStruct16{

    int size; // Number of neurons
    bool _active; // Allows to shut down the whole population
    int max_delay; // Maximum number of steps to store for delayed synaptic transmission

    // Access functions used by cython wrapper
    int get_size() { return size; }
    void set_size(int s) { size  = s; }
    int get_max_delay() { return max_delay; }
    void set_max_delay(int d) { max_delay  = d; }
    bool is_active() { return _active; }
    void set_active(bool val) { _active = val; }



    // Neuron specific parameters and variables

    // Local variable r
    std::vector< double > r;

    // Random numbers


    // Delayed variables
    std::deque< std::vector< double > > _delayed_r;


    // Custom local parameters of a TimedArray
    std::vector< int > _schedule; // List of times where new inputs should be set
    std::vector< std::vector< double > > _buffer; // buffer holding the data
    int _period; // Period of cycling
    long int _t; // Internal time
    int _block; // Internal block when inputs are set not at each step


    // Access methods to the parameters and variables

    std::vector<double> get_local_attribute_all_double(std::string name) {

        // Local variable r
        if ( name.compare("r") == 0 ) {
            return r;
        }


        // should not happen
        std::cerr << "PopStruct16::get_local_attribute_all_double: " << name << " not found" << std::endl;
        return std::vector<double>();
    }

    double get_local_attribute_double(std::string name, int rk) {
        assert( (rk < size) );

        // Local variable r
        if ( name.compare("r") == 0 ) {
            return r[rk];
        }


        // should not happen
        std::cerr << "PopStruct16::get_local_attribute_double: " << name << " not found" << std::endl;
        return static_cast<double>(0.0);
    }

    void set_local_attribute_all_double(std::string name, std::vector<double> value) {
        assert( (value.size() == size) );

        // Local variable r
        if ( name.compare("r") == 0 ) {
            r = value;
            return;
        }


        // should not happen
        std::cerr << "PopStruct16::set_local_attribute_all_double: " << name << " not found" << std::endl;
    }

    void set_local_attribute_double(std::string name, int rk, double value) {
        assert( (rk < size) );

        // Local variable r
        if ( name.compare("r") == 0 ) {
            r[rk] = value;
            return;
        }


        // should not happen
        std::cerr << "PopStruct16::set_local_attribute_double: " << name << " not found" << std::endl;
    }


    // Custom local parameters of a TimedArray
    void set_schedule(std::vector<int> schedule) { _schedule = schedule; }
    std::vector<int> get_schedule() { return _schedule; }
    void set_buffer(std::vector< std::vector< double > > buffer) { _buffer = buffer; r = _buffer[0]; }
    std::vector< std::vector< double > > get_buffer() { return _buffer; }
    void set_period(int period) { _period = period; }
    int get_period() { return _period; }


    // Method called to initialize the data structures
    void init_population() {
    #ifdef _DEBUG
        std::cout << "PopStruct16::init_population() - this = " << this << std::endl;
    #endif
        _active = true;

        // Local variable r
        r = std::vector<double>(size, 0.0);



        // Delayed variables
        _delayed_r = std::deque< std::vector< double > >(max_delay, std::vector< double >(size, 0.0));


        // Initialize counters
        _t = 0;
        _block = 0;
        _period = -1;


    }

    // Method called to reset the population
    void reset() {


        for ( int i = 0; i < _delayed_r.size(); i++ ) {
            _delayed_r[i] = r;
        }


        _t = 0;
        _block = 0;

        r.clear();
        r = std::vector<double>(size, 0.0);

    }

    // Init rng dist
    void init_rng_dist() {

    }

    // Method to draw new random numbers
    void update_rng() {
#ifdef _TRACE_SIMULATION_STEPS
    std::cout << "    PopStruct16::update_rng()" << std::endl;
#endif

    }

    // Method to update global operations on the population (min/max/mean...)
    void update_global_ops() {

    }

    // Method to enqueue output variables in case outgoing projections have non-zero delay
    void update_delay() {

        if ( _active ) {

        _delayed_r.push_front(r);
        _delayed_r.pop_back();

        }
    }

    // Method to dynamically change the size of the queue for delayed variables
    void update_max_delay(int value) {

        if(value <= max_delay){ // nothing to do
            return;
        }
        max_delay = value;

    _delayed_r.resize(max_delay, std::vector< double >(size, 0.0));

    }

    // Main method to update neural variables
    void update() {

        if(_active){
            //std::cout << _t << " " << _block<< " " << _schedule[_block] << std::endl;

            // Check if it is time to set the input
            if(_t == _schedule[_block]){
                // Set the data
                r = _buffer[_block];
                // Move to the next block
                _block++;
                // If was the last block, go back to the first block
                if (_block == _schedule.size()){
                    _block = 0;
                }
            }

            // If the timedarray is periodic, check if we arrive at that point
            if(_period > -1 && (_t == _period-1)){
                // Reset the counters
                _block=0;
                _t = -1;
            }

            // Always increment the internal time
            _t++;
        }

    }

    void spike_gather() {

    }



    // Memory management: track the memory consumption
    long int size_in_bytes() {
        long int size_in_bytes = 0;

        // schedule
        size_in_bytes += _schedule.capacity() * sizeof(int);

        // buffer
        size_in_bytes += _buffer.capacity() * sizeof(std::vector<double>);
        for( auto it = _buffer.begin(); it != _buffer.end(); it++ )
            size_in_bytes += it->capacity() * sizeof(double);

        return size_in_bytes;
    }

    // Memory management: destroy all the C++ data
    void clear() {
#ifdef _DEBUG
    std::cout << "PopStruct16::clear() - this = " << this << std::endl;
#endif
        // Variables
        r.clear();
        r.shrink_to_fit();

    }
};

