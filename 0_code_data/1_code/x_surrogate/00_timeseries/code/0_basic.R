###########################################################################
#
#
###########################################################################


#################
# Start the clock!
start.time <- Sys.time()

###########################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.
r_scripts_path <- getwd()
setwd("../../../../../")
github_path <- getwd()
libfun_path <- '/0_code_data/1_code/2_libraries_functions'


###########################################################################
# (1) Loading Functions and Libraries

library(devtools)
load_all(paste(github_path, libfun_path, '/nonlinearTseries', sep=""))


# ################################################################################
# # Nyquist Theorem
# # said that the frequency of the signal
# # should be the double as the sampling frequency to recover the signal
# # and avoid problems with aliasing. For instance, for the
# # maximum hearning frequency of  20Hz, the
# # sampling rate for those signals should be 40 Hz.
# # FSampling > 2*F max
#
# # Fmax=5
# # 50 > 2*5
# # 50 > 10
#
# # For our case, the Maximum Frequencies shohould be
# # Fmapling/2 which is a maximum freqneices of 25
# #
#


###########################################################################
###########################################################################
###########################################################################
### Surrogate Example from 
### https://rdrr.io/cran/nonlinearTseries/man/surrogateTest.html


# Number of generated surrogates 
K_val <- 5
alpha <- 0.05

NS= ((2*K_val)/alpha) -1 # for two-side test
message('NS=', NS)


lx = lorenz(do.plot=F)$x
sdt = surrogateTest(	
	time.series = lx,
	significance = alpha,
        K=K_val, 
	#Integer controlling the number of surrogates to be generated 
	one.sided = FALSE,# a two-side test is applied. 
	FUN=timeAsymmetry
	) 


############################################################################
############################################################################
############################################################################
### FFTsurrogate: Generate surrogate data using the Fourier transform
### https://rdrr.io/cran/nonlinearTseries/man/FFTsurrogate.html
#time.series = arima.sim(list(order = c(1,0,1), ar = 0.6, ma = 0.5), n = 200)
#surrogate = FFTsurrogate(time.series, 20)



###########################################################################
##########################################################################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
###########################################################################
##########################################################################


###########################################################################
setwd(r_scripts_path) ## go back to the r-script source path
