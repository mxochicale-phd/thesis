###############################################################################	
# 
# 
#
#
#
###############################################################################	

#################
# Start the clock!
start.time <- Sys.time()



### Load libraries
library(data.table)
library(ggplot2)



################################################################################
# (0) Defining paths for main_path, r_scripts_path, ..., etc.
homepath <- Sys.getenv("HOME")
r_scripts_path <- getwd()
setwd("../")
main_path <- getwd()
figures_path <- paste(main_path,'/src',sep="")
setwd("../../../../")
github_path <- getwd()



################################################################################
# Nyquist Theorem
# said that the frequency of the signal
# should be the double as the sampling frequency to recover the signal
# and avoid problems with aliasing. For instance, for the
# maximum hearning frequency of  20Hz, the
# sampling rate for those signals should be 40 Hz.
# FSampling > 2*F max

# Fmax=5
# 50 > 2*5
# 50 > 10

# For our case, the Maximum Frequencies shohould be
# Fmapling/2 which is a maximum freqneices of 25
#



################################################################################
## SineWaves Function
# dc.component <- 0
# amplitudes <- c(1,1,1)  # strength of signal components
# frequencies <- c(4,2,0) # frequency of signal components (Hz)
# delays <- c(0,0,0)      # delay of signal components (radians)
sinewaves.func <- function(t,dc.component,amplitudes,frequencies,delays, mean.additivenoise, sd.additivenoise ) {
    dc.component +
    sum( amplitudes * sin(2*pi*frequencies*t + delays) +
    rnorm(length(t), mean = mean.additivenoise, sd = sd.additivenoise  )
    )
}



##################################################################
# Time Domain setup
acq.freq <- 10  # 50 Hertz
dt <- 1/acq.freq # 0.02 seconds or 20 miliseconds

# T <- 4   ## Maximum Time in seconds
T <- 8   ## Maximum Time in seconds

df <- 1/T
n <- T/dt
t <- seq(0,T,by=dt)



################################################################################
# Create Waveforms in a data.table object


WindowLength <- (length(t)-1)
allSDnoise <- 0.00
# allSDnoise <- 0.05
# allSDnoise <- 0.1




s1 <- data.table(
  n=0:(length(t)-1),
  tn=t,
  xtn=sapply(t, sinewaves.func, dc.component=0, 
		amplitudes=c(1,1,1),
		frequencies=c(1/2,1/4,0),
		delays=c(0,0,0), 
		mean.additivenoise=0, 
		sd.additivenoise=allSDnoise)
  )
s1 <- cbind(type="s1",s1) # Addind type column

s2 <- data.table(
  n=0:(length(t)-1),
  tn=t,
  xtn=sapply(t, sinewaves.func, dc.component=0, 
		amplitudes=c(1,1,1),
		frequencies=c(1,1/2,0),
		delays=c(0,0,0), 
		mean.additivenoise=0, 
		sd.additivenoise=allSDnoise)
  )
s2 <- cbind(type="s2",s2)

s3 <- data.table(
  n=0:(length(t)-1),
  tn=t,
  xtn=sapply(t, sinewaves.func, dc.component=0, 
		amplitudes=c(1,1,1),
		frequencies=c(2,1,0),
		delays=c(0,0,0), 
		mean.additivenoise=0, 
		sd.additivenoise=allSDnoise)
  )
s3 <- cbind(type="s3",s3)


s4 <- data.table(
  n=0:(length(t)-1),
  tn=t,
  xtn=sapply(t, sinewaves.func, dc.component=0, 
		amplitudes=c(1,1,1),
		frequencies=c(4,2,0),
		delays=c(0,0,0), 
		mean.additivenoise=0, 
		sd.additivenoise=allSDnoise)
  )
s4 <- cbind(type="s4",s4)

# ts <- rbind(s1,s2,s3,s4)
ts <- rbind(s2)


################################################################################
# (3) Plotting 

plot_path <- paste(figures_path, sep="")
if (file.exists(plot_path)){
    setwd(file.path(plot_path))
} else {
  dir.create(plot_path, recursive=TRUE)
  setwd(file.path(plot_path))
}




plotlinewidth <- 5

################################################################################
## Plotting time series
plot <- ggplot(ts) +
  geom_line(     aes(x=n,y=xtn),colour='red', lwd = plotlinewidth, alpha=0.7)+      # line
  geom_point(    aes(x=n,y=xtn), shape=21, size=3, stroke =0.5 ) + # stem type end
  geom_segment(  aes(x=n,y=xtn, xend=n, yend= xtn-xtn), size=0.5 ) + # stem
  labs(x='samples (n)',y='')+
  facet_wrap(~type, scales = 'free_y', nrow = 4,  strip.position="right")+
  theme_bw(20)+
  theme( axis.title.x = element_text(size = rel(2), angle = 0),
         axis.text.x = element_text(size = rel(1.5), angle = 0),
         axis.title.y = element_text(size = rel(2.5), angle = 90),
         axis.text.y = element_text(size = rel(1.5), angle = 90),
         panel.grid.major = element_blank(),
         panel.grid.minor = element_blank(),
         panel.background = element_rect(fill = "transparent",colour = NA),
         plot.background = element_rect(fill = "transparent",colour = NA)
         )+
  theme(legend.position="none")

# dev.new(xpos=0,ypos=0,width=15, height=6)
# plot(plot)


# image_width <- 500
# image_height <- 700
# image_dpi <- 300


# png(filename=filenametags,
#   bg = image_bg,
#   type="cairo",
#   width = image_width , height = image_height, units = "px",
#   pointsize=20,
#   res=75
#   )
#
# plot(plot)
#
# dev.off()

imagefilename <- paste('plot_ts_', 'WL_', WindowLength,'_Nsigma', allSDnoise, '.png')

width = 1000
height = 350
image_bg <- "transparent" #image_bg <- "white"

text.factor = 1
dpi <- text.factor * 100
width.calc <- width / dpi
height.calc <- height / dpi

ggsave(filename = imagefilename,
            dpi = dpi,
            width = width.calc,
            height = height.calc,
            units = 'in',
            bg = image_bg,
            device = "png"
            )




#################
# Stop the clock!
end.time <- Sys.time()
end.time - start.time
################################################################################
setwd(r_scripts_path) ## go back to the r-script source path


