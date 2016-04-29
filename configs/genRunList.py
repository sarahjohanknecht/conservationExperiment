seed_start = 9000
reps = 10
pops = list(range(1,11))
command = "./avida -s $seed -set ENVIRONMENT_FILE {0} -set EVENT_FILE {1} -set BIRTH_METHOD 11 -set DISPERSAL_RATE 1 -set COPY_MUT_PROB 0.0025"
kill_rates = [100, 200, 300, 400, 500]
ecology = [True, False]
environment = ['configs/conservation-100patches_3each-environment.cfg', 'configs/conservation-1patches_30each-environment.cfg', 'configs/conservation-225patches_2each-environment.cfg', 'configs/conservation-25patches_6each-environment.cfg', 'configs/conservation-36patches_5each-environment.cfg', 'configs/conservation-4patches_15each-environment.cfg', 'configs/conservation-900patches_1each-environment.cfg', 'configs/conservation-9patches_10each-environment.cfg']

out_file = open("run_list", "w")

out_file.write("set description conservation\nset email dolsonem@msu.edu\nset email_when final\nset class_pref 95\nset walltime 4\nset mem_request 4\nset config_dir configs\nset dest_dir /mnt/home/dolsonem/conservation/round_3_results\n\n")

for env in environment:
    for kill in kill_rates:
        for pop in pops:
            for eco in ecology:
                eventsfile = "conservation-events-"
                if eco:
                    eventsfile += "experiment-eco"
                eventsfile += "kill" + str(kill) + "-pop" + str(pop) + ".cfg"
                seeds = str(seed_start) + ".." + str(seed_start+reps-1)
                seed_start += reps
                name = env.split("-")[-2]
                name = name.split("_")
                name = [w.strip("patches") for w in name]
                name = name[0] + "_patches_" + name[1] + "_cells_"
                name += str(kill) + "_killed"
                if eco:
                    name += "_ecology"
                name += "-pop"+str(pop)
                out_file.write(seeds + " " + name + " " + command.format(env.split("/")[-1], eventsfile)+"\n")

out_file.close()
