#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

requirements:
  InitialWorkDirRequirement:
    listing:
     - $(inputs.fastq_forward)
     - $(inputs.fastq_reverse)
     - $(inputs.adapter_clip)
  InlineJavascriptRequirement: {}

hints:
  DockerRequirement:
    dockerImageId: trimmomatic:latest

## TODO- move PE and -phred33 into inputs section
baseCommand: [java, -jar, /usr/local/pipeline/Trimmomatic-0.38/trimmomatic-0.38.jar, PE, -phred33]


inputs:
  fastq_forward:
    type: File
    inputBinding:
      valueFrom: $(self.basename)
      position: 1
  fastq_reverse:
    type: File
    inputBinding:
      valueFrom: $(self.basename)
      position: 2
  adapter_clip:
    type: File
    inputBinding:
      valueFrom: $(self.path+':0:95:95')
      prefix: 'ILLUMINACLIP:'
      separate: False
      position: 7
  crop_def:
    type: string
    default: '150'
    inputBinding:
      prefix: 'CROP:'
      separate: False
      position: 8
  sliding_window:
    type: string
    default: '4:20'
    inputBinding:
      prefix: 'SLIDINGWINDOW:'
      separate: False
      position: 9
  minlen:
    type: string
    default: '50'
    inputBinding:
      prefix: 'MINLEN:'
      separate: False
      position: 10

arguments:
  - valueFrom: $(inputs.fastq_forward.nameroot.split('.fastq')[0]+'.qfilter.fastq.gz')
    position: 3
  - valueFrom: $(inputs.fastq_forward.nameroot.split('.fastq')[0]+'.unpaired.fastq.gz')
    position: 4
  - valueFrom: $(inputs.fastq_reverse.nameroot.split('.fastq')[0]+'.qfilter.fastq.gz')
    position: 5
  - valueFrom: $(inputs.fastq_reverse.nameroot.split('.fastq')[0]+'.unpaired.fastq.gz')
    position: 6


outputs:
  forward_u_filter_file: 
    type: File
    outputBinding: 
      glob: $(inputs.fastq_forward.nameroot.split('.fastq')[0] + '.unpaired.fastq.gz')
  forward_q_filter_file:
    type: File
    outputBinding: 
      glob: $(inputs.fastq_forward.nameroot.split('.fastq')[0] + '.qfilter.fastq.gz')
  reverse_u_filter_file: 
    type: File
    outputBinding:
      glob: $(inputs.fastq_reverse.nameroot.split('.fastq')[0] + '.unpaired.fastq.gz')
  reverse_q_filter_file:
    type: File
    outputBinding: 
      glob: $(inputs.fastq_reverse.nameroot.split('.fastq')[0] + '.qfilter.fastq.gz')
  log_file_stdout:
    type: stdout
  log_file_stderr:
    type: stderr

stdout: trimmomatic_stdout.txt
stderr: trimmomatic_stderr.txt 