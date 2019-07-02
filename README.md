<h1> CWL-Docker NGS analysis pipeline </h1>
<h2> Introduction </h2>

A NGS analysis pipeline to analyse Illumina PE sequencing data. The pipeline is co-ordinated by the CWL specification. The CWL workflow pull images from Dockerhub and runs NGS analysis tools within independent Docker containers. The NGS analysis pipeline includes the following tools: Fastqc, Trimmomatic and BWA.

<h2> Dependencies </h2>

1. Docker CE edition (version 18.06.1-ce )
1. cwltool (version 1.0.2)
1. Python 3 (version 3.7)

<h2> Pre-requisites </h2>

1. Clone this repository- https://github.com/DanEgan93/cwl_docker_pipeline_iteration_1.git

<h2> Running CWL-Docker pipeline </h2>

1. Change directory into directory containing FASTQ samples to be analysed.
1. Manually enter sample names into universal_PE_job.yml.
1. run command (replacing {} with  location of cloned repository}:
    * cwltool {cwl_docker_ngs_pipeline/iteration_1}/universal_PE_workflow.cwl {cwl_docker_ngs_pipeline/iteration_1}/universal_PE_job.yml
1. Check output directory for expected pipeline output.
