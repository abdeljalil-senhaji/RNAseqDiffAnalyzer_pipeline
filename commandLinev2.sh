godjob create -n pipeline_meta -t snakemake,pipeline_meta --external_image -v home -v scratch -v annotations -c 1 -r 1 \
-i sequoia-docker-tools/snakemake:6.9.0  --cmd "snakemake \
  -s /scratch/recherche/asenhaji/v1_pipe_delete_hg38/snakefile \
  --keep-going \
  --configfile /scratch/recherche/asenhaji/v1_pipe_delete_hg38/config.json \
  --cluster-config /scratch/recherche/asenhaji/v1_pipe_delete_hg38/cluster.json \
  --cluster 'godjob create -n {cluster.name} -t {cluster.tags} --external_image -v {cluster.volume_snakemake} -v {cluster.volume_home} -v {cluster.volume_scratch} -v {cluster.volume_annotations} -c {cluster.cpu} -r {cluster.mem} -i {cluster.image} -s' \
  -j 50 -w 30 \
  --stats /scratch/recherche/asenhaji/v1_pipe_delete_hg38/stats.txt \    
  2>&1 | tee /scratch/recherche/asenhaji/v1_pipe_delete_hg38/output/pipeline_advance.log"


  #--report /scratch/recherche/asenhaji/v1_pipe_delete_hg38/output/report.html \
  #--benchmark-report benchmark.csv \    
  #--timeline timeline.json \   
  #--detailed-summary --json summary.json \
  #--rulegraph > /scratch/recherche/asenhaji/v1_pipe_delete_hg38/rulegraph.dot && dot -Tsvg -o /scratch/recherche/asenhaji/v1_pipe_delete_hg38/graph_rule.svg \