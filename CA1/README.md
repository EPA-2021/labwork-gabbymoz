created a dir called CA1 using mkdir CA1
created the files process.sh, proc_count.sh and docker using vi <filename> 
to allow permissions to read and write to this file use chmod 777

docker file:
FROM ubuntu:latest 

WORKDIR /labwork-gabbymoz/CA1 (specify working directory)

COPY proc_count.sh . (copy to container)

RUN chmod u+x /labwork-gabbymoz/CA1/proc_count.sh (allow permissions)

CMD ["/labwork-gabbymoz/CA1/proc_count.sh"] (run the file)

proc_count file:
#!/bin/bash 
cnt = `more /proc/cpuinfo |grep”processor”| wc -l`
echo $cnt



cnt =`more /proc/cpuinfo |grep”processor”| wc -l
more - views the text of the file
/proc/cpuinfo - is where the processor information is stored
wc -l - is the word count

echo $cnt

to build a docker container:
-docker build .
docker images to get the docker image ID (a3eb017240fd - image ID)
docker run a3eb017240fd

docker push the image:
eu.gcr.io/epa-labs-2021/cpuvirt:latest


