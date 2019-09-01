logBOOK


# TODO

- [ ] Embedding the minfo5.c in R [1](http://users.stat.umn.edu/~geyer/rc/).

* [ ] incorporeate in the function the minumum embedding dimesion data table for plots as follows :


```
sage( 'tau: ', tau_i )
	    Et<- as.data.table(cao97sub(inputtimeseries,maxdim,tau_i) )
	    


  	
		########################################    	
		## Minimum Embedding Dimension
		e <- Et# e for the same tau and mi= 1:maxdim	
		ee <- data.table()
			
		fi <- 0
		for (di in 1:(maxdim-2) ){ ##start##for (di in 1:(maxdim-2) ){
			##message( 'dim: ', (di+1), 'diff:', (abs(e$V1[di+1] - e$V1[di]) < delta_ee)    )
			ee <- rbind(ee,  cbind( abs( e$V1[di+1] - e$V1[di] )  , (abs( e$V1[di+1]-e$V1[di]))< delta_ee )  )
			

			if (   ( ( abs( e$V1[di+1]-e$V1[di]) )< delta_ee  ) # absolute substraction betweent the e[di+1] and e[di]
				&&  (   (  e$V1[di] > (1-delta_ee)  )  &&  ( e$V1[di] < (1+delta_ee) )   )    # is e[di] between 1 +/- delta_ee
				&&  (   (  e$V1[di+1] > (1-delta_ee)  )  &&  ( e$V1[di+1] < (1+delta_ee) )   )    # is e[di+1] between 1 +/- delta_ee
	   			) 
				{
				fi <- fi+1
				if (fi == 1)#return the first minimum dimension that is between the threshold
					{
					minEmdDim_r <- as.data.table(di+1)	
					}
				}
			if (fi==0)#otherwhise return zero in case none has been found
				{
				minEmdDim_r <- as.data.table(0)	
				}
			
			##message('fi',fi)	
		
		} ##end##for (di in 1:(maxdim-2) ){

		#create data table for diff and mindim[true/false]
		ee[,dim:=seq(2,(maxdim-1))]
		names(ee) <- gsub("V1", "diff", names(ee))
		names(ee) <- gsub("V2", "mindim", names(ee))

		#add tau column, reorder and accumudlate with other ee values
		func <-function(x) {list( tau_i )}
    		ee[,c("tau"):=func(), ]
 		setcolorder(ee, c(3,4,1,2))
    		eemin_r<- rbind(eemin_r, ee )##  is accumaltion of dim, tau, diff, mindim[true/false]


		##message('minEmdDim_r:',minEmdDim_r)
    		minEmdDim_r[,c("tau"):=func(), ]
		MinEmdDim_r <- rbind(MinEmdDim_r, minEmdDim_r)

		##
		########################################    	




	    func <-function(x) {list( tau_i )}
	    Et[,c("tau"):=func(), ]
	    Et[,dim:=seq(.N)]
	    setcolorder(Et, c(3,4,1:2))
	    E <- rbind(E, Et )
	}


```
added:  Mon 28 May 23:40:21 BST 2018
sorted: ???


* [ ] incorporate timeLag of nonlinearTseries in the functions


```

library(nonlinearTseries)

#Method used for selecting a concrete time lag. 
#Available methods are "first.zero", "first.e.decay" (default), 
#"first.minimum" and "first.value".
ami_timelag_selection_method <- 'first.minimum'
#ami_timelag_selection_method <- 'first.value' 

##Numeric value indicating the value that the autocorrelation/AMI function 
#must cross in order to select the time lag. 
#It is used only with the "first.value" selection method.
ami_numeric_value <- 1/exp(0)

	## tau-delay estimation based on the mutual information function
	tau.ami <- timeLag(time.series = inputtimeseries, technique = "ami",
                selection.method = ami_timelag_selection_method, value = ami_numeric_value,
		lag.max = maxtau,
                do.plot = F, n.partitions = number_of_partitions,
                units = "Bits")

	tauamilag_hs01 <- as.data.table(tau.ami[[1]])
	ami <- tau.ami[[2]]

	amidt <- as.data.table(ami)
	amidt[, tau := 0:(.N-1), ]
	
	ftag <-function(x) {list("HS01")}
	amidt[,c("sensor"):=ftag(), ]
	amihs01 <- amidt

	tauamilag_hs01[,c("sensor"):=ftag(), ]
	

```

added: Mon 28 May 23:42:26 BST 2018
sorted: ???




* [ ] update ami function in state space reconstruciton with the follwoing lines
	which crease a text message right above the miminum delay embedding: 
```
pami <- ggplot(amidt ) + 
	geom_line(  aes(x=tau,y=ami)  ) +
	geom_point(  aes(x=tau,y=ami) ) + 
	#geom_point( aes(x=mintau_idx, y=mintau_val ), size=2, colour='blue', alpha=0.3 ) +
	geom_point( aes(x=mintau_idx, y=mintau_val, size=1.2, alpha=0.5),  colour='blue'  ) +
	annotate("text", x = mintau_idx, y = mintau_val+( mintau_val*(10/100)  ), label = paste('First Min=', mintau_idx, sep='') )+	
	ylab("Average Mutual Information") + 
	theme_bw(20) +	
       	theme(axis.text.x = element_text(colour="grey20",size=16,angle=90,hjust=.5,vjust=.5,face="plain")  )+
	theme(legend.position='none')

```

	added: Sun 27 May 22:09:16 BST 2018    
	sorted: 






# SORTED 


