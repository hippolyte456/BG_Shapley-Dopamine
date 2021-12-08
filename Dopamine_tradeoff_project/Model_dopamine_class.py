##################################### Modification du rBCBG, prise en compte de la dopamine et influence sur les choix ############################################

#####FIN DE L'AJOUT DE TOUS LES NOYAUX D1 ET D2, 
#####AVEC MODIFICATIONS DE LEURS PROJECTIONS TEL QUE DANS KHAMAMSSI / HUMPHRIES 
##### DIFF AVEC VERSION3 : PASSAGE À 10 CANAUX 

##### modifications pour faire les graphes de Mehdi et Humphries 





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
import random as rd 
############################################     CHOIX DE LA MODELISATION         ############################################

os.getcwd()
os.chdir('/home/hippo/Documents/FoldersBG/Dopamine_tradeoff_project')

modelID = 9
models_param = loadtxt(open("compact_weights.csv","rb"),delimiter=";",skiprows=1)
model = models_param[modelID]





class BGmodel: 
    def __init__(self,Tau_MSN = 30, Tau_FSI = 30, Tau_STN = 30, Tau_GPe = 30, Tau_GPiSNr = 30 , Dt = 1, time = 1000.0, NbChannels = 10, Lambda = 0, seed = 456, show_input = False, show_firing = True, show_proba = False, show_all = None, save = False, method_stim = 'random'):
        self.Tau_MSN = Constant('tau_MSN', Tau_MSN)
        self.Tau_FSI = Constant('tau_FSI', Tau_FSI)
        self.Tau_STN = Constant('tau_STN', Tau_STN)
        self.Tau_GPe = Constant('tau_GPe', Tau_GPe)
        self.Tau_GPiSNr = Constant('tau_GPiSNr', Tau_GPiSNr)
        self.Dt = Dt
        self.time = time 
        self.NbChannels = NbChannels
        self.Lambda = Lambda
        self.seed = seed
        self.show_input = show_input
        self.show_firing = show_firing
        self.show_proba = show_proba
        self.show_all = show_all
        self.save = save
        self.method_stim = method_stim
    
        
        sigma = 7*1e3			#microV
        self.sigmap = Constant('sigmap', (sigma * sqrt(3) / pi) )
        #firing rate max des neurones
        self.Smax_MSN = Constant('Smax_MSN', 300.0)
        self.Smax_STN = Constant('Smax_STN', 300.0)
        self.Smax_GPe = Constant('Smax_GPe', 400.0)
        self.Smax_GPiSNr = Constant('Smax_GPiSNr', 400.0)
        self.Smax_FSI = Constant('Smax_FSI', model[29])
        #paramètre d'activation des neurones
        self.theta_MSN = Constant('theta_MSN', model[24]*1e3)
        self.theta_FSI = Constant('theta_FSI', model[25]*1e3)
        self.theta_STN = Constant('theta_STN', model[26]*1e3)
        self.theta_GPe = Constant('theta_GPe', model[27]*1e3)
        self.theta_GPiSNr = Constant('theta_GPiSNr', model[28]*1e3)
        #on divise par deux les projections partant de MSN puisque le nombre de neurones de la population simulée est maintenant divisée entre d1 et d2 
        self.W_CSN_MSN = model[0]   
        self.W_CSN_FSI = model[1]
        self.W_PTN_MSN = model[22]   
        self.W_PTN_FSI = model[23]
        self.W_PTN_STN = model[2]
        self.W_MSN_GPe = model[3]    /2  
        self.W_MSN_GPiSNr = 0.82 *model[4]   /2     # corrects an error: the probability of projection 0.82 self.Was forgotten self.When generating compact_self.Weights.csv
        self.W_MSN_MSN = model[16]/ NbChannels /2
        self.W_STN_GPe = model[5]/ NbChannels
        self.W_STN_GPiSNr = model[6]/ NbChannels
        self.W_STN_MSN = model[7]/ NbChannels   
        self.W_STN_FSI = model[8]/ NbChannels
        self.W_GPe_STN = model[9]
        self.W_GPe_GPiSNr = model[10]/ NbChannels
        self.W_GPe_MSN = model[11]/ NbChannels   
        self.W_GPe_FSI = model[12]/ NbChannels
        self.W_GPe_GPe = model[13]/ NbChannels
        self.W_FSI_MSN = model[14]/ NbChannels    
        self.W_FSI_FSI = model[15]/ NbChannels
        self.W_CmPf_MSN = model[17]/ NbChannels    
        self.W_CmPf_FSI = model[18]/ NbChannels
        self.W_CmPf_STN = model[19]/ NbChannels
        self.W_CmPf_GPe = model[20]/ NbChannels
        self.W_CmPf_GPiSNr = model[21]/ NbChannels
        self.latency  = {"dCSN_MSN" : 6 , "dCSN_FSI" : 6 , "dPTN_MSN" : 6 , "dPTN_FSI" : 6 , "dPTN_STN" : 4 , "dMSN_GPe" : 8 , "dMSN_GPiSNr" : 11 , "dMSN_MSN" : 0 , "dSTN_GPe" : 9 ,"dSTN_GPiSNr" : 4 , "dSTN_MSN" : 3 ,"dSTN_FSI" : 3 , "dGPe_STN" : 1 , "dGPe_GPiSNr" :1 , "dGPe_MSN" : 8 , "dGPe_FSI" : 8 , "dGPe_GPe" : 0 , "dFSI_MSN" : 0 , "dFSI_FSI" : 0 ,"dCmPf_MSN" : 0 , "dCmPf_FSI" : 0 ,"dCmPf_STN" : 0 ,"dCmPf_GPe" : 0 ,"dCmPf_GPiSNr" : 0 }
    #######################################################   
        self.LeakyIntegratorNeuron_MSN = Neuron(               
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
        self.LeakyIntegratorNeuron_FSI = Neuron(                                                      
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

        self.LeakyIntegratorNeuron_GPe = Neuron(              
                                                    
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

        self.LeakyIntegratorNeuron_STN = Neuron(              
                                                    
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

        self.LeakyIntegratorNeuron_GPiSNr = Neuron(              
                                                    
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

    #######################################################
    laps = 30
    
    def method(self):
        stimuli_CSN = self.creation_stimuli(self.NbChannels, self.laps, self.time, num_seed = self.seed, method = self.method_stim, nucleus = 'CSN')
        stimuli_PTN = self.creation_stimuli(self.NbChannels, self.laps, self.time, num_seed = self.seed, method = self.method_stim, nucleus = 'PTN')
        stimuli_CmPf = [[5,self.time,0,self.laps]]
    
    

    ### input ### 
    def creation_input(self):
        CSN = {}
        PTN = {}
        CmPf = creation_TimedArray(time,self.NbChannels,stimuli,stimuli_CmPf)

        for i in range(self.NbChannels):
            CSN[i] = self.creation_TimedArray(time,1,stimuli, stimuli_CSN[i])
            PTN[i] = self.creation_TimedArray(time,1,stimuli, stimuli_PTN[i])
    
    ### BG ###
    FSI = Population(name='FSI', geometry=self.NbChannels, neuron=LeakyIntegratorNeuron_FSI) # à diviser en 2 aussi ? 
    MSNd1 = Population(name='MSNd1', geometry=self.NbChannels, neuron=LeakyIntegratorNeuron_MSN)
    MSNd2 = Population(name='MSNd2', geometry=self.NbChannels, neuron=LeakyIntegratorNeuron_MSN)
    GPe = Population(name='GPe', geometry=self.NbChannels, neuron=LeakyIntegratorNeuron_GPe)
    GPiSNr = Population(name='GPiSNr', geometry=self.NbChannels, neuron=LeakyIntegratorNeuron_GPiSNr)
    STN = Population(name='STN', geometry=self.NbChannels, neuron=LeakyIntegratorNeuron_STN) # à diviser en 2 aussi ? 

    Basic = Synapse(parameters="""alpha = 1.0""")
    # # # CREATION DES PROJECTIONS ENTRE LES POPULATIONS 
    lambda1 = Lambda
    lambda2 = Lambda
    d1_GPe = 1
    d1_GPi = 1
    d2_GPe = 1
    d2_GPi = 0.6

    for i in range(self.NbChannels):
        proj_CSN1_MSNd1 = Projection(pre=CSN[i], post=MSNd1[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_CSN_MSN*(1+lambda1) , delays = latency['dCSN_MSN'])
        proj_CSN1_MSNd2 = Projection(pre=CSN[i], post=MSNd2[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_CSN_MSN*(1-lambda2) , delays = latency['dCSN_MSN']) 
        proj_CSN1_FSI = Projection(pre=CSN[i], post=FSI[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_CSN_FSI , delays = latency['dCSN_FSI'])
        proj_PTN1_MSNd1 = Projection(pre=PTN[i], post=MSNd1[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_MSN*(1+lambda1) , delays = latency['dPTN_MSN']) 
        proj_PTN1_MSNd2 = Projection(pre=PTN[i], post=MSNd2[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_MSN*(1-lambda2) , delays = latency['dPTN_MSN'])
        proj_PTN1_FSI = Projection(pre=PTN[i], post=FSI[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_FSI , delays = latency['dPTN_FSI'])
        proj_PTN1_STN = Projection(pre=PTN[i], post=STN[i], target='exc', synapse=Basic).connect_one_to_one(weights= W_PTN_STN , delays = latency['dPTN_STN'])
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



    def creation_stimuli(self,NbChannels,laps,time,num_seed = 456, method = 'manual', nucleus = 'CSN',):
        stimuli = {}

        if method == 'manual':
            if nucleus == 'CSN':
                stim = [ [[2,time,0,laps]],[[5,time,0,laps]],[[10,time,0,laps]],[[15,time,0,laps]],[[18,time,0,laps]],[[15,time,0,laps]],[[12,time,0,laps]],[[10,time,0,laps]],[[7,time,0,laps]],[[4,time,0,laps]] ]
            if nucleus == 'PTN':
                stim = [ [[15,time,0,laps]],[[20,time,0,laps]],[[25,time,0,laps]],[[30,time,0,laps]],[[35,time,0,laps]],[[32,time,0,laps]],[[28,time,0,laps]],[[24,time,0,laps]],[[21,time,0,laps]],[[18,time,0,laps]] ]    
        
        if method == 'random':
            rd.seed(num_seed)
            if nucleus == 'CSN':
                stim = [ [[2+18*rd.random(),time,0,laps]]  for i in range(NbChannels) ]
            if nucleus == 'PTN':
                stim = [ [[15+31*rd.random(),time,0,laps]]  for i in range(NbChannels) ]

        for i in range(NbChannels):
            stimuli[i] = stim[i]
        
        return stimuli


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







    compile()

    #### préparation des paramètres à monitorer ####

    channels = [ 'mono%d' %i for i in range(1,self.NbChannels+1)]
    MSNd1monitors, MSNd2monitors, FSImonitors, STNmonitors, GPemonitors, GPiSNrmonitors, = {} , {} , {} , {} , {} , {}
    for idx,channel in enumerate(channels):
            MSNd1monitors[channel] = Monitor(MSNd1[idx], 'r')
            MSNd2monitors[channel] = Monitor(MSNd1[idx], 'r')
            FSImonitors[channel] = Monitor(FSI[idx], 'r')
            STNmonitors[channel] = Monitor(STN[idx], 'r')
            GPemonitors[channel] = Monitor(GPe[idx], 'r')
            GPiSNrmonitors[channel] = Monitor(GPiSNr[idx], 'r')

    mCSN, mPTN = {}, {}
    for i in range(self.NbChannels):
        mCSN[i] = Monitor(CSN[i], 'r')
        mPTN[i] = Monitor(PTN[i], 'r')        
    mCmPf = Monitor(CmPf, 'r')
    
    ##### CONFIGURATION INPUTS ET SIMULATIONS #####
            #todo : mettre les différents inputs possibles dans des fonctions  
    all_time = time 
    simulate(all_time)


    ##### TRAITEMENT DES DONNEES simulées #####  
    rGPis = get_firingrates(GPiSNrmonitors) 
    probas = calcul_proba(rGPis)
    H = calcul_entropy(probas)  #l'entropie H reflète la disposition à l'exploration à un instant donné.
    
    ##### AFFICHAGE #####
    if show_input :
        view_input(self.NbChannels,all_time,Dt,mCSN,mPTN,mCmPf, save = save, Lambda=Lambda)       
    if show_firing:
        view_all_firing_rate(self.NbChannels, MSNd1monitors, MSNd2monitors, STNmonitors,FSImonitors,GPemonitors,rGPis, all_time, Dt = Dt, save = save, Lambda=Lambda )
    if show_proba:
        view_proba(probas,H, save = save, Lambda=Lambda)

     #return H
    

    ###########################################################################################################




    def get_firingrates(GPiSNrmonitors):
    rGPi = []
    for monitor in GPiSNrmonitors:
        r = GPiSNrmonitors[monitor].get('r')
        rGPi.append(r)
    return rGPi 


##################################  Fonctions pour creer les inputs  #####################################
    



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
def view_input(NbChannels,all_time,Dt,mCSN,mPTN,mCmPf, save = False, Lambda = 0):
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
    if save: 
        plt.savefig(f'log/test_Khamassi/var_lambda/input_lambda={Lambda}.png', dpi=300, bbox_inches='tight') 
    else:
        plt.show()
 
def view_all_firing_rate( NbChannels, MSNd1monitors, MSNd2monitors, STNmonitors,FSImonitors,GPemonitors,rGPis, all_time, Dt = 1, save = False, Lambda = 0):
    
    fig,axs = plt.subplots(nrows=6 , ncols= NbChannels , sharey='row')
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
    
    if save:
        #plt.savefig('log/test_variation_tau/tau' + str(Tau_MSN) +','+ str(Tau_FSI) +','+ str(Tau_GPe) +','+ str(Tau_STN) +','+ str(Tau_GPiSNr) + '.pdf', dpi=300, bbox_inches='tight')
        #plt.savefig('log/comprendre_oscillations/test_tau/tauSTN=' + str(Tau_STN) + '.png', dpi=300, bbox_inches='tight')
        plt.savefig(f'log/test_Khamassi/var_lambda/firingrate_lambda={Lambda}.png', dpi=300, bbox_inches='tight')
    else:
        plt.show()
        #plt.close('all')

def view_proba(probas,entropy, save = False, Lambda = 0):
    fig,ax = plt.subplots()
    x = [ i for i in range(len(probas)) ]
    ax.bar(x,height = probas)
    #ax.plot(x,probas)
    textstr = f'H = {round(entropy,5)}'
    props = dict(boxstyle='round', facecolor='wheat', alpha=0.5)
    ax.text(0.05, 0.95, textstr, transform= ax.transAxes, fontsize=14,
        verticalalignment='top', bbox=props)
    if save:
        plt.savefig(f'log/test_Khamassi/var_lambda/probas_lambda={Lambda}.png', dpi=300, bbox_inches='tight')
    else:
        plt.show()






####################################### LES DIFFÉRENTS TESTS À LANCER #################################################
def Khamassi_var_entropy(nb_points = 11,lambda_max = 1, nb_inputs = 10, first_seed = 456):
    list_lambda = []
    list_H = []
    list_varH = []
    for i in range(nb_points+1):      # nombre de points sur la courbe H = f(lambda)
        Lambda = i/(nb_points)*lambda_max
        lH = []
        num_seed = first_seed       # pour chaque nouveau lambda on réintialise la seed pour avoir la même séquence d'input 
        for i in range(nb_inputs):  # nombre d'inputs différents pour créer chaque point de la courbe 
            H = creation_model(Lambda = Lambda, show_all = False, seed = num_seed) 
            num_seed += 1           # on fait varier la seed à chaque modèle
            lH.append(H)

        list_lambda.append(Lambda)
        meanH = mean(lH)
        varH = var(lH)
        list_H.append(meanH)
        list_varH.append(varH)

    plt.plot(list_lambda, list_H)
    for err in range(len(list_lambda)):
        plt.errorbar(list_lambda[err], list_H[err], yerr = 2*sqrt( list_varH[err]/nb_points) )
    #plt.savefig('log/test_Khamassi/var_entropy/10X456entropy=f(lambda).png', dpi=300, bbox_inches='tight')
    plt.show()
    ##ajouter une ligne pour sauver données aussi, en plus de la figure 
    
    
def Khamassi_var_proba():
    for i in [0,0.5,1]:
        creation_model(Lambda=i, show_all = True, method_stim = 'manual', save = True)












    print("coucou j'ai été instancié")

    def use_attribute(self):
        print(self.NbChannels *10)
    # def ANNarchy_parameter(self):
    #     tau_MSN = Constant('tau_MSN', Tau_MSN)
    #     tau_FSI = Constant('tau_FSI', Tau_FSI)
    #     tau_STN = Constant('tau_STN', Tau_STN)
    #     tau_GPe = Constant('tau_GPe', Tau_GPe)
    #     tau_GPiSNr = Constant('tau_GPiSNr', Tau_GPiSNr)

if __name__ == '__main__':
    BG = BGmodel() 
    BG.use_attribute()  
    print(BG.LeakyIntegratorNeuron_MSN.parameters)
    print(BG.sigmap)


















