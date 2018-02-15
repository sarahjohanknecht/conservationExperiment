import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

data = pd.read_csv("Concatenated.Conservation.Data.Round.Two.Ecology.csv")
data_eco =[]
data_no_eco = []
length = len(data)
print(length)

for i in range(length):
    if data["Ecology"][i] == "Y":
        print(data.loc[i])


sns.boxplot(x=data["Patches"], y=data["Shannon.Diversity"])
#plt.show()

sns.boxplot(x=data["Patches"], y=data["Average.Task.Diversity"])
#plt.show()

sns.boxplot(x=data["Patches"], y=data["Average.Phenotype.Diversity"])
#plt.show()

sns.boxplot(x=data["Patches"], y=data["Unique.Phenotypes.Task"])
#plt.show()

sns.boxplot(x=data["Patches"], y=data["Unique.Phenotype.Count"])
#plt.show()