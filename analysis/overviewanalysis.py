import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

data = pd.read_csv("all_data_100000_patches.csv")

#data at 100,000 updates in non-ecology mode
dataNoEco = data[data.loc[:,"ecology"]== "N" ]

#data at 100,000 updates in ecology mode
dataEco = data[data.loc[:, "ecology"]==  "Y" ]

#Patches x Shannon Diversity
#sns.boxplot(x=data["Patches"], y=data["Shannon.Diversity"])
plot = sns.boxplot(x=dataEco["patches"], y=dataEco["shannondiv"])
plot.set( xlabel = 'Patches', ylabel = 'Shannon Diversity By Task Done')
plt.show()


#Patches x Average task Diversity
#sns.boxplot(x=data["Patches"], y=data["Average.Task.Diversity"])
sns.boxplot(x=dataEco["patches"], y=dataEco["avgtaskdiv"])
plt.show()

#Patches x Average Shannon Diversity
#sns.boxplot(x=data["Patches"], y=data["Average.Phenotype.Diversity"])
plot = sns.boxplot(x=dataEco["patches"], y=dataEco["avgshannondiv"])
plot.set(xlabel='Patches', ylabel = 'Average Shannon Diversity')
plt.show()

plot = sns.boxplot(x=dataEco["patches"], y=dataEco["avgshannondiv"])
plot.set(xlabel='Patches', ylabel = 'Average Shannon Diversity')
plt.show()

#Patches x Unqiue Phenotypes Task
#sns.boxplot(x=data["Patches"], y=data["Unique.Phenotypes.Task"])
sns.boxplot(x=dataEco["patches"], y=dataEco["uniquephenotypetask"])
plt.show()

#Patches x Unique Phenotype Count
#sns.boxplot(x=data["Patches"], y=data["Unique.Phenotype.Count"])
sns.boxplot(x=dataEco["patches"], y=dataEco["uniquephenotypecount"])
plt.show()
