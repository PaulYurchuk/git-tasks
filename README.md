# git-tasks
##  Git-Jenkins task from Alah Tsuranau and Artiom Aksionkin
Task contains **vagrantfile** which implements next steps:

  +Configuration of VM

  +Provisioning script:

    +a) Jenkins installed to folder /opt/jenkins/
    +b) Server should be run under ‘jenkins’ user and started from init script as service
    +c) JENKINS_HOME=/opt/jenkins/master
    +d) JENKINS_DIR=/opt/jenkins/bin  ( <- .war is here)
    +e) Closed by Nginx and available by link http://jenkins

Additionaly illustrated *below*


 ![alt text](https://github.com/MNT-Lab/git-tasks/blob/atsuranau-aaksionkin/imgpsh_fullsize.jpg)
