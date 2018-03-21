import glob
import sys
import pandas as pd


frames = []

for res_dir in glob.glob(sys.argv[1]):
    print(res_dir)
    avg_data = pd.read_csv(res_dir+"/average.dat", delimiter= " ", skiprows=19, header=None, names = ["update","merit", "gestation", "fitness", "repro_rate", "dep_size", "copied_size", "executed_size", "dep_abundance", "prop_birth", "breed_true", "dep_depth", "generation", "neutral", "label", "true_rep_rate"], index_col=False)
    task_data = pd.read_csv(res_dir+"/tasks.dat", delimiter= " ", header=None, skiprows=15, names=["update","not","nand","and","orn","or","andn","nor","xor","equ" ], index_col=False)
    resource_data = pd.read_csv(res_dir+"/resource.dat", delimiter= " ", header=None, skiprows=16, names=["update","resnot", "resand", "resor", "resnor", "resnand", "resorn","resandn","resxor","resequ", "safe"], index_col=False)
    count_data = pd.read_csv(res_dir+"/count.dat", delimiter= " ", header=None, skiprows=19, names=["update","inst_executed","popsize","genotypecount","thresholdgenotypes","numspecies","numthresholdspecies","numlineages","numbirths","numdeaths", "numbreedtrue", "numbreedtrue2", "numnobirth", "numsinglethreaded", "nummultithreaded", "nummodified"], index_col=False)
    phenotype_data = pd.read_csv(res_dir+"/phenotype_count.dat", delimiter= " ", header=None, skiprows=8, names=["update","uniquephenotypetask","shannondiv","uniquephenotypecount","avgshannondiv","avgtaskdiv"], index_col=False)
    task_data = task_data.set_index("update")
    resource_data = resource_data.set_index("update")
    avg_data = avg_data.set_index("update")
    count_data = count_data.set_index("update")
    phenotype_data = phenotype_data.set_index("update")

    all_data = pd.concat([avg_data, task_data,resource_data, count_data, phenotype_data],axis=1)

    #get seed, condition (directory name), number of patches, and number killed
    all_data["seed"] = res_dir.split("/")[-2].split("_")[-1]
    all_data["condition"] = res_dir
    all_data["patches"]= res_dir.split("/")[-2].split("_")[0]
    all_data["killed"]=res_dir.split("/")[-2].split("_")[4]

    #get whether ecology or not
    if(res_dir.split("/")[-2].split("_")[-2][0:3] == "eco"):
        all_data["ecology"] = 'Y'

    else:
        all_data["ecology"] = 'N'

    frames.append(all_data)

all_data = pd.concat(frames)

all_data.to_csv("all_data_test.csv")
