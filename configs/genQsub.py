#!/usr/bin/python
import argparse


def main():
    parser = argparse.ArgumentParser(description="Generate qsub file for MSU HPCC.")
    parser.add_argument("--time", default=24, type=int, help="Integer indicating number of hours to allocate for job")
    parser.add_argument("--mem", default="4gb", help="String indicating amount of memory to allocate. e.g. '4gb'")
    parser.add_argument("--start_seed", default=1, type=int, help="Int indicating which random seed to start from. All subsequent random seeds used willbe the next consecutive integers.")
    parser.add_argument("--reps", default=30, type=int, help="The number of replicates of each condition to run.")
    parser.add_argument("--path", default="~/avida/cbuild/work", help="Path to change directory to.")
    parser.add_argument("--events", default="~/avida/cbuild/work/events.cfg", help="The event file to use for the run (ignored if this isn't an Avida job)")
    parser.add_argument("--environment", default="~/avida/cbuild/work/environment.cfg", help="The environment file to use for the run (ignored if this isn't an Avida job)")
    parser.add_argument("--executable", default="~/avida/cbuild/work/avida", help="The executable file to use for the run")
    parser.add_argument("--config", default="~/avida/cbuild/work/avida.cfg", help="The config file to use for the run (ignored if this isn't an Avida job)")
    parser.add_argument("--data", default="~/expr", help="The prefix of the directory to store results in.")
    parser.add_argument("--name", default="avida", help="The prefix of the job name.")
    parser.add_argument("--suffix", action="append", help="Adds specified suffix to list of suffixes to use on the specified file.")
    parser.add_argument("--prefix", action="append", help="Adds file type to list to be suffixed.")
    
    parser.add_argument("--args", default = "", help="Additional command line arguments for job.")

    args = parser.parse_args()

    if args.prefix == None:
        args.prefix=[]

    print args.suffix
    for i in range(len(args.suffix)):
        suff = "-" + args.suffix[i]
        filename = args.name + suff + ".qsub"
        name = args.name + suff
        job_range = str(args.start_seed + i*args.reps ) + "-" + str(args.start_seed + i*args.reps + args.reps - 1)
        data = args.data + suff
        
        env = args.environment
        if "environment" in args.prefix:
            env += suff + ".cfg"
        
        events = args.events
        if "events" in args.prefix:
            events += suff + ".cfg"
        
        cfg = args.config
        if "config" in args.prefix:
            cfg += suff + ".cfg"
        
        make_file(filename, args.time, args.mem, name, job_range, args.path, args.executable, cfg, data, env, events, args.args)

def make_file(filename, time, mem, name, job_range, path, exe, config, data, env, event, args):
    outfile = open(filename, "w")
    outfile.write("#!/bin/bash -login\n\n")
    outfile.write("#PBS -l walltime=" + str(time) + ":00:00\n")
    outfile.write("#PBS -l nodes=1:ppn=1\n")
    outfile.write("#PBS -l mem=" + mem + "\n")
    outfile.write("#PBS -N " + name + "\n")
    outfile.write("#PBS -t " + job_range + "\n")
    
    outfile.write("\n")
    
    outfile.write("mkdir " + data + "\n")
    outfile.write("cd " + path + "\n\n")

    outfile.write(exe + " -c " + config + " -set RANDOM_SEED ${PBS_ARRAYID}")
    outfile.write(" -set DATA_DIR " + data +"/${PBS_ARRAYID}")
    outfile.write(" -set ENVIRONMENT_FILE " + env)
    outfile.write(" -set EVENT_FILE " + event + " ")
    outfile.write(args)

    outfile.close()

main()
