import pandas as pd

#get a file of only 100,000th updates
df = pd.read_csv("all_data.csv")
data_file_open = open("all_data_100000.csv", "w")
data_file_open.write( (df.loc[df['update'] == 100000]).to_csv())
data_file_open.close()
