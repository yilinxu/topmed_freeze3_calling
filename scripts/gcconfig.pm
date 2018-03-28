package gcconfig;

use base qw/Exporter/;
use Cwd qw(realpath);
use File::Basename qw(dirname);
use POSIX qw(pow sqrt);
use FindBin;

## Variables and methods shared across the package
our @EXPORT = qw($ref $md5 $bgzip $samtools $bcftools $bamUtil $tabix $index $pedf $out $vt $discoverUnit $genotypeUnit $omnivcf $hapmapvcf $dbsnp $invNorm $svmlearn $svmclassify $vcfsummary $vcfsummary2);

############################################################
### MODIFY THESE VARIABLES TO YOUR COMPUTING ENVIRONMENT
#our $index = "data/trio_data.index";
#our $pedf = "data/trio_data.ped";

our $index = "data/TopMed_open_access_files.index";
our $pedf = "data/TopMed_open_access_files.ped";

our $out = "out";
our $discoverUnit = 20000000;
our $genotypeUnit = 1000000;
############################################################
### MODIFY THESE VARIABLES TO IF REFERENCE IS LOCATED ELSEWHERE
our $refDir = "$FindBin::Bin/../data/local/ref/gotcloud.ref/hg38";
our $md5 = "$refDir/md5/%2s/%2s/%s";
our $ref = "$refDir/hs38DH.fa";
our $dbsnp = "$refDir/dbsnp_142.b38.vcf.gz";
our $hapmapvcf = "$refDir/hapmap_3.3.b38.sites.vcf.gz";
our $omnivcf = "$refDir/1000G_omni2.5.b38.sites.PASS.vcf.gz";
############################################################
### MODIFY THESE VARIABLES TO IF EXTERNAL BINARIES ARE USED
our $bgzip = "$FindBin::Bin/../htslib/bgzip";
our $tabix = "$FindBin::Bin/../htslib/tabix";
our $vt = "$FindBin::Bin/../vt/vt";
our $samtools = "$FindBin::Bin/../samtools/samtools";
our $bcftools = "$FindBin::Bin/../bcftools/bcftools";
our $bamUtil = "$FindBin::Bin/../gotcloud/src/bin/bamUtil";
our $svmlearn = "$FindBin::Bin/../gotcloud/src/bin/svm-train";
our $svmclassify = "$FindBin::Bin/../gotcloud/src/bin/svm-predict";
our $invNorm = "$FindBin::Bin/../gotcloud/src/bin/invNorm";
our $vcfsummary = "$FindBin::Bin/vcf-summary";
our $vcfsummary2 = "$FindBin::Bin/vcf-summary-v2";

1;
