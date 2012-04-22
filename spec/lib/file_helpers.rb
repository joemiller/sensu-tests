# returns the owner of a File
def file_owner(file)
  uid = File.stat(file).uid
  Etc.getpwuid(uid).name
end

# returns the owner of a File
def file_group(file)
  gid = File.stat(file).gid
  Etc.getgrgid(gid).name
end

