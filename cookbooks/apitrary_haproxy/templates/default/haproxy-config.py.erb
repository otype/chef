#!/usr/bin/python

# haproxy-config.py
# Copyright (c) 2008 Finnlabs
# written by Holger Just <h.just _at_ finn.de> 2008-09-11

# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation
# files (the "Software"), to deal in the Software without
# restriction, including without limitation the rights to use,
# copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
# HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.

import getopt
import os
import sys
import time

# The script expects the following directory structure. Note, that
# the toplevel directory names are fixed while the filenames and intermediate 
# directory names are not restricted at all.

# /
# |> global
#    | 00-base
#    | 10-log
#    | ...
# |> defaults
#    | 00-base
#    | 10-errorfiles
#    | ...
# |> frontends
#    |> 00-my-first-frontend
#       | 00-ports
#       | 10-acls
#       | 20-backend1
#       | 21-backend2
#    |> 10-my-second-frontend
#       | ...
# |> listen
#    |> 00-sect1
#       | 00-base
#       | 10-backend1
#    |> 10-sect2
#       ...
# |> backends
#    |> 00-my-first-backend
#       | 00-base
#       | 10-server1
#       | 11-server2
#    |> 10-my-second-backend
#       | ...


def print_usage(program):
    print "\nThis program creates a HAProxy configuration file from a fixed"
    print "directory structure. See the comments of this script for details!"
    print ""
    print "Usage: %s [-c config_dir] [-o output_file]" % program
    print ""
    print "config_dir  defaults to /etc/haproxy"
    print "output_file defaults to /etc/haproxy/haproxy.cfg"

def exit_with_usage(program):
    print_usage(program)
    sys.exit(2)

def create_config(config_dir, output_file):
    output = open (output_file, 'w')
    
    output.write("# Configuration file for HAProxy\n")
    output.write("#\n")
    output.write("# This file is generated. All changes are overwritten!\n")
    output.write("# Generated on %s\n" % time.ctime(time.time()) )
    
    simple_types = ["global", "defaults"]
    # Simple types are all configuration directives without sub directories
    for t in simple_types:
        try:
            file_list = os.listdir(os.path.join(config_dir, t))
        except:
            file_list = []
        
        file_list.sort()
        if file_list:
            output.write(t)
        
        for fname in file_list:
            output.write("\n\t## %s\n" % fname)
            
            f = open( os.path.join(config_dir, t, fname) )
            for line in f:
                output.write("\t%s" %  line)
            f.close()
    
    complex_types = ["listen", "frontend", "backend"]
    # the other configuration directives use sub directories to split up
    # the building blocks
    for t in complex_types:
        if t not in ("listen"):
            # Notice the difference between haproxy and directory naming:
            #   HAPROXY     DIRECTORY
            #   backend     /backends
            #   frontend    /frontends
            #  (listen ist the same on both)
            tdir = os.path.join(config_dir, "%ss" % t)
        else:
            tdir = os.path.join(config_dir, t)
        try:
            section_list = os.listdir(tdir)
        except:
            section_list = []
        
        section_list.sort()
        for section in section_list:
            try:
                file_list = os.listdir(os.path.join(tdir, section))
            except:
                file_list = []
            
            file_list.sort()
            if file_list:
                # create new section
                # use the name of the respective directory as the section name
                output.write("%s %s\n" % (t, section))
            
            for fname in file_list:
                output.write("\t## %s\n" % fname)
                
                f = open( os.path.join(tdir, section, fname) )
                for line in f:
                    output.write("\t%s" % line)
                f.close()
    
    # Clean up
    output.flush()
    output.close()

def main():
    config_dir = "/etc/haproxy"
    output_file = config_dir + "/haproxy.cfg"
    
    # parse command line arguments
    try:
        opts,args = getopt.getopt(sys.argv[1:], "c:o:", ["help"])
    except getopt.GetoptError, err:
        print str(err) # will print somthing like option -a not recognized"
        exit_with_usage(sys.argv[0])
    
    if args:
        # no args allowed
        exit_with_usage(sys.argv[0])

    for o, a in opts:
        if o == "-c":
            config_dir = a
        elif o == "-o":
            output_file = a
        else:
            exit_with_usage(sys.argv[0])
    
    create_config(config_dir, output_file)
    sys.exit(0)

if __name__ == "__main__":
    main()
