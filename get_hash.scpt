do shell script "
# Change the folder name accordingly, these looks to a folder named Eds_Software on users desktop
cd ~/Desktop/Ed_Software;

echo 'Filename,SHA256,SHA512,DeveloperID' > hash_values.csv;

for file in *;
do
  if [ -f \"$file\" ]; then
    sha256=$(shasum -a 256 \"$file\" | awk '{print $1}');
    sha512=$(shasum -a 512 \"$file\" | awk '{print $1}');
    
    codesign_output=$(codesign -dv --verbose=4 \"$file\" 2>&1);
    developer_id=$(echo \"$codesign_output\" | grep 'Authority=Developer ID Application:' | awk -F': ' '{print $2}');
    
    if [ -z \"$developer_id\" ]; then
      developer_id='N/A';
    fi;
    
    echo \"$file,$sha256,$sha512,$developer_id\" >> hash_values.csv;
  fi;
done;
"
