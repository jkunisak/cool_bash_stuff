# .bashrc

# GENERAL FUNCTIONS

# Fix output of uniq -c so its useable
uc () {
	uniq -c $1 | sed "s/^ *//" | tr " " "\t"
}

# USEFUL FUNCTIONS FOR TSV FILES

# Show colnames and indices for a tsv (good for creating awk commands with big tsvs)
colnames () {
	bioawk -t 'NR==1{for(i=1; i<=NF; i++){print i, $i} exit}' $1
}

# Print out the number of columns in a tsv
ncols () {
	bioawk -t '{print NF; exit}' $1
}
