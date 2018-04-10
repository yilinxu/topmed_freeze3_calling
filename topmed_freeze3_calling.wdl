workflow TopMedVariantCaller {

  Array[File] input_cram_files

  call downloadReferenceFiles

  call sumCRAMSizes {
    input:
      input_crams = input_cram_files,
      downloadReferenceFilesOK = downloadReferenceFiles.outputFile

  }

  call constructIndexFile {
    input:
      disk_size = sumCRAMSizes.total_size,
      input_crams = input_cram_files

  }

  call variantDiscoveryAndConsolidation {
     input:
      disk_size = sumCRAMSizes.total_size,
      indexFileConstructedOK = constructIndexFile.constructIndexFileOK,
      indexFile = constructIndexFile.outputIndexFile,
      PEDFile = constructIndexFile.outputPEDFile
  }

  call jointGenotyping {
    input:
      disk_size = sumCRAMSizes.total_size,
      variantDiscoveryAndConsolidationOutput = variantDiscoveryAndConsolidation.variantDiscoveryAndConsolidationOutput
  }
}

  task downloadReferenceFiles {
    command {
      set -o pipefail
      set -e

      if [[ ! -d "data/local.org/ref/gotcloud.ref/hg38" ]] || [[ -z "$(ls -A data/local.org/ref/gotcloud.ref/hg38)" ]]
      then
        echo "Reference files not found; downloading them now"
        wget ftp://share.sph.umich.edu/gotcloud/ref/hs38DH-db142-v1.tgz    
        tar xzvf hs38DH-db142-v1.tgz
        rm hs38DH-db142-v1.tgz
      else
        echo "Reference files found"
      fi

      echo "Reference files installed OK" > "downloadReferenceFilesOK.txt"
    }
    output {
      File outputFile = "downloadReferenceFilesOK.txt"
    }
    runtime {
      memory: "10 GB"
      cpu: "16"
      #disks: "local-disk " + sub(disk_size, "\\..*", "") + " HDD"
      zones: "us-central1-a us-central1-b us-east1-d us-central1-c us-central1-f us-east1-c"
      docker: "quay.io/wshands/topmed_freeze3_calling:latest"
    }
  }


  task sumCRAMSizes {
    Array[File] input_crams
    File downloadReferenceFilesOK

    command {
      python <<CODE
      import os
      import functools

      cram_string = "${ sep=',' input_crams }"
      cram_list = cram_string.split(',')
      crams_size = functools.reduce((lambda x, y: os.stat(x).st_size + os.stat(y).st_size), cram_list)
      print crams_size
      CODE
    }
    runtime {
      memory: "10 GB"
      cpu: "16"
      #disks: "local-disk " + sub(disk_size, "\\..*", "") + " HDD"
      zones: "us-central1-a us-central1-b us-east1-d us-central1-c us-central1-f us-east1-c"
      docker: "quay.io/wshands/topmed_freeze3_calling:latest"
    }
    output {
      String total_size = read_string(stdout())
    }
  }

  
  task constructIndexFile {
    Array[File] input_crams
    String disk_size

    command {
      python <<CODE

      from __future__ import print_function
      import csv
      import os
      
      cram_string = "${ sep=',' input_crams }"
      crams_list = cram_string.split(',')
      
      tsv_crams_rows = []
      for cram_file in crams_list:
          base_name = os.path.basename(cram_file)
          base_name_wo_extension = base_name.split('.')[0]
          tsv_crams_rows.append([base_name_wo_extension, cram_file, '0.000'])

      # Remove the old PED file; we will not use a PED file?
      open('TopMed_open_access_files.ped', 'w+').close()
      #open('/root/topmed_freeze3_calling/data/TopMed_open_access_files.ped', 'w+').close()

      with open('TopMed_open_access_files.index', 'w+') as tsv_index_file:
      #with open('/root/topmed_freeze3_calling/data/TopMed_open_access_files.index', 'w+') as tsv_index_file:
          writer = csv.writer(tsv_index_file, delimiter = '\t')
          for cram_info in tsv_crams_rows:
              writer.writerow(cram_info)

      with open('constructIndexFileOutputOK.txt', 'w+') as index_file_OK:
          print("Index and PED file constructed", index_file_OK)

      CODE
    }
    output {
      File constructIndexFileOK = "constructIndexFileOutputOK.txt"
      File outputIndexFile = "TopMed_open_access_files.index"
      File outputPEDFile = "TopMed_open_access_files.ped"
    }
    runtime {
      memory: "10 GB"
      cpu: "16"
      disks: "local-disk " + sub(disk_size, "\\..*", "") + " HDD"
      zones: "us-central1-a us-central1-b us-east1-d us-central1-c us-central1-f us-east1-c"
      docker: "quay.io/wshands/topmed_freeze3_calling:latest"
    }
  }

  task variantDiscoveryAndConsolidation {
     String disk_size
     File indexFile
     File PEDFile
     File indexFileConstructedOK

    command {
      set -o pipefail
      set -e

      cd /root/topmed_freeze3_calling
      cp ${indexFile} /root/topmed_freeze3_calling/data/TopMed_open_access_files.index
      cp ${PEDFile} /root/topmed_freeze3_calling/data/TopMed_open_access_files.ped
      WORKING_DIR='out'
      echo "Running step1 - detect and merge variants"
      echo "Running step1 - detect and merge variants - removing old output dir if it exists"
      if [ -d "$WORKING_DIR" ]; then rm -Rf "$WORKING_DIR"; fi
      echo "Running step1 - detect and merge variants - generating Makefile"
      perl scripts/step1-detect-and-merge-variants.pl $(seq 1 22 | xargs -n 1 -I% echo chr%) chrX
      echo "Running step1 - detect and merge variants - running Makefile"
      make SHELL='/bin/bash' -f 'out/aux/Makefile' -j 22
      echo "Variant discovery and consolidation OK" > "variantDiscoveryAndConsolidationOK.txt"
    }
     output {
      File variantDiscoveryAndConsolidationOutput = "variantDiscoveryAndConsolidationOK.txt"
    }
   runtime {
      memory: "10 GB"
      cpu: "16"
      disks: "local-disk " + sub(disk_size, "\\..*", "") + " HDD"
      zones: "us-central1-a us-central1-b us-east1-d us-central1-c us-central1-f us-east1-c"
      docker: "quay.io/wshands/topmed_freeze3_calling:latest"
    }
  }

  task jointGenotyping {
    String disk_size
    File variantDiscoveryAndConsolidationOutput

    command {
      set -o pipefail
      set -e

      cd /root/topmed_freeze3_calling
      WORKING_DIR='out'
      echo "Running step2 - joing genotyping"
      echo "Running step2 - joing genotyping - removing old output dir if it exists"
      if [ -d "$WORKING_DIR"/paste ]; then rm -Rf "$WORKING_DIR"/paste; fi
      echo "Running step2 - joing genotyping - generating Makefile"
      perl scripts/step2-joint-genotyping.pl $(seq 1 22 | xargs -n 1 -I% echo chr%) chrX
      echo "Running step2 - joing genotyping - running Makefile"
      MAKEFILE_NAME="chrchr"$(seq -s '_chr' 1 22)".Makefile"
      make SHELL='/bin/bash' -f "$WORKING_DIR"/paste/"$MAKEFILE_NAME" -j 22

    }
    runtime {
      memory: "10 GB"
      cpu: "16"
      disks: "local-disk " + sub(disk_size, "\\..*", "") + " HDD"
      zones: "us-central1-a us-central1-b us-east1-d us-central1-c us-central1-f us-east1-c"
      docker: "quay.io/wshands/topmed_freeze3_calling:latest"
    }
  }

