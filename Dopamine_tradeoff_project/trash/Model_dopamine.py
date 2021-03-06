##################################### Modification du rBCBG, prise en compte de la dopamine et influence sur les choix ############################################

############################################     IMPORTATION MODULES         ################################################

from ANNarchy import *
from numpy.core.defchararray import title
from connexweights import * #pas besoin 
from math import * 
from numpy import *
import matplotlib.pyplot as plt
import time as ti
import os as os 
from itertools import chain, combinations
############################################     CHOIX DE LA MODELISATION         ############################################

os.getcwd()
os.chdir('/home/hippo/Documents/FoldersBG_new/Dopamine_tradeoff_project')

modelID = 9
models_param = loadtxt(open("compact_weights.csv","rb"),delimiter=";",skiprows=1)
model = models_param[modelID]



##################### DEFINITION / RECUPERATION PARAMETRES NECESSAIRES ... A PASSER AUX CLASSES d'ANNarchy #################### 
def creation_model(Tau_MSN = 30, Tau_FSI = 30, Tau_STN = 30, Tau_GPe = 30, Tau_GPiSNr = 30 , Dt = 1, time = 1000.0, NbChannels = 4, show_input = False):

    #### paramétrage ####

    clear()
    setup( dt = Dt)

    tau_MSN = Constant('tau_MSN', Tau_MSN)
    tau_FSI = Constant('tau_FSI', Tau_FSI)
    tau_STN = Constant('tau_STN', Tau_STN)
    tau_GPe = Constant('tau_GPe', Tau_GPe)
    tau_GPiSNr = Constant('tau_GPiSNr', Tau_GPiSNr)
    

    sigma = 7*1e3			#microV
    sigmap = Constant('sigmap', (sigma * sqrt(3) / pi) )

    Smax_MSN = Constant('Smax_MSN', 300.0)
    Smax_STN = Constant('Smax_STN', 300.0)
    Smax_GPe = Constant('Smax_GPe', 400.0)
    Smax_GPiSNr = Constant('Smax_GPiSNr', 400.0)
    Smax_FSI = Constant('Smax_FSI', model[29])

    theta_MSN = Constant('theta_MSN', model[24]*1e3)
    theta_FSI = Constant('theta_FSI', model[25]*1e3)
    theta_STN = Constant('theta_STN', model[26]*1e3)
    theta_GPe = Constant('theta_GPe', model[27]*1e3)
    theta_GPiSNr = Constant('theta_GPiSNr', model[28]*1e3)

    W_CSN_MSN = model[0]   
    W_CSN_FSI = model[1]
    W_PTN_MSN = model[22]
    W_PTN_FSI = model[23]
    W_PTN_STN = model[2]
    W_MSN_GPe = model[3]
    W_MSN_GPiSNr = 0.82 *model[4]       # corrects an error: the probability of projection 0.82 was forgotten when generating compact_weights.csv
    W_MSN_MSN = model[16]/ NbChannels
    W_STN_GPe = model[5]/ NbChannels
    W_STN_GPiSNr = model[6]/ NbChannels
    W_STN_MSN = model[7]/ NbChannels
    W_STN_FSI = model[8]/ NbChannels
    W_GPe_STN = model[9]
    W_GPe_GPiSNr = model[10]/ NbChannels
    W_GPe_MSN = model[11]/ NbChannels
    W_GPe_FSI = model[12]/ NbChannels
    W_GPe_GPe = model[13]/ NbChannels
    W_FSI_MSN = model[14]/ NbChannels
    W_FSI_FSI = model[15]/ NbChannels
    W_CmPf_MSN = model[17]/ NbChannels
    W_CmPf_FSI = model[18]/ NbChannels
    W_CmPf_STN = model[19]/ NbChannels
    W_CmPf_GPe = model[20]/ NbChannels
    W_CmPf_GPiSNr = model[21]/ NbChannels

    #latency  = {"dCSN_MSN" : 7 , "dCSN_FSI" : 7 , "dPTN_MSN" : 7 , "dPTN_FSI" : 7 , "dPTN_STN" : 3 , "dMSN_GPe" : 7 , "dMSN_GPiSNr" : 11 , "dMSN_MSN" : 0 , "dSTN_GPe" : 3 ,"dSTN_GPiSNr" : 3 , "dSTN_MSN" : 3 ,"dSTN_FSI" : 3 , "dGPe_STN" : 10 , "dGPe_GPiSNr" :3 , "dGPe_MSN" : 3 , "dGPe_FSI" : 3 , "dGPe_GPe" : 0 , "dFSI_MSN" : 0 , "dFSI_FSI" : 0 ,"dCmPf_MSN" : 0 , "dCmPf_FSI" : 0 ,"dCmPf_STN" : 0 ,"dCmPf_GPe" : 0 ,"dCmPf_GPiSNr" : 0 }
    #latency  = {"dCSN_MSN" : 6 , "dCSN_FSI" : 6 , "dPTN_MSN" : 6 , "dPTN_FSI" : 6 , "dPTN_STN" : 4 , "dMSN_GPe" : 8 , "dMSN_GPiSNr" : 11 , "dMSN_MSN" : 0 , "dSTN_GPe" : 9 ,"dSTN_GPiSNr" : 4 , "dSTN_MSN" : ? ,"dSTN_FSI" : ? , "dGPe_STN" : 1 , "dGPe_GPiSNr" :1 , "dGPe_MSN" : 8 , "dGPe_FSI" : 8 , "dGPe_GPe" : 0 , "dFSI_MSN" : 0 , "dFSI_FSI" : 0 ,"dCmPf_MSN" : 0 , "dCmPf_FSI" : 0 ,"dCmPf_STN" : 0 ,"dCmPf_GPe" : 0 ,"dCmPf_GPiSNr" : 0 }
    latency  = {"dCSN_MSN" : 6 , "dCSN_FSI" : 6 , "dPTN_MSN" : 6 , "dPTN_FSI" : 6 , "dPTN_STN" : 4 , "dMSN_GPe" : 8 , "dMSN_GPiSNr" : 11 , "dMSN_MSN" : 0 , "dSTN_GPe" : 9 ,"dSTN_GPiSNr" : 4 , "dSTN_MSN" : 3 ,"dSTN_FSI" : 3 , "dGPe_STN" : 1 , "dGPe_GPiSNr" :1 , "dGPe_MSN" : 8 , "dGPe_FSI" : 8 , "dGPe_GPe" : 0 , "dFSI_MSN" : 0 , "dFSI_FSI" : 0 ,"dCmPf_MSN" : 0 , "dCmPf_FSI" : 0 ,"dCmPf_STN" : 0 ,"dCmPf_GPe" : 0 ,"dCmPf_GPiSNr" : 0 }


    #### MODELE rBCBG AVEC ANNarchy ####
          


    # NEURONES TYPES DU MODELE

    LeakyIntegratorNeuron_MSN = Neuron(               
                                                ### A TESTER : qu'est ce qu'on peut mettre dans ces strings ? les parametres sont à passer forcement avec la class "Constant" ? on peut les definir direct dedans ? on peut mettre des commentaires avec un # au sein de la string ? ...bref comprendre comment ça fonctionne ces strings...
                                                ### le exc se refère aux projections qui sont définies comme arrivant sur le neurone (et ses projections dépendent de la pop dans laquelle il a été mis)
        parameters = """
            tau = tau_MSN 
        """,
        equations = """
            tau * dmp/dt  + mp = sum(exc) - sum(inh)               
            r = f_activateMSN(mp)                            
        """,
        functions = """
            f_activateMSN(x) = Smax_MSN / ( 1.0 + exp( (theta_MSN-x)/sigmap ) )
        """
    )

    LeakyIntegratorNeuron_FSI = Neuron(              
                                                
        parameters = """
            tau = tau_FSI
        """,
        equations = """
            tau * dmp/dt  + mp = sum(exc) - sum(inh)
            r = f_activateFSI(mp)                            
        """,
        functions = """
            f_activateFSI(x) = Smax_FSI / ( 1.0 + exp( (theta_FSI-x)/sigmap ) )
        """
    )

    LeakyIntegratorNeuron_GPe = Neuron(              
                                                
        parameters = """
            tau = tau_GPe
        """,
        equations = """
            tau * dmp/dt  + mp = sum(exc) - sum(inh)
            r = f_activateGPe(mp)                            
        """,
        functions = """
            f_activateGPe(x) = Smax_GPe / ( 1.0 + exp( (theta_GPe-x)/sigmap ) )
        """
    )

    LeakyIntegratorNeuron_STN = Neuron(              
                                                
        parameters = """
            tau = tau_STN
        """,
        equations = """
            tau * dmp/dt  + mp = sum(exc) - sum(inh)
            r = f_activateSTN(mp)                            
        """,
        functions = """
            f_activateSTN(x) = Smax_STN / ( 1.0 + exp( (theta_STN-x)/sigmap ) )
        """
    )

    LeakyIntegratorNeuron_GPiSNr = Neuron(              
                                                
        parameters = """
            tau = tau_GPiSNr
        """,
        equations = """
            tau * dmp/dt  + mp = sum(exc) - sum(inh)
            r = f_activateGPiSNr(mp)                            
        """,
        functions = """
            f_activateGPiSNr(x) = Smax_GPiSNr / ( 1.0 + exp( (theta_GPiSNr-x)/sigmap ) )
        """
    )

    
    # DEFINITION DES POPULATIONS 



    laps = 30
    nb_stim = 1
    
    # stimuli_CSN1 = [[2,time*5,0,laps],[5,time*4,time*5,laps],[10,time*3,time*9,laps],[15,time*2,time*12,laps],[20,time*1,time*14,laps]]
    # stimuli_CSN2 = [[2,time*1,0,laps],[5,time*1,time,laps],[10,time*1,time*2,laps],[15,time*1,time*3,laps],[20,time*1,time*4,laps],    [5,time*1,time*5,laps],[10,time*1,time*6,laps],[15,time*1,time*7,laps],[20,time*1,time*8,laps],    [10,time*1,time*9,laps],[15,time*1,time*10,laps],[20,time*1,time*11,laps],    [15,time*1,time*12,20],[20,time*1,time*13,laps],    [20,time*1,time*14,laps]  ]
    # stimuli_PTN1= [[15,time*5,0,laps],[23,time*4,time*5,laps],[30,time*3,time*9,laps],[38,time*2,time*12,laps],[45,time*1,time*14,laps]]
    # stimuli_PTN2= [[15,time*1,0,laps],[23,time*1,time*1,laps],[30,time*1,time*2,laps],[38,time*1,time*3,laps],[45,time*1,time*4,laps],     [23,time*1,time*5,laps],[30,time*1,time*6,laps],[38,time*1,time*7,laps],[45,time*1,time*8,laps],    [30,time*1,time*9,laps],[38,time*1,time*10,laps],[45,time*1,time*11,laps],     [38,time*1,time*12,20],[45,time*1,time*13,laps],     [45,time*1,time*14,laps]]
    # stimuli_CmPf = [[4,time*15,0,laps]]



    stimuli_CSN1 = [[2,time,0,laps]]
    stimuli_CSN2 = [[3,time,0,laps]]
    stimuli_PTN1= [[15,time,0,laps]]
    stimuli_PTN2= [[18,time,0,laps]]
    stimuli_CmPf = [[0,time,0,laps]]

    ### input ###    
    CSN = creation_TimedArray(nb_stim*time,NbChannels-1,stimuli,stimuli_CSN1)
    PTN = creation_TimedArray(nb_stim*time,NbChannels-1,stimuli,stimuli_PTN1)
    CSNstim = creation_TimedArray(nb_stim*time,1,stimuli,stimuli_CSN2)
    PTNstim = creation_TimedArray(nb_stim*time,1,stimuli,stimuli_PTN2)
    CmPf = creation_TimedArray(nb_stim*time,NbChannels,stimuli,stimuli_CmPf)
    ### BG ###
    FSI = Population(name='FSI', geometry=NbChannels, neuron=LeakyIntegratorNeuron_FSI)
    MSN = Population(name='MSN', geometry=NbChannels, neuron=LeakyIntegratorNeuron_MSN)
    GPe = Population(name='GPe', geometry=NbChannels, neuron=LeakyIntegratorNeuron_GPe)
    GPiSNr = Population(name='GPiSNr', geometry=NbChannels, neuron=LeakyIntegratorNeuron_GPiSNr)
    STN = Population(name='STN', geometry=NbChannels, neuron=LeakyIntegratorNeuron_STN)
    ### output / thalamus ###
    #...
    

    # DEFINITION DES SYNAPSES UTILISEES

    Basic = Synapse(parameters="""alpha = 1.0""")


    # # # CREATION DES PROJECTIONS ENTRE LES POPULATIONS 

    proj_CSN_MSN = Projection(pre=CSN, post=MSN[1:NbChannels], target='exc', synapse=Basic).connect_one_to_one(weights= W_CSN_MSN , delays = latency['dCSN_MSN'])
    proj_CSN_FSI = Projection(pre=CSN, post=FSI[1:NbChannels], target='exc', synapse=Basic).connect_one_to_one(weights= W_CSN_FSI , delays = latency['dCSN_FSI'])
    proj_PTN_MSN = Projection(pre=PTN, post=MSN[1:NbChannels], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_MSN , delays = latency['dPTN_MSN'])
    proj_PTN_FSI = Projection(pre=PTN, post=FSI[1:NbChannels], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_FSI , delays = latency['dPTN_FSI'])
    proj_PTN_STN = Projection(pre=PTN, post=STN[1:NbChannels], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_STN , delays = latency['dPTN_STN'])
    proj_CSN_MSN_stim = Projection(pre=CSNstim, post=MSN[0], target='exc', synapse=Basic).connect_one_to_one(weights= W_CSN_MSN , delays = latency['dCSN_MSN'])
    proj_CSN_FSI_stim = Projection(pre=CSNstim, post=FSI[0], target='exc', synapse=Basic).connect_one_to_one(weights= W_CSN_FSI , delays = latency['dCSN_FSI'])
    proj_PTN_MSN_stim = Projection(pre=PTNstim, post=MSN[0], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_MSN , delays = latency['dPTN_MSN'])
    proj_PTN_FSI_stim = Projection(pre=PTNstim, post=FSI[0], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_FSI , delays = latency['dPTN_FSI'])
    proj_PTN_STN_stim = Projection(pre=PTNstim, post=STN[0], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_STN , delays = latency['dPTN_STN'])

    

    proj_MSN_GPe = Projection(pre=MSN, post=GPe, target='inh', synapse=Basic).connect_one_to_one(weights= W_MSN_GPe , delays = latency['dMSN_GPe'])

    proj_MSN_GPiSNr = Projection(pre=MSN, post=GPiSNr, target='inh', synapse=Basic).connect_one_to_one(weights= W_MSN_GPiSNr , delays = latency['dMSN_GPiSNr'])

    proj_MSN_MSN = Projection(pre=MSN, post=MSN, target='inh', synapse=Basic).connect_all_to_all(weights = W_MSN_MSN , delays = latency['dMSN_MSN'], allow_self_connections=True) #attention il faut faire en sorte que la connexion se fasse sur tout le monde sauf le neurone qui envoie

    proj_STN_GPe = Projection(pre=STN, post=GPe, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_GPe , delays = latency['dSTN_GPe']) 
    
    proj_STN_GPiSNr = Projection(pre=STN, post=GPiSNr, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_GPiSNr , delays = latency['dSTN_GPiSNr']) 
    
    proj_STN_MSN = Projection(pre=STN, post=MSN, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_MSN , delays = latency['dSTN_MSN']) 
    
    proj_STN_FSI = Projection(pre=STN, post=FSI, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_FSI , delays = latency['dSTN_FSI']) 
    
    proj_GPe_STN = Projection(pre=GPe, post=STN, target='inh', synapse=Basic).connect_one_to_one(weights= W_GPe_STN , delays = latency['dGPe_STN'])
    
    proj_GPe_GPiSNr = Projection(pre=GPe, post=GPiSNr, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_GPiSNr , delays = latency['dGPe_GPiSNr']) 

    proj_GPe_MSN = Projection(pre=GPe, post=MSN, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_MSN , delays = latency['dGPe_MSN']) 

    proj_GPe_FSI = Projection(pre=GPe, post=FSI, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_FSI , delays = latency['dGPe_FSI']) 

    proj_GPe_GPe = Projection(pre=GPe, post=GPe, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_GPe , delays = latency['dGPe_GPe'], allow_self_connections=True)

    proj_FSI_MSN = Projection(pre=FSI, post=MSN, target='inh', synapse=Basic).connect_all_to_all(weights = W_FSI_MSN, delays = latency['dFSI_MSN'])

    proj_FSI_FSI = Projection(pre=FSI, post=FSI, target='inh', synapse=Basic).connect_all_to_all(weights = W_FSI_FSI, delays = latency['dFSI_FSI'], allow_self_connections=True)
    
    proj_CmPf_MSN = Projection(pre=CmPf, post=MSN, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_MSN , delays = latency['dCmPf_MSN'])
    
    proj_CmPf_FSI = Projection(pre=CmPf, post=FSI, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_FSI , delays = latency['dCmPf_FSI'])
    
    proj_CmPf_STN = Projection(pre=CmPf, post=STN, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_STN , delays = latency['dCmPf_STN'])
    
    proj_CmPf_GPe = Projection(pre=CmPf, post=GPe, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_GPe , delays = latency['dCmPf_GPe'])
    
    proj_CmPf_GPiSNr = Projection(pre=CmPf, post=GPiSNr, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_GPiSNr , delays = latency['dCmPf_GPiSNr'])


    # ##########################################################################################################################

  
    compile()


    #### préparation des paramètres à monitorer ####

    channels = [ 'mono%d' %i for i in range(1,NbChannels+1)]
    MSNmonitors, FSImonitors, STNmonitors, GPemonitors, GPiSNrmonitors, = {} , {} , {} , {} , {} 
    for idx,channel in enumerate(channels):
            MSNmonitors[channel] = Monitor(MSN[idx], 'r')
            FSImonitors[channel] = Monitor(FSI[idx], 'r')
            STNmonitors[channel] = Monitor(STN[idx], 'r')
            GPemonitors[channel] = Monitor(GPe[idx], 'r')
            GPiSNrmonitors[channel] = Monitor(GPiSNr[idx], 'r')

    
    mCSN = Monitor(CSN, 'r')
    mCSNstim = Monitor(CSNstim, 'r')
    mPTN = Monitor(PTN, 'r')
    mPTNstim = Monitor(PTNstim, 'r')
    mCmPf = Monitor(CmPf, 'r')
    
    # #### configuration ds inputs  et simulation ####
        
    
    #mettre les différents inputs possibles dans des fonctions  
    all_time = time * nb_stim
    simulate(all_time)
          

    
    ##### traitement des données simulées et affichage ####
    if show_input : 
        rCSN = mCSN.get('r')
        rCSNstim = mCSNstim.get('r')
        rPTN = mPTN.get('r')
        rPTNstim = mPTNstim.get('r')
        rCmPf = mCmPf.get('r')
        f,axs = plt.subplots(nrows=3 , ncols= 2 , sharey='row')
        axs[0,0].plot(dt()*np.arange(all_time*(1/Dt)), rCSN, c = 'b')
        axs[0,1].plot(dt()*np.arange(all_time*(1/Dt)), rCSNstim)
        axs[1,0].plot(dt()*np.arange(all_time*(1/Dt)), rPTN) 
        axs[1,1].plot(dt()*np.arange(all_time*(1/Dt)), rPTNstim)
        axs[2,0].plot(dt()*np.arange(all_time*(1/Dt)), rCmPf)
        axs[2,1].plot(dt()*np.arange(all_time*(1/Dt)), rCmPf)
        plt.show()


    rGPi = view_all_firing_rate(NbChannels, MSNmonitors, STNmonitors,FSImonitors,GPemonitors,GPiSNrmonitors, all_time, Dt = Dt, Tau_MSN = Tau_MSN, Tau_FSI = Tau_FSI, Tau_STN = Tau_STN, Tau_GPe = Tau_GPe, Tau_GPiSNr = Tau_GPiSNr )
    
    

    ####################################### VISUALISATIONS DU MODELE ##########################################################
import matplotlib as mpl


#la fonction renvoie aussi la sortie du modèle qui sert pour les calculs d'efficacité et de distorsion
def view_all_firing_rate( NbChannels, MSNmonitors, STNmonitors,FSImonitors,GPemonitors,GPiSNrmonitors, all_time, projection_test = False, Shapley_test = False, Dt = 1, test_variation_tau = False, Tau_MSN = 5, Tau_FSI = 5, Tau_STN = 5, Tau_GPe = 5, Tau_GPiSNr = 5):
    
   
    fig,axs = plt.subplots(nrows=5 , ncols= NbChannels , sharey='row')
    
    #fig.Figure.set_figsize([10,10])
    
    for idx,monitor in enumerate(MSNmonitors):
        r = MSNmonitors[monitor].get('r')
        axs[0,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
        axs[0,idx].title.set_text('Channels %d' %(idx+1))
        axs[0,idx].title.set_size(20)
    axs[0,0].axes.set_ylabel("MSN", size = 16 )
    for idx,monitor in enumerate(FSImonitors):
        r = FSImonitors[monitor].get('r')
        axs[1,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
    axs[1,0].axes.set_ylabel("FSI", size = 16 )
    for idx,monitor in enumerate(STNmonitors):
        r = STNmonitors[monitor].get('r')
        axs[2,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
    axs[2,0].axes.set_ylabel("STN",size = 16 )
    for idx,monitor in enumerate(GPemonitors):
        r = GPemonitors[monitor].get('r')
        axs[3,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
    axs[3,0].axes.set_ylabel("GPe",size = 16 )
    rGPi = []
    for idx,monitor in enumerate(GPiSNrmonitors):
        r = GPiSNrmonitors[monitor].get('r')
        axs[4,idx].plot(dt()*np.arange(all_time*(1/Dt)), r)
        if idx <= 1: #on récupere le firing rate du GPi pour les deux premiers canaux : le premier étant celui stimuler et l'autre pour la comparaison
            rGPi.append(r)
    axs[4,0].axes.set_ylabel("GPiSNr",size = 16)
    
    #plt.savefig('log/test_variation_tau/tau' + str(Tau_MSN) +','+ str(Tau_FSI) +','+ str(Tau_GPe) +','+ str(Tau_STN) +','+ str(Tau_GPiSNr) + '.pdf', dpi=300, bbox_inches='tight')
    #plt.savefig('log/comprendre_oscillations/test_tau/tauSTN=' + str(Tau_STN) + '.png', dpi=300, bbox_inches='tight')
    plt.savefig('log//variations_CmPf/CmPf=0Htz.png', dpi=300, bbox_inches='tight')
    #plt.show()
    #plt.close('all')
    return(rGPi)




##################################  Fonctions pour creer les inputs  #####################################
def creation_TimedArray(time,NbCanaux,funct,stimuli):  #*args
    time = int(time)
    inputs = np.zeros((int(time),NbCanaux))
    X = linspace(0,time,time)
    Y = [funct(X[i],stimuli) for i in range(time)]
    for j in range(NbCanaux):
        for i in range(time):
            inputs[i][j] = Y[i]
    inp = TimedArray(rates=inputs) 
    return (inp)

#stimulus est défini par son intensite puis sa duree puis son Temps initial puis le laps de temps qu'il faut pour arriver son maximum 
def f(t,a):
    return (a*t + abs(a*t)) / 2 

def g(t,pente,laps):
    return  f(t,pente/laps) - f(t-laps,pente/laps) 

def stimulus(t,intensite,Duree,Ti,laps):
    return g(t-Ti,intensite,laps) - g(t-Duree-Ti+laps,intensite,laps)

def stimuli(t,L):
    exc = 0
    for stim in L:
        exc += sum(stimulus(t,stim[0],stim[1],stim[2],stim[3]))
    return exc



##############################################################################################################



if __name__ == '__main__':
    creation_model( )

    #val_proj_eff, val_proj_dist = Shapley_test()
    #np.save('log/test_Shapley/results_eff', val_proj_eff)
    #np.save('log/test_Shapley/results_dist', val_proj_dist)











