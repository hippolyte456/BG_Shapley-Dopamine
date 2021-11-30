
#include "ANNarchy.h"



/*
 * Internal data
 *
 */
double dt;
long int t;
std::vector<std::mt19937> rng;

// Custom constants

double tau_MSN;
void set_tau_MSN(double value){tau_MSN = value;};
double tau_FSI;
void set_tau_FSI(double value){tau_FSI = value;};
double tau_STN;
void set_tau_STN(double value){tau_STN = value;};
double tau_GPe;
void set_tau_GPe(double value){tau_GPe = value;};
double tau_GPiSNr;
void set_tau_GPiSNr(double value){tau_GPiSNr = value;};
double sigmap;
void set_sigmap(double value){sigmap = value;};
double Smax_MSN;
void set_Smax_MSN(double value){Smax_MSN = value;};
double Smax_STN;
void set_Smax_STN(double value){Smax_STN = value;};
double Smax_GPe;
void set_Smax_GPe(double value){Smax_GPe = value;};
double Smax_GPiSNr;
void set_Smax_GPiSNr(double value){Smax_GPiSNr = value;};
double Smax_FSI;
void set_Smax_FSI(double value){Smax_FSI = value;};
double theta_MSN;
void set_theta_MSN(double value){theta_MSN = value;};
double theta_FSI;
void set_theta_FSI(double value){theta_FSI = value;};
double theta_STN;
void set_theta_STN(double value){theta_STN = value;};
double theta_GPe;
void set_theta_GPe(double value){theta_GPe = value;};
double theta_GPiSNr;
void set_theta_GPiSNr(double value){theta_GPiSNr = value;};

// Populations
PopStruct0 pop0;
PopStruct1 pop1;
PopStruct2 pop2;
PopStruct3 pop3;
PopStruct4 pop4;
PopStruct5 pop5;
PopStruct6 pop6;
PopStruct7 pop7;
PopStruct8 pop8;
PopStruct9 pop9;
PopStruct10 pop10;
PopStruct11 pop11;
PopStruct12 pop12;
PopStruct13 pop13;
PopStruct14 pop14;
PopStruct15 pop15;
PopStruct16 pop16;
PopStruct17 pop17;
PopStruct18 pop18;
PopStruct19 pop19;
PopStruct20 pop20;
PopStruct21 pop21;
PopStruct22 pop22;
PopStruct23 pop23;
PopStruct24 pop24;
PopStruct25 pop25;
PopStruct26 pop26;


// Projections
ProjStruct0 proj0;
ProjStruct1 proj1;
ProjStruct2 proj2;
ProjStruct3 proj3;
ProjStruct4 proj4;
ProjStruct5 proj5;
ProjStruct6 proj6;
ProjStruct7 proj7;
ProjStruct8 proj8;
ProjStruct9 proj9;
ProjStruct10 proj10;
ProjStruct11 proj11;
ProjStruct12 proj12;
ProjStruct13 proj13;
ProjStruct14 proj14;
ProjStruct15 proj15;
ProjStruct16 proj16;
ProjStruct17 proj17;
ProjStruct18 proj18;
ProjStruct19 proj19;
ProjStruct20 proj20;
ProjStruct21 proj21;
ProjStruct22 proj22;
ProjStruct23 proj23;
ProjStruct24 proj24;
ProjStruct25 proj25;
ProjStruct26 proj26;
ProjStruct27 proj27;
ProjStruct28 proj28;
ProjStruct29 proj29;
ProjStruct30 proj30;
ProjStruct31 proj31;
ProjStruct32 proj32;
ProjStruct33 proj33;
ProjStruct34 proj34;
ProjStruct35 proj35;
ProjStruct36 proj36;
ProjStruct37 proj37;
ProjStruct38 proj38;
ProjStruct39 proj39;
ProjStruct40 proj40;
ProjStruct41 proj41;
ProjStruct42 proj42;
ProjStruct43 proj43;
ProjStruct44 proj44;
ProjStruct45 proj45;
ProjStruct46 proj46;
ProjStruct47 proj47;
ProjStruct48 proj48;
ProjStruct49 proj49;
ProjStruct50 proj50;
ProjStruct51 proj51;
ProjStruct52 proj52;
ProjStruct53 proj53;
ProjStruct54 proj54;
ProjStruct55 proj55;
ProjStruct56 proj56;
ProjStruct57 proj57;
ProjStruct58 proj58;
ProjStruct59 proj59;
ProjStruct60 proj60;
ProjStruct61 proj61;
ProjStruct62 proj62;
ProjStruct63 proj63;
ProjStruct64 proj64;
ProjStruct65 proj65;
ProjStruct66 proj66;
ProjStruct67 proj67;
ProjStruct68 proj68;
ProjStruct69 proj69;
ProjStruct70 proj70;
ProjStruct71 proj71;
ProjStruct72 proj72;
ProjStruct73 proj73;
ProjStruct74 proj74;
ProjStruct75 proj75;
ProjStruct76 proj76;
ProjStruct77 proj77;
ProjStruct78 proj78;
ProjStruct79 proj79;
ProjStruct80 proj80;
ProjStruct81 proj81;
ProjStruct82 proj82;
ProjStruct83 proj83;
ProjStruct84 proj84;
ProjStruct85 proj85;
ProjStruct86 proj86;
ProjStruct87 proj87;
ProjStruct88 proj88;
ProjStruct89 proj89;
ProjStruct90 proj90;
ProjStruct91 proj91;
ProjStruct92 proj92;
ProjStruct93 proj93;
ProjStruct94 proj94;
ProjStruct95 proj95;
ProjStruct96 proj96;
ProjStruct97 proj97;


// Global operations


// Recorders
std::vector<Monitor*> recorders;
int addRecorder(Monitor* recorder){
    int found = -1;

    for (unsigned int i=0; i<recorders.size(); i++) {
        if (recorders[i] == nullptr) {
            found = i;
            break;
        }
    }

    if (found != -1) {
        // fill a previously cleared slot
        recorders[found] = recorder;
        return found;
    } else {
        recorders.push_back(recorder);
        return recorders.size() - 1;
    }
}
Monitor* getRecorder(int id) {
    if (id < recorders.size())
        return recorders[id];
    else
        return nullptr;
}
void removeRecorder(Monitor* recorder){
    for (unsigned int i=0; i<recorders.size(); i++){
        if(recorders[i] == recorder){
            recorders[i] = nullptr;
            break;
        }
    }
}

void singleStep(); // Function prototype

// Simulate the network for the given number of steps,
// called from python
void run(int nbSteps) {
#ifdef _TRACE_SIMULATION_STEPS
    std::cout << "Perform simulation for " << nbSteps << " steps." << std::endl;
#endif

    for(int i=0; i<nbSteps; i++) {
        singleStep();
    }

}

// Simulate the network for a single steps,
// called from python
void step() {

    singleStep();

}

int run_until(int steps, std::vector<int> populations, bool or_and)
{


    run(steps);
    return steps;


}

// Initialize the internal data and the random numbers generator
void initialize(double _dt) {


    // Internal variables
    dt = _dt;
    t = (long int)(0);

    // Populations
    // Initialize populations
    pop0.init_population();
    pop1.init_population();
    pop2.init_population();
    pop3.init_population();
    pop4.init_population();
    pop5.init_population();
    pop6.init_population();
    pop7.init_population();
    pop8.init_population();
    pop9.init_population();
    pop10.init_population();
    pop11.init_population();
    pop12.init_population();
    pop13.init_population();
    pop14.init_population();
    pop15.init_population();
    pop16.init_population();
    pop17.init_population();
    pop18.init_population();
    pop19.init_population();
    pop20.init_population();
    pop21.init_population();
    pop22.init_population();
    pop23.init_population();
    pop24.init_population();
    pop25.init_population();
    pop26.init_population();


    // Projections
    // Initialize projections
    proj0.init_projection();
    proj1.init_projection();
    proj2.init_projection();
    proj3.init_projection();
    proj4.init_projection();
    proj5.init_projection();
    proj6.init_projection();
    proj7.init_projection();
    proj8.init_projection();
    proj9.init_projection();
    proj10.init_projection();
    proj11.init_projection();
    proj12.init_projection();
    proj13.init_projection();
    proj14.init_projection();
    proj15.init_projection();
    proj16.init_projection();
    proj17.init_projection();
    proj18.init_projection();
    proj19.init_projection();
    proj20.init_projection();
    proj21.init_projection();
    proj22.init_projection();
    proj23.init_projection();
    proj24.init_projection();
    proj25.init_projection();
    proj26.init_projection();
    proj27.init_projection();
    proj28.init_projection();
    proj29.init_projection();
    proj30.init_projection();
    proj31.init_projection();
    proj32.init_projection();
    proj33.init_projection();
    proj34.init_projection();
    proj35.init_projection();
    proj36.init_projection();
    proj37.init_projection();
    proj38.init_projection();
    proj39.init_projection();
    proj40.init_projection();
    proj41.init_projection();
    proj42.init_projection();
    proj43.init_projection();
    proj44.init_projection();
    proj45.init_projection();
    proj46.init_projection();
    proj47.init_projection();
    proj48.init_projection();
    proj49.init_projection();
    proj50.init_projection();
    proj51.init_projection();
    proj52.init_projection();
    proj53.init_projection();
    proj54.init_projection();
    proj55.init_projection();
    proj56.init_projection();
    proj57.init_projection();
    proj58.init_projection();
    proj59.init_projection();
    proj60.init_projection();
    proj61.init_projection();
    proj62.init_projection();
    proj63.init_projection();
    proj64.init_projection();
    proj65.init_projection();
    proj66.init_projection();
    proj67.init_projection();
    proj68.init_projection();
    proj69.init_projection();
    proj70.init_projection();
    proj71.init_projection();
    proj72.init_projection();
    proj73.init_projection();
    proj74.init_projection();
    proj75.init_projection();
    proj76.init_projection();
    proj77.init_projection();
    proj78.init_projection();
    proj79.init_projection();
    proj80.init_projection();
    proj81.init_projection();
    proj82.init_projection();
    proj83.init_projection();
    proj84.init_projection();
    proj85.init_projection();
    proj86.init_projection();
    proj87.init_projection();
    proj88.init_projection();
    proj89.init_projection();
    proj90.init_projection();
    proj91.init_projection();
    proj92.init_projection();
    proj93.init_projection();
    proj94.init_projection();
    proj95.init_projection();
    proj96.init_projection();
    proj97.init_projection();


    // Custom constants

        tau_MSN = 0.0;
        tau_FSI = 0.0;
        tau_STN = 0.0;
        tau_GPe = 0.0;
        tau_GPiSNr = 0.0;
        sigmap = 0.0;
        Smax_MSN = 0.0;
        Smax_STN = 0.0;
        Smax_GPe = 0.0;
        Smax_GPiSNr = 0.0;
        Smax_FSI = 0.0;
        theta_MSN = 0.0;
        theta_FSI = 0.0;
        theta_STN = 0.0;
        theta_GPe = 0.0;
        theta_GPiSNr = 0.0;

}

// Initialize the random distribution objects
void init_rng_dist() {
pop0.init_rng_dist();
pop1.init_rng_dist();
pop2.init_rng_dist();
pop3.init_rng_dist();
pop4.init_rng_dist();
pop5.init_rng_dist();
pop6.init_rng_dist();
pop7.init_rng_dist();
pop8.init_rng_dist();
pop9.init_rng_dist();
pop10.init_rng_dist();
pop11.init_rng_dist();
pop12.init_rng_dist();
pop13.init_rng_dist();
pop14.init_rng_dist();
pop15.init_rng_dist();
pop16.init_rng_dist();
pop17.init_rng_dist();
pop18.init_rng_dist();
pop19.init_rng_dist();
pop20.init_rng_dist();
pop21.init_rng_dist();
pop22.init_rng_dist();
pop23.init_rng_dist();
pop24.init_rng_dist();
pop25.init_rng_dist();
pop26.init_rng_dist();

}

// Change the seed of the RNG
void setSeed(long int seed, int num_sources, bool use_seed_seq){
    rng.clear();

    rng.push_back(std::mt19937(seed));

    rng.shrink_to_fit();
}

// Step method. Generated by ANNarchy.
void singleStep()
{


    ////////////////////////////////
    // Presynaptic events
    ////////////////////////////////


    // pop21: FSI
    if (pop21._active)
        memset( pop21._sum_exc.data(), 0.0, pop21._sum_exc.size() * sizeof(double));

    // pop21: FSI
    if (pop21._active)
        memset( pop21._sum_inh.data(), 0.0, pop21._sum_inh.size() * sizeof(double));

    // pop22: MSNd1
    if (pop22._active)
        memset( pop22._sum_exc.data(), 0.0, pop22._sum_exc.size() * sizeof(double));

    // pop22: MSNd1
    if (pop22._active)
        memset( pop22._sum_inh.data(), 0.0, pop22._sum_inh.size() * sizeof(double));

    // pop23: MSNd2
    if (pop23._active)
        memset( pop23._sum_exc.data(), 0.0, pop23._sum_exc.size() * sizeof(double));

    // pop23: MSNd2
    if (pop23._active)
        memset( pop23._sum_inh.data(), 0.0, pop23._sum_inh.size() * sizeof(double));

    // pop24: GPe
    if (pop24._active)
        memset( pop24._sum_exc.data(), 0.0, pop24._sum_exc.size() * sizeof(double));

    // pop24: GPe
    if (pop24._active)
        memset( pop24._sum_inh.data(), 0.0, pop24._sum_inh.size() * sizeof(double));

    // pop25: GPiSNr
    if (pop25._active)
        memset( pop25._sum_exc.data(), 0.0, pop25._sum_exc.size() * sizeof(double));

    // pop25: GPiSNr
    if (pop25._active)
        memset( pop25._sum_inh.data(), 0.0, pop25._sum_inh.size() * sizeof(double));

    // pop26: STN
    if (pop26._active)
        memset( pop26._sum_exc.data(), 0.0, pop26._sum_exc.size() * sizeof(double));

    // pop26: STN
    if (pop26._active)
        memset( pop26._sum_inh.data(), 0.0, pop26._sum_inh.size() * sizeof(double));

#ifdef _TRACE_SIMULATION_STEPS
    std::cout << "Update psp/conductances ..." << std::endl;
#endif
    proj0.compute_psp();
    proj1.compute_psp();
    proj2.compute_psp();
    proj3.compute_psp();
    proj4.compute_psp();
    proj5.compute_psp();
    proj6.compute_psp();
    proj7.compute_psp();
    proj8.compute_psp();
    proj9.compute_psp();
    proj10.compute_psp();
    proj11.compute_psp();
    proj12.compute_psp();
    proj13.compute_psp();
    proj14.compute_psp();
    proj15.compute_psp();
    proj16.compute_psp();
    proj17.compute_psp();
    proj18.compute_psp();
    proj19.compute_psp();
    proj20.compute_psp();
    proj21.compute_psp();
    proj22.compute_psp();
    proj23.compute_psp();
    proj24.compute_psp();
    proj25.compute_psp();
    proj26.compute_psp();
    proj27.compute_psp();
    proj28.compute_psp();
    proj29.compute_psp();
    proj30.compute_psp();
    proj31.compute_psp();
    proj32.compute_psp();
    proj33.compute_psp();
    proj34.compute_psp();
    proj35.compute_psp();
    proj36.compute_psp();
    proj37.compute_psp();
    proj38.compute_psp();
    proj39.compute_psp();
    proj40.compute_psp();
    proj41.compute_psp();
    proj42.compute_psp();
    proj43.compute_psp();
    proj44.compute_psp();
    proj45.compute_psp();
    proj46.compute_psp();
    proj47.compute_psp();
    proj48.compute_psp();
    proj49.compute_psp();
    proj50.compute_psp();
    proj51.compute_psp();
    proj52.compute_psp();
    proj53.compute_psp();
    proj54.compute_psp();
    proj55.compute_psp();
    proj56.compute_psp();
    proj57.compute_psp();
    proj58.compute_psp();
    proj59.compute_psp();
    proj60.compute_psp();
    proj61.compute_psp();
    proj62.compute_psp();
    proj63.compute_psp();
    proj64.compute_psp();
    proj65.compute_psp();
    proj66.compute_psp();
    proj67.compute_psp();
    proj68.compute_psp();
    proj69.compute_psp();
    proj70.compute_psp();
    proj71.compute_psp();
    proj72.compute_psp();
    proj73.compute_psp();
    proj74.compute_psp();
    proj75.compute_psp();
    proj76.compute_psp();
    proj77.compute_psp();
    proj78.compute_psp();
    proj79.compute_psp();
    proj80.compute_psp();
    proj81.compute_psp();
    proj82.compute_psp();
    proj83.compute_psp();
    proj84.compute_psp();
    proj85.compute_psp();
    proj86.compute_psp();
    proj87.compute_psp();
    proj88.compute_psp();
    proj89.compute_psp();
    proj90.compute_psp();
    proj91.compute_psp();
    proj92.compute_psp();
    proj93.compute_psp();
    proj94.compute_psp();
    proj95.compute_psp();
    proj96.compute_psp();
    proj97.compute_psp();



    ////////////////////////////////
    // Recording target variables
    ////////////////////////////////
#ifdef _TRACE_SIMULATION_STEPS
    std::cout << "Record psp/conductances ..." << std::endl;
#endif
    for (unsigned int i=0; i < recorders.size(); i++){
        recorders[i]->record_targets();
    }

    ////////////////////////////////
    // Update random distributions
    ////////////////////////////////
#ifdef _TRACE_SIMULATION_STEPS
    std::cout << "Draw required random numbers ..." << std::endl;
#endif




    ////////////////////////////////
    // Update neural variables
    ////////////////////////////////
#ifdef _TRACE_SIMULATION_STEPS
    std::cout << "Evaluate neural ODEs ..." << std::endl;
#endif

    pop0.update(); pop0.spike_gather(); 
    pop1.update(); pop1.spike_gather(); 
    pop2.update(); pop2.spike_gather(); 
    pop3.update(); pop3.spike_gather(); 
    pop4.update(); pop4.spike_gather(); 
    pop5.update(); pop5.spike_gather(); 
    pop6.update(); pop6.spike_gather(); 
    pop7.update(); pop7.spike_gather(); 
    pop8.update(); pop8.spike_gather(); 
    pop9.update(); pop9.spike_gather(); 
    pop10.update(); pop10.spike_gather(); 
    pop11.update(); pop11.spike_gather(); 
    pop12.update(); pop12.spike_gather(); 
    pop13.update(); pop13.spike_gather(); 
    pop14.update(); pop14.spike_gather(); 
    pop15.update(); pop15.spike_gather(); 
    pop16.update(); pop16.spike_gather(); 
    pop17.update(); pop17.spike_gather(); 
    pop18.update(); pop18.spike_gather(); 
    pop19.update(); pop19.spike_gather(); 
    pop20.update(); pop20.spike_gather(); 
    pop21.update(); pop21.spike_gather(); 
    pop22.update(); pop22.spike_gather(); 
    pop23.update(); pop23.spike_gather(); 
    pop24.update(); pop24.spike_gather(); 
    pop25.update(); pop25.spike_gather(); 
    pop26.update(); pop26.spike_gather(); 



    ////////////////////////////////
    // Delay outputs
    ////////////////////////////////
#ifdef _TRACE_SIMULATION_STEPS
    std::cout << "Update delay queues ..." << std::endl;
#endif
    pop1.update_delay();
    pop2.update_delay();
    pop3.update_delay();
    pop4.update_delay();
    pop5.update_delay();
    pop6.update_delay();
    pop7.update_delay();
    pop8.update_delay();
    pop9.update_delay();
    pop10.update_delay();
    pop11.update_delay();
    pop12.update_delay();
    pop13.update_delay();
    pop14.update_delay();
    pop15.update_delay();
    pop16.update_delay();
    pop17.update_delay();
    pop18.update_delay();
    pop19.update_delay();
    pop20.update_delay();
    pop22.update_delay();
    pop23.update_delay();
    pop24.update_delay();
    pop26.update_delay();


    ////////////////////////////////
    // Global operations (min/max/mean)
    ////////////////////////////////
#ifdef _TRACE_SIMULATION_STEPS
    std::cout << "Update global operations ..." << std::endl;
#endif




    ////////////////////////////////
    // Update synaptic variables
    ////////////////////////////////
#ifdef _TRACE_SIMULATION_STEPS
    std::cout << "Evaluate synaptic ODEs ..." << std::endl;
#endif




    ////////////////////////////////
    // Postsynaptic events
    ////////////////////////////////


    ////////////////////////////////
    // Structural plasticity
    ////////////////////////////////


    ////////////////////////////////
    // Recording neural / synaptic variables
    ////////////////////////////////

    for (unsigned int i=0; i < recorders.size(); i++){
        recorders[i]->record();
    }


    ////////////////////////////////
    // Increase internal time
    ////////////////////////////////
    t++;


}


/*
 * Access to time and dt
 *
*/
long int getTime() {return t;}
void setTime(long int t_) { t=t_;}
double getDt() { return dt;}
void setDt(double dt_) { dt=dt_;}

/*
 * Number of threads
 *
*/
void setNumberThreads(int threads, std::vector<int> core_list)
{
    std::cerr << "WARNING: a call of setNumberThreads() is without effect on single thread simulation code." << std::endl;
}
