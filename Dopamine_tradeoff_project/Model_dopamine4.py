##################################### Modification du rBCBG, prise en compte de la dopamine et influence sur les choix ############################################

#####FIN DE L'AJOUT DE TOUS LES NOYAUX D1 ET D2, 
#####AVEC MODIFICATIONS DE LEURS PROJECTIONS TEL QUE DANS KHAMAMSSI / HUMPHRIES 
##### DIFF AVEC VERSION3 : PASSAGE À 10 CANAUX 

# Questions pour modif du modele :
# Separation d1 d2 pour les MSN seulement ou pour FSI aussi... et les modulations des autres noyaux on prend en compte ou pas ? (comparaison avec et sans ou pas interessant ?)
# où estce que je fais arriver les projections de chacun des MSND1 et MSND2 ? 
# pour adapter le poids de chacun des noyaux (independammeent de la modulation dopaminergique) on divise juste par 2 chacun des MSND1 D2 pour avoir un poids total équivalent à MSN du modele sans separation ? 
# entropie à ecrire pour mesurer explo exploit 
#comprendre ce qu'ils entendent par substractive model ou multiplicative (pour pas alterer le gain ?...)

# CmPf module la sélection... Qu'est ce qui active CmPf ou pas ? 
#question sur la manière de travailler (Benoit)... J'aimerais bien mieux voir l'organisation du travail (en particiulier pour rédiger un article, qu'estce qu'il faut avoir noté avant pour rien oublier quand on l'ecrit)



############################################     IMPORTATION MODULES         ################################################

from ANNarchy import *
from numpy.core.defchararray import title
from connexweights import * #pas besoin 
from math import * 
from numpy import *
import matplotlib.pyplot as plt
import matplotlib as mpl
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
def creation_model(Tau_MSN = 30, Tau_FSI = 30, Tau_STN = 30, Tau_GPe = 30, Tau_GPiSNr = 30 , Dt = 1, time = 1000.0, NbChannels = 10, show_input = False):

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

#on divise par deux les projections partant de MSN puisque le nombre de neurones de la population simulée est maintenant divisée entre d1 et d2 
    W_CSN_MSN = model[0]   
    W_CSN_FSI = model[1]
    W_PTN_MSN = model[22]   
    W_PTN_FSI = model[23]
    W_PTN_STN = model[2]
    W_MSN_GPe = model[3]    /2  
    W_MSN_GPiSNr = 0.82 *model[4]   /2     # corrects an error: the probability of projection 0.82 was forgotten when generating compact_weights.csv
    W_MSN_MSN = model[16]/ NbChannels /2
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
    stimuli_CSN = {}
    stimuli_PTN = {}
    stimuli_CmPf = [[5,time,0,laps]]

    for i in range(NbChannels):
        stimCSN = [ [[2,time,0,laps]],[[5,time,0,laps]],[[10,time,0,laps]],[[15,time,0,laps]],[[18,time,0,laps]],[[15,time,0,laps]],[[12,time,0,laps]],[[10,time,0,laps]],[[7,time,0,laps]],[[4,time,0,laps]] ]
        stimPTN = [ [[15,time,0,laps]],[[20,time,0,laps]],[[25,time,0,laps]],[[30,time,0,laps]],[[35,time,0,laps]],[[32,time,0,laps]],[[28,time,0,laps]],[[24,time,0,laps]],[[21,time,0,laps]],[[18,time,0,laps]] ]
        stimuli_CSN[i] = stimCSN[i]
        stimuli_PTN[i]= stimPTN[i]
        
    

    ### input ### 
    CSN = {}
    PTN = {}
    CmPf = creation_TimedArray(nb_stim*time,NbChannels,stimuli,stimuli_CmPf)

    for i in range(NbChannels):
        CSN[i] = creation_TimedArray(nb_stim*time,1,stimuli, stimuli_CSN[i])
        PTN[i] = creation_TimedArray(nb_stim*time,1,stimuli, stimuli_PTN[i])
        
        
    
    ### BG ###
    FSI = Population(name='FSI', geometry=NbChannels, neuron=LeakyIntegratorNeuron_FSI) # à diviser en 2 aussi ? 
    MSNd1 = Population(name='MSNd1', geometry=NbChannels, neuron=LeakyIntegratorNeuron_MSN)
    MSNd2 = Population(name='MSNd2', geometry=NbChannels, neuron=LeakyIntegratorNeuron_MSN)
    GPe = Population(name='GPe', geometry=NbChannels, neuron=LeakyIntegratorNeuron_GPe)
    GPiSNr = Population(name='GPiSNr', geometry=NbChannels, neuron=LeakyIntegratorNeuron_GPiSNr)
    STN = Population(name='STN', geometry=NbChannels, neuron=LeakyIntegratorNeuron_STN)
    ### output / thalamus ###
    #...
    

    # DEFINITION DES SYNAPSES UTILISEES

    Basic = Synapse(parameters="""alpha = 1.0""")


    # # # CREATION DES PROJECTIONS ENTRE LES POPULATIONS 

    lambda1 = 0.5
    lambda2 = 0.5
    d1_GPe = 1
    d1_GPi = 1
    d2_GPe = 1
    d2_GPi = 0.6

###############
    
    
    for i in range(NbChannels):
        proj_CSN1_MSNd1 = Projection(pre=CSN[i], post=MSNd1[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_CSN_MSN*(1+lambda1) , delays = latency['dCSN_MSN'])
        proj_CSN1_MSNd2 = Projection(pre=CSN[i], post=MSNd2[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_CSN_MSN*(1-lambda2) , delays = latency['dCSN_MSN']) 
        proj_CSN1_FSI = Projection(pre=CSN[i], post=FSI[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_CSN_FSI , delays = latency['dCSN_FSI'])
        proj_PTN1_MSNd1 = Projection(pre=PTN[i], post=MSNd1[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_MSN*(1+lambda1) , delays = latency['dPTN_MSN']) 
        proj_PTN1_MSNd2 = Projection(pre=PTN[i], post=MSNd2[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_MSN*(1-lambda2) , delays = latency['dPTN_MSN'])
        proj_PTN1_FSI = Projection(pre=PTN[i], post=FSI[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_FSI , delays = latency['dPTN_FSI'])
        proj_PTN1_STN = Projection(pre=PTN[i], post=STN[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_STN , delays = latency['dPTN_STN'])
        
################
    
    proj_MSNd1_GPe = Projection(pre=MSNd1, post=GPe, target='inh', synapse=Basic).connect_one_to_one(weights= W_MSN_GPe *d1_GPe , delays = latency['dMSN_GPe'])  ########poids à changer
    proj_MSNd2_GPe = Projection(pre=MSNd2, post=GPe, target='inh', synapse=Basic).connect_one_to_one(weights= W_MSN_GPe *d1_GPi, delays = latency['dMSN_GPe'])           

    proj_MSNd1_GPiSNr = Projection(pre=MSNd1, post=GPiSNr, target='inh', synapse=Basic).connect_one_to_one(weights= W_MSN_GPiSNr *d2_GPe, delays = latency['dMSN_GPiSNr'])   ########poids à changer
    proj_MSNd2_GPiSNr = Projection(pre=MSNd2, post=GPiSNr, target='inh', synapse=Basic).connect_one_to_one(weights= W_MSN_GPiSNr *d2_GPi, delays = latency['dMSN_GPiSNr'])

################

    proj_MSNd1_MSNd1 = Projection(pre=MSNd1, post=MSNd1, target='inh', synapse=Basic).connect_all_to_all(weights = W_MSN_MSN *(1+lambda1), delays = latency['dMSN_MSN'], allow_self_connections=True) #attention il faut faire en sorte que la connexion se fasse sur tout le monde sauf le neurone qui envoie... ou pas ...
    proj_MSNd1_MSNd2 = Projection(pre=MSNd1, post=MSNd2, target='inh', synapse=Basic).connect_all_to_all(weights = W_MSN_MSN *(1-lambda2), delays = latency['dMSN_MSN'])                                #on doit diviser en /d1 vers d1 / d1 vers d2 / d2 vers d1 / d2 vers d2 ducoup ?
    proj_MSNd2_MSNd1 = Projection(pre=MSNd2, post=MSNd1, target='inh', synapse=Basic).connect_all_to_all(weights = W_MSN_MSN *(1+lambda1), delays = latency['dMSN_MSN']) 
    proj_MSNd2_MSNd2 = Projection(pre=MSNd2, post=MSNd2, target='inh', synapse=Basic).connect_all_to_all(weights = W_MSN_MSN *(1-lambda2), delays = latency['dMSN_MSN'], allow_self_connections=True) 

    proj_STN_GPe = Projection(pre=STN, post=GPe, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_GPe , delays = latency['dSTN_GPe']) 
    
    proj_STN_GPiSNr = Projection(pre=STN, post=GPiSNr, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_GPiSNr , delays = latency['dSTN_GPiSNr'])           
    
    proj_STN_MSNd1 = Projection(pre=STN, post=MSNd1, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_MSN *(1+lambda1), delays = latency['dSTN_MSN'])   ########poids à changer
    proj_STN_MSNd2 = Projection(pre=STN, post=MSNd2, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_MSN *(1-lambda2), delays = latency['dSTN_MSN']) 
    
    proj_STN_FSI = Projection(pre=STN, post=FSI, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_FSI , delays = latency['dSTN_FSI']) 
    
    proj_GPe_STN = Projection(pre=GPe, post=STN, target='inh', synapse=Basic).connect_one_to_one(weights= W_GPe_STN , delays = latency['dGPe_STN'])
    
    proj_GPe_GPiSNr = Projection(pre=GPe, post=GPiSNr, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_GPiSNr , delays = latency['dGPe_GPiSNr']) 

    proj_GPe_MSNd1 = Projection(pre=GPe, post=MSNd1, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_MSN *(1+lambda1), delays = latency['dGPe_MSN'])  ########poids à changer
    proj_GPe_MSNd2 = Projection(pre=GPe, post=MSNd2, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_MSN *(1-lambda2), delays = latency['dGPe_MSN'])  

    proj_GPe_FSI = Projection(pre=GPe, post=FSI, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_FSI , delays = latency['dGPe_FSI']) 

    proj_GPe_GPe = Projection(pre=GPe, post=GPe, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_GPe , delays = latency['dGPe_GPe'], allow_self_connections=True)

    proj_FSI_MSNd1 = Projection(pre=FSI, post=MSNd1, target='inh', synapse=Basic).connect_all_to_all(weights = W_FSI_MSN *(1+lambda1), delays = latency['dFSI_MSN'])  ########poids à changer
    proj_FSI_MSNd2 = Projection(pre=FSI, post=MSNd2, target='inh', synapse=Basic).connect_all_to_all(weights = W_FSI_MSN *(1-lambda2), delays = latency['dFSI_MSN'])

    proj_FSI_FSI = Projection(pre=FSI, post=FSI, target='inh', synapse=Basic).connect_all_to_all(weights = W_FSI_FSI, delays = latency['dFSI_FSI'], allow_self_connections=True)
    
    proj_CmPf_MSNd1 = Projection(pre=CmPf, post=MSNd1, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_MSN *(1+lambda1), delays = latency['dCmPf_MSN'])   ########poids à changer
    proj_CmPf_MSNd2 = Projection(pre=CmPf, post=MSNd2, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_MSN *(1-lambda2), delays = latency['dCmPf_MSN'])
    
    proj_CmPf_FSI = Projection(pre=CmPf, post=FSI, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_FSI , delays = latency['dCmPf_FSI'])
    
    proj_CmPf_STN = Projection(pre=CmPf, post=STN, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_STN , delays = latency['dCmPf_STN'])
    
    proj_CmPf_GPe = Projection(pre=CmPf, post=GPe, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_GPe , delays = latency['dCmPf_GPe'])
    
    proj_CmPf_GPiSNr = Projection(pre=CmPf, post=GPiSNr, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_GPiSNr , delays = latency['dCmPf_GPiSNr'])


    # ##########################################################################################################################

  
    compile()


    #### préparation des paramètres à monitorer ####

    channels = [ 'mono%d' %i for i in range(1,NbChannels+1)]
    MSNd1monitors, MSNd2monitors, FSImonitors, STNmonitors, GPemonitors, GPiSNrmonitors, = {} , {} , {} , {} , {} , {}
    for idx,channel in enumerate(channels):
            MSNd1monitors[channel] = Monitor(MSNd1[idx], 'r')
            MSNd2monitors[channel] = Monitor(MSNd1[idx], 'r')
            FSImonitors[channel] = Monitor(FSI[idx], 'r')
            STNmonitors[channel] = Monitor(STN[idx], 'r')
            GPemonitors[channel] = Monitor(GPe[idx], 'r')
            GPiSNrmonitors[channel] = Monitor(GPiSNr[idx], 'r')

    if show_input: 
        mCSN, mPTN = {}, {}
        for i in range(NbChannels):
            mCSN[i] = Monitor(CSN[i], 'r')
            mPTN[i] = Monitor(PTN[i], 'r')        
        mCmPf = Monitor(CmPf, 'r')
        
    # #### configuration ds inputs  et simulation ####
        
    
    #mettre les différents inputs possibles dans des fonctions  
    all_time = time * nb_stim
    simulate(all_time)
          

    
    ##### traitement des données simulées et affichage ####

    if show_input : 
        rCSN, rPTN = {}, {}
        for i in range(NbChannels):
            rCSN[i] = mCSN[i].get('r')
            rPTN[i] = mPTN[i].get('r')
            
        rCmPf = mCmPf.get('r')
        f,axs = plt.subplots(nrows=3 , ncols= NbChannels , sharey='row')
        for i in range(NbChannels):  
            axs[0,i].plot(dt()*np.arange(all_time*(1/Dt)), rCSN[i])
            axs[1,i].plot(dt()*np.arange(all_time*(1/Dt)), rPTN[i]) 
            axs[2,i].plot(dt()*np.arange(all_time*(1/Dt)), rCmPf)     
        plt.show()


    rGPis = get_firingrates(GPiSNrmonitors)
    
    
    probas = calcul_proba(rGPis)
    H = calcul_entropy(probas)  #l'entropie H reflète la disposition à l'exploration à un instant donné.
    
    
    view_all_firing_rate(NbChannels, MSNd1monitors, MSNd2monitors, STNmonitors,FSImonitors,GPemonitors,rGPis, all_time, Dt = Dt, Tau_MSN = Tau_MSN, Tau_FSI = Tau_FSI, Tau_STN = Tau_STN, Tau_GPe = Tau_GPe, Tau_GPiSNr = Tau_GPiSNr )
    view_proba(probas,H)
    
###########################################################################################################




def get_firingrates(GPiSNrmonitors):
    rGPi = []
    for monitor in GPiSNrmonitors:
        r = GPiSNrmonitors[monitor].get('r')
        rGPi.append(r)
    return rGPi 


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



######### Fonctions pour calculer probas de choix d'action et entropie de la selection à partir des rGPis ################
def calcul_proba(firing_rates):
    activities = []
    normalized_activities = []
    probas = []
    
    for i in range(len(firing_rates)):
        r = firing_rates[i]
        activity = mean(r[400:800])  #vérifier que l'on prend bien le mean une fois stabilisé !!
        activities.append(activity)

    rest = max(activities)

    for activity in activities:
        norm_activity = activity / rest
        normalized_activities.append(norm_activity)
    
    Sum = 0
    for norm_activity in normalized_activities:
        Sum += 1 - norm_activity

    for norm_activity in normalized_activities:
        proba = (1 - norm_activity) / Sum
        probas.append(proba)

    return probas

def calcul_entropy(probas):
    Sum = 0
    for proba in probas:
        if proba != 0:
            Sum += proba*log2(proba)
    entropy = - Sum  
    return entropy


####################################### VISUALISATIONS DU MODELE ##########################################################

#la fonction renvoie aussi la sortie du modèle qui sert pour les calculs d'efficacité et de distorsion
def view_all_firing_rate( NbChannels, MSNd1monitors, MSNd2monitors, STNmonitors,FSImonitors,GPemonitors,rGPis, all_time, projection_test = False, Shapley_test = False, Dt = 1, test_variation_tau = False, Tau_MSN = 5, Tau_FSI = 5, Tau_STN = 5, Tau_GPe = 5, Tau_GPiSNr = 5):
    fig,axs = plt.subplots(nrows=6 , ncols= NbChannels , sharey='row')
    
    #fig.Figure.set_figsize([10,10])
    
    for idx,monitor in enumerate(MSNd1monitors):
        r = MSNd1monitors[monitor].get('r')
        axs[0,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
        axs[0,idx].title.set_text('Channels %d' %(idx+1))
        axs[0,idx].title.set_size(8)
    axs[0,0].axes.set_ylabel("MSNd1", size = 12 )
    for idx,monitor in enumerate(MSNd2monitors):
        r = MSNd2monitors[monitor].get('r')
        axs[1,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
    axs[1,0].axes.set_ylabel("MSNd2", size = 12 )
    for idx,monitor in enumerate(FSImonitors):
        r = FSImonitors[monitor].get('r')
        axs[2,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
    axs[2,0].axes.set_ylabel("FSI", size = 12 )
    for idx,monitor in enumerate(STNmonitors):
        r = STNmonitors[monitor].get('r')
        axs[3,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
    axs[3,0].axes.set_ylabel("STN",size = 12 )
    for idx,monitor in enumerate(GPemonitors):
        r = GPemonitors[monitor].get('r')
        axs[4,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
    axs[4,0].axes.set_ylabel("GPe",size = 12 )
    for idx,r in enumerate(rGPis):
        axs[5,idx].plot(dt()*np.arange(all_time*(1/Dt)), r)
    axs[5,0].axes.set_ylabel("GPiSNr",size = 12)
    
    #plt.savefig('log/test_variation_tau/tau' + str(Tau_MSN) +','+ str(Tau_FSI) +','+ str(Tau_GPe) +','+ str(Tau_STN) +','+ str(Tau_GPiSNr) + '.pdf', dpi=300, bbox_inches='tight')
    #plt.savefig('log/comprendre_oscillations/test_tau/tauSTN=' + str(Tau_STN) + '.png', dpi=300, bbox_inches='tight')
    #plt.savefig('log/var_dop_lvl_highCmPf/lambda=2.png', dpi=300, bbox_inches='tight')
    plt.show()
    #plt.close('all')

def view_proba(probas,entropy):
    fig,ax = plt.subplots()
    x = [ i for i in range(len(probas)) ]
    ax.bar(x,height = probas)
    textstr = f'H = {round(entropy,5)}'
    props = dict(boxstyle='round', facecolor='wheat', alpha=0.5)
    ax.text(0.05, 0.95, textstr, transform= ax.transAxes, fontsize=14,
        verticalalignment='top', bbox=props)

    #plt.savefig('log/var_dop_lvl_highCmPf/lambda=2.png', dpi=300, bbox_inches='tight')
    plt.show()

def view_entropy(list_H):
    
    #plt.savefig('log/var_dop_lvl_highCmPf/lambda=2.png', dpi=300, bbox_inches='tight')
    plt.show()
    



##########################################################################################################################

if __name__ == '__main__':
    creation_model()












