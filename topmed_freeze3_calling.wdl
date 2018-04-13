workflow TopMedVariantCaller {

  Array[File] input_crai_files
  Array[File] input_cram_files

  File topmed_variant_caller_output_file
  File topmed_variant_caller_output_path

  File ref_1000G_omni2_5_b38_sites_PASS_vcf_gz
  File ref_1000G_omni2_5_b38_sites_PASS_vcf_gz_tbi
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr10_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr11_KI270927v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr11_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr12_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr13_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_GL000009v2_random_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_KI270846v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr15_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr16_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270857v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270862v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270909v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr18_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr19_KI270938v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr19_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_KI270706v1_random_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_KI270766v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr20_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr21_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_KI270879v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_KI270928v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_KI270773v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_KI270894v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr3_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr4_GL000008v2_random_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr4_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr5_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr6_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr7_KI270803v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr7_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr8_KI270821v1_alt_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr8_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chr9_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chrUn_KI270742v1_vcf
  File ref_1kg_pilot_release_merged_indels_sites_hg38_chrX_vcf
  File ref_dbsnp_142_b38_vcf_gz
  File ref_dbsnp_142_b38_vcf_gz_tbi
  File ref_dbsnp_All_vcf_gz
  File ref_dbsnp_All_vcf_gz_tbi
  File ref_hapmap_3_3_b38_sites_vcf_gz
  File ref_hapmap_3_3_b38_sites_vcf_gz_tbi
  File ref_hs38DH_bs_umfa
  File ref_hs38DH_dict
  File ref_hs38DH_fa
  File ref_hs38DH_fa_alt
  File ref_hs38DH_fa_amb
  File ref_hs38DH_fa_ann
  File ref_hs38DH_fa_bwt
  File ref_hs38DH_fa_fai
  File ref_hs38DH_fa_pac
  File ref_hs38DH_fa_sa
  File ref_hs38DH_winsize100_gc


  call sumCRAMSizes {
    input:
      input_crams = input_cram_files,
      input_crais = input_crai_files

  }


  call variantDiscoveryAndConsolidation {
     input:
      input_crais = input_crai_files,
      input_crams = input_cram_files,
      disk_size = sumCRAMSizes.total_size,
      topmed_variant_caller_output_file = topmed_variant_caller_output_file,
      topmed_variant_caller_output_path = topmed_variant_caller_output_path,

      ref_1000G_omni2_5_b38_sites_PASS_vcf_gz = ref_1000G_omni2_5_b38_sites_PASS_vcf_gz,
      ref_1000G_omni2_5_b38_sites_PASS_vcf_gz_tbi = ref_1000G_omni2_5_b38_sites_PASS_vcf_gz_tbi,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr10_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr10_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr11_KI270927v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr11_KI270927v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr11_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr11_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr12_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr12_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr13_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr13_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_GL000009v2_random_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_GL000009v2_random_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_KI270846v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_KI270846v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr15_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr15_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr16_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr16_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270857v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270857v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270862v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270862v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270909v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270909v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr18_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr18_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr19_KI270938v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr19_KI270938v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr19_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr19_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_KI270706v1_random_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_KI270706v1_random_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_KI270766v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_KI270766v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr20_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr20_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr21_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr21_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_KI270879v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_KI270879v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_KI270928v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_KI270928v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_KI270773v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_KI270773v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_KI270894v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_KI270894v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr3_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr3_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr4_GL000008v2_random_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr4_GL000008v2_random_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr4_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr4_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr5_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr5_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr6_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr6_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr7_KI270803v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr7_KI270803v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr7_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr7_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr8_KI270821v1_alt_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr8_KI270821v1_alt_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr8_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr8_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chr9_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chr9_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chrUn_KI270742v1_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chrUn_KI270742v1_vcf,
      ref_1kg_pilot_release_merged_indels_sites_hg38_chrX_vcf = ref_1kg_pilot_release_merged_indels_sites_hg38_chrX_vcf,
      ref_dbsnp_142_b38_vcf_gz = ref_dbsnp_142_b38_vcf_gz,
      ref_dbsnp_142_b38_vcf_gz_tbi = ref_dbsnp_142_b38_vcf_gz_tbi,
      ref_dbsnp_All_vcf_gz = ref_dbsnp_All_vcf_gz,
      ref_dbsnp_All_vcf_gz_tbi = ref_dbsnp_All_vcf_gz_tbi,
      ref_hapmap_3_3_b38_sites_vcf_gz = ref_hapmap_3_3_b38_sites_vcf_gz,
      ref_hapmap_3_3_b38_sites_vcf_gz_tbi = ref_hapmap_3_3_b38_sites_vcf_gz_tbi,
      ref_hs38DH_bs_umfa = ref_hs38DH_bs_umfa,
      ref_hs38DH_dict = ref_hs38DH_dict,
      ref_hs38DH_fa = ref_hs38DH_fa,
      ref_hs38DH_fa_alt = ref_hs38DH_fa_alt,
      ref_hs38DH_fa_amb = ref_hs38DH_fa_amb,
      ref_hs38DH_fa_ann = ref_hs38DH_fa_ann,
      ref_hs38DH_fa_bwt = ref_hs38DH_fa_bwt,
      ref_hs38DH_fa_fai = ref_hs38DH_fa_fai,
      ref_hs38DH_fa_pac = ref_hs38DH_fa_pac,
      ref_hs38DH_fa_sa = ref_hs38DH_fa_sa,
      ref_hs38DH_winsize100_gc = ref_hs38DH_winsize100_gc

  }
  output {
      File topmed_variant_caller_output = topmed_variant_caller_output_file
  }
}


  task sumCRAMSizes {
    Array[File] input_crams
    Array[File] input_crais

    command {
      python <<CODE
      import os
      import functools

      cram_string = "${ sep=',' input_crams }"
      cram_list = cram_string.split(',')
      crams_size = functools.reduce((lambda x, y: os.stat(x).st_size + os.stat(y).st_size), cram_list)

      crai_string = "${ sep=',' input_crais }"
      crai_list = crai_string.split(',')
      crais_size = functools.reduce((lambda x, y: os.stat(x).st_size + os.stat(y).st_size), crai_list)

      print crams_size + crais_size
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

  

  task variantDiscoveryAndConsolidation {
     # The CRAM index files are listed as an input because they are required
     # by various tools, e.g. Samtools. They should be in the same location
     # as the CRAM files when specified in the input JSON
     Array[File] input_crais
     Array[File] input_crams

     String disk_size
     File topmed_variant_caller_output_file
     File topmed_variant_caller_output_path

     File ref_1000G_omni2_5_b38_sites_PASS_vcf_gz
     File ref_1000G_omni2_5_b38_sites_PASS_vcf_gz_tbi
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr10_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr11_KI270927v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr11_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr12_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr13_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_GL000009v2_random_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_KI270846v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr15_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr16_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270857v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270862v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270909v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr18_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr19_KI270938v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr19_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_KI270706v1_random_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_KI270766v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr20_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr21_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_KI270879v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_KI270928v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_KI270773v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_KI270894v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr3_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr4_GL000008v2_random_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr4_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr5_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr6_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr7_KI270803v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr7_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr8_KI270821v1_alt_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr8_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chr9_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chrUn_KI270742v1_vcf
     File ref_1kg_pilot_release_merged_indels_sites_hg38_chrX_vcf
     File ref_dbsnp_142_b38_vcf_gz
     File ref_dbsnp_142_b38_vcf_gz_tbi
     File ref_dbsnp_All_vcf_gz
     File ref_dbsnp_All_vcf_gz_tbi
     File ref_hapmap_3_3_b38_sites_vcf_gz
     File ref_hapmap_3_3_b38_sites_vcf_gz_tbi
     File ref_hs38DH_bs_umfa
     File ref_hs38DH_dict
     File ref_hs38DH_fa
     File ref_hs38DH_fa_alt
     File ref_hs38DH_fa_amb
     File ref_hs38DH_fa_ann
     File ref_hs38DH_fa_bwt
     File ref_hs38DH_fa_fai
     File ref_hs38DH_fa_pac
     File ref_hs38DH_fa_sa
     File ref_hs38DH_winsize100_gc


     command {
      python <<CODE

      from __future__ import print_function
      import csv
      import os
      from shutil import copyfile     

      if not os.path.exists('/root/topmed_freeze3_calling/data/'):
          os.makedirs('/root/topmed_freeze3_calling/data/')

      # Create the index file that lists the CRAM files and their location
      # We do not need to do this for the CRAM index files becuase the 
      # tools assume they are located in the same place as the CRAM files
      cram_string = "${ sep=',' input_crams }"
      crams_list = cram_string.split(',')

      tsv_crams_rows = []
      for cram_file in crams_list:
          # Get the Cromwell location of the CRAM file
          # The worklow will be able to access them 
          # since the Cromwell path is mounted in the
          # docker run commmand that Cromwell sets up
          base_name = os.path.basename(cram_file)
          base_name_wo_extension = base_name.split('.')[0]
          tsv_crams_rows.append([base_name_wo_extension, cram_file, '0.000'])

      # Remove the old PED file; we will not use a PED file?
      open('/root/topmed_freeze3_calling/data/TopMed_open_access_files.ped', 'w+').close()

      with open('/root/topmed_freeze3_calling/data/TopMed_open_access_files.index', 'w+') as tsv_index_file:
          writer = csv.writer(tsv_index_file, delimiter = '\t')
          for cram_info in tsv_crams_rows:
              writer.writerow(cram_info)

      CODE


      set -o pipefail
      set -e

      cd /root/topmed_freeze3_calling
      mkdir -p /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38

      # Create a symlink from the where the workflow expects the reference files
      # to the Cromwell location of the reference files 
      ln -s ${ref_1000G_omni2_5_b38_sites_PASS_vcf_gz}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1000G_omni2.5.b38.sites.PASS.vcf.gz
      ln -s ${ref_1000G_omni2_5_b38_sites_PASS_vcf_gz_tbi}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1000G_omni2.5.b38.sites.PASS.vcf.gz.tbi
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr10_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr10.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr11_KI270927v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr11_KI270927v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr11_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr11.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr12_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr12.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr13_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr13.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_GL000009v2_random_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr14_GL000009v2_random.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_KI270846v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr14_KI270846v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr14_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr14.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr15_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr15.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr16_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr16.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270857v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr17_KI270857v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270862v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr17_KI270862v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_KI270909v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr17_KI270909v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr17_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr17.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr18_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr18.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr19_KI270938v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr19_KI270938v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr19_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr19.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_KI270706v1_random_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr1_KI270706v1_random.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_KI270766v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr1_KI270766v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr1_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr1.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr20_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr20.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr21_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr21.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_KI270879v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr22_KI270879v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_KI270928v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr22_KI270928v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr22_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr22.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_KI270773v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr2_KI270773v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_KI270894v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr2_KI270894v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr2_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr2.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr3_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr3.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr4_GL000008v2_random_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr4_GL000008v2_random.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr4_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr4.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr5_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr5.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr6_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr6.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr7_KI270803v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr7_KI270803v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr7_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr7.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr8_KI270821v1_alt_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr8_KI270821v1_alt.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr8_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr8.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chr9_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chr9.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chrUn_KI270742v1_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chrUn_KI270742v1.vcf
      ln -s ${ref_1kg_pilot_release_merged_indels_sites_hg38_chrX_vcf}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/1kg.pilot_release.merged.indels.sites.hg38.chrX.vcf
      ln -s ${ref_dbsnp_142_b38_vcf_gz}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/dbsnp_142.b38.vcf.gz
      ln -s ${ref_dbsnp_142_b38_vcf_gz_tbi}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/dbsnp_142.b38.vcf.gz.tbi
      ln -s ${ref_dbsnp_All_vcf_gz}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/dbsnp.All.vcf.gz
      ln -s ${ref_dbsnp_All_vcf_gz_tbi}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/dbsnp.All.vcf.gz.tbi
      ln -s ${ref_hapmap_3_3_b38_sites_vcf_gz}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hapmap_3.3.b38.sites.vcf.gz
      ln -s ${ref_hapmap_3_3_b38_sites_vcf_gz_tbi}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hapmap_3.3.b38.sites.vcf.gz.tbi
      ln -s ${ref_hs38DH_bs_umfa}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH-bs.umfa
      ln -s ${ref_hs38DH_dict}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH.dict
      ln -s ${ref_hs38DH_fa}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH.fa
      ln -s ${ref_hs38DH_fa_alt}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH.fa.alt
      ln -s ${ref_hs38DH_fa_amb}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH.fa.amb
      ln -s ${ref_hs38DH_fa_ann}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH.fa.ann
      ln -s ${ref_hs38DH_fa_bwt}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH.fa.bwt
      ln -s ${ref_hs38DH_fa_fai}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH.fa.fai
      ln -s ${ref_hs38DH_fa_pac}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH.fa.pac
      ln -s ${ref_hs38DH_fa_sa}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH.fa.sa
      ln -s ${ref_hs38DH_winsize100_gc}  /root/topmed_freeze3_calling/data/local.org/ref/gotcloud.ref/hg38/hs38DH.winsize100.gc

      WORKING_DIR='out'
      echo "Running step1 - detect and merge variants"
      echo "Running step1 - detect and merge variants - removing old output dir if it exists"
      if [ -d "$WORKING_DIR" ]; then rm -Rf "$WORKING_DIR"; fi
      echo "Running step1 - detect and merge variants - generating Makefile"
      perl scripts/step1-detect-and-merge-variants.pl $(seq 1 22 | xargs -n 1 -I% echo chr%) chrX
      echo "Running step1 - detect and merge variants - running Makefile"
      make SHELL='/bin/bash' -f 'out/aux/Makefile' -j 23
      

      echo "Running step2 - joing genotyping"
      echo "Running step2 - joing genotyping - removing old output dir if it exists"
      if [ -d "$WORKING_DIR"/paste ]; then rm -Rf "$WORKING_DIR"/paste; fi
      echo "Running step2 - joing genotyping - generating Makefile"
      perl scripts/step2-joint-genotyping.pl $(seq 1 22 | xargs -n 1 -I% echo chr%) chrX
      echo "Running step2 - joing genotyping - running Makefile"
      MAKEFILE_NAME="chrchr"$(seq -s '_chr' 1 22)_chrX".Makefile"
      make SHELL='/bin/bash' -f "$WORKING_DIR"/paste/"$MAKEFILE_NAME" -j 23

      #tar up the output directories into the output file provided in the input JSON
      tar -zcvf ${topmed_variant_caller_output_file} "$WORKING_DIR"/paste/ "$WORKING_DIR"/aux/individual/

      #tar -zcvf /root/topmed_freeze3_calling/test_output.tar.gz "$WORKING_DIR"/paste/ "$WORKING_DIR"/aux/individual/
      #cp /root/topmed_freeze3_calling/test_output.tar.gz ${topmed_variant_caller_output_path}
    }
     output {
      String variantDiscoveryAndConsolidationOutput = read_string(stdout())
    }
   runtime {
      memory: "10 GB"
      cpu: "16"
      disks: "local-disk " + sub(disk_size, "\\..*", "") + " HDD"
      zones: "us-central1-a us-central1-b us-east1-d us-central1-c us-central1-f us-east1-c"
      docker: "quay.io/wshands/topmed_freeze3_calling:latest"
    }
  }

