import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

data = pd.read_csv("all_data_100000_patches.csv")


#Patches x Shannon Diversity
#sns.boxplot(x=data["Patches"], y=data["Shannon.Diversity"])
sns.boxplot(x=data["patches"], y=data["shannondiv"])
plt.show()

#Patches x Average task Diversity
#sns.boxplot(x=data["Patches"], y=data["Average.Task.Diversity"])
sns.boxplot(x=data["patches"], y=data["avgtaskdiv"])
plt.show()

#Patches x Average Shannon Diversity
#sns.boxplot(x=data["Patches"], y=data["Average.Phenotype.Diversity"])
sns.boxplot(x=data["patches"], y=data["avgshannondiv"])
plt.show()

#Patches x Unqiue Phenotypes Task
#sns.boxplot(x=data["Patches"], y=data["Unique.Phenotypes.Task"])
sns.boxplot(x=data["patches"], y=data["uniquephenotypetask"])
plt.show()

#Patches x Unique Phenotype Count
#sns.boxplot(x=data["Patches"], y=data["Unique.Phenotype.Count"])
sns.boxplot(x=data["patches"], y=data["uniquephenotypecount"])
plt.show()
