# .bashrc

# GENERAL FUNCTIONS

# Fix output of uniq -c so its useable (assumes TSV)
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

# Add prefix to header line of TSV (useful when merging files)
hprefix () {
    bioawk -t -v prefix=$1 'NR==1{for(i=1; i<=NF; i++){$i=prefix"_"$i} print; exit}' $2
}

# Convert 1-based table to 0-based bed file and add comment char to header line for compatability with things like tabix
tobed () {
	bioawk -t -v n=1 'NR==1{ $1 = "#"$1; $2 = "Start" FS "End"; print }; NR!=1 { $2 = $2-n FS $2; print }' $1
}

# Same as above and coord sort the bed file
tobed-sort () {
	bioawk -t -v n=1 'NR==1{ $1 = "#"$1; $2 = "Start" FS "End"; print }; NR!=1 { $2 = $2-n FS $2; print | "sort -k1,1 -k2,2n" }' $1
}
