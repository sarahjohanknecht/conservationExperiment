# Set my working directory to put things in the right place

#setwd("/Users/mmgdepartment/Desktop/Conservation_9-25-2015")

setwd("~/conservation/scripts")

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
#dirs <- list.dirs(path = "../round_2_results", recursive=FALSE)
dirs <- list.dirs(path = ".", recursive=FALSE)
print(dirs)

#Make sure that files from same replicate get merged appropriately

# Take just the max update for each file; looking at just endpoints


# Take just the max update for each file; looking at just endpoints
results.data <- NULL #This section adapted from stackoverflow.com answer



for (d in dirs) {
	for (d2 in list.dirs(path = d, recursive = FALSE)){

		phenotype_file_path <- paste(d2, "phenotype_count.dat", sep = "/")
		average_file_path <- paste(d2, "average.dat", sep = "/")
		count_file_path <- paste(d2, "count.dat", sep = "/" )

		if (file.exists(phenotype_file_path) & file.exists(average_file_path)){

			phenotypes <- read.csv(phenotype_file_path, header = F, sep = " ", na.strings = "", colClasses = "character", skip = 8)
			phenotypes[,1]<-as.numeric(as.character(phenotypes[,1]))
			max.update.phenotype<-max(phenotypes[,1])

			phenotypes<-subset(phenotypes, phenotypes[,1]==max.update.phenotype)



			fitness <- read.csv(average_file_path, header = F, sep = " ", na.strings = "", colClasses = "character", skip = 19)
			fitness[,1]<-as.numeric(as.character(fitness[,1]))
			max.update.fitness<-max(fitness[,1])
			fitness<-subset(fitness, fitness[,1]==max.update.fitness)

			wanted <- cbind(fitness[,1], fitness[,4], fitness[,13])

			wanted[,1]<-as.numeric(as.character(wanted[,1]))
			wanted[,2]<-as.numeric(as.character(wanted[,2]))
			wanted[,3]<-as.numeric(as.character(wanted[,3]))

			counts <- read.csv(count_file_path, header = F, sep = " ", na.strings = "", colClasses = "character", skip = 19)

			wanted <-  cbind(wanted, counts[,3], counts[,4])

			wanted[,4]<-as.numeric(as.character(wanted[,4]))
			wanted[,5]<-as.numeric(as.character(wanted[,5]))

			fitness <- wanted

			colnames(fitness) <- c("Update", "Fitness", "Generation", "Pop.Size", "Unique.Genotypes")

			colnames(phenotypes) <- c("Update", "Unique.Phenotypes.Task", "Shannon.Diversity", "Unique.Phenotype.Count", "Average.Phenotype.Diversity", "Average.Task.Diversity")

			dat <- merge(phenotypes, fitness, by = 1)

			dat$Condition <- tail(unlist(strsplit(d, split = "/", fixed = T)), n=1)

			dat$Killed <- as.numeric(unlist(regmatches(dat$Condition, gregexpr('\\d+(?=_killed)', dat$Condition , perl=T))))

			dat$Patches <- 0

			if (as.numeric(unlist(gregexpr('patch', dat$Condition , perl=T)))>0) {
				dat$Patches <- as.numeric(unlist(regmatches(dat$Condition, gregexpr('\\d+(?=_patch)', dat$Condition , perl=T))))
				}

			dat$Ecology <- "N"

			if (as.numeric(unlist(gregexpr('ecology', dat$Condition , perl=T)))>0) {
				dat$Ecology <- "Y"
				}


			full.string <- tail(unlist(strsplit(d, split = "/", fixed = T)), n=1)

			seed <- tail(unlist(strsplit(full.string, split = "_", fixed = T)), n=1)


			foo <- tail(unlist(strsplit(d, split = "/", fixed = T)), n=1)
			blah <- tail(unlist(strsplit(foo, split = "-", fixed = T)), n=1)
			initial.pop <- head(unlist(strsplit(blah, split = "_", fixed = T)), n=1)

			dat$Initial.Pop<-initial.pop
			dat$Seed <- as.numeric(as.character(seed))


			results.data <- rbind(results.data, dat)
			}
		}
	}


dirs <- list.dirs(path = "/mnt/home/dolsonem/conservation/round_2_results", recursive=FALSE)

#Make sure that files from same replicate get merged appropriately

# Take just the max update for each file; looking at just endpoints


# Take just the max update for each file; looking at just endpoints



for (d in dirs) {
	for (d2 in list.dirs(path = d, recursive = FALSE)){

		phenotype_file_path <- paste(d2, "phenotype_count.dat", sep = "/")
		average_file_path <- paste(d2, "average.dat", sep = "/")
		count_file_path <- paste(d2, "count.dat", sep = "/")

		if (file.exists(phenotype_file_path) & file.exists(average_file_path)){

			phenotypes <- read.csv(phenotype_file_path, header = F, sep = " ", na.strings = "", colClasses = "character", skip = 8)
			phenotypes[,1]<-as.numeric(as.character(phenotypes[,1]))
			max.update.phenotype<-max(phenotypes[,1])

			phenotypes<-subset(phenotypes, phenotypes[,1]==max.update.phenotype)

                        counts <- read.csv(count_file_path, header = F, sep = " ", na.strings = "", colClasses = "character", skip = 19)


			fitness <- read.csv(average_file_path, header = F, sep = " ", na.strings = "", colClasses = "character", skip = 19)
			fitness[,1]<-as.numeric(as.character(fitness[,1]))
			max.update.fitness<-max(fitness[,1])
			fitness<-subset(fitness, fitness[,1]==max.update.fitness)

			wanted <- cbind(fitness[,1], fitness[,4], fitness[,13])

			wanted[,1]<-as.numeric(as.character(wanted[,1]))
			wanted[,2]<-as.numeric(as.character(wanted[,2]))
			wanted[,3]<-as.numeric(as.character(wanted[,3]))

			wanted < cbind(wanted, counts[,3], counts[,4]

			wanted[,4]<-as.numeric(as.character(wanted[,4]))
			wanted[,5]<-as.numeric(as.character(wanted[,5]))

			fitness <- wanted

			colnames(fitness) <- c("Update", "Fitness", "Generation", "Pop.Size", "Unique.Genotypes")

			colnames(phenotypes) <- c("Update", "Unique.Phenotypes.Task", "Shannon.Diversity", "Unique.Phenotype.Count", "Average.Phenotype.Diversity", "Average.Task.Diversity")

			dat <- merge(phenotypes, fitness, by = 1)

			dat$Condition <- tail(unlist(strsplit(d, split = "/", fixed = T)), n=1)

			dat$Killed <- as.numeric(unlist(regmatches(dat$Condition, gregexpr('\\d+(?=_killed)', dat$Condition , perl=T))))

			dat$Patches <- 0

			if (as.numeric(unlist(gregexpr('patch', dat$Condition , perl=T)))>0) {
				dat$Patches <- as.numeric(unlist(regmatches(dat$Condition, gregexpr('\\d+(?=_patch)', dat$Condition , perl=T))))
				}

			dat$Ecology <- "N"

			if (as.numeric(unlist(gregexpr('ecology', dat$Condition , perl=T)))>0) {
				dat$Ecology <- "Y"
				}


			full.string <- tail(unlist(strsplit(d, split = "/", fixed = T)), n=1)

			seed <- tail(unlist(strsplit(full.string, split = "_", fixed = T)), n=1)


			foo <- tail(unlist(strsplit(d, split = "/", fixed = T)), n=1)
			blah <- tail(unlist(strsplit(foo, split = "-", fixed = T)), n=1)
			initial.pop <- head(unlist(strsplit(blah, split = "_", fixed = T)), n=1)

			dat$Initial.Pop<-initial.pop
			dat$Seed <- as.numeric(as.character(seed))


			results.data <- rbind(results.data, dat)
			}
		}
	}





backup.results.data<-results.data

results.data<-backup.results.data

#Include factors as factors
results.data$Condition<-factor(results.data$Condition)
results.data$Ecology<-factor(results.data$Ecology)
results.data$Initial.Pop<-factor(results.data$Initial.Pop)


#Convert numeric type to numeric
results.data$Unique.Phenotypes.Task<-as.numeric(as.character(results.data$Unique.Phenotypes.Task))
results.data$Shannon.Diversity<-as.numeric(as.character(results.data$Shannon.Diversity))
results.data$Unique.Phenotype.Count<-as.numeric(as.character(results.data$Unique.Phenotype.Count))
results.data$Average.Phenotype.Diversity<-as.numeric(as.character(results.data$Average.Phenotype.Diversity))
results.data$Average.Task.Diversity<-as.numeric(as.character(results.data$Average.Task.Diversity))
results.data$Fitness<-as.numeric(as.character(results.data$Fitness))
results.data$Generation<-as.numeric(as.character(results.data$Generation))
results.data$Unique.Genotypes<-as.numeric(as.character(results.data$Unique.Genotypes))
results.data$Pop.Size<-as.numeric(as.character(results.data$Pop.Size))




# Write these results to a data file.

write.csv(results.data, file="Concatenated.Conservation.Data.Round.Two.csv")
