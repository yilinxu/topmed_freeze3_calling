workflow TopMedVariantCaller {

  Array[File] input_cram_files

  call downloadReferenceFiles {

  }

  call sumCRAMSizes {
    input:
      input_crams = input_cram_files

  }

  call constructIndexFile {
    input:
      input_crams = input_cram_files
      disk_size = sumCRAMSizes.total_size

  }

  call variantDiscoveryAndConsolidation {
      
  }

  call jointGenotyping {

  }

  task downloadReferenceFiles {
    command {
      if [[ ! -d "data/local.org/ref/gotcloud.ref/hg38" ]] || [[ -z "$(ls -A data/local.org/ref/gotcloud.ref/hg38)" ]]
      then
        echo "Reference files not found; downloading them now"
        wget ftp://share.sph.umich.edu/gotcloud/ref/hs38DH-db142-v1.tgz    
        tar xzvf hs38DH-db142-v1.tgz
        rm hs38DH-db142-v1.tgz
      else
          echo "Reference files found"
      fi
    }
    runtime {
      memory: "1 GB"
    }
  }    


  task sumCRAMSizes {
    Array[File] input_crams

    command {
      python <<CODE
        import os
        # for reduce
        import functools

        cram_string = "${ sep=',' $(input_crams) }
        cram_list = cram_string.split(',')
        crams_size = functools.reduce((lambda x, y: os.stat(x).st_size + os.stat(y).st_size), cram_list)
        #print("total size:{}".format(crams_size))
      CODE
    }
    runtime {
      memory: "7 GB"
    }
    output {
      Int total_size = crams_size
  }

  
  task constructIndexFile {
    Array[File] input_crams

    command {
      python <<CODE

        import csv
        import os
        
        cram_string = "${ sep=',' $(input_crams) }
        crams_list = cram_string.split(',')
        
        tsv_crams_rows = []
        for cram_file in crams_list:
            base_name = os.path.basename(cram_file)
            base_name_wo_extension = base_name.split('.')[0]
            tsv_crams_rows.append([base_name_wo_extension, cram_file, '0.000'])
        
        # Remove the old PED file; we will not use a PED file?
        open('data/trio_data.ped.test', 'w').close()
        
        with open('data/trio_data.index.test', 'w') as tsv_index_file:
            writer = csv.writer(tsv_index_file, delimiter = '\t')
            for cram_info in tsv_crams_rows:
                writer.writerow(cram_info)

      CODE
    }
    runtime {
      memory: "7 GB"
    }

  }

  task variantDiscoveryAndConsolidation {

    command {

      WORKING_DIR='out'
      echo "Running step1 - detect and merge variants"
      echo "Running step1 - detect and merge variants - removing old output dir if it exists"
      if [ -d "${WORKING_DIR}" ]; then rm -Rf "${WORKING_DIR}"; fi
      echo "Running step1 - detect and merge variants - generating Makefile"
      perl scripts/step1-detect-and-merge-variants.pl $(seq 1 22 | xargs -n 1 -I% echo chr%)
      echo "Running step1 - detect and merge variants - running Makefile"
      make SHELL='/bin/bash' -f 'out/aux/Makefile' -j 22

    }

  }

  task jointGenotyping {

    command {
      WORKING_DIR='out'
      echo "Running step2 - joing genotyping"
      echo "Running step2 - joing genotyping - removing old output dir if it exists"
      if [ -d "${WORKING_DIR}"/paste ]; then rm -Rf "${WORKING_DIR}"/paste; fi
      echo "Running step2 - joing genotyping - generating Makefile"
      perl scripts/step2-joint-genotyping.pl $(seq 1 22 | xargs -n 1 -I% echo chr%)
      echo "Running step2 - joing genotyping - running Makefile"
      MAKEFILE_NAME="chrchr"$(seq -s '_chr' 1 22)".Makefile"
      make SHELL='/bin/bash' -f "${WORKING_DIR}"/paste/"${MAKEFILE_NAME}" -j 22

    }

  }

}

























}
