# Set my working directory to put things in the right place

setwd("~/agingex1")

# This is where files will be from both my and Emily's HPCC accounts, on
# the round of testing that gave us [WHAT IS IN THIS SET OF DATA?]

#Start Code

#Read in data
# First line sets what the base path that everything else contains is.
# Second line finds just those portions which contain whatever is in the quotation marks
# and retains them

# This starting with a . gives me a relative path based on the setwd;
# This one works with just the results; I will need to repeat with the initials.

# Pull Fitness from average.dat, not tasks.  Still want phenotypes.
# Might pull just final update from results and look at just the start (initial) and end (end of results); can care about trajectories later.
# Check number of skip lines from average.dat to make sure I skip the right number of rows at start of file.

print(getwd())

#dirs <- list.dirs(path = "./results", recursive=FALSE)
dirs <- list.dirs(path = "results", recursive=FALSE)
print(dirs)

#Make sure that files from same replicate get merged appropriately

# Take just the max update for each file; looking at just endpoints


# Take just the max update for each file; looking at just endpoints
results.data <- NULL #This section adapted from stackoverflow.com answer



for (d in dirs) {
	for (d2 in list.dirs(path = d, recursive = FALSE)){

		phenotype_file_path <- paste(d2, "data/phenotype_count.dat", sep = "/")    
		average_file_path <- paste(d2, "data/average.dat", sep = "/")
		task_file_path <- paste(d2, "data/tasks.dat", sep = "/" )

		if (file.exists(phenotype_file_path) & file.exists(average_file_path)){
    
			phenotypes <- read.csv(phenotype_file_path, header = F, sep = " ", na.strings = "", colClasses = "character", skip = 8)
			phenotypes[,1]<-as.numeric(as.character(phenotypes[,1]))

			fitness <- read.csv(average_file_path, header = F, sep = " ", na.strings = "", colClasses = "character", skip = 19)
			fitness[,1]<-as.numeric(as.character(fitness[,1]))

			wanted <- cbind(fitness[,1], fitness[,3], fitness[,4], fitness[,13])

			wanted[,1]<-as.numeric(as.character(wanted[,1]))
			wanted[,2]<-as.numeric(as.character(wanted[,2]))
			wanted[,3]<-as.numeric(as.character(wanted[,3]))
			wanted[,4]<-as.numeric(as.character(wanted[,4]))

			tasks <- read.csv(task_file_path, header = F, sep = " ", na.strings = "", colClasses = "character", skip = 19)

			wanted <-  cbind(wanted, tasks[,10])

			wanted[,5]<-as.numeric(as.character(wanted[,5]))

			fitness <- wanted

			colnames(fitness) <- c("Update", "Generation_length", "Fitness", "Generation", "EQU_evoled")

			colnames(phenotypes) <- c("Update", "Unique_Phenotypes_Task", "Shannon_Diversity", "Unique_Phenotype_Count", "Average.Phenotype.Diversity", "Average.Task.Diversity")

			dat <- merge(phenotypes, fitness, by = 1)

			current_path <- unlist(strsplit(d, split = "/", fixed = T))
			condition <- current_path[3]
			dat$AgeLimit <- as.numeric(as.character(unlist(strsplit(condition, split="_", fixed=T))[2]))

			seed <- current_path[4]
			dat$Seed <- as.numeric(as.character(seed))


			results.data <- rbind(results.data, dat)
			}
		}
	}

#Convert numeric type to numeric
results.data$Unique_Phenotypes_Task<-as.numeric(as.character(results.data$Unique_Phenotypes_Task))
results.data$Shannon_Diversity<-as.numeric(as.character(results.data$Shannon_Diversity))
results.data$Unique_Phenotype_Count<-as.numeric(as.character(results.data$Unique_Phenotype_Count))
results.data$Average_Phenotype_Diversity<-as.numeric(as.character(results.data$Average_Phenotype_Diversity))
results.data$Average_Task_Diversity<-as.numeric(as.character(results.data$Average_Task_Diversity))
results.data$Fitness<-as.numeric(as.character(results.data$Fitness))
results.data$Generation<-as.numeric(as.character(results.data$Generation))
results.data$Generation_length<-as.numeric(as.character(results.data$Generation_length))
results.data$EQU_evolved<-as.numeric(as.character(results.data$EQU_evolved))

write.csv(results.data, file="aging_experiment_1.csv")
