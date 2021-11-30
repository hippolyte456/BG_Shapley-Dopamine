#Shapley_ordi_Benoit



##################################### rewriting of rBCBG with ANNarchy simulator ############################################
#############################################################################################################################

################################################## REMARQUES GENERALES ######################################################
### pour le firing rate at rest... directement dans la def de r ... ?
### trouver le moyen de donner des nom qui change dans les boucles ?? sinon ne peut le faire sous forme de boucles... )
### je ne comprends pas pourquoi il faut recompiler à chaque fois ça n'a aucun seeeeens ! #en plus ça marche la 2eme mais pas la troisieme fois...

### la grosse fonction a 3 parties : def du model precompile (mettre des paramètres dedans, compilation, option de ce qu'on veut faire avec le modele( simul et visu, avec paramétrage aussi))
###donc on va creer des programmes differents pour 1ère partie et 2ème partie 


#utiliser les fonctions de comptage du temps d'execution pour preparer le run 
#test des matrices de distorsion/efficacité pour le modèle rBCBG initial (comparé 4 valeurs et 11 valeurs) -->peut-on extrapoler ?
#regarder le comportmeent des selections lorsqu'il y a 2 canaux / lorsqu'il y a 6 canaux --> peut-on réduire à 2 canaux sans soucis ? 
#vérifier que le temps d'intégration ne provoque pas les oscillations ? 
#test de Gurney 2001 pour verifier l'histeresis du modèle
#regarder comment sauvegarder les modeles pour les recharger et les modifier seuelemnt un peu ensuite... estce que ça va plus vite ? 


#quel modèle utilisé ?
#pourquoi il n'y a jamais du one two one EET du all to all ??? ça pourrait pas changé complétmeent la chose ? 
############################################     IMPORTATION MODULES         ################################################

from ANNarchy import *
clear()
from connexweights import * #pas besoin 
from math import * 
from numpy import *
import matplotlib.pyplot as plt
import time as ti
import os as os 
from itertools import chain, combinations
############################################     CHOIX DE LA MODELISATION         ############################################

os.getcwd()
os.chdir('/home/hippo/Documents/FoldersBG')

modelID = 9
models_param = loadtxt(open("compact_weights.csv","rb"),delimiter=";",skiprows=1)
model = models_param[modelID]



##################### DEFINITION / RECUPERATION PARAMETRES NECESSAIRES ... A PASSER AUX CLASSES d'ANNarchy #################### 
def creation_model(Tau_MSN = 30, Tau_FSI = 30, Tau_STN = 30, Tau_GPe = 30, Tau_GPiSNr = 30 , Dt = 1, time = 1000.0, NbChannels = 3, perturb = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1], projection_test = False, channel_test = False, Shapley_test = False, test_verif_model = False, test_hysteresis = False, test_variation_tau = False):

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

    latency  = {"dCSN_MSN" : 7 , "dCSN_FSI" : 7 , "dPTN_MSN" : 7 , "dPTN_FSI" : 7 , "dPTN_STN" : 3 , "dMSN_GPe" : 7 , "dMSN_GPiSNr" : 11 , "dMSN_MSN" : 0 , "dSTN_GPe" : 3 ,"dSTN_GPiSNr" : 3 , "dSTN_MSN" : 3 ,"dSTN_FSI" : 3 , "dGPe_STN" : 10 , "dGPe_GPiSNr" :3 , "dGPe_MSN" : 3 , "dGPe_FSI" : 3 , "dGPe_GPe" : 0 , "dFSI_MSN" : 0 , "dFSI_FSI" : 0 ,"dCmPf_MSN" : 0 , "dCmPf_FSI" : 0 ,"dCmPf_STN" : 0 ,"dCmPf_GPe" : 0 ,"dCmPf_GPiSNr" : 0 }


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

    
    input_CSN = Neuron(parameters="r=2")
    input_CSNstim = Neuron(parameters="r=2")
    input_PTN = Neuron(parameters="r=15")
    input_PTNstim = Neuron(parameters="r=15")
    input_CmPf = Neuron(parameters="r=4")


    # DEFINITION DES POPULATIONS 

    ### input ###    
    CSN = Population(name='CSN', geometry=NbChannels-1, neuron = input_CSN )
    PTN = Population(name='PTN', geometry=NbChannels-1, neuron = input_PTN )
    CSNstim = Population(name='CSNstim', geometry=1, neuron = input_CSNstim )
    PTNstim = Population(name='PTNstim', geometry=1, neuron = input_PTNstim )
    CmPf = Population(name='CMPf', geometry=NbChannels, neuron = input_CmPf )
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

    
    if perturb[0] :
        proj_MSN_GPe = Projection(pre=MSN, post=GPe, target='inh', synapse=Basic).connect_one_to_one(weights= W_MSN_GPe , delays = latency['dMSN_GPe'])
    if perturb[1] :
        proj_MSN_GPiSNr = Projection(pre=MSN, post=GPiSNr, target='inh', synapse=Basic).connect_one_to_one(weights= W_MSN_GPiSNr , delays = latency['dMSN_GPiSNr'])
    if perturb[2] :
        proj_MSN_MSN = Projection(pre=MSN, post=MSN, target='inh', synapse=Basic).connect_all_to_all(weights = W_MSN_MSN , delays = latency['dMSN_MSN'], allow_self_connections=True) #attention il faut faire en sorte que la connexion se fasse sur tout le monde sauf le neurone qui envoie
    if perturb[3] :
        proj_STN_GPe = Projection(pre=STN, post=GPe, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_GPe , delays = latency['dSTN_GPe']) 
    if perturb[4] :   
        proj_STN_GPiSNr = Projection(pre=STN, post=GPiSNr, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_GPiSNr , delays = latency['dSTN_GPiSNr']) 
    if perturb[5] :   
        proj_STN_MSN = Projection(pre=STN, post=MSN, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_MSN , delays = latency['dSTN_MSN']) 
    if perturb[6] :    
        proj_STN_FSI = Projection(pre=STN, post=FSI, target='exc', synapse=Basic).connect_all_to_all(weights = W_STN_FSI , delays = latency['dSTN_FSI']) 
    if perturb[7] :    
        proj_GPe_STN = Projection(pre=GPe, post=STN, target='inh', synapse=Basic).connect_one_to_one(weights= W_GPe_STN , delays = latency['dGPe_STN'])
    if perturb[8] :    
        proj_GPe_GPiSNr = Projection(pre=GPe, post=GPiSNr, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_GPiSNr , delays = latency['dGPe_GPiSNr']) 
    if perturb[9] :    
        proj_GPe_MSN = Projection(pre=GPe, post=MSN, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_MSN , delays = latency['dGPe_MSN']) 
    if perturb[10] :    
        proj_GPe_FSI = Projection(pre=GPe, post=FSI, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_FSI , delays = latency['dGPe_FSI']) 
    if perturb[11] :    
        proj_GPe_GPe = Projection(pre=GPe, post=GPe, target='inh', synapse=Basic).connect_all_to_all(weights = W_GPe_GPe , delays = latency['dGPe_GPe'], allow_self_connections=True)
    if perturb[12] :    
        proj_FSI_MSN = Projection(pre=FSI, post=MSN, target='inh', synapse=Basic).connect_all_to_all(weights = W_FSI_MSN, delays = latency['dFSI_MSN'])
    if perturb[13] :    
        proj_FSI_FSI = Projection(pre=FSI, post=FSI, target='inh', synapse=Basic).connect_all_to_all(weights = W_FSI_FSI, delays = latency['dFSI_FSI'], allow_self_connections=True)
    if perturb[14] :    
        proj_CmPf_MSN = Projection(pre=CmPf, post=MSN, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_MSN , delays = latency['dCmPf_MSN'])
    if perturb[15] :    
        proj_CmPf_FSI = Projection(pre=CmPf, post=FSI, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_FSI , delays = latency['dCmPf_FSI'])
    if perturb[16] :    
        proj_CmPf_STN = Projection(pre=CmPf, post=STN, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_STN , delays = latency['dCmPf_STN'])
    if perturb[17] :    
        proj_CmPf_GPe = Projection(pre=CmPf, post=GPe, target='exc', synapse=Basic).connect_all_to_all(weights = W_CmPf_GPe , delays = latency['dCmPf_GPe'])
    if perturb[18] :    
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



    #### configuration ds inputs  et simulation ####

    nb_saliences = 10
    CSN_levels = [2 + (salience * (20-2))/(nb_saliences-1) for salience in range(nb_saliences)]
    PTN_levels = [15 + (salience * (46-15))/(nb_saliences-1) for salience in range(nb_saliences)]
    n = len(CSN_levels) #on pourrait prendre directement nb_saliences
    CSN_order = [CSN_levels[i] for i in range(n) for k in range(n-i) ]         
    CSN_order_stim = [CSN_levels[i] for k in range(n) for i in range(k,n)]
    PTN_order = [PTN_levels[i] for i in range(n) for k in range(n-i) ]
    PTN_order_stim = [PTN_levels[i] for k in range(n) for i in range(k,n)]
    CSNsaliences = [(CSN_order[i],CSN_order_stim[i]) for i in range(len(CSN_order_stim))]
    PTNsaliences = [(PTN_order[i],PTN_order_stim[i]) for i in range(len(CSN_order_stim))]

    nb_stim = len(CSNsaliences)
    all_time = time * nb_stim
    for i in range(nb_stim):
            CSN.r = CSNsaliences[i][0]
            PTN.r = PTNsaliences[i][0]
            CSNstim.r = CSNsaliences[i][1]
            PTNstim.r = PTNsaliences[i][1]

            simulate(all_time / nb_stim)

    
    # #### traitement des données simulées et affichage ####

    rGPi = view_all_firing_rate(NbChannels, MSNmonitors, STNmonitors,FSImonitors,GPemonitors,GPiSNrmonitors, all_time, projection_test = projection_test, Shapley_test= Shapley_test, Dt = Dt, test_variation_tau = test_variation_tau, Tau_MSN = Tau_MSN, Tau_FSI = Tau_FSI, Tau_STN = Tau_STN, Tau_GPe = Tau_GPe, Tau_GPiSNr = Tau_GPiSNr )
    eff , dist, list_eff, list_dist = calcul_eff_dist(rGPi[0], rGPi[1],nb_stim)
    
    if not (projection_test or Shapley_test) :
        view_matrix_eff_dist(list_eff,list_dist,n, NbChannels,Tau_GPe)

   
    return(eff,dist)

    

    ####################################### VISUALISATIONS DU MODELE ##########################################################


#la fonction renvoie aussi la sortie du modèle qui sert pour les calculs d'efficacité et de distorsion
def view_all_firing_rate( NbChannels, MSNmonitors, STNmonitors,FSImonitors,GPemonitors,GPiSNrmonitors, all_time, projection_test = False, Shapley_test = False, Dt = 1, test_variation_tau = False, Tau_MSN = 5, Tau_FSI = 5, Tau_STN = 5, Tau_GPe = 5, Tau_GPiSNr = 5):
    f,axs = plt.subplots(nrows=5 , ncols= NbChannels , sharey='row')
    for idx,monitor in enumerate(MSNmonitors):
        r = MSNmonitors[monitor].get('r')
        axs[0,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
        axs[0,idx].title.set_text('Channels')
    for idx,monitor in enumerate(FSImonitors):
        r = FSImonitors[monitor].get('r')
        axs[1,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
    for idx,monitor in enumerate(STNmonitors):
        r = STNmonitors[monitor].get('r')
        axs[2,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
    for idx,monitor in enumerate(GPemonitors):
        r = GPemonitors[monitor].get('r')
        axs[3,idx].plot(dt()*np.arange(all_time*(1/Dt)), r) 
    rGPi = []
    for idx,monitor in enumerate(GPiSNrmonitors):
        r = GPiSNrmonitors[monitor].get('r')
        axs[4,idx].plot(dt()*np.arange(all_time*(1/Dt)), r)
        if idx <= 1: #on récupere le firing rate du GPi pour les deux premiers canaux : le premier étant celui stimuler et l'autre pour la comparaison
            rGPi.append(r)
    
    if test_variation_tau: 
        plt.savefig('log/test_variation_tau/tau' + str(Tau_MSN) +','+ str(Tau_FSI) +','+ str(Tau_GPe) +','+ str(Tau_STN) +','+ str(Tau_GPiSNr) + '.pdf', dpi=300, bbox_inches='tight')
        plt.close()
    if projection_test or Shapley_test or test_variation_tau :
        pass
    else: 
        plt.show()
        plt.close()
    return(rGPi)


def view_matrix_eff_dist(list_eff,list_dist, n, NbChannels,Tau_GPe = 5):
    
    matrix_eff = np.matrix( [ [ 0 for k in range(j) ]  +  [list_eff[ int(sum([((n) - k) for k in range(j)]) ) + l ] for l in range(n - j) ]   for j in range(n) ] )
    matrix_dist = np.matrix( [ [ 0 for k in range(j) ]  +  [list_dist[ int(sum([((n) - k) for k in range(j)]) ) + l ] for l in range(n - j) ]   for j in range(n) ] )
    #matrix_eff = np.matrix([[list_eff[i] for i in range(5)],[list_eff[5 + i] for i in range(4)] + [0] , [list_eff[5+4 + i] for i in range(3)] + [0,0], [list_eff[5+4+3 + i] for i in range(2)] + [0,0,0], [list_eff[5+4+3+2 + i] for i in range(1)] + [0,0,0,0]])
    #matrix_dist = np.matrix([[list_dist[i] for i in range(5)],[list_dist[5 + i] for i in range(4)] + [0] , [list_dist[5+4 + i] for i in range(3)] + [0,0], [list_dist[5+4+3 + i] for i in range(2)] + [0,0,0], [list_dist[5+4+3+2 + i] for i in range(1)] + [0,0,0,0]])
    plt.subplot(121)
    plt.imshow(matrix_eff)
    plt.subplot(122)
    plt.imshow(matrix_dist)
    plt.show()
    #plt.savefig('log/tau_over_effdist/tau='+ str(Tau_GPe) + '.png', dpi=300, bbox_inches='tight')
    #plt.imsave(fname = "log/channels_test/matrice_eff%d" %NbChannels, arr = matrix_eff, format = 'png' )
    #plt.imsave(fname = "log/channels_test/matrice_dist%d" %NbChannels, arr = matrix_dist, format = 'png' )
    plt.close()



############################# TEST DE SHAPLEY #################################################################

#on veut mesurer l'apport relatif de chaque projection à la qualité de sélection du modèle (ie l'efficacité et la distorsion)
#on utilise des petits pas de saliences pour construire les matrices d'efficacité et de distorsion (le temps de calcul n'étant presque pas influencé par le nombre de saliences choisies)
#on vérifie qu'il n'y a pas d'effet d'hystereris 
#on vérifie que le nombre de channels n'influence pas trop la qualité de sélection du modèle 


#il faut relier à chaque partition sa valeur de eff et sa valeur de dist (fonction link)
#puis il faut calculer la valeur de shapley pour chaque projection, et pour ça il faut appeler toutes les partitions et soustraire le joueur i
# to do : faire des sous ensembles de projections et regarder qu'est-ce qui sert à quoi (pas long) //// tester l'ensemble des connexions en même temps (long )

def powerset(iterable):
    "powerset([1,2,3]) --> () (1,) (2,) (3,) (1,2) (1,3) (2,3) (1,2,3)"
    s = list(iterable)
    return chain.from_iterable(combinations(s, r) for r in range(1,len(s)+1)) #estcequon rpend lenseble vide ou pas ...


def calcul_val_Shapley(val_partitions,i):    #calcule la valeur de Shapley pour la projection i (à voir s'il faut optimiser en faisant toute les projection en meme tems ou temps negligeable ?)
    num_projection = i 
    val_projection = 0
    n = 19
    for partition in val_partitions:
        if num_projection in partition:
            partition_sans_i = list(partition)  # partition sans la projection en question
            partition_sans_i.remove(num_projection)  
            partition_sans_i = tuple(partition_sans_i)
            z = len(partition)
            if len(partition_sans_i) != 0 :
                val_partition_sans_i = val_partitions[partition_sans_i] 
            else : 
                val_partition_sans_i = 0
            val_partition = (val_partitions[partition] - val_partition_sans_i) * factorial(n-z)*factorial(z-1)/factorial(n)  #
            val_projection += val_partition
    return(val_projection)


def calcul_eff_dist(firing_rate,firing_rate_stim,nb_stim):
    subarrays, subarrays_stim = {} , {}
    for i in range(nb_stim): 
        subarrays['%d'%i] = firing_rate[int('%d250'%i) : int('%d750'%i)]         
        subarrays_stim['%d'%i] = firing_rate_stim[int('%d250'%i) : int('%d750'%i)]

    rGPi_rest = mean(subarrays['1'])
    efficacity, distortion = [],[]
    for i in range(nb_stim):
        rGPi = mean(subarrays['%d'%i])
        rGPi_stim = mean(subarrays_stim['%d'%i])
        eff1 = max(0, 1 - rGPi / rGPi_rest)
        eff2 = max(0, 1 - rGPi_stim / rGPi_rest)
        eff = max( eff1, eff2)
        if eff == 0:
            dist = 0
        else:    
            dist = 1 - abs( eff1 - eff2 ) / (eff) #changer pour la la mettre à 0 quand pas d'efficacité du tout 
        efficacity.append(eff)
        distortion.append(dist)
    
    value_efficacity = mean(efficacity)
    value_distortion = mean(distortion)
    #tot_selection_value = mean(np.array(1-value_distortion,value_efficacity))   #à normaliser
    return (value_efficacity,value_distortion,efficacity,distortion)







def Shapley_test():
    a = time.time()
    nb_projections = 2  ##### PENSER A REMETTRE à 19 
    all_partitions = list(powerset( [i for i in range(nb_projections)]) )  
    valeurs_eff, valeurs_dist = {}, {}
    for i in range(19): 
        valeurs_eff['proj%d'%i] = 0
        valeurs_dist['proj%d'%i] = 0
    val_partitions_eff, val_partitions_dist = {},{}
 
    for combinaison in all_partitions:
        perturbation = [1 for i in range(19)]
        for idx in combinaison: #attention estceque les idx sont biens definis dans all-partitions (tuple)
            perturbation[idx] = 0
        eff, dist = creation_model(perturb = perturbation, Shapley_test = True)
        val_partitions_eff[combinaison] = eff
        val_partitions_dist[combinaison] = dist

    for  i in range(19): 
        valeurs_eff['proj%d'%i] = calcul_val_Shapley(val_partitions_eff,i)
        valeurs_dist['proj%d'%i] = calcul_val_Shapley(val_partitions_dist,i)
    b = time.time()
    print(b-a)
    return(valeurs_eff , valeurs_dist)











if __name__ == '__main__':
    #creation_model(Tau_MSN = 30, Tau_FSI = 30, Tau_STN = 30, Tau_GPe = 30, Tau_GPiSNr = 30)
    val_proj_eff, val_proj_dist = Shapley_test()
    print(val_proj_eff,val_proj_dist)
    # np.save('log/test_Shapley/results_eff', val_proj_eff)
    # np.save('log/test_Shapley/results_dist', val_proj_dist)


















